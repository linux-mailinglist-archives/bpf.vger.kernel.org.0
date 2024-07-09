Return-Path: <bpf+bounces-34220-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37C3192B496
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 12:01:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD0C7284BA4
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 10:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A19215623B;
	Tue,  9 Jul 2024 10:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lH1HdJCR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6467813C8E5;
	Tue,  9 Jul 2024 10:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720519269; cv=none; b=CnmcPvxr5dE2oxAXWIKYlygNGpVFANgxCvwXYvvFGa6d8ZXqyDrZ+G9LIzhg7Qtk9A7jbeL3KBtgTmX2E966RWCSyn6OGGQgW9TweGM0oFHaiVio8Ne8D/FrfxBLJIO4N2Voa6/4Ke2Qyd/qFx26p84d/kBphnGRJyBiYYUtLlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720519269; c=relaxed/simple;
	bh=YXEKDrHx7xU7GSPly2qCLsA3q7mmRiQWaxxv09opKo8=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gMcvL5h7bl7ORnjBxvia1qeuXql7lM5nZ53LS7E6pFWURq8M3G4VQtX/uaHtRn2/yNCrv4LjBth2ASFGK6XzGtG+NunRJlsVEPsuznHFypYhxWnEQiDSMWL3W2/mJJfPOF2P5qOcp8pf3yv+UmOACn2DXqR0ueIYH0X/hhiNZbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lH1HdJCR; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a77c0b42a8fso710904066b.1;
        Tue, 09 Jul 2024 03:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720519267; x=1721124067; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cesQpqTyuCsvlvVlu0V81EvNragai1Z9EpcRXpHE97A=;
        b=lH1HdJCROQeO6VZV4DgGdk06ky381v9w4GhMR2N1/PAsoejeopnZVrrMK2RjG6m6tg
         TW6tlU84kIe15DQii/OUn5u8MgVE63ApZU/KGwsapFmEL15THXl1OCeM3Ym9tMaFeKtg
         feFOo/Q9Rbi3J4CkzMp3/0bIqCHOwgcOVlkdYb5hRbqXGTUhCqtKUdJ4dw4A4ztqKU8A
         2HH9RkoEaJLxf1qwB61Xihi769dlge18wwE14Uyq4fEIbkOMpQwhhWJ3TjQo5dpF5Q8S
         lBGkKkstZZ4UkZPUrzFsdrYCCzFBELF+uex8tr37A2IWAXsSpDDMwvIOxbCj1Tgyo37L
         GARA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720519267; x=1721124067;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cesQpqTyuCsvlvVlu0V81EvNragai1Z9EpcRXpHE97A=;
        b=cZEkpcw7kfUIKKkUtux94FuD1ArzQsBewnvmCWNJehhrvRs7zLd4HS7TEL87e6W5sC
         d06ioWJgECah4ukHsco4lwz46Rj34Q2RE2qoGolZDyuYyONkpAIW9YiBVsZzAgcejUpS
         QFtFREErmaDcnoZW9agCeDHsTNRLdp9OFDHZiTdDU1MuwNI4AESUKd4Ye766YxBfXmTG
         W44nlpUdRM/LYe8COhGkw23MgPyoDSVuI0gZ0vbVYeuNAwmSFfhgeAomwpL5WrqdG+rO
         bcMaSHlbqw3a1iiQxoF6Xw413avpxrzMHH0DAiQIgkGeapzwB2LobcNKPXVW6TOcKYG3
         2kfA==
X-Forwarded-Encrypted: i=1; AJvYcCU160y4ZmcQCknGfBGslWBV6AAUatQGZNQSobF+gc5h11Zltup6NQZtRsQHv4BzgUUKW1UqjBhElKoo/dugrJ0+EtgGLtrXrUoy2y9cJ9O8pXktRB8y6ZaBT2JrDw3cu8qA
X-Gm-Message-State: AOJu0YwUz+XZqFCxGb0GQfw6lN3EnFWa8Xgha8rbE5eqebXstcucb26b
	pu3SKpLOhshR+kTftP6SJ9WaOCpqFip65dKMVaFNyZU+DR4T0GoW
X-Google-Smtp-Source: AGHT+IGqolitkJi7LU77VU4RtQ2pZKdfOwoNB5MgkaNN9UGCZTwxQvk4CI7P+sWki44gweKV+4nvuA==
X-Received: by 2002:a17:906:c103:b0:a72:7a71:7f4f with SMTP id a640c23a62f3a-a780d20ea49mr185628866b.7.1720519266511;
        Tue, 09 Jul 2024 03:01:06 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a780a72fd39sm64567266b.91.2024.07.09.03.01.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 03:01:06 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 9 Jul 2024 12:01:03 +0200
To: Peter Zijlstra <peterz@infradead.org>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Masami Hiramatsu <mhiramat@kernel.org>, mingo@kernel.org,
	andrii@kernel.org, linux-kernel@vger.kernel.org,
	rostedt@goodmis.org, oleg@redhat.com, clm@meta.com,
	paulmck@kernel.org, bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH 00/10] perf/uprobe: Optimize uprobes
Message-ID: <Zo0KX1P8L3Yt4Z8j@krava>
References: <20240708091241.544262971@infradead.org>
 <20240709075651.122204f1358f9f78d1e64b62@kernel.org>
 <CAEf4BzY6tXrDGkW6mkxCY551pZa1G+Sgxeuex==nvHUEp9ynpg@mail.gmail.com>
 <20240709090304.GG27299@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240709090304.GG27299@noisy.programming.kicks-ass.net>

On Tue, Jul 09, 2024 at 11:03:04AM +0200, Peter Zijlstra wrote:
> On Mon, Jul 08, 2024 at 05:25:14PM -0700, Andrii Nakryiko wrote:
> 
> > Ramping this up to 16 threads shows that mmap_rwsem is getting more
> > costly, up to 45% of CPU. SRCU is also growing a bit slower to 19% of
> > CPU. Is this expected? (I'm not familiar with the implementation
> > details)
> 
> SRCU getting more expensive is a bit unexpected, it's just a per-cpu
> inc/dec and a full barrier.
> 
> > P.S. Would you be able to rebase your patches on top of latest
> > probes/for-next, which include Jiri's sys_uretprobe changes. Right now
> > uretprobe benchmarks are quite unrepresentative because of that.
> 
> What branch is that? kernel/events/ stuff usually goes through tip, no?

it went through the trace tree:

https://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git probes/for-next

and it's in linux-next/master already

jirka

