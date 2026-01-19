Return-Path: <bpf+bounces-79508-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D8E8D3B7AF
	for <lists+bpf@lfdr.de>; Mon, 19 Jan 2026 20:54:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 99607300B365
	for <lists+bpf@lfdr.de>; Mon, 19 Jan 2026 19:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5873421ABC1;
	Mon, 19 Jan 2026 19:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="IvGhHEDq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745C32DB791
	for <bpf@vger.kernel.org>; Mon, 19 Jan 2026 19:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768852439; cv=none; b=fVsFWeIokSlzNaZbZm8wqd7t3k2Z1OIGXDcLEtssSr3WnlyJvLeNMrFWsXsjfbmSt5N8nWAH/QVlXbmd48FwO919GMYRbBiSLaV/SCM/oo28Uglzm45RfTHDHh/yx4LnN9uaQBfGjCVPlAsFbhsKYmPaF1+tkvDZ8siUZ/EO0hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768852439; c=relaxed/simple;
	bh=90QMWnjCg4N0niL+RNXlsTEjnabJWT8FcDlgDnSm+Rk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=u+nGQbOIaS+BtlEmyfEOgMK9Rhe6yjqeetMIT8Tzrx6b3acX6tKSwHlZMc6hyEvuv87+YZP8bGJpXEiO62pj+tOjaqFix/1D3XbASxJG8PAlH5aix2Vh97Vnj9Zvqi3xmBTQzm9Q6czHvvdaN79birEvQAaIIFSDKM9bhmCe7bE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=IvGhHEDq; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b872cf905d3so766454066b.2
        for <bpf@vger.kernel.org>; Mon, 19 Jan 2026 11:53:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1768852436; x=1769457236; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HGl2ih0bFcK2HkHqlgtrfAO45PgnsB0zF3nmRHfuZNo=;
        b=IvGhHEDqd61MVjuwsISaO2md8KuMFiN1SP+/5r8P9Hs1iPHEkkH5aSHJFzXSrQBmSj
         /eR2Uv9W1I0MO1g32GP04H9HsvOnSkdHmr4Wm9qB5DD2ijzPq2+ju3D9gxPmDEzT4zId
         4X2hJfDuMty7a2pqBryuFN0OTV6ayl2dQqg7V56aCVDhGaRobma18QhnKvzfCXRfvgR0
         +Sn0m5Y/66G04TbQh8bkOouT2MMiusFLtLhqgDmOZ9ZeLuAlQ2UuooOsvxDU/R6nrU0d
         kwmAWVG9aTr2tSLX1thnHJNEsDdfzdG8S6doeadNZNi15pN+YSxzRPWz2AdSwxR6IHzh
         MRmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768852436; x=1769457236;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HGl2ih0bFcK2HkHqlgtrfAO45PgnsB0zF3nmRHfuZNo=;
        b=Acn1uF17xLBRusEhoCosGcoz4bo2lhmZma+vGzpYNHH7UorFcA8aRGk3P9TNOL9GaD
         Dw3VJ43daoVJXCQgRjyNtOrFl9IaQtjHfAO/gmyRt9QOdWUsHfkakBkBOLX38fI8HdRN
         gV9WlYu9vt9tINNQnKmfgJqwW8+kOQ957XndFmgP6WjoPiOPoNyTrblReNlXaGcMu1af
         0lhuc2gKF1TGoABiGcNffz/7BBnP4pbrIZPCBWWXfmyLAcZqoA2wxMN2+95Yjs9stO6L
         gpyloWkbmKYu/RWFXRRas59Nx8zuCVNSel9SL1UwwumqoJv1/tW67RqWLNUhOI4V1Tok
         7sQw==
X-Gm-Message-State: AOJu0YxcEhquq2TFVIJzKOZfn9Dxyc92GfkYU2Ar8icPDw8H1eOxN4GG
	Aq1h3WD1AjpgaLj9QJpalb22/fmuNQqWQcl0yQcfTD7rhQS0hEe2BLgv2/234x+Ur70=
