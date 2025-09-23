Return-Path: <bpf+bounces-69318-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA58DB94045
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 04:38:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85D5C441DFA
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 02:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD00C26F2B7;
	Tue, 23 Sep 2025 02:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N3vehyyd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47F8265623
	for <bpf@vger.kernel.org>; Tue, 23 Sep 2025 02:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758595115; cv=none; b=kkgMmWjC72pNQWYKZcufStVi17bn7wrKvmmoxuqHw6zDf8+p4Ay+ISx74CGq8gZlpwAuSKZ2H4bctgkjuIHy/N+AMaOaRU9WXs7jGFvgyXOSBsNHcdYxShVYGiH+Fk1IPY/43I64XPnR4/fEn2k83u4RXu+JXqI4PchERrQG2MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758595115; c=relaxed/simple;
	bh=khAfGN2HmpSSCrICEJhBR1zMFhyvufigG6/RSFKRFc0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VMagimiSqu8T1j1KiNosJnvHMTnCOGAdOQcvnZBT0T7a1z2fC95HdmKutCo5pi0igdcvIuphT5g8i3ijngRQDRl1mTAofLYGo8r9I8Z/tI1PJ6ir5Ch2HMTxovnHbBht2RmPERhEit9sgsjdYrQRB5HBMHb29CQ+vz2B+9MhtLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N3vehyyd; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3f99ac9acc4so1780862f8f.3
        for <bpf@vger.kernel.org>; Mon, 22 Sep 2025 19:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758595112; x=1759199912; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hUprFu/u7L5xCQa1mxBumnhbg1ay9gKf9ZXcVbRWqFY=;
        b=N3vehyydSnWkWgdoVFt5sqwfx9UDhvMvLjJXSvHD/YF3OMQmfAmh1DJsR4hc9My9y0
         w8vjqiq0zWz6Q1A29bUy0V2vjuytWNyvw2txJgWiTWS+BwbswL9t061wMdLC3i42cKBj
         gJewSTWtDRiV5IxRXtct6bgu+Ydt3bENfGW/aZz+wcGWaS++C/vgg+Va3Wg72vkxgSer
         +If6GUUQrRlpcx3Qk29KmwuhuTkKrwMoTd8oZXCbl1f9MSDaF8Lt3/u2NZ6/9S7566aH
         uw0ApRWj3Os9KMHWWH77RTHbHl6TR1A3ZnfpmJVUAeQIYQkC5ijm/wPbPqEdEIQPzIF4
         683g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758595112; x=1759199912;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hUprFu/u7L5xCQa1mxBumnhbg1ay9gKf9ZXcVbRWqFY=;
        b=oNnlsZoNgU0+vHRIU5iWMW8akOew1u9oFUW9j4jtXPx9bGiO5PKLJYh6URvP3GfcVj
         5Olwx7N6TWk8EIk6RCBVm+QfeVnSwFb4Pqkf2mCgNMvxXT9loecDfdmoiI1Liy8duS++
         2u7sj+BMq6CD9UlIsc2SVoVpPAH6sy7dDnUhMunDxPO6V5YI6kRRq1z2KgM3iwT7B8L+
         bNyDvbeqtcf+5R12VUzGNQoQF9jpZjVOFxSCLLxgcLv4oaIxORF3X160JoyW1UiSsjy7
         zGk+h7f6XhJpm28nZq8DCXr3fxNs9R1T7ZueMjOrLtOqVImnE7rQuCPaC7QNkKER4bBX
         ZNXw==
X-Gm-Message-State: AOJu0YwxUzhNJRG9zVNsDXwiUnY3nEh6Ha4TfloVXGJaqc8io/4E0h3Y
	7nn1YBp4Sr3v0OI2EGyXooKmWNCP9v37cUpwWRr7KGfRcQj328fObQmGlSHWynWOr7Ks1Irij+8
	OLhGbUJ4MFGur9ZJ8ZhqF6P4Edl5wnew=
X-Gm-Gg: ASbGnct8Ogl0jfcc6wJy9/9zjPMfs2CpsrdSXBbGjm/DSaRZP1FIVA8hlCy60nKFsLy
	ISr16oZMEj0V+EvIUCcR/Aym7/6hMKcZDJI5WqcBaR4FBbmB9Iqff8Jv+1FZf8k2KNdtH/AVW7X
	ATlMa7/U5S70Tzh83rQK9p4a/mETMHk4QmjtcvtdioXI4crhJp0m+LbrSaNb2HzQFiNuO87S8f8
	gbH53A3lsw4VN9hk+gTUogI/CKsJTcYMwjzu71YHKYs6S69Wk8=
X-Google-Smtp-Source: AGHT+IFA5D+IE/Zix20//1w2VYmCNsIOLBEPHYG5eLd37CJQWgmyIJQnxDpXiugNw2is/SApfmWkiY8gv+3C9WvYewc=
X-Received: by 2002:a05:6000:26c8:b0:3e8:9e32:38f8 with SMTP id
 ffacd0b85a97d-405c57f88c4mr589186f8f.14.1758595111985; Mon, 22 Sep 2025
 19:38:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250922232611.614512-1-mykyta.yatsenko5@gmail.com> <20250922232611.614512-2-mykyta.yatsenko5@gmail.com>
In-Reply-To: <20250922232611.614512-2-mykyta.yatsenko5@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 22 Sep 2025 19:38:21 -0700
X-Gm-Features: AS18NWBkpftVI--DwchXlhnYnn8r0fjYkgOHOHGQiKWMdfHeJgyPLi6fwbnUGEY
Message-ID: <CAADnVQKzT94tC9zF+KcqGVCip5ZEFN_qmHC+M3ehKXuDHMJT6g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v7 1/9] bpf: refactor special field-type detection
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Martin Lau <kafai@meta.com>, 
	Kernel Team <kernel-team@meta.com>, Eduard <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 22, 2025 at 4:26=E2=80=AFPM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> +       const char *field_type_name;
> +       enum btf_field_type field_type;
> +       bool is_unique;
> +
> +       for (i =3D 0; i < ARRAY_SIZE(field_types); ++i) {
> +               field_type =3D field_types[i].type;
> +               field_type_name =3D field_types[i].name;
> +               is_unique =3D field_types[i].is_unique;

The variable is set, but not used.
There were few other "clang W=3D1" warnings flagged by CI.
Please fix and respin.

The stress test in patch 9 looks good.
Maybe reduce it to 1 sec ?

pw-bot: cr

