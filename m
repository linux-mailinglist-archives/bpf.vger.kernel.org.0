Return-Path: <bpf+bounces-45434-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FA2E9D56C1
	for <lists+bpf@lfdr.de>; Fri, 22 Nov 2024 01:32:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D49B0283126
	for <lists+bpf@lfdr.de>; Fri, 22 Nov 2024 00:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC5043C30;
	Fri, 22 Nov 2024 00:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LCGX9ZAf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f66.google.com (mail-lf1-f66.google.com [209.85.167.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C950C1853
	for <bpf@vger.kernel.org>; Fri, 22 Nov 2024 00:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732235549; cv=none; b=JSqHlC/Ql3O5/+XT8OnHTfya/n6WmFwy6VGUULOV41eOIE9pGwtV2ZackPzI69qzSWokUiCoILdXEXhQ+zyBc9Cv/h+ogOPWI224WK74NYYy4QtUcpcRdyIoqjAvQgozNzoUi4x3D+ror6HVf+1WdEHMWWJJ7LBLEoW3MA9lk3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732235549; c=relaxed/simple;
	bh=695y1mMrXqLbicbM6KoYkBaTw+J7TbixKXYfkVjy1ZQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DpdYEwlUISm6npz4RZhxaMxq8pPSD8xzxWsm9oLxkFxa6jxSeesxb0N925n3RcS6fRcIdDslzwfo3KtGeIMC4huxD0d10tKjnxAGth6BUIQRAP0XIIFP242auuIcq+VzxDG+q6PjR6433Aj51EVa6uMqi1lIx95o7JbzJ/ZsNhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LCGX9ZAf; arc=none smtp.client-ip=209.85.167.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f66.google.com with SMTP id 2adb3069b0e04-539e63c8678so1718546e87.0
        for <bpf@vger.kernel.org>; Thu, 21 Nov 2024 16:32:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732235544; x=1732840344; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=695y1mMrXqLbicbM6KoYkBaTw+J7TbixKXYfkVjy1ZQ=;
        b=LCGX9ZAf8vI6PCphIDl0ctC40Tc7gEku8DYHf5ang18KO8PY02N1RQ2kBppJHvYPUW
         qaqczhlBs/VKesztr2bKNbDU0ertL75sqRaosSJSdFkGnkdiaUfGQO9cs1omsdK46Vvc
         UkAuH681Wl9iMuGDN+25A62EEtnS46gJw0W+AoOK+eSAjDKXMzIcb8CMyVGI4p/zL742
         ufWYRy+O/cxbwDpAjJ34plKkkTDgc61/wmg861+X+4N6QMNbUvy9t7CZXItcT8VYVEsX
         Vg+rBRZknENtcqFECO0ZHf29obJURlkkSoS5SkBn7d7yYMLqqOvgIFKXt+HI/V4zt+Xo
         I9wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732235544; x=1732840344;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=695y1mMrXqLbicbM6KoYkBaTw+J7TbixKXYfkVjy1ZQ=;
        b=jpyndZFKvCLtSPPz8EkwKU/q9dhY/Hl+zbIVVKpr98PD19/y/6z5Ex3RW3yvzLhp7U
         l+9ZmKYvHsGZJ5RtwKLla/fcTLecY8IxdQe/yUdfMr4tINpPCHkOvSCPHgx3AF8CHWoj
         NxVTdeK3h/EFG3VQQ6IDWeUy5vRQnHG4/zHWO7XGcmUFtWqbgIpbp4dcqVZbXjDmatWH
         gwHBec+dnhaQVBIpIEeDGSBB+VTBNL42Q9fAyxNqPThQdWul99Ob60jWakZYmja22cG+
         Ab0WRTANI8o4TZQrTZN5zGohXBgT5HWTTqp+FpyzFP6o9jT02Ox7+OPlBi/RAO5iN5uz
         BnGA==
X-Gm-Message-State: AOJu0YwM/e0Ny4PwXPa2zYlZZPKnQM6vUjxCR4hx6xSyKJ34drB9P8Q3
	iH1D28NEwccq+8VnIUBHX6mB7dqfZAcptU9Di35zGsQXFLkag4hpwVW7QjvQTQftYJYe/huf6G5
	wlV6j0DlOy1BatixUt39RyyLXBMU=
X-Gm-Gg: ASbGncuLJmG27BXiIvo1mpjUCX+0lMrqd93wqUdoVEe2/aIAFAL1IL2cmqXz5+JD9VC
	Nb/ON/G0W7CRu9AtaNqxJhiasWNsD9IuwMg==
X-Google-Smtp-Source: AGHT+IFipMHYzTg3VFmray4z/SuavTPPu7ip/v0Wqfb76ITuJNMC1Z8xHnphBvOA9ikn2N+Ct3P0CnJUkh122HFrkYk=
X-Received: by 2002:a05:6512:3e23:b0:535:82eb:21d1 with SMTP id
 2adb3069b0e04-53dd3baf730mr280674e87.57.1732235543613; Thu, 21 Nov 2024
 16:32:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241121005329.408873-1-memxor@gmail.com> <20241121005329.408873-2-memxor@gmail.com>
 <CAADnVQKr+5=3OnikYGjFU39Lcbox0HKFjaVeDGeF_UoULGh1gQ@mail.gmail.com>
In-Reply-To: <CAADnVQKr+5=3OnikYGjFU39Lcbox0HKFjaVeDGeF_UoULGh1gQ@mail.gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Fri, 22 Nov 2024 01:31:47 +0100
Message-ID: <CAP01T75A3RdK+LZjmKrJFjZhMNOCfGFt+mq1-acGG7TmJaH=yg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 1/7] bpf: Refactor and rename resource management
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, kkd@meta.com, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 22 Nov 2024 at 01:24, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Nov 20, 2024 at 4:53=E2=80=AFPM Kumar Kartikeya Dwivedi
> <memxor@gmail.com> wrote:
> >
> > With the commit f6b9a69a9e56 ("bpf: Refactor active lock management"),
> > we have begun using the acquired_refs array to also store active lock
> > metadata, as a way to consolidate and manage all kernel resources that
> > the program may acquire.
> >
> > This is beginning to cause some confusion and duplication in existing
> > code, where the terms references now both mean lock reference state and
> > the references for acquired kernel object pointers. To clarify and
> > improve the current state of affairs, as well as reduce code duplicatio=
n,
> > make the following changes:
> >
> > Rename bpf_reference_state to bpf_resource_state, and begin using
> > resource as the umbrella term. This terminology matches what we use in
> > check_resource_leak. Next, "reference" now only means RES_TYPE_PTR, and
> > the usage and meaning is updated accordingly.
>
>
> Sorry I don't like this renaming.
> reference state is already understood as a set of resources that
> were acquired.
> Whether it's an object allocated by bpf_obj_new or any other
> resource.
> I think this patch has a net negative effect.
> People familiar with the verifier already understand what
> refsafe() or acquired_refs are for.
> Calling them slightly different names adds confusion, not clarity.
>
> pw-bot: cr

Ok

