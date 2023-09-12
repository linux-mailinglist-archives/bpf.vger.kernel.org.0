Return-Path: <bpf+bounces-9813-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4601C79DC2B
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 00:48:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4403F1C210DC
	for <lists+bpf@lfdr.de>; Tue, 12 Sep 2023 22:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DDA9134B7;
	Tue, 12 Sep 2023 22:47:01 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B334125A2;
	Tue, 12 Sep 2023 22:47:00 +0000 (UTC)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 278DA10EB;
	Tue, 12 Sep 2023 15:47:00 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-31aec0a1a8bso205520f8f.0;
        Tue, 12 Sep 2023 15:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694558818; x=1695163618; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sT29HscYryKGVaLS4ITmGogx99J9Puoxilk7JdApwLE=;
        b=bwB5e18CqTc89LsjuJwxjDmt+aK1qXTSzO/IfsJFcHHFm99ufKgkx1qLse08YVt2EM
         +yS2Sdz4oyvxwzEDMeSuU3LKmhEHeVA6qEHfFFMB2dbtSpaGl8/Q8p+n3KEdFhxYB7m1
         gRGLK2zLEM+w0wSl3nOxp2PlgGZmPftv9maovSn1OSflD+9kjp0CtiHgR4QIDq97Z7g9
         B7fuZ3YPZ3rmTUX1B9wshXzI8J3DzHXxNBthDb4B3ncgagEbdYt1VD+zuujIpq0Xhtfe
         DeLrSx5tL5OeEozFNjoZYXteI5bC9Y9nC9ha12WjY91xOIzjXq959vzmVsy8dJ6gMLTC
         M1zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694558818; x=1695163618;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sT29HscYryKGVaLS4ITmGogx99J9Puoxilk7JdApwLE=;
        b=tES/UnK7u1pq+cDf2/+eD52aICP352rjjLfkXNOi/vBy2HZ+Bf4WKVVoRUSCx9fZh+
         lNw2/94EvyjX6S03FhydVbSxo+63mYQgQoFehHQ0HyV+UN9iVc81WpQhwVO0AT/H544w
         jf2F8holtlcq0WEClUd7yXymt+MwXWigtA9GWHs3Ti+d1pbfKEJwyXVBvvOQ1SgStAL7
         kbSVdOQHvxJY0mtZFf0sdhMNxOVHobeRb3cLztLs9fSeP01a8m/nLPN+lRqQpcpf+GV5
         3DHwRC3Jb5UqS1OEY9eCiTCQhDfEorb0T8TMCsfRhZJ345TyZtnDh1wgi/GsUy3QmmBR
         hdBg==
X-Gm-Message-State: AOJu0YxcVvOw8fPjBzNvVAg71R7n1aYpDR1B9g2bUdUeVjWeXGNZupdU
	7l396FuaXYQFGSQxwmKdJbU=
X-Google-Smtp-Source: AGHT+IGmXcseiJIR5TJ93E0zDMbc0daNf/KmJUUYoyIE/Gf3HMcwKKCMLML9MVROQedqC+pALyVq0A==
X-Received: by 2002:adf:dc85:0:b0:319:5234:5c92 with SMTP id r5-20020adfdc85000000b0031952345c92mr596882wrj.35.1694558818289;
        Tue, 12 Sep 2023 15:46:58 -0700 (PDT)
Received: from ip-172-31-30-46.eu-west-1.compute.internal (ec2-34-242-166-189.eu-west-1.compute.amazonaws.com. [34.242.166.189])
        by smtp.gmail.com with ESMTPSA id e15-20020a5d594f000000b00317df42e91dsm13921794wri.4.2023.09.12.15.46.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 15:46:58 -0700 (PDT)
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
Subject: [PATCH bpf-next 2/6] bpf, x86-32: Always zero extend for LDX with B/W/H
Date: Tue, 12 Sep 2023 22:46:50 +0000
Message-Id: <20230912224654.6556-3-puranjay12@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230912224654.6556-1-puranjay12@gmail.com>
References: <20230912224654.6556-1-puranjay12@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The JITs should not depend on the verifier for zero extending the upper
32 bits of the destination register when loading a byte, half-word, or
word.

A following patch will make the verifier stop patching zext instructions
after LDX.

Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
---
 arch/x86/net/bpf_jit_comp32.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp32.c b/arch/x86/net/bpf_jit_comp32.c
index 429a89c5468b..aef9183ff107 100644
--- a/arch/x86/net/bpf_jit_comp32.c
+++ b/arch/x86/net/bpf_jit_comp32.c
@@ -2050,8 +2050,6 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image,
 			case BPF_B:
 			case BPF_H:
 			case BPF_W:
-				if (bpf_prog->aux->verifier_zext)
-					break;
 				if (dstk) {
 					EMIT3(0xC7, add_1reg(0x40, IA32_EBP),
 					      STACK_VAR(dst_hi));
-- 
2.39.2


