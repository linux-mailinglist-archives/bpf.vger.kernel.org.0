Return-Path: <bpf+bounces-71584-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A440BF7849
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 17:56:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFD821886347
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 15:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D68F343D63;
	Tue, 21 Oct 2025 15:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RtmxI4bO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D080946A
	for <bpf@vger.kernel.org>; Tue, 21 Oct 2025 15:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761062166; cv=none; b=hhki5/VS+GzVyTTluhD81ElIUXxRzUQKhp44QeEkT/dF66e+d2FUQ06Z206LpVDamHVEB0tDmGE1mf03qiK0uMjtHqHMl2/7i0IyLU7tR5RBzoeb4WtX/jxKcFyyZsM5h+78gKvcD7V/EtjSkStWl5aqS2r1lD+Ox3wJlsFPV9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761062166; c=relaxed/simple;
	bh=JYR7iP2GeSeObGGEO8s2n6ldhfxp1AJFvfmViXYS6m4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Eo0EL3x4BZRbLkSOawwllmUpFt3aFYBYeRf7V3K3/qp5P3L2MoaLDDqnTpoLVRYVeQvkWFO71rTDVrYr3N4ASrR5nxwY6Q+sCPXJs2b4Ag7mXYHAwPiVWJX1wUzMAjp2629tXdxw+3Wfq/uSl2VPxQOjwGB6HTOHr53q/ASWpAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RtmxI4bO; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7835321bc98so5120396b3a.2
        for <bpf@vger.kernel.org>; Tue, 21 Oct 2025 08:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761062163; x=1761666963; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9NuM9NxvrAaUomQK+eU5/GRUQ/IUXPFsKBqtif+2vUc=;
        b=RtmxI4bOGjVyU49EtUsnhPHnNL0N6Mgl52kDSNLWSM27h1vRoI7WSo3U6INXoTBRzl
         iULl9FVhBSPOV/4c3cNxXkvTJ/tptOsPYB+wTBIAfvpwLSrSH7RjqHviW5EcuxGzH66U
         KTDwM3RvUhH/Hmsjd7yA8JkhGmgdHw3Hvw9eqSsIWtdawAckTNiIwjTdAfSgRtJJVtb+
         C2A4/eAkpYqJv94AFa8ac9ezEv/p9cauDvX+INy0r9gnwx5nvn2SoApQX976qkSpbzhI
         WI1lNFf+14nwE4KX6fVJWCoVHp+12JNTvTUezk7TJi/wQiGGI6/fsPZac32BlbVShTLc
         j6gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761062163; x=1761666963;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9NuM9NxvrAaUomQK+eU5/GRUQ/IUXPFsKBqtif+2vUc=;
        b=ZguIu6DIqTGnwrNeA7IPMchgk2lJzoCdbS39uDLhUVQ294T4WII6xt/e6IiHKkO3dl
         4SEOqu47F6EeJNfg7sLNUmQPdgvYLgwV06N8qlbSX4J/xJFaBPaXKczhmeCOO7fmrL4O
         VlfTyCbgxJ/EJYikX5JanW0Bh9/qc61R6QUtk7q5xoZlgxZCCdCHqpheRyCTqPKT47fQ
         FMUbC/9lbbq5NRMvPRwi4l28qRhTMp7dZNDyDwywgfzf4Ir0c2IZqGbo0hwplyGcjxK3
         i2hAo3EixYcmjHV9vmT5wKm3EI8zAMC3QZb3j0mAa20fh9hie4uHcoAY+sckB0wB7TBY
         i3jg==
X-Forwarded-Encrypted: i=1; AJvYcCXKeBJtww3XG4P12tksyXWkXGg7BQ/M1c+UsLywqxeCrGzCTA5mh5MlhycxnUfovHxP9vg=@vger.kernel.org
X-Gm-Message-State: AOJu0YywSsN+G9idIYREVlFbCc2rnlGhRcKvcwpx/gKg/6IZ+ZXcO3fl
	2u3r2vMfXToa29xNBhEYMSi+LdDZ+D+oKTuqHq6ymr/344Jkn536bgHz
