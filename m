Return-Path: <bpf+bounces-71149-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 73D49BE5678
	for <lists+bpf@lfdr.de>; Thu, 16 Oct 2025 22:28:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EB249357667
	for <lists+bpf@lfdr.de>; Thu, 16 Oct 2025 20:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D2852DEA9E;
	Thu, 16 Oct 2025 20:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iPmtlvPx"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE7D218FDDB
	for <bpf@vger.kernel.org>; Thu, 16 Oct 2025 20:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760646533; cv=none; b=W0XQdk9umnFkIh0N36I7hcaWhP4Dx9pUvDaXC+b/uGOjsHlM0Fq3Mgn+mK8kmdS3HXvKhhv1H0PS/MANsqD1HsVZwMoDv0r9wkgZfvvBVlK1aXVIr43yI7E46iykSpqj9FDOu9JkqXhYS374qrQYMvSd13rgF7Fc3I613Nj6yos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760646533; c=relaxed/simple;
	bh=pAwHmuJGCE37w9BILfTJEkXNbacr6XtoS56A4wL/GnM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F34nPCniKwD8MeLJ8ZLdgiITzYP+2Biei6Wzqf012jn4DOm3B8GN7MN+o95E8XjsnNOxQDdbwsnSa0GWP9CQCY4SOf3ja2esKXJkPEkpFJhF3a3KkzEcK4M7ZMhPFxOLOyw3TT/GICWCDFkrvZ1ekKWOsBm8a3Z1YmOy+S3VXnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iPmtlvPx; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-33ba2f134f1so1199078a91.2
        for <bpf@vger.kernel.org>; Thu, 16 Oct 2025 13:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760646530; x=1761251330; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IJlkoIkmRdqWWwkmBk5yAznPiL2zm9nsSbO1CJbC2uY=;
        b=iPmtlvPxqiHASsDfyXe2cEJFe1oaRJR22l57/MM4ZEVv/QaVv3DETPKOvvfcmojZnH
         PDduYmTJTYLpN3VB1G0zhNYl98nvNL0x4Y8QW2ESrktT42apxwn2VntK+Vl5ReQU89tW
         lbpB1eBia/XS56VKYaEUWyrv6WS6GocihRr+HFfMqBGQKNlqts9KAL8dS5AnEpsamNDP
         VHaaRSYxRrLv76eTEEd/63Uek9a6RMPoPrjxR0vbwn5qh4vHohkURrptUR//SRfh5i4P
         XkmMiGRgiD65Vsyg0lLdof0LYdU44jZDJaFcPxmoy6QFQpPz8qfRThpFK/UG6T5rt+mC
         U2kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760646530; x=1761251330;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IJlkoIkmRdqWWwkmBk5yAznPiL2zm9nsSbO1CJbC2uY=;
        b=H3RtFgVPQ03L7S9XfGi7w368TRL7HiVgaIkRwx/flDVyWBwf6QdqPaNwvi/N9Yz3zq
         VNA8KmJGGUd9yiSKHAzLyscnM6cMa7GRhg49Zj14pvrv0aTFfCXzWQcDxljGTe8MTSpW
         DMtr5jTSPDJGZTjDIIWRewqrxtB2iuVb8bIdbCDxqf192RpXj8f7s63BVBzMNYjvIe6l
         WwSNptB9vzoWNi9LqlL7q0lEFlEnmg/Wwg95pCIQfKPlDIIKuQhWF4m8pC6kRdaRTi+X
         MA/tzNPL89MFlAAJbs5cVWzB+ZpLMRvAyNptLJPA92NFBCxUaCJbmxQwzNwk8M2E3mhv
         GyKg==
X-Gm-Message-State: AOJu0YwpnaHsHK8H2Hc5XgnUf/gfEcXDsV/pj+AE47EH09ZB+w3G+pmB
	Pv/humuiLNGMghNyYpQSpTaMh/oEifZg/j4ZlFWG0Jwo2X300xIsI/TZ93nMyqztL6b+fCve7iy
	keAfLCrjwn55Dn2T+TZdJU6ut8AVaLlY=
