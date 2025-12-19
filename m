Return-Path: <bpf+bounces-77155-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 86121CD04E3
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 15:38:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A2D8930440D7
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 14:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADCC73246F4;
	Fri, 19 Dec 2025 14:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RjKkpD3R";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="mzdytlFU"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7672D2FCC0E
	for <bpf@vger.kernel.org>; Fri, 19 Dec 2025 14:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766154996; cv=none; b=FkGWWVP11saBfI/GiisLryzO6YHHzimBnUiDutqAybNKbsABiAvRQOB0e534K2lECI4MCTYomkrAOfjps6lvG7aMPkTlJOgOi8mSaFg+nBma2YssQIoOo2W40jmSo+rvpIsOQXSyDr6z9aehsS/skv01iTE0hCdkarc6aGWN6vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766154996; c=relaxed/simple;
	bh=HSFPB/bwkL8yxZYc5klNfsL7dvjnOX38Gvv8GtWH4y8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=R7AAf6NyaLf8To2eyi8kzU8JRw3Wgsh5X7nXhrfZE/Oq9QJNOyaitXpAI5lENNaNTcz+iOqwWK2w4jcfgDm0prKkHpugXScS2Wv5CbchI66tDx3t5QjHdW4cqAdgQLDbnI78i0PoGBe/u9O5xQlOvQGmR7XtYsWp8jn3GmYkdgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RjKkpD3R; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=mzdytlFU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766154993;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=HSFPB/bwkL8yxZYc5klNfsL7dvjnOX38Gvv8GtWH4y8=;
	b=RjKkpD3RXZsHSkmqATCeCNrRgEzjo0njIGXNtxQsF67g38C/YSugzP69ThVq5XZk7T5B/2
	6vt9TZnLdZRXMZdSzRuAaT/5US4+KHNTHpq3viVjJdJFuVQKUfLFgKIteGm1Ka6lGriTYB
	ujoR1pOFcFGZiinlbUPis3lUpicwTD0=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-220--p0d11w2OgaizL1ur8fLLQ-1; Fri, 19 Dec 2025 09:36:30 -0500
X-MC-Unique: -p0d11w2OgaizL1ur8fLLQ-1
X-Mimecast-MFC-AGG-ID: -p0d11w2OgaizL1ur8fLLQ_1766154990
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-29e6b269686so36187065ad.1
        for <bpf@vger.kernel.org>; Fri, 19 Dec 2025 06:36:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766154990; x=1766759790; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HSFPB/bwkL8yxZYc5klNfsL7dvjnOX38Gvv8GtWH4y8=;
        b=mzdytlFUdC/37s5JWCld6fcexuKbbyIHxDefKdWHqsK5Vju+kOSndN2a8uiDRQ+VDR
         BgnTzZdDQaovYjYNXebDRvKy2+8JgatQNhi1Wid9HP96n3NhNwWc96Ps/UFty+7AgN+t
         qqzR5eRhH2Q3vk6V7sq/Lb9gKPUOflYc72sXvD+KjtiuebpW3Z/FO5tDJcPbqcuLtE+c
         9fLmK5ERpcJAxsp/shEXXTaUE88w+LwiXNtwsLMkiuU1aM/mpoXON4qoGZkaT3JhnSMd
         nc01gK6d4kpBIOemfIeOHd24hluBolfsGu85IEc+2DAzuurJTLmXXMuNrXoONXqba3PI
         9NKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766154990; x=1766759790;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HSFPB/bwkL8yxZYc5klNfsL7dvjnOX38Gvv8GtWH4y8=;
        b=vx0wT+V/E7gptX1JrK/LBN/00kwTttuaDp1o0F/zWkjxlkCXh6MU0vFXPjWnow7sKm
         B6U4NQQ58sSBGtr5JbQtLxLG/Ows8Qt1PFCj3ePKD+h58XAZleWE9wy46hbq7a8d2UQh
         lqs5UAyaVIwRlzO+EvAuxZ8e0YIXqd8PCPw1lP0e3A0inusGV1NAg8h6rp862wQ45RAv
         CjcGqut0heZr3F8wQ/1Ky+gZCJveb+MivDWrb7xJxvjlUd4ZHqbtjgEE6/Ny5L8YzlkA
         6UlDt89K0pWDh7Q96ofwC+ZppTm7NwfAgNIxRewp54XmKJN8jFFip96OSeHmxoDmP0Yl
         cFoA==
