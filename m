Return-Path: <bpf+bounces-40584-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61D2D98A816
	for <lists+bpf@lfdr.de>; Mon, 30 Sep 2024 17:06:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E2A81F23D75
	for <lists+bpf@lfdr.de>; Mon, 30 Sep 2024 15:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7269190671;
	Mon, 30 Sep 2024 15:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hoYcBJff"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1FC818FDBD
	for <bpf@vger.kernel.org>; Mon, 30 Sep 2024 15:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727708752; cv=none; b=CZI7uzZcM9Cuorkt99poogHJdpIWj+Si8lE6oBMjKST+Q7pOzTro1jvkpEci9zs480ZaqZZ7GK1o90DwvE+ThEEMFkzm/da0EW2/Aa/JrGI+XaZtWEosHRsBWBm94cMhnU/qxVlWJHwMey0v4ICFBziurOaowbP9HuuobixO2hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727708752; c=relaxed/simple;
	bh=q1EylvTXCOSu3WUgeBvEVrnh2dL1oWDc7sixJb+KcCM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZhRJLY6yfOsjFCo6lu0dNKUefMYyIY0LEbBr2ZJTWupx2vlFq3mfii0bKsBoLfWLInUXtMDPAVBcdjXzuaCl2tSv55KnriEoCROUTjqTZZ1aCQ3GYM3OgUWWvAEwtHNRdqiNXtMcchvrfWXi5MedvYI+JICfZS9Cs8ZdNnR6VLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hoYcBJff; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42cc8782869so41494295e9.2
        for <bpf@vger.kernel.org>; Mon, 30 Sep 2024 08:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727708749; x=1728313549; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/+Sj32ztOlwR5YP5m8KSicIJCrfbaXXGmoGnvtrkvCM=;
        b=hoYcBJffXpYiK8M9vAdHFfIREf2XxUtoX4OBdhQOPvb+VgzukCovSlh9bhwsHX09Ox
         hP/AIyZS+W1NMoiv5sbRN0d77VSNgY4nZfuuVPW1hkt8GNW6dzjeBDCEJp/mULRoOCqV
         YSr0AfQiHVBz7TxT/TWJ2A2H8lBH9LT2rSavy4ACTXBCbr17O0iryB6W4OknBipZyp0C
         ot9NUDE7sP7C1dpaRLaYnMZ3Skh2GSjsumtZU3isoh7/szwP/ol5d6GU7crzxT62FhSI
         qRghrKOgnKHPnTnOWDV2wZxX5s9cjStF0Luf2YziC+FrZtMjtoOanC2p0FkEntj/klDC
         OeRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727708749; x=1728313549;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/+Sj32ztOlwR5YP5m8KSicIJCrfbaXXGmoGnvtrkvCM=;
        b=e/OFXphhI3wvvC5y5VZprGYRMvwc6MJaHwjCleaxA4ZNhAcGMK/rDJJU2pPQ2ZkVFU
         BGhQkJthGDZ+4oNOTdoOIkDqJc35bUid7CbjcaSKYQ/zKT5QuIAF0BMIOBPVC5MAcuo8
         Go+vVZgx/AyDTx2xM7aMXfN05BjXZ9tWABu7aMk+8IHT8gc8Er/GlgZxJvBViEX7SvHD
         JHRRyWStpOHe/xe/p6dZHRzYWCseHMWbecLpeG+z/+qOHZLLQ1FliHGSInzqiEzl/7oe
         KeWkYCgbEHRxQziJvjvEEtoF4CntuY38vVKUJUh3JZoGGkzBKDpJHipfYp1mcDrP6IEH
         GFyw==
X-Forwarded-Encrypted: i=1; AJvYcCUj3vkyq2xi8ie0kLbOIoeqgeBmcCLKO3Zw+WbaqeVxtMbNYeaBMa7wRJ0G62B8DFNuuV0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPEGkvzw1vtL7SxLehDspkRX4o9QAzrleOgUBMpj5KEan7t9W2
	XtdgJIIdZyOmJarh/b4siTBJcSaxFBRoZeLQN7nxG1Vb+3mcPOhYICV+P5NwS67RG8vUtz4Ickc
	cDT5wQyLdcs502DPkn3fdlslhgmk=
X-Google-Smtp-Source: AGHT+IG1yM2MxxEMgVe7UHeUTwFuJm75x16UDte1/FpmVZroicE8zgbYPRY70m0x0T5+FsmqICnq8wGhRCl36S4J0zM=
X-Received: by 2002:a05:600c:5125:b0:42c:b22e:fc2e with SMTP id
 5b1f17b1804b1-42f5844b601mr97331625e9.15.1727708749187; Mon, 30 Sep 2024
 08:05:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240926234506.1769256-1-yonghong.song@linux.dev>
 <20240926234531.1771024-1-yonghong.song@linux.dev> <ZvqqOTrK_0aLRolW@krava>
In-Reply-To: <ZvqqOTrK_0aLRolW@krava>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 30 Sep 2024 08:05:38 -0700
Message-ID: <CAADnVQ+XCqenWJF+d52gtV1ZZgO=80p9jEb43OWgv1QdEUpkrw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 5/5] selftests/bpf: Add private stack tests
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Kernel Team <kernel-team@fb.com>, 
	Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 30, 2024 at 6:40=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Thu, Sep 26, 2024 at 04:45:31PM -0700, Yonghong Song wrote:
> > Some private stack tests are added including:
> >   - prog with stack size greater than BPF_PSTACK_MIN_SUBTREE_SIZE.
> >   - prog with stack size less than BPF_PSTACK_MIN_SUBTREE_SIZE.
> >   - prog with one subprog having MAX_BPF_STACK stack size and another
> >     subprog having non-zero stack size.
> >   - prog with callback function.
> >   - prog with exception in main prog or subprog.
> >
> > Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>
> hi,
> might be some fail on my side, but I had to include bpf_experimental.h to
> compile this.. ci seems ok
>
>   CLNG-BPF [test_progs-cpuv4] verifier_private_stack.bpf.o
> progs/verifier_private_stack.c:174:2: error: call to undeclared function =
'bpf_throw'; ISO C99 and later do not support implicit function declaration=
s [-Wimplicit-function-declaration]
>   174 |         bpf_throw(0);

Yeah. Let's add bpf_experimental.h for folks like Jiri
who didn't upgrade their pahole for a long time :)

bpf_throw will be in vmlinux.h ;)

