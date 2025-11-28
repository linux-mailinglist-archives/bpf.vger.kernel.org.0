Return-Path: <bpf+bounces-75726-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BBBEC92392
	for <lists+bpf@lfdr.de>; Fri, 28 Nov 2025 15:05:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B210F3A4600
	for <lists+bpf@lfdr.de>; Fri, 28 Nov 2025 14:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D9A430FC08;
	Fri, 28 Nov 2025 14:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bf5D8tor"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17BD01C701F
	for <bpf@vger.kernel.org>; Fri, 28 Nov 2025 14:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764338680; cv=none; b=RApv87wEvDkdfakrLIN6I7AcW3kAUSWOThX5OLdamMKmips0xigFvLSVnrPhB/Xt07NqtRRPcBMsqw3anUllk2gNynz6AowbiBggt62qubua1el+lIZE2IvubdIWVUIHR6zj+1KgK8SornViBvfPj6oNG0sW67zEWp1a2Yjd7eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764338680; c=relaxed/simple;
	bh=8BUy/DlnXFwDpANRZOOtzUxjbSJftZsc9GiewZUjuuY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BmLzGtoACdFr3PVMR89XZxjjmDY6ubbPq0+JF4Y+nQgIgKy0mLIsfV83WwnhNpYXhyzBB8zhO1dVjerwlFCVsWE3dQjmMHGUq2qcgChZ40qSZRaYYtaKYJWeg1/3l7lI97N+QRy/wLys9TxaHqr9DiAud28LPFja67QutrTh3yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bf5D8tor; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764338678;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2aYbQOviV9G6U7vQC1wZCjsv5aDiytW/O4hn4aGzwt0=;
	b=bf5D8tor/A1Wq4XBvUt1KEdNqVCjpPcJcbNNtT3z474QXOZDJlaQ5q+xVOuUK3C6gEs95Y
	LtYlUJTFMVg1ZfT8f08ZoNdQnlq+ZwjmJHoLoNhReUMq9N5ry1E23+VBDalHWze0bxDYhW
	ykpnznrxeoiD+yO7AqEuy3VzRBZRWqI=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-ssVJcb4qMdCDsYrzBK8Sgg-1; Fri, 28 Nov 2025 09:04:36 -0500
X-MC-Unique: ssVJcb4qMdCDsYrzBK8Sgg-1
X-Mimecast-MFC-AGG-ID: ssVJcb4qMdCDsYrzBK8Sgg_1764338675
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-59427500731so1210397e87.0
        for <bpf@vger.kernel.org>; Fri, 28 Nov 2025 06:04:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764338675; x=1764943475;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2aYbQOviV9G6U7vQC1wZCjsv5aDiytW/O4hn4aGzwt0=;
        b=UxXFRPFH4X3ufclQOkZxs0L2NCerWWa6PH+A16cIgXqTC11nFxJ7NGsgdgzlODUqQA
         36OXUzqY/GBjJxON+ApqjGUVQ2gtzs02NhTjrCFFQNQu0b94fcGr9V/Sp5LKNJUqIS8L
         Ux39n1zKQiDF2FEcsomjouj/bsgG/FMhLjG5cCF/hoUfqK1R/uVpJ+/LImM94p/M0MLk
         SA4UK0k15OXMMsF+CEM7i0n2uzaHepMGzOSgID5Mi5Mw3rFD9g6P9WV+JTc6X1eMxqFv
         MviYfLzWqVQkJt1fiEZbd9llyvryywDfMqmDKI4LeJHW8MQFKK4OSTBB37Rdy2tBUyxo
         zbeQ==
X-Forwarded-Encrypted: i=1; AJvYcCUE9xJhJO5ydHi/OwpxxxO/OCrgxsjg1GSAWcKaWL8P1EyXxjwxR/6Sp+jKWUZ4FHdOnSo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzT6jHY+CU4QiKLTppVvOj1P9m1HvN49WjWsYvcfEEr/JlzKyOv
	mYxw/Q0B3ZHwSrvrmx9fLOg4BUarXDytcGUTyNQjj80Sb+RM93CgAJBqK7V/05QYuXNptXIQi9k
	iI6P5J7WBD4pl/+9BfA2o0e2r9oLUneDN4IpYMnm7iofxDpEMG5GFRtdeWUZVoJT/EQXJW4Fh+P
	nBjEn5r1Pt+nfcnqre7U+YfjrfYKFp
