Return-Path: <bpf+bounces-44326-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 765359C15E5
	for <lists+bpf@lfdr.de>; Fri,  8 Nov 2024 06:08:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 040831F240BC
	for <lists+bpf@lfdr.de>; Fri,  8 Nov 2024 05:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70F9F19C571;
	Fri,  8 Nov 2024 05:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bQQNgBLc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BBD380C0C
	for <bpf@vger.kernel.org>; Fri,  8 Nov 2024 05:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731042529; cv=none; b=Vft9f11fFIptb0AkArCq+Ki+1gjkolYFLqs0I5l7RaUmeEzlTJy09E4g7ZXjyWSr4MBpqvCu6EhUiDWDYUXyz5yIfm3FM+Xe4wTHLF0cUeVfzp8AE2LnwBwDn+Drdfvtklcyzu/sM4klqYqpk2a0OXadkfVs7fm+SgX0PguYqUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731042529; c=relaxed/simple;
	bh=hiz4+zWQg8Zx5coolNOrjvJKJg3k7ueqhcblOR5TEt8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mfKGSMx8u40Vit2sYc/3pJtrr3o2bKRO+OpfCk6Ogwin87JgKdQzA+AnT1hsuLTSLZlM39x6ENxH3PLwgtnG97xfmJt6ZyD6kcbcPN0NX1MhHDqtJJtUT7pUwn2QddiGbChSpmNs8FMN2NmeFYi5HlR4KcVppB+Vch6HW+mrl0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bQQNgBLc; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-72410cc7be9so863272b3a.0
        for <bpf@vger.kernel.org>; Thu, 07 Nov 2024 21:08:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731042527; x=1731647327; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1L7J3GDHTrpmMb0JBTHsObdW9FrIBtfJGApc+ISoATc=;
        b=bQQNgBLccJ6PbynePqgbVv4ZF9kgIsobIDdwISM+bdrSYjaiDUgUAWkaUUI1Z17/OW
         9KAlk7yLSA8Z0ayup2r2B+ttFjaEy7cFuDo6DpMe61GnYnn3viCP15Z6wb3F5/7ZKq5n
         dfmJlz3eAr4heVx4knEu8bf3SJConjcTXwr4DL9GwhVCvFBcMQpjsZ1Kz+2gaAG9KyF1
         iEK4hJ2+Ff+aM39Iqo553maPQ8VCRPSRbG3jerdEfKRURbwKquItqVjKJLQU+1Czhoon
         u7Nn/D9XybBfC5Hc7mscWs+XW0LAFptb54DDNfjFBFzRAULKoma8LcZOAA+FQ5Nc+LVY
         w1Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731042527; x=1731647327;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1L7J3GDHTrpmMb0JBTHsObdW9FrIBtfJGApc+ISoATc=;
        b=cl4o86TMmJ3lAAE3alzYkjdS0QgE7m7y2fTQiOl4S136wPvYhaCvpxyCCOWrj4jRac
         qVdWiDfNRTET/sQ073M3jaF3ScH1+yUBz3ZN92xnrznTtwLCALNX73TfdZ/uJl8LVex4
         PzQ9SKpq/gn9S6wTU4xusHPxQSShObHjuxS1UQAYQQ129aOvO91SEFoRlx6LG/dhyHrd
         twuODel7/0ZNREhqMwLwPMsFrwSN4VLZLH8BTQJLn6nVES/d1cm7QYyw6iI1EhgpLBzb
         zm/CGHpepE/0qA8EsZ/m6Oy/4zUJX4x/xkjFdsPcdAQ0GEv0iBBqfK6jt8W/ioYH29dx
         8OPw==
X-Forwarded-Encrypted: i=1; AJvYcCXK911TZ4QewP11wvW6R/9OuIITb4ySaJlDjNsGBsUFHATBFp8LlX+vMwE0C1npqiLDIrY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrS+YP+GkqTj4K9L+HZ1nbF771UnspW8xNEDrLVd0ep07NlcVu
	c0/sILibazOR5L0b7JuUG+HnWkNXh/bMLdDaTH8ooI1jNp249dxA
X-Google-Smtp-Source: AGHT+IEJeMnqtsEXcdpPzqXzHKDERMWJ0YounVp/zCuKsN8VMbZKVKWUJ9eI0F+lDIYe0vZFAQn6vg==
X-Received: by 2002:a05:6a00:1488:b0:71e:6ef2:6c11 with SMTP id d2e1a72fcca58-72413286757mr2348344b3a.9.1731042526648;
        Thu, 07 Nov 2024 21:08:46 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7240799bacbsm2756714b3a.108.2024.11.07.21.08.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 21:08:45 -0800 (PST)
