Return-Path: <bpf+bounces-34110-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B241C92A81D
	for <lists+bpf@lfdr.de>; Mon,  8 Jul 2024 19:15:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 665131F21723
	for <lists+bpf@lfdr.de>; Mon,  8 Jul 2024 17:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88B0A1474AF;
	Mon,  8 Jul 2024 17:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V9ryKyiB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD111146D74
	for <bpf@vger.kernel.org>; Mon,  8 Jul 2024 17:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720458872; cv=none; b=uAFwlN4x7hWpr0IFz2QoH/pP6gtcirS7Ht6t68koX5lmu5HfXyrcgmXBDZiaHucdTmiLyYJWbHQrDJodnIalzx3Lwfu2GOIE8yvImwqLCMipVGpaTpObM68Hmirol252LgT6QmyIok2wOo5VNptbg7NIav7I/R2oQ6Mor5mcSbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720458872; c=relaxed/simple;
	bh=bimqJyz94CHd8S/xM1Tm+mXANWM73zAF3y6R/rDVu4w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vf9kJichSN6ylE+iRrP5UZURBFsxTHUy7UcGgBVWgwGdZfLyE8YqhUoy+JL+wC91V1Zq3vbJ95QTnGd6RInbjtgHq/yhQkh/g0ryINqMWgY0aeJBn6Pji2l5TGKyqB0GGD3uTobQkDMZSe1Mkkz6X4O8EexYfD5FYrxVI47wMAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V9ryKyiB; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2c9a8313984so2651977a91.2
        for <bpf@vger.kernel.org>; Mon, 08 Jul 2024 10:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720458870; x=1721063670; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bimqJyz94CHd8S/xM1Tm+mXANWM73zAF3y6R/rDVu4w=;
        b=V9ryKyiBPQX1HUMG+0zYbLwAHoFd7FNCCftlypkE0+2OnL0IPTsRYgkzBSH31j0p+O
         3ApeGXNe78fO7P7o0IDe4+W0Wnx04x3AIVQBcScUEGTutFclqEL48om5ESoZlxkqssA5
         XdjzMn3O6dIFutHCdnYcXyJxc2ALp+ZQNb3vN6SnsFMsd0cQyIfA3KKFLLsMr6D9gmw+
         iNAWgKkn9yWFAKT4yDGj+VL7w871N3XZ1q6gUcPCvTQWrQttKLvcqZDYx3Z0c/sigbvQ
         mI0qBUyZrZoSkk+EVBG138GElcdk/XQueKA/YSSnky1ZGwhde6W4F3APZtrZtYPE+DFe
         HvSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720458870; x=1721063670;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bimqJyz94CHd8S/xM1Tm+mXANWM73zAF3y6R/rDVu4w=;
        b=Eao8B9TfKCIl9ryhzAUWWrcVSctVO6MDFeKujcWD/hEyikO8wf9RL/k0IGRp3T7jOK
         EdGC9ciqwzpxi5BrXcx8s+a4jL+sp6df1J6akkFhbQ58nEE3gc4WfPxZGsz+lBsVNoVh
         cpBEKzAtQBuPaXb6xSzklLw9I4tAi0BdG/AQZV5TzPRlZe6NfiTq78CD3e97pea3LvPV
         0qEAPz6CfzwtlepfGYEeeeXZmAj5gl3ErrFgQoLJaR1a2YAHXeDXksLpaagcl9Rhi1GC
         pKPyEfClwu+HV6F8s4XfmMAcE7voYnE29ry48Fm7nRfPaSYrxEuxolVL7G4iuowIlvme
         NjEw==
X-Forwarded-Encrypted: i=1; AJvYcCWkOSzZBuDx9rcT+r0czdGEPnuqbXjfssHJrJ46Zh/VMtJzVYYsZXXlwebj0LWoEkm+ShAbrpvkZy6p9lS5+8gxvSDT
X-Gm-Message-State: AOJu0YwUV8sYWc29IiaTC9Km00D0G8azPTSc7oi5IR4isJmEMYTbUD5y
	vWeFiU+t57522zKeIe8QOvETM+DZVXaZJ18SWmUi1CSMoyJisGKMPdZhFj2MpPG5kzD6Jp7zIYH
	zsCujyk/DHz/UXvYqWPLNvl7tgAw=
X-Google-Smtp-Source: AGHT+IFUOZZhwzbBKvegslVxbL5KGRvIcNbDctieaYDJviC3Ml/4esS8jkqTZwcmY8y76Z3KKNcIm0j7LWjFw+BbDjg=
X-Received: by 2002:a17:90b:3785:b0:2c8:e43b:4015 with SMTP id
 98e67ed59e1d1-2ca35bde6abmr331812a91.6.1720458869865; Mon, 08 Jul 2024
 10:14:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240704001527.754710-1-andrii@kernel.org> <20240704001527.754710-2-andrii@kernel.org>
 <fcc66ffb-d565-4596-b166-9f91f8ca1d43@kernel.org>
In-Reply-To: <fcc66ffb-d565-4596-b166-9f91f8ca1d43@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 8 Jul 2024 10:14:17 -0700
Message-ID: <CAEf4BzbUFxcD6EfcP_zq+adCCXgwqCJb8vjdTmC95p+E-pvFYA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpftool: improve skeleton backwards compat
 with old buggy libbpfs
To: Quentin Monnet <qmo@kernel.org>
Cc: Mykyta Yatsenko <yatsenko@meta.com>, Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, 
	ast@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 4, 2024 at 12:21=E2=80=AFPM Quentin Monnet <qmo@kernel.org> wro=
te:
>
> On 04/07/2024 01:15, Andrii Nakryiko wrote:
> > Old versions of libbpf don't handle varying sizes of bpf_map_skeleton
> > struct correctly. As such, BPF skeleton generated by newest bpftool
> > might not be compatible with older libbpf (though only when libbpf is
> > used as a shared library), even though it, by design, should.
> >
> > Going forward libbpf will be fixed, plus we'll release bug fixed
> > versions of relevant old libbpfs, but meanwhile try to mitigate from
> > bpftool side by conservatively assuming older and smaller definition of
> > bpf_map_skeleton, if possible. Meaning, if there are no struct_ops maps=
.
> >
> > If there are struct_ops, then presumably user would like to have
> > auto-attaching logic and struct_ops map link placeholders, so use the
> > full bpf_map_skeleton definition in that case.
> >
> > Co-developed-by: Mykyta Yatsenko <yatsenko@meta.com>
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
>
> Note: I don't know to what extent we enforce this, but kernel docs state
> that "Since Co-developed-by: denotes authorship, every Co-developed-by:
> must be immediately followed by a Signed-off-by: of the associated
> co-author". Mykyta's sign-off is missing from both patches.
>

Oh, sorry about that. I don't do co-developed-by often, so didn't
realize. I'll add Mykyta's Signed-off-by in v2, thanks

> Other than that, the patch looks good, thanks for fixing bpftool!
>
> Acked-by: Quentin Monnet <qmo@kernel.org>

