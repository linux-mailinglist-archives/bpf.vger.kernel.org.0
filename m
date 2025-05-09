Return-Path: <bpf+bounces-57864-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00D26AB194B
	for <lists+bpf@lfdr.de>; Fri,  9 May 2025 17:51:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E8349E171A
	for <lists+bpf@lfdr.de>; Fri,  9 May 2025 15:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3D3F22E418;
	Fri,  9 May 2025 15:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JhZn9GQI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFED12309A7
	for <bpf@vger.kernel.org>; Fri,  9 May 2025 15:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746805856; cv=none; b=U/mnm3cGS902tU1wVMmyhLfXy88GYUwZccxvq/XOiyYkqIgsKZiRGIm0NIJiMbNGkv1MT+MGCNUef1EUm3VTG7asGiLlqyWc86jWaLgTl4275DiATUPzZSHwIsmrPlAn2oJXPMeakHCPzqVhYY2J7BVqHZ6aHoVuYWiXIQCwnJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746805856; c=relaxed/simple;
	bh=deYPxL251vOAjeeIBjjpnT48XLh/Wc0w2WkT7mzTLkE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H1K9gIXbPmTSSoe/4aFgdXx006Mi2uKnVj5vFFs8ZtnqNMLBB3JuHXkrW3CH1qbQFcIaLKUvvB4eByr2/IIOGq39+yZdQLh74YEsdf99F9kKLaZy7XfBrBwl+b7orQaLGXS4HuDj+ywvG4rkMPNdMROzWugExaWbVvEmeEVpZZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JhZn9GQI; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43cfecdd8b2so16055495e9.2
        for <bpf@vger.kernel.org>; Fri, 09 May 2025 08:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746805853; x=1747410653; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4E0Zns1UUdzBMgxkHMGqdqrvZJ5wS5++cnUGd9mbNHQ=;
        b=JhZn9GQINeh1XMpdjebjiTzC9pyxAp4AHxSkwNS+SxvhYg9nEosAVwe1MSS9Y9xDLJ
         3G9x6tvKleDxlkvrC6V5EWJyaNC1gDlwQPvRbx2z8wVwDIkOIHr7xyxdOlbGKBzg+7CJ
         LOjBCxPXG/qgNVxzo1YXJ3z/K9Mfj+AvddzncO49AxFHdNOEqVrYiTIK2TWEsS8/fes2
         lHJ3/86fUsDpYatmMMN3TApP7klxFC++w/zVn4DttcVlbbWF7upjC7EsNTWFrpQgFaLb
         dgu95KiUIGBdme/uaj8XONWwxgSca+8EJ6fMUQWMs1OAxhUAC/b1Fz9+XF+BDgR4xyxJ
         1uuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746805853; x=1747410653;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4E0Zns1UUdzBMgxkHMGqdqrvZJ5wS5++cnUGd9mbNHQ=;
        b=nM5LKiecU5SjirSvADGT+gngDDPoaF2ZPMPXaEtbZBK4Pq7SIjKqTyHhu1euTyoxCd
         4dyqMw/NjuETdCvRixPHmKO7L/IyJRPjDVMC7x7XjQNjhph0g18jG65LOdrzzu6ltESn
         o14YqHA2AFvC6d9y4msvNzAtjbb/0WHYGOW/r6IRX7YPfmEPSU9KRwBQuwbKvaGbJqct
         SO04dEDVOx8vEdWZbVZ9s+sS4KuxAzU5cf8RIWksyGsLzaVvPx276tpSzt2eZqgtYV/r
         QOm0Kzl0D2IeHV0/kf2MXHJuiWRtREJNSgGhUzJ922/EsRNqOtVreTKCe/B9dzDkS3AL
         vPIA==
X-Gm-Message-State: AOJu0Yxq3Js7u4ECfl/3J4cfdfyPsx4wqL5cXiZ1Yw/+6YmfKhzu9v6j
	06qoYuOdFUE8ZZ8QqT42dfU2AuZxcZgzD9QSZy4TpIcPKl1JXavaa87yRCkOZtLOqq7WdqYAjMa
	i3XXXHPYywkqbkuN3MV/esBL98i8=
X-Gm-Gg: ASbGncvCWQQ8bH1QevI0zW7ri2QXH4h1/Id8t0hNtRyIP3E5AKSTkWqs6qzKGLBQcVc
	AF8B3/HVCI7M40IyP91165OmJL0JOF2G9UvIu5lFv/TPxMEwg5GFnikigtdhwumnHwgMONWzN6J
	rhU2DlABEODpPFL8QLFum40lNMx5zmF5TxmV4eiPq8fQh80i6B
X-Google-Smtp-Source: AGHT+IFtVJWeCiPDlmoIIGnlQFyBsZlc4yWLEJNyPIwUp/+LvKUmohKjmBubAaXNejD4TMizydWDGluT2PQuR7Tw9uk=
X-Received: by 2002:a05:6000:2902:b0:3a1:1215:1d6e with SMTP id
 ffacd0b85a97d-3a1f64275camr3530934f8f.1.1746805852890; Fri, 09 May 2025
 08:50:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250508220624.255537-1-mykyta.yatsenko5@gmail.com> <20250508220624.255537-3-mykyta.yatsenko5@gmail.com>
In-Reply-To: <20250508220624.255537-3-mykyta.yatsenko5@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 9 May 2025 08:50:40 -0700
X-Gm-Features: AX0GCFsJy1XKU1lSCmkle0Vpo2LFVwwrKNpaerNqD5Kojb--S-h2At1QmCZJUAs
Message-ID: <CAADnVQK3oXfVtKR-SM07N3+-AtoU+Khcvu_HLv6QXkO6hthgvg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 2/3] bpf: implement dynptr copy kfuncs
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Martin Lau <kafai@meta.com>, 
	Kernel Team <kernel-team@meta.com>, Eduard <eddyz87@gmail.com>, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 8, 2025 at 3:06=E2=80=AFPM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> +static __always_inline int __bpf_dynptr_copy_str(struct bpf_dynptr *dptr=
, u32 doff, u32 size,
> +                                                const void __user *unsaf=
e_src,
> +                                                copy_fn_t str_copy_fn,
> +                                                struct task_struct *tsk)
> +{

...
> +__bpf_kfunc int bpf_copy_from_user_task_str_dynptr(struct bpf_dynptr *dp=
tr, u32 off,
> +                                                  u32 size, const void *=
unsafe_ptr__ign,
> +                                                  struct task_struct *ts=
k)
> +{
> +       return __bpf_dynptr_copy_str(dptr, off, size, unsafe_ptr__ign,
> +                                    copy_user_str_sleepable, tsk);
> +}

CI is not happy about implicit cast that changes address spaces:

../kernel/trace/bpf_trace.c:3702:55: warning: incorrect type in
argument 4 (different address spaces)
../kernel/trace/bpf_trace.c:3702:55:    expected void const [noderef]
__user *unsafe_src
../kernel/trace/bpf_trace.c:3702:55:    got void const *unsafe_ptr__ign

Please use gcc 14 or higher or sparse to see them.

Probably __bpf_dynptr_copy_str() shouldn't have __user qualifier,
but bpf_copy_from_user_task_str_dynptr() should have __user next to
unsafe_ptr__ign,
and everywhere we kfunc has __user it can case to (const void *) before
calling __bpf_dynptr_copy_str().

