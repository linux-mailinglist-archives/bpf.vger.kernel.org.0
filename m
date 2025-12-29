Return-Path: <bpf+bounces-77473-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3906FCE7B65
	for <lists+bpf@lfdr.de>; Mon, 29 Dec 2025 18:14:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 58D42301A1D6
	for <lists+bpf@lfdr.de>; Mon, 29 Dec 2025 17:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3036D330B22;
	Mon, 29 Dec 2025 17:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GIqSjaYO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C97631D726
	for <bpf@vger.kernel.org>; Mon, 29 Dec 2025 17:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767028446; cv=none; b=irSRJHW1b451KYmkcMqda2KzEEMc49YkwAnzkwCgzRGcG2wdC79H3IG/6iyonI51YxTFotrzUylT7J0LZvdBUzv97b5Yug8tl84aTPzPm8OTKwUR9ZouKfeZQvf3/CZXN7q3oqT/wgj0P+9wD6eCFTw9b0vaODtMibUJT23VphQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767028446; c=relaxed/simple;
	bh=rPHsj2oVdQZJmJLJWmWO3toMXK9yiLTRStaMVd6JXbQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o0odx+uqQNsgsHYNpmhKRHVM3fnzzahNh+zntT7g+NGPKhKhhbGcs4aRQLu493UUlZVLO0J/e2XmkwN+BUBH7jk6yKWrTmUJXEJN/5NOQHfl1IAXlndJhVJ/SIUnZJ1Rf98DsClXlIKyMMKqqgLqyQZ60MaoR3ttOaIXLZ1uW3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GIqSjaYO; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-ba599137cf8so3026821a12.0
        for <bpf@vger.kernel.org>; Mon, 29 Dec 2025 09:14:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767028444; x=1767633244; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nq0hy4ZDbyOAkYMZ9R2bJ77qMoSVUcBr/BQKEBLGcD4=;
        b=GIqSjaYO1LPsrpNx+MJUWdouSiwqq1TK0fcFqnIsRtvuZ12XgO8SfwBzriE3wgzLPo
         e0ZYaemf16rLUaOC0HTYWCUD93l/g1Yga21wt6aElb8a0HEjxa3B5pdig/nopRdz4BeJ
         pRZszj0yS9okHYU9ToggSWm8ewt+VW9d1ifHEWILEMtatcQCB+tR4VYF3uM52MJ4jgQb
         i571ihJiXIx0VgN7OrSQpdRDe+4sUxTPo1AmT4Ls4ttzRXTBb712R2q/EEzQ5HGDqbpn
         bUsoEPvxsbOczHl+Q9cfKuED+iW8LWMbNnSixSv+viCwXtPdiMEphoUSAjbtZtDYlIQe
         uVVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767028444; x=1767633244;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nq0hy4ZDbyOAkYMZ9R2bJ77qMoSVUcBr/BQKEBLGcD4=;
        b=L68OKQoGZYhACHrEFV2dh8AU2x341Dh2YmdbNZRYRF5QyI7wCnuLx9tgCezrQalDC8
         j3Xa5MoiqES9Yv2NX0r9sNfGTGdkKqskav3ziYYIMK9m4V2jw+GWElZqotMdWxk5Tm6W
         DQU//3+aTC93ZzOqufjDgSlD6/GN3KcBO2XHGcQPOmQhVtFHiBzvYOP/fz496+A1wvDP
         GJpILG2FcY+T6oP5kDbByKI0LhbZ0cOnHa5zmjAO8fP6dj0DJT5tdotjY2/b1zgyqugz
         Gl2LZ9yq0zPxEFN0MoKxmmU8oSIadaQ+Uxh4jMAQrUdm7FPom2uT969FtIPxx5vJO+oi
         u8Uw==
X-Forwarded-Encrypted: i=1; AJvYcCXzgs45NJdF7F0nB+f0SsDgBukf/OsgPNas8JF7v13K7rll8rZJZDMJQw/28QKLSnyLN60=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywfdd1XA44ppfwK2FocPptD4Q50UfTZnJ9/7zAH9/Q5kGdnQ/Xn
	jr3DEzOsrHYxTwKHnFcvsgTE1fCWnMWscdK0CgLHPz/H5MLkkSDLRl2h
