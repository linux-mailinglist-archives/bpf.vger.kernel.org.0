Return-Path: <bpf+bounces-62705-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3A16AFD7E3
	for <lists+bpf@lfdr.de>; Tue,  8 Jul 2025 22:08:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76BB31C20624
	for <lists+bpf@lfdr.de>; Tue,  8 Jul 2025 20:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76019239E9F;
	Tue,  8 Jul 2025 20:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nIyMLVD9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F97821ABDB
	for <bpf@vger.kernel.org>; Tue,  8 Jul 2025 20:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752005290; cv=none; b=YoTqhIsdkW4AEiY/sTdb22enmg34H3kJDhmekAmQ3EfPpj0hlRf5VZsntZKbzbqth7Mqxc0660eXb+pAheSbmZeQvGvYubnjwDyb8gZh+Vf1X3CKQavodzLnLDDG2tVm4F766oKdvwce54rsanQXJ2HqhJNiYKiI7e4YIjQUk74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752005290; c=relaxed/simple;
	bh=cm9OiTeazBaywfDmpHKmPzc1zAxK3e+QDAzcUcuvwiY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u7ZBdWqJLB3IzfoEFJBskgDNxLaFxXS+474pHmDiibGnfihtJCKSkpjULQBBHyLAU47duxCRCU5FxDVakHWl2q4iSbFe+QWLZHqRUijWYIyyZK55ADZ2mVtViNGPgk0xk2MaDhpRYDMCcUPyBeL4lxtkc+ejRFHR6JxwXNRxdLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nIyMLVD9; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3a50956e5d3so3631542f8f.1
        for <bpf@vger.kernel.org>; Tue, 08 Jul 2025 13:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752005287; x=1752610087; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hgs2yMA23ZTDzqmbds1qgDhI/oByGhkl8pvvSA2GRS4=;
        b=nIyMLVD9Rh1hHSPwma8IG+EThNxvxBcFvcsTeX9MPsZazl6we9OKpWdopHijC84Gw1
         hFmPnVRZHpTz2nl2Br6vYfGhrQ49ZoM8FEc1114fzDdvBLBFgRkm0at8LVDx011GW0ti
         JBPoBQBHtJr8FMmtb5O7lJMGoC1tQrauMZADCACghx5pyzwZvbjq/075hFnXoBiHZe5O
         nWXxS5HQqnkPa8aXAqGJ5NFFaLXgI3dotrFhkIvXpaOZeEXxSjoI4MF7KDFoJ82bJw2d
         mOGOcIwsHiaoOseyHXRF/QD1mlOWnF5u6RyGViGoF9w+0sK+N223voyv5RNwdryH5K8t
         L5uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752005287; x=1752610087;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hgs2yMA23ZTDzqmbds1qgDhI/oByGhkl8pvvSA2GRS4=;
        b=jBvPoZS1qRO7GQQ0NyfKtmzsjAWcg2C80BceR+eSzllW56pEI+Wnhjsg/ysva2eZSy
         ivwqygXofOU82yYHbxs4E2Saco7hFLLzi/pVDhi6hvXs7JIvQeBmwCrjzs7ePd8//kBA
         BJvSqNCI+4HnBmUul1nT3d07urBXr3zo8rBbCNzqfWdyu2eEMATdrLrEFw3j2h9Kuq9t
         eTSPoqw0tTzItkGavEhVywAsjIWtvgf3A5Q7E2OLgVGhdKkKfE534VE7bRdqdp76cjQS
         7ltKG4v3FLQNkkh1p2bbUSY1XkILx/08QcXs+AL/9CWzxD4LcYFss4A24sTd1Tcg7RWK
         isuw==
X-Forwarded-Encrypted: i=1; AJvYcCWm82+g2Hsb5LZ1UTv7+ADgLwytgudpmNQzgeRn3BY5U53IXcr7ZaTkPi59iElbSFP6rOE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBo24hWKUMs7WFpdpOW2n87jNXtl0sRclhVc6eMKp+JEc4w1Cb
	XFq4CXD7DKgoZTo0+W4/buX8J1/ZrUIO3EYo6ZLg8nQwKXn87l9AFEk1AgeNUlukOkcNgZRjvaV
	cj7E4Bgdi0KpLk4FpYWNXjoVbOsJVdH0=
X-Gm-Gg: ASbGncuTru3Bpcl1lOMNi65dsVSaUjZv5al4t9KiliQTTXqZa/jZts5XQjp9KZZpMTS
	QeqUxWzQvhd4aNF3hH/+lBDrWi4BsSc/xvLq8UhXdQUs0Vt/1RXrtXk3xwkdTf9IRwZ9alS5wOt
	uwP2R9RbKn2HY7+Avon7E5D6AN6zGW2hMq/mIrxu7GtoyMy1y5VuLnh9GEvc8=
X-Google-Smtp-Source: AGHT+IHIRas3gE7EhNo0s/9Esm1lpPmaSKB6fOphrqB5GxQOHYIroDrYCsX7e8zPKQ7imOQSSleb0HFNi0rzDJL7P44=
X-Received: by 2002:a5d:588e:0:b0:3a5:243c:6042 with SMTP id
 ffacd0b85a97d-3b5e2fe338bmr790817f8f.2.1752005286437; Tue, 08 Jul 2025
 13:08:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250703121521.1874196-1-dongml2@chinatelecom.cn> <20250703121521.1874196-18-dongml2@chinatelecom.cn>
In-Reply-To: <20250703121521.1874196-18-dongml2@chinatelecom.cn>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 8 Jul 2025 13:07:52 -0700
X-Gm-Features: Ac12FXxfe41m7yWKgcNdmMSVF2ajzqUbvl2XkAp2iCoGYmdcL6cYsfjZCxmSHBI
Message-ID: <CAADnVQKxgrXZ3ATO4rdC9GcTtXvURpKR8XcGCdCa_qPh4RGFrQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 17/18] selftests/bpf: add basic testcases for tracing_multi
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Alan Maguire <alan.maguire@oracle.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, Andrii Nakryiko <andrii@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 3, 2025 at 5:18=E2=80=AFAM Menglong Dong <menglong8.dong@gmail.=
com> wrote:
>
> +               return true;
> +
> +       /* Following symbols have multi definition in kallsyms, take
> +        * "t_next" for example:
> +        *
> +        *     ffffffff813c10d0 t t_next
> +        *     ffffffff813d31b0 t t_next
> +        *     ffffffff813e06b0 t t_next
> +        *     ffffffff813eb360 t t_next
> +        *     ffffffff81613360 t t_next
> +        *
> +        * but only one of them have corresponding mrecord:
> +        *     ffffffff81613364 t_next
> +        *
> +        * The kernel search the target function address by the symbol
> +        * name "t_next" with kallsyms_lookup_name() during attaching
> +        * and the function "0xffffffff813c10d0" can be matched, which
> +        * doesn't have a corresponding mrecord. And this will make
> +        * the attach failing. Skip the functions like this.
> +        *
> +        * The list maybe not whole, so we still can fail......We need a
> +        * way to make the whole things right. Yes, we need fix it :/
> +        */
> +       if (!strcmp(name, "kill_pid_usb_asyncio"))
> +               return true;
> +       if (!strcmp(name, "t_next"))
> +               return true;
> +       if (!strcmp(name, "t_stop"))
> +               return true;

This looks like pahole bug. It shouldn't emit BTF for static
functions with the same name in different files.
I recall we discussed it in the past and I thought the fix had landed.

