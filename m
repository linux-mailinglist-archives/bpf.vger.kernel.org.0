Return-Path: <bpf+bounces-60887-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F8BDADE109
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 04:16:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFC1F3AE874
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 02:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4D2816A95B;
	Wed, 18 Jun 2025 02:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fYiztxkZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97188B67F
	for <bpf@vger.kernel.org>; Wed, 18 Jun 2025 02:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750213014; cv=none; b=eGp+HVK2KJzRGBErxGsenLX6lPrrPD5pAc++p8MGOrU7EcTgC9qtdlzk74Pij8ZvlmpBgbsEaZNTq/aBRjNuQRR8mC0a/e75dTolVCG5GW5/AXljNpdBxXlDZQWiBP6dUcZr1EyN1SO/NKujYAljT0JEAAXonCOqMSH/PcheXnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750213014; c=relaxed/simple;
	bh=zkkwPOzRmHn8m2YFwmCCR+YHjA+X06ro/NzNnJssUFg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dr8dArGvnzKFSac0oZQhpgD1+F63IA6U2iHNnidqVk0v/f/ZRxx7DYGJfQ0I/43KKqcag/9YMMbHY4cwRfhbDKAG3naNG0fNF4/Nn6UOIQWKIiPERecJhkARaUHr/iuZWxe66eSXmApu6q/9BvsE1IfwYF5DT0NJqwxyhm1KGNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fYiztxkZ; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-45310223677so51535915e9.0
        for <bpf@vger.kernel.org>; Tue, 17 Jun 2025 19:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750213011; x=1750817811; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+VoSUj36U2D7r/NUpHuJjPj5CpYdQqGydpkpnwOsYF8=;
        b=fYiztxkZ1ax9qfltf4tHqnXIDnYGvIJtl1YHRqlTSkL+lawmmbJunllhMMwPDl1HCK
         0Q0l3OyYV0aS7sFA4C9jk8uer3upmIWSrwAmGwQnUnBwpa2Mc+G+KtxZV52UZhcDs2Cx
         R3UzaiVveiwWlpRl/z+lObDOTWGxElw1uoF6F3gb+By3TboSAkxMPd0s5hGy5Mr0Vmdi
         edEoM4qmtwbl7tOJf6P3NPbT8Z1Uv0zxJIevLWZplg9CLu73KrSDSon9pvzK/1Sx4+QN
         oZ6y7qNMZiikbtW3m9EN0NFUZZfnD8hghfgpxjZmnJbe1CA9KUmgEr2inV7BguOogzH6
         JdKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750213011; x=1750817811;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+VoSUj36U2D7r/NUpHuJjPj5CpYdQqGydpkpnwOsYF8=;
        b=PToscszMT6uG9rpwdL2+ZMz/themXriQLUhyWhJz9pvgSJfaNY3jk6yDlf7mjw6l6/
         tGXRdARi9/vCdE9koEaGLpxvi5oP9W2af2gIzqK2TVmShG1UiCpS/SrfyvINlwlKXGfi
         YTl429SConIvKGK4Aq4gwVC/NJQjHhHACm+zRuxmUFjkx/0fuVtMZztMAJwMbyYQKmd2
         42rdf1UvkC/gVB4ZR+rddhMeGSFWTGQ8dD4CJMDhuop+H9wuh9I/rVnkRKFHbrur8+ej
         60qx9rdBBs+yqH2DJO81lVOGZQk1C/ETcOX4nPdOz4qArfCdCH9aGCwSdS2d4+pcTW+Q
         mXdQ==
X-Forwarded-Encrypted: i=1; AJvYcCWLp0OQJGU3gLNC2nYWX7p+jejCZNoXUTA7nBUxm3xvqFolww+gQwOcJpHtEMQmfUw44nI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtztcdsgVoDaltCjpW9jZJfzp8jzdKODXFzrI1C/htyQ+xxUSK
	YCUkSueznqZubPg1Xfa0U6mjGAXamzrAuYE7XLK/2dELlHoGWdgc2rUEP2mu6AT/g6aW3CSWTCR
	tDNAiAHTdK/x0lwkTrrWXMui2R55rebQ=
X-Gm-Gg: ASbGncthN3cN+yYhmno05RnUCi8swp+IZpX+xa+WCMEt2k7aJnazajvHkz97tx8sJPJ
	P+gw9aAIQJOnGGLtMomZREvyPO0QJFhs4iMf0RPE1F/X4hDMIkg7DvJ6i2zTQx3Ql5rfVeH2rPt
	uV66wrylpRyXWlQyidOLtnhdH6dzQAd6LtTlvT28mW7F5+yeTck+DCvf9NFFzJHK2gV/Y+lFWs
X-Google-Smtp-Source: AGHT+IGWKDIeCfV2suN2Av4xgLfk4LZtVorG7nqxdbbRk1GIQYsA4B7zi2gzOujKnPK5nuKK9iz9u0Yjxgeox2J70z0=
X-Received: by 2002:a05:600c:5494:b0:442:e0e0:250 with SMTP id
 5b1f17b1804b1-4533cb0c00bmr152947245e9.29.1750213010568; Tue, 17 Jun 2025
 19:16:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250615085943.3871208-1-a.s.protopopov@gmail.com>
 <20250615085943.3871208-3-a.s.protopopov@gmail.com> <7edb47e73baa46705119a23c6bf4af26517a640f.camel@gmail.com>
In-Reply-To: <7edb47e73baa46705119a23c6bf4af26517a640f.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 17 Jun 2025 19:16:39 -0700
X-Gm-Features: Ac12FXyn_IjflJiX_kF9-7HqCGwE3Lh8dySHYdGo1JypqrBWuJ_xCAEYMGb2cvk
Message-ID: <CAADnVQJyBBoYZE8M=GrghdPm3-ZjTEoiFDP5_Y00bPvKy_XEoQ@mail.gmail.com>
Subject: Re: [RFC bpf-next 2/9] bpf, x86: add new map type: instructions set
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Anton Protopopov <a.s.protopopov@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Anton Protopopov <aspsk@isovalent.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Quentin Monnet <qmo@kernel.org>, Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 17, 2025 at 5:57=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Sun, 2025-06-15 at 08:59 +0000, Anton Protopopov wrote:
>
> Meta: "instruction set" is a super confusing name, at-least for me the
>       first thought is about actual set of instructions supported by
>       some h/w. instruction_info? instruction_offset? just
>       "iset"/"ioffset"?

BPF_MAP_TYPE_INSN_ARRAY ?

and in the code use either insn_array or iarray

