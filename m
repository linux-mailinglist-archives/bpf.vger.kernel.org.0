Return-Path: <bpf+bounces-9817-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 31DBC79DC3E
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 00:51:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 469051C213FC
	for <lists+bpf@lfdr.de>; Tue, 12 Sep 2023 22:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 187E5156C4;
	Tue, 12 Sep 2023 22:47:05 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D798B1549A;
	Tue, 12 Sep 2023 22:47:04 +0000 (UTC)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24E881708;
	Tue, 12 Sep 2023 15:47:04 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-31aeedbb264so6597900f8f.0;
        Tue, 12 Sep 2023 15:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694558822; x=1695163622; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GxeItlNv04+BjzshAn31wAsB9adLvt962s1bQaHQhqk=;
        b=qkDC7lydUruK+up4ibdg5dKJAohUWVCTp+4NBx524I2YL7zZVduRLYAlDwpC/jjmUb
         R+Z9ZRFQJ8RqepOGSlG3bkVnNZ5Zofvov5QBXV+mq3mxxIPMHM+I3Aq6xGfmacmk8BGu
         YsV9xSqrV6GW6owSRIe4f2YSzostnhu9dn3wsUu/UQXKxVXl6uA9xN8reeDQtGehTwdR
         qVnCzMAyxUcIR3Ipl8Nv+GjrF4h63D+zin2vjp68FApH7wxZOS38o1k6oEHbFbc0J8ps
         AejUvVu6NZ2nacbgbQ3gl8Gvz8h5QAMn/A+xncv9UPOKVEYPMJFj5sedZSzkF3fDKd1u
         M8QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694558822; x=1695163622;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GxeItlNv04+BjzshAn31wAsB9adLvt962s1bQaHQhqk=;
        b=M8XBBwvWUJ14TkS3XPZIlnRPJ1mxnNYmOK1fz573PuTZgri6R2TOTw8mATEfO0AYGS
         wdrkkm0BaI76FG9hxKMKqUdbUdZZAsKb24lggG2cs3L00b7gyBt1CekKQhFiaPW4/NRg
         C+Is3IE0Y7Z8T0DiP1jOE5YcQRNClTHhAT72vR2cyHUVokWY1aubRauNKmYJJ/aWx610
         iCVPz8JPYl6xqrXY/agF5HuQh0kH2uGeS68X9/mKqcjhK1PoIFn0uk2nw9w4b8uyfyPF
         Nmr2FTFj4Jod6ySmhQJmkMNmXemh+fBHO0TZSHKFQFgVrW51wr0JwKFNacQglk8UOn7G
         yc+g==
X-Gm-Message-State: AOJu0YxRLjva5vrNwg3uPLWbHnybuXk5wil6jVO5u2mWDb2Uuzv5Font
	zSNEbDFoxsqK2JqYttsGFS4=
X-Google-Smtp-Source: AGHT+IGIRL1pLS66Q0kL+tNt95f9G7dGNYYYAmglWQ49OAUKZ2P+a9yQAWCML5eZu0IFvzTnTl7LPw==
X-Received: by 2002:a5d:45d0:0:b0:31f:9838:dfc4 with SMTP id b16-20020a5d45d0000000b0031f9838dfc4mr646970wrs.33.1694558822455;
        Tue, 12 Sep 2023 15:47:02 -0700 (PDT)
Received: from ip-172-31-30-46.eu-west-1.compute.internal (ec2-34-242-166-189.eu-west-1.compute.amazonaws.com. [34.242.166.189])
        by smtp.gmail.com with ESMTPSA id e15-20020a5d594f000000b00317df42e91dsm13921794wri.4.2023.09.12.15.47.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 15:47:02 -0700 (PDT)
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
Subject: [PATCH bpf-next 6/6] bpf, verifier: always mark destination of LDX as 64-bit
Date: Tue, 12 Sep 2023 22:46:54 +0000
Message-Id: <20230912224654.6556-7-puranjay12@gmail.com>
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

All 64-bit JITs utilize a single instruction to load + zero-extend a
byte, word, or a half-word. The optimisation of emitting zext for LDX is
not useful for most of the JITs.

All the JITs that relied on the verifier for zero extension of LDX
desitination registers have been modified to always zero extend the
destination.

Now the verifier can safely mark LDX destination as 64-bit and stop
emitting zero-extension instructions for it.

Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
---
 kernel/bpf/verifier.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index dbba2b806017..02a1ac1a1327 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3028,9 +3028,7 @@ static bool is_reg64(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		return false;
 
 	if (class == BPF_LDX) {
-		if (t != SRC_OP)
-			return BPF_SIZE(code) == BPF_DW;
-		/* LDX source must be ptr. */
+		/* LDX source must be a ptr. and LDX destination is always zero-extended. */
 		return true;
 	}
 
-- 
2.39.2


