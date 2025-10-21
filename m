Return-Path: <bpf+bounces-71486-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C13DBF4389
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 03:06:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 132C93B73C2
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 01:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC5B2214210;
	Tue, 21 Oct 2025 01:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K10jsOlW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 030A516CD33
	for <bpf@vger.kernel.org>; Tue, 21 Oct 2025 01:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761008780; cv=none; b=fjiXjaObRCwwcsbcvZIE89nldKgSSC/LoOZkfFiwtncm7zRUurYZW6x9fRrllSP8oY8MpDOeo80vY6SVPbe20jHZYgrL8DMuKmOhFN92sRYpcrLjH5nOP9ykRHwpM5nvc0yRQqp0NQ2NdgdUOVt5PWjifuWEdMHEKzDysjZn5yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761008780; c=relaxed/simple;
	bh=xUuHHljOFEdYCvkkVUcG2yNKYjdPagL7eq358zZ15x4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RW1CYDxlroskKmlG8El0PoyORBhaqiCQyvLbwIYmVbjuS6MvMswkfcGXf6cKcRXy26T9bPHpNFF67DcM6lhamUhIUzK0r29rCJ85eFUDzr1kxGMY31fP5Wad1XL0wvdEPAdkQquWFvD5bDpoXwpfVW4mzXEXFt4BXsvJa5HWNEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K10jsOlW; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b556284db11so4249602a12.0
        for <bpf@vger.kernel.org>; Mon, 20 Oct 2025 18:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761008778; x=1761613578; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+63y6nXBzztYrhoSW6YELYnT99ah/4Fb8gojWvD1Sa8=;
        b=K10jsOlWY7XRHq2Ed/vHvjparvIAlgN1kmlb/p8NO8WFbJ3W9a94zrbAOHXHlOTWzq
         8JfkB/v2vuOlj6GgIcp9ZaZsibfnalLH17k7u/DPvV2KOv9QNtSJrFCxeMIZXEFLeoQB
         +tbdANtxgbyk6OENqOd9maCgKHUokfjmHLiX/sQfgbVNyn/C8nEMtlQ7IudRny+ILtlj
         ANaZYDS9RLRpeudAwXEjePaFcM8cAiMOPrMxI/deqaoQgz9S9sOAR3orxmutwWHbyYvm
         w1qUs9sijBptGa/25o5DR6hgtXM9hN8elU5i3IBcxDwP8WNeWDxzJfWv7cNbJbMHgFua
         jJtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761008778; x=1761613578;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+63y6nXBzztYrhoSW6YELYnT99ah/4Fb8gojWvD1Sa8=;
        b=vFMvYKaNCUr0XNm1TQIY7rvJccBRqfgsrM1/4Hc9O2JBxdBdRn0/cd26L82Bc74RZt
         4UJ/EdUadAqaVM9ZixX+mTIdZ6caVUgWt4qPw2Pf2bRNGwo52YFUue75V1h+BcBU8vxN
         FroHbdNvaEYBPqwlP1s/Ybl5ziEV9IMscO2D7wsupz4eYdhgFmdMaryXsOYi2oJ9bmCS
         2hMwBxda+qMi03dId5hb9iW787xWQO2HpG9uF1FHBPo/zBZEzC9PsjH8FNbXzGGwg6p1
         lZaFdPaB4b6maWIIukQHd1t61Y0mfIk2SP64kzewL81MsPNmTeQ1N7+PgERqWWEimc/n
         sqSQ==
X-Forwarded-Encrypted: i=1; AJvYcCXEgBPXI3TWW0lfit7JGhMv/7D+h19qf99H/V/aAh94FD77EVSTFSej2NWsNKn3zggXrtw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBFVD3rIrd1YKGzuKNLNc7TJSO7ym9L+kbJGa2G33o1dbya5u7
	PMWZM8VhJm0Ooa3aKdv/peH1NttJZvFBe7sWywm/vaKQcMuN60+87qzY
X-Gm-Gg: ASbGncsfa2cX3mRfkYbFa+FEBIGuV+m3wm7/hGCxyHk6S4z3xm06jaCEHvftI4v/o51
	x/JDOP+19muGJM8GIPkc+PT/uO/s5SisC/C3+TctAX9O36H3SCr0Q7Pp88hWatSrjWTM38+12Td
	OaWatNYVclceuN1/32RL6N9oXyh63cbi15KMDmukq+is72y4u7a/aTFe32ZIwUSOvnywVCdvt2m
	xodQHiCMrtFKG1aNiVJ0rRh4Q1W3V7SNymYHp5En8iPM/FKAZqwMCL0nUPJWJU55Ih3Yt/MotHx
	DtsikU91Vo0zlA87YoBjLfhFnCe/4/DTZlRv6ofq3DVyP8jh80+9JaIrOxXhPQ6FLUuE6X4YYmH
	l/28tweWqnausby/mJ0lYEypy5akDeoQ+0sk/o50nO0czeu+cLu/5KWbTy+YEOAchPkVjKJ0sPc
	e5IfbZnX7ACPVf4iTtadMtXOAsmg==
X-Google-Smtp-Source: AGHT+IFHp3nJbq1iBMXBd1/3CdZaGtu/ESeFDqoXznrwJB5IngEJkzQth+ImAUyhapBjqU5QVG7c1A==
X-Received: by 2002:a17:902:eccb:b0:28e:80d7:662d with SMTP id d9443c01a7336-290cbb483demr195431325ad.58.1761008778137;
        Mon, 20 Oct 2025 18:06:18 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:badb:b2de:62b2:f20c? ([2620:10d:c090:500::4:1637])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29246ebd215sm93327565ad.14.2025.10.20.18.06.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 18:06:17 -0700 (PDT)
Message-ID: <76e2860403e1bed66f76688132ffe71316f28445.camel@gmail.com>
Subject: Re: [RFC PATCH v2 1/5] btf: search local BTF before base BTF
From: Eduard Zingerman <eddyz87@gmail.com>
To: Donglin Peng <dolinux.peng@gmail.com>, ast@kernel.org
Cc: linux-kernel@vger.kernel.org, bpf@vger.kernel.org, Andrii Nakryiko	
 <andrii.nakryiko@gmail.com>, Alan Maguire <alan.maguire@oracle.com>, Song
 Liu	 <song@kernel.org>, pengdonglin <pengdonglin@xiaomi.com>
Date: Mon, 20 Oct 2025 18:06:16 -0700
In-Reply-To: <20251020093941.548058-2-dolinux.peng@gmail.com>
References: <20251020093941.548058-1-dolinux.peng@gmail.com>
	 <20251020093941.548058-2-dolinux.peng@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-10-20 at 17:39 +0800, Donglin Peng wrote:
> Change btf_find_by_name_kind() to search the local BTF first,
> then fall back to the base BTF. This can skip traversing the large
> vmlinux BTF when the target type resides in a kernel module's BTF,
> thereby significantly improving lookup performance.
>=20
> In a test searching for the btf_type of function ext2_new_inode
> located in the ext2 kernel module:
>=20
> Before: 408631 ns
> After:     499 ns
>=20
> Performance improvement: ~819x faster

[...]

> ---

The flip makes sense, but are we sure that there are no implicit
expectations to return base type in case of a name conflict?

E.g. kernel/bpf/btf.c:btf_parse_struct_metas() takes a pointer to
`btf` instance and looks for types in alloc_obj_fields array by name
(e.g. "bpf_spin_lock"). This will get confused if module declares a
type with the same name. Probably not a problem in this particular
case, but did you inspect other uses?

