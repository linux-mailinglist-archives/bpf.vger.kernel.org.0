Return-Path: <bpf+bounces-22498-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA25A85F774
	for <lists+bpf@lfdr.de>; Thu, 22 Feb 2024 12:50:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0861B24E8A
	for <lists+bpf@lfdr.de>; Thu, 22 Feb 2024 11:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51D9646450;
	Thu, 22 Feb 2024 11:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LNHlvWpD"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530BF4776E
	for <bpf@vger.kernel.org>; Thu, 22 Feb 2024 11:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708602619; cv=none; b=iGffG8ZwBzlOXn+kyhPrzTUPKBiS7942PWG659NrSGQ8/bDNqpnCuGorHTD9cmRfJg0wF9LvKDtEFwru54tCU6hKQm9FK1iKW9G6eCd8e9Sqge8F5ycIYjS9yGVb+/TkWxKAy2+i7uHKOO40jU9RxcesLbjI/ZcDM0AnF/a8IGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708602619; c=relaxed/simple;
	bh=ma9DfQIGiAa5vr3ks75PfINXo2TPrC0w7A/88yi8pA8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ck/g/qVjdeVgBhxNO4FX2M3MtqlUqB0/AquT6dUxlJxMOX2UlWlEakMuIiZC04cDcsn9fO6fRFFxel1Ye2qshn3+/zg/CFVBAfgjufmiWQ2OLQwEdHt4mewv6RKP6I/j1yW2jEahVVENZBv/V2sCaJm6tiUcVJ51iUAROurehaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LNHlvWpD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708602617;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ldC5iLR/TjfHxpr5I8kE+2L9PTCMZ2jj1k9txMQpdfM=;
	b=LNHlvWpDPvqy6mIpfwQBe7iBjXqd28ML5ZmGBOpEMRu1nPlpHyWxgNMk6N4czt4mPdsSNw
	EkNAUkQeAsQWv+W58bVedLlLGDy8CWVecJCD/r19DIyPYLNKVp7pOJHqgDh2NCRfiiGFCg
	XRwa7yM8XhJhwk95PwaQFQbgc+ynhvA=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-AZtT1E15Mu2Z215_mgPdYw-1; Thu, 22 Feb 2024 06:50:15 -0500
X-MC-Unique: AZtT1E15Mu2Z215_mgPdYw-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a3f56a2936eso84707966b.1
        for <bpf@vger.kernel.org>; Thu, 22 Feb 2024 03:50:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708602614; x=1709207414;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ldC5iLR/TjfHxpr5I8kE+2L9PTCMZ2jj1k9txMQpdfM=;
        b=JGdN/UmWOG2Qb1mhe5xqRNWtewXE/xmxdHqPZuu2Mv3GjxpGKe36gd3xzs+nL34/78
         rjxeYsgYrqSoJsPbU/F+WMKnoEfj71jkXGujXtHLD0jI+g4QgVukkx+O7MI7TXMSPo9T
         1OjVItklIQwXRNgfi0SbWxpDZKRZw/dZC+EnRI8xBjglRlnqpwR9Wt5ibv1aIJLAWlqr
         V6aXDuFqo/3hx746EULuFZzqqhGVMhHFya0jv/toDtVhye6OnGDkrPXQDXGoEos8trdH
         YjDcaZ69KY4ZhKnavzcIddlbLKSfsS9s8ajhZEtcAXYwZG57Fz/FoHbjtmj+u3a07fzP
         SN6w==
X-Gm-Message-State: AOJu0Yx0XnBCXB04JfKqkJIV5h0EEIXdtEAJ/xidwSDuqdnupe0FXjQD
	7L9Km39vngwyrb6XDf6l3rA7nZQA9F5Ft2qgI/dChDedRF4lnnOLvpiRN7boYJEzSRSba3n533/
	Wdx14fqbL/j8cW8ZGmJz4esZzDQEqWSvOhXfV6nhVdT0Ar2xHfw==
