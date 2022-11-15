Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C020562A17B
	for <lists+bpf@lfdr.de>; Tue, 15 Nov 2022 19:42:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbiKOSmc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Nov 2022 13:42:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230472AbiKOSmb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Nov 2022 13:42:31 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C8202FFC3
        for <bpf@vger.kernel.org>; Tue, 15 Nov 2022 10:42:30 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id g13-20020a056a000b8d00b0056e28b15757so8148511pfj.1
        for <bpf@vger.kernel.org>; Tue, 15 Nov 2022 10:42:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=upp3xuPUqFgBifk0MziDCU3KXshXPKZfotY7q9TX0Ao=;
        b=M+ayA7Evg1qqUP/5ClI2/pfzlCK3DjfiRWi2h90dAUKX8Veki4vekOpdIwkCpGxXhu
         dKVSdhGQvRSWWv8rLRJwCQjKMJ2ls+ZfmcZ8wei45ApLn/8ZCMGsO4/Hzz442vsJVn0G
         UovgDytAoB1fdNRXs5ftW1ux5GEqRK3OHkXpu9QgQLAlIj/8J66z4nIcwDU0xKZq6Ppy
         egJqhhTZiAHgQQTnQTOy4BYjW/eb1VOWFQqJyeQVJ9vu8nQeaLr0a7p4v4IxwlWJC9S9
         wwOmXubSdnQcG5nBCkxinjtfIiGz3PwlWcbXv87zwZpsbX75hOu6nq8BV5ndki89uT79
         dgwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=upp3xuPUqFgBifk0MziDCU3KXshXPKZfotY7q9TX0Ao=;
        b=MCu2b0IJmeT7795vxzjU+1796p7+OdfijKqAUuToghh3WyXMKzoeBmb3k7OMpSbMgL
         nSnI6IQxGo2u1EqiVNJrwVhsohtZ7K9cyzBL8DKTAiBCBNs7hC+3jLx8ka0tKo5RweFZ
         tbblc6seze0j7shXkNvpP7IQ0CGAHFM78ASV3gcjOYReKUV2/nU5N/EIVjJwGC7kSUtg
         7sa7MUZwfcfI+zAO7rrQ3Toed1BNHyaaLIyxKyZHftn0lserNhbU6c1L+zVijBxeXlvc
         ce1ISvd17qrlqYvAZlkgfRq4ySvKDYOENRPTCcEo8Ro+uO17addJo2P9isldeu3sNBJp
         G72g==
X-Gm-Message-State: ANoB5pmcVwp7iyxWvHSIRErdTX3ZIUyMjbkxW+5Lj8w3+6e/aAIerXoj
        ltdfQNc097W+myPu0bZbZ4H1+4Y=
X-Google-Smtp-Source: AA0mqf5Wo9rUwTp6N6LxIHlVY1a27mW8hhU5yEv6CA5FN6k6Iht03uVoYvjKxEjbi9jVPK29ozBn0dI=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:903:2403:b0:186:9fb9:1f8c with SMTP id
 e3-20020a170903240300b001869fb91f8cmr5214872plo.69.1668537750032; Tue, 15 Nov
 2022 10:42:30 -0800 (PST)
Date:   Tue, 15 Nov 2022 10:42:28 -0800
In-Reply-To: <1668517207-11822-1-git-send-email-yangtiezhu@loongson.cn>
Mime-Version: 1.0
References: <1668517207-11822-1-git-send-email-yangtiezhu@loongson.cn>
Message-ID: <Y3PdlPVxobFMVYoX@google.com>
Subject: Re: [PATCH bpf-next v2] bpftool: Check argc first before "file" in do_batch()
From:   sdf@google.com
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Quentin Monnet <quentin@isovalent.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 11/15, Tiezhu Yang wrote:
> If the parameters for batch are more than 2, check argc first can
> return immediately, no need to use is_prefix() to check "file" with
> a little overhead and then check argc, it is better to check "file"
> only when the parameters for batch are 2.

> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>

Acked-by: Stanislav Fomichev <sdf@google.com>

> ---
>   tools/bpf/bpftool/main.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)

> diff --git a/tools/bpf/bpftool/main.c b/tools/bpf/bpftool/main.c
> index 741e50e..337ab79 100644
> --- a/tools/bpf/bpftool/main.c
> +++ b/tools/bpf/bpftool/main.c
> @@ -337,12 +337,12 @@ static int do_batch(int argc, char **argv)
>   	if (argc < 2) {
>   		p_err("too few parameters for batch");
>   		return -1;
> -	} else if (!is_prefix(*argv, "file")) {
> -		p_err("expected 'file', got: %s", *argv);
> -		return -1;
>   	} else if (argc > 2) {
>   		p_err("too many parameters for batch");
>   		return -1;
> +	} else if (!is_prefix(*argv, "file")) {
> +		p_err("expected 'file', got: %s", *argv);
> +		return -1;
>   	}
>   	NEXT_ARG();

> --
> 2.1.0

