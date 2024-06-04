Return-Path: <bpf+bounces-31390-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BD6D8FBE81
	for <lists+bpf@lfdr.de>; Wed,  5 Jun 2024 00:08:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 374B8B222F6
	for <lists+bpf@lfdr.de>; Tue,  4 Jun 2024 22:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFEE9132135;
	Tue,  4 Jun 2024 22:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kWfXuL5X"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA2F320C
	for <bpf@vger.kernel.org>; Tue,  4 Jun 2024 22:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717538902; cv=none; b=BFEY6+Ta3i+DNGojgEwbWvzZDoG1KskK05hUa1r6iWk9/tlRR7N0Wfw3KfeZ4j3zCZAu1FfZlGk1kqdfZaiE7AnP0QrV2l+RrNZtP1Y8gBrMg+T6QBfSv0DpFGm9igFRlDcTeLYzWEuaLlAhbt6ftTdLXZ2picVSX4lXmTtpoG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717538902; c=relaxed/simple;
	bh=2UHxafmNIroRa9lt/8W11lnZC2zboaugtQpWvTXPRuE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DUnE/qytbsxyjNPiaLAEQk+b8Cb3GRj6FFbE4pQhOZPWdPwAEGZmE/9FghBbkCzt1r827AKoEEgI/C5LJEs6m2qYZQ29ukSs98BQ4I9a2AkZXpBsOK+nAbpNbZluV2XqOqX3xHW+BEiQAr7Y7rjk1OA54nlQBBpBwGLG9qtsXEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kWfXuL5X; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-6c5a6151ff8so1272884a12.2
        for <bpf@vger.kernel.org>; Tue, 04 Jun 2024 15:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717538900; x=1718143700; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lo9krNuWjLkGtBE+KNxfBFFI+lfHTSyKrDY2KbIpFeA=;
        b=kWfXuL5X7gHAEIo9z+9PBlDFwZzxlhlmk5o53aWm/xScCIu2fjPrROvVXkL6nVMxtc
         wKj961dcvMpyK1iRvhFzvEcd/O3C4ZXC9Vyoiq2pXQKgO0ocAT7mcXQe9Hw/34JZ0Zsg
         2eTzrdtRPNtf1Lm8pbqUYvIZg4N91egu3c8RtV6azjktFLqxKGAOTq3R6Accs7Lufdg9
         l5exujDrAkiL+/nY9n9lxJhw89k2XgLOa9CH+09v0T7SrVKM9tsE36h+A7xaXmXWwpQe
         LCkTsYyFetT8GjRZHLhK7PFPn/y8TuaowJ32ptEU/TVSETO72mnviszcJCGPN1GwI00C
         eMEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717538900; x=1718143700;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lo9krNuWjLkGtBE+KNxfBFFI+lfHTSyKrDY2KbIpFeA=;
        b=cUixmGq/t/XzNc36dbMKZPFmgB4IpaTXKtwqqhUm0Tk6qGnFq1ltiNX+6fXW+j1OCa
         dHeJ6Zim3/P/Ued09gnem3kEIgqBF4XMFpSFY1o4wORQClELWJDlOR2b2hS6doQSHOCS
         28PBaq+f1iHtvpiUTUwllwXrC5XTtYRAb3o6FjSLpzHWaMkcFu6qYFDU3j9G+oUsBMNr
         CzaL0PNT92CpbjzNfXsTT4Fnrt3UK1Mh8m6BUBiiVDv8lJ1XLymQQdHk4GsaeF8Xwb3Z
         NWgqvXnAkIkJqQSbzd/9ZmnA2vgVMRO1gewC5x+fQAqieccuVGZ2ARdplj/scWW7of21
         6Ksg==
X-Forwarded-Encrypted: i=1; AJvYcCVjq4M4qLriexQTVUCLyaQnsuzrsfeEExjShx9aj+IRSk6r2Gp/Q7ERm7HTskAPrbg7hLtu2jhrz+turqfKgi4BT27A
X-Gm-Message-State: AOJu0YygCU2tyssrDBuyYyh/9CC5FQIzvetcsBPVy4RC/QGq9EfJ/rn3
	zGRFpcCPf6tdHjdoEEM9PUiCtBT9hu6oIvqwT1yIkuYS3aq2iq5o
