Return-Path: <bpf+bounces-26615-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD8948A2B74
	for <lists+bpf@lfdr.de>; Fri, 12 Apr 2024 11:44:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6476028473F
	for <lists+bpf@lfdr.de>; Fri, 12 Apr 2024 09:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5379B51C40;
	Fri, 12 Apr 2024 09:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MAmR8ZIu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5458254660
	for <bpf@vger.kernel.org>; Fri, 12 Apr 2024 09:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712915053; cv=none; b=Y1Q2sM6QOMmqsjoeyeWDYRG3c4k6YG+kwIo6ryJT7Cz6mbQF2LJmhXBSNz0iUM6Eg/YPwb0DjVZ2AnWZ5GKYDr5BM3hAEb1AuKy4iBTOE2WkQPCqrpTNvrOTQuI8lO2YASkzfQtkie2pLkrGD0qUUo/ffanIG4UsGSDi7+lUaCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712915053; c=relaxed/simple;
	bh=V0IA6BO1BXkqhWQdIZ9Qh6mOExvYBX3C5rgQlLXoO+E=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=og9RSLuo2U6j9A00kTjLQtCtwZUzSycF0avY8uQMTQNGUKy1eIJlp68QvrF/ap/TPHcksm1ljBZcsaznXGUhAbZG0V3MuE7tmf+xeMbhoqJZu2nSYyIK1N7UzsOiw/6qAYJUpz2UjOpVe6KyaZzZcN4TQ2OyReFbzzPVvUOyxMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MAmR8ZIu; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-56e48d0a632so1121114a12.2
        for <bpf@vger.kernel.org>; Fri, 12 Apr 2024 02:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712915050; x=1713519850; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=G7VsNSmHrRpVhso6qn/KgPHetnr/uK3sqK3M01a9rRU=;
        b=MAmR8ZIuGy0EEunGcET2Yz0eLHVjnETTOkxU3sECJbW/mebA2t/iDC1F8zlNRnZ3Dr
         RqB+GO/CYcRcQsmDPwktSrbjnUspVEzeDlpMh73T8CbjdhRVyeo2YnfCFDKrWdwQl8uL
         Gr0p0hi0vqXafdT+xiSCUNnHrHyCdTVeTn/bo5dJ7uaRd5hE13ElGzTVoBQ+5572R0xf
         CXDoRMVDzD29JDY1h9DH3M0eI1GBqnCMGWQrwyC54WWZ+GmUIk/egtv2G7t1ajc7km8F
         HzoUKjiEacgD2hKfXrq0ezUWSDTL47OxlpTlFvrWJ2d2iMjK0l8zgI7FE8PBWJG9jtR0
         o3hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712915050; x=1713519850;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G7VsNSmHrRpVhso6qn/KgPHetnr/uK3sqK3M01a9rRU=;
        b=S+UK4d3XhtMosWV2jLHxjZbPqKrNx/GDuWFz71/FcCCsUpHB9az5zwGZjhOG2w/tsY
         tzxn79lG1024kE+dU88mu41Hf95fqP47qmE08fTUhjof2lH9uEOPFl/I7QVBnVPvZGVz
         p9xakQ0An8iy4K8fkFg823EFE3P/8Rdk/50/ysh1/LqayJ3hA3YZN/x8zsp8P2/rimgP
         pNWQDBZJbna58fBTbARsqp9vRunMqQ2aA5E66dPE1f2rKjMRUjRDwdQ3IFhIfbD5JbSZ
         Sh6Thv6Y/VfL0dbUNEq7w43FuOZahwcyQzQmsftVpLxQxIkzSVoRvh80qOwWu/leWVjq
         DNXw==
X-Forwarded-Encrypted: i=1; AJvYcCXsc5tmeiQQACpkQ0j508R/OPAwlm9cfFnSVftUSvvOVs7X8d2FPOHR8sfx49I7rXz50TvfmuYJwQwtI7b9T7DntpCt
X-Gm-Message-State: AOJu0Ywq6ja2lVT6iRAyL3fWBhlPvDImIbx+1Sd8gctiPQ+Vl7Vs68rO
	nslIpCQfnkPur8t/l3GYBC7ombgp5Zoas74TX6tQNNfvnAjQNZlO
