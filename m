Return-Path: <bpf+bounces-23073-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD65486D261
	for <lists+bpf@lfdr.de>; Thu, 29 Feb 2024 19:32:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BCB81F26C23
	for <lists+bpf@lfdr.de>; Thu, 29 Feb 2024 18:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BABF7828D;
	Thu, 29 Feb 2024 18:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="kO+egWIP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5883540847
	for <bpf@vger.kernel.org>; Thu, 29 Feb 2024 18:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709231525; cv=none; b=Lvc7dL9HcPvesnDfZMmXXgKko5isUkrFFFDPsqZi5zS6iO9i0QFUVxd5/U42H4aUaPGWNh6W0Y4QSRTD7RPARiFjsb/W5yWbjdg/9uN5/9cdT1tGy6rOr3zBUeN8VzdvuYmEbJJKWt6JmTnReAM+u6DSGVUhFP/cO7XfcNfxrJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709231525; c=relaxed/simple;
	bh=G9HD630sRPzPI72iuyqYlKeo7sS7I5SqO/qDADohpVk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=McpqlTgdTr7GAOw8tfFIR1pK7YjVP+C74B57qP3czZ+RzsCjIIIyRiZlTUql8f2DPq7fBZM454J5YFp2etuSlq7UsbBqlXgtauSO+14xlCXXmF4xBqioWYjLdu4z3uMh68j/Z7YPWelY452Xsbss9UUbpt5xX8j04LjhY/1einw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=kO+egWIP; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-607e60d01b2so8371327b3.1
        for <bpf@vger.kernel.org>; Thu, 29 Feb 2024 10:32:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1709231523; x=1709836323; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oaeBOT+t9mePNFUipxjmnCS7BvLCAtAwOO3iooaJWCc=;
        b=kO+egWIPz8KaCVqAQrG//izl+reDUKAHZnn77DNpKe9143Brnuth/7iizqJVTaKEeR
         htBZnL/YnkI1AeGWQnmOTAqWOhoQ7dYdpgIPZB1BhKmsil3nUsWGDvpghw7vbaoNH+NB
         cMhK4X9Ka7G/Hid0gs70k7Oq2K4a0UZzLVsxd5oCPs5b7TXYOvim5SKJRB6I3IpbCvcI
         BUOS1cYsKCJUc/UfKeD5kcYitPAjtYc9CwaGaC7Lrlkbn+AwsG6i+36CBXKVxed3OtNF
         mN+hWUKnRowvpWdKh2uK7uJvu0FlTnDp0F2AaJju0D/pd1iwmbqHbo7QVaMyzRZxbYhM
         Hv6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709231523; x=1709836323;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oaeBOT+t9mePNFUipxjmnCS7BvLCAtAwOO3iooaJWCc=;
        b=EiEEc+fHan2/jyqzJR34edddTqsYGqvIpRmKaxpMUGC5WPOGnIMnhGD8xiRlgKhI2B
         Hf2/wyCEHID0fG+I1wJgr0ZQ5ZbCeaYzG3/8aAmszgKaUgQwGvTpCUnC7vICbTIa3bct
         f9qv5ZwYzUszk+DTx+IToYOD6PZWBDYEYlt+szQh+OvXuEc7ETkPGMhSLKBg8JmbsFU8
         0YMr0qb32hlvHXDrJnYMCfIndcHdSBWhGbvCyxaL6sq9M92i3fLR+2isNlTTstPr8tXI
         GX69YkwHW5PGXRgCU8Mtz0U1enyIfi9zR2X4snQMuu4WyDKL1GclQL9o3LUYwwz9y5u4
         niAg==
X-Forwarded-Encrypted: i=1; AJvYcCVAs6cXbxgZ7EsqnEYAcwDWH3wnoBba3HOE1i1ul1+aUF3tSUzQyED3K7VHVrmzgyQ68bs1v3ztfAxuqTAIfeLBzHTP
X-Gm-Message-State: AOJu0YwH7D1twMrXv36YEKVqkUH1+LguUebVRj4SPLtDixVlw1GNiJR3
	Zv7K9SIOAfzS2Wth9i/OVXHgt4f65RlQ66061olgfO+eUjM6T3nZMWOGocGxMFjRUQfXrEkZhFs
	4nVIcZmfqPIs5Iwtb919d3NaDtEBjlGss4LLl