X-Google-Smtp-Source: AGHT+IFjpYyQ+yxXHqAwfZ9uKg5Hl7JD6A6lvccEEnfMvNpGB4gE1Tzg9ALYHVoqgArVZwx1pz7D6A==
X-Received: by 2002:a17:90b:3544:b0:2c2:3762:2c18 with SMTP id 98e67ed59e1d1-2c27db18c8dmr812030a91.22.1717538900080;
        Tue, 04 Jun 2024 15:08:20 -0700 (PDT)
Received: from [192.168.0.31] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6324032f9sm89428635ad.242.2024.06.04.15.08.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 15:08:19 -0700 (PDT)
Message-ID: <7e0c896b359d00b077fafa52ea7896281741034b.camel@gmail.com>
Subject: Re: [PATCH bpf-next 1/5] libbpf: add BTF field iterator
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
 ast@kernel.org,  daniel@iogearbox.net, martin.lau@kernel.org,
 alan.maguire@oracle.com,  jolsa@kernel.org
Date: Tue, 04 Jun 2024 15:08:14 -0700
In-Reply-To: <CAEf4BzZRFB0ATkF+g9U+s7E+MwfhiWefZU7jT_WhLqP3TtQ_Og@mail.gmail.com>
References: <20240603231720.1893487-1-andrii@kernel.org>
	 <20240603231720.1893487-2-andrii@kernel.org>
	 <91750196c22c77d28d016ff51ff4bd3452d499e5.camel@gmail.com>
	 <CAEf4BzZRFB0ATkF+g9U+s7E+MwfhiWefZU7jT_WhLqP3TtQ_Og@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-06-04 at 14:40 -0700, Andrii Nakryiko wrote:

[...]

> > Nit: it is a bit confusing that for two 'if' statements above
> >      m_idx is guarded by vlen and off_idx is guarded by m_cnt :)
>=20
> I'm open to suggestions. m_idx stands for "current member index",
> m_cnt is for "per-member offset count", while "off_idx" is generic
> "offset index" which indexes either a singular set of offsets or
> per-member set of offsets. Easy ;)

Well, since you've asked, how about renaming like below?
At-least 'off_idx' is always compared to something with 'off' in it's name.

---

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 1de7579f2a08..9ea09b808459 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -5169,7 +5169,7 @@ __u32 *btf_field_iter_next(struct btf_field_iter *it)
 		return NULL;
=20
 	if (it->m_idx < 0) {
-		if (it->off_idx < it->desc.t_cnt)
+		if (it->off_idx < it->desc.t_offs_cnt)
 			return it->p + it->desc.t_offs[it->off_idx++];
 		/* move to per-member iteration */
 		it->m_idx =3D 0;
@@ -5183,7 +5183,7 @@ __u32 *btf_field_iter_next(struct btf_field_iter *it)
 		return NULL;
 	}
=20
-	if (it->off_idx >=3D it->desc.m_cnt) {
+	if (it->off_idx >=3D it->desc.m_offs_cnt) {
 		/* exhausted this member's fields, go to the next member */
 		it->m_idx++;
 		it->p +=3D it->desc.m_sz;
diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_interna=
l.h
index 9f4a04367287..aa32b4537dba 100644
--- a/tools/lib/bpf/libbpf_internal.h
+++ b/tools/lib/bpf/libbpf_internal.h
@@ -515,11 +515,11 @@ enum btf_field_iter_kind {
=20
 struct btf_field_desc {
 	/* once-per-type offsets */
-	int t_cnt, t_offs[2];
+	int t_offs_cnt, t_offs[2];
 	/* member struct size, or zero, if no members */
 	int m_sz;
 	/* repeated per-member offsets */
-	int m_cnt, m_offs[1];
+	int m_offs_cnt, m_offs[1];
 };
=20
 struct btf_field_iter {


