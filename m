Return-Path: <bpf+bounces-65855-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75CD7B299F6
	for <lists+bpf@lfdr.de>; Mon, 18 Aug 2025 08:45:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 155333A3D07
	for <lists+bpf@lfdr.de>; Mon, 18 Aug 2025 06:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81061275B1B;
	Mon, 18 Aug 2025 06:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i5is2fkE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F3A275AFA
	for <bpf@vger.kernel.org>; Mon, 18 Aug 2025 06:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755499404; cv=none; b=JBm7uzAHqXLwnf3UBk/yeiFGSHLJ6tyYaiLGUvWBCE1bGAVH/TgzqID0g9rbuF4pqWlPmvr36F0du/1j30gDx9FH5dzv3zeZVZZk/xTqXlU0G3xOzHNntCXg5wzSZKVdl3gAa7WXTBsjMtKhVDKR5UtGlYOEKP6DErMntWPJBQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755499404; c=relaxed/simple;
	bh=FccAh4HSF6suhs5C90nMivMI4zakCl/2og6YkKYgbPE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nXbvaP91Uo8IVxWb7PBPmFuTK5t/1fGAq2CxA/B9Io9uc4kyxJBWu8WhEkG4511bv+IbmxyxstXXFK+l7w1kLfa7n6YfbEkW/r5MdoDrvPVa/qxWImTvdr+thQmypzTlNOhlDPl2Kq3balv1FSXA63B+4Ph6cKG7PlrhfR/s4/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i5is2fkE; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6188b6f501cso4499901a12.2
        for <bpf@vger.kernel.org>; Sun, 17 Aug 2025 23:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755499400; x=1756104200; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fZXEF0xCGdQ2T6mi9xAIOOCIMKcYkk4JxgTjMg5NaEo=;
        b=i5is2fkEmGzGN74+A56ypBF6GGZOaucPe7zv2wHZwl45s8tTBTsT2FF/gWWMOzcCPL
         I2tPWZG3iro7QBwDYDVk1KF2nndhhy6FyZSahRCu2tGsel58LWpBuL5z+IlBOCneUtNw
         2Zn0LqPORYYMkN15k8I0Tj/K0FleB+Fa8YgGkth+ZLsmJIlg17puRVnbkEJJMxHt3lMR
         nhFsxzR1j66PWSXTJbdrxuMiuXROtz7BAV+Fsw7Kpsr0G98J0zNsosI2opDzegc0byGc
         8q4f7M8SSzpkj12gOKsXjY/9gubvMDnxCNDfBWIxQKH0ARmddUWsmenitM3DH8Z19qcu
         T+ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755499400; x=1756104200;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fZXEF0xCGdQ2T6mi9xAIOOCIMKcYkk4JxgTjMg5NaEo=;
        b=TokcIFHScljzJCU8sj4LuGEvtBjHp8kEQSw1sRfA1N96CY86CgKf1PA+sRSOIYbOAO
         eh/nv7SHiYQBdS+nrR255/nfecRiFN3dg+bvPy2EmBTEStpvm4Pd0X+BnfGeLr/H8J9p
         T0/PczdCl6R0havkRNJP+6c0NuVtLs2bGgJUJJ7GpSIP0XD204yh0rPcXxG3fXL9/OhX
         kTf/RYzsN59/2xLLKjvht9U0EBvPSlN+KAK+vGpV3H7gNVgVg8JKzcpPiiFMqwHsuAs2
         uvjEmY9SMW1PNeduoxNgxtvq7YkbGrooYGFj9JyaCRvO44M9jH9j1bdq7vx7EEHNAsC2
         CDJQ==
X-Forwarded-Encrypted: i=1; AJvYcCUE7jP14LYOpvtCgmImaLq3FOhCE4RyqkW3hTE89K7ZLzV0ZSKmkcZjudRAhYuIzsRURKw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPHnwu/p2O2pmhloPUEX6yUlWv45HGein+msEBeJumyNeLr3kG
	UNvrL1iIkDif5UbvzP59TnWsZKfgZPdqvhE7iVt/6dc2Ag8GnawRT2FyrFSlQ3Te3g==
X-Gm-Gg: ASbGncsIaqKqEgfaaVJIB/J06Xf84A6nB1FpfU1/gMKnuRWB0Z+IEKCoa58D1wuabzx
	zXv7ZyoV8vZcacHW4K6jOUmre36YwiruAeFPViHTTHEG6GnxTtTOr8TOwbvzXAQiim3F+YBTW/5
	xEivFspw9FRlKqy0YinQdjZHBlv9ruoNovnKQS3H01GLBAtJg2Xn2+o0AakvBj7nlL1e4l12Vs3
	Ao8UaUFwQIzlIftWh2wFJBYa+vILEKUIC5bjzQKRJ87/FkE7nXDKVo8YWzjrHsqz5cyxJqYRD1F
	OTh5l8kV+4aeDw1st4WnYHfaKr/DJEeTzVmyr5QnKdhA8PEEaxdmzqaEeB9GE/r3111qZ1H7ZxX
	QuIIL/kVbYm54ZInlDeqGJEkTII0qgET2CDgnS+V+PbnmazulAX02HLyh6lfl34XMFajrJu1rZZ
	z9OgFuSXKZYwI=
