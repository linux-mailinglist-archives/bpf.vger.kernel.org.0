Return-Path: <bpf+bounces-72482-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B16B8C12A65
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 03:19:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 32DEB4F10A4
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 02:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8DCE23AE9B;
	Tue, 28 Oct 2025 02:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UD5tX09z"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5AAC1D7E41
	for <bpf@vger.kernel.org>; Tue, 28 Oct 2025 02:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761617944; cv=none; b=YcaqkgsBRCj3WR9NM1Is631v/6LLWpzJjjVkdTBVVmeM7i5Ilv3IGsbuPh/amzZFGzhTjQIypgvnMP68k0iQoJ32/eVaGUSKVcNnlaQRaicbnZdiYNus2u80Fl1HeNZaXuua6dxX5UeV9c+L+PgyROiYPiFOvvAzu5L6QgBBS0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761617944; c=relaxed/simple;
	bh=wUrzYZVlpyiPMeDu/2DVjoebFrvXatkNqm72yhlCLN0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=grdiprl0GfMP6a9QBApK9KLXtz9CaYLrF5NJiu2X+St81Ow54jJOEGXl4qpVGq7DdRH5825BKaYcSbhXtMXuGJSN/hi+fjWw3O31KVlPoC3x7TpO4noJr/dMGEA0LHxQLOs3hHNqEqWNlH5Hq/ojtQ2jYT6f4emRh7EkXpIiXZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UD5tX09z; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-63c0eb94ac3so9608123a12.2
        for <bpf@vger.kernel.org>; Mon, 27 Oct 2025 19:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761617941; x=1762222741; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AN510ZMpd18wGhePif0lPafM6Nb9iWSBr18OTXAbR0A=;
        b=UD5tX09zJILmIhXmscaJo5ceODhWhEzxTlH7+x8WFVMnF+hrwS+B54xQ6Oe9LDMJ0N
         R+3+dCWkP/Wb7NiUVCgSVrcwCyn0G98gojXmmTR/3hwru3L2WPXBsCSm/kbfP4zDIUAD
         t2eap7aF2SlQKRkpzA8ndMiAvsg3EYb9URzbmhhIbgf1eve9XRoj32z0oa5no0MvctXL
         Euus6v5rNCCc8P6hy2betWW4JlJVjWTiiPLHIlNmFSqrFyuhqLDPJCNumw5qeDeb5m4W
         +zZlXtl6tsz0uW5FKWh0S+bv1E0i2zQFxtODZ7eMhjm0t0qEuo3DFIPQI4LdRtfv0WMR
         Ifdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761617941; x=1762222741;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AN510ZMpd18wGhePif0lPafM6Nb9iWSBr18OTXAbR0A=;
        b=smPil2dFVrk/ZHH1oBKwyz+UMfkcKNsjTa6QAuMcr/SLdNJ4xwOOH+N1dWPCtOgm2S
         bfYIeKowIHJ+eFm3ZSOCjR5/sETAkBM+YAZCeFteLZ33uwq1pw/3FTBw5oETBXhrAMs2
         nzWVFoJapMgFQzNoqYrx1AlaA5VUSnlky8KskHlxn82pm5uXTrzCwe4PTsI8zzS2YoX3
         r3y27bTE71LB69m+GYKZ718ktdL4r+svI534laGETaepD0FKRIHQCkeMJ8rjEqXI0L3h
         qZ/1473RfTY3XE+OoD8c4/CWysSQD0Eq8XauB+iTkEIEycULeOs0tBrOPjnevIbXBnsQ
         sLOA==
X-Forwarded-Encrypted: i=1; AJvYcCXa7O6QLZYUpfwE33wx72H2dmj1OnVj3SMgb5Tgdtox1lfpsjA9LBPeedk1d1JDqKTKgGc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLRlczCBNadReqAQqQ6Gud6C0ExK6jkAbpLHq87jqoz5XIfcbA
	GBfI8eDU4cLCPWIRAVgEN6qPi4t3n0fyPLiZCPoJeoPwrEoGHandYE6t89YbFKC18/2QZDPQW2Z
	/CQIRfdYpxl+vdp5PBtC5lhU6bdhBZsE=
