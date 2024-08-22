Return-Path: <bpf+bounces-37890-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 074A095BDBF
	for <lists+bpf@lfdr.de>; Thu, 22 Aug 2024 19:53:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 196741C232AB
	for <lists+bpf@lfdr.de>; Thu, 22 Aug 2024 17:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A48FA1CF28E;
	Thu, 22 Aug 2024 17:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y6BtDkyo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5BCB15ACA
	for <bpf@vger.kernel.org>; Thu, 22 Aug 2024 17:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724349203; cv=none; b=Tj0vv96J0NmY6FYBJ8Aag4QL1mhhPXH9dTpyn4+s7kHptnlsUpTHM/0f0+RQikwSGmpDnQc0TyY1/CDnekxf0loFLBQt3MVJI5+xK9aWrMki8fbG73/HxBvp+bNwWUJRvvLGuXzUCquT87AX8jfbGqmg4XokrF1JN0ruEY2z3MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724349203; c=relaxed/simple;
	bh=gXD39ehsIhkUMWpXaX4OZLqLZbgYP8RigfBoTXxeJWQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MOBrOhyIPGxJNKJWBuUdfohLDLTA7BdQdCs3CKbQgn9DA576szT1p6BHn9YLYtAT9pbBXGYyAU3L3heYVyloWojP1LZ6mqO7LeA9y5Dxf6omtDA/GtYTsujeH6vODSCtyLiBgTi+JZl3CJdJHrA8TIvgBHwIpLiz3Cj60tii3YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y6BtDkyo; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4281d812d3eso11084785e9.3
        for <bpf@vger.kernel.org>; Thu, 22 Aug 2024 10:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724349200; x=1724954000; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gXD39ehsIhkUMWpXaX4OZLqLZbgYP8RigfBoTXxeJWQ=;
        b=Y6BtDkyohDppiCRk90eG9GIwhVqJGESjbp9bo4GGlEdsYqYg1+zOQKACxYzgFhMC2I
         iTMnbONCSCPHsJUwVpNdIi2uPuuf0RXujsGQyw8b1u3ovRnWYZb4y+EcBHxKKkkBcH4w
         3lGTWDITNqK3/ws3uEZbgyY6xRtmu6bOPwCTsRDIMLcN6YbaEK06pQe5TegE4LlUSR/1
         3UgonVu4NCGv+mKI4Hoc1ABxnrf8WlEofOxNr8B3XqbgbD6Mbm4l3WmBYLyMZJYH9Ze1
         BEzhdcFbcy5jF6jHNlRjfNU17WTVqXIce+3zPiUTQ7GIxJs9+E2D/qRm7GfIadPXbqTr
         1bGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724349200; x=1724954000;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gXD39ehsIhkUMWpXaX4OZLqLZbgYP8RigfBoTXxeJWQ=;
        b=Ibj32FtQZg8p95qyYCKCezLPYxSQXPLmuAc+WYD6U+SVuqjpiv8sIAg2iWiOuywsnQ
         SDRJUZsb6eb+8TFR70ZOICbZhHxav3HGyr5jLHCdo2tTJmPS/H14A0LIZk23AHSMm0r1
         Q32eEnZvunivr2VjOmcd/nTvvPen/oZLtbkZNy4Ssn1ttspQYIOwbyIFVrukLlr++szN
         zk2tYp7MXd+Nb9weOZxiIm0I8wn9qtKvbIE8BwxaKK5x1vqdEMcZPThuQnMqMO1+fnNT
         b1i4S9xpLY23CkzOEXxzd9dNfeSxwhzubJ5dZKx4+ZqOqmZ4g2LWbJLsUmzCvVn7NEzN
         IabQ==
X-Forwarded-Encrypted: i=1; AJvYcCVq6GQQNd7H1pWGyuukbuVspBIi8Oxm5KglVCossqpiiobnnWU1OWNQmBL2KIz+x6Q4Z40=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWV4LZdY5CGl1LZL/kURqpO6duXPGIkcD0PTUa3M2MZcQhVtFC
	lyN11nkeZA/j7IJgVSqmctWf1WP8BRygOOQn2baXxCcmOjTKzgYXHyDKv8tfthHbqOM7o+8W38f
	LdwVp8d8GR+3KKUiHPDSSqAjoD7A=
X-Google-Smtp-Source: AGHT+IEtr1awS+kjm+s7AstCtm458smHvuLPGI0F2Qqce8PPP+40tkovccEHnlKxfg/SSNcztZ1gRnK2Y53QQZxqV5g=
X-Received: by 2002:a05:6000:470b:b0:371:83ae:809b with SMTP id
 ffacd0b85a97d-37308c0090cmr2826013f8f.4.1724349199671; Thu, 22 Aug 2024
 10:53:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240822001837.2715909-1-eddyz87@gmail.com> <20240822001837.2715909-3-eddyz87@gmail.com>
 <CAEf4BzaVjrHSi9eh9-YP37tsH2B5n0ah3m290Y7_v6zBXrEBiw@mail.gmail.com>
 <b058840690d79648405839c2af767a783a41bef8.camel@gmail.com>
 <CAEf4BzYK9JpdPonHhSARkLRbStMA94URxZ0r5fpaOg693jtLpg@mail.gmail.com>
 <CAADnVQ+umPO=jSqv+boTqS_-r_PYJyzhVms4438SxeG1hN0GFA@mail.gmail.com> <CAEf4BzZ6GZJWiy0+R3y3dtEjSeN9PK=BM2HozndP4C7M7cAGMw@mail.gmail.com>
In-Reply-To: <CAEf4BzZ6GZJWiy0+R3y3dtEjSeN9PK=BM2HozndP4C7M7cAGMw@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 22 Aug 2024 10:53:08 -0700
Message-ID: <CAADnVQL1M0NoLhdQtD+9PRsm33HKOSCU8buA_hdiKDD+nx3X-g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: test for malformed
 BPF_CORE_TYPE_ID_LOCAL relocation
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Kernel Team <kernel-team@fb.com>, Yonghong Song <yonghong.song@linux.dev>, 
	Liu RuiTong <cnitlrt@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 22, 2024 at 10:27=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, Aug 22, 2024 at 9:55=E2=80=AFAM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Thu, Aug 22, 2024 at 9:51=E2=80=AFAM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > > > I don't see why we can't extend the bpf_prog_load() API to allow =
to
> > > > > specify those. (would allow to avoid open-coding this whole bpf_a=
ttr
> > > > > business, but it's fine as is as well)
> > > >
> > > > Maybe extend API as a followup?
> > > > The test won't change much, just options instead of bpf_attr.
> > >
> > > yep, follow up is good, thanks
> >
> > I don't think we want this extension to bpf_prog_load() libbpf api.
> > This is internal gen_loader use.
>
> bpf_prog_load() is just a wrapper around BPF_PROG_LOAD command of
> bpf() syscall, so it feels appropriate to expose all the available
> kernel functionality, even if libbpf itself doesn't use some parts of
> it. Those core_relos fields are there in bpf_attr and are part of
> UAPI, what's wrong with making them available in low-level API?

because it's a maintenance cost for something where
the single user is a selftest.
Hence I wouldn't bother, but I don't insist.

