Return-Path: <bpf+bounces-57616-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A3F5AAD427
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 05:43:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30C137B23BB
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 03:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F2801B85CC;
	Wed,  7 May 2025 03:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4QgiWcpF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9255942048
	for <bpf@vger.kernel.org>; Wed,  7 May 2025 03:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746589375; cv=none; b=Xd2IXMyF9X53tagzC6BnpKBgIRWa53eJUqvowMBWwsHgycRaNnwiEatumjnA/gNDYclFpZnQF8ia8/xlE7TB/ikctYK0GL7DfTDNLTcz59QEZg//nluVsSLW7rAIV7qfi6Ak+8OxSDfIIIGsPKxH72/8IvvccO+TGQPfyGZYlZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746589375; c=relaxed/simple;
	bh=OQGlNssRlPDWlCWPZDt4Zau7flrdbewcJOyYYX6YB5g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LM/cj3TeodGR0vWP64Dre74Px8n9zQcWu5IYXzXVb8cw1oMo5w+F/ZUvWO9jREXFWVSw/8hj19gfBQUCjQ5Q/THvIb3ED2iWRd22xmYvyZ2d3qs+GOEnOheejultpeG24w+wcjHKNaSOkhsDXbkRxMSKSx3Cu218/q5eFopPk1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yepeilin.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4QgiWcpF; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yepeilin.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b16b35ea4aaso3910133a12.1
        for <bpf@vger.kernel.org>; Tue, 06 May 2025 20:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746589373; x=1747194173; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D3ohcUNpnNrLBXhF5o8bgmqMF5EWq+vsTR9j7XgMXH8=;
        b=4QgiWcpFZmhbPQq6jLNKzU+SyHksxvJ8tjwCw7yKRtnBV+r9xA1wD4SqeBns1yIeCj
         T04dO9IlsjoCcklQspuiv6QLed2o5xmMC4s3PUZz8uS2TFqFpfrzN3QYtqwcLWWczQ9W
         OnQ+bjKFc71zIrXl1ev9cAasw1PC9PRRQfiD2tHtInWnUmByVN1QzNZKuDePZpxvzGlv
         t8MlkE3e9kaYTNKa+MMjfU4lcTNCMndAFQompFPYMzdWmTyrNjhHaTDhC2265ylDWm4m
         kPNE/pHnV66ag/CpFw0TfuPk8kBHTLBBl+Mjoez7wQ3UtXsJvwlLemvzRFaVxUccQPTd
         ZO7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746589373; x=1747194173;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=D3ohcUNpnNrLBXhF5o8bgmqMF5EWq+vsTR9j7XgMXH8=;
        b=WyXHlvQIU+Oaj3Wa+UuuuNTG7WzOpxrcESpUr4JBiHnsfdiamG3xA2blCRirvG0/1j
         o+XoG9P35QZ4W2acCyKnSrv1b/YUt9AGIQ7Mn/vU1yliMMapv4RSXsI/o2w038LhQIFS
         9RklFcpbKYjPAqhaJRAMDD+7Fcwl6oIpGyffmXZWBEVCqbbnAYqJ95jO4tcJR0ZWGEY7
         jEjQZ+/vpQzMOfSx1BihcA9FbgDP5CX7/WBkkoOyNv6Rjlbglnbq87p12e4NWMEOjtpk
         xsBKGzDCl8zCFgk7dxMtHUklpyO6O4zC4WSVzm/KIo91bIPkwgKiN5egETCqdKmEQbAy
         HQvg==
X-Gm-Message-State: AOJu0YyZ7IPnERWfZjGveUP7ifZ3GrVZzYS3Bg4WuanXqiH3nbzbHgFY
	ET5VS+8OBaBW88DtJ9wrjYB20M4UgxYkIup76nJk6IGMi46w4Uv7WGLxmalw70sH5SaQbEGxXqU
	m6sI8Q1WIi4Xe1nWMIquqIvMunna1mm810BusDljyKQ+T5p+VHtWgB+pohF9dEktGg5nG1d3tWW
	M/0Wx8GZNEwrG4sa266dVZxIDzoFDAR/c3SzjapYk=
X-Google-Smtp-Source: AGHT+IFz4BJzYn4BfdWYvLkT/5ONenxt7WQBZf9xlB0zuHUWc3QHVKMfEbhxGAhiemEViSzfZMFPv/n3rglc7w==
X-Received: from plef17.prod.google.com ([2002:a17:902:f391:b0:227:967c:4f38])
 (user=yepeilin job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:c94c:b0:223:3bf6:7e6a with SMTP id d9443c01a7336-22e5ea2b6bemr29706915ad.12.1746589372383;
 Tue, 06 May 2025 20:42:52 -0700 (PDT)
Date: Wed,  7 May 2025 03:42:45 +0000
In-Reply-To: <cover.1746588351.git.yepeilin@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1746588351.git.yepeilin@google.com>
X-Mailer: git-send-email 2.49.0.967.g6a0df3ecc3-goog
Message-ID: <09cb2aec979aaed9d16db41f0f5b364de39377c0.1746588351.git.yepeilin@google.com>
Subject: [PATCH bpf-next v2 1/8] bpf/verifier: Handle BPF_LOAD_ACQ
 instructions in insn_def_regno()
From: Peilin Ye <yepeilin@google.com>
To: bpf@vger.kernel.org
Cc: Peilin Ye <yepeilin@google.com>, linux-riscv@lists.infradead.org, 
	Andrea Parri <parri.andrea@gmail.com>, 
	"=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?=" <bjorn@kernel.org>, Pu Lehui <pulehui@huawei.com>, 
	Puranjay Mohan <puranjay@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Luke Nelson <luke.r.nels@gmail.com>, Xi Wang <xi.wang@gmail.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Mykola Lysenko <mykolal@fb.com>, 
	Shuah Khan <shuah@kernel.org>, Josh Don <joshdon@google.com>, Barret Rhoden <brho@google.com>, 
	Neel Natu <neelnatu@google.com>, Benjamin Segall <bsegall@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

In preparation for supporting BPF load-acquire and store-release
instructions for architectures where bpf_jit_needs_zext() returns true
(e.g. riscv64), make insn_def_regno() handle load-acquires properly.

Acked-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>
Tested-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com> # QEMU/RVA23
Signed-off-by: Peilin Ye <yepeilin@google.com>
---
 kernel/bpf/verifier.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 99aa2c890e7b..28f5a7899bd6 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3649,16 +3649,16 @@ static int insn_def_regno(const struct bpf_insn *in=
sn)
 	case BPF_ST:
 		return -1;
 	case BPF_STX:
-		if ((BPF_MODE(insn->code) =3D=3D BPF_ATOMIC ||
-		     BPF_MODE(insn->code) =3D=3D BPF_PROBE_ATOMIC) &&
-		    (insn->imm & BPF_FETCH)) {
+		if (BPF_MODE(insn->code) =3D=3D BPF_ATOMIC ||
+		    BPF_MODE(insn->code) =3D=3D BPF_PROBE_ATOMIC) {
 			if (insn->imm =3D=3D BPF_CMPXCHG)
 				return BPF_REG_0;
-			else
+			else if (insn->imm =3D=3D BPF_LOAD_ACQ)
+				return insn->dst_reg;
+			else if (insn->imm & BPF_FETCH)
 				return insn->src_reg;
-		} else {
-			return -1;
 		}
+		return -1;
 	default:
 		return insn->dst_reg;
 	}
--=20
2.49.0.967.g6a0df3ecc3-goog