X-Gm-Gg: AY/fxX57TTGK1zF7q7tNZvNN88wOG6ruRYa5AA/5pnG68sXV/3v3kXDMhtZZuAcVuDj
	cQxnbbjS1mTrTZi/EEgPDXq4fk3yBXcxwZOEYJ4d4wBPxQpDN4HOIv1KlkPiLOquNqeL0clCG7B
	k4e/zM5CBrAETM1NQ2MY3qOQgAwzao7yzYwEB3iddQMl3MIpKZkbe3jPbuYUp/48Yg/Byf3BC20
	NT6FDyG4vT/MGeFEvDYxh9+THeBDb4kok7PoFDF8HHRVx8S5+PGnPQWNq7CAB3xzLnPrU1RKssl
	LaqPNgX7gzu8kM9a2mHU1WZvqghNdXXSrP2YD9aVm1O8OWf2W3Wc7UNcFRbNp8AY14wkmMFZURn
	enL0jv2LvyGA4THazF8oPOTw1kP4wa4GGqB4sZid0CbILK+b32ub8TZUccntfl571DBNV1gDcAK
	BdQ1Q/PDovlOGk0A9isIhQDLExb/QHckVva+FpURV//OQjKiieIA30X3KaRiIoig==
X-Google-Smtp-Source: AGHT+IG4eXbFG3XgvqZI1V+B2x2P42ZmXTkV7Dp/LoGqVFuSVOvFy0fGaXCjk1bAi09n8KFPykhhkg==
X-Received: by 2002:a17:90b:2e4a:b0:34c:9cec:3898 with SMTP id 98e67ed59e1d1-34e71e29544mr29378809a91.13.1767028444325;
        Mon, 29 Dec 2025 09:14:04 -0800 (PST)
Received: from kailas.hsd1.or.comcast.net ([2601:1c2:982:6040::e14d])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34e76ae7618sm16105280a91.1.2025.12.29.09.14.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Dec 2025 09:14:03 -0800 (PST)
From: Ryan Foster <foster.ryan.r@gmail.com>
To: bboscaccy@linux.microsoft.com
Cc: James.Bottomley@hansenpartnership.com,
	akpm@linux-foundation.org,
	bpf@vger.kernel.org,
	corbet@lwn.net,
	dhowells@redhat.com,
	foster.ryan.r@gmail.com,
	gnoack@google.com,
	jmorris@namei.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux@treblig.org,
	mic@digikod.net,
	paul@paul-moore.com,
	serge@hallyn.com
Subject: Re: [RFC 00/11] Reintroduce Hornet LSM
Date: Mon, 29 Dec 2025 09:12:48 -0800
Message-ID: <20251229171402.1491979-1-foster.ryan.r@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <87v7i4hpi4.fsf@microsoft.com>
References: <87v7i4hpi4.fsf@microsoft.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

I am considering how to reconcile the TOCTOU concern with the "don't touch BPF internals" feedback, I think a very small API might help:

Minimal API draft: BPF integrity measurement

Goal: kernel-generated measurement of the final relocated program + declared inputs, so attach/link can be enforced without poking internals.

1) New BPF cmd
- BPF_MEASURE_PROG (or BPF_PROG_MEASURE)
- Input: prog_fd
- Output: opaque measurement blob + metadata

struct bpf_prog_measure_opts {
        __u32 size;
        __u32 flags;
        __u32 sig_len;
        __u64 sig_ptr;
        __u64 prog_id;
        __u64 meas_id;
};

Semantics
- Kernel computes measurement over final relocated insns + inputs explicitly in the integrity contract (e.g., sealed maps).
- Measurement is kernel-owned and stable for a program state.

2) Per-prog integrity state

enum lsm_integrity_verdict {
        LSM_INT_VERDICT_UNSIGNED,
        LSM_INT_VERDICT_PARTIAL,
        LSM_INT_VERDICT_OK,
        LSM_INT_VERDICT_BADSIG,
};

struct bpf_prog_integrity {
        __u64 meas_id;
        enum lsm_integrity_verdict v;
};

- Attach/link allowed only if policy verdict passes.
- Any input mutation invalidates meas_id and resets verdict.

3) Input immutability
- Only sealed/frozen maps can be measured.
- Any write to a measured map invalidates the measurement.

4) LSM integration
- Hornet (or another integrity LSM) consumes the measurement blob, verifies signatures, stores verdict.
- SELinux/IPE/BPF LSMs can gate attach/link based on verdict.

Why this helps
- TOCTOU: verification tied to final relocated program + frozen inputs; mutations invalidate.
- No BPF internals: LSMs use a stable syscall API, not map internals.
- Minimal blast radius: one syscall + small per-prog state.

A thought for future iterations, happy to help refine if this seems useful.

Thanks,
Ryan

