Return-Path: <bpf+bounces-49536-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CA49A19A88
	for <lists+bpf@lfdr.de>; Wed, 22 Jan 2025 22:53:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 412BD188D429
	for <lists+bpf@lfdr.de>; Wed, 22 Jan 2025 21:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB3B81C5F12;
	Wed, 22 Jan 2025 21:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="be96s8Jp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4AB71C5D61
	for <bpf@vger.kernel.org>; Wed, 22 Jan 2025 21:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737582780; cv=none; b=ipT3A5Z8ZS93/UQs2Fs62r+9/Qn2V9ZPQyDDwx7y2BVkMuAaT3B2BC/ctPJsG6QvcPJfuvv+b7JMI3/vsLVXSyn9w9X2Xq0DaTPeW0LMYDnkUlCPH48agquheFVUiWbw/n9UxkQXTP1h+gGBAA+RVOcEOkAQcEG4YYa2bAzWLKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737582780; c=relaxed/simple;
	bh=W+/zUCXG69NoiJf3QZS5QVQEK/s/6uTInBFBs8Mv3E8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YlVgzt2T8pnCccj18rmD1jDhUA3uvmHag4pI0QPLWBTQiSWJfVRchCuOR797B2VwNvPXwW5Fw9RZuZjJHCTV53ySi6zPkX9CMGN/NuV/3cUIwpkBVKZGHyBe9V/UiMGnWKyifjCO7qI9rdVEvcajx48RETcmKmy97H4kTsO+7VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=be96s8Jp; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-21bc1512a63so3175895ad.1
        for <bpf@vger.kernel.org>; Wed, 22 Jan 2025 13:52:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737582778; x=1738187578; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3WGLzZ0m5VTEG7U3PVKDe3p8gkg3ZZFPZucf8BYG4mA=;
        b=be96s8JpcVTQcrNO0d0bR1tQsps0ox0RrdACT6yRmEWiuOQS/0/Hruf4437jK2eOxw
         E0lZ3TH9FvRTDe1oyKOX54biQG297KBGEBvkItV7GPDPYPl6+K7eptveA87HCvBGBCJr
         CO7hXdZT1pLQoxosOTtgk13zLjfyhLxIkKkxSv1PBqeJGxwLr1SKUs2Wgszgsgylwsow
         855nHuXzCnIoNIrPaKP0GNk8xMqhHWLBPzuNcJV7kkb/qNIYGoEpCwYGrzeJ9KGFf+ja
         iAuGelGKYvNE0SImQTa8kbCDmU1+oGyxpMFqfy9wTDcCSmNTMHUvFhsDWUIqOmAAqlyA
         y4Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737582778; x=1738187578;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3WGLzZ0m5VTEG7U3PVKDe3p8gkg3ZZFPZucf8BYG4mA=;
        b=W4k1IMGjyvd7hdrqsa/NiE1CIMzcBAkhh3l2SqKDuLgbuYedNRxEPLUwSUTpT9YBco
         zzf70ZD3Ov+2LGxtThOc3SnkraN5xq5L8kTvMsueQ2v0edCd05dqlNlXuzkNb7setPFL
         7dIXlH1SQTQlCO2HAr55MrciLF8FuhXayPEEovxK94I39nCvtxpV7AEskfpwytZg9cYQ
         1BUURyyLynBKNYQT6sS09RbDqS3P/OHyuioB7h2mnBMlTktDNZMaJuE1cFvBBvFEC4pg
         jUSg+/flWTmVBPJk5kBBFrQFH03K2Mh7hi9SYk9xhCsRdhUbWrMyC9NeF3qDZio91zPn
         yq1g==
X-Forwarded-Encrypted: i=1; AJvYcCWPBRJ3R0W76FDEIJbucltEwCsxIITnM1HGraA9sji7SyCENtE2rbqz+DUlPEAGQWFSLD4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4LwFeAqOjMg+6nqHj8iKWf10m2y5g/EcdPqf3TxLbuvYWgUKE
	3HCKAoX5Q+eHXYCg+cZ9Rw5LK3pcNuzT7YY7V5HlalAznjSt7Vu0skS46ToyqIndQ+Tqpxm88v+
	+fBxIizbH1bl0dx0EpaqgAb6aljaGvA==
X-Gm-Gg: ASbGnctw41Sg8TH1BxlzF/PZtfz3yH0TcvV2fu14jLewT/8fIoxhrUTjU/H47l0M5Tb
	F6kRar8s+G9TIyTRAg/MN3jjxgE2aKomY584m/zog8rOwF5YTt2EfXJKEhxXvy0Aqc3E=
