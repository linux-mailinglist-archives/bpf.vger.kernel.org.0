Return-Path: <bpf+bounces-64516-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE75FB13C53
	for <lists+bpf@lfdr.de>; Mon, 28 Jul 2025 16:03:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CAB11C21F53
	for <lists+bpf@lfdr.de>; Mon, 28 Jul 2025 13:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE78E277C9D;
	Mon, 28 Jul 2025 13:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="C+FYiwjc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB7D27281D
	for <bpf@vger.kernel.org>; Mon, 28 Jul 2025 13:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753710889; cv=none; b=GLe916q9Fqj9WM1/2o8Np+N0AWSKFfVnpOQicnRgpQ0ouFb765uoOQIKCGrLQ5qrRrYc5IzFmcrbdEPDAE+mC39WQ4BM9YX9w+VYTz5Z0z8hqPaYcdrAa6llXkr85e0D4zQya3dlz5uTvCuHbrj3kJtGTX/88qDKPbiz4xU6+qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753710889; c=relaxed/simple;
	bh=x/yb4HC2Xl2ySb/GMi99oyej0z3Lz80nYVhRpbu/YqY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e7mSa4m2W/cMKklq4yr/TMy4vk0JtCEmsQCcCe81YD7/eRFd7Myf+kAskkTWCjb06lvQkmnk4Z1loBFxhvzca3iLYdy3O9WvR5NR6vCVvBu1ASYxeF540eP66B+KKG7pGmZZOHJbzEJlrCdb0XqMey2mzAicAa4j2pPnBZAuRms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=C+FYiwjc; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-71a1df028b1so8860587b3.1
        for <bpf@vger.kernel.org>; Mon, 28 Jul 2025 06:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1753710886; x=1754315686; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3RZYXq/OvdawPiF2bTXvsrcdRx1GVjERuhMIvOj7h+s=;
        b=C+FYiwjcORVAoNXLGpiHNl7diJIUi9mmfbaRjTl0okea2VPmmr8UxAZjlSs5HpPAmH
         Fbztjodpg6XaFW6of+mlxfTDTldWw5biQ+EFYPLFLs0zfUsB9AK9eXqdVjoN6rTL+Q6e
         ilX5QKYG8SjnD9VJC1zLsn3DcZPgLpyipbuPE1JAkBKP5gIkMdhlAvWG3+EK2F4u1LwZ
         ybklsoIyXuCbY8iNyYbICZXWyyfyJoeyI+rdApDYuhRRfpe5aek3GnUU2D8/I45JjLBP
         YF6VmQrqwHBF1waqcdGmJTDxA8nmndTXjIaAERtOTzTSXjloabmiszjK/0QD8r9dHARP
         /3bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753710886; x=1754315686;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3RZYXq/OvdawPiF2bTXvsrcdRx1GVjERuhMIvOj7h+s=;
        b=H1i2/coyVc1JoIHvdz4fHiLV8RTPkI7HCdFi7FPUKKj8/vvjyfeFTy0XXWdxdqV/JK
         so44bruvT9HV06Mu7YanIvZ+KVI3oP0Ha/CF4xfcTJDV97Pm+ra5EsJ6L2B6OrdwIjxu
         ojYkYoLps5rsdt5WtHmxdpBv9fNWd4dIb9G0u9kxmLIEjZotpgmW8QSS1bJBjj3uJJs2
         SPV0bHcLBKTmSQLeIY59xa8B8s9tCFk05iRIezFJk6way1mi2aOzMKhN8Ky9tjknvBbS
         EPrCZZ9JB2JMwCjx/wFVrbUmus5DHZaY6KzgGTlewj11NdP4rJmXWx7edyDBg3CVlNR7
         OcCA==
X-Gm-Message-State: AOJu0YzX93vfx7v2lbV1owL2DlkJtFtgujAPe7NsWW4YYfUQSfit0pJ/
	B5Qui59+w+/xUZu9jk1nml/KXKZAEFFcVJLOtPMGz9ttkbJfIvCBJvzBvH47XQvKTC89yGtcvnK
	1Wsl1pQeKg+E/R6A0BV+6bfOxPFfFvRrMS3cObvNFtQ==
X-Gm-Gg: ASbGnctyCam3WJfyD5GItVI/JLx4ycEQ649EmPK3KVeqN7WFDSBa2oocJQcEAy4PABr
	bOwB/X1ZuUXn6ZO2pndPsJ0FdicRz6UYygCwFMp+Mdpr86YBuVgSOMMci14rtR595qvYMG8wk14
	3XU2DWiORDOowIKybRi33kyLdoE3sgjkaffgVVSxfwq+8JUu+ahbwXyVQsv8v30HvgyCg2trUoV
	ISgILNd
