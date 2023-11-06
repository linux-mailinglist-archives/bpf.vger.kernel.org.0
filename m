Return-Path: <bpf+bounces-14281-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7348B7E1C68
	for <lists+bpf@lfdr.de>; Mon,  6 Nov 2023 09:38:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FCE41C20AE4
	for <lists+bpf@lfdr.de>; Mon,  6 Nov 2023 08:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B80362561;
	Mon,  6 Nov 2023 08:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BjSXGWnZ"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39AE15B7
	for <bpf@vger.kernel.org>; Mon,  6 Nov 2023 08:38:26 +0000 (UTC)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E87E8CC
	for <bpf@vger.kernel.org>; Mon,  6 Nov 2023 00:38:24 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-409299277bbso29586115e9.2
        for <bpf@vger.kernel.org>; Mon, 06 Nov 2023 00:38:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699259903; x=1699864703; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1obyZVSBDJ9jwrMhcq9z3qKGElXG9y+4Qk9KA/x4aWA=;
        b=BjSXGWnZ8LggJrabd+4b9PiubQg/ijuHLcxwQoxrrVKO6mmG9dOFzNRT56yznncVKl
         1l0a4b7dGTujYXrApB53KBqH6Unn0jDfhRWKVi9WsjiNPFtvlg+qjr8xdDyDdy46Hywh
         MSLcvqq+Pz2aaF09Pwe4uXR6gvQaYq1eAnGwUHCYSGWzdePMaZb8BRDO81sx+HiMRxc+
         vddJSAmJR+wI6XZ81Sy/3faDccbkOtIeW2uOv15OtsVCmYy304S5w6QpOuKSRUO+Ebor
         Fjso1PAfEW6RsD/yUpHdeTlAou0ocqAn2ZCHwbXf2kMOEbNYn7fPnRgncLBDTXbuWQje
         SGMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699259903; x=1699864703;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1obyZVSBDJ9jwrMhcq9z3qKGElXG9y+4Qk9KA/x4aWA=;
        b=TjL2HUcLQp1iLbXY9o//BYTh5XKPQ2aUlZzwlkshz4veE32vYLYcU0gsk3MkBR6DLb
         KQ/mAJFJB4CnSN/d4OYM8sXsGMPkZzBckbUvZ0KAupztMa+ghOjQiI9U4rdGk6kg8nYv
         oeSqbQ3vcRZnVa3sqJEE5nWEskL2eqZxUxwspVRcYM+yHwNbByvD5Bpx52za3upHm/xk
         ZkyP+doo6q7J9ZUFtnETEUq8QMETb4wWO8+2WIgpdP0itnQGX6f5KuKTJckH5IV5Tzw3
         u10S/ZK+hi4IqMg5f1FRG1/rbt4nKmOVF1Nug3waldnY9WCe0LDLvxyE6yuGIb3+r+cz
         QqyQ==
X-Gm-Message-State: AOJu0YxT3ld4xf27yLng2D9JWXXU3lhlzn2JUiitUs/E6vtnAP5GETva
	FDtJTLj2MG93c/YwQ4Z5r2qDLfXoKEYvRnX9i1E+awKSNv0=
X-Google-Smtp-Source: AGHT+IEjFD8KY/TOwk7PJSfy8vr5F6hRLiRmnwNyGlJHh7X3p/vU0TsTi6LVojM6dLUpjGSx+gm1MvPZzB3JiEP7RW4=
X-Received: by 2002:a05:600c:539b:b0:408:3cdf:32c with SMTP id
 hg27-20020a05600c539b00b004083cdf032cmr26538523wmb.41.1699259903021; Mon, 06
 Nov 2023 00:38:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADx9qWgqfQdHSVn0RMMz7M2jp5pKP-bnnc7GAfFD4QbP4eFA4w@mail.gmail.com>
 <20231103212024.327833-1-hawkinsw@obs.cr> <CAADnVQLztq5W9qmGUBQeRBUJeCmTcc9H-OXCCJJzn=0baz+8_Q@mail.gmail.com>
 <CADx9qWiQA3U+j-QoZPh7z66_2iNv6B51WXmd60Y-6GKhg+k0=w@mail.gmail.com>
In-Reply-To: <CADx9qWiQA3U+j-QoZPh7z66_2iNv6B51WXmd60Y-6GKhg+k0=w@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 6 Nov 2023 00:38:11 -0800
Message-ID: <CAADnVQKXz-Y_ykNXa-sgSjo2r6F-vuO0Jx=9zHzG7j3-ZKhGYA@mail.gmail.com>
Subject: Re: [Bpf] [PATCH v3] bpf, docs: Add additional ABI working draft base text
To: Will Hawkins <hawkinsw@obs.cr>
Cc: bpf@ietf.org, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 5, 2023 at 4:17=E2=80=AFPM Will Hawkins <hawkinsw@obs.cr> wrote=
:
>
> On Sun, Nov 5, 2023 at 4:51=E2=80=AFAM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Fri, Nov 3, 2023 at 2:20=E2=80=AFPM Will Hawkins <hawkinsw@obs.cr> w=
rote:
> > > +
> > > +The ABI is specified in two parts: a generic part and a processor-sp=
ecific part.
> > > +A pairing of generic ABI with the processor-specific ABI for a certa=
in
> > > +instantiation of a BPF machine represents a complete binary interfac=
e for BPF
> > > +programs executing on that machine.
> > > +
> > > +This document is the generic ABI and specifies the parameters and be=
havior
> > > +common to all instantiations of BPF machines. In addition, it define=
s the
> > > +details that must be specified by each processor-specific ABI.
> > > +
> > > +These psABIs are the second part of the ABI. Each instantiation of a=
 BPF
> > > +machine must describe the mechanism through which binary interface
> > > +compatibility is maintained with respect to the issues highlighted b=
y this
> > > +document. However, the details that must be defined by a psABI are a=
 minimum --
> > > +a psABI may specify additional requirements for binary interface com=
patibility
> > > +on a platform.
> >
> > I don't understand what you are trying to say in the above.
> > In my mind there is only one BPF psABI and it doesn't have
> > generic and processor parts. There is only one "processor".
> > BPF is such a processor.
>
> What I was trying to say was that the document here describes a
> generic ABI. In this document there will be areas that are specific to
> different implementations and those would be considered processor
> specific. In other words, the ubpf runtime could define those things
> differently than the rbpf runtime which, in turn, could define those
> things differently than the kernel's implementation.

I see what you mean. There is only one BPF psABI. There cannot be two.
ubpf can decide not to follow it, but it could only mean that
it's non conformant and not compatible.