X-Gm-Gg: AZuq6aKp6cCJdbMsOuLk8e7LZdsL2MHTxJBhWMTDiIIbuc1R16s0zKX1apxcqnaYrlc
	m0jaNl8BOLf92nU/XtfoDuO4LDkC9yBOQZScCZwT0BmZeNHTLQwcmdGeW+UBGkGN96WM+veF9g3
	YkzhVMg2V5VcR8JPRpQHW4lcmMVDObAlCaC3FtIGJk6PsIwm7Pr3dOUFOwAJo5UiHUaGQS50zDF
	XAtoPfrG6dcQx2PrHy5mHnqV8vx7gSLbfl0SMBiCtEuqM4xAZptTWQUT8zsHgHgNaj2wz1g8u/w
	ITSofoeEazAYYsH+SxFI7rPZ/S1bjmDaMOHyS1KMw7adewmPAT5J1U1p4VYGCZDu2j+1gyRcQ4S
	cmaWuRE7obOs8VGrMM+WUFBS/9pVia1jsE9iKsZSsa57GbXU8/P6LXQ81WcrJ5iluO2xt7Puom6
	B98uwRU2ixj409zJZ1pjDkaaVM9/EGzZRklOBnOEEIa0WLN+EcdhPZ+5dKQYI=
X-Received: by 2002:a17:907:d03:b0:b87:892:f43f with SMTP id a640c23a62f3a-b87969386d0mr1039368166b.29.1768852435761;
        Mon, 19 Jan 2026 11:53:55 -0800 (PST)
Received: from cloudflare.com (79.184.207.118.ipv4.supernova.orange.pl. [79.184.207.118])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b87959fbefdsm1165986966b.55.2026.01.19.11.53.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 11:53:55 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
Subject: [PATCH bpf-next 0/4] Switch from kfuncs to direct helper calls in
 prologue/epilogue
Date: Mon, 19 Jan 2026 20:53:50 +0100
Message-Id: <20260119-skb-meta-bpf-emit-call-from-prologue-v1-0-e8b88d6430d8@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAM6LbmkC/x2NywrCMBAAf6Xs2YUmgkZ/RTyk6aYu5sUmlULpv
 xs9zmFmdqgkTBXuww5CH66cUwd1GsC9bFoIee4MetSXUSmN9T1hpGZxKh4pckNnQ0AvOWKRHPK
 yEs7a3Yw6e2OuFnqqCHne/psH/MREW4PncXwB963tXIAAAAA=
X-Change-ID: 20260112-skb-meta-bpf-emit-call-from-prologue-d2c9813f887a
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Amery Hung <ameryhung@gmail.com>, 
 netdev@vger.kernel.org, kernel-team@cloudflare.com
X-Mailer: b4 0.15-dev-07fe9

This series enables direct helper calls using BPF_EMIT_CALL from prologue
and epilogue code generated by verifier ops. The goal is to simplify the
calling convention and remove kfunc support from prologue/epilogue, as
suggested by Alexei [1].

Patch 1 adds the infrastructure to mark direct helper calls as finalized
(already resolved) so the verifier skips the imm fixup.

Patch 2 converts bpf_qdisc to use BPF_EMIT_CALL instead of BPF_CALL_KFUNC
for the init prologue and reset/destroy epilogue helpers.

Patch 3 removes the now-unused kfunc support code from prologue/epilogue
handling in the verifier.

Patch 4 removes the corresponding selftests that exercised kfuncs in
prologue/epilogue.

[1] https://lore.kernel.org/bpf/CAADnVQJ=kmVAZsgkG9P2nEBTUG3E4PrDG=Yz8tfeFysH4ZBqVw@mail.gmail.com/

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
Jakub Sitnicki (4):
      bpf, verifier: Support direct helper calls from prologue/epilogue
      bpf: net_sched: Use direct helper calls instead of kfuncs in pro/epilogue
      bpf: Remove kfunc support in prologue and epilogue
      selftests/bpf: Remove tests for prologue/epilogue with kfuncs

 include/linux/bpf_verifier.h                       |  1 +
 kernel/bpf/verifier.c                              | 47 +++++------
 net/core/filter.c                                  |  3 +-
 net/sched/bpf_qdisc.c                              | 76 ++++++++----------
 .../selftests/bpf/prog_tests/pro_epilogue.c        |  2 -
 .../selftests/bpf/progs/pro_epilogue_with_kfunc.c  | 88 ---------------------
 .../testing/selftests/bpf/test_kmods/bpf_testmod.c | 92 ----------------------
 7 files changed, 61 insertions(+), 248 deletions(-)