X-Google-Smtp-Source: AGHT+IEkQXirpXegomIa3NpywpevCcu3MXdDP8S8i4wweCowJu9ckC4+nPPuZ9RX+d1k87mAvfsTqRGn3DrOnlX1I/s=
X-Received: by 2002:a05:6a20:a11d:b0:1e0:cc4a:caab with SMTP id
 adf61e73a8af0-1eb214de542mr33132818637.19.1737582777794; Wed, 22 Jan 2025
 13:52:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250122025308.2717553-1-ihor.solodrai@pm.me> <87msfjhy3v.fsf@oracle.com>
In-Reply-To: <87msfjhy3v.fsf@oracle.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 22 Jan 2025 13:52:45 -0800
X-Gm-Features: AWEUYZnhQ9SLrzK_0W-ugW40jsK1rROV01jFcGvqfOaQzDHpLGJNNKukorfFTiI
Message-ID: <CAEf4BzbVxbtpRnAo2PqrF0n7-B28p59KPvozXuEuPpTZYA9=7g@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/5] BTF: arbitrary __attribute__ encoding
To: "Jose E. Marchesi" <jose.marchesi@oracle.com>
Cc: Ihor Solodrai <ihor.solodrai@pm.me>, bpf@vger.kernel.org, andrii@kernel.org, 
	ast@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com, mykolal@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 22, 2025 at 3:44=E2=80=AFAM Jose E. Marchesi
<jose.marchesi@oracle.com> wrote:
>
>
> > This patch series extends BPF Type Format (BTF) to support arbitrary
> > __attribute__ encoding.
> >
> > Setting the kind_flag to 1 in BTF type tags and decl tags now changes
> > the meaning for the encoded tag, in particular with respect to
> > btf_dump in libbpf.
> >
> > If the kflag is set, then the string encoded by the tag represents the
> > full attribute-list of an attribute specifier [1].
>
> Why is extending BTF necessary for this?  Type and declaration tags
> contain arbitrary strings, and AFAIK you can have more than one type tag

Because currently TYPE_TAG(some_string) is
__attribute__((btf_type_tag("some_string"))).

That btf_type_tag() attribute name is hard-coded in the semantics of
current TYPE_TAG (and DECL_TAG as well). So here Ihor is generalizing
this to be __attribute__((some_string)).

> associated with a single type or declaration.  Why coupling the
> interpretation of the contents of the string with the transport format?
>
> Something like "cattribute:always_inline".

I think that ship has sailed. We didn't define any extra semantics for
any sort of "prefix:" part of TYPE_TAG's string, and I'm not sure we
want to retroactively define anything like that at this point.

What is exactly the problem with using kflag=3D1? Keep in mind, at least
initially, this is meant for tools like pahole and bpftool, not
GCC/Clang itself, to augment BTF with extra annotations (like
preserve_access_index attribute that is added when generating
vmlinux.h).

>
> > This feature will allow extending tools such as pahole and bpftool to
> > capture and use more granular type information, and make it easier to
> > manage compatibility between clang and gcc BPF compilers.
> >
> > [1] https://gcc.gnu.org/onlinedocs/gcc-13.2.0/gcc/Attribute-Syntax.html
> >
> > Ihor Solodrai (5):
> >   libbpf: introduce kflag for type_tags and decl_tags in BTF
> >   libbpf: check the kflag of type tags in btf_dump
> >   selftests/bpf: add a btf_dump test for type_tags
> >   bpf: allow kind_flag for BTF type and decl tags
> >   selftests/bpf: add a BTF verification test for kflagged type_tag
> >
> >  Documentation/bpf/btf.rst                     |  27 +++-
> >  kernel/bpf/btf.c                              |   7 +-
> >  tools/include/uapi/linux/btf.h                |   3 +-
> >  tools/lib/bpf/btf.c                           |  87 +++++++---
> >  tools/lib/bpf/btf.h                           |   3 +
> >  tools/lib/bpf/btf_dump.c                      |   5 +-
> >  tools/lib/bpf/libbpf.map                      |   2 +
> >  tools/testing/selftests/bpf/prog_tests/btf.c  |  23 ++-
> >  .../selftests/bpf/prog_tests/btf_dump.c       | 148 +++++++++++++-----
> >  tools/testing/selftests/bpf/test_btf.h        |   6 +
> >  10 files changed, 234 insertions(+), 77 deletions(-)

