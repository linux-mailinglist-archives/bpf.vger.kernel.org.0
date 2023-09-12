Return-Path: <bpf+bounces-9811-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2637F79DC21
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 00:47:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9790282068
	for <lists+bpf@lfdr.de>; Tue, 12 Sep 2023 22:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE5CABA4D;
	Tue, 12 Sep 2023 22:46:58 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C45361;
	Tue, 12 Sep 2023 22:46:58 +0000 (UTC)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B77D710EF;
	Tue, 12 Sep 2023 15:46:57 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-401187f8071so2136825e9.0;
        Tue, 12 Sep 2023 15:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694558816; x=1695163616; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5maphRaiJtxCw6vGqmBPcygT14ffJWcXjb1lb6GupVY=;
        b=bHBFpxYObCOAeTwyTuOAKTUJ/BJov0F1mEVMfUw3Lgicx5DLBY6N2hBJp/RVoWoY4t
         4/W4yGQKj38C1e9OyIyPD+aXYOqY7Npi+EOIbN4eEAlbcftfKatpymhSrrbd5nWU2pGY
         QgHx9t/FVU2jZv+hr4YO0oN4GjNvGoq2+i1S2NkXfd2q56BShrnn2hM80PziugCiyiCz
         oP7dxauNEDgjuviAJdrd2FCUI8x7yGzBMdyt3XC7zJHXcMbAr9tgfqli8dFOzNCetX60
         rXoai5tFj6TDQDdgCecEQ2oJ8UIPmvQ3yXfwmhe/jt1u69qOe8a2pP21AJtg3H+NpHaK
         hTCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694558816; x=1695163616;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5maphRaiJtxCw6vGqmBPcygT14ffJWcXjb1lb6GupVY=;
        b=iLxw3WWGdZE0ITAtrNDjzYWrpkg5XUD2iBAbqcjTlsr12WUkEj8+61h5W6o2odw/ST
         2asDP3P2eQpc+49c9zZIvKKISqzXbjOQITckqks3h5CuMtYN+q+bGj2tRcEE5V42YQeT
         u1WhUmNN+W1WuSZzZ7LhodWfYvlyQGceVgWtKMs0ETd/DpSkXWOzCHean6V/AJ5VNhf0
         +qn6hR2mjbh127WNUL673yoc+vEB2oOWcqLoCw63p7LOvaH/vEUMhHK0DuzjVXo3zWLJ
         fcaBFaM9qPtIgJlsgDHbBGKOsJLgIhBGIfJ5Hzspd3fyK9dsCQUbSESvsqucssvNiJ2Z
         cfvg==
X-Gm-Message-State: AOJu0Yz0iy8Pki1PFPKBR/WeplojuRFGjJ7tEjXh9SVzYfs8JXWvoHyg
	sf0zL/WpRkT6pXkMNMOC4a/FF8SAKK5Dmkah6mXpIw==
X-Google-Smtp-Source: AGHT+IFYGntNSfOXewM/tS8LvcLOqQgmS8ZJLgFgXfGLUpzIXraOzxew/iXIiOfAYDr2U/xwgoNtcg==
X-Received: by 2002:a05:600c:21cc:b0:401:c8b9:4b86 with SMTP id x12-20020a05600c21cc00b00401c8b94b86mr734598wmj.9.1694558815736;
        Tue, 12 Sep 2023 15:46:55 -0700 (PDT)
Received: from ip-172-31-30-46.eu-west-1.compute.internal (ec2-34-242-166-189.eu-west-1.compute.amazonaws.com. [34.242.166.189])
        by smtp.gmail.com with ESMTPSA id e15-20020a5d594f000000b00317df42e91dsm13921794wri.4.2023.09.12.15.46.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 15:46:55 -0700 (PDT)
From: Puranjay Mohan <puranjay12@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shubham Bansal <illusionist.neo@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	Helge Deller <deller@gmx.de>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Luke Nelson <luke.r.nels@gmail.com>,
	Xi Wang <xi.wang@gmail.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Wang YanQing <udknight@gmail.com>,
	bpf@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	netdev@vger.kernel.org
Cc: puranjay12@gmail.com
Subject: [PATCH bpf-next 0/6] bpf: verifier: stop emitting zext for LDX
Date: Tue, 12 Sep 2023 22:46:48 +0000
Message-Id: <20230912224654.6556-1-puranjay12@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All 64-bit architectures that support the BPF JIT do LDX + zero extension
with a single CPU instruction. Some 64-bit architectures like riscv64,
s390, mips64, etc. have bpf_jit_needs_zext() -> true. This means although
these architectures do LDX + zero extension with a single CPU instruction,
the verifier emits extra zero extension instructions after LDX | B/H/W.

After a discussion about this in [1], it was decided that the verifier
should not emit zext instructions for LDX and all JITs that can't do a LDX
+ zero extension with a single instruction should emit two instructions by
default for LDX.

All 32 bit JITs checked for ctx->prog->aux->verifier_zext and did not do
explicit zero extension after LDX if this is set by the verifier.

This patch series changes all applicable 32-bit JITs to always do a zero
extension after LDX without checking ctx->prog->aux->verifier_zext.

The last patch modifies the verifier to always mark the destination of LDX
as 64 bit which in turn stops the verifier from emitting zext after LDX.

These changes have not been tested because I don't have the hardware to do
so, I would request the JIT maintainers to help me test this. Especially,
the powerpc32 JTI where amount of code change is more.

[1] https://lore.kernel.org/all/CANk7y0j2f-gPgZwd+YfTL71-6wfvky+f=kBC_ccqsS0EHAysyA@mail.gmail.com/

Puranjay Mohan (6):
  bpf, riscv32: Always zero extend for LDX with B/W/H
  bpf, x86-32: Always zero extend for LDX with B/W/H
  bpf, parisc32: Always zero extend for LDX with B/W/H
  bpf, powerpc32: Always zero extend for LDX
  bpf, arm32: Always zero extend for LDX with B/H/W
  bpf, verifier: always mark destination of LDX as 64-bit

 arch/arm/net/bpf_jit_32.c         |  9 +++------
 arch/parisc/net/bpf_jit_comp32.c  |  9 +++------
 arch/powerpc/net/bpf_jit_comp32.c | 25 ++++++++-----------------
 arch/riscv/net/bpf_jit_comp32.c   |  9 +++------
 arch/x86/net/bpf_jit_comp32.c     |  2 --
 kernel/bpf/verifier.c             |  4 +---
 6 files changed, 18 insertions(+), 40 deletions(-)

-- 
2.39.2


