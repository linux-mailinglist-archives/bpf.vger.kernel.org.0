Return-Path: <bpf+bounces-75436-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 12D16C84927
	for <lists+bpf@lfdr.de>; Tue, 25 Nov 2025 11:52:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 992914E780F
	for <lists+bpf@lfdr.de>; Tue, 25 Nov 2025 10:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0B81314A73;
	Tue, 25 Nov 2025 10:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RMd45mtz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CAF4310647
	for <bpf@vger.kernel.org>; Tue, 25 Nov 2025 10:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764067961; cv=none; b=MyEpAE7SSZPi+Q1LspszCRgzk12yfErFpnXsnmtAeXXPnyfqx5A5MHPnZB2pt7sW/XXSgXNokQDNA2vmDJZcMPycmbm0Yo8N3QlzUVdWhSo0mimzrj4ajwTq8UD2AAFIE1B5qutwiQOdmNbLCcHL7G8PRqlmGcAmGXxGYUvMAJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764067961; c=relaxed/simple;
	bh=Zzy7AyJw3E7/TD3OV4wq/0z8XZzKwYKI82YHiT8aqj4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oVNW4zQEnzr7G+xEaaPx87Q131Nf6bOaaDEpmjCP/TxPovIaREll5xu500q5FkuoTNrLO6tDcGKVvjiuOWZUUIO+siqST+cQcXVyLNvq+oAlhMDqgYBgUe9f205grnLFwYA5IkpDrDltNs1sbljF9TAjUpDfgN35n3NwmYjT+o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RMd45mtz; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b76b5afdf04so239478066b.1
        for <bpf@vger.kernel.org>; Tue, 25 Nov 2025 02:52:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764067958; x=1764672758; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zzy7AyJw3E7/TD3OV4wq/0z8XZzKwYKI82YHiT8aqj4=;
        b=RMd45mtzAi9gSei6pBHbbM5U+yOIbGYUk3A3uiiJRC9X6ciKQmQy1dcdMwfeXLIwgU
         autuEkP/I//Mr1Llr+2AOyPZ1j3J/8V4i+BOZ1jIUvnr4aIxPNfT6Mmvg9H5SlUQQ6SX
         CeBskXsJ5Cxs81FCep4PPikE8qsPGqz33XNldChXWNOhqSqIIBJOMNt0Jzd8iL8HbvaP
         BP4J3Bjh0OiUCudeWzXAm/6GGKNcYB3Evhe8AGZQL9OHDUMVSi8mPD8tuka9Z6MeAZTo
         eEjrnP1nJ1/tyKjPt5tiZnD3cVCtC2qZSjv9PDU2dLgwnv2HVh8VwUMi/9ulhhi4OKCb
         9v+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764067958; x=1764672758;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Zzy7AyJw3E7/TD3OV4wq/0z8XZzKwYKI82YHiT8aqj4=;
        b=vX3YfARzqLvvvRjHoZcN+/MH8DlNjAEUUCqre3OdSKRGssVylafrCUpsUSAZZtAFWz
         SbDjxUjbCv+0J70w7haEgH73R+e3v9U1p6S2C4vx+cxjxOal3OeWQri2YG5nFN9EoP8N
         t27Oyi0XOTcfSep18a7M0spaLu5/jDS4vXfKB3ztWkFTZ+fpJd6MYdNcDjckUpJOIMct
         G0Wt75y674S1JzJ15rg/rAPQsEej9r9C4hQ4GBUYT/ZX4mHLVLmslMyzGKTeKdzmqpok
         S55VUNC+plhHMVIzDQsYtbds06YKHzlhjBwpiiE2fE7/0HLmDEGOifTz2n0lEKy8vu0U
         Wi4g==
X-Forwarded-Encrypted: i=1; AJvYcCWm9xkWjUb3agC/FjWlrdOM0xRqCZ5p5lwLVueizViYqxZKUZeQ2cc8PSqyzuDRFBnLiuc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnIfAxrmBH29vBFr8aoIyT6UaR+7/YTK7EbcYG9C67avWenCOE
	Am6a0QU/D11dP2lr4COlJJQ4YMr1OPDxlFZxIzNc7+t5n4P9F2jvrXbdTktSDTxadBHI1yjoVjg
	n84EGKbs0yZTLLnaB/KrpWkecsXKQ9buJ0SxEQLg=
X-Gm-Gg: ASbGncuLubViIwlzHJSL12EHfeEEqzkom44xBRXGKEGDvqLGNTMzE1QxI7TU8MWJC1T
	mqROcWI48McTEBYM8uXTghZ4vYYsquYKIyVI6KLGZFEV+KFLtYrcp3LtVdmzPaS6wlNcII97kvt
	l3ozIUVYAwFCgR7V8SybBIumfp+3VdREN6tvBQ8vkVggPj6lDtAxIaxy/Wc34Zpjm9oKz7/gKxS
	GFPY0aEu5rOUojtmvcyvG1VS3PZaLQb9LqAh/QLY+6ZGtcFx3NkCqRQ/k+Z6UhdP5/VyV+u