X-Google-Smtp-Source: AGHT+IGSCq77ocxd7gplB+cHpPQ+Y1JtselXqVpEOhC68LuPI6+y4CIZriULLW8UPwmIs5rFfwGFL/iGFD2xbXyZ9Hs=
X-Received: by 2002:a81:8687:0:b0:609:2857:af0 with SMTP id
 w129-20020a818687000000b0060928570af0mr3175403ywf.25.1709231523326; Thu, 29
 Feb 2024 10:32:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240225165447.156954-1-jhs@mojatatu.com> <20240225165447.156954-7-jhs@mojatatu.com>
 <9bb827bfc79345d02a063650990de68ce2386ddb.camel@redhat.com>
In-Reply-To: <9bb827bfc79345d02a063650990de68ce2386ddb.camel@redhat.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Thu, 29 Feb 2024 13:31:52 -0500
Message-ID: <CAM0EoMkrZAQx7p1=5Bq-HDEHiDgS1fYwTxT2keXOWs3GXjcNiw@mail.gmail.com>
Subject: Re: [PATCH net-next v12 06/15] p4tc: add P4 data types
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, deb.chatterjee@intel.com, anjali.singhai@intel.com, 
	namrata.limaye@intel.com, tom@sipanda.io, mleitner@redhat.com, 
	Mahesh.Shirshyad@amd.com, Vipin.Jain@amd.com, tomasz.osinski@intel.com, 
	jiri@resnulli.us, xiyou.wangcong@gmail.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, vladbu@nvidia.com, horms@kernel.org, 
	khalidm@nvidia.com, toke@redhat.com, daniel@iogearbox.net, 
	victor@mojatatu.com, pctammela@mojatatu.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 29, 2024 at 10:09=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wr=
ote:
>
> On Sun, 2024-02-25 at 11:54 -0500, Jamal Hadi Salim wrote:
> > Introduce abstraction that represents P4 data types.
> > This also introduces the Kconfig and Makefile which later patches use.
> > Numeric types could be little, host or big endian definitions. The abst=
raction
> > also supports defining:
> >
> > a) bitstrings using P4 annotations that look like "bit<X>" where X
> >    is the number of bits defined in a type
> >
> > b) bitslices such that one can define in P4 as bit<8>[0-3] and
> >    bit<16>[4-9]. A 4-bit slice from bits 0-3 and a 6-bit slice from bit=
s
> >    4-9 respectively.
> >
> > c) speacialized types like dev (which stands for a netdev), key, etc
> >
> > Each type has a bitsize, a name (for debugging purposes), an ID and
> > methods/ops. The P4 types will be used by externs, dynamic actions, pac=
ket
> > headers and other parts of P4TC.
> >
> > Each type has four ops:
> >
> > - validate_p4t: Which validates if a given value of a specific type
> >   meets valid boundary conditions.
> >
> > - create_bitops: Which, given a bitsize, bitstart and bitend allocates =
and
> >   returns a mask and a shift value. For example, if we have type
> >   bit<8>[3-3] meaning bitstart =3D 3 and bitend =3D 3, we'll create a m=
ask
> >   which would only give us the fourth bit of a bit8 value, that is, 0x0=
8.
> >   Since we are interested in the fourth bit, the bit shift value will b=
e 3.
> >   This is also useful if an "irregular" bitsize is used, for example,
> >   bit24. In that case bitstart =3D 0 and bitend =3D 23. Shift will be 0=
 and
> >   the mask will be 0xFFFFFF00 if the machine is big endian.
> >
> > - host_read : Which reads the value of a given type and transforms it t=
o
> >   host order (if needed)
> >
> > - host_write : Which writes a provided host order value and transforms =
it
> >   to the type's native order (if needed)
>
> The type has a 'print' op, but I can't easily find where such op is
> used and its role?!?
>

Thanks for catching that. We'll remove it. It was part of an
operational debugging patch that was not submitted.

cheers,
jamal

> Thanks,
>
> Paolo
>

