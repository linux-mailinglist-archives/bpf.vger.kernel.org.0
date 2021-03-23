Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A8EC34562A
	for <lists+bpf@lfdr.de>; Tue, 23 Mar 2021 04:22:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbhCWDVr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 22 Mar 2021 23:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbhCWDVl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 22 Mar 2021 23:21:41 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A76EC061574;
        Mon, 22 Mar 2021 20:21:41 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id 11so12834439pfn.9;
        Mon, 22 Mar 2021 20:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yZbUyZ8Yb8abcybiz2dwsAdjG3gi9bXidHbGwFp7ee0=;
        b=YP6DJbYkpiW9kBZL14gufR7AraNfzEGpOS0hzAsddy5CvnNg5n6Tq9dw5lDtwsKi9+
         c0F03hJzr75Pp96G78jx7njqnd6j5/LLyRXQTkCGS0sP+DcArcg8s/ekLTSphd58KJU2
         7REAMokiOxwzbMT1v0aVdVOwe0xRh+H1s02ONu0MuFx7oklv/f9fv93IMGjcpqG7KrPf
         l6Lj5LjWfxJKwVTPrfz4xEfqNPMK9JTTIqZcoJg5fxMlbALeq6DHj4ffDEcGlQrLOim5
         Bedwhq4zV/Fi1X6pOyUajXWTZZcbWPDzkyRXO2xN4Bnh11hsTQD7jGGMln20QgXScPAL
         UhmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yZbUyZ8Yb8abcybiz2dwsAdjG3gi9bXidHbGwFp7ee0=;
        b=TaGq8ZMOZnTuzO3X7sp3xzqvcw6wDE69TiLvtJsIZ7KxMQ0dXfNiyhlOVWuHTfkvTd
         v4/6/P72gwfurjt9CECJo59JeSv6oeHIZonb2J+fUkCHkc5GJdpPOA7o0hLr6mphlIAD
         bdfCs63YKe7mBTUrl1gRbXqkOEZSLVVbWNSpLR0EH8W1Tn/KZtqGxen49q7L59l6EEEp
         54Dw56VqYd6z6z8EgoReI6gWdbzPMp4uaXoXJW5oOkZh2YJV/bUMM8mBlYOwtTMZR1bI
         4PeX6shycE1t2jufr9Nh2tZQe4HT/DkgaazUXNTF9iJIL3lOmuzhw5barCvCPQ85DO8F
         akUA==
X-Gm-Message-State: AOAM5329EglmxXP/foe6sWpQgz7Ecwma1xNc9wBMcYdkXNJX8uTkXuLy
        Or2/J3k3nwZA2Y32adi97hw=
X-Google-Smtp-Source: ABdhPJyPHPoFPYpl4ko4gK0fPQmWpt/JCUXPQ8cNUcwL7QJTrYESQJvgfbw0oAIs+W3l3olhKlh3nw==
X-Received: by 2002:a05:6a00:b47:b029:20d:1c65:75f0 with SMTP id p7-20020a056a000b47b029020d1c6575f0mr2751887pfo.9.1616469700761;
        Mon, 22 Mar 2021 20:21:40 -0700 (PDT)
Received: from ast-mbp ([2620:10d:c090:400::5:6970])
        by smtp.gmail.com with ESMTPSA id 81sm8480960pfu.164.2021.03.22.20.21.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 20:21:39 -0700 (PDT)
Date:   Mon, 22 Mar 2021 20:21:37 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Florent Revest <revest@chromium.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, yhs@fb.com, kpsingh@kernel.org,
        jackmanb@chromium.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next 2/5] bpf: Add a bpf_snprintf helper
Message-ID: <20210323032137.yv23z25zjz45prvy@ast-mbp>
References: <20210310220211.1454516-1-revest@chromium.org>
 <20210310220211.1454516-3-revest@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210310220211.1454516-3-revest@chromium.org>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Mar 10, 2021 at 11:02:08PM +0100, Florent Revest wrote:
