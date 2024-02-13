Return-Path: <bpf+bounces-21858-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 81DF8853655
	for <lists+bpf@lfdr.de>; Tue, 13 Feb 2024 17:41:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ECF77B20B2D
	for <lists+bpf@lfdr.de>; Tue, 13 Feb 2024 16:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AE3F5F54E;
	Tue, 13 Feb 2024 16:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H3AWX42d"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42AECB65E
	for <bpf@vger.kernel.org>; Tue, 13 Feb 2024 16:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707842412; cv=none; b=A4DmzqyM2jBllDqH0Cb3PAWp4ceZ1Iit1sc02JF5fLgn5Jf8aSwM3wK8M7OKjbgMNNoaXTcaYUaBdTmxFpYouDn+MSdcIqyGcQXwm4Rr+YtBtOi3PGluUkj0HevfR2B5KNf7zakidCjazFYkBJHRP8SmTXTFEF9/Na0oBtWFM6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707842412; c=relaxed/simple;
	bh=4v7yf7F7xXeOdDp3GsVn2FDpToYZsDSqhq+XG0+zuB4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ummd2ClQLhanFOcFAKL43iQTy7jfuU9BTEt/HgKSFA4nVMaASedq3i8BSK+Vv+Hhh924ZfTvjl8rjlqyzrgBdPexZ3e+hmUslgWC/z9bUUJeanMuEXKjxGA2Muy2KIwPjBO9QACmLMYve+42e4kng9bu7kTLRg+f94Ze8umjIDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H3AWX42d; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a3d2587116aso38051266b.3
        for <bpf@vger.kernel.org>; Tue, 13 Feb 2024 08:40:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707842407; x=1708447207; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZWt6UsJTTV5xXz1l4jkz5wu+9wEMXoZ13iCL/+nO+fU=;
        b=H3AWX42dEuTf0nCPvV2xv/z2kLQG5AbRLVQneePQaD/VagGtSRl9NFHMT7pyHuv1h5
         2IsbnKOq+pvbpeofoSBxBYLht3d5GtbBUaF/M3H/fR3d1fgO8wmC4qfw3IWfm4vnyf4x
         ZNP2BXXCQOZz+SjbKETEX3v/lCb9p3rkM3lfyicfM5mGBjqdYmBFGQfhMvSuGElQ7Uc6
         frwNAoxXmNUbUF/zJKFOO2OgYRnZC61IvncE9gzBgj1UHk/kTlS3eJQVFmLBnnPqSdVm
         Q58Bd/z6U2tnOOYSqN526U4+snG8/g8oEMaaefOWgYhZrrY5eU7DNzmMPRoIVdCV1pK7
         83yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707842407; x=1708447207;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZWt6UsJTTV5xXz1l4jkz5wu+9wEMXoZ13iCL/+nO+fU=;
        b=OaBdPZ+jclHH6r3ZNafGLjS2AVTR2FmPXaXeuEALM0Xrkf/EDCH6F8BiIg2iIbX0Lx
         OCgegoBvJblnAQcQfXA/LEt6qbi1U6zMnHMVV7IncQcQlxW6gaSdBJKt07Su3+ig2u5y
         Q5vdZr7OmJPh2mLLSnthGWe9UDjD5KSRbjwybBgLcnMHw0VqbSlovb4fx8e3XQjfOU9v
         YbzEqJHHauEhHOlfogGouWjpu2EGa1Hq8nodgPD/RyVpYqQDmQlafJy/HuZMnwXItaPM
         MuQgGvl6PI32heNVbOJk6Nc0SLzK+IjimGPs049XfSmRxHqE1IGlV0S7h7H1isd4GEOB
         dHhQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQGObfy+1qhwUwiwkjF2QBv5j7GMwD2o/jxD3KLlbrILIcg+8kECfMHSlwf9j7ouPfVxFHVs3RjT/vE+1N779JeAIq
X-Gm-Message-State: AOJu0YzbqnQHim0P2n0+L+dN3WsSXEIgQb/bx5QPFAY9XQFp9gOgjJyk
	CF3kicnC/eR5MAgu1KOUYNjgt+A65seFLd3xk5Adh8uOlIvaZN2b
X-Google-Smtp-Source: AGHT+IETDVM8ZXm8VEXq+XwkPP1G2Kj8RtEiExMx9cQCR8LSp44zQ2PoiX08kbYbM4oYDH07t7KQBQ==
X-Received: by 2002:a17:906:fb05:b0:a3d:15ed:60e3 with SMTP id lz5-20020a170906fb0500b00a3d15ed60e3mr1072943ejb.26.1707842407528;
        Tue, 13 Feb 2024 08:40:07 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUJmYF0nYAwO3jWfIUAvbA7GHRT5bDo5s0ydZj9GbJV0M+6Ogdz86vVivhKBUon7AtmbNyd7X0aKw/zN/sECzM6fd1tj6ujed5gvI7ad5WCVBf42O8t7BZN61F0Pmn/reIVQuXdKc1MlRiKX29Iuq78BlKK0oN20IpkJngG7g5spA==