X-Forwarded-Encrypted: i=1; AJvYcCWtM3FEe1rEn7dg30zx9HFDXU4V41wmw5zp9L/vSME0p4LVgcLEBnYBv8PgPCKRDxHjS4U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz28jSyPtS8YYRkg/ftxQO1AcmDyTrDCIMjxqCmB+NaW+ER3+fX
	TmGVv7FJvFfP3s7QBf/OHvFkVUr0MYEKK/496nNHiVzPRM5ityMfXCOEd7xxUERiYzS4YFMOkE9
	T8unPPjKzPmk//SEgHmo8HrhYCBazxymrzceYQVlusOzrSnf4Jd/GKAVMp91Tljtowk+wm2nvzy
	ryQHmAcScgqZ2EhuTceDK3pNfioSAd
X-Gm-Gg: AY/fxX43cHRNHFMvbxyhtSSyptWFdQpR+rTLdZcM+Zj/7g+jbM4x/3YaRAf8tdbB/3o
	a0m6Uu4vKWWFXdduI0pjkoIwAjeXmoNmOVXoYQ/BaQvZ7ihGvGeUT3/4DB9TTMmfqJPzfTrhz0Q
	8f4/g9kA06faiSzYBENZeds/UesM/YBgjuGCTBvCDe2oV7ZEBelmHGfzBYXmr9YUlK1Bmqmd19z
	NN4oTs=
X-Received: by 2002:a17:90a:e7c9:b0:34a:b8e0:dd64 with SMTP id 98e67ed59e1d1-34e92113546mr2602519a91.1.1766154989661;
        Fri, 19 Dec 2025 06:36:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH6XTI+e9miphOZJZOd+oGctJdHIYB919X0q9PI20jDC/DqiFfT4PXKX2g1KDxLKh2+5CLUbQqa1wiKc1MyUkg=
X-Received: by 2002:a17:90a:e7c9:b0:34a:b8e0:dd64 with SMTP id
 98e67ed59e1d1-34e92113546mr2602507a91.1.1766154989236; Fri, 19 Dec 2025
 06:36:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Jason Montleon <jmontleo@redhat.com>
Date: Fri, 19 Dec 2025 09:36:17 -0500
X-Gm-Features: AQt7F2pnE7QJEunHyj172HIMr_CoX0S3PPbHC3g7BOuigEeA0QrCgTUwLvZmr1E
Message-ID: <CAJD_bPKbZaEHmKzVcLPGJuR3Y3MO1AJDA0TmLZrLkCJ0PzCM1A@mail.gmail.com>
Subject: [REGRESSION] Cannot boot 6.19-rc1 on riscv64 with BPF enabled.
To: Linux regressions mailing list <regressions@lists.linux.dev>, menglong8.dong@gmail.com, ast@kernel.org
Cc: linux-riscv@lists.infradead.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

When booting riscv64 systems with BPF enabled using 6.19-rc1 the
system produces the following panic. I tried on several boards and
they resulted in the same error.

