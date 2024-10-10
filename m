Return-Path: <bpf+bounces-41525-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93594997A57
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 04:03:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54D632841F2
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 02:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B58939FD0;
	Thu, 10 Oct 2024 02:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hq8YDiNW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF3B38DD8
	for <bpf@vger.kernel.org>; Thu, 10 Oct 2024 02:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728525826; cv=none; b=nJNdVjznhIN2lTGXnBCb36gFrCr3yq9q4XZAGFudk+6NNNzXS67Der8IQ4IVJDPETdGU1n93Y5Y9tQjOtoJC5Fa/Zem64KvG6eMUL+NN7maIqEu5OSRu+k+rqyB0GZi7anSws6QHAvSuL8NaIh2fFIofCJcWqVouyYWcSvg8kwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728525826; c=relaxed/simple;
	bh=j41bGSuh1igdcfCyT3CfqQehTiRGSxZuw+cDNoz02kw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=axUByY9ZjKocBPSdc4ezjrKs/wSeHrq6y+n4SvEPpp7H+0R3deXuiHbnEvkfa21IvZ/YxLCVKW4wFtSOLfEjAW+DxH4HrkwASyNWzEPXeGZe5CfzUoo6EbyzUtcvW063gDNmdl8cDT/jL2zSFUuNi5nw12oSQA4et65wFhIFIuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hq8YDiNW; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-37ccfbbd467so236988f8f.0
        for <bpf@vger.kernel.org>; Wed, 09 Oct 2024 19:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728525823; x=1729130623; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j41bGSuh1igdcfCyT3CfqQehTiRGSxZuw+cDNoz02kw=;
        b=hq8YDiNWxtLBUqBS1OD/JOlbHj4JiA47nAH3d62ljRALejEiKOtQWyYfgwZn2oUeW2
         JLueCZ86DmTdcYpAR6sNaOfNZ/pVf7r77gQryo3XhO7uk/rQwIlGqWKmDI2+kF94JLII
         7g5MSatHmIgWhMwjNUqaHbodZ7F7ZQzJaq2lXyBhyWYLBFlYY1UgGSEBQQ0ogpxdlITy
         OU+iucDeyTu2joEob9b/5rCgTaGlLlD32m9JdX07Kb/5PBPZQcVTbtNBy4hTPTToPVV6
         vHlX/zLUTytJ08xSj80TJ3A54DD6WOo8QzdQdIxJwjlHuraAZZ6RBhsH9mRhICNrcCNg
         EYiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728525823; x=1729130623;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j41bGSuh1igdcfCyT3CfqQehTiRGSxZuw+cDNoz02kw=;
        b=lHFbLWRtUaTLjhpCes/tc5WZKxzvS9l8XFaf4xYBEl0CNhqfOzdLFQyKwaSnE+Rsn/
         wpaWMJ9KZjwLcM6dkkZXh/PxugPiT/hqTdNf0Ehxtr5l5uagmZsOE7akcvS7drLRLXkX
         h20wZGtpS/4POSvzcGhoBvIGZHnzx/SmILGiAc5MK8fH+eOtwQBHbwCLtBXlRC/5vtEV
         xHeJpbDLJ9fR+zmeqD/25w8sSjKiSkc2usuAv4yAC+Ql2w3fM/xlQc2N2RDJlaYsRBb7
         61FPCi62i9uHV6hQt53E0SxTT6FEvw5LyJuBFBCjfw+J08w5ezbq6lX1s25KbjaD2Ntw
         6b9Q==
X-Forwarded-Encrypted: i=1; AJvYcCXcXwpX+ZyLVqzju9aTYanXFtKFVHBvZTGj9oruOWvtI6UC9nqf/PXLOPTwYcEsKlbkAak=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4gUfDDfBPGHJRc0HEKLkaYqZfGy1sr9zZvwqiBVklzYJoHTRR
	E0ClRro6McCUhgwKGSAnv/FgVci30iP3m8iXAxEtSnwyNULLWoKJ8Pa/IqQvpU9al0Ta4t3D2M8
	2/2k+/bhhOE65WopM7m85A8BQi5k=