Received: from [192.168.1.94] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id si26-20020a170906ceda00b00a3d2fe84ff9sm8085ejb.36.2024.02.13.08.40.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 08:40:07 -0800 (PST)
Message-ID: <e3b68a899b8ade18addd198d6f33dcbbed473c3c.camel@gmail.com>
Subject: Re: [PATCH v2 bpf-next 2/4] bpf: handle bpf_user_pt_regs_t typedef
 explicitly for PTR_TO_CTX global arg
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
 ast@kernel.org,  daniel@iogearbox.net, martin.lau@kernel.org
Cc: kernel-team@meta.com
Date: Tue, 13 Feb 2024 18:40:06 +0200
In-Reply-To: <20240212233221.2575350-3-andrii@kernel.org>
References: <20240212233221.2575350-1-andrii@kernel.org>
	 <20240212233221.2575350-3-andrii@kernel.org>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=mQGNBGKNNQEBDACwcUNXZOGTzn4rr7Sd18SA5Wv0Wna/ONE0ZwZEx+sIjyGrPOIhR14/DsOr3ZJer9UJ/WAJwbxOBj6E5Y2iF7grehljNbLr/jMjzPJ+hJpfOEAb5xjCB8xIqDoric1WRcCaRB+tDSk7jcsIIiMish0diTK3qTdu4MB6i/sh4aeFs2nifkNi3LdBuk8Xnk+RJHRoKFJ+C+EoSmQPuDQIRaF9N2m4yO0eG36N8jLwvUXnZzGvHkphoQ9ztbRJp58oh6xT7uH62m98OHbsVgzYKvHyBu/IU2ku5kVG9pLrFp25xfD4YdlMMkJH6l+jk+cpY0cvMTS1b6/g+1fyPM+uzD8Wy+9LtZ4PHwLZX+t4ONb/48i5AKq/jSsb5HWdciLuKEwlMyFAihZamZpEj+9n91NLPX4n7XeThXHaEvaeVVl4hfW/1Qsao7l1YjU/NCHuLaDeH4U1P59bagjwo9d1n5/PESeuD4QJFNqW+zkmE4tmyTZ6bPV6T5xdDRHeiITGc00AEQEAAbQkRWR1YXJkIFppbmdlcm1hbiA8ZWRkeXo4N0BnbWFpbC5jb20+iQHUBBMBCgA+FiEEx+6LrjApQyqnXCYELgxleklgRAkFAmKNNQECGwMFCQPCZwAFCwkIBwIGFQoJCAsCBBYCAwECHgECF4AACgkQLgxleklgRAlWZAv/cJ5v3zlEyP0/jMKQBqbVCCHTirPEw+nqxbkeSO6r2FUds0NnGA9a6NPOpBH+qW7a6+n6q3sIbvH7jlss4pzLI7LYlDC6z+egTv7KR5X1xFrY1uR5UGs1beAjnzYeV2hK4yqRUfygsT0Wk5e4FiNBv4+DUZ8r0cNDkO6swJxU55DO21mcteC147+4aDoHZ40R0tsAu+brDGSSoOPpb0RWVsEf9XOBJqWWA+T7mluw
 nYzhLWGcczc6J71q1Dje0l5vIPaSFOgwmWD4DA+WvuxM/shH4rtWeodbv iCTce6yYIygHgUAtJcHozAlgRrL0jz44cggBTcoeXp/atckXK546OugZPnl00J3qmm5uWAznU6T5YDv2vCvAMEbz69ib+kHtnOSBvR0Jb86UZZqSb4ATfwMOWe9htGTjKMb0QQOLK0mTcrk/TtymaG+T4Fsos0kgrxqjgfrxxEhYcVNW8v8HISmFGFbqsJmFbVtgk68BcU0wgF8oFxo7u+XYQDdKbI1uQGNBGKNNQEBDADbQIdo8L3sdSWGQtu+LnFqCZoAbYurZCmUjLV3df1b+sg+GJZvVTmMZnzDP/ADufcbjopBBjGTRAY4L76T2niu2EpjclMMM3mtrOc738Kr3+RvPjUupdkZ1ZEZaWpf4cZm+4wH5GUfyu5pmD5WXX2i1r9XaUjeVtebvbuXWmWI1ZDTfOkiz/6Z0GDSeQeEqx2PXYBcepU7S9UNWttDtiZ0+IH4DZcvyKPUcK3tOj4u8GvO3RnOrglERzNCM/WhVdG1+vgU9fXO83TB/PcfAsvxYSie7u792s/I+yA4XKKh82PSTvTzg2/4vEDGpI9yubkfXRkQN28w+HKF5qoRB8/L1ZW/brlXkNzA6SveJhCnH7aOF0Yezl6TfX27w1CW5Xmvfi7X33V/SPvo0tY1THrO1c+bOjt5F+2/K3tvejmXMS/I6URwa8n1e767y5ErFKyXAYRweE9zarEgpNZTuSIGNNAqK+SiLLXt51G7P30TVavIeB6s2lCt1QKt62ccLqUAEQEAAYkBvAQYAQoAJhYhBMfui64wKUMqp1wmBC4MZXpJYEQJBQJijTUBAhsMBQkDwmcAAAoJEC4MZXpJYEQJkRAMAKNvWVwtXm/WxWoiLnXyF2WGXKoDe5+itTLvBmKcV/b1OKZF1s90V7WfSBz712eFAynEzyeezPbwU8QBiTpZcHXwQni3IYKvsh7s
 t1iq+gsfnXbPz5AnS598ScZI1oP7OrPSFJkt/z4acEbOQDQs8aUqrd46PV jsdqGvKnXZxzylux29UTNby4jTlz9pNJM+wPrDRmGfchLDUmf6CffaUYCbu4FiId+9+dcTCDvxbABRy1C3OJ8QY7cxfJ+pEZW18fRJ0XCl/fiV/ecAOfB3HsqgTzAn555h0rkFgay0hAvMU/mAW/CFNSIxV397zm749ZNLA0L2dMy1AKuOqH+/B+/ImBfJMDjmdyJQ8WU/OFRuGLdqOd2oZrA1iuPIa+yUYyZkaZfz/emQwpIL1+Q4p1R/OplA4yc301AqruXXUcVDbEB+joHW3hy5FwK5t5OwTKatrSJBkydSF9zdXy98fYzGniRyRA65P0Ix/8J3BYB4edY2/w0Ip/mdYsYQljBY0A==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-02-12 at 15:32 -0800, Andrii Nakryiko wrote:
