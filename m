Return-Path: <bpf+bounces-77175-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 85C6ACD1493
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 19:06:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6C3EA301B3AC
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 18:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45FE534F252;
	Fri, 19 Dec 2025 17:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="baN9RqMQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB7B34E748
	for <bpf@vger.kernel.org>; Fri, 19 Dec 2025 17:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766167145; cv=none; b=Jnxe7m/NN8U4kxE6wd+KvsHieMWBBhmfhojByIhac+Pgi7/X4W/iwmSh/qqJ41Kg90PYOBYDt/EfIS0RQ+9yDhh7BqFSRCdzziagIMpdPTNcGV4Uzm688vvaDnsPF8YVhZzdP8I2IEy+DZb7PfKZiqbZ1g55nBO3c5xJdoXt+HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766167145; c=relaxed/simple;
	bh=SVwXawwJqmV8FEwhgJ5+11th3V5S7kqhU4cZk74979M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YlVkHfRdLSvt7TnIf5DMJl6ZXgNaInxn+o+5hQ2FtTVZ8K2fQHxXeaWqPlCAuIKKvwo6h8b6IKNACPYzgfTYxmM7k1fKR2gyAgsXc6GV8d3/yPsfS/kyLgNl/xtOuAkvP0g3zwZ091CRpDfjRBwAzHv342t1C9qRaJ7NalPvVR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=baN9RqMQ; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-34e90f7b49cso1039060a91.3
        for <bpf@vger.kernel.org>; Fri, 19 Dec 2025 09:59:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766167142; x=1766771942; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tlpe6+pZrbcw9Zu+li+e09BHjw+JoUbz2Bk5+b9DEF0=;
        b=baN9RqMQPKK4/YTQuZHajbL4qTLztjkKbKlyHbp99o9lThDQuFPZ45PX31Lxz+aDGI
         py4ASdtjPDllGonhPDi2JHsVapT4/EEm9T7CwT7ApOENdnICt1UtMnQyvaUqaCzSzyB/
         8KWwnnYk8/MxBIRJqO/z585ur66kuMvw5Qvqh0OPGQeJsphf2EdwIAv/CJlOVhef3ZaL
         fig2g7aR7JMDwm6bLT7by5tHSQ5/9d4/bJ4YykxpiV2FKBikYg8RioeEcnlW/g+gK6ob
         c9220hKCUroqjsOFkU2/5TqrRAWs9NphfEb9tIUthrVFRWmJRsbF4J82krOoCZeG/RWw
         fbng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766167142; x=1766771942;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Tlpe6+pZrbcw9Zu+li+e09BHjw+JoUbz2Bk5+b9DEF0=;
        b=JsxEAsPjpuo7j/FXnJBSh4HvDRYxPqm6qKVMX5tX4q/iairPBxsqN7q7m+DvvjDGmt
         nHVFrGRJwHVOjERJwx5YCKyWj531SNaFQKvpmdRqJ4zpHeYRknCJS9UuMHZAOUzqHW+6
         rxfoyzXmNVkDW2Bm1i66LP5v1D1B09biaQMYl6zgdqCnjZrqLNmjpeMX8h4JiFFu5G79
         9NN/lrohfpAetf6DIDbBcjquecUKnjvKZqylew3GX7Amt7OmWz7bnprtyKvZXVJ3KbZM
         I0tdGadBQNYtCGrO4h0mITY/Y47U4OhQ/hup89VFrSaBOfBUEYojrYhySIEXlVNg8nVt
         OnSQ==
X-Forwarded-Encrypted: i=1; AJvYcCUH+0AIs83MbtWF9+E0TzoT5lEaQxCIhSgYHYm754kEDWZ8Z/m2ooYmzqpj4Tlj4bUIQas=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8WtwcbWVxmqoWh20hBCtlJGtM0l1+fHPkJFePIoHWx8yDSwhw
	R7SQ6SMaPZ47IGGZ+Tiad0XQE4TpwCYjnBwdCxNWVKN+5v+yVq/NKUTw3uWtsGBCF4hp2yZx6v3
	o1wtiog1K97tBx9n9xO2Nkf90Ooaourg=
X-Gm-Gg: AY/fxX71QPdudpL1q9jQJH+5UrB/0fiC2bgCHVIvKii5EltBivfO/pMS+k5O+HT6ulH
	ZUc0v3IX2xQxWxeJqub5HBQVG4gi7iHxgb5CA6kdvcVRPrnkMKg3mm37Umb8hVxjrhE5pFIbDpd
	zknW3L0kXk2JFkrHbQMHsjlZXfAIWrWVmfREPwx+JJsiek3oFjhq7R/Ek6EtG7ybi92zaG+R2q3
	P6KsidLPkfEUKdKyTJ//+b9PHCJl+bPL7I1XJOQImqXvL/ht9HVCirz12q4ksITHAhV7Io=