X-Google-Smtp-Source: AGHT+IGP2ALDWIUoOOWHCO7bzLkxfwCIBrPkSHNtI7/E6SsWmu41Kb6jVGTQK/GJL4VrFXvQ/HD0O/sTGt0vKsz1jQw=
X-Received: by 2002:a05:690c:6281:b0:71a:18b5:ef27 with SMTP id
 00721157ae682-71a18b5f1b7mr48462407b3.18.1753710885751; Mon, 28 Jul 2025
 06:54:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250717164842.1848817-1-ameryhung@gmail.com>
In-Reply-To: <20250717164842.1848817-1-ameryhung@gmail.com>
From: Emil Tsalapatis <linux-lists@etsalapatis.com>
Date: Mon, 28 Jul 2025 09:54:35 -0400
X-Gm-Features: Ac12FXyzrR9PFh36bD_7_IC6OAVScVa66EVwwh8JHXqv5ZbB9QqiJLUSQI8Sc1E
Message-ID: <CABFh=a5Z7i+Yk4i42=BSt9+9NLQtY-CP73M5kQiroQpNtsELfQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 0/3] Task local data
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, tj@kernel.org, memxor@gmail.com, 
	martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Some feedback on the cover letter:

On Thu, Jul 17, 2025 at 12:48=E2=80=AFPM Amery Hung <ameryhung@gmail.com> w=
rote:
>
> * Motivation *
>
> CPU schedulers can potentially make a better decision with hints from
> user space process. To support experimenting user space hinting with
> sched_ext, there needs a mechanism to pass a "per-task hint" from user
> space to the bpf scheduler "efficiently".
>

I think this is underselling the feature a bit, isn't it useful for
all BPF users?
Otherwise why isn't it in the scx repo?

> The proposed mechanism is task local data. Similar to pthread key or
> __thread, it allows users to define thread-specific data. In addition,
> the user pages that back task local data are pinned to the kernel to
> share with bpf programs directly. As a result, user space programs
> can directly update per-thread hints, and then bpf program can read
> the hint with little overhead. The diagram in the design section gives
> a sneak peek of how it works.
>
>
> * Overview *
>
> Task local data defines an abstract storage type for storing data specifi=
c
> to each task and provides user space and bpf libraries to access it. The
> result is a fast and easy way to share per-task data between user space
> and bpf programs. The intended use case is sched_ext, where user space
> programs will pass hints to sched_ext bpf programs to affect task
> scheduling.
>

Same as above, why is this a sched_ext feature? Maybe some of the design
choices are informed by it, but there is nothing sched_ext specific in here=
.

> Task local data is built on top of task local storage map and UPTR[0]
> to achieve fast per-task data sharing. UPTR is a type of special field
> supported in task local storage map value. A user page assigned to a UPTR
> will be pinned by the kernel when the map is updated. Therefore, user
> space programs can update data seen by bpf programs without syscalls.
>
> Additionally, unlike most bpf maps, task local data does not require a
> static map value definition. This design is driven by sched_ext, which
> would like to allow multiple developers to share a storage without the
> need to explicitly agree on the layout of it. While a centralized layout
> definition would have worked, the friction of synchronizing it across
> different repos is not desirable. This simplify code base management and
> makes experimenting easier.
>

This text is hard to follow because the point it makes belongs in the desig=
n
section, this is a design point that does not really matter at this
point in the text.
At least make it more abstract maybe?

> In the rest of the cover letter, "task local data" is used to refer to
> the abstract storage and TLD is used to denote a single data entry in
> the storage.
>
>
> * Design *
>
> Task local data library provides simple APIs for user space and bpf
> through two header files, task_local_data.h and task_loca_data.bpf.h,

Typo: task_loca_data ->task_local_data

> respectively. The usage is illustrated in the following diagram.
> An entry of data in the task local data, TLD, first needs to be defined
> with TLD_DEFINE_KEY() with the size of the data and a name associated wit=
h
> the data. The macro defines and initialize an opaque key object of

Typo: initialize -> initializes

> tld_key_t type, which can be used to locate a TLD. The same key may be
> passed to tld_get_data() in different threads, and a pointer to data
> specific to the calling thread will be returned. The pointer will
> remain valid until the process terminates, so there is not need to call

Typo: not need -> no need