X-Google-Smtp-Source: AGHT+IGXzuK1O3YnX9FUpb+Zy/f/FcQw+sbDsnGVohyYKIJkS9CRXAEN6zn6bcoa7Iqkbs04z/7nEy1n6Y+O7uxbfp4=
X-Received: by 2002:a5d:4c49:0:b0:37d:4821:fa0 with SMTP id
 ffacd0b85a97d-37d482110f9mr961052f8f.48.1728525823378; Wed, 09 Oct 2024
 19:03:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1727329823.git.vmalik@redhat.com> <bc06e1f4bef09ba3d431d7a7236303746a7adb57.1727329823.git.vmalik@redhat.com>
 <CAEf4Bzas4ZxiyJp7h7N5OGmPSMRfZDgPUgEAdTmir3n-4cx-xg@mail.gmail.com>
 <adaa47618f2b71c2803195749cedd4a5b468cffa.camel@gmail.com>
 <CAADnVQLCk+VNpN8WfCbSbT-FBcHBuMXpk-hBOLB7HX3BrURp8w@mail.gmail.com>
 <CAEf4BzZSFuXyUbwN8_VvbR6Uk_qHAKWNLkCZfdo-58WC_RYYag@mail.gmail.com>
 <CAADnVQLsnhsL2i_RnOBUSebO--yx_5Az1Ydr9QPb5WZCkmYQJg@mail.gmail.com>
 <CAEf4BzYt42A73kmg5=HWRiHj0H1Dr0WPQosmQLkBhgkkiw0HQA@mail.gmail.com>
 <c831b42e-30ba-4a19-bc0d-5346c8388892@redhat.com> <CAADnVQLhr+xOF58ppaySOjb6cMdsWEYhr_4ZLvQ-XDWXHBMgBA@mail.gmail.com>
 <e4bfbee4-ca5f-4496-98ed-60d24e402046@redhat.com> <CAADnVQKmEOLp+7p+YV0gS1z8ed+cLHK+BjMgt+rvhdUdJxPRGg@mail.gmail.com>
 <ce2f1357-7e89-4caa-8027-559b0d7ebf43@redhat.com>
In-Reply-To: <ce2f1357-7e89-4caa-8027-559b0d7ebf43@redhat.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 9 Oct 2024 19:03:31 -0700
Message-ID: <CAADnVQKJr_Gmf1SjTpmVLSWaPi=0irza365_Jb2-3kOKhKULdg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Add kfuncs for read-only string operations
To: Viktor Malik <vmalik@redhat.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Eduard Zingerman <eddyz87@gmail.com>, 
	bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 3, 2024 at 12:37=E2=80=AFPM Viktor Malik <vmalik@redhat.com> wr=
ote:
>
> Anyways, it seems to me that both the bounded and the unbounded versions
> have their place. Would it be ok with you to open-code just the
> unbounded ones and call in-kernel implementations for the bounded ones?

Right. Open coding unbounded ones is not a lot of code.
We can copy paste from arch/x86/boot/string.c and replace
pointer deref with __get_kernel_nofault().
No need to be fancy.

The bounded ones should call into in-kernel bits that are
optimized in asm.

Documenting the difference in performance between bounded vs unbounded
should be part of the patch.

> Also, just out of curiosity, what are the ways to create/obtain strings
> of unbounded length in BPF programs? Arguments of BTF-enabled program
> types (like fentry)? Any other examples? Because IIUC, when you read
> strings from kernel/userspace memory using bpf_probe_read_str, you
> always need to specify the size.

The main use case is argv/env processing in bpf-lsm programs.
These strings are nul terminated and can be very large.
Attackers use multi megabyte env vars to hide things.

Folks push them into ringbuf and strstr() in user space as a workaround.
Unbounded bpf_strstr() kfunc would be handy.