X-Google-Smtp-Source: AGHT+IHRxLsCXrDiVvVO9sp6L04oGH/AhQnwCzcfqHNN5tR1CYv3oXG2RxS8/oWzWeNDguKnMm6dMZVWHGD69hkpWDc=
X-Received: by 2002:a17:90b:4a52:b0:34c:35ce:3c5f with SMTP id
 98e67ed59e1d1-34e9212f6c8mr2672757a91.5.1766167142432; Fri, 19 Dec 2025
 09:59:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251215091730.1188790-1-alan.maguire@oracle.com>
 <20251215091730.1188790-3-alan.maguire@oracle.com> <CAEf4Bza+C7nRxFDHS0dNDk5XF79nE6y4GqEu0bmtJPTMoFrNvQ@mail.gmail.com>
 <db38bb39-7d16-41b6-968d-61e3b7681440@oracle.com>
In-Reply-To: <db38bb39-7d16-41b6-968d-61e3b7681440@oracle.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 19 Dec 2025 09:58:50 -0800
X-Gm-Features: AQt7F2qe5G7UQmwFPf8eqQLjCndwC0USKlN9uGKlkNRW1Dphi8Epul_MS2UniEg
Message-ID: <CAEf4Bzbn_eWC8W8+so-BgkzNOxx8jgEysU3kTzBCW1jwXPEfnQ@mail.gmail.com>
Subject: Re: [PATCH v8 bpf-next 02/10] libbpf: Support kind layout section
 handling in BTF
To: Alan Maguire <alan.maguire@oracle.com>
Cc: andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, qmo@kernel.org, 
	ihor.solodrai@linux.dev, dwarves@vger.kernel.org, bpf@vger.kernel.org, 
	ttreyer@meta.com, mykyta.yatsenko5@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 19, 2025 at 5:34=E2=80=AFAM Alan Maguire <alan.maguire@oracle.c=