> tld_get_data() in subsequent accesses.
>
> TLD_DEFINE_KEY() is allowed to define TLDs up to roughly a page. In the
> case when a TLD can only be known and created on the fly,
> tld_create_key() can be called. Since the total TLD size cannot be known
> beforehand, a memory of size TLD_DYN_DATA_SIZE is allocated for each
> thread to accommodate them.
>
> On the bpf side, programs will use also use tld_get_data() to locate
> TLDs. The arugments contain a name and a key to a TLD. The name is
> used for the first tld_get_data() to a TLD, which will lookup the TLD
> by name and save the corresponding key to a task local data map,
> tld_key_map. The map value type, struct tld_keys, __must__ be defined by
> developers. It should contain keys used in the compilation unit.
>
>
>  =E2=94=8C=E2=94=80 Application =E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=90
>  =E2=94=82 TLD_DEFINE_KEY(kx, "X", 4);      =E2=94=8C=E2=94=80 library A =
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=90=E2=94=82
>  =E2=94=82                                  =E2=94=82 void func(...)     =
             =E2=94=82=E2=94=82
>  =E2=94=82 int main(...)                    =E2=94=82 {                  =
             =E2=94=82=E2=94=82
>  =E2=94=82 {                                =E2=94=82     tld_key_t ky;  =
             =E2=94=82=E2=94=82
>  =E2=94=82      int *x;                     =E2=94=82     bool *y;       =
             =E2=94=82=E2=94=82
>  =E2=94=82                                  =E2=94=82                    =
             =E2=94=82=E2=94=82
>  =E2=94=82      x =3D tld_get_data(fd, kx);   =E2=94=82     ky =3D tld_cr=
eate_key("Y", 1);=E2=94=82=E2=94=82
>  =E2=94=82      if (x) *x =3D 123;            =E2=94=82     y =3D tld_get=
_data(fd, ky);   =E2=94=82=E2=94=82
>  =E2=94=82                         =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=A4     if (y) *y =3D tr=
ue;           =E2=94=82=E2=94=82
>  =E2=94=82                         =E2=94=82        =E2=94=94=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=98=E2=94=
=82
>  =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=AC=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=82=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=98
>          V                 V
>  + =E2=94=80 Task local data =E2=94=80 =E2=94=80 =E2=94=80 =E2=94=80 =E2=
=94=80 +  =E2=94=8C=E2=94=80 BPF program =E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=90
>  | =E2=94=8C=E2=94=80 tld_data_map =E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=90 |  =E2=94=
=82 struct tld_object obj;             =E2=94=82
>  | =E2=94=82 BPF Task local storage  =E2=94=82 |  =E2=94=82 bool *y;     =
                      =E2=94=82
>  | =E2=94=82                         =E2=94=82 |  =E2=94=82 int *x;      =
                      =E2=94=82
>  | =E2=94=82 __uptr *data            =E2=94=82 |  =E2=94=82              =
                      =E2=94=82
>  | =E2=94=82 __uptr *metadata        =E2=94=82 |  =E2=94=82 if (tld_init_=
object(task, &obj))   =E2=94=82
>  | =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=98 |  =E2=94=82     return 0;                      =
=E2=94=82
>  | =E2=94=8C=E2=94=80 tld_key_map =E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=90 |  =
=E2=94=82                                    =E2=94=82
>  | =E2=94=82 BPF Task local storage  =E2=94=82 |  =E2=94=82 x =3D tld_get=
_data(&obj, kx, "X", 4);=E2=94=82
>  | =E2=94=82                         =E2=94=82 |<=E2=94=80=E2=94=A4 if (x=
) /* do something */          =E2=94=82
>  | =E2=94=82 tld_key_t kx;           =E2=94=82 |  =E2=94=82              =
                      =E2=94=82
>  | =E2=94=82 tld_key_t ky;           =E2=94=82 |  =E2=94=82 y =3D tld_get=
_data(&obj, ky, "Y", 1);=E2=94=82
>  | =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=98 |  =E2=94=82 if (y) /* do something */          =
=E2=94=82
>  + =E2=94=80 =E2=94=80 =E2=94=80 =E2=94=80 =E2=94=80 =E2=94=80 =E2=94=80 =
=E2=94=80 =E2=94=80 =E2=94=80 =E2=94=80 =E2=94=80 =E2=94=80 =E2=94=80 +  =
=E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=98
>
>
>
> * Implementation *
>
> Task local data defines the storage to be a task local storage map with
> two UPTRs, data and metadata. Data points to a blob of memory for storing
> TLDs individual to every task with the offset of data in a page. Metadata=
,

Nit: Maybe just use the name of the struct, u_tld_metadata?

> individual to each process and shared by its threads, records the total
> number and size of TLDs and the metadata of each TLD. Metadata for a
> TLD contains the key name and the size of the TLD.
>
>   struct u_tld_data {
>           u64 start;
>           char data[PAGE_SIZE - 8];
>   };
>
>   struct u_tld_metadata {
>           u8 cnt;
>           u16 size;
>           struct metadata data[TLD_DATA_CNT];

Rename data -> metadata? That's how it is in the code.

>   };
>
> Both user space and bpf API follow the same protocol when accessing
> task local data. A pointer to a TLD is located by a key. tld_key_t
> effectively is the offset of a TLD in data. To add a TLD, user space

typo: user space API -> the user space API

> API, loops through metadata->data until an empty slot is found and update
> it. It also adds sizes of prior TLDs along the way to derive the offset.
> To locate a TLD in bpf when the first time tld_get_data() is called,
> __tld_fetch_key() also loops through metadata->data until the name is

Same here, isn't it ->metadata?

> found. The offset is also derived by adding sizes. When the TLD is not
> found, the current TLD count is cached instead to skip name comparison
> that has been done. The detail of task local data operations can be found
> in patch 1.
>
>
> * Misc *
>
> The metadata can potentially use run-length encoding for names to reduce
> memory wastage and support save more TLDs. I have a version that works,
> but the selftest takes a bit longer to finish. More investigation needed
> to find the root cause. I will save this for the future when there is a
> need to store more than 63 TLDs.
>
>
> [0] https://lore.kernel.org/bpf/20241023234759.860539-1-martin.lau@linux.=
dev/
>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>



> ---
>
> v5 -> v6
>   - Address Andrii's comment
>   - Fix verification failure in no_alu32
>   - Some cleanup
>   v5: https://lore.kernel.org/bpf/20250627233958.2602271-1-ameryhung@gmai=
l.com/
>
> v4 -> v5
>   - Add an option to free memory on thread exit to prevent memory leak
>   - Add an option to reduce memory waste if the allocator can
>     use just enough memory to fullfill aligned_alloc() (e.g., glibc)
>   - Tweak bpf API
>       - Remove tld_fetch_key() as it does not work in init_tasl
>       - tld_get_data() now tries to fetch key if it is not cached yet
>   - Optimize bpf side tld_get_data()
>       - Faster fast path
>       - Less code
>   - Use stdatomic.h in user space library with seq_cst order
>   - Introduce TLD_DEFINE_KEY() as the default TLD creation API for
>     easier memory management.
>       - TLD_DEFINE_KEY() can consume memory up to a page and no memory
>         is wasted since their size is known before per-thread data
>         allocation.
>       - tld_create_key() can only use up to TLD_DYN_DATA_SIZE. Since
>         tld_create_key can run any time even after per-thread data
>         allocation, it is impossible to predict the total size. A
>         configurable size of memory is allocated on top of the total
>         size of TLD_DEFINE_KEY() to accommodate dynamic key creation.
>   - Add tld prefix to all macros
>   - Replace map_update(NO_EXIST) in __tld_init_data() with cmpxchg()
>   - No more +1,-1 dance on the bpf side
>   - Reduce printf from ASSERT in race test
>   - Try implementing run-length encoding for name and decide to
>     save it for the future
>   v4: https://lore.kernel.org/bpf/20250515211606.2697271-1-ameryhung@gmai=
l.com/
>
> v3 -> v4
>   - API improvements
>       - Simplify API
>       - Drop string obfuscation
>       - Use opaque type for key
>       - Better documentation
>   - Implementation
>       - Switch to dynamic allocation for per-task data
>       - Now offer as header-only libraries
>       - No TLS map pinning; leave it to users
>   - Drop pthread dependency
>   - Add more invalid tld_create_key() test
>   - Add a race test for tld_create_key()
>   v3: https://lore.kernel.org/bpf/20250425214039.2919818-1-ameryhung@gmai=
l.com/
>
>
> Amery Hung (3):
>   selftests/bpf: Introduce task local data
>   selftests/bpf: Test basic task local data operations
>   selftests/bpf: Test concurrent task local data key creation
>
>  .../bpf/prog_tests/task_local_data.h          | 388 ++++++++++++++++++
>  .../bpf/prog_tests/test_task_local_data.c     | 297 ++++++++++++++
>  .../selftests/bpf/progs/task_local_data.bpf.h | 227 ++++++++++
>  .../bpf/progs/test_task_local_data.c          |  65 +++
>  4 files changed, 977 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/task_local_dat=
a.h
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/test_task_loca=
l_data.c
>  create mode 100644 tools/testing/selftests/bpf/progs/task_local_data.bpf=
.h
>  create mode 100644 tools/testing/selftests/bpf/progs/test_task_local_dat=
a.c
>
> --
> 2.47.1
>
>

