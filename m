Return-Path: <bpf+bounces-54866-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 54694A74F81
	for <lists+bpf@lfdr.de>; Fri, 28 Mar 2025 18:36:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE66E1894BBD
	for <lists+bpf@lfdr.de>; Fri, 28 Mar 2025 17:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C698E1DE3AC;
	Fri, 28 Mar 2025 17:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TAmLumbp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9291C9B62
	for <bpf@vger.kernel.org>; Fri, 28 Mar 2025 17:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743183253; cv=none; b=m+lnDAAK/Re01xLp2vBEmpKJmn9TBITfQ3qeh7z8tUJVZBw8lpeQrML7xqxT03WFAN0UTyI37Gjt4+17q2hmJWu28hpurHu19u3ZQwlE6ZkncfQZ4cFJ3BcIOy4+DYokEs33odtYG8w1CaqwW9YL38asJsWek5pbVxvG0J36ciw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743183253; c=relaxed/simple;
	bh=40/Lz1fBCTMJc4Q4sBEAB/9hYS3yfNDoC718RkPlG1c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zo8osplZ3hPmL0Fwzly3tzcsM5t01vw0avhRP5HuRP0YSdozj/9DU4C2wK/Ow1F7kjsLjKUWK4bStRXfU1rUPA3mEW8vWCaj4CIeVQMSz3qU4RNej3EymMvY6B+mAFP38DzLona4hqdrkbXtQwGN68oJsO1wcJ0JbhcTWbJFp7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TAmLumbp; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-224341bbc1dso49412045ad.3
        for <bpf@vger.kernel.org>; Fri, 28 Mar 2025 10:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743183251; x=1743788051; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uzRnEtBGnPBwZ/QjtPsy4n09BJmodDUuUH2PkgoKo5c=;
        b=TAmLumbptWyb4zRRcg9XZWyZ7SqDMbXSrp+PNLv6Bwd+Pjg0TLl7Mb3dkxGnh/2y2l
         x4qpAoJa3KDAsOY9Ztcby36xOAzEoDwG/tTnN4jpE1t+W3bKHeg86FxNaOJrFPJi5H3T
         2oL3pEnsOChQ41fEhHwrNXs1tE/CopoU0C9EzvX5yIGcaB3c48kT95DDl0BgIMPqFVvx
         yKiFUK9p7JF+KHgIVAeqPwpZjqi9sGUWJs9i7TmhxEIVvRPcGlldshXLaLE96Lbt2lCD
         hSgazKyugUtru76IYZS8r65L0NryTzjthGDJvxsH6hVi2LNfxOTGoqbM/S/mw9PcPGyR
         Ga2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743183251; x=1743788051;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uzRnEtBGnPBwZ/QjtPsy4n09BJmodDUuUH2PkgoKo5c=;
        b=V3c7QN2CYguh0oODEZpzjx0mCCBEN8Z0NuElsR6NLU0xcP4La1wai3Ou1+WrZwDa31
         V+tjWBXGMuAIty2M0dYOvRkzXHr8qBVTfa0c6loB6NL2NyUsV3lw/1Hk0ej+2S56syo6
         /P3TYJSlqv6W+knJOWum9LZ317OpqvzZ+bdUTlvVqSMK4AXS8sLEdFDNvUd9Etg49GVX
         O4ZmpYfQ5lPJP9CyTSFNeZjCzPIkbwuXkRNKvF3fUxj4BBjbb/8IxZMtODPxhB4/bqWC
         7UjGtUnCx6jZBrGR9pZYr/vrtHRRsDeAC5fy34m7QOuN2F3Ftq9n3gWDwV4It+rWvqZd
         Xe0A==
