Return-Path: <bpf+bounces-76794-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 01EBACC5816
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 00:43:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C9E6D3002D34
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 23:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A258340A51;
	Tue, 16 Dec 2025 23:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b2hN4BRn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932F733FE30
	for <bpf@vger.kernel.org>; Tue, 16 Dec 2025 23:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765928605; cv=none; b=Neod8DwQ7modBXDn6XMWUTQYT+aLKJ8OJLGbfzKwvc0GZ4wzNtXcw8mqs33Iyt5ClODMcuCW95P38rWU52P7ji/0S6fDqQE0SSOA0HU6W9WgmW1qY1244x1zUa2BtuoJF4MZmuyIBqhaPaV/zcIfIB7J4I4o5RPxmo/vxAaM/eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765928605; c=relaxed/simple;
	bh=Zi6+u84+oRXTkRfAcDFp64t7e0oHyq52imsQ2ARf1rY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=L8R1RxvSSh12b3a3LKQUyGkgOX45N3iwpfYelzXsu6t1sHCrPDLP2OHP13KP2LMIns/16BwLDigZHiQYpg8guZS//rljceDqgwCoayu4XAskMEBf85zJ8WRxiL0PO2w9UyHaNH+t/qAkWQxrEYZ9w6171VwHYcOaYYbOpZRStTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b2hN4BRn; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7b80fed1505so5130068b3a.3
        for <bpf@vger.kernel.org>; Tue, 16 Dec 2025 15:43:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765928603; x=1766533403; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fKNAqWTFF+sYglWcdP7S43C4o3xHJLvET2fj5e3TDjg=;
        b=b2hN4BRnrCsjToz+9Pm1OUSf3hkKjdGAJk2CRJgyGg+kvwIcpVUp9IOZp6nI1Zc8Nu
         UO9L0U4hHBMj5hi/rRPmPKB0sRn7P+FrRUoqfvSnhtNDa6+EpEEjQ5guh34s1YZgSeSz
         PAhjY3mWqsjcIm7mCJEYYFO15koWRD+2B8CbCHQIRxH1aChuaKtZzIwT/C5iwdxedccz
         YHB6wrTyCyqEykjqj3tALWKcsYzIOhCKeIuOnymHf7kzTE83d65/p7T0xW6Y+TmBeP4f
         NTU87gC9NkdnbhBteLtE9UowIsXj9pAFsanbidfe9zdg1y6WK7q4K9CY4uAyt1C6wlwN
         45Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765928603; x=1766533403;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fKNAqWTFF+sYglWcdP7S43C4o3xHJLvET2fj5e3TDjg=;
        b=BG5z9vzbBJldyWQCYajT0sHU/rZ+JrVodF4VgfEJEUCPh2B5M10k/KWsyYF8LksN3T
         XdIXSCPfyjEeArOZ4afjUp1AktkQhbqtQFf/0WIKYqaniFm26VM1x7g5cwjd9Tou85at
         c1XdfZfbAcR9r9uva3OvovGe1amm43yAdQJG1S8D1/wK0SXfnj0TfUjguLtfmmok8aei
         AQkP+YDKFXUfh0oamRxP0TLMu0Nz9f267bR7wIDaPRtdWGO+rdH6Qh6nt38lNHcKaGxl
         HMxhYXh5YIxmz3AUaRguWl1iEi7fybbWWisafzLIDxW57frCJ6kWlQtvgzsR31gvhwPS
         0GmQ==
X-Forwarded-Encrypted: i=1; AJvYcCW3/Q4VXoyLvF4zyCb8kbQKyUKL+Qzg1HfOS5S+trxuKQheY+BtKTDDFzQFAXE6HsFqLtw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3iGKmj4//WuRtxWs6wpqJnawHzn3rjl7cbp9C3BRl6iMMgu5e
	JBySVkY9dM65eQmKMdKHTXjBFTcJrK7hSKihpzOSZDSmviRhuXJ1DBQM
X-Gm-Gg: AY/fxX7X7AeEM59tG5P0GOvP5c9MF+C/fZfZPLkGrxbeyheZPVjUye58oR8lfq3KMa6
	p42cLvBeB+ABb0xkTR+cFZTm/9VAe53y8KjUEfM5pQjkudNLQuFWyWNkufLpL6rcwaRNsUMvS8W
	Xh1VNDXAwHBZtObiCwYJT6YIb87xYlVZsEdTpr+FZnw1D+ac4Y57wUAX7YcaqIhnvNVRBjNeKlM
	2UvA7B/jRMui12lIzHTenss6p83I4eQ1/MIpCvGKPKGjscaDfjcaLaoi1b3nnXmIO2owbiHabzk
	MtAQls+2Hyegbevsga+SOikleSu66iTslb5PmXS3Zg8dfdpqrSshPjfJ6edKveNTq5s4eVtlP6D
	HzsKLObNHPtCGYJi6u7/p2Iu1bSbpPZ5uyn2iq/Qq6Af0yVb/6IOUOKicPuHMtjtKLDzm9pr4uR
	B2B0fzs85H
X-Google-Smtp-Source: AGHT+IFuWVVQpGfu7neSI/oRXyRD3f5hfZKSWnhEgHGaM+dXALjA1R2F1rVtpKvG0LPr4EqQ/lyqlQ==
X-Received: by 2002:a05:6a20:2449:b0:366:14af:9bbf with SMTP id adf61e73a8af0-369b07ae5c0mr14798827637.73.1765928602707;
        Tue, 16 Dec 2025 15:43:22 -0800 (PST)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c0c2ad579b8sm16978305a12.19.2025.12.16.15.43.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 15:43:22 -0800 (PST)