X-Gm-Gg: ASbGncvNhZIK0OmgIXD5G+QflmFcjO1n01KM5e9MBIOLmYwqb+useaSp/SIuSi0qebJ
	8KiDa76j/ynFCytPkfVgbCFCWboWqMMaIDrq0hRxa1iRO8lyEZfoB9ogHdczDq0UTrbuCV16ZIM
	zrJS0O8K1RhXtSEMkadPs5JDINon0mEvPRW0kDIMKKTb34FkIYuwAsqBjSGeR9O9YL3juQtWBX7
	u4taSRjSGMO0UnHlq1m2NE63KfZgN2aMByAktkNmOueWCRNV7+pGI/XbcCuMxqQbp28w/ZShHUS
	RTURrzmKi35wK+R7TMqH83TYXGAbCoc9/mqxcG5cJw0TY5s36+GERI0NHKScz4foDVscaRRbPuN
	82mdX9Td5W12d9ml1f0ilrlLB4anKBO79DEvdz4XZWbmjOag4X/yob9Cp9BYXH7cmPWdHi9/DCc
	nf19KPK7L76JqM7MPv2/0q9oOZrHnrHEI0A/rp
X-Google-Smtp-Source: AGHT+IHcYUVZInwV5j7HGErIAKOBZtcl/ZY5ioU8jv8MIcJcezR92mWzNOgV5n7d5cG/GiuW4mdsKQ==
X-Received: by 2002:a05:6a00:3696:b0:784:27cb:a2df with SMTP id d2e1a72fcca58-7a220a61ac4mr19382489b3a.1.1761062163287;
        Tue, 21 Oct 2025 08:56:03 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:5f45:f3d3:dde4:d0ab? ([2620:10d:c090:500::6:82c0])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a2300f252csm11638614b3a.38.2025.10.21.08.56.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 08:56:02 -0700 (PDT)
Message-ID: <dacb24230861da2eb8fb5bd7168bdca571727b62.camel@gmail.com>
Subject: Re: [RFC PATCH v2 1/5] btf: search local BTF before base BTF
From: Eduard Zingerman <eddyz87@gmail.com>
To: Donglin Peng <dolinux.peng@gmail.com>
Cc: ast@kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 Andrii Nakryiko <andrii.nakryiko@gmail.com>, Alan Maguire
 <alan.maguire@oracle.com>, Song Liu	 <song@kernel.org>, pengdonglin
 <pengdonglin@xiaomi.com>
Date: Tue, 21 Oct 2025 08:56:01 -0700
In-Reply-To: <CAErzpmvLR8tc0bfYg6mG82gqMSXHq_qXeMsssSDuzirxkSt-Rg@mail.gmail.com>
References: <20251020093941.548058-1-dolinux.peng@gmail.com>
	 <20251020093941.548058-2-dolinux.peng@gmail.com>
	 <76e2860403e1bed66f76688132ffe71316f28445.camel@gmail.com>
	 <CAErzpmvLR8tc0bfYg6mG82gqMSXHq_qXeMsssSDuzirxkSt-Rg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-10-21 at 16:31 +0800, Donglin Peng wrote:
> On Tue, Oct 21, 2025 at 9:06=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.c=
om> wrote:
> >=20
> > On Mon, 2025-10-20 at 17:39 +0800, Donglin Peng wrote:
> > > Change btf_find_by_name_kind() to search the local BTF first,
> > > then fall back to the base BTF. This can skip traversing the large
> > > vmlinux BTF when the target type resides in a kernel module's BTF,
> > > thereby significantly improving lookup performance.
> > >=20
> > > In a test searching for the btf_type of function ext2_new_inode
> > > located in the ext2 kernel module:
> > >=20
> > > Before: 408631 ns
> > > After:     499 ns
> > >=20
> > > Performance improvement: ~819x faster
> >=20
> > [...]
> >=20
> > > ---
> >=20
> > The flip makes sense, but are we sure that there are no implicit
> > expectations to return base type in case of a name conflict?
> >=20
> > E.g. kernel/bpf/btf.c:btf_parse_struct_metas() takes a pointer to
> > `btf` instance and looks for types in alloc_obj_fields array by name
> > (e.g. "bpf_spin_lock"). This will get confused if module declares a
> > type with the same name. Probably not a problem in this particular
> > case, but did you inspect other uses?
>=20
> Thank you for pointing this out. I haven't checked other use cases yet,
> and you're right that this could indeed become a real issue if there are
> name conflicts between local and base types. It seems difficult to
> prevent this behavior entirely. Do you have any suggestions on how we
> should handle such potential conflicts?

What are the results of the above benchmark after sorting?
If things are fast enough we might not need to do this change.
Otherwise, each call to btf_find_by_name_kind() should be
inspected. If necessary new APIs can be added to search only in
vmlinux, or only in program, or only in module BTF.