X-Gm-Gg: ASbGnctgRFVFOpPTvMF/Om4q5CMoI+ehJy8AQdzU09jzpTPW8l/awXAapYTTjA1y1fq
	le2wJ3VcTqXNGFjJdd80BfPbl0oxiFzC9rRo3LnnEUmffyZjtLrYNUQYQ86fFuRv26uNyngKVWE
	36cBFHlulkTDC1QRCpTOTebAZPZx3HeF9YtfNvqhqvzVk4Os/4wsnSpm5TuNfnGRWjKksWKRk6f
	4+4I6SrMjTBOMG3iLcOOB4ciIKbigsKVn/5YrCv+aDtGmxGRgO579G1jh8jZRUb/w2n8t/3sNek
	BCbDP/OE4grHZrRUK7tfrw==
X-Google-Smtp-Source: AGHT+IG8qw0KRau9xEmwLhJYlo25wjP4fthLOXRPbeGaYHGBcHxu9ZQ3bZv8lM7TBrguH6hVpl2MdHAn4nPVbYoV3So=
X-Received: by 2002:a17:90b:1dd2:b0:327:9e88:7714 with SMTP id
 98e67ed59e1d1-33bcf926c1bmr1217823a91.37.1760646530040; Thu, 16 Oct 2025
 13:28:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251015161155.120148-1-mykyta.yatsenko5@gmail.com> <20251015161155.120148-5-mykyta.yatsenko5@gmail.com>
In-Reply-To: <20251015161155.120148-5-mykyta.yatsenko5@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 16 Oct 2025 13:28:35 -0700
X-Gm-Features: AS18NWDP7WaXX9RfaAxvBFIoxaIhK5vLgptqpGGn0JquEuVmxx9QvRmXfAOpVM8
Message-ID: <CAEf4BzbbZrfEi_tWKvD4f2et0gN1s3seZMguROsgTSqtnW5=SA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 04/11] lib/freader: support reading more than 2 folios
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, eddyz87@gmail.com, 
	memxor@gmail.com, Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 15, 2025 at 9:12=E2=80=AFAM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> freader_fetch currently reads from at most two folios. When a read spans
> into a third folio, the overflow bytes are copied adjacent to the second
> folio=E2=80=99s data instead of being handled as a separate folio.
> This patch modifies fetch algorithm to support reading from many folios.
>
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---
>  lib/buildid.c | 26 ++++++++++++++------------
>  1 file changed, 14 insertions(+), 12 deletions(-)
>

LGTM

Reviewed-by: Andrii Nakryiko <andrii@kernel.org>


> diff --git a/lib/buildid.c b/lib/buildid.c
> index df06e492810d..ade01d7ff682 100644
> --- a/lib/buildid.c
> +++ b/lib/buildid.c
> @@ -108,18 +108,20 @@ const void *freader_fetch(struct freader *r, loff_t=
 file_off, size_t sz)
>          */
>         folio_sz =3D folio_size(r->folio);
>         if (file_off + sz > r->folio_off + folio_sz) {
> -               int part_sz =3D r->folio_off + folio_sz - file_off;
> -
> -               /* copy the part that resides in the current folio */
> -               memcpy(r->buf, r->addr + (file_off - r->folio_off), part_=
sz);
> -
> -               /* fetch next folio */
> -               r->err =3D freader_get_folio(r, r->folio_off + folio_sz);
> -               if (r->err)
> -                       return NULL;
> -
> -               /* copy the rest of requested data */
> -               memcpy(r->buf + part_sz, r->addr, sz - part_sz);
> +               u64 part_sz =3D r->folio_off + folio_sz - file_off, off;
> +
> +               memcpy(r->buf, r->addr + file_off - r->folio_off, part_sz=
);
> +               off =3D part_sz;
> +
> +               while (off < sz) {
> +                       /* fetch next folio */
> +                       r->err =3D freader_get_folio(r, r->folio_off + fo=
lio_sz);
> +                       if (r->err)
> +                               return NULL;
> +                       part_sz =3D min_t(u64, sz - off, folio_size(r->fo=
lio));
> +                       memcpy(r->buf + off, r->addr, part_sz);
> +                       off +=3D part_sz;
> +               }
>
>                 return r->buf;
>         }
> --
> 2.51.0
>

