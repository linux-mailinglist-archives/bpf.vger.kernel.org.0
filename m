Return-Path: <bpf+bounces-75301-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 6377EC7D39B
	for <lists+bpf@lfdr.de>; Sat, 22 Nov 2025 16:59:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9B92834F65A
	for <lists+bpf@lfdr.de>; Sat, 22 Nov 2025 15:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DE4928D83F;
	Sat, 22 Nov 2025 15:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fPnmzUUL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56BF723BCEE
	for <bpf@vger.kernel.org>; Sat, 22 Nov 2025 15:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763827166; cv=none; b=o0s0SZQWsolc8zYjbjZ3EyFmHqeyMUFAe9muk4oCic/rgG7Yumz2PmWBnRS1BPU4W2fiz0WCHk9JhNfeNXhaC73c3Y46Q0AfG80mwpSp3IC0ML22FWyN54aIO6jZUWuz1wdI3SP4raI79geVD1CBfbcIai8fGGsoc3cpi6mAoaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763827166; c=relaxed/simple;
	bh=G4HlJkJfs+X7j2y+XDuNutjvxRt6GVKQpUi+6mcq/tI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KjkVFVla6M8c+FP46vwK5tOj7b8JjPyvYjcVd4NA4fIGfQCYPv7uqtuQ1ioP7R9vbVcdpfra/uHoc6j76jl32wybusYrFhYRdDNGkbW+M5E7uWkMAc5yYGUuwNUgLsKNnr/vnG57kcS2aCE3rbGIphnQgMZCT2g1s1GZskajQyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fPnmzUUL; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4ed9c19248bso25599841cf.1
        for <bpf@vger.kernel.org>; Sat, 22 Nov 2025 07:59:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763827163; x=1764431963; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PA9HUZf89WC3K4tA59DUHEENRT6niiXypvEHAtpLer8=;
        b=fPnmzUULVk2smzFxzclBxDqInroaNWzwtbhas6RvBH7OTC1AcenYWy4zoSV1IyIqZQ
         xRHGwDvZCxWb/7rmuv8ntlBYhserx/RgWs23U4v7YQHOX/ZGsiyL1CbQBGCN+LIbDdhb
         M2vA9mOg2XJJkiD3Xor5992rKE+YIUzjX+nBvQrXN52RuTPtcJSDYt88NqltYeGr/+mD
         FYCdQXIV/Cj5B8FwgfuuoyjJ55SBJ7eL5gsioctCnXOHCfKvMNbaTMVIkOZYlAPlZbrW
         HB65m8neo2wBu88bcSUJc+5TmT5M+Vjn32BvivMxBvWgWBgtY+2k3eohJoDPsD441yua
         Y76g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763827163; x=1764431963;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PA9HUZf89WC3K4tA59DUHEENRT6niiXypvEHAtpLer8=;
        b=AsYjjFgCC+zyrdM92xGsNRlUaKK6jRaAzk2T5rcD4ZNHC3RwbAqr7w2ubIHU+vHvNC
         ilHi/cKelUTUIeOc1aEXYsUBhNOZ13T5AmiiTCJNT8ZPJw0lqwbYxshr9ZzeVHUG4kA1
         HTxLzvdK6KS/OQM6j2Q5cYf7jzW/pRDW49d07YvElXemCOXNcY1qX5bcCRQ1HW0i2c7X
         GiyVIsADY12IBtTBs+1GAUaUobgjCrHIGh1/o5gqYi3SaF2ZKr0/ZX3l8ppPVHZ5kBcG
         QcymOm+Ol5blco6P92MeRAc12PtITVkLuTDt+I9fyyZ+jC0zSSfiIxJxI0/rAIWky/DG
         4AJg==
X-Forwarded-Encrypted: i=1; AJvYcCXfrnWlu7aMDDWr9b9tBC2nZoVU/CaMqD+jkWz2MKf92+L9CFK36MkkWJ9mXFpYWo1bJJc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8TBnT3pqRDtS8MynxQS8j7ZzXE7O54apTZRdeluGuY6rYZzuJ
	yvU2ShcfdE7TXfNnwDVCsCKjtw8ApOft2noEDSwlr0Kym/YYBQfDsdOfX2cdFkSIpfRWFujm2ZT
	AgxCtxsn1XF9JLPJ5tGq2ISFh0hOkc1w=
