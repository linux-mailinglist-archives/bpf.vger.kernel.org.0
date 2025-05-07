Return-Path: <bpf+bounces-57622-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E95DAAD42D
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 05:43:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D72B983F48
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 03:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 657971B4257;
	Wed,  7 May 2025 03:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X+FbghFE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9DF1B85CC
	for <bpf@vger.kernel.org>; Wed,  7 May 2025 03:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746589410; cv=none; b=OdjP0ELL9vDM1/+gsRYqGiSz08/Y3q9pklQbX0JgrosTcw1qejoJiyOz8J149nkbh9pTet1KjO+nVNQrt/keEAZR/Hqq7fIeijwZZvT0Ew3G3FmZfyVDixYyC4+r3Z0i3x4ueOJeN6E+sWYiUGLxqS28HSIQpvipmRHt4Xk01YA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746589410; c=relaxed/simple;
	bh=S3f5tEuGuwgXgYYoz2dazVzLSGi2L09TYchlj4Cb4sg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=unPURKBRxb2RYhpQJu4fM6xfktcbPKhB6NzeQBSt/eRmtZaYmJ/GrHsPtzn7OLrJmVEG437HEeMnBDjgRI4wvobf6eHLIxO4+iM2aUKf5TMn4FCdihMeQEbvpeD8bZOq+2vZmcICbrbkX/deNnpxdqQ48rTrO6aCtW6wIBw5LkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yepeilin.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=X+FbghFE; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yepeilin.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-225ab228a37so50397315ad.2
        for <bpf@vger.kernel.org>; Tue, 06 May 2025 20:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746589409; x=1747194209; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xzvwhqpet2wKikEpSs/exbZDwf74+YM6WPqZRUaUv4c=;
        b=X+FbghFE1uPgtNd2f4eCoEPsRJ4CtBvQCmzmZZMe6gHsuSaVgDKkRJkOP34CYui7dJ
         pmGjeW9l/M2MaIKr/tqKuDMAL7h1HDwzlPB0/+0A7NE5sBi9twUC/kHQRNQuYVkZak4V
         rccDvW/f3M2y84E66sZjhjqWuslJ/AMoXMqfB7iwjH1tN9j74gYGuxcNouDWagSzSInS
         rcXZfOVEWNv5G56n6jjya1F4NzN5yUB4/97rI5R2w4dfjgdArQFTSEk/K+FrG70Kot+Q
         DOCXNYjHb+chscg89SYxv1sYo5/MPINtoiIl51WFxbf43fKUdvx9Z9pKqKERWtv2NJks
         Vk8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746589409; x=1747194209;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Xzvwhqpet2wKikEpSs/exbZDwf74+YM6WPqZRUaUv4c=;
        b=lLjszrteY7pEfggXsS1wzqL19Amg5hlscjk1o7lq6Zoomb32sa8HTTjvIsLyVrKcyw
         XoO+nlBy8/qfjNDDj0cVTiNGLV6XK4Z5OUaBpKy53LnmYryDCyVgvLjottpnYj6MT7Vm
         YreN0bqfpHu8OZpUhUg6qnOOlOtCqrwf/b22MIBR9kV8RgddUnEQhUL5Mw70hH2ggzGY
         VE0Ckz2juUffgy8oxPZZBk4qc8/y7sIehnWqAfcFBRQzPb0sVUez9phAm8PoJPPJVDnN
         evKyWHB/pGKaW7Xg8QDgqyVlALGAryO37YnRff4ijaR1MIVeqj/mfzr3MzuVcxmRl5h/
         BQTw==
X-Gm-Message-State: AOJu0YxILP0YDPl8MJzk8/1pvZXKqvoo5JQe6QtuQR3CArkfCA6AcdQq
	m9DxChkMZI2Dtnitx/7QUykiXxjH+tHndWG5PDh4P7KYGjBLJFmAqmW02VwAgFOAtW0Li19q0td
	zLpqPqKbBYDoi1YsK+7bIbs7xE17cypwXbrgLp457DE5smndSaFTEyaH9r9tOPq72Q0KVB1hhC6
	5kmSxSHeEkR/h/kbwNC0LYIGjH/ApbyEolaNjYex8=
