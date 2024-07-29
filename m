Return-Path: <bpf+bounces-35916-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC40093FE78
	for <lists+bpf@lfdr.de>; Mon, 29 Jul 2024 21:46:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B38C1C22588
	for <lists+bpf@lfdr.de>; Mon, 29 Jul 2024 19:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7A11188CD7;
	Mon, 29 Jul 2024 19:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="s2l733R6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6F984D02
	for <bpf@vger.kernel.org>; Mon, 29 Jul 2024 19:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722282398; cv=none; b=mKuA1+0zaJEe/roMFBaLOnYtcGMFf+fDul988zQVajNcMQBwDDJi8qTooIXXipZQUZikk//52BSVIEx/Q140HBwKvHPsDoKlslzPJFzfoYZQmHbJfkVKA2A3uT+67MPrGr8SsVkfb/ENaKRKuBfE0UI8FpkV9EvzgdLO1TvLTgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722282398; c=relaxed/simple;
	bh=FR/x2IiQiKwgWe94ryrQfqytEtpInOGLjD8sTqSrMEo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MBwP6ntuVkbOUNaxSOIyhSH8KsVHJCMrfkSRQuY0m+sfdojJzwcYPYhPtojIjbKhwxMX1zCzsoTZZ2EFgGXaDyf4E8JydQjuesPfu3B6oH6taHD6ba/1YRMPexSqB6zNkiVihhJIkvtZzoxbBDzcoHR8ToocngzOXVUuxJz//CE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=s2l733R6; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-70d357040dbso2801324b3a.1
        for <bpf@vger.kernel.org>; Mon, 29 Jul 2024 12:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1722282395; x=1722887195; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Eb6u1v+rp+L34/fq+ePdWX4sBR+FCrH0jIJkH5yVcjY=;
        b=s2l733R6qWbw3INNvzlgjBMnhj5F6w1vFVhl0MZJu1sq0XlL7bi+PXUanH1DbuKNKo
         3wYfXBw7DDJBBwn1/LDIv9YdmAmqgUa842XXeuTlZ0Glfb9Xr+j5t4sIMGkaML+0tpjE
         ZsWf3RFOI4GUgtswmX2FbBPz46rhA10pfNr84SdSfj/2YxcIn69/MigfjmHbBvWy92fq
         sADQ9s9JLspqttPl6UQggWDLLw8LZjhTIiKMdMHhghQNjyGPXzuR/ELwZ7gWBQFMsAdV
         DnAGOHcyJSeBI+reVuBpGO6Y6QUYUtHoDcbwoLyNk/QbXH/mTlMNwv3UsKSzE1c49y2J
         AS0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722282395; x=1722887195;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Eb6u1v+rp+L34/fq+ePdWX4sBR+FCrH0jIJkH5yVcjY=;
        b=cwdFXi4ctAfHkvbvndOzqFLBALFli9D9/n0N7lM6bo/F7YXYUR6HZcOZQiLSdbhTWA
         Pim8oTU6L+zxBAV3OosS6S2EZqRjFd/AJKRcMSLAouX/q6AVni86d+VqV6q13IuaUu47
         BOIuHiy/z81d+ulX2jGqbXkTaCdRCLs/+RRV2V2ZfQ655l+4Oq0OuuLpYjQ67HNhG9jv
         a1IhHNx/i0Vqf59UXKw6DGDzxRQxYN7kKFnsrmkZ10PCjOgJhUO4mM/hgyi3vqYbTArK
         SndB/Z3S5ZcCD1kEYcVBUWC4QcZdgqoMM/3odOhYMi5ekm5ATJfObqXSGJ/ynWBKUlFH
         971Q==
X-Forwarded-Encrypted: i=1; AJvYcCVU5jyW+ku8qUkkt2qcHXYGrvgcttk8ku3k5AascXMkojVx/WiAnezVOUMCUKwn6gz1EwTEAlaux5xhG6bZtsAreHAr
X-Gm-Message-State: AOJu0Yw7NwP5wiiqdORpy8rqQYB6TukWKB83cYBk+hDqHGwW4CdsI1NV
	uGiSXnOBmaTQ6tbgL3P9IHQkTD64BxYDPoiDqEt1MHC0bFz95IAu22Uci75FdH0=