X-Gm-Gg: ASbGncs7GJSYA/yPFoPpyVHEu2CUG76uh+gRv0iZuSlXCzPJfk1cFpAczXXymkwqzg3
	Bfk50Z3AfUF/6lmDvLMozuGFCrJhnYlnXxuYeHj309fw8qW4PK2v8wuOfwPuEy0fRB7YiZRVKc8
	YeuOPTxLWesTSIB6Ol3BeIDB8y/LxdOI6fXMZTjSp19kq0W0s3bbByoviS0HXOI1pl/g==
X-Received: by 2002:a05:6512:3c98:b0:595:7c47:cd47 with SMTP id 2adb3069b0e04-596a3e983camr10042582e87.2.1764338674896;
        Fri, 28 Nov 2025 06:04:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGz66R88yyrnFnHjZ3XK8T/KldcTjOaeEpw5lXyP8wGGA8SNJySTlDwLR+bs2xmbBIFPh69rhXpxTJeYQlaS0s=
X-Received: by 2002:a05:6512:3c98:b0:595:7c47:cd47 with SMTP id
 2adb3069b0e04-596a3e983camr10042564e87.2.1764338674340; Fri, 28 Nov 2025
 06:04:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251117184409.42831-1-wander@redhat.com> <20251117184409.42831-9-wander@redhat.com>
 <CADDUTFz_gU0C8uqwDS3ewFRUxk7nbkGv1UU09Omjy0Ew2wB5VQ@mail.gmail.com>
In-Reply-To: <CADDUTFz_gU0C8uqwDS3ewFRUxk7nbkGv1UU09Omjy0Ew2wB5VQ@mail.gmail.com>
From: Wander Lairson Costa <wander@redhat.com>
Date: Fri, 28 Nov 2025 11:04:23 -0300
X-Gm-Features: AWmQ_blHLGrvmJS-VExLZPhZncF8FW2knptR9rNbECwrzHFDz6oKpDascdVpK0c
Message-ID: <CAAq0SUmsdk=uQ7NcjWHZDetm__q5CPxe+H-U01GefJXASN=6HQ@mail.gmail.com>
Subject: Re: [rtla 08/13] rtla: Use standard exit codes for result enum
To: Costa Shulyupin <costa.shul@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Tomas Glozar <tglozar@redhat.com>, 
	Ivan Pravdin <ipravdin.official@gmail.com>, Crystal Wood <crwood@redhat.com>, 
	John Kacur <jkacur@redhat.com>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	"open list:Real-time Linux Analysis (RTLA) tools" <linux-trace-kernel@vger.kernel.org>, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:BPF [MISC]:Keyword:(?:b|_)bpf(?:b|_)" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 28, 2025 at 10:18=E2=80=AFAM Costa Shulyupin <costa.shul@redhat=
.com> wrote:
>
> On Mon, 17 Nov 2025 at 20:56, Wander Lairson Costa <wander@redhat.com> wr=
ote:
> >
> >
> > -       PASSED =3D 0, /* same as EXIT_SUCCESS */
> > -       ERROR =3D 1,  /* same as EXIT_FAILURE, an error in arguments */
> > -       FAILED =3D 2, /* test hit the stop tracing condition */
> > +       PASSED  =3D EXIT_SUCCESS,
> > +       ERROR   =3D EXIT_FAILURE,
> > +       FAILED, /* test hit the stop tracing condition */
>
> The exit codes are defined as numbers internationally because it provides=
 direct translation from numbers to codes and vice versa. Additional indire=
ction doesn't add to readability.
>

I believe that where it is written "internationally" reads
"intentionally" (happens to me all the time). The main motivation is
to use the standard C library exit codes when calling exit().

> Costa
>
>
> ________________________________
> Hi Wander,
>
> Additional indirection does not add to readability.
>
> Thanks,
> Costa


