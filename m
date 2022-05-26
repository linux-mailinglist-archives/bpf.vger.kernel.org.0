Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD59053517D
	for <lists+bpf@lfdr.de>; Thu, 26 May 2022 17:33:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243319AbiEZPdg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 26 May 2022 11:33:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347980AbiEZPde (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 26 May 2022 11:33:34 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F399DE312;
        Thu, 26 May 2022 08:33:28 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id t26so2299970edt.0;
        Thu, 26 May 2022 08:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7ZpvpLnrsJF4rcP8IoPyzSYJthw69jzv/0DWyfv1ap4=;
        b=fBkV2uu9Npnu69dcSmKkFOlkS8TBncPnAKDHklZbAkCD+RrFZ5GN9GWrnJExLGd3tG
         tltL2cCODt/Z2iIZ5UfXGKygYsit2mqeqR0k3XowGmg5EXCAISQfGt5IGJMNqjOAVaZB
         Yojm2Vb3qzMXrl0mh2mfrbrGg1Fshr/41TWpObLYWspuRCq3iyINJlAJJEZxSgQYY6YO
         9Tvn7BO45FhbarXL3p3oamfhOR9CLjDPLjntF7W18CBxDvLDFPr1AIlpLtZfYjs4DmO+
         z58y5/yMjsXIUwNtP+W7UUtpTUnBV5pbngpt6CgiRjccV9tBoff4frV2JpBZs/iTYmce
         LdHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7ZpvpLnrsJF4rcP8IoPyzSYJthw69jzv/0DWyfv1ap4=;
        b=ODkpPblZPTJuZATbBbG3IbUU4jwpdGiY1NwxGO+m1R7KBC1dQxHIsADSlDNEwoZmSv
         KwAykIQeHotJeloRmvAYZ8vJWpxCUjMhdxLf3ps+DirCHDuLaInREyjw0e3DKw906P2R
         CCZ7PUraAjIiIZoV+a+BWvjYJiXeG6Azo5HCnA3mmNucbhpyUbgH7kHI6uubOomytn0d
         143IdAWBKukci06/M4rZRgh6WJZv7jdQQ/AkwhF4oC0ShlZgxkz9L2tuIqinn7DXerC4
         o4QXn+2WJE5IpVB1BlbaLP7uW9AZkrzJYkWCyD0ZONpr9icpISl5BM/I1qUO8FR520ly
         Wp+w==
X-Gm-Message-State: AOAM532KPVqBo/IfbBPLFDni4I1eRJStSVq7CnqKZybMNA9hFy/W3kYq
        cvwHVuObCD9T5433AEw+bsc=
X-Google-Smtp-Source: ABdhPJx56/6EKJWnJHStzTRdwDj07JhHuK/vXxBs/sztpDU6XbOnJwK60tzSKn/Fb7JWfrcd3npm3w==
X-Received: by 2002:aa7:c683:0:b0:42a:b2cc:b345 with SMTP id n3-20020aa7c683000000b0042ab2ccb345mr40071484edq.282.1653579206777;
        Thu, 26 May 2022 08:33:26 -0700 (PDT)
Received: from krava (net-93-147-243-239.cust.vodafonedsl.it. [93.147.243.239])
        by smtp.gmail.com with ESMTPSA id g10-20020a50d5ca000000b0042ad0358c8bsm935025edj.38.2022.05.26.08.33.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 08:33:26 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Thu, 26 May 2022 17:33:22 +0200
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>, bpf@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] bpf: Use safer kvmalloc_array() where possible
Message-ID: <Yo+dwv/OVFnPrvbs@krava>
References: <Yo9VRVMeHbALyjUH@kili>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yo9VRVMeHbALyjUH@kili>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, May 26, 2022 at 01:24:05PM +0300, Dan Carpenter wrote:
> The kvmalloc_array() function is safer because it has a check for
> integer overflows.  These sizes come from the user and I was not
> able to see any bounds checking so an integer overflow seems like a
> realistic concern.
> 
> Fixes: 0dcac2725406 ("bpf: Add multi kprobe link")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Eugene was addressing these:
  https://lore.kernel.org/bpf/399e634781822329e856103cddba975f58f0498c.1652982525.git.esyr@redhat.com/

I think using kvmalloc_array was one of the review comments

jirka


> ---
>  kernel/trace/bpf_trace.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 10b157a6d73e..7a13e6ac6327 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -2263,11 +2263,11 @@ static int copy_user_syms(struct user_syms *us, unsigned long __user *usyms, u32
>  	int err = -ENOMEM;
>  	unsigned int i;
>  
> -	syms = kvmalloc(cnt * sizeof(*syms), GFP_KERNEL);
> +	syms = kvmalloc_array(cnt, sizeof(*syms), GFP_KERNEL);
>  	if (!syms)
>  		goto error;
>  
> -	buf = kvmalloc(cnt * KSYM_NAME_LEN, GFP_KERNEL);
> +	buf = kvmalloc_array(cnt, KSYM_NAME_LEN, GFP_KERNEL);
>  	if (!buf)
>  		goto error;
>  
> @@ -2464,7 +2464,7 @@ int bpf_kprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
>  		return -EINVAL;
>  
>  	size = cnt * sizeof(*addrs);
> -	addrs = kvmalloc(size, GFP_KERNEL);
> +	addrs = kvmalloc_array(cnt, sizeof(*addrs), GFP_KERNEL);
>  	if (!addrs)
>  		return -ENOMEM;
>  
> @@ -2489,7 +2489,7 @@ int bpf_kprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
>  
>  	ucookies = u64_to_user_ptr(attr->link_create.kprobe_multi.cookies);
>  	if (ucookies) {
> -		cookies = kvmalloc(size, GFP_KERNEL);
> +		cookies = kvmalloc_array(cnt, sizeof(*addrs), GFP_KERNEL);
>  		if (!cookies) {
>  			err = -ENOMEM;
>  			goto error;
> -- 
> 2.35.1
> 