X-Gm-Gg: ASbGncvul8l8dMNI9FhhWZBI8hT9w/BML3Ppc7O/RKfFxRZCj+le34hUGESPWAi51Ml
	B3xMmJzWiKisjSaFbnNn9SaHst7UxJC3I+0XZJuA+QjmIwc6u6MOqHtMOrqFI6jrQ42MasyQq82
	iWUkQOOt+IentNgyFGXcMx12k/d9LYZ0OvM1lDIL3OFQVe29zmumu+LMjWyxwdUUDJpZuNLrnrn
	pZWysiDiL3hKyV2i0+4UvwqvTVZhw5jNbT3L5PlGCTFwCRN4v6v9gC4iCDZOo+ChNAtKNeI
X-Google-Smtp-Source: AGHT+IHddH2CmiGu4yHhbW7ydZscAr021whwNH3Os5724F8V8GEPckJW8ZtqNepD3wMzObwCELw+/PBMOY7e3zR/R+I=
X-Received: by 2002:a05:622a:1193:b0:4ee:9b1:e2c with SMTP id
 d75a77b69052e-4ee5885ff55mr84401771cf.33.1763827163166; Sat, 22 Nov 2025
 07:59:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251119031531.1817099-1-dolinux.peng@gmail.com>
 <20251119031531.1817099-6-dolinux.peng@gmail.com> <CAEf4BzYQfHKHUdxv7W7mET1xBXuokvx9v=69HNAkhg_CAPCm-g@mail.gmail.com>
 <CAErzpmvLhKbCYh3hYW=54JJtXj3TV0t2JAmGwy4E3xW7r84OBw@mail.gmail.com>
 <bddc9f1d5c1f2f7f233707cf2af81a2013d46b7d.camel@gmail.com>
 <CAErzpmvP41CNQhRVKuDU23xnBKjj239R6_e5K8DSwcNDo7GG5Q@mail.gmail.com> <f515305c3b250f9dbed003b98d78f72c3d72cc2c.camel@gmail.com>
In-Reply-To: <f515305c3b250f9dbed003b98d78f72c3d72cc2c.camel@gmail.com>
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Sat, 22 Nov 2025 23:59:10 +0800
X-Gm-Features: AWmQ_bmadNsT6zQ-llWrmq0t4fmRW-XRUxqGczgwonIEQIMSyn_eTM4LJxTxzQY
Message-ID: <CAErzpmtaHHuukkep26GTc+r0aTGHNt0LXiJ2aYKz50dD+Acw7A@mail.gmail.com>
Subject: Re: [RFC PATCH v7 5/7] libbpf: Implement BTF type sorting validation
 for binary search optimization
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, ast@kernel.org, zhangxiaoqin@xiaomi.com, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	Donglin Peng <pengdonglin@xiaomi.com>, Alan Maguire <alan.maguire@oracle.com>, 
	Song Liu <song@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 22, 2025 at 4:50=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Sat, 2025-11-22 at 15:19 +0800, Donglin Peng wrote:
>
> [...]
>
> > > - find_bpffs_btf_enums() - this function does a linear scan over all
> > >   types in module BTFs.
> >
> > I think putting names ahead is helpful here, because there is a check
> > (info->cmd_t && info->map_t && info->prog_t && info->attach_t) to
> > return early. but I think it can be converted to use btf_find_by_name_k=
ind.
>
> Oh, sorry, I somehow missed the early exit here.
> But as you say, it is a combination of 4 by-name lookups, essentially.
> Thus can be converted to btf_find_by_name_kind() trivially.
>
> > > - find_btf_percpu_datasec() - this function looks for a DATASEC with
> > >   name ".data..percpu" and returns as soon as the match is found.
> > >
> > > Of the 4 functions above only find_btf_percpu_datasec() will return
> > > early if BTF type with specified name is found. And it can be
> > > converted to use btf_find_by_name_kind().
> >
> > Thanks. I=E2=80=99ve looked into find_btf_percpu_datasec and we can=E2=
=80=99t use
> > btf_find_by_name_kind here because the search scope differs. For
> > a module BTF, find_btf_percpu_datasec only searches within the
> > module=E2=80=99s own BTF, whereas btf_find_by_name_kind prioritizes
> > searching the base BTF first. Thus, placing named types ahead is
> > more effective here. Besides, I found that the '.data..percpu' named
> > type will be placed at [1] for vmlinux BTF because the prefix '.' is
> > smaller than any letter, so the linear search only requires one loop to
> > locate it. However, if we put named types at the end, it will need more
> > than 60,000 loops..
>
> But this can be easily fixed if a variant of btf_find_by_name_kind()
> is provided that looks for a match only in a specific BTF. Or accepts
> a start id parameter.

Yes, but I'm not sure it's necessary to add a new parameter to
btf_find_by_name_kind for just one use case.

