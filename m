Return-Path: <bpf+bounces-44668-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E31E9C61C8
	for <lists+bpf@lfdr.de>; Tue, 12 Nov 2024 20:48:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD2321F233A9
	for <lists+bpf@lfdr.de>; Tue, 12 Nov 2024 19:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48362219485;
	Tue, 12 Nov 2024 19:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nOAJ+9By"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E5A217F27
	for <bpf@vger.kernel.org>; Tue, 12 Nov 2024 19:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731440877; cv=none; b=gH8ihdZuX+MAKaXHuz2Pb7XpfYqF6DDEzS4KDXIjDoR6A7bBkYKrnjzqPVwc6XhpbYob5bc+uMZA7ZgzxXsTHLLz/r7UKvhIVT2F4xjXlYFt5yqyUC02ntYS6HRD76u1NAkSpdgI59pcmGSeA0IqZB9GduzqVPqY7t5h/hQe+q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731440877; c=relaxed/simple;
	bh=rjYIZJfJarRlQMgw564Z/Og/cusMaQyXe3qnq3AtTew=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XYCd94ZZI3VtPBS0EmHtNVn3RnWmjXRfQrHRZH6gYIyfz/Ta4otJGS3hY9bUBQVK9OeNJhln/mrisGq3gurM5Lq9ruPPQ44NoboMEfNNAJaOXZP505dJVxPLHYTwGMktcY6cxAiifMRBaModdsiu4+LD/gcQa3T8Tgsaiy3HYeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nOAJ+9By; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4315df7b43fso53013685e9.0
        for <bpf@vger.kernel.org>; Tue, 12 Nov 2024 11:47:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731440874; x=1732045674; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rjYIZJfJarRlQMgw564Z/Og/cusMaQyXe3qnq3AtTew=;
        b=nOAJ+9By/Eg9rIP5lK6Ina87QpF8R51cOXdqKtX8y8r/shj8R0b1E3KsNVBIx19WAZ
         eq/e+AyKe8PgeenS45FdA03vos01JjMsqZ+Ku2CQVA60IKriVqCLk5tFCg2B80t/Qs4n
         BV+Op5dXX8uBOyAC2MEFPtS90CEoYlyzZjF+lXVHpceZIrIfdafk6H/t6s5PNwy8LsLy
         LnxgUv5M+BooP8Q5sgfLM7z75TpLu0c+tvNRwtMeotwnBH+ZHrGjKuC7qxoG9d5wsZ6f
         /7b6ZcugnSHMZR3pbjlgBiLdHKUlBNib8U8bcsvdpYaE03dm0ARH0RTYQ3PDpq7JLiJg
         BvZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731440874; x=1732045674;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rjYIZJfJarRlQMgw564Z/Og/cusMaQyXe3qnq3AtTew=;
        b=soJAFdRXc5ihD1e0rWEx3gtOSZHkQ0w52FP7FMFZSR1qYMPWuTFiK9Yya+CqJpXKVf
         zZ0hhk3jjG04HcGVz3QMZQRqeU1+ZwiApeCt6kdEsm2cwMaT+JeiA+d5PXQ9o7EUvYY7
         C/T8/mFbipnJhSiVlZaimYWrYqbHWtcxLgS/FwJfhrrAwTgEjadqHqvGy/Ur38QVImTL
         rNvq4iFx/V81nypc+y8qT+CKfbDbZRvsyIlYNNj0CtS15zZtLlsVDLckGLQTr74w27wo
         zjVUgDuleqXJTHETWN0KiMBmRlc1Qfir5Ry9FcBJJAAbwi1Nov3b87JrmVs7Eof6CDXn
         Oc9w==
X-Forwarded-Encrypted: i=1; AJvYcCVM9/ArLpQsnPVF4D4IMTqj6rupI7QfvzB4UWm3X5C1iWKZTK8EUfpZ4yHnGyPu/SgCHSE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2kmfTmRTAp4XQwfW+Ad6d8snx6u8oJEszqpYR9A+3dMDTzW7T
	P1qyFwFDnXQwzkUBlDR9Qiu1tB7EKJLzf7O40PWzYn6irtE0v/h12sdZ4lqty1qyJE6DpzC5UcB
	PexhpwXtZ0kAjVpOCdaermgX9gg0=
