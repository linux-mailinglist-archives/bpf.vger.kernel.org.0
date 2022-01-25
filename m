Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4AC749BA25
	for <lists+bpf@lfdr.de>; Tue, 25 Jan 2022 18:22:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1454164AbiAYRTU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 Jan 2022 12:19:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1453946AbiAYRPh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 Jan 2022 12:15:37 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 983F9C061753
        for <bpf@vger.kernel.org>; Tue, 25 Jan 2022 09:14:53 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id f12-20020a056902038c00b006116df1190aso42458050ybs.20
        for <bpf@vger.kernel.org>; Tue, 25 Jan 2022 09:14:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=RanNWL6m6SDNGXcdCXC0nYewgVRzYkuqflNw1ZDbcaY=;
        b=tGBoAf6UUkNXCLH352WEO49FAEh9DU40x5cPr6e3czEJrrTwvIdAQfY0nns4M7XPOn
         rAwqwfiFfixziQLWvVVemLSEvmCrH9nEAHpEUk/4gzSBEp7tt18UUXt6Whf9UGeTDEsL
         W3lE7UgDmy7AZF4BHTHiHkig9Lnr16Yp3tk3ODeIOx+jGyRtjrDFR2/diTVhNPquQgLU
         c4nGxfCaRWu29JRNpu37BBTlXtspmsFZ3o07ZCm1GmSDfUg4Kc9ydUUK4YU4YaH+vf0K
         iuZseJPXrrUnOLHd4HsYIBU3/llBKuVJ83585AwzdVfM7EqDgmNaINVmjmxtJo++EsPp
         MvIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=RanNWL6m6SDNGXcdCXC0nYewgVRzYkuqflNw1ZDbcaY=;
        b=q6cjM2W/fqdVkUWDK9R/9hWgJ2+fcIG3GCxB9zIhT9DdeNJcWWPiB5xvZ1/VsdwMCs
         o0s5AEhB4DWTepx/AGu/YN6mOA+aZaHc96P95wH6w1Yfp8hMOzF4hcUTIJhswlQHsBHk
         kBjDfq6hVFZ4Siy3R/8zWabo7cj/rVkK8BaEyyeTIzKdG2vvgOvkoF+SajCDRyzP8N8l
         r8Qfrl2EDJ7jOoryEvx40QYjeaHBnAtM2yCcGiwx1JCJCnb7ASDrMUBp46AY9DUXUhBQ
         yjqFLTlSZ55d2+IRglVOqcKmhgaOv4+YuS9D/QgeD93AoxtM/4ssEMHbDheWNA4nhz7s
         2+5w==
X-Gm-Message-State: AOAM533gB788wWiio6GVwOV4dpVJiniK0qBcLJcoqCsFlwIZTFRVXXyM
        IZWCJu56xw7CPbePew8+46eLppw=
X-Google-Smtp-Source: ABdhPJwo6U8gI+G+CIWABexRo2H1/1K7gOS3BFtecInwhYKRu7O0ehfHqCB7jsC73m7nt3oF1vWrlm8=
X-Received: from sdf2.svl.corp.google.com ([2620:15c:2c4:201:f696:cb26:7b81:e8f1])
 (user=sdf job=sendgmr) by 2002:a25:5489:: with SMTP id i131mr31085865ybb.169.1643130892871;
 Tue, 25 Jan 2022 09:14:52 -0800 (PST)
Date:   Tue, 25 Jan 2022 09:14:50 -0800
In-Reply-To: <6f569cca2e45473f9a724d54d03fdfb45f29e35f.1643129402.git.fmaurer@redhat.com>
Message-Id: <YfAwCh+uA30Ji8wE@google.com>
Mime-Version: 1.0
References: <6f569cca2e45473f9a724d54d03fdfb45f29e35f.1643129402.git.fmaurer@redhat.com>
Subject: Re: [PATCH bpf-next] selftests: bpf: Less strict size check in sockopt_sk
From:   sdf@google.com
To:     Felix Maurer <fmaurer@redhat.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        kafai@fb.com, yauheni.kaliuta@redhat.com, zhuyifei@google.com,
        jbenc@redhat.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 01/25, Felix Maurer wrote:
> Originally, the kernel strictly checked the size of the optval in
> getsockopt(TCP_ZEROCOPY_RECEIVE) to be equal to sizeof(struct
> tcp_zerocopy_receive). With c8856c0514549, this was changed to allow
> optvals of different sizes.

> The bpf code in the sockopt_sk test was still performing the strict size
> check. This fix adapts the kernel behavior from c8856c0514549 in the
> selftest, i.e., just check if the required fields are there.

Looks good, thank you!

Reviewed-by: Stanislav Fomichev <sdf@google.com>

> Fixes: 9cacf81f81611 ("bpf: Remove extra lock_sock for  
> TCP_ZEROCOPY_RECEIVE")
> Signed-off-by: Felix Maurer <fmaurer@redhat.com>
> ---
>   tools/testing/selftests/bpf/progs/sockopt_sk.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)

> diff --git a/tools/testing/selftests/bpf/progs/sockopt_sk.c  
> b/tools/testing/selftests/bpf/progs/sockopt_sk.c
> index d0298dccedcd..c8d810010a94 100644
> --- a/tools/testing/selftests/bpf/progs/sockopt_sk.c
> +++ b/tools/testing/selftests/bpf/progs/sockopt_sk.c
> @@ -72,7 +72,8 @@ int _getsockopt(struct bpf_sockopt *ctx)
>   		 * reasons.
>   		 */

> -		if (optval + sizeof(struct tcp_zerocopy_receive) > optval_end)
> +		/* Check that optval contains address (__u64) */
> +		if (optval + sizeof(__u64) > optval_end)
>   			return 0; /* bounds check */

>   		if (((struct tcp_zerocopy_receive *)optval)->address != 0)
> --
> 2.34.1

