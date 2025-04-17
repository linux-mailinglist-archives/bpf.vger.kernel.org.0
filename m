Return-Path: <bpf+bounces-56160-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C451A92BF9
	for <lists+bpf@lfdr.de>; Thu, 17 Apr 2025 21:54:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BBAF4A2850
	for <lists+bpf@lfdr.de>; Thu, 17 Apr 2025 19:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3ECB2040B2;
	Thu, 17 Apr 2025 19:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BJLOm9/h"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f67.google.com (mail-ej1-f67.google.com [209.85.218.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F5B1EF38F
	for <bpf@vger.kernel.org>; Thu, 17 Apr 2025 19:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744919689; cv=none; b=VFK53Kz4/66RrLD5ppzDC5deo1Jw+RwBO2uhUsis/Q1ntV2dlvOtSSjPJa4OcMWv6FD6bd547ReRRu8t5h7tDlSQ7ccJG7u7vVvja1H5G9y4QSQkQ2WAPRVGJHvHLuvv9poFAlKouXI17NwXb3f0AW3OoHuTKTGZg9TEuyE6gak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744919689; c=relaxed/simple;
	bh=b26QPHetjIYxSztRii5qHs2xKKJ5QKtbkFbrKZQn6qM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AfHSj2hb25AXfuHSw7ouI2I6VvavTSkHhbU3O7VWFntOkph0hqlUaDLJFUeb+WctFjzdi1MOTs5Q77JMoFFu7tNh8IN2/xEaaGQmrj2KUNIcMrZvDQZP8rrOjh8kDGwgY+r9kl7Pw4L/OkAsc79e/zRY79Afhx0WPuPNuOz1T+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BJLOm9/h; arc=none smtp.client-ip=209.85.218.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f67.google.com with SMTP id a640c23a62f3a-ac2aeada833so234168766b.0
        for <bpf@vger.kernel.org>; Thu, 17 Apr 2025 12:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744919686; x=1745524486; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CEwA8M2Qdaa/Mrr+hhtjTxuNXNRW/rZbhdUmONze3gA=;
        b=BJLOm9/hmQ+Ilw6RPavqD5+zjyeX71VxkU6mLvwKQlkwswNv+h3LkoniOZBOCNWSJO
         i0vIayFcwI7toe1geHoaLbFNci93UdeF6XgCdUM8SmUnCeM1GZGsTYMG7UKS4PLTwxTV
         BE93WP0LtBSE7tBk8nSgoY+G9fn61Pdy57YY75oLEK8GppsEGqHOT67ReEgmkCFDGxlI
         qaegoRoJFLf4d8fnSk7zook6MmBqZSWupFaRWPWBS464v5UjidqDepo2cBciOKxoTRp4
         oTN9vFDZ3jRNcluOfG5Suzz1MUTn0btEC2IRmydlrDXPKL7eKJLBc4O8ag/78tsK7AAp
         /gQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744919686; x=1745524486;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CEwA8M2Qdaa/Mrr+hhtjTxuNXNRW/rZbhdUmONze3gA=;
        b=NOignTZ+nXMUnUmS7ajEShaZPrTb7WRtlSuS3LazRzAPRuVhEjYXp4pYiUDt2T7Rfo
         S0NT225K2bJnCIrNooxHHH3Xq0lBClp9GH67X2Sr+m20tmXk9p42pHl3WNWH5cTLYjVq
         jAIs1zyXD6ZNamg2Nhl4PyKqUMD+RtpxMLwz6V7Tm0FPqv2kdzVhAE4Nt+9sD/hSTYhB
         KnmkNOOi2DUludbSywadAR+6QrnWNFoexZnAbSXM8x+cLJSbMcMqQSqlI2gUWT/TaLi8
         MNBnLob+Usk8hKeGX+raNH+8KlBECC7QKiRmG6oBFMvcABWD92u13y3n/1Y1WXvs8azR
         9WIg==
