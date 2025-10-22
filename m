Return-Path: <bpf+bounces-71663-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 44FCDBF9C93
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 05:08:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 434854F1929
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 03:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAC902264CB;
	Wed, 22 Oct 2025 03:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="naOXyBe3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90690224AF2
	for <bpf@vger.kernel.org>; Wed, 22 Oct 2025 03:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761102498; cv=none; b=JtEhT71AP4LrzJfVk8QLWQUaEvTxH7n81//zU9d28QtogOHaatSF/V5ri/VY5vizVcTukwROwPUpSy+1vkh+MZOxpyIJznTZq3dRLcPnmKLJn+RCQQ8U0BLVsmxaB5C4xz0X57qJSbxvO3zrWmrRfj2ekHx1wSpzHqgu/uE7U8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761102498; c=relaxed/simple;
	bh=zPBJPWJG1RmSuUSiXXFf7Fti2uJ0uJ2ARX+chCP+tt0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DqNkM1L7PVB0EVEWO7XR2kI0PN2ZQdmcjajOEKIPobLAWLbFK6+hlWLQtOJ6fHqMSrFFbBgCeG6mqWNxcvvwDIytz+w9e3jOi/cG8cBUIpjLAQlLk3gHdKHqS7HTu6BRVJsB3CaiHkvZYi3w2UCDd3Wy8jjdQNj/sBURU2Z2Jfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=naOXyBe3; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-63bdfd73e6eso993421a12.0
        for <bpf@vger.kernel.org>; Tue, 21 Oct 2025 20:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761102495; x=1761707295; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=InWFJpQO8fTxO1bkzACACUHVLGVVqDW5A3rrLvGIiHo=;
        b=naOXyBe3+hvTKIo+vbFvLXlll+y+KoSnNIP9bGK+69ckGp168T341BGAXX+iL8Nwx4
         UB+/16hqXMr9Tk6KZcoZDP/3xLL/+hlGzV86xxL0tw/sgUg92vyg9w1kBduHJ9oS41VY
         WiE3aPl3KWkd3uWf7z1jPkQsX9n6oJ6dh90oOBmas0EEQLWnbjsGAzo79m8/411kq+Iz
         Zu2Oe4Q37i4Vl75V3vVCwWRcUZ4/1g56Lf+nmnJKOvK2X34bLwK1E1sY3pE1qyOTGJ4+
         c9RV87r2qa7vpfRKku8GYT9UhyoV7Ta031pz5+1q/8eRGLp1AhoQQbO6dEGizE1j0v6A
         hXVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761102495; x=1761707295;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=InWFJpQO8fTxO1bkzACACUHVLGVVqDW5A3rrLvGIiHo=;
        b=RStj5mJRIZp4pekRN8YEdak2ZIRwmKV7UjBi5/kolEYkQBP41XyZxlYCJdrQlFeTNi
         LWsMcJ6kbp08H7IuZ59yL0CpZsZBgQz0nyu3SuAAketXns5By/sKmvw3fALFvCVbcQu2
         tXUqKfee76IuaPnYWAel9IHeWoXVmBuTHSbqFU7ReluGMtlwai8dLhlXZYapoWuJyTAY
         9/ICUzrCEVlEnf7ywUHdAvWxYuvqV37dt4FN3FfQhr3dOkpsvjd+uTSXEZtAmlU4bJex
         hY9aRMztooMJdYZPFlM2EmxWB1tiCFNeXas/hpwykmfSwWs6vo3CXqEMwHOSatFWLlY/
         cFkA==
X-Forwarded-Encrypted: i=1; AJvYcCXuvsGshscssrUtu274/kPM5mWtwDrpmqc4QeinuOP8m2KR1KkqhIT5eJITiuQyXAhzchk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnNVwW2VxcQvAAlMW4olhEDntb127okK5luR2AXhtu5D4g/7Ps
	lm/itXNjPD9WYTIPj5LXNp286CWaUMmeDvcD4y2AQfo+Gv+BBaPU3I014pujfMP82NGrCAkafYR
	5oLZIOdgtnw6ZW/kP6nXIxR2yT3Y2TX0=