X-Gm-Gg: ASbGnct74gn0eArI1etB/oSeFZjt0J+n3KmkyAkjRd8syJoxyxlqwRpXayvt9smwFJZ
	akMsJn/TR7KZMUtLt85AMH5aWWZcdLW54v7el6ZCkeJDHn6Kv+qMNsnBO1NHMlhd8kywXFh9zPa
	nt+fLUCL6oh/7SJ74Tg3Ts/A95KPnrfAD14V7ZNCOB5saXfr6rtp8078m7yqjb5Ivqr6Tm+NQcq
	GdYLeKL7SXukLGgEdt8YkoVswAK2H/ko690x9bzKV71Q/K89n6onNm8oL6I+0gGJvUcXi6r
X-Google-Smtp-Source: AGHT+IFaeiMil37TfUWLDdiI45hMGvdiKJDEANP666ZOSHDxzSK6WS0C1Hplz9vcdJS1CTShLHgekTPjcP6/7Z0vX1Y=
X-Received: by 2002:a05:6402:5113:b0:634:7224:c6b5 with SMTP id
 4fb4d7f45d1cf-63ed8266d91mr1744511a12.28.1761617940813; Mon, 27 Oct 2025
 19:19:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027135423.3098490-1-dolinux.peng@gmail.com>
 <20251027135423.3098490-2-dolinux.peng@gmail.com> <6e7ef94cb4e2d7fbc82676b2af1a165cac620aae.camel@gmail.com>
In-Reply-To: <6e7ef94cb4e2d7fbc82676b2af1a165cac620aae.camel@gmail.com>
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Tue, 28 Oct 2025 10:18:48 +0800
X-Gm-Features: AWmQ_bkDfsyvvmcYCiAEQKQCeupP_Qvm5g2X7LvMYt4ywV38fGg4BM6et1J8JJ0
Message-ID: <CAErzpmu19JkTffsqXxmcppbUON4_03ZjpcxcCQntNo9HG_-uvA@mail.gmail.com>
Subject: Re: [RFC PATCH v3 1/3] btf: implement BTF type sorting for
 accelerated lookups
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: ast@kernel.org, Andrii Nakryiko <andrii.nakryiko@gmail.com>, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>, Song Liu <song@kernel.org>, 
	pengdonglin <pengdonglin@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 28, 2025 at 3:06=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Mon, 2025-10-27 at 21:54 +0800, Donglin Peng wrote:
>
> [...]
>
> Question to Andrii, I think.
> It looks a bit asymmetrical, that there is btf_check_sorted() in
> libbpf, but library does not provide comparison or sorting function.
> Wdyt?
>
> > +static void btf_check_sorted(struct btf *btf, int start_id)
> > +{
> > +     const struct btf_type *t;
> > +     int i, n, nr_sorted_types;
> > +
> > +     n =3D btf__type_cnt(btf);
> > +     if (btf->nr_types < BTF_CHECK_SORT_THRESHOLD)
> > +             return;
> > +
> > +     n--;
> > +     nr_sorted_types =3D 0;
> > +     for (i =3D start_id; i < n; i++) {
> > +             int k =3D i + 1;
> > +
> > +             if (btf_compare_type_kinds_names(&i, &k, btf) > 0)
> > +                     return;
> > +
> > +             t =3D btf_type_by_id(btf, k);
> > +             if (!str_is_empty(btf__str_by_offset(btf, t->name_off)))
> > +                     nr_sorted_types++;
> > +     }
> > +
> > +     t =3D btf_type_by_id(btf, start_id);
> > +     if (!str_is_empty(btf__str_by_offset(btf, t->name_off)))
> > +             nr_sorted_types++;
> > +
> > +     if (nr_sorted_types < BTF_CHECK_SORT_THRESHOLD)
> > +             return;
>
> Nit: Still think that this is not needed.  It trades a couple of CPU
>      cycles for this check and a big comment on the top, about why
>      it's needed.

Thanks, I will remove it in the next version.

>
> > +
> > +     btf->nr_sorted_types =3D nr_sorted_types;
> > +}
>
> [...]