X-Gm-Message-State: AOJu0YxvZmcBPkaOIqTfo3C5DbuqTfPcuVLllSEUPtKqTdb+ukbJPVOl
	TXujXfHcH5oq4LW2UPC+qBWqZLRpVMu3ZNviJPLvAxIMejwIBQkLCsCqSKNZvb9gV2IbGQfjEY4
	ufTbRIo3Z5yZUwox5od2/Qf9LcSg=
X-Gm-Gg: ASbGncssFbY+/K0A3ywd826K7SHSAjztnme0IXT+MdW2vwDW9xCvg66pl5WOljEcQjH
	42rFTSSXMzPDqpeSrrdeeE/HVApGu5yK/5V8QclyqCqEECtrx9RHH7WjCqBtGIi5kGcD9ZjEJBm
	29hO9OfNJLygK12E73VrpTlW1+AfEFsUKNRgXpwGta9No=
X-Google-Smtp-Source: AGHT+IFrAdoeWet7fHg/5eYUQcWCBnhXQjeHXUOmwTklemxwn12DV5v5cduW/czFyxxmalpHXe6E+nu2qFYOgxaSIbc=
X-Received: by 2002:a17:907:7fa9:b0:ac6:e29b:8503 with SMTP id
 a640c23a62f3a-acb6ec0bf9emr92900366b.1.1744919685844; Thu, 17 Apr 2025
 12:54:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250414161443.1146103-1-memxor@gmail.com> <20250414161443.1146103-3-memxor@gmail.com>
 <CAEf4BzaoiQ7-OETFL7aPvOnR0g3GKJfJdRPp=+C7ErD=y-R2bQ@mail.gmail.com>
In-Reply-To: <CAEf4BzaoiQ7-OETFL7aPvOnR0g3GKJfJdRPp=+C7ErD=y-R2bQ@mail.gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Thu, 17 Apr 2025 21:54:08 +0200
X-Gm-Features: ATxdqUHrTxYVszNZXVJd2ulfYuXKDYXocZQhmQUVc_CT3oWSRve4fsY-DLrx1DI
Message-ID: <CAP01T74bV+PTP0Z3tsjGSQJwaNgjBi_pPm1BANUWnSs8065_0w@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next/net v1 02/13] bpf: Compare dynptr_id in regsafe
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Barret Rhoden <brho@google.com>, kkd@meta.com, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 16 Apr 2025 at 23:04, Andrii Nakryiko <andrii.nakryiko@gmail.com> w=
rote:
>
> On Mon, Apr 14, 2025 at 9:14=E2=80=AFAM Kumar Kartikeya Dwivedi
> <memxor@gmail.com> wrote:
> >
> > Now that PTR_TO_MEM can be invalidated due to skb going away, we must
> > take care to be more careful in regsafe regarding state pruning. While
> > ref_obj_id comparison will ensure that incorrect pruning is prevented,
> > since we attach ref_obj_id of skb to the PTR_TO_MEM emanating from it,
> > it is nonetheless clearer to also compare the dynptr_id as well.
> >
> > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > ---
> >  kernel/bpf/verifier.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index a62dfab9aea6..7e09c4592038 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -18426,6 +18426,8 @@ static bool regsafe(struct bpf_verifier_env *en=
v, struct bpf_reg_state *rold,
> >                        range_within(rold, rcur) &&
> >                        tnum_in(rold->var_off, rcur->var_off) &&
> >                        check_ids(rold->id, rcur->id, idmap) &&
> > +                      (base_type(rold->type) =3D=3D PTR_TO_MEM ?
> > +                       check_ids(rold->dynptr_id, rcur->dynptr_id, idm=
ap) : 1) &&
> >                        check_ids(rold->ref_obj_id, rcur->ref_obj_id, id=
map);
>
> hm... shall we split out PTR_TO_MEM case instead of making this
> not-so-simple condition even more not-so-simple? or (if people don't
> like that idea), I'd rather have this special PTR_TO_MEM handling as a
> separate if with return

I can split into a separate case.

>
>
> >         case PTR_TO_PACKET_META:
> >         case PTR_TO_PACKET:
> > --
> > 2.47.1
> >

