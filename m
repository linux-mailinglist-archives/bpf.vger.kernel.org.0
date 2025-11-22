Return-Path: <bpf+bounces-75273-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 64D83C7C046
	for <lists+bpf@lfdr.de>; Sat, 22 Nov 2025 01:34:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 433A036353F
	for <lists+bpf@lfdr.de>; Sat, 22 Nov 2025 00:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 228B8207A20;
	Sat, 22 Nov 2025 00:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OwOF9dFH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B16A19067C
	for <bpf@vger.kernel.org>; Sat, 22 Nov 2025 00:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763771679; cv=none; b=oMu3d2F0SNe8riH7PzH8jNhRVKJw1FCX+mDQnoLkyuflW97PO6oo6OHZf8QebGFDwYDVzj1hQiXErWzHMFh8ffBT0GVdKeiRySbHsOT6j1MVB5uUR6Xu+cZ3NIZshdy5ZxKo+OlIJ01r0czxphxRkLPqvInrswiGCP5Y5QNgImY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763771679; c=relaxed/simple;
	bh=Pg/OW9saPiNfnY22pVtquN0LCbn+Lzy9m13QsPz3Yu0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UdA7kFoNQWa+t2+tjVSIUMKSDCvcCxEulRg+RNfiscrIx4oC5XEqXkbOxP4MDN8AB8+hCMJOt/tEHmcWTsCaekh0lw6IHfo+y+nvfQQA6ePVI/rBXSfoQF6muUZO8wQDan9OHT4BSgsbRfcXruZXtJl5pX84IaUQRdZb6icLXKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OwOF9dFH; arc=none smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-64306a32ed2so713946d50.2
        for <bpf@vger.kernel.org>; Fri, 21 Nov 2025 16:34:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763771677; x=1764376477; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dQkS1cETZxYgPThXfkDjdzrQav1uw4NzyFlzBGaLEvk=;
        b=OwOF9dFHbukf7Xyc6QENaigmMxTzPuAN1YsiLuMf/G0vIf1AT3C5P7kfC0lgsjFIQ+
         Aa2rD6OnDtHwozQ4QE3UtdRssWi1MGADvbz3Mro062BJ9c4QA1UcmrDzndY2o8cvQ6xE
         ZPqcbMB58B5bAV44ftYt0pDpEX6E31KTLkJ4cspMvKpVDXplt8TNrJgeul6WO9iDmueW
         Zo0JPoOlFvPjQkETkfnzlxg5P5zYSAHVKph57vBG/8NLsnQ2S6JRT63EJ3shv5MlZy+h
         DHiRdtGvyC/OsD3Bmk8PS+7LpKe/YzQLTAYcqBgZuwONoEa26WHwcMPmPdPYWh8npeVD
         qb/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763771677; x=1764376477;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dQkS1cETZxYgPThXfkDjdzrQav1uw4NzyFlzBGaLEvk=;
        b=KSTB/tCJ+TVUvL2UiVposFKOMTIJN0v5CuaPZSyg07js1v6X4rlWjTekyrJJslxdgG
         DsYjf+SlzY4WSScfRzGwc9kpzQbo8br5pJuBFroweFgF+aWdexkQ/CcgyvB889SFZVHD
         wJ1Uu5j6wc5CahM/j7XwaXnClsk6x7aRsjGLUHwSuLS+IsyDFOHayp5UM2Yi3dSoiwn+
         W5WwNbZLulaf2tmj1eSsTc2+gX9xaSD3yrymCcOiCxdkjpfWFU83RWp+yuHTJd1MfbdI
         TDdPUTwReqSUoIf6Vx6ugPPuIVIsSIWX5X7O89UUT8grya6DvRYMyBPzlNS890b0cL0i
         1sSw==
X-Gm-Message-State: AOJu0YxBnaIMZuvZPqLg0gLTcfM8cBwZ22NIrlJQNRsiQR9rnfJGjQGH
	e9whknY6Mtjh590TtT97G1CUiHKubDnS7hzHJ6am2EaP+3s2iD1+qtR34D4q9c1jKk0OUqm8uSp
	pdkgCXEevByxnrByHjxRS5fklIZX+g2M=
X-Gm-Gg: ASbGncvaJ3oLIyB9Ax/kku7q9yag1i0T54IpCwcQJ6ijMGIpn3plCz1l6xgB1W2iFgJ
	21jmoBQ+vuowk34/zmSuDc4OGETgo3e6SqfHMydhWHhyP8yDs5iZ/Kbu4Um67EvSLiwNsX6v/y4
	qWHkFfyR2kCaGRY6FSVaqZVU/fIWTvi1ZrIJVOzVbG8RvPYNGtH+wmGVbtOBc6PM5Oa6BG7bsbf
	NJrJDn9A7r4xsJ6su7qUp/qhRpxaqTlrA8UPkpYqzDlGLR8Bk/BmfUX084MS29ixJTEx/E24Lx6
	ei8etQ==
X-Google-Smtp-Source: AGHT+IENwuHlGwwYNW8hhhyKct8eakoXi81jziCzpyiK4XX7FIICIoPiBYfvkNIVVnhWlh4FUD8NXF13qnUYmXDph8g=
X-Received: by 2002:a05:690e:2008:b0:640:d038:fafb with SMTP id
 956f58d0204a3-64302ac99e5mr2288195d50.64.1763771677068; Fri, 21 Nov 2025
 16:34:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251121231352.4032020-1-ameryhung@gmail.com> <20251121231352.4032020-5-ameryhung@gmail.com>
 <CAADnVQLeSP654facoQxW9EHJpLBivdM3rm6WpCsimsnXPbYJ1g@mail.gmail.com>
In-Reply-To: <CAADnVQLeSP654facoQxW9EHJpLBivdM3rm6WpCsimsnXPbYJ1g@mail.gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Fri, 21 Nov 2025 16:34:26 -0800
X-Gm-Features: AWmQ_bnb_zIJIzTox8-b4QZMvdhPNo0o2MJYofRK2yw3ki7OjQWQ04OPpMbjmVU
Message-ID: <CAMB2axPpZPD+h_AmKY2ypNomOHViDCsSxoPUYvikEd1EeGtxjg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v7 4/6] selftests/bpf: Test BPF_PROG_ASSOC_STRUCT_OPS
 command
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Network Development <netdev@vger.kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Tejun Heo <tj@kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 21, 2025 at 4:22=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Nov 21, 2025 at 3:13=E2=80=AFPM Amery Hung <ameryhung@gmail.com> =
wrote:
> >
> > +/* Call test_1() of the associated struct_ops map */
> > +int bpf_kfunc_multi_st_ops_test_1_prog_arg(struct st_ops_args *args, v=
oid *aux__prog)
> > +{
> > +       struct bpf_prog_aux *prog_aux =3D (struct bpf_prog_aux *)aux__p=
rog;
>
> Doesn't matter for selftest that much, but it's better to use _impl
> suffix here like all other kfuncs with implicit args.

Thanks for taking a look. I will add _impl suffix to the function name.

