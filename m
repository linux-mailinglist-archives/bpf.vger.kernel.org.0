Return-Path: <bpf+bounces-22192-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D996B85887A
	for <lists+bpf@lfdr.de>; Fri, 16 Feb 2024 23:29:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7716228C59D
	for <lists+bpf@lfdr.de>; Fri, 16 Feb 2024 22:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E93A148307;
	Fri, 16 Feb 2024 22:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TfBMLXHO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f66.google.com (mail-ej1-f66.google.com [209.85.218.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584801482FE
	for <bpf@vger.kernel.org>; Fri, 16 Feb 2024 22:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708122537; cv=none; b=hCCZrpGhvnqTTEZO1NI1jrBhoXVpo7QUJYRXlnPyaVwJCUaIRKrmSFR1Ccu3gzvV9ASmA8uNs6geoG80+JoICXlSx0iovg+OxeyK8Pw791Ohs5rRo2J5r+PFltSVx+fUB8gsZQ2XW5kSeyFi4CxBdgsKb4mPuhrsdQKKr1V0DZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708122537; c=relaxed/simple;
	bh=YWP57nqHC4MrXxQEW6MJuxjAAgvw3azE4om/24rGkRk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YcowodU3QThObgVnarq7ffglKdQwSP3D7syO4ibnCbN70lkTwGvlKnpkZV5b+Yj/JKng8LxsGFCnC1jzNfjQxGlkn4RHpIJ7rs2Jz/2mEGXQqgTwMIYsxic6Rz23j1hwd+6wbxvrL/cqsz4K8LkJ/4YwE334SSXmehb0mLoaHMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TfBMLXHO; arc=none smtp.client-ip=209.85.218.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f66.google.com with SMTP id a640c23a62f3a-a3ddc13bbb3so212054266b.0
        for <bpf@vger.kernel.org>; Fri, 16 Feb 2024 14:28:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708122534; x=1708727334; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jsdZcvlRbs+huUGV/ERMjl2LCxDC0d/ecevYj4eNE7Y=;
        b=TfBMLXHOLih28qrZiJyK/aWYDGmG4WKvhMPxi+UoWsNCjiWDxqFW0kg1ZPZgrpoOzB
         +3Gr+lg324uGg5S4Tc+o40RAQsVcL1WFvXT0rnzVKKwvWWQlHE2g1S5Jr5gBQT7gmcXv
         /pUdPA63Nx1YuYuJ9OpR5BC0hHJTtcKzwhhAdL3Ds780ZRAFVnklZe4YTp6cFCFnSb5q
         icYGRSCbRvJuhDiX1XGBjTQeVYl5j69oHYt45BowD/HLjSeju8SirdNNxA+ztOS0nsQT
         oodaGujpQZ9nLzjkGB3AIaM5R2iw8AJUgtJlnYjNBpbBE9mEY7DpLXIRrK1i8TcFDUGU
         3iBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708122534; x=1708727334;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jsdZcvlRbs+huUGV/ERMjl2LCxDC0d/ecevYj4eNE7Y=;
        b=EAZFMPEfhm9VTiAg4g4lZC9cVOJhL/gjoIH0tyJ6VuGMylHnByed/deALi3V/MLRz8
         tjRvjE0rYhyd2Pf9DZol9LnURbh8BUMz41T9zeBIO8cEfs7uurt6NQoJk6jGaBM/7F14
         MdEfMK8jq7gxh6q6c/jX5zRUn8AuDqzsthvtlRXxqGOrz6GkPf5uKw5PuQpML7DH6gV3
         E7N2wAFl3XOkeRbKmzEAHMJv+oTfJ1celUuqmqWtjfzFFmesfJXvrkswAyTVu9e2LySD
         MX5GqAyK5Hx4vlYPUBUCXjFvNNa9Ivjf8Z7fS/vzE2fX6M1GldEp7qE8q1Ezzr3LD/Se
         V14g==
X-Gm-Message-State: AOJu0YxfX45TXeLX2fs0qcriZgDZU8A7yyU+XHRNVbNXRXFBWbQ7UO5t
	Rf8QRr5gW2qIfk5DLv+ONcIG2C9fWGIK5jV5/9qJyZV/5GqdyuWXLjpLYh9TaFdSBQUT23MC3N6
	peqOt2Ilf7yhq3GVJYLr98e/q64A=
X-Google-Smtp-Source: AGHT+IGdubluBR+o/0mjqNaF6wDQ0dSDuTX7ZilN/gt0iPj5EN8BGktwRtOiTduUptaBrHShmaMCU0E4oFB3SZa+Nes=
X-Received: by 2002:a17:906:a3cb:b0:a3d:bc49:96f2 with SMTP id
 ca11-20020a170906a3cb00b00a3dbc4996f2mr3518898ejb.12.1708122534376; Fri, 16
 Feb 2024 14:28:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240201042109.1150490-1-memxor@gmail.com> <20240201042109.1150490-11-memxor@gmail.com>
 <4c3b58902d28550551c61a2a001d3ec54beac65d.camel@gmail.com>
In-Reply-To: <4c3b58902d28550551c61a2a001d3ec54beac65d.camel@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Fri, 16 Feb 2024 23:28:18 +0100
Message-ID: <CAP01T76w4vUpsMrvfk1UfDp4yA6ND-Jbw0UZYXLynF8351OJaQ@mail.gmail.com>
Subject: Re: [RFC PATCH v1 10/14] bpf, x86: Implement runtime resource cleanup
 for exceptions
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, David Vernet <void@manifault.com>, Tejun Heo <tj@kernel.org>, 
	Raj Sahu <rjsu26@vt.edu>, Dan Williams <djwillia@vt.edu>, Rishabh Iyer <rishabh.iyer@epfl.ch>, 
	Sanidhya Kashyap <sanidhya.kashyap@epfl.ch>
Content-Type: text/plain; charset="UTF-8"

On Fri, 16 Feb 2024 at 13:02, Eduard Zingerman <eddyz87@gmail.com> wrote:
>
> On Thu, 2024-02-01 at 04:21 +0000, Kumar Kartikeya Dwivedi wrote:
>
> [...]
>
> > +int bpf_cleanup_resource_reg(struct bpf_frame_desc_reg_entry *fd, void *ptr)
> > +{
>
> Question:
> Maybe I missed something in frame descriptor construction process,
> but it appears like there is nothing guarding against double cleanup.
> E.g. consider a program like below:
>
>    r6 = ... PTR_TO_SOCKET ...
>    r7 = r6
>    *(u64 *)(r10 - 16) = r6
>    call bpf_throw()
>
> Would bpf_cleanup_resource_reg() be called for all r6, r7 and fp[-16],
> thus executing destructor for the same object multiple times?

Good observation. My idea was to rely on release_reference so that
duplicate resources get erased from verifier state in such a way that
we don't go over the same ref_obj_id twice. IIUC, we start from the
current frame, and since bpf_for_each_reg_in_vstate iterates over all
frames, every register/stack slot sharing the ref_obj_id is destroyed,
so we wouldn't encounter the same resource again, hence the frame
descriptor should at most have one entry per resource. We iterate over
the stack frame first since the location of registers holding
resources is relatively stable and increases chances of merging across
different paths.

>
> > +     u64 reg_value = ptr ? *(u64 *)ptr : 0;
> > +     struct btf_struct_meta *meta;
> > +     const struct btf_type *t;
> > +     u32 dtor_id;
> > +
> > +     switch (fd->type) {
> > +     case PTR_TO_SOCKET:
> > +     case PTR_TO_TCP_SOCK:
> > +     case PTR_TO_SOCK_COMMON:
> > +             if (reg_value)
> > +                     bpf_sk_release_dtor((void *)reg_value);
> > +             return 0;
>
> [...]

