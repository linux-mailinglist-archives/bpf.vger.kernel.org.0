Return-Path: <bpf+bounces-43391-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CE8C9B4D57
	for <lists+bpf@lfdr.de>; Tue, 29 Oct 2024 16:15:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10611283FBD
	for <lists+bpf@lfdr.de>; Tue, 29 Oct 2024 15:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78C5F192D73;
	Tue, 29 Oct 2024 15:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tg7ldVYG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238FF747F;
	Tue, 29 Oct 2024 15:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730214929; cv=none; b=Abm3WTx1cwIqi8AtcvNVpBz84jE3d7qqjT1VXZsfrcdVqem9Djn/HGTEQe8/Vr+iXtGvnIJX5Nm2LoQ/xl0mEYRmXkJGeqgsYINvyRvR5avNV3gIwfgrsJjKM2l4ft1cmDFNBu5ELX7Zj7TNVI4Gx4wqtUCJr3SyaTqmGKm2ASg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730214929; c=relaxed/simple;
	bh=XTdAOFFPHoByAW0zEX+1bZ8Eb08mn2sn6pazzDy8SQ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X++KXxU52lTcxac3rGQX2ZubrPH8tC76ytnShrOGd8Ndl67z/aJHwqmjaBJ/hyvvIZXZHWs9F/O0j7BLCpBcgx3o06CX4i0bdCDpaOWLp5Sklmv4BXdkjq0d85pZsOYn+ewRRb23X7qJisaXj/9D2OzFID2+W4QTxI11Hd4+KAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tg7ldVYG; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43167ff0f91so54990605e9.1;
        Tue, 29 Oct 2024 08:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730214924; x=1730819724; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XTdAOFFPHoByAW0zEX+1bZ8Eb08mn2sn6pazzDy8SQ8=;
        b=Tg7ldVYGvgBn5fKGsXCcm8ZLDh9Iw+JfsRTyO9Lgv+LNV3njQHAJTtT2U8g6ZiOR8F
         E1KA5Q7JyCJs6aJD/IjgtXahXbtYv795oT5HEGuuob/K9VlOan79YtCGrlvGs2tzt6bY
         CJhZLS8siPBZLUYv5VGjDnrgLlsrPAVR0VdahVnGc9bsvAkJ3PFyx+/25vIh+cKHAsR7
         6C2yyTBF7vbiqYWrUzSxDEZ0iEmlfyOdSMT47uuCRUfll6pRTNX1AcVvIak2xrpumVFP
         TpGscsfwxFcgm9JQVDm6934Mte84klYBZEMnTy6k/Hk+5vkHGpF2/C/GdpX7osoHmo8D
         pT+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730214924; x=1730819724;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XTdAOFFPHoByAW0zEX+1bZ8Eb08mn2sn6pazzDy8SQ8=;
        b=dHh3heFWHUPEkEbYl5AyQEumFfbkw/VCsuW/TZPQtOktoPnj1LvL9MQZ+RmGWGlBba
         jyJIP/S8Ol5vnONCKJy3mobSO31sAHaektvYbMOCJVNesFjPKxM3YMMIHT5JKe4qX8lw
         XHnL921vAm+OgSviAoKsKASUlcUSYT97pEYkP/J1XLzN3Gu1NTaUH587IXOrF/ZoCgGn
         MVXRODjNSxL593KvnETmzw/340sjB0Mh4YI+DFNy1ZpfFs9qeuPtybtyZYAuUls+EpO4
         yF243uh0xpoXxM62JaG5Oa4A+BGbN2omds/wL0BgwnKLYr02jsZUrEXIOG2eq4rRgSpP
         Bk5A==
X-Forwarded-Encrypted: i=1; AJvYcCUBS2f8F07LSQGFOBrl6g2RqMtS68PIAiFuYVVCoiM6qiUBt/nXb0IKZMzcZPnCc6posXgO7wJPrQipDBs=@vger.kernel.org, AJvYcCUhvZEmudXE+7X4zf2ttZR9wExw4acebvMCAG00kWcCd7lSLUgLzIEtm+WqfdxfCgL4+IcN/SVXff0Q5CrRqBIz5Bu3@vger.kernel.org, AJvYcCVCTxzJLB01CHJKFm/TBI/9RryLUIKV1nBQob6Ny6MhENqOt/hKY2+l+BX9qNa8xXljnvDWXXAz@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+djwWjTt75RmsWKmDq2wO5tExJH2MLME8ch5xsWMPbq+OKqMY
	OsgPkBGvKXKK9ZgDb7+nx0ZEak91/T9AD5kzG/w6eDm4M/tF9wzMjVgD/z+u0m0KWfRcJws9md/
	vlBW9hBup7bXSJWZvI6eyqNU4CyY=
X-Google-Smtp-Source: AGHT+IFt3LhIP+T08xuSWl2DD2ktCkrZyc5GBn2EFnoVWOdyMp9q0tyHDl7Px5ZlD2TVQmiWP3R/n24rbjSd9KDMM3M=
X-Received: by 2002:a05:600c:3c9a:b0:431:5d14:1cae with SMTP id
 5b1f17b1804b1-4319acb1d60mr101991675e9.19.1730214924190; Tue, 29 Oct 2024
 08:15:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241029143445.72132-1-technoboy85@gmail.com>
In-Reply-To: <20241029143445.72132-1-technoboy85@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 29 Oct 2024 08:15:12 -0700
Message-ID: <CAADnVQLdcJMddFAxVRRaySeD06eGkU+rt0x8LkSqRak0fHqNEw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] bpf: use kfunc hooks instead of program types
To: Matteo Croce <technoboy85@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Network Development <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, Matteo Croce <teknoraver@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 29, 2024 at 7:34=E2=80=AFAM Matteo Croce <technoboy85@gmail.com=
> wrote:
>
> From: Matteo Croce <teknoraver@meta.com>
>
> Pass to register_btf_kfunc_id_set() a btf_kfunc_hook directly, instead
> of a bpf_prog_type.
> Many program types share the same kfunc hook, so some calls to
> register_btf_kfunc_id_set() can be removed.

Still nack for the same reason: let's avoid churn
when kfunc registration needs a redesign.

pw-bot: cr