>  
> +struct bpf_snprintf_buf {
> +	char buf[MAX_SNPRINTF_MEMCPY][MAX_SNPRINTF_STR_LEN];
> +};
> +static DEFINE_PER_CPU(struct bpf_snprintf_buf, bpf_snprintf_buf);
> +static DEFINE_PER_CPU(int, bpf_snprintf_buf_used);
> +
> +BPF_CALL_5(bpf_snprintf, char *, out, u32, out_size, char *, fmt, u64 *, args,
> +	   u32, args_len)
> +{
> +	int err, i, buf_used, copy_size, fmt_cnt = 0, memcpy_cnt = 0;
> +	u64 params[MAX_SNPRINTF_VARARGS];
> +	struct bpf_snprintf_buf *bufs;
> +
> +	buf_used = this_cpu_inc_return(bpf_snprintf_buf_used);
> +	if (WARN_ON_ONCE(buf_used > 1)) {

this can trigger only if the helper itself gets preempted and
another bpf prog will run on the same cpu and will call into this helper
again, right?
If so, how about adding preempt_disable here to avoid this case?
It won't prevent the case where kprobe is inside snprintf core,
so the counter is still needed, but it wouldn't trigger by accident.
Also since bufs are not used always, how about grabbing the
buffers only when %p or %s are seen in fmt?
After snprintf() is done it would conditionally do:
if (bufs_were_used) {
   this_cpu_dec(bpf_snprintf_buf_used);
   preempt_enable();
}
This way simple bpf_snprintf won't ever hit EBUSY.

> +		err = -EBUSY;
> +		goto out;
> +	}
> +
> +	bufs = this_cpu_ptr(&bpf_snprintf_buf);
> +
> +	/*
> +	 * The verifier has already done most of the heavy-work for us in
> +	 * check_bpf_snprintf_call. We know that fmt is well formatted and that
> +	 * args_len is valid. The only task left is to convert some of the
> +	 * arguments. For the %s and %pi* specifiers, we need to read buffers
> +	 * from a kernel address during the helper call.
> +	 */
> +	for (i = 0; fmt[i] != '\0'; i++) {
> +		if (fmt[i] != '%')
> +			continue;
> +
> +		if (fmt[i + 1] == '%') {
> +			i++;
> +			continue;
> +		}
> +
> +		/* fmt[i] != 0 && fmt[last] == 0, so we can access fmt[i + 1] */
> +		i++;
> +
> +		/* skip optional "[0 +-][num]" width formating field */
> +		while (fmt[i] == '0' || fmt[i] == '+'  || fmt[i] == '-' ||
> +		       fmt[i] == ' ')
> +			i++;
> +		if (fmt[i] >= '1' && fmt[i] <= '9') {
> +			i++;
> +			while (fmt[i] >= '0' && fmt[i] <= '9')
> +				i++;
> +		}
> +
> +		if (fmt[i] == 's') {
> +			void *unsafe_ptr = (void *)(long)args[fmt_cnt];
> +
> +			err = strncpy_from_kernel_nofault(bufs->buf[memcpy_cnt],
> +							  unsafe_ptr,
> +							  MAX_SNPRINTF_STR_LEN);
> +			if (err < 0)
> +				bufs->buf[memcpy_cnt][0] = '\0';
> +			params[fmt_cnt] = (u64)(long)bufs->buf[memcpy_cnt];

how about:
char buf[512]; instead?
instead of memcpy_cnt++ remember how many bytes of the buf were used and
copy next arg after that.
The scratch space would be used more efficiently.
The helper would potentially return ENOSPC if the first string printed via %s
consumed most of the 512 space and the second string doesn't fit.
But the verifier-time if (memcpy_cnt >= MAX_SNPRINTF_MEMCPY) can be removed.
Ten small %s will work fine.

We can allocate a page per-cpu when this helper is used by prog and free
that page when all progs with bpf_snprintf are unloaded.
But extra complexity is probably not worth it. I would start with 512 per-cpu.
It's going to be enough for most users.

Overall looks great. Cannot wait for v2 :)
