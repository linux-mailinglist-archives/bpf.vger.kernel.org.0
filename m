Return-Path: <bpf+bounces-53215-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F29AA4E8EA
	for <lists+bpf@lfdr.de>; Tue,  4 Mar 2025 18:32:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA88C1884FF7
	for <lists+bpf@lfdr.de>; Tue,  4 Mar 2025 17:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C12CD27F4D9;
	Tue,  4 Mar 2025 17:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qtj/uO7b"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B75C824EA92
	for <bpf@vger.kernel.org>; Tue,  4 Mar 2025 17:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741107652; cv=none; b=WhmB3yosrsom7KyX7NFGDCV1oFvj+nFkgK52pgZsfMSHtCwmDQ2RABXWPSFbqUtE24cKRfrKU1ZZ9YrJs4rNeIn5shJBELYiNBzM5bQXRki+vGPKQhcqtolcQGB8qcB00kjp7EiXKje5txgyBtbWAPEgvdCl5h/qqbYemVye7PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741107652; c=relaxed/simple;
	bh=hZJm9tdi+k5geE1Yk2x1jJlApN6p8B9ZtliS6BekFjQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XCv754mKjUxwryFSRRsRodDAy+z/amSjdqwyTXFXvsHQc0Aks/pHWRawFUNB5rUIeCw1y9rOI0s1CrGFmlG/RQYGNIBy6SF1XIO3QNT06WAxd/huA6Ey80QYtoOzC+1oBJPDnvrQFSp27vS6NCUViZSC7FMaK1ibuis4CzU4IQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qtj/uO7b; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-439846bc7eeso37997055e9.3
        for <bpf@vger.kernel.org>; Tue, 04 Mar 2025 09:00:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741107649; x=1741712449; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uXWpgUQkWp9DyjfXzGhmtJdjWbgp8H21RkSK27CxnBw=;
        b=Qtj/uO7bdRxMboj/4fm+DwngN2IE83/8qnWGUl8iTtkeFYmN0jf39A1ZRTyhLB+xt7
         ovRYa7sv8Rq256hKPMGY0SZTOfdwr1BeTp/6RNE8Nt/IWBEWOAnnvhx/1s1gWh+bFPhw
         nChKC6ykvtwxoo/K3hezTB+nOEtnbRDEGH4kIEu8x8TuSiusFyXHPkYGlQ9AAo8tcPO0
         aVFSpEffhNUhuSOA4g3arEcyg7Y2b0hq3TEQw2j5/oCYn5pAa8Qdz6COYufwKyDXK7PF
         Lf5D544NIDX6L/G3mZB/3bGqRcEo2AVdTNMfpL2TWgx6Ds1SYtjuHnM4lgAgVV8ffa9g
         kw9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741107649; x=1741712449;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uXWpgUQkWp9DyjfXzGhmtJdjWbgp8H21RkSK27CxnBw=;
        b=AbmLEYXefZMRxSqYpBD5z/ykrNPpSupwiZpD5q2AYW4Re6Atp4gl9p0/63lp5tKdf4
         BfqRThdNNBSTcn6Tk8Hng/v+MbdLsWQKOdqvCGAqQoVzKXKnkHMwK4hPQnzL+Ge/u/oG
         oKWsIsgUXuhRMNDZdg6pbnt9nQqMem3txhd48J3n0AMfRNVqzRYekx/m50JEinQXF8EJ
         TpjmFH3PMMbUO4mdIzrYe3KjpMw3lspHxSX0u8yT0gN3x5+nDz3dEqclmd/SoxJzCTzD
         aDNLQL+nq5S9QMVsdTjXHjHGWoYWs8bhQ3+vkkcpXFzAky0d7b5AS7r2JsJ6rKCAcZWH
         gXKQ==
X-Gm-Message-State: AOJu0Yz6PS9AzqCvHc/bZtWC3m/bzRxTvr9zKnxm+d7duP7R7yo3dZnH
	etSHjC+cAeLYYueLSeztG1zpViiwwLstoPuD6voL606p9yRAD8QQeZbyt18+niIcA/R13DLCsMe
	t0bxkkqQ3Jfdrxa/Dd1LAv/1TPNvOPQ==
X-Gm-Gg: ASbGncv4u6GOMSe98Q+WinRqr7CTc6ddBaXyKLJLee4iMlAMxT2H9iEOnSUGdQYbGaz
	IqTjMSTWlxsUMuiUxxMr/8E62Ainsafj8xGRPsGl/vbUT2FX3pBshEgKumddLcey2XqeRxcdoDw
	4CoPSA5SdJHKVdotu22OT16RrELVMGhc+N++64qAW2Ww==
X-Google-Smtp-Source: AGHT+IEKXNXUfdU3yCxd3/O8zWLPwqSY2rY85MiYtoM34XpZp+bIzHGmR9DUiRFEwekP7YQSMAaZUhwjsY8Z/UlEzSI=
X-Received: by 2002:a05:600c:511e:b0:439:6017:6689 with SMTP id
 5b1f17b1804b1-43ba66e0bf5mr144314855e9.9.1741107648586; Tue, 04 Mar 2025
 09:00:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250304074239.2328752-1-eddyz87@gmail.com> <20250304074239.2328752-4-eddyz87@gmail.com>
In-Reply-To: <20250304074239.2328752-4-eddyz87@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 4 Mar 2025 09:00:36 -0800
X-Gm-Features: AQ5f1JpKTnjzNPW7gCJJVHz-vS_Gr5B1vTWOyieglGRlSuFCNGRNRpCQLIDh4ns
Message-ID: <CAADnVQ+gBOK_KODR0AD7tEVqjeCn9QTPjOjS=6A1bbbNr55nnA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 3/5] bpf: simple DFA-based live registers analysis
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Kernel Team <kernel-team@fb.com>, 
	Yonghong Song <yonghong.song@linux.dev>, Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 3, 2025 at 11:43=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> +       case BPF_STX:
> +               switch (mode) {
> +               case BPF_MEM:
> +                       def =3D 0;
> +                       use =3D dst | src;
> +                       break;
> +               case BPF_ATOMIC:
> +                       use =3D dst | src;
> +                       if (insn->imm & BPF_FETCH) {
> +                               if (insn->imm =3D=3D BPF_CMPXCHG)
> +                                       def =3D r0;
> +                               else
> +                                       def =3D src;
> +                       } else {
> +                               def =3D 0;
> +                       }
> +                       break;
> +               }

This would need a follow up to recognize newly introduced
load_acq/store_rel insns.