X-Google-Smtp-Source: AGHT+IEtoQx5D2S9W7WAmHeQNr3gJVW7PqfCB40WHN0EShgVdc/0yI0wAxRoW5BJaCzOHqdGbwsUKwFn2rFGAA==
X-Received: from plbkr8.prod.google.com ([2002:a17:903:808:b0:223:f441:fcaa])
 (user=yepeilin job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:f54b:b0:22c:33e4:fa5a with SMTP id d9443c01a7336-22e5ea1d27emr23509275ad.9.1746589408717;
 Tue, 06 May 2025 20:43:28 -0700 (PDT)
Date: Wed,  7 May 2025 03:43:25 +0000
In-Reply-To: <cover.1746588351.git.yepeilin@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1746588351.git.yepeilin@google.com>
X-Mailer: git-send-email 2.49.0.967.g6a0df3ecc3-goog
Message-ID: <11097fd515f10308b3941469ee4c86cb8872db3f.1746588351.git.yepeilin@google.com>
Subject: [PATCH bpf-next v2 7/8] selftests/bpf: Verify zero-extension behavior
 in load-acquire tests
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

Verify that 8-, 16- and 32-bit load-acquires are zero-extending by using
immediate values with their highest bit set.  Do the same for the 64-bit
variant to keep the style consistent.

Acked-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>
Reviewed-by: Pu Lehui <pulehui@huawei.com>
Tested-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com> # QEMU/RVA23
Signed-off-by: Peilin Ye <yepeilin@google.com>
---
 tools/testing/selftests/bpf/progs/verifier_load_acquire.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/verifier_load_acquire.c b/to=
ols/testing/selftests/bpf/progs/verifier_load_acquire.c
index a696ab84bfd6..74f4f19c10b8 100644
--- a/tools/testing/selftests/bpf/progs/verifier_load_acquire.c
+++ b/tools/testing/selftests/bpf/progs/verifier_load_acquire.c
@@ -15,7 +15,7 @@ __naked void load_acquire_8(void)
 {
 	asm volatile (
 	"r0 =3D 0;"
-	"w1 =3D 0x12;"
+	"w1 =3D 0xfe;"
 	"*(u8 *)(r10 - 1) =3D w1;"
 	".8byte %[load_acquire_insn];" // w2 =3D load_acquire((u8 *)(r10 - 1));
 	"if r2 =3D=3D r1 goto 1f;"
@@ -35,7 +35,7 @@ __naked void load_acquire_16(void)
 {
 	asm volatile (
 	"r0 =3D 0;"
-	"w1 =3D 0x1234;"
+	"w1 =3D 0xfedc;"
 	"*(u16 *)(r10 - 2) =3D w1;"
 	".8byte %[load_acquire_insn];" // w2 =3D load_acquire((u16 *)(r10 - 2));
 	"if r2 =3D=3D r1 goto 1f;"
@@ -55,7 +55,7 @@ __naked void load_acquire_32(void)
 {
 	asm volatile (
 	"r0 =3D 0;"
-	"w1 =3D 0x12345678;"
+	"w1 =3D 0xfedcba09;"
 	"*(u32 *)(r10 - 4) =3D w1;"
 	".8byte %[load_acquire_insn];" // w2 =3D load_acquire((u32 *)(r10 - 4));
 	"if r2 =3D=3D r1 goto 1f;"
@@ -75,7 +75,7 @@ __naked void load_acquire_64(void)
 {
 	asm volatile (
 	"r0 =3D 0;"
-	"r1 =3D 0x1234567890abcdef ll;"
+	"r1 =3D 0xfedcba0987654321 ll;"
 	"*(u64 *)(r10 - 8) =3D r1;"
 	".8byte %[load_acquire_insn];" // r2 =3D load_acquire((u64 *)(r10 - 8));
 	"if r2 =3D=3D r1 goto 1f;"
--=20
2.49.0.967.g6a0df3ecc3-goog


