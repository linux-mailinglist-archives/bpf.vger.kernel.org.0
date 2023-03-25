Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 187BF6C8A8B
	for <lists+bpf@lfdr.de>; Sat, 25 Mar 2023 04:01:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbjCYDBO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Mar 2023 23:01:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjCYDBM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Mar 2023 23:01:12 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D18F14200
        for <bpf@vger.kernel.org>; Fri, 24 Mar 2023 20:01:11 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 185-20020a250ac2000000b00b6d0cdc8e3bso3476753ybk.4
        for <bpf@vger.kernel.org>; Fri, 24 Mar 2023 20:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679713270;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OLmpe3DGgfzSC8J8gtuK4TJ0THoeBO2A0hFfwyc6SEg=;
        b=BjXiFBKydRY72rb+pfolWARgKfJ5jxxCMWnrNtoLploWASxvfduYqly0TVT0SVhU2V
         jo3Wy0HX6K2nhNeKZgC2Wc7r249Db9EOQKZY3yqKAaCEir+knG2MIzuI2Ig3mM56yzjC
         mY2yZpMZF9M7Xck3ko06Kej40rj5ubjnpEFofD7ou4B+zgBOBjvUKX35wMX+uemqDXnb
         NpPClEPwtonQH+RrhldXkMhsATiMIvPFRDvi6wf1+JwHzhsQVitEF1J4TPhTPAb2bdti
         YNjGwc3s49pzypADcFBYZNhCQMEeijfsRd92Tg6k2Vrf9HwoEa0zkNU51be8yGqVwRvH
         qEDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679713270;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OLmpe3DGgfzSC8J8gtuK4TJ0THoeBO2A0hFfwyc6SEg=;
        b=RecGfAqvBdXVDDH9ndtjeSHFoVEecGG1+oLuu3ABsVCnXaEVEUg18tbmA0E7riH++0
         lgq5LDhV1OvaxnWdzWRsvIYUF4/yIATKXavQQBm+nJEifkwmLVjBaF36deotIvM3bjsS
         qVL6m2jxhYgI398Hs9LIAsTrxR2XisGd3nGJhvhqQ5CZc4mcts2jbO5+dkV5fjEeMh0g
         vLg1lQFpAezssxvidY5sN4yi/oWFablHE6MIoA4qECgIYtoZkc5bTQDrLy5VmReyPM7p
         FIuJxor3Crjdvo7IZ25GfND8bJkqZ0gLul3SKdfSI3ZBO4qp07iSjYngB0wrM0OFploJ
         b1yA==
X-Gm-Message-State: AAQBX9cbt/X8CHyk1iNhxvdzn/DegMnrKbnJwL2870VQ7M/UK4vLVTzo
        gGU84qx43++aJ1vHqpRfVwsKrdg=
X-Google-Smtp-Source: AKy350aZKCdpmtRW7giLAcuGsqefHDVKD45VoyeLww6zePo0tgkchiac800vL91/O5dUNWZe2Ov2WBw=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a05:6902:100a:b0:b76:3e1:c42d with SMTP id
 w10-20020a056902100a00b00b7603e1c42dmr2712353ybt.13.1679713270804; Fri, 24
 Mar 2023 20:01:10 -0700 (PDT)
Date:   Fri, 24 Mar 2023 20:01:09 -0700
In-Reply-To: <20230324232745.3959567-2-andrii@kernel.org>
Mime-Version: 1.0
References: <20230324232745.3959567-1-andrii@kernel.org> <20230324232745.3959567-2-andrii@kernel.org>
Message-ID: <ZB5j9Zcx1F6kSx6v@google.com>
Subject: Re: [PATCH v2 bpf-next 1/3] libbpf: disassociate section handler on
 explicit bpf_program__set_type() call
From:   Stanislav Fomichev <sdf@google.com>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 03/24, Andrii Nakryiko wrote:
> If user explicitly overrides programs's type with
> bpf_program__set_type() API call, we need to disassociate whatever
> SEC_DEF handler libbpf determined initially based on program's SEC()
> definition, as it's not goind to be valid anymore and could lead to
> crashes and/or confusing failures.

> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>   tools/lib/bpf/libbpf.c | 1 +
>   1 file changed, 1 insertion(+)

> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index f6a071db5c6e..a34ebb6b8508 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -8465,6 +8465,7 @@ int bpf_program__set_type(struct bpf_program *prog,  
> enum bpf_prog_type type)
>   		return libbpf_err(-EBUSY);

>   	prog->type = type;
> +	prog->sec_def = NULL;
>   	return 0;
>   }

Surprisingly, but it breaks the following selftest:

serial_test_bpf_obj_id:PASS:get-fd-by-notexist-prog-id 0 nsec
serial_test_bpf_obj_id:PASS:get-fd-by-notexist-map-id 0 nsec
serial_test_bpf_obj_id:PASS:get-fd-by-notexist-link-id 0 nsec
serial_test_bpf_obj_id:FAIL:prog_attach prog #0, err -95
   #17      bpf_obj_id:FAIL

(saw in the bot, reproduced locally)

> --
> 2.34.1

