Return-Path: <bpf+bounces-78270-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AC37D06B98
	for <lists+bpf@lfdr.de>; Fri, 09 Jan 2026 02:19:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1A5343050881
	for <lists+bpf@lfdr.de>; Fri,  9 Jan 2026 01:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C8A6225785;
	Fri,  9 Jan 2026 01:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GTDkmTAM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B836C224B14
	for <bpf@vger.kernel.org>; Fri,  9 Jan 2026 01:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767921532; cv=none; b=hfe9pZTdFqDMvlqcVCd0amvC21lnBFsujVVnoxFPHoRAYJVE/ENZMse7OeGwvEgm5I+r+NgAvXLlFqGsfXDb9Et8vD7N4Bv6kz0wCXFRVFrItDOIMPAkbkFXxL5rL/1U52n/ZsRYiQotqLOLZ0/DGuDwN35lMBEolwOs8SVkcjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767921532; c=relaxed/simple;
	bh=g0vdoIEG2OU4E8eo0jjzj5lcSk57RdxT7F2CvW7p+bE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rn5d4WnxbmjwVCleiY3lrMJrOX0dEs1yz1FTC9qrWrcDXewVGlS9qQio3NI/bePDtghoj/7P9RdFxwHEt+lecXxbB+C85KwJMgvVEDVWzCA+eOFL/MG2J4oNEbiEMB19Dk5bwhNYrYU49huLLWzDPEuR4lw6tUbpFnqEbvbEjWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GTDkmTAM; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-34ccb7ad166so2219369a91.2
        for <bpf@vger.kernel.org>; Thu, 08 Jan 2026 17:18:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767921530; x=1768526330; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DEAZK03SYA4znD8D5b9ZzG8c4U0qtGIz66XPmDdEIE8=;
        b=GTDkmTAMMa2cm5nDSrr9Xo0rX+27ySiyovrSHDZnUEQxvPezK79HKtkN4oUJDjUm8J
         HmQmIlLxRom/+Pr3A2EG2gECtAJ975/kArWbxEmz/FAkizpjuqMXE24mh5WGyZQ3nbTP
         61iUjz+WvG3G6MZS5Id0XywHDX/W4oZ5WroY7yYzWwCYwikdKYYvEsJl4qKnQEICZZtn
         83ie9XQupd7F3jme3ZeOU9EQNu5wh+g8LN3C/ceeulOC52JVcvmf4ODxQscaQotr23Do
         gmdt7GgsTCdFfuCUavzbgtvJRdtPfYCSMkuurpkoECx0EeKgZEzzh357/MNzwpCH2V0J
         FyYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767921530; x=1768526330;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DEAZK03SYA4znD8D5b9ZzG8c4U0qtGIz66XPmDdEIE8=;
        b=bizzkls1tXNTlo+F77EOdGXnqk0PRoDUmtlsS5aXf63rEwySrZnHhcrHyUDf85iEha
         xqYtSWN5ABSCeOnhR2P+JYshSTTgS2ObLlyeIQoN1ieslcNcCm2TFgHRF7sr9Iazf3B+
         RM5pmMJjjq8/VAKSa6oBUHcS7XgrQ6srvXXfJqE8VdVcPyF0vlhG3c+YojZPm7LSazbJ
         N1ualCWsceMBnpBgo+z0Ay5VGH64aesKltLpsjUUz69abpKIEzqPxoCBQYvyKLgxMRkB
         9vpvcVIYVxoofFo61qu3FIb3rz8V53UpgbuDrB7PMs4CJBJKcA16XhhR2dHRszFwmsbG
         iN0Q==
X-Forwarded-Encrypted: i=1; AJvYcCUUG1Z6YY1w8dli6s+xy0Ors8m6PGgt+9rPQKtnnXsKlS9/8EBP1kV96B/5qeb3T87P1VU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGLstPZi66T1T3H46CsEtxDOOw5O5Q0iInn5tIpc5iDlxH/zFH
	Z4G8OkymxjMvG/rfLloE3pnYpyvIOK9CcgYIIB97tnjrVC4ncu61JQGaGrFUpswsRn6KKXI2cYO
	iC0jlxlTiY/1ldQ0BP2j3zyTYqogie2w=
