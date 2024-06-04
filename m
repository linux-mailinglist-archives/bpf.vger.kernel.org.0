Return-Path: <bpf+bounces-31389-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AC6E8FBE28
	for <lists+bpf@lfdr.de>; Tue,  4 Jun 2024 23:40:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8877286BF9
	for <lists+bpf@lfdr.de>; Tue,  4 Jun 2024 21:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EC9914B977;
	Tue,  4 Jun 2024 21:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aU+L1B+y"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A4913F441
	for <bpf@vger.kernel.org>; Tue,  4 Jun 2024 21:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717537245; cv=none; b=CsTdBFl8Dtdjb+zJD0ARwOwjDGj5LQhu6PhJKdtjq6K7NEKjx37ZopUmEl63laqgRl9W7XmXtgtYnC2b2NmXdLJuAhAAIqhOivB0JPiJeWBin8Ays2GKiyqfzl9BAUsCv7JTKkLCeImp6E9bjCN59DXGosrtD8tW6peEcV1Y+6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717537245; c=relaxed/simple;
	bh=fn5CwwedJ/jAxlCtDabN2AQK/qxd3lSqIcW3rd7Dezc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NeYSCXcmQKzy4h5xxcFcWWnJb+mSU7x/V48mNmHFAuF7LvVroATBhTMpc70G3Ca46a8CK5BB+tSoorDsnuxlyRsRaLLbxk9si48gOHFcS3UuWv+wFdmxRs0hE5UazrFuh7R7x/rMSDB6iA21pakLz4XoGlHfNIaoA9NiGAb2xdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aU+L1B+y; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2c1b9152848so4206962a91.1
        for <bpf@vger.kernel.org>; Tue, 04 Jun 2024 14:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717537244; x=1718142044; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cf/aOGthtBs4x1sZtCGf1kk1tUTk1vJPPRq/ynTeHcg=;
        b=aU+L1B+ytPuddhCV5dbiPTl65PGcMwWuxC430XakZtq2pDPTHERpRtFjRwadWHGvlS
         1Md8LZQyn9PFbxjiYQPIqkR3g0E6nyWCs3IrmSZi94rJ8UVdDjBeS+yOEeGPhbS3Pd3/
         JW/IBJXMIgUR/EVB4k+QAHqa56Y/Gf+p221KgB+DaAbnP/HkxdnsSJ6rmX7K9Q4oY2t8
         8/lt4bjco6iZdgChY+B1B/kVImZn3u5C3HtJnVyJBpHOiP+yz43TBZP+sy0pNzBLE2ju
         MB9kecpdo/lI1sJ4T7jByMsoxDjyMLK8qe93iGB4IlgOtmtootE2h4rvGTfTTaN0Wtub
         VioA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717537244; x=1718142044;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cf/aOGthtBs4x1sZtCGf1kk1tUTk1vJPPRq/ynTeHcg=;
        b=IToVXbon6JQ0ZxhbJJfupeoJJkbiQ7GyNXl8CaUK4XQfDknLLe/dcKqs8Sb5Qn/IbD
         r+HQwvAYlUd9rbBoW75jQNeVr4YifqxFp8wE9cTpkoCh4c1bvS3/07Q+e1tTRyI7LBnw
         PGTLc5+NrA4J9O/sYPVap+m1/ePgoQlw1YfhP9/40nT0HTBV9l53wE73V7lENu/X6+jB
         25lyVzq3JV338X45Kipf3VnoFeXU54RlihRESaKBfJJ4GFvsexYcMwFqIvn+eyzxP7G/
         9YWe9EuvOTHZ6h9IXDtHYigwPyvJS8WWDwFCFfdQHrp/Mt15UidObXmgEIyvQ0m7UrAK
         bE7A==
X-Forwarded-Encrypted: i=1; AJvYcCX2hTm+f6naby1ipIJ9IFEF4kIvnTokkSIgCc7VxFUyfLE8In2UBFcg+zYw6zdNKi35Oc36CKgi6CGZ702d5sedIbZJ
X-Gm-Message-State: AOJu0YyZBE2cSS8V6RVWDadAdJ80ofdWOMmRoa0qvCCgI1Os64ro0mdk
	EprBLvgEkrU67WBU0l393jSD6K/8P+i6iZiFO4+j3TxmcOB6gwGPYwX6sWH8AQCeAgDbBj0O12r
	Q/t5A/Yjv+8eDCx0IOJBw+1YwWjo1fA==