Message-ID: <df84c4c41d3fa9cbc43738ad226bc9efc5fa495c.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 0/2] Handle possible NULL trusted raw_tp
 arguments
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Puranjay Mohan
	 <puranjay@kernel.org>, Yonghong Song <yonghong.song@linux.dev>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf <bpf@vger.kernel.org>, 
	kkd@meta.com, Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
	 <andrii@kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>, Song Liu
	 <song@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Jiri Olsa
	 <olsajiri@gmail.com>, Juri Lelli <juri.lelli@redhat.com>, Kernel Team
	 <kernel-team@fb.com>
Date: Thu, 07 Nov 2024 21:08:41 -0800
In-Reply-To: <57dfdda6a89819b65be8960c3c6953bb9b8ceed3.camel@gmail.com>
References: <20241101000017.3424165-1-memxor@gmail.com>
	 <CAP01T75OUeE8E-Lw9df84dm8ag2YmHW619f1DmPSVZ5_O89+Bg@mail.gmail.com>
	 <c3f7ee7790c6f53a572ff2857433f534f4972189.camel@gmail.com>
	 <CAADnVQLZ9oj4+en43UZVOOLNHfHGq2aEcR9pYwLKLeMh1rJN-w@mail.gmail.com>
	 <57dfdda6a89819b65be8960c3c6953bb9b8ceed3.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-11-01 at 17:32 -0700, Eduard Zingerman wrote:
> On Fri, 2024-11-01 at 17:29 -0700, Alexei Starovoitov wrote:
>
> [...]
>
> > Hmm.
> > Puranjay touched it last with extra logic.
> >
> > And before that David Vernet tried to address flakiness
> > in commit 4a54de65964d.
> > Yonghong also noticed lockups in paravirt
> > and added workaround 7015843afc.
> >
> > Your additional timeout/workaround makes sense to me,
> > but would be good to bisect whether Puranjay's change caused it.
>
> I'll debug what's going on some time later today or on Sat.

I finally had time to investigate this a bit.
First, here is how to trigger lockup:

  t1=3Dsend_signal/send_signal_perf_thread_remote; \
  t2=3Dsend_signal/send_signal_nmi_thread_remote; \
  for i in $(seq 1 100); do ./test_progs -t $t1,$t2; done

Must be both tests for whatever reason.
The failing test is 'send_signal_nmi_thread_remote'.

The test is organized as parent and child processes communicating
various events to each other. The intended sequence of events:
- child:
  - install SIGUSR1 handler
  - notify parent
  - wait for parent
- parent:
  - open PERF_COUNT_SW_CPU_CLOCK event
  - attach BPF program to the event
  - notify child
  - enter busy loop for 10^8 iterations
  - wait for child
- BPF program:
  - send SIGUSR1 to child
- child:
  - poll for SIGUSR1 in a busy loop
  - notify parent
- parent:
  - check value communicated by child,
    terminate test.

The lockup happens because on every other test run perf event is not
triggered, child does not receive SIGUSR1 and thus both parent and
child are stuck.

For 'send_signal_nmi_thread_remote' perf event is defined as:

	struct perf_event_attr attr =3D {
		.sample_period =3D 1,
		.type =3D PERF_TYPE_HARDWARE,
		.config =3D PERF_COUNT_HW_CPU_CYCLES,
	};

And is opened for parent process pid.

Apparently, the perf event is not always triggered between lines
send_signal.c:165-180. And at line 180 parent enters system call,
so cpu cycles stop ticking for 'parent', thus if perf event
had not been triggered already it won't be triggered at all
(as far as I understand).

Applying same fix as Yonghong did in 7015843afc is sufficient to
reliably trigger perf event:

--- a/tools/testing/selftests/bpf/prog_tests/send_signal.c
+++ b/tools/testing/selftests/bpf/prog_tests/send_signal.c
@@ -223,7 +223,8 @@ static void test_send_signal_perf(bool signal_thread, b=
ool remote)
 static void test_send_signal_nmi(bool signal_thread, bool remote)
 {
        struct perf_event_attr attr =3D {
-               .sample_period =3D 1,
+               .freq =3D 1,
+               .sample_freq =3D 1000,
                .type =3D PERF_TYPE_HARDWARE,
                .config =3D PERF_COUNT_HW_CPU_CYCLES,
        };

But I don't understand why.
As far as I can figure from kernel source code,
sample_period is measured in nanoseconds (is it?),
so busy loop at send_signal.c:174-175 should run long enough for perf
event to be triggered before.

Can someone with understanding of how perf event work explain why
above change helps?


