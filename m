Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7108B628717
	for <lists+bpf@lfdr.de>; Mon, 14 Nov 2022 18:30:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236681AbiKNRaX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 14 Nov 2022 12:30:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236791AbiKNRaW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 14 Nov 2022 12:30:22 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C00F125EA8
        for <bpf@vger.kernel.org>; Mon, 14 Nov 2022 09:30:19 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id i71-20020a63874a000000b00476a4a5452eso459837pge.22
        for <bpf@vger.kernel.org>; Mon, 14 Nov 2022 09:30:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=d1dQp5WpI3a43ApVkLCwRzvLrzQKIAyYpZgXgD0Dw7Q=;
        b=EsBwEhpKorOzI+O/kMJ7e1ExFw2k7wXLa1cTMY0h2cFGy9eSyYckKZBEzMq/5z5cZ1
         G9fHMgDPM+St0HiMUOAZaefO07g8e6411zpnoFMkgpAjQJgupPbE7SGCDbfye9K7c+jP
         NeqWOIml0melOuwdBK/7cLBTPho5FpGyKxA+8dWHxLpFTL08NB8bWNFrTR7I8K8jzwH8
         3Q5EYeffUQHlFJNyl4b8LH4lGOZy6HwuxVDSJttl6CK7Ackx9xOJ6+zFZf1gkA2vngcj
         VAawUjbAtYA0J2Fgbjcz66EC/GHiIeAfvnC9NjJjRb4MrsQpZvTZOZY8StlsANSOkZeM
         mgKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d1dQp5WpI3a43ApVkLCwRzvLrzQKIAyYpZgXgD0Dw7Q=;
        b=vcd44qB4rvwWW4oqXxd9qBJz8k8VxAU7gbl8YXiZE82U3iIiPHN0Q0gVL63KE1aCgY
         Wn+cN85TvemC7VIp/scWuzcxwv7wVyeAhRX5d+CYFH6dWLgOCCD2GgT8m51E8iqO2igI
         k15RiTmUnmeWSXRoR6F2TBnkSarbljrT0GupqFtlrH2kTGw7FpCZ4Po2kGqDd4qjwI/L
         OO/G65d843waJDoRpf19Xc5a7sAHp4lysgSxKSCIZxpaFFdgiMY1kPgTwNedoeWlutn0
         nM6j0+fIUQHq1Ce4MUjJrDD7Z2OQnH3TQd63PhNVTOW6rITCL8bkLaZS1nSuh80BQbo4
         AFig==
X-Gm-Message-State: ANoB5pkUzsY+VYe84mkcaPUG9iRO2VISl5FBrJj9U7bCAdQXCo69JxIN
        2DHN3BfeJZNpOztw0T0UjZq0+TA=
X-Google-Smtp-Source: AA0mqf6kcXlwL6kSjatGPQziRYISFTgJut4/wY+lwR5YYWdiVqbud6lS/hlF2znlXiuvjK7Qvs3E7+8=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:aa7:96a2:0:b0:56b:f62c:4dc0 with SMTP id
 g2-20020aa796a2000000b0056bf62c4dc0mr14522852pfk.79.1668447019263; Mon, 14
 Nov 2022 09:30:19 -0800 (PST)
Date:   Mon, 14 Nov 2022 09:30:17 -0800
In-Reply-To: <1668396484-4596-3-git-send-email-yangtiezhu@loongson.cn>
Mime-Version: 1.0
References: <1668396484-4596-1-git-send-email-yangtiezhu@loongson.cn> <1668396484-4596-3-git-send-email-yangtiezhu@loongson.cn>
Message-ID: <Y3J7KW1xQc7aO18/@google.com>
Subject: Re: [PATCH bpf-next 2/2] bpftool: Check argc first before "file" in do_batch()
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

On 11/14, Tiezhu Yang wrote:
> If the parameters for batch are more than 2, check argc first can
> return immediately, no need to use strcmp() to check "file" with
> a little overhead and then check argc, it is better to check "file"
> only when the parameters for batch are 2.

Seems fine if you respin with is_prefix instead of strcmp.
Has the potential of breaking some buggy users which pass
more than one file, but I don't think it's a good justification
no to do the fix? Quentin?


> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>   tools/bpf/bpftool/main.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)

> diff --git a/tools/bpf/bpftool/main.c b/tools/bpf/bpftool/main.c
> index 4ef87c2..27d6dbf 100644
> --- a/tools/bpf/bpftool/main.c
> +++ b/tools/bpf/bpftool/main.c
> @@ -337,12 +337,12 @@ static int do_batch(int argc, char **argv)
>   	if (argc < 2) {
>   		p_err("too few parameters for batch");
>   		return -1;
> -	} else if (strcmp(*argv, "file")) {
> -		p_err("expected 'file', got: %s", *argv);
> -		return -1;
>   	} else if (argc > 2) {
>   		p_err("too many parameters for batch");
>   		return -1;
> +	} else if (strcmp(*argv, "file")) {
> +		p_err("expected 'file', got: %s", *argv);
> +		return -1;
>   	}
>   	NEXT_ARG();

> --
> 2.1.0