X-Google-Smtp-Source: AGHT+IFSLG9wQ9n2epKKFyxMsAK9xRHAmGZWIINz6j3WaX9teBTW/Um/fcCSepWDCOOgjlEon7yPgkkpEK8+nhfcBtU=
X-Received: by 2002:a17:90a:f00e:b0:2b4:b306:ffbc with SMTP id
 98e67ed59e1d1-2c27db117f0mr667004a91.17.1717537243704; Tue, 04 Jun 2024
 14:40:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240603231720.1893487-1-andrii@kernel.org> <20240603231720.1893487-2-andrii@kernel.org>
 <91750196c22c77d28d016ff51ff4bd3452d499e5.camel@gmail.com>
In-Reply-To: <91750196c22c77d28d016ff51ff4bd3452d499e5.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 4 Jun 2024 14:40:31 -0700
Message-ID: <CAEf4BzZRFB0ATkF+g9U+s7E+MwfhiWefZU7jT_WhLqP3TtQ_Og@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/5] libbpf: add BTF field iterator
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@kernel.org, alan.maguire@oracle.com, 
	jolsa@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 4, 2024 at 1:37=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> On Mon, 2024-06-03 at 16:17 -0700, Andrii Nakryiko wrote:
> > Implement iterator-based type ID and string offset BTF field iterator.
> > This is used extensively in BTF-handling code and BPF linker code for
> > various sanity checks, rewriting IDs/offsets, etc. Currently this is
> > implemented as visitor pattern calling custom callbacks, which makes th=
e
> > logic (especially in simple cases) unnecessarily obscure and harder to
> > follow.
> >
> > Having equivalent functionality using iterator pattern makes for simple=
r
> > to understand and maintain code. As we add more code for BTF processing
> > logic in libbpf, it's best to switch to iterator pattern before adding
> > more callback-based code.
> >
> > The idea for iterator-based implementation is to record offsets of
> > necessary fields within fixed btf_type parts (which should be iterated
> > just once), and, for kinds that have multiple members (based on vlen
> > field), record where in each member necessary fields are located.
> >
> > Generic iteration code then just keeps track of last offset that was
> > returned and handles N members correctly. Return type is just u32
> > pointer, where NULL is returned when all relevant fields were already
> > iterated.
> >
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
>
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
>
> [...]
>
> > +__u32 *btf_field_iter_next(struct btf_field_iter *it)
> > +{
> > +     if (!it->p)
> > +             return NULL;
> > +
> > +     if (it->m_idx < 0) {
> > +             if (it->off_idx < it->desc.t_cnt)
> > +                     return it->p + it->desc.t_offs[it->off_idx++];
> > +             /* move to per-member iteration */
> > +             it->m_idx =3D 0;
> > +             it->p +=3D sizeof(struct btf_type);
> > +             it->off_idx =3D 0;
> > +     }
> > +
> > +     /* if type doesn't have members, stop */
> > +     if (it->desc.m_sz =3D=3D 0) {
> > +             it->p =3D NULL;
> > +             return NULL;
> > +     }
> > +
> > +     if (it->off_idx >=3D it->desc.m_cnt) {
> > +             /* exhausted this member's fields, go to the next member =
*/
> > +             it->m_idx++;
> > +             it->p +=3D it->desc.m_sz;
> > +             it->off_idx =3D 0;
> > +     }
> > +
> > +     if (it->m_idx < it->vlen)
> > +             return it->p + it->desc.m_offs[it->off_idx++];
>
> Nit: it is a bit confusing that for two 'if' statements above
>      m_idx is guarded by vlen and off_idx is guarded by m_cnt :)

I'm open to suggestions. m_idx stands for "current member index",
m_cnt is for "per-member offset count", while "off_idx" is generic
"offset index" which indexes either a singular set of offsets or
per-member set of offsets. Easy ;)

>
> > +
> > +     it->p =3D NULL;
> > +     return NULL;
> > +}
> > +
>
> [...]