X-Google-Smtp-Source: AGHT+IFerk1lHBZdCU+2Flf0T+NR2IyXHI9C4Kd+xgkUz/d2hgnHT4gyUCYsx3vTF4+9zioLvnV8PY8qi2VTM+/jcB0=
X-Received: by 2002:a05:600c:3b10:b0:430:5356:ac92 with SMTP id
 5b1f17b1804b1-432b74fa9demr150553765e9.7.1731440874055; Tue, 12 Nov 2024
 11:47:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241110112905.64616-1-dev@der-flo.net> <a917cefe-28d5-ceeb-5cfa-4fbb8f9a3c9d@huaweicloud.com>
 <CAADnVQKKaNkmyCX5EwL+k0YZXFFrT4v+QtwDX6_7d7oJXjp=UQ@mail.gmail.com> <ZzOo3ZTefm8Pf6st@der-flo.net>
In-Reply-To: <ZzOo3ZTefm8Pf6st@der-flo.net>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 12 Nov 2024 11:47:42 -0800
Message-ID: <CAADnVQL7zSss7yVx=ZJ5ag3GZjw2dtEW_C=z2K1HuUJWQHs5Hw@mail.gmail.com>
Subject: Re: [bpf-next 0/2] bpf: Add flag for batch operation
To: Florian Lehner <dev@der-flo.net>
Cc: Hou Tao <houtao@huaweicloud.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eddy Z <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Anton Protopopov <aspsk@isovalent.com>, Kees Cook <kees@kernel.org>, 
	Abhishek Chauhan <quic_abchauha@quicinc.com>, Martin Kelly <martin.kelly@crowdstrike.com>, 
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, yikai.lin@vivo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 12, 2024 at 11:13=E2=80=AFAM <dev@der-flo.net> wrote:
>
> On Mon, Nov 11, 2024 at 07:01:26PM -0800, Alexei Starovoitov wrote:
> > On Mon, Nov 11, 2024 at 6:15=E2=80=AFAM Hou Tao <houtao@huaweicloud.com=
> wrote:
> > >
> > >
> > >
> > > On 11/10/2024 7:29 PM, Florian Lehner wrote:
> > > > Introduce a new flag for batch operations that allows the deletion =
process
> > > > to continue even if certain keys are missing. This simplifies map f=
lushing
> > > > by eliminating the requirement to maintain a separate list of keys =
and
> > > > makes sure maps can be flushed with a single batch delete operation=
.
> > >
> > > Is it expensive to close and recreate a new map instead ? If it is
> > > expensive, does it make more sense to add a new command to delete all
> > > elements in the map ? Because reusing the deletion logic will make ea=
ch
> > > deletion involve an unnecessary lookup operation.
> >
> > +1 to above questions.
>
> There is an eBPF map, that a variable number of eBPF programs use, to acc=
ess
> common states for a variable number of connections. On predefined events,=
 a set
> of keys is deleted from this map. This set can either be all keys or just=
 a
> subset of all keys - but it is not guaranteed that this set of keys still=
 exists
> in this eBPF map.
> The current work around is to use bpf_map_lookup_and_delete_batch(), as t=
his
> operation continues on missing keys and clears all requested keys from th=
e eBPF
> map.

Hmm.
bpf_map_lookup_and_delete_batch() deletes all elements and
returns key/values.
It doesn't do any key comparisons.
There is no concept of skipping keys or missing keys.
It deletes all.

This cannot be a workaround.

> The noticeable downside of bpf_map_lookup_and_delete_batch() is the memor=
y
> requirement that comes with the lookup and allocation for the values.

Sure. That's why I suggest for_each+delete that clears the map
without returning key/value back to user space.

> > > [..] If it is
> > > expensive, does it make more sense to add a new command to delete all
> > > elements in the map ?
>
> It felt like bpf_map_delete_batch() was introduced for this use case. So =
adding
> a new command was not considered.
>
> >
> > In addition:
> >
> > What is the use case ?
> > Are you trying to erase all elements from the map ?
> >
> > If so you bpf_for_each_map_elem() and delete elems while iterating.
>
> bpf_for_each_map_elem() could be an option if the map should be flushed
> completley, but in most cases only a subset of keys should be removed fro=
m the
> map.
>
> >
> > This extra flag looks too specific.
>
> Sure, the proposed flag is focused on the delete operation. What could be=
 the
> requirement to make it less specific?

I feel that letting map_delete_batch() ignore keys make it a footgun.

Sounds like in your case the key is a network connection tuple.
So by ignoring unknown tuple you're saying 'delete connection info
if it's there'. I assuming because bpf prog and user space may race
to delete it.
In such case user space can trim key list and retry generic_map_delete_batc=
h.
It's another syscall. A bit more overhead, but
try to speed up this very specific use cases seems wrong.
It's not going to be much faster. The set of keys is probably limited.