> Expected canonical argument type for global function arguments
> representing PTR_TO_CTX is `bpf_user_pt_regs_t *ctx`. This currently
> works on s390x by accident because kernel resolves such typedef to
> underlying struct (which is anonymous on s390x), and erroneously
> accepting it as expected context type. We are fixing this problem next,
> which would break s390x arch, so we need to handle `bpf_user_pt_regs_t`
> case explicitly for KPROBE programs.
>=20
> Fixes: 91cc1a99740e ("bpf: Annotate context types")
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---

Nit: same could be achieved w/o special casing kprobes by looking
     if typedef's type is named before skipping, e.g. as below.
     But I do not insist, probably good as it is as well.

---

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index f0ce384aa73e..830635b37fa1 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -907,11 +907,9 @@ bool btf_member_is_reg_int(const struct btf *btf, cons=
t struct btf_type *s,
 }
=20
 /* Similar to btf_type_skip_modifiers() but does not skip typedefs. */
-static const struct btf_type *btf_type_skip_qualifiers(const struct btf *b=
tf,
-						       u32 id)
+static const struct btf_type *__btf_type_skip_qualifiers(const struct btf =
*btf,
+							 const struct btf_type *t)
 {
-	const struct btf_type *t =3D btf_type_by_id(btf, id);
-
 	while (btf_type_is_modifier(t) &&
 	       BTF_INFO_KIND(t->info) !=3D BTF_KIND_TYPEDEF) {
 		t =3D btf_type_by_id(btf, t->type);
@@ -920,6 +918,12 @@ static const struct btf_type *btf_type_skip_qualifiers=
(const struct btf *btf,
 	return t;
 }
=20
+static const struct btf_type *btf_type_skip_qualifiers(const struct btf *b=
tf,
+						       u32 id)
+{
+	return __btf_type_skip_qualifiers(btf, btf_type_by_id(btf, id));
+}
+
 #define BTF_SHOW_MAX_ITER	10
=20
 #define BTF_KIND_BIT(kind)	(1ULL << kind)
@@ -5695,9 +5699,25 @@ bool btf_is_prog_ctx_type(struct bpf_verifier_log *l=
og, const struct btf *btf,
 	const char *tname, *ctx_tname;
=20
 	t =3D btf_type_by_id(btf, t->type);
-	while (btf_type_is_modifier(t))
-		t =3D btf_type_by_id(btf, t->type);
-	if (!btf_type_is_struct(t)) {
+
+	/* Skip modifiers, but stop if skipping of typedef would
+	 * lead an anonymous type, e.g. like for s390:
+	 *
+	 *   typedef struct { ... } user_pt_regs;
+	 *   typedef user_pt_regs bpf_user_pt_regs_t;
+	 */
+	t =3D __btf_type_skip_qualifiers(btf, t);
+	while (btf_type_is_typedef(t)) {
+		const struct btf_type *t1;
+
+		t1 =3D btf_type_by_id(btf, t->type);
+		t1 =3D __btf_type_skip_qualifiers(btf, t1);
+		tname =3D btf_name_by_offset(btf, t1->name_off);
+		if (!tname || tname[0] =3D=3D '\0')
+			break;
+		t =3D t1;
+	}
+	if (!btf_type_is_struct(t) && !btf_type_is_typedef(t)) {
 		/* Only pointer to struct is supported for now.
 		 * That means that BPF_PROG_TYPE_TRACEPOINT with BTF
 		 * is not supported yet.