X-Gm-Gg: AY/fxX6QoWff6npZBzXPByzU4Bh1GAuVkyevkeVqKRVVW7dY6akme0Z2COZsA+Nhbrr
	Tgr8QcG7JvVOD04lask+G2PDNw1LssR69yLKn9kdOWBrq4VRoyzTSYVCkxLehUUnyGIAkkFiRwJ
	6TgIJ72HXt8K+7HSGD3p02iI57gbrus6cXgqbillYbR8pa5G6CAaYzT0B0hN7nh+dDghV+cxY8r
	lHc0s33JpbceKwkV+UHBRsPpRZJhhhzGm30pVzZOp5rvVzRD2iDzema513RqvoPZCmGLKESRXSr
	E8IyPqzrU8E=
X-Google-Smtp-Source: AGHT+IEHxmq+YQ3NMAdNEJ42QnWdOffbXy8X/ceQXn0UXQk9xrKsrUeGfDgI5ui3yEP6BKUXjZc1cLSKFKs3WW6PM58=
X-Received: by 2002:a17:90b:4acb:b0:34a:8e4b:5b52 with SMTP id
 98e67ed59e1d1-34f68b4ce84mr7688524a91.8.1767921529916; Thu, 08 Jan 2026
 17:18:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260107-timer_nolock-v3-0-740d3ec3e5f9@meta.com>
 <20260107-timer_nolock-v3-4-740d3ec3e5f9@meta.com> <CAP01T77h5caT6EprhREYMNmjTkbBZ9-OT7HkxdnJUNNME2evQQ@mail.gmail.com>
 <e4eee776-e9c7-4186-b239-733f81a9ae4a@gmail.com>
In-Reply-To: <e4eee776-e9c7-4186-b239-733f81a9ae4a@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 8 Jan 2026 17:18:37 -0800
X-Gm-Features: AQt7F2oNUZZW_rrJr4HwpjH1EJDPKVIzBCMBauxO0QJ-ytkQvZOALXwo_dfrGTI
Message-ID: <CAEf4BzYY0s6yF8JACTENANzJXd6abZctiB1iP+jYARq_xPDm0A@mail.gmail.com>
Subject: Re: [PATCH RFC v3 04/10] bpf: Add lock-free cell for NMI-safe async operations
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org, ast@kernel.org, 
	andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
	eddyz87@gmail.com, Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 7, 2026 at 11:05=E2=80=AFAM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> On 1/7/26 18:30, Kumar Kartikeya Dwivedi wrote:
> > On Wed, 7 Jan 2026 at 18:49, Mykyta Yatsenko <mykyta.yatsenko5@gmail.co=
m> wrote:
> >> From: Mykyta Yatsenko <yatsenko@meta.com>
> >>
> >> Introduce mpmc_cell, a lock-free cell primitive designed to support
> >> concurrent writes to struct in NMI context (only one writer advances),
> >> allowing readers to consume consistent snapshot.
> >>
> >> Implementation details:
> >>   Double buffering allows writers run concurrently with readers (read
> >>   from one cell, write to another)
> >>
> >>   The implementation uses a sequence-number-based protocol to enable
> >>   exclusive writes.
> >>    * Bit 0 of seq indicates an active writer
> >>    * Bits 1+ form a generation counter
> >>    * (seq & 2) >> 1 selects the read cell, write cell is opposite
> >>    * Writers atomically set bit 0, write to the inactive cell, then
> >>      increment seq to publish
> >>    * Readers snapshot seq, read from the active cell, then validate
> >>      that seq hasn't changed
> >>
> >> mpmc_cell expects users to pre-allocate double buffers.
> >>
> >> Key properties:
> >>   * Writers never block (fail if lost the race to another writer)
> >>   * Readers never block writers (double buffering), but may require
> >>   retries if write updates the snapshot concurrently.
> >>
> >> This will be used by BPF timer and workqueue helpers to defer NMI-unsa=
fe
> >> operations (like hrtimer_start()) to irq_work effectively allowing BPF
> >> programs to initiate timers and workqueues from NMI context.
> >>
> >> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> >> ---
> > We already have a dual-versioned concurrency control primitive in the
> > kernel (seqcount_latch_t). I would just use that instead of
> > reinventing it here. I don't see much of a difference except writer
> > serialization, which can be done on top of it. If it was already
> > considered and discarded for some reason, please add that reason to
> > the commit message.
> yes, multiple concurrent  writers support would is the main difference
> between seqcount_latch_t and my implementation. I'll switch to
> seqcount_latch_t and external synchronization for writers.

One advantage of custom primitive is that we don't need a second
atomic counter for writers. Here we combine the reader latch counter
(it's just scaled 2x for custom implementation) and "writer is active"
bit (even/odd counter).

With potentially millions of timer activations per second for some
extreme cases, would performance be enough reason to have custom
"seqlock latch"? (I'm not sure myself, trying to get opinions)

> >>   [...]
> >>
>