Message-ID: <9fbd1b7714fcd549d5d9c1aea47d50d93297ca26.camel@gmail.com>
Subject: Re: [PATCH bpf-next v9 04/10] libbpf: Optimize type lookup with
 binary search for sorted BTF
From: Eduard Zingerman <eddyz87@gmail.com>
To: Donglin Peng <dolinux.peng@gmail.com>, ast@kernel.org, 
	andrii.nakryiko@gmail.com
Cc: zhangxiaoqin@xiaomi.com, ihor.solodrai@linux.dev, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, pengdonglin
	 <pengdonglin@xiaomi.com>, Alan Maguire <alan.maguire@oracle.com>
Date: Tue, 16 Dec 2025 15:43:19 -0800
In-Reply-To: <cb0afb795b4dc8feae51985af71b7f8b1548826f.camel@gmail.com>
References: <20251208062353.1702672-1-dolinux.peng@gmail.com>
		 <20251208062353.1702672-5-dolinux.peng@gmail.com>
	 <cb0afb795b4dc8feae51985af71b7f8b1548826f.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-12-16 at 15:38 -0800, Eduard Zingerman wrote:
> On Mon, 2025-12-08 at 14:23 +0800, Donglin Peng wrote:
>=20
> [...]
>=20
> Lgtm, one question below.
>=20
> >  static __s32 btf_find_by_name_kind(const struct btf *btf, int start_id=
,
> >  				   const char *type_name, __u32 kind)
> >  {
> > -	__u32 i, nr_types =3D btf__type_cnt(btf);
> > +	const struct btf_type *t;
> > +	const char *tname;
> > +	__s32 idx;
> > +
> > +	if (start_id < btf->start_id) {
> > +		idx =3D btf_find_by_name_kind(btf->base_btf, start_id,
> > +			type_name, kind);
> > +		if (idx >=3D 0)
> > +			return idx;
> > +		start_id =3D btf->start_id;
> > +	}
> > =20
> > -	if (kind =3D=3D BTF_KIND_UNKN || !strcmp(type_name, "void"))
> > +	if (kind =3D=3D BTF_KIND_UNKN || strcmp(type_name, "void") =3D=3D 0)
> >  		return 0;
> > =20
> > -	for (i =3D start_id; i < nr_types; i++) {
> > -		const struct btf_type *t =3D btf__type_by_id(btf, i);
> > -		const char *name;
> > +	if (btf->sorted_start_id > 0) {
            ^^^^^^^^^^^^^^^^^^^^^^^^
Also, previous implementation worked for anonymous types, but this one
will not work because of the 'max(start_id, btf->sorted_start_id)', right?
Maybe check that type is not anonymous in the condition above?

> > +		__s32 end_id =3D btf__type_cnt(btf) - 1;
> > +
> > +		/* skip anonymous types */
> > +		start_id =3D max(start_id, btf->sorted_start_id);
> > +		idx =3D btf_find_by_name_bsearch(btf, type_name, start_id, end_id);
> > +		if (unlikely(idx < 0))
> > +			return libbpf_err(-ENOENT);
> > +
> > +		if (unlikely(kind =3D=3D -1))
> > +			return idx;
> > +
> > +		t =3D btf_type_by_id(btf, idx);
> > +		if (likely(BTF_INFO_KIND(t->info) =3D=3D kind))
> > +			return idx;
> > +
> > +		for (idx++; idx <=3D end_id; idx++) {
> > +			t =3D btf__type_by_id(btf, idx);
> > +			tname =3D btf__str_by_offset(btf, t->name_off);
> > +			if (strcmp(tname, type_name) !=3D 0)
> > +				return libbpf_err(-ENOENT);
> > +			if (btf_kind(t) =3D=3D kind)
>                             ^^^^^^^^^^^^^^^^^^^
>                 Is kind !=3D -1 check missing here?
>=20
> > +				return idx;
> > +		}
> > +	} else {
> > +		__u32 i, total;
> > =20
> > -		if (btf_kind(t) !=3D kind)
> > -			continue;
> > -		name =3D btf__name_by_offset(btf, t->name_off);
> > -		if (name && !strcmp(type_name, name))
> > -			return i;
> > +		total =3D btf__type_cnt(btf);
> > +		for (i =3D start_id; i < total; i++) {
> > +			t =3D btf_type_by_id(btf, i);
> > +			if (kind !=3D -1 && btf_kind(t) !=3D kind)
> > +				continue;
> > +			tname =3D btf__str_by_offset(btf, t->name_off);
> > +			if (tname && strcmp(tname, type_name) =3D=3D 0)
>=20
> Nit: no need for `tname &&` part, as we found out.
>=20
> > +				return i;
> > +		}
> >  	}
> > =20
> >  	return libbpf_err(-ENOENT);
> >  }
> > =20
> > +/* the kind value of -1 indicates that kind matching should be skipped=
 */
> > +__s32 btf__find_by_name(const struct btf *btf, const char *type_name)
> > +{
> > +	return btf_find_by_name_kind(btf, btf->start_id, type_name, -1);
> > +}
> > +
> >  __s32 btf__find_by_name_kind_own(const struct btf *btf, const char *ty=
pe_name,
> >  				 __u32 kind)
> >  {
>=20
> [...]