X-Google-Smtp-Source: AGHT+IFsuUXso/ROrw+QW3L511Rd5L0Q676wKh5+ZjV4xxCgbIopZ++Mns/WPemDXGJyS+Vf0Y1Bxg==
X-Received: by 2002:a05:6402:35cc:b0:618:fe3:f4c with SMTP id 4fb4d7f45d1cf-619bf225800mr4952344a12.29.1755499400325;
        Sun, 17 Aug 2025 23:43:20 -0700 (PDT)
Received: from google.com (155.217.141.34.bc.googleusercontent.com. [34.141.217.155])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-618b01ae57dsm6471172a12.29.2025.08.17.23.43.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Aug 2025 23:43:19 -0700 (PDT)
Date: Mon, 18 Aug 2025 06:43:15 +0000
From: Matt Bobrowski <mattbobrowski@google.com>
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Stanislav Fomichev <stfomichev@gmail.com>, bpf@vger.kernel.org,
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	eddyz87@gmail.com, mykolal@fb.com
Subject: Re: [PATCH bpf] bpf/selftests: fix test_tcpnotify_user
Message-ID: <aKLLg0y7cJd592cf@google.com>
References: <aJ8kHhwgATmA3rLf@google.com>
 <aJ9V9r4U24phxzQG@mini-arch>
 <70cdb532-4477-459c-8762-638ceedae043@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <70cdb532-4477-459c-8762-638ceedae043@linux.dev>

On Fri, Aug 15, 2025 at 01:17:39PM -0700, Martin KaFai Lau wrote:
> On 8/15/25 8:44 AM, Stanislav Fomichev wrote:
> > On 08/15, Matt Bobrowski wrote:
> > > Based on a bisect, it appears that commit 7ee988770326 ("timers:
> > > Implement the hierarchical pull model") has somehow inadvertently
> > > broken BPF selftest test_tcpnotify_user. The error that is being
> > > generated by this test is as follows:
> > > 
> > > 	FAILED: Wrong stats Expected 10 calls, got 8
> > > 
> > > It looks like the change allows timer functions to be run on CPUs
> > > different from the one they are armed on. The test had pinned itself
> > > to CPU 0, and in the past the retransmit attempts also occurred on CPU
> > > 0. The test had set the max_entries attribute for
> > > BPF_MAP_TYPE_PERF_EVENT_ARRAY to 2 and was calling
> > > bpf_perf_event_output() with BPF_F_CURRENT_CPU, so the entry was
> > > likely to be in range. With the change to allow timers to run on other
> > > CPUs, the current CPU tasked with performing the retransmit might be
> > > bumped and in turn fall out of range, as the event will be filtered
> > > out via __bpf_perf_event_output() using:
> > > 
> > >      if (unlikely(index >= array->map.max_entries))
> > >              return -E2BIG;
> > 
> > [..]
> > 
> > > A possible change would be to explicitly set the max_entries attribute
> > > for perf_event_map in test_tcpnotify_kern.c to a value that's at least
> > > as large as the number of CPUs. As it turns out however, if the field
> > > is left unset, then the BPF selftest library will determine the number
> > > of CPUs available on the underlying system and update the max_entries
> > > attribute accordingly.
> > 
> > nit: the max_entries is set by libbpf in map_set_def_max_entries. 'BPF
> > selftest library' seems a bit vague. But not a reason for respin.
> 
> Fixed the commit message. Thanks. Applied.

ACK. Apologies about the oversimplification there.

> > > A further problem with the test is that it has a thread that continues
> > > running up until the program exits. The main thread cleans up some
> > > LIBBPF data structures, while the other thread continues to use them,
> > > which inevitably will trigger a SIGSEGV. This can be dealt with by
> > > telling the thread to run for as long as necessary and doing a
> > > pthread_join on it before exiting the program.
> 
> Some of the "goto err" seems to have similar problem but ok-ish as long as
> the iptables runs fine. I didn't look why the test needs to start a thread
> at all, so I leave it as is. The CI is not running this test. The test is
> getting rotten overall. It should be moved to test_progs. Probably as a
> subtest in some of the existing sockops test in test_progs.

Agree, this test is archaic and needs should be converted or folded
such that it runs under test_progs. If I have time, I'll perform this
clean up.