X-Google-Smtp-Source: AGHT+IFuHsbJgpQ4trRGPnv/ZCTaXDn5XKvGXQuhjTO/KdShWmrmoKPYUdt896G3evAm46BKNxUYF5RNCJxu1qS2Qqc=
X-Received: by 2002:a17:907:9711:b0:b46:6718:3f20 with SMTP id
 a640c23a62f3a-b76718cfde7mr1534627566b.48.1764067957642; Tue, 25 Nov 2025
 02:52:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251119031531.1817099-1-dolinux.peng@gmail.com>
 <20251119031531.1817099-6-dolinux.peng@gmail.com> <CAEf4BzYQfHKHUdxv7W7mET1xBXuokvx9v=69HNAkhg_CAPCm-g@mail.gmail.com>
 <CAErzpmvLhKbCYh3hYW=54JJtXj3TV0t2JAmGwy4E3xW7r84OBw@mail.gmail.com>
 <e8f499647614e592845dbdfa23d53e6c62434485.camel@gmail.com>
 <CAErzpmvpyLE67gEyspuj33+FCczErZJVCZuy6BEZ6miurvL7cw@mail.gmail.com>
 <CAErzpmsCDmGvne4+TCbm09RNhfcUYVdsk_X7uoS_tSDKG=0Kqg@mail.gmail.com> <c29c91ad68f01b8bee8fff36b511d4dbdca1549d.camel@gmail.com>
In-Reply-To: <c29c91ad68f01b8bee8fff36b511d4dbdca1549d.camel@gmail.com>
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Tue, 25 Nov 2025 18:52:25 +0800
X-Gm-Features: AWmQ_bnafqO0Y3Y2i2JcLizGUtKYNmSBv_0MMKgI7pPm1QmjxhtV5jjZaUHzqTw
Message-ID: <CAErzpmsHFPwcm-W1aSpZ3Kv9rJLMjrVenk+Mk8Ai99NAkK0=rg@mail.gmail.com>
Subject: Re: [RFC PATCH v7 5/7] libbpf: Implement BTF type sorting validation
 for binary search optimization
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, ast@kernel.org, zhangxiaoqin@xiaomi.com, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	Donglin Peng <pengdonglin@xiaomi.com>, Alan Maguire <alan.maguire@oracle.com>, 
	Song Liu <song@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 25, 2025 at 2:20=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Sat, 2025-11-22 at 16:38 +0800, Donglin Peng wrote:
> > On Sat, Nov 22, 2025 at 3:32=E2=80=AFPM Donglin Peng <dolinux.peng@gmai=
l.com> wrote:
> > >
> > > On Sat, Nov 22, 2025 at 3:42=E2=80=AFAM Eduard Zingerman <eddyz87@gma=
il.com> wrote:
> > > >
> > > > On Thu, 2025-11-20 at 15:25 +0800, Donglin Peng wrote:
> > > >
> > > > [...]
> > > >
> > > > > Additionally, in the linear search branch, I saw there is a NULL =
check for
> > > > > the name returned by btf__name_by_offset. This suggests that chec=
king
> > > > > name_off =3D=3D 0 alone may not be sufficient to identify an anon=
ymous type,
> > > > > which is why I used str_is_empty for a more robust check.
> > > >
> > > > btf_str_by_offset(btf, offset) returns NULL only when 'offset' is
> > > > larger then 'btf->hdr.str_len'. However, function btf_check_meta()
> > > > verifies that this shall not happen by invoking
> > > > btf_name_offset_valid() check. The btf_check_meta() is invoked for =
all
> > > > types by btf_check_all_metas() called from btf_parse_base(),
> > > > btf_parse_module() and btf_parse_type_sec() -> btf_parse().
> > > >
> > > > So, it appears that kernel protects itself from invalid name_off
> > > > values at BTF load time.
> > >
> > > Right. The kernel guarantees that btf_str_by_offsetnever returns NULL=
,
> > > and there is no NULL check performed on the name returned by
> > > btf_find_by_name_kind. The NULL check is included in the libbpf versi=
on
> > > of the function.
> >
> > Sorry =E2=80=94 my mistake. There=E2=80=99s no NULL check on the name f=
rom
> > btf_str_by_offset in the kernel=E2=80=99s btf_find_by_name_kind. The
> > libbpf version has it.
>
> tools/lib/bpf/btf.c:btf_sanity_check() is called from btf_new(),
> it calls btf_validate_type(), which does btf_validate_str().
> So, ignoring the NULL case on libbpf side should be safe as well.

Thanks, I also noticed that too and will drop the NULL check in the next
version.

>
> [...]