X-Received: by 2002:a17:906:393:b0:a3f:4ca8:f93e with SMTP id b19-20020a170906039300b00a3f4ca8f93emr2003785eja.24.1708602614212;
        Thu, 22 Feb 2024 03:50:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHFqkM/gRLrevRcPSWpe7we5hg0Pbu6lFDxiRpmiSyGCXmYKdK+uwM9zZOtenBwAxZkzrXVHw==
X-Received: by 2002:a17:906:393:b0:a3f:4ca8:f93e with SMTP id b19-20020a170906039300b00a3f4ca8f93emr2003757eja.24.1708602613833;
        Thu, 22 Feb 2024 03:50:13 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id h10-20020a170906398a00b00a3f99497456sm259912eje.90.2024.02.22.03.50.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 03:50:13 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 63345112DEFE; Thu, 22 Feb 2024 12:50:12 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Benjamin Tissoires <bentiss@kernel.org>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, John Fastabend
 <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, Martin
 KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP
 Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Jiri Kosina
 <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-input@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>
Subject: Re: [PATCH RFC bpf-next v3 04/16] bpf/helpers: introduce sleepable
 bpf_timers
In-Reply-To: <20240221-hid-bpf-sleepable-v3-4-1fb378ca6301@kernel.org>
References: <20240221-hid-bpf-sleepable-v3-0-1fb378ca6301@kernel.org>
 <20240221-hid-bpf-sleepable-v3-4-1fb378ca6301@kernel.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Thu, 22 Feb 2024 12:50:12 +0100
Message-ID: <87le7chg5n.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Benjamin Tissoires <bentiss@kernel.org> writes:

> @@ -1245,6 +1294,7 @@ BPF_CALL_3(bpf_timer_set_callback, struct bpf_timer_kern *, timer, void *, callb
>  		ret = -EPERM;
>  		goto out;
>  	}
> +	down(&t->sleepable_lock);
>  	prev = t->prog;
>  	if (prev != prog) {
>  		/* Bump prog refcnt once. Every bpf_timer_set_callback()
> @@ -1261,6 +1311,7 @@ BPF_CALL_3(bpf_timer_set_callback, struct bpf_timer_kern *, timer, void *, callb
>  		t->prog = prog;
>  	}
>  	rcu_assign_pointer(t->callback_fn, callback_fn);
> +	up(&t->sleepable_lock);
>  out:
>  	__bpf_spin_unlock_irqrestore(&timer->lock);
>  	return ret;
> @@ -1282,7 +1333,7 @@ BPF_CALL_3(bpf_timer_start, struct bpf_timer_kern *, timer, u64, nsecs, u64, fla
>  
>  	if (in_nmi())
>  		return -EOPNOTSUPP;
> -	if (flags & ~(BPF_F_TIMER_ABS | BPF_F_TIMER_CPU_PIN))
> +	if (flags & ~(BPF_F_TIMER_ABS | BPF_F_TIMER_CPU_PIN | BPF_F_TIMER_SLEEPABLE))
>  		return -EINVAL;
>  	__bpf_spin_lock_irqsave(&timer->lock);
>  	t = timer->timer;
> @@ -1299,7 +1350,10 @@ BPF_CALL_3(bpf_timer_start, struct bpf_timer_kern *, timer, u64, nsecs, u64, fla
>  	if (flags & BPF_F_TIMER_CPU_PIN)
>  		mode |= HRTIMER_MODE_PINNED;
>  
> -	hrtimer_start(&t->timer, ns_to_ktime(nsecs), mode);
> +	if (flags & BPF_F_TIMER_SLEEPABLE)
> +		schedule_work(&t->work);
> +	else
> +		hrtimer_start(&t->timer, ns_to_ktime(nsecs), mode);
>  out:
>  	__bpf_spin_unlock_irqrestore(&timer->lock);
>  	return ret;

I think it's a little weird to just ignore the timeout parameter when
called with the sleepable flag. But I guess it can work at least as a
first pass; however, in that case we should enforce that the caller
passes in a timeout of 0, so that if we do add support for a timeout for
sleepable timers in the future, callers will be able to detect this.

-Toke