X-Forwarded-Encrypted: i=1; AJvYcCU3gJ11wpVCr42P1VSq/LR6jB8H9uGeKWT5tHzeCZp1LVUTmQAhl6qJw0ZvxVMbPYAklg8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzupiJiETw1gh0UUikrv4S8x3sKTvgQ9IlhlxEo7RcAfKZGqLy7
	+xrY6UvFgIXt84EKdoUVNYX9SQSr+grPU0pE+/ZrQ7O0MroTERQZpzB9wSvYFvla51mTIZgm91I
	3trNl+rJGRsc2LSNWdc+44luLj+Q=
X-Gm-Gg: ASbGncuCSvRwwiAyiuKRrJq7XxsmXLtowB8VedvHG/zhOtAn2OqM0sXIu0JYaf/IkZz
	OhI0i7zIXnzS8vsukyT6++1hfKO5qFuReY3DWyYMu9ULzS8eV6JnZWkQMddbpoA63qQg9eMwXAt
	x/zJoD2P2Hhy3/IyBPRdZSri5dGxiXjf81CD3167yTRA==
X-Google-Smtp-Source: AGHT+IEdhdw1SlU2iTSvOXN9JFVrjv/E6/IN1vkCwOOf4TTpvM9kmTUdLS6xqyI4mLGnSxknu67dSkLT6miMfqStU+A=
X-Received: by 2002:a17:902:f709:b0:210:fce4:11ec with SMTP id
 d9443c01a7336-2292f944ecfmr386205ad.1.1743183250995; Fri, 28 Mar 2025
 10:34:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250326180714.44954-1-mykyta.yatsenko5@gmail.com>
 <CAEf4BzY_rbdXFDyYN=s7c25R5kwpBX5-zxQd8Q+6wX2N0r6Uhw@mail.gmail.com> <d3edc724c733fc656eb61f98c9a78273ebd28df9.camel@gmail.com>
In-Reply-To: <d3edc724c733fc656eb61f98c9a78273ebd28df9.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 28 Mar 2025 10:33:57 -0700
X-Gm-Features: AQ5f1JrZkUuaQwo22JgoVwjnhUi12A3CVlb4zUBMA3CvNjoz_7lwd2qPRARAGvE
Message-ID: <CAEf4BzZtV41XHK3i+HyT9hxxfA8wqA3PkSTW31yQwQraXBM1bA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: add getters for BTF.ext func and line info
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org, ast@kernel.org, 
	andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 28, 2025 at 10:29=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
>
> On Fri, 2025-03-28 at 10:14 -0700, Andrii Nakryiko wrote:
>
> [...]
>
> > As Eduard mentioned, I don't think `void *` is a good interface. We
> > have bpf_line_info_min and bpf_func_info_min structs in
> > libbpf_internal.h. We have never changed those types, so at this point
> > I feel comfortable enough to expose them as API types. Let's drop the
> > _min suffix, and move definitions to btf.h?
> >
> > The only question is whether to document that each record could be
> > bigger in size than sizeof(struct bpf_func_info) (and similarly for
> > bpf_line_info), and thus user should always care about
> > func_info_rec_size? Or, to keep it ergonomic and simple, and basically
> > always return sizeof(struct bpf_func_info) data (and if it so happens
> > that we'll in the future have different record sizes, then we'll
> > create a local trimmed representation for user; it's a pain, but we
> > won't be really stuck from API compatibility standpoint).
>
> There is also an option to do:
>
>     const struct bpf_line_info *bpf_program__line_info(const struct bpf_p=
rogram *prog, u32 idx)
>
> and hide the rec_size.
> But yes, simply assuming the array of `struct bpf_line_info` looks reason=
able.

The main (and could be the only one; though I can see bpftool/veristat
or some other tools using this to do a better program dump as well,
but alas) use case is for manual bpf_prog_load() of a program prepared
by libbpf as part of bpf_object__prepare(), so making users
reconstruct an array one item at a time seems counterproductive, IMO.

So I'd say it comes down to whether we expose "line_info struct can
grow, theoretically" parts in this API or not. But I can see how we
can accommodate this with adding new APIs (and keeping old ones
working), if line_info or func_info ever grows, so it feels
justifiable to do it in a simple and nice way today.

>
> [...]
>

