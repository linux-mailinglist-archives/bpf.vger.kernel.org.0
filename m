Return-Path: <bpf+bounces-26207-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E516589CA9D
	for <lists+bpf@lfdr.de>; Mon,  8 Apr 2024 19:17:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 237091C24404
	for <lists+bpf@lfdr.de>; Mon,  8 Apr 2024 17:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC8E9143C67;
	Mon,  8 Apr 2024 17:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DGc9L4dp"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF6114388F
	for <bpf@vger.kernel.org>; Mon,  8 Apr 2024 17:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712596637; cv=none; b=CZPUqauVRZZK1mMlocImHMpWXpahszn+EEiBb/Y3JLHmIrzzNzfqNqtpFB6pt0tyhHf5d7D9PqW0fJezqdfy3Pf7DF8FweS7ozCQkHSk//RaE7/Joov7v9Ajj9Euull1TfThabcX872Ag+CpfPMbGRX6GJSjMzitSSMdrV272AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712596637; c=relaxed/simple;
	bh=xF4xeuz99ep8htCfVfsU9KUXsF8OcTckfAdeLONyRZA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b1N6MuYnNrmq2rfaOm77TLrlNINwlO2Tvai9CgtAvNtp3osrtjbJC2emCR4OtKZnIHhR2V9qpffIaY+RJY/v6DNLrl/QSRO6EA3qj7dNK/MMTN2gjnm4E6ahBVpfDUYxmh+IIJ6oqpLWuIJ8zHzCER4Aw0tNn4sNbUW2qZd0aaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DGc9L4dp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712596633;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WW0XvdmjMS/v2Hm/5i1sBEwUsjS5WooxJxuAgT2dOlY=;
	b=DGc9L4dpC50G4fIjgG+SMha2gpdnY1RFqgZqesmx43aQaiZqtAveJQ/0/wolm4ZCEGnSjA
	cCb8hr7uCZ11HcvJxKX1D53uBxp7mgisIJb5BjRjOgrN+RE9SXxCIegd6ncDBIzq+TpFVX
	pdgObnp5gUoH4Rn2lHLynVx2mkZ+5Ts=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-315-vO2YeUAyN_-RkpNxmwFR2A-1; Mon, 08 Apr 2024 13:17:10 -0400
X-MC-Unique: vO2YeUAyN_-RkpNxmwFR2A-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a51acf7c214so52908966b.1
        for <bpf@vger.kernel.org>; Mon, 08 Apr 2024 10:17:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712596629; x=1713201429;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WW0XvdmjMS/v2Hm/5i1sBEwUsjS5WooxJxuAgT2dOlY=;
        b=u1gEwdHye7oI5jTNbYlFFusaid9tDMCQPzYitfxQUv+r2PVQFILtDd5MFc40tyNSbT
         KymBT1g6qBMCvcaBltrK4jP6YP1TVfHo4cRR1kTlArgMoscz+C2palpqGv/Nllp5jLVc
         IYTUp2fqIMbxDyc0NuYcDycP9kpb9Y4VVWTkpbQoVsjAZu3va4388JfGMoVQ9hgB4VSu
         oNOhdndkAYQYDvCZU//8bCBPlM45lFpvNb5UNdv8XloPiqxfDm8qesqHOnDqt6/w3FQR
         bBeskotsbBrgibpUmLB6UcFGwwbhQOkjgJWxR+fLK6Sp6MPygJYK7DyYcu9Ge4ICTzmj
         2kvg==
X-Forwarded-Encrypted: i=1; AJvYcCWxkQpLFanCnUgs5jzzDHGCh+mbA4RpTkf7sCNre75MCy8/jpVrzIli40We9Gt2WzN4imcwZtFV7tGUQeVG1X4jgtoB
X-Gm-Message-State: AOJu0YxkGzftnTVFtK6N0PGX91QUesCb2XVj5l08nOrqOLZMVu2G/L37
	HBnk3MHKPE9o174WVUqwju6uHudSq511Q8DkaruLpp85Ttre8ovfJqB6KEF1BisONdepcYl0KYi
	N+6GmzhKfnqW8myQjJvOqTCAgFECMQehbs7dMUVqYju24F9pvBIOgTgg2ZPPRbPMWHHx8xGsCw2
	WUKpzRBQ65gm7Yes8y0J91y6MU
X-Received: by 2002:a50:bae3:0:b0:56d:eef4:28f0 with SMTP id x90-20020a50bae3000000b0056deef428f0mr8272246ede.20.1712596629298;
        Mon, 08 Apr 2024 10:17:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEAF1+hbaATpPBSLsawJT9hD9ZY/wEezf8GBaxPQ4bTaPU4MyEkTrtk9mJjETJCu6N8z9MdWpNoScSpWk06qzY=
X-Received: by 2002:a50:bae3:0:b0:56d:eef4:28f0 with SMTP id
 x90-20020a50bae3000000b0056deef428f0mr8272229ede.20.1712596629007; Mon, 08
 Apr 2024 10:17:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240408-hid-bpf-sleepable-v6-0-0499ddd91b94@kernel.org>
 <20240408-hid-bpf-sleepable-v6-3-0499ddd91b94@kernel.org> <ed027c1d54cb588914602a84fa12dfb2a9a403bd.camel@gmail.com>
In-Reply-To: <ed027c1d54cb588914602a84fa12dfb2a9a403bd.camel@gmail.com>
From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date: Mon, 8 Apr 2024 19:16:57 +0200
Message-ID: <CAO-hwJJtrNDcJVcsU_XpS_HxXgwVXYQiAoia_UKnd1-rjCGguw@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next v6 3/6] bpf/helpers: introduce
 bpf_timer_set_sleepable_cb() kfunc
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Benjamin Tissoires <bentiss@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 8, 2024 at 4:31=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> On Mon, 2024-04-08 at 10:09 +0200, Benjamin Tissoires wrote:
> [...]
>
> > diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> > index fd05d4358b31..d6528359b3f4 100644
> > --- a/kernel/bpf/helpers.c
> > +++ b/kernel/bpf/helpers.c
>
> [...]
>
> > @@ -2726,6 +2764,7 @@ BTF_ID_FLAGS(func, bpf_dynptr_is_null)
> >  BTF_ID_FLAGS(func, bpf_dynptr_is_rdonly)
> >  BTF_ID_FLAGS(func, bpf_dynptr_size)
> >  BTF_ID_FLAGS(func, bpf_dynptr_clone)
> > +BTF_ID_FLAGS(func, bpf_timer_set_sleepable_cb_impl)
>
> Note:
> this hunk does not apply cleanly on top of current master.
> The line 'BTF_ID_FLAGS(func, bpf_modify_return_test_tp)'
> was added to the list since last time current patch-set was merged.


Oops, thanks for the update.

Just to be clear, I already mentioned it in the cover letter, but this
series is not intended to be merged just now (thus RFC again). The
plan is to add a new bpf_wq API on the side, and compare it with this
v6 to see which one is best, because I am trying to force the
workqueue API into a timer, when it's getting further and further away
from each other.

Cheers,
Benjamin


>
>
> >  BTF_KFUNCS_END(common_btf_ids)
> >
> >  static const struct btf_kfunc_id_set common_kfunc_set =3D {
>