om> wrote:
>
> On 16/12/2025 19:34, Andrii Nakryiko wrote:
> > On Mon, Dec 15, 2025 at 1:18=E2=80=AFAM Alan Maguire <alan.maguire@orac=
le.com> wrote:
> >>
> >> Support reading in kind layout fixing endian issues on reading;
> >> also support writing kind layout section to raw BTF object.
> >> There is not yet an API to populate the kind layout with meaningful
> >> information.
> >>
> >> As part of this, we need to consider multiple valid BTF header
> >> sizes; the original or the kind layout-extended headers.
> >> So to support this, the "struct btf" representation is modified
> >> to always allocate a "struct btf_header" and copy the valid
> >> portion from the raw data to it; this means we can always safely
> >> check fields like btf->hdr->kind_layout_len.
> >>
> >> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> >> ---
> >>  tools/lib/bpf/btf.c | 260 +++++++++++++++++++++++++++++++------------=
-
> >>  1 file changed, 183 insertions(+), 77 deletions(-)
> >>
> >> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> >> index b136572e889a..8835aee6ee84 100644
> >> --- a/tools/lib/bpf/btf.c
> >> +++ b/tools/lib/bpf/btf.c
> >> @@ -40,42 +40,53 @@ struct btf {
> >>
> >>         /*
> >>          * When BTF is loaded from an ELF or raw memory it is stored
> >> -        * in a contiguous memory block. The hdr, type_data, and, strs=
_data
> >> +        * in a contiguous memory block. The  type_data, and, strs_dat=
a
> >
> > nit: two spaces, and so many commas around and ;) let's leave Oxford
> > comma, but comma after and is weird
> >
> >>          * point inside that memory region to their respective parts o=
f BTF
> >>          * representation:
> >>          *
> >> -        * +--------------------------------+
> >> -        * |  Header  |  Types  |  Strings  |
> >> -        * +--------------------------------+
> >> -        * ^          ^         ^
> >> -        * |          |         |
> >> -        * hdr        |         |
> >> -        * types_data-+         |
> >> -        * strs_data------------+
> >> +        * +--------------------------------+---------------------+
> >> +        * |  Header  |  Types  |  Strings  |Optional kind layout |
> >
> > Space missing, boo. Keep diagrams beautiful!..
> >
> >> +        * +--------------------------------+---------------------+
> >> +        * ^          ^         ^           ^
> >> +        * |          |         |           |
> >> +        * raw_data   |         |           |
> >> +        * types_data-+         |           |
> >> +        * strs_data------------+           |
> >> +        * kind_layout----------------------+
> >> +        *
> >> +        * A separate struct btf_header is allocated for btf->hdr,
> >> +        * and header information is copied into it.  This allows us
> >> +        * to handle header data for various header formats; the origi=
nal,
> >> +        * the extended header with kind layout, etc.
> >>          *
> >>          * If BTF data is later modified, e.g., due to types added or
> >>          * removed, BTF deduplication performed, etc, this contiguous
> >> -        * representation is broken up into three independently alloca=
ted
> >> -        * memory regions to be able to modify them independently.
> >> +        * representation is broken up into four independent memory
> >> +        * regions.
> >> +        *
> >>          * raw_data is nulled out at that point, but can be later allo=
cated
> >>          * and cached again if user calls btf__raw_data(), at which po=
int
> >> -        * raw_data will contain a contiguous copy of header, types, a=
nd
> >> -        * strings:
> >> +        * raw_data will contain a contiguous copy of header, types, s=
trings
> >> +        * and optionally kind_layout.  kind_layout optionally points =
to a
> >> +        * kind_layout array - this allows us to encode information ab=
out
> >> +        * the kinds known at encoding time.  If kind_layout is NULL n=
o
> >> +        * kind information is encoded.
> >>          *
> >> -        * +----------+  +---------+  +-----------+
> >> -        * |  Header  |  |  Types  |  |  Strings  |
> >> -        * +----------+  +---------+  +-----------+
> >> -        * ^             ^            ^
> >> -        * |             |            |
> >> -        * hdr           |            |
> >> -        * types_data----+            |
> >> -        * strset__data(strs_set)-----+
> >> +        * +----------+  +---------+  +-----------+   +-----------+
> >> +        * |  Header  |  |  Types  |  |  Strings  |   |kind_layout|
> >> +        * +----------+  +---------+  +-----------+   +-----------+
> >
> > nit: spaces (and if we go with "layout" naming, this will be short and
> > beautiful " Layout " ;)
> >
> >> +        * ^             ^            ^               ^
> >> +        * |             |            |               |
> >> +        * hdr           |            |               |
> >> +        * types_data----+            |               |
> >> +        * strset__data(strs_set)-----+               |
> >> +        * kind_layout--------------------------------+
> >
> > [...]
> >
> >> @@ -3888,7 +3989,7 @@ static int btf_dedup_strings(struct btf_dedup *d=
)
> >>
> >>         /* replace BTF string data and hash with deduped ones */
> >>         strset__free(d->btf->strs_set);
> >> -       d->btf->hdr->str_len =3D strset__data_size(d->strs_set);
> >> +       btf_hdr_update_str_len(d->btf, strset__data_size(d->strs_set))=
;
> >>         d->btf->strs_set =3D d->strs_set;
> >>         d->strs_set =3D NULL;
> >>         d->btf->strs_deduped =3D true;
> >> @@ -5343,6 +5444,11 @@ static int btf_dedup_compact_types(struct btf_d=
edup *d)
> >>         d->btf->type_offs =3D new_offs;
> >>         d->btf->hdr->str_off =3D d->btf->hdr->type_len;
> >>         d->btf->raw_size =3D d->btf->hdr->hdr_len + d->btf->hdr->type_=
len + d->btf->hdr->str_len;
> >> +       if (d->btf->kind_layout) {
> >> +               d->btf->hdr->kind_layout_off =3D d->btf->hdr->str_off =
+ roundup(d->btf->hdr->str_len,
> >> +                                                                     =
        4);
> >> +               d->btf->raw_size =3D roundup(d->btf->raw_size, 4) + d-=
>btf->hdr->kind_layout_len;
> >
> > maybe put layout data after type data, but before strings? rounding up
> > string section which is byte-based feels weird. I think old libbpf
> > implementations should handle all this well, because btf_header
> > explicitly specifies string section offset, no?
> >
>
> That sounds good, but I think there are some strictness issues with how w=
e parse
> BTF on the kernel side that we may need to think about, especially if we =
want to
> make kind layout always available. In that case we'd need to think how ol=
d kernels
> built with newer pahole might handle newer headers with layout info.
>
> First in btf_parse_hdr() the kernel rejects BTF with non-zero unsupported=
 fields.
> So trying to load vmlinux BTF generated by a pahole that adds layout info=
 will
> fail for such a kernel.
>
> Second when validating section info in btf_check_sec_info() we check for =
overlaps
> between known sections, and we also check for gaps between known sections=
. Finally we
> also check for any additional data other than the known section data.

I thought we don't validate gaps, I missed btf_check_sec_info()
checks, though. Good for kernel, it should be strict.

But it's easy to drop this layout info in libbpf for BTF sanitization,
this shouldn't be a problem. Just shift everything to the left and
adjust strs_off.

>
> For layout info stored between type+strings we'd wind up rejecting it for=
 a few reasons:
>
> 1. we'd find non-zero data in the header (layout offset/len)
> 2. we'd find a "gap" between types+strings (the layout data)
>
> Similarly with layout at the end
>
> 1. we'd find non-zero data in the header (kind layout offset/len)
> 2. we'd find unaccounted-for data after the string data (the kind layout =
data)
>
> So either way we'd wind up with unsupported headers. One approach would b=
e to
> do stable backports relaxing these header tests; I think we could relax t=
hem to
> simply ensure no overlap between sections and that sections don't overrun=
 data
> length without risking having unusable BTF. Then a newer BTF header with =
additional
> layout info wouldn't get rejected. What do you think?

See above, I don't see why we can't just sanitize BTF and drop layout
parts altogether. They are optional for kernel either way, no harm in
dropping them.

>
> Alan