[ 5.380583] Insufficient stack space to handle exception!
[ 5.385986] Task stack: [0xffffffc600020000..0xffffffc600024000]
[ 5.392339] Overflow stack: [0xffffffd7fef7a070..0xffffffd7fef7b070]
[ 5.398693] CPU: 2 UID: 0 PID: 1 Comm: systemd Tainted: G W
6.19.0-rc1-00001-g74d9cab5b6c1 #15 NONE
[ 5.409302] Tainted: [W]=WARN
[ 5.412271] Hardware name: starfive StarFive VisionFive 2
v1.3B/StarFive VisionFive 2 v1.3B, BIOS 2024.10-rc3 10/01/2024
[ 5.423134] epc : copy_from_kernel_nofault_allowed+0xa/0x28
[ 5.428718] ra : copy_from_kernel_nofault+0x28/0x198
[ 5.433774] epc : ffffffff8024062a ra : ffffffff80240670 sp : ffffffc60001fff0
[ 5.440997] gp : ffffffff82464ce8 tp : 0000000000000000 t0 : ffffffff80024620
[ 5.448219] t1 : ffffffff8017c052 t2 : 0000000000000000 s0 : ffffffc600020030
[ 5.455442] s1 : ffffffd6c2198260 a0 : ffffffd6c2198260 a1 : 0000000000000008
[ 5.462664] a2 : 0000000000000008 a3 : 000000000000009d a4 : 0000000000000000
[ 5.469885] a5 : 0000000000000000 a6 : 0000000000000021 a7 : 0000000000000003
[ 5.477106] s2 : ffffffc600020070 s3 : 0000000000000008 s4 : 0000000000000000
[ 5.484327] s5 : ffffffc600020080 s6 : 0000000000000000 s7 : 0000000000038000
[ 5.491549] s8 : 0000000000008002 s9 : 0000000000380000 s10: ffffffc600023cf8
[ 5.498771] s11: ffffffd6c419bf00 t3 : 0000000077ab9db9 t4 : 00000000113918e7
[ 5.505993] t5 : ffffffff9e9bcc29 t6 : ffffffc600023ad4
[ 5.511304] status: 0000000200000120 badaddr: ffffffc60001fff0 cause:
000000000000000f
[ 5.519221] Kernel panic - not syncing: Kernel stack overflow
[ 5.524967] CPU: 2 UID: 0 PID: 1 Comm: systemd Tainted: G W
6.19.0-rc1-00001-g74d9cab5b6c1 #15 NONE
[ 5.535574] Tainted: [W]=WARN
[ 5.538544] Hardware name: starfive StarFive VisionFive 2
v1.3B/StarFive VisionFive 2 v1.3B, BIOS 2024.10-rc3 10/01/2024
[ 5.549408] Call Trace:
[ 5.551859] [<ffffffff8001e438>] dump_backtrace+0x28/0x38
[ 5.557262] [<ffffffff80002462>] show_stack+0x3a/0x50
[ 5.562317] [<ffffffff80016d02>] dump_stack_lvl+0x5a/0x80
[ 5.567720] [<ffffffff80016d40>] dump_stack+0x18/0x20
[ 5.572776] [<ffffffff80002b7a>] vpanic+0xf2/0x2d0
[ 5.577570] [<ffffffff80002d96>] panic+0x3e/0x48
[ 5.582191] [<ffffffff8001e110>] handle_bad_stack+0x98/0xc0
[ 5.587765] [<ffffffff80240670>] copy_from_kernel_nofault+0x28/0x198
[ 5.594122] SMP: stopping secondary CPUs
[ 5.598070] ---[ end Kernel panic - not syncing: Kernel stack overflow ]---

A bisect identified 47c9214dcb as the problematic commit:
[47c9214dcbea9043ac20441a285c7bb5486b8b2d] bpf: fix the usage of
BPF_TRAMP_F_SKIP_FRAME

This commit reverts cleanly and when building 6.19-rc1 without it I am
able to boot successfully.

A copy of the trace, bisect log, and config used to reproduce the
problem are at:
https://gist.github.com/jmontleon/b8b861352e7b9bc9fd3a93d391926dec

#regzbot introduced: 47c9214dcb

Thank you,
Jason Montleon