X-Gm-Gg: ASbGncvtzSlF3RIiy6P4SZ6ojAxxyCnw9ayA+syXkN8DabBld7byEB7oFUi58rNSObt
	5OiBatu3SNUuocV4CKwUBZ1AiOoerUXxBmvx9QBsYQ/Qj7/d4jwqKtFhzvrZqQ0hTyWq1oakdOw
	CWwJJ2YM7TuiftcocqROT7kCRJfIV6QL6DG0nZv1EA051cZZX3BSDC5H74OeGJrwgHH3Li+I4qj
	BCs5ixoQ1YADIC9AzKPGmdEQe5ZKULOUJw5kPNUINItwo+f++txlfpV3wjBw5TzCYIe9Kvk
X-Google-Smtp-Source: AGHT+IEX1rltKwLPyvW0/Qg9CwBU/OfKcOnqDgE5TVcbY0wTzB19biWLcNylgJME1yuSwaOCqqEw3jC5+BWl5NnsTiE=
X-Received: by 2002:a05:6402:210b:b0:63c:5892:3c3a with SMTP id
 4fb4d7f45d1cf-63e173c0c0bmr1896817a12.13.1761102494810; Tue, 21 Oct 2025
 20:08:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251020093941.548058-1-dolinux.peng@gmail.com>
 <20251020093941.548058-2-dolinux.peng@gmail.com> <76e2860403e1bed66f76688132ffe71316f28445.camel@gmail.com>
 <CAErzpmvLR8tc0bfYg6mG82gqMSXHq_qXeMsssSDuzirxkSt-Rg@mail.gmail.com> <dacb24230861da2eb8fb5bd7168bdca571727b62.camel@gmail.com>
In-Reply-To: <dacb24230861da2eb8fb5bd7168bdca571727b62.camel@gmail.com>
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Wed, 22 Oct 2025 11:08:03 +0800
X-Gm-Features: AS18NWB2xp5k8jJQYnmoli_av-vve609ERXlhcmwqYUxVIE0Xnuffu4DyjzlWZQ
Message-ID: <CAErzpmtV4AS4=TvgXM5R0bW-7kv8W014D=mcCFANQ-o3PFnZtg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/5] btf: search local BTF before base BTF
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: ast@kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	Andrii Nakryiko <andrii.nakryiko@gmail.com>, Alan Maguire <alan.maguire@oracle.com>, 
	Song Liu <song@kernel.org>, pengdonglin <pengdonglin@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 21, 2025 at 11:56=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
>
> On Tue, 2025-10-21 at 16:31 +0800, Donglin Peng wrote:
> > On Tue, Oct 21, 2025 at 9:06=E2=80=AFAM Eduard Zingerman <eddyz87@gmail=
.com> wrote:
> > >
> > > On Mon, 2025-10-20 at 17:39 +0800, Donglin Peng wrote:
> > > > Change btf_find_by_name_kind() to search the local BTF first,
> > > > then fall back to the base BTF. This can skip traversing the large
> > > > vmlinux BTF when the target type resides in a kernel module's BTF,
> > > > thereby significantly improving lookup performance.
> > > >
> > > > In a test searching for the btf_type of function ext2_new_inode
> > > > located in the ext2 kernel module:
> > > >
> > > > Before: 408631 ns
> > > > After:     499 ns
> > > >
> > > > Performance improvement: ~819x faster
> > >
> > > [...]
> > >
> > > > ---
> > >
> > > The flip makes sense, but are we sure that there are no implicit
> > > expectations to return base type in case of a name conflict?
> > >
> > > E.g. kernel/bpf/btf.c:btf_parse_struct_metas() takes a pointer to
> > > `btf` instance and looks for types in alloc_obj_fields array by name
> > > (e.g. "bpf_spin_lock"). This will get confused if module declares a
> > > type with the same name. Probably not a problem in this particular
> > > case, but did you inspect other uses?
> >
> > Thank you for pointing this out. I haven't checked other use cases yet,
> > and you're right that this could indeed become a real issue if there ar=
e
> > name conflicts between local and base types. It seems difficult to
> > prevent this behavior entirely. Do you have any suggestions on how we
> > should handle such potential conflicts?
>
> What are the results of the above benchmark after sorting?
> If things are fast enough we might not need to do this change.
> Otherwise, each call to btf_find_by_name_kind() should be
> inspected. If necessary new APIs can be added to search only in
> vmlinux, or only in program, or only in module BTF.

Thanks for the suggestion. I'll run some benchmarks and share my findings.

