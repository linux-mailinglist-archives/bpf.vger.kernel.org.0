Return-Path: <bpf+bounces-14268-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03AD87E181D
	for <lists+bpf@lfdr.de>; Mon,  6 Nov 2023 01:17:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D67E1C20A89
	for <lists+bpf@lfdr.de>; Mon,  6 Nov 2023 00:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76DDB38E;
	Mon,  6 Nov 2023 00:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=obs-cr.20230601.gappssmtp.com header.i=@obs-cr.20230601.gappssmtp.com header.b="Pc0Kf1W1"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E3B37E
	for <bpf@vger.kernel.org>; Mon,  6 Nov 2023 00:17:50 +0000 (UTC)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C19EB8
	for <bpf@vger.kernel.org>; Sun,  5 Nov 2023 16:17:49 -0800 (PST)
Received: by mail-qv1-xf29.google.com with SMTP id 6a1803df08f44-6711dd6595fso21628236d6.3
        for <bpf@vger.kernel.org>; Sun, 05 Nov 2023 16:17:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=obs-cr.20230601.gappssmtp.com; s=20230601; t=1699229868; x=1699834668; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ulsmunuNb8bz0pUFc21DYC/kQrN38pAwzjD0Cf6Sa9A=;
        b=Pc0Kf1W1su9vKqGaNwgQ+/SZF3LtwVU8za1VYEhD0qUlBiHTwZ5LeTf31HonY1M6ps
         24zqAYWSDj083lkqx5L4xwA6+exe13B+kmcsVQSrSBBxpHdfdLxB/J5viL0ZDLaD/9/S
         ni5hXe2pc5oJ7L31/uYlV8RrmUvztioNx8fLqa+qyvu6Ek0BNUv0GcnOmpivndVfqBzf
         kaMZuXSIXMJLoUtQR9SsfGeAVTJWLS69EcST3J8rhDOmWWXuSjpdToYncIDN0V8hF4DT
         u27JyBpx+ZI7SWOzx3uk2xX0hQ0z5Kj73nFEB7GQnD5tHlUSOxRCmxP64R/17NEYaJ8w
         E+9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699229868; x=1699834668;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ulsmunuNb8bz0pUFc21DYC/kQrN38pAwzjD0Cf6Sa9A=;
        b=QS8kR3WXc9smPfPNTFRHs3sXQUtYqER9N/JbS5fyzHaYGE4QUGHFOqhxbiXJlDHV11
         hmptwxriXfQ3q+sH/wKUsj6/CgA642D3qRSHnjZWhj6myz/J7EH4S9Ty2TWRx+Cyx4Bg
         B/zPuRC0GSgPXVHA1wa9b9RSlhTMyuv8eN861MuI+XTGBYwprG4k9aIX+Kk96ocCRPxC
         LUSBey7eJMsLKKkLUgp6Xe7hOG5IkghebEWEdq5q9uAy3yatHJW5dPy1QhFU7/4o7lHR
         WEqDaTeLjW1QiLrLJyFhLnZoWjhZtAGWWr3BiTMcrOFzugPeePfTmUozTvXJEPeNMpuW
         iIVQ==
X-Gm-Message-State: AOJu0YxEBgTWrhLudAKDMV034z2yOedPhgmo1bdF0g6y4EJYLDfPd7e6
	ZjDzUEDJntY0hYdnth3BaVMgkkGO2JZroTODl5XoWs+a9C3MZvs9
X-Google-Smtp-Source: AGHT+IEklZDO6gZsTi+kvNyqhsxeJHjtg3+uciDip8aP1B0ev6pt81FBmlxgTfbZZUXkMcz3qAutFsqGN7H8LRmTIpQ=
X-Received: by 2002:a05:6214:2488:b0:65d:afc:3a52 with SMTP id
 gi8-20020a056214248800b0065d0afc3a52mr30052300qvb.49.1699229868554; Sun, 05
 Nov 2023 16:17:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADx9qWgqfQdHSVn0RMMz7M2jp5pKP-bnnc7GAfFD4QbP4eFA4w@mail.gmail.com>
 <20231103212024.327833-1-hawkinsw@obs.cr> <CAADnVQLztq5W9qmGUBQeRBUJeCmTcc9H-OXCCJJzn=0baz+8_Q@mail.gmail.com>
In-Reply-To: <CAADnVQLztq5W9qmGUBQeRBUJeCmTcc9H-OXCCJJzn=0baz+8_Q@mail.gmail.com>
From: Will Hawkins <hawkinsw@obs.cr>
Date: Sun, 5 Nov 2023 19:17:37 -0500
Message-ID: <CADx9qWiQA3U+j-QoZPh7z66_2iNv6B51WXmd60Y-6GKhg+k0=w@mail.gmail.com>
Subject: Re: [Bpf] [PATCH v3] bpf, docs: Add additional ABI working draft base text
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@ietf.org, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 5, 2023 at 4:51=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Nov 3, 2023 at 2:20=E2=80=AFPM Will Hawkins <hawkinsw@obs.cr> wro=
te:
> > +
> > +The ABI is specified in two parts: a generic part and a processor-spec=
ific part.
> > +A pairing of generic ABI with the processor-specific ABI for a certain
> > +instantiation of a BPF machine represents a complete binary interface =
for BPF
> > +programs executing on that machine.
> > +
> > +This document is the generic ABI and specifies the parameters and beha=
vior
> > +common to all instantiations of BPF machines. In addition, it defines =
the
> > +details that must be specified by each processor-specific ABI.
> > +
> > +These psABIs are the second part of the ABI. Each instantiation of a B=
PF
> > +machine must describe the mechanism through which binary interface
> > +compatibility is maintained with respect to the issues highlighted by =
this
> > +document. However, the details that must be defined by a psABI are a m=
inimum --
> > +a psABI may specify additional requirements for binary interface compa=
tibility
> > +on a platform.
>
> I don't understand what you are trying to say in the above.
> In my mind there is only one BPF psABI and it doesn't have
> generic and processor parts. There is only one "processor".
> BPF is such a processor.

What I was trying to say was that the document here describes a
generic ABI. In this document there will be areas that are specific to
different implementations and those would be considered processor
specific. In other words, the ubpf runtime could define those things
differently than the rbpf runtime which, in turn, could define those
things differently than the kernel's implementation.

