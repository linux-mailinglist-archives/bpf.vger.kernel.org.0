Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BD8853261E
	for <lists+bpf@lfdr.de>; Tue, 24 May 2022 11:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234884AbiEXJGe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 24 May 2022 05:06:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235531AbiEXJGb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 24 May 2022 05:06:31 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AAF831DC7
        for <bpf@vger.kernel.org>; Tue, 24 May 2022 02:06:30 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id t6so24752216wra.4
        for <bpf@vger.kernel.org>; Tue, 24 May 2022 02:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=xh7cYU8Wq2KxTr228j/cNTFLA81xx3ODWjDCwRg52qk=;
        b=s68ncFXLx3XCZ/al4U2j5S0eh/tBIZcfCFNCk2j0qnnFPYCA8BNMUh1NQiiH54T1wL
         kEmd9PvwPP14lWaw5EoqGF3GlwZMzLB6BwXcpYtaO6I0dg6zgtYWa70A8R9sTF0mNkdm
         ZeIY9881xr1kBKTew3A37c5JpD83ZjGs1EltVU7cXnzHlOb1N0lYKVIJcsLyR2ejpIp4
         7ssiHpGhBBv/dO5jc109fd7/FFYtXK/fi6iXl3tOj0/K5kW9YxKUOktRBu0Nfl9m8R9S
         pjhgTJLtFweX2rvsK6opkEdrIXP801V+QzQ1bX5QXUsgggWGpI8i+HThXfb3OBa/5nyf
         CZvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=xh7cYU8Wq2KxTr228j/cNTFLA81xx3ODWjDCwRg52qk=;
        b=fRwWjZz5Cy+QHmCjE+PWtMNf9bboYcnwWL718B0KVa3BSdscEiKFL6psy1ChvhM98y
         v1tOm4/ZaOAX5LXzyvglsmwjiPg03roeLSuTf6kvgceeWL8KHC3kDMcY/Hw/F1p4KN6J
         bD1vTbpv8UPxq0YKmWgOkGoCG1R/Ja8RfMS8ChHXfr7ttI+fce8Pf8bHR8wuMJHqzG6c
         JBPaBG7Xuzz+zavgPYf4ohXxECbcXG/HszxJ+XZNhsGnhGAONgJekK5AyhoQ1I5CDJSq
         CGa69XWa+6TKURKpZ8srScqgWhR9hdrKkd66ck2LqkaOddY99zFJCMtRWCsCUUrtgtVX
         9diw==
X-Gm-Message-State: AOAM532xWeqYWTqwyid5oA19/sHZhyRleQcrEjMbLnr71hWXT7AVDV7W
        JCKrfD7kNAkO8WuRA+w+ELR1Sw==
X-Google-Smtp-Source: ABdhPJy42p7BjFVgu3GhZfbou6XS5HRM8dP2UUTyeLLS/H2Skul1FpUTGESdum1vFEh/obT9xuXCrA==
X-Received: by 2002:adf:8bc2:0:b0:20e:7a89:277 with SMTP id w2-20020adf8bc2000000b0020e7a890277mr17106769wra.58.1653383188821;
        Tue, 24 May 2022 02:06:28 -0700 (PDT)
Received: from [192.168.178.21] ([51.155.200.13])
        by smtp.gmail.com with ESMTPSA id l15-20020adfbd8f000000b0020e65d7d36asm12590250wrh.11.2022.05.24.02.06.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 May 2022 02:06:28 -0700 (PDT)
Message-ID: <3d5afb9c-4603-5678-610e-13f025827a60@isovalent.com>
Date:   Tue, 24 May 2022 10:06:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH bpf-next v4 09/12] bpftool: Use libbpf_bpf_attach_type_str
Content-Language: en-GB
To:     =?UTF-8?Q?Daniel_M=c3=bcller?= <deso@posteo.net>,
        bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com
Cc:     yhs@fb.com
References: <20220523230428.3077108-1-deso@posteo.net>
 <20220523230428.3077108-10-deso@posteo.net>
From:   Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <20220523230428.3077108-10-deso@posteo.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

2022-05-23 23:04 UTC+0000 ~ Daniel Müller <deso@posteo.net>
> This change switches bpftool over to using the recently introduced
> libbpf_bpf_attach_type_str function instead of maintaining its own
> string representation for the bpf_attach_type enum.
> 
> Note that contrary to other enum types, the variant names that bpftool
> maps bpf_attach_type to do not adhere a simple to follow rule. With
> bpf_prog_type, for example, the textual representation can easily be
> inferred by stripping the BPF_PROG_TYPE_ prefix and lowercasing the
> remaining string. bpf_attach_type violates this rule for various
> variants.
> We decided to fix up this deficiency with this change, meaning that
> bpftool uses the same textual representations as libbpf. Supporting
> tests, completion scripts, and man pages have been adjusted accordingly.
> However, we did add support for accepting (the now undocumented)
> original attach type names when they are provided by users.
> 
> For the test (test_bpftool_synctypes.py), I have removed the enum
> representation checks, because we no longer mirror the various enum
> variant names in bpftool source code. For the man page, help text, and
> completion script checks we are now using enum definitions from
> uapi/linux/bpf.h as the source of truth directly.
> 
> Signed-off-by: Daniel Müller <deso@posteo.net>

Looks all good to me this time, thanks again! And thank you for
splitting the changes on the test script, it's also easier to follow.

Acked-by: Quentin Monnet <quentin@isovalent.com>

> diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
> index 39e1e71..6e08a30 100644
> --- a/tools/bpf/bpftool/prog.c
> +++ b/tools/bpf/bpftool/prog.c
> @@ -41,12 +41,24 @@ enum dump_mode {
>  	DUMP_XLATED,
>  };
>  
> +static const bool attach_types[] = {
> +	[BPF_SK_SKB_STREAM_PARSER] = true,
> +	[BPF_SK_SKB_STREAM_VERDICT] = true,
> +	[BPF_SK_SKB_VERDICT] = true,
> +	[BPF_SK_MSG_VERDICT] = true,
> +	[BPF_FLOW_DISSECTOR] = true,
> +	[__MAX_BPF_ATTACH_TYPE] = false,
> +};
> +
> +/*
> + * Textual representations traditionally used by the program and kept around for
> + * the sake of backwards compatibility.
> + */

Nit: Opening marker for comments should be on the same line as the text,
but this is not worth a respin.