X-Google-Smtp-Source: AGHT+IGSx1vO3c330hljkKZpex8cjcQU8dQ2MjJJP3KIsEJO5xpCZrvK/hUldp5Nwa7iHn9mSrqpag==
X-Received: by 2002:a50:c318:0:b0:566:2aff:2d38 with SMTP id a24-20020a50c318000000b005662aff2d38mr1596682edb.26.1712915050272;
        Fri, 12 Apr 2024 02:44:10 -0700 (PDT)
Received: from krava (124.239.197.178.dynamic.wless.lssmb00p-cgnat.res.cust.swisscom.ch. [178.197.239.124])
        by smtp.gmail.com with ESMTPSA id u5-20020aa7d985000000b0057000a2cb5bsm278614eds.18.2024.04.12.02.44.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 02:44:09 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 12 Apr 2024 11:44:06 +0200
To: Yonghong Song <yonghong.song@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>
Subject: Re: [PATCHv2 bpf-next] selftests/bpf: Add read_trace_pipe_iter
 function
Message-ID: <ZhkCZrUQdE9gSo88@krava>
References: <20240410140952.292261-1-jolsa@kernel.org>
 <64fa1c03-26dc-4ec3-a54c-205900950862@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64fa1c03-26dc-4ec3-a54c-205900950862@linux.dev>

On Wed, Apr 10, 2024 at 05:09:18PM -0700, Yonghong Song wrote:
> 
> On 4/10/24 7:09 AM, Jiri Olsa wrote:
> > We have two printk tests reading trace_pipe in non blocking way,
> > with the very same code. Moving that in new read_trace_pipe_iter
> > function.
> > 
> > Current read_trace_pipe is used from sampless/bpf and needs to
> > do blocking read and printf of the trace_pipe data, using new
> > read_trace_pipe_iter to implement that.
> > 
> > Both printk tests do early checks for the number of found messages
> > and can bail earlier, but I did not find any speed difference w/o
> > that condition, so I did not complicate the change more for that.
> > 
> > Some of the samples/bpf programs use read_trace_pipe function,
> > so I kept that interface untouched. I did not see any issues with
> > affected samples/bpf programs other than there's slight change in
> > read_trace_pipe output. The current code uses puts that adds new
> > line after the printed string, so we would occasionally see extra
> > new line. With this patch we read output per lines, so there's no
> > need to use puts and we can use just printf instead without extra
> > new line.
> > 
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> 
> Ack with a nit below.
> 
> Acked-by: Yonghong Song <yonghong.song@linux.dev>

SNIP

> > @@ -56,21 +47,12 @@ void serial_test_trace_printk(void)
> >   		goto cleanup;
> >   	/* verify our search string is in the trace buffer */
> > -	while (getline(&buf, &buflen, fp) >= 0 || errno == EAGAIN) {
> > -		if (strstr(buf, SEARCHMSG) != NULL)
> > -			found++;
> > -		if (found == bss->trace_printk_ran)
> > -			break;
> 
> The above condition is not covered, but I think it is okay since the test
> will run in serial mode.

right, I made a note about that in the changelog:

> > Both printk tests do early checks for the number of found messages
> > and can bail earlier, but I did not find any speed difference w/o
> > that condition, so I did not complicate the change more for that.

I think it's fine

SNIP

> > +int read_trace_pipe_iter(void (*cb)(const char *str, void *data), void *data, int iter)
> > +{
> > +	size_t buflen, n;
> > +	char *buf = NULL;
> > +	FILE *fp = NULL;
> > +
> > +	if (access(TRACEFS_PIPE, F_OK) == 0)
> > +		fp = fopen(TRACEFS_PIPE, "r");
> > +	else
> > +		fp = fopen(DEBUGFS_PIPE, "r");
> > +	if (!fp)
> > +		return -1;
> > +
> > +	 /* We do not want to wait forever when iter is specified. */
> > +	if (iter)
> > +		fcntl(fileno(fp), F_SETFL, O_NONBLOCK);
> > +
> > +	while ((n = getline(&buf, &buflen, fp) >= 0) || errno == EAGAIN) {
> > +		if (n > 0)
> > +			cb(buf, data);
> > +		if (iter && !(--iter))
> 
> "if (iter-- == 1)" should also work. But your code works too.

ok, keeping the current one ;-)

thanks,
jirka

> 
> > +			break;
> > +	}
> > +
> > +	free(buf);
> > +	if (fp)
> > +		fclose(fp);
> > +	return 0;
> > +}
> > +
> [...]