X-Google-Smtp-Source: AGHT+IF2xMDcCMLViVzTPYLxX6qawEepMk2EQYJGWmKToargwVSNSokPyBL0gjsTSIrYtJNenIhKYw==
X-Received: by 2002:a05:6a20:430f:b0:1c0:f675:ed08 with SMTP id adf61e73a8af0-1c4a129a73bmr8141673637.6.1722282395112;
        Mon, 29 Jul 2024 12:46:35 -0700 (PDT)
Received: from ghost ([50.145.13.30])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70ead712f25sm7141309b3a.81.2024.07.29.12.46.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 12:46:34 -0700 (PDT)
Date: Mon, 29 Jul 2024 12:46:31 -0700
From: Charlie Jenkins <charlie@rivosinc.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v2 2/8] libbpf: Move opts code into dedicated header
Message-ID: <Zqfxl82VCxUUi3R+@ghost>
References: <20240726-overflow_check_libperf-v2-0-7d154dcf6bea@rivosinc.com>
 <20240726-overflow_check_libperf-v2-2-7d154dcf6bea@rivosinc.com>
 <CAEf4BzZ8MGa8Ywp_9ztJh6naywqtfrbeGWs4=izw-e-p4GGxcA@mail.gmail.com>
 <ZqfXd0FKtXCJ5dwH@ghost>
 <CAEf4BzZ9B=CPuti9smOqDKD1dRvs3Ug7h9pHupr6jFeKEppJ4g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzZ9B=CPuti9smOqDKD1dRvs3Ug7h9pHupr6jFeKEppJ4g@mail.gmail.com>

On Mon, Jul 29, 2024 at 11:59:47AM -0700, Andrii Nakryiko wrote:
> On Mon, Jul 29, 2024 at 10:55 AM Charlie Jenkins <charlie@rivosinc.com> wrote:
> >
> > On Mon, Jul 29, 2024 at 10:01:05AM -0700, Andrii Nakryiko wrote:
> > > On Mon, Jul 29, 2024 at 9:46 AM Charlie Jenkins <charlie@rivosinc.com> wrote:
> > > >
> > > > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> > > > ---
> > > >  tools/include/tools/opts.h      | 68 +++++++++++++++++++++++++++++++++++++++++
> > > >  tools/lib/bpf/bpf.c             |  1 +
> > > >  tools/lib/bpf/btf.c             |  1 +
> > > >  tools/lib/bpf/btf_dump.c        |  1 +
> > > >  tools/lib/bpf/libbpf.c          |  3 +-
> > > >  tools/lib/bpf/libbpf_internal.h | 48 -----------------------------
> > > >  tools/lib/bpf/linker.c          |  1 +
> > > >  tools/lib/bpf/netlink.c         |  1 +
> > > >  tools/lib/bpf/ringbuf.c         |  1 +
> > > >  9 files changed, 76 insertions(+), 49 deletions(-)
> > > >
> > >
> > > Nope, sorry, I don't think I want to do this for libbpf. This will
> > > just make Github synchronization trickier, and I don't really see a
> > > point.
> > >
> > > I'm totally fine with libperf making a copy of these helpers, though
> > > (this is not complicated or tricky code). I also don't think it will
> > > change much, so there is little risk of any sort of divergence.
> >
> > I did this because there were two comments on the previous version of
> > this patch that asked to change the functions that were copied over.  I
> > had a couple of choices, have the implementations diverge, not change
> > the implementation in perf to keep it the same as bpf, update both perf
> > and bpf, or share the implementations. I figured the last option was the
> > best to avoid immediate divergence. However, both of the comments can be
> > safely ignored, and also perhaps divergence doesn't matter.
> >
> 
> I mean, feel free to diverge. First and foremost the code has to make
> sense to specific library and specific use case. If libperf has some
> extra things that it needs to enforce or check, by all means. I just
> want to avoid unnecessary code sharing, given the code isn't tricky or
> complicated, but will complicate libbpf's sync story to Github (libbpf
> kind of lives in two places, kernel repo and Github repo).

Alright, I like to avoid copy-pasting code but if that's what is
required I will do that.

> 
> > - Charlie
> >
> > >
> > > [...]

