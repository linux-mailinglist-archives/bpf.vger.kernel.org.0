Return-Path: <bpf+bounces-56726-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CC0DA9D300
	for <lists+bpf@lfdr.de>; Fri, 25 Apr 2025 22:30:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D97B01C007C1
	for <lists+bpf@lfdr.de>; Fri, 25 Apr 2025 20:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D025222562;
	Fri, 25 Apr 2025 20:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MEmA0PHo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07161A9B58;
	Fri, 25 Apr 2025 20:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745613035; cv=none; b=ebCq33yYM8qIZCLVqs9Sidpu6VbMy6B1sBzVJnQ+emJZCazWETrwqEQP4UoEYLoVX3rDC458vZUlmLMhBB98s8MkHF7Do/h0tAUU/eZ58DnD4ArQNzHfVY+9sO4z+wC+IaMgZVlLEREHRPRn6l0f2w1vGiw6UHxloX37eE29nlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745613035; c=relaxed/simple;
	bh=ZBG2w3192k7Zw2J4qBxXuahhkNmVAN9ckWOPGb882oc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NzJNANnXhR8Lds2hCI4mp6Dp+FqnixlKUBtLd7DqKmmYPSBXld0E3lGPmPm14Vvq1RM+dKDyta5hSVRgW9DEPD0CthQCVQ5Ht1m/B9xJgwddKzkcOmFCJzYILIVkqMF77raAQprKfkaGrtmj3voLk3HzFDKJWMhNH8ZdGquaW/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MEmA0PHo; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-39c1efbefc6so1897739f8f.1;
        Fri, 25 Apr 2025 13:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745613032; x=1746217832; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KjaU7oV6Nv7ndape00Yf8cohDP+pDNimggIH43COsgc=;
        b=MEmA0PHoOUAZFWbHmE8iQGrNKssQwmYKqoMDiI1P3tPrIU8+OkXhSFnBsUIvxXDrPk
         k96D+epTkj25E00de9ro4kbOR7LpnQYw/0NBBw5u+bfgEFI7EC9pU3Iw7cg7Ck9FY38a
         NSajwBNRnyStrX7K8JdeSqqrV+ZWmF6F2b3LsTSj3Mb1QRUDmpae1U7LPYxYMqSqihY4
         SL9Bvg9fVsCY6Bamg1PBoWe+8GAj3cS9uIcrwHKpPjuQBQtnRy44oE5vkV54sLtcdX0B
         illKY67x89leNbv2OQGhGg9wbtNbOYH6JevyYbGHuZdDS+yjRMA7JEnTYWb93Bhhwq1G
         eb1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745613032; x=1746217832;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KjaU7oV6Nv7ndape00Yf8cohDP+pDNimggIH43COsgc=;
        b=VvvChsZF7WvRLrHvr96lKc59gDTnJwk6v+yuTLnSef9GCmjvSSTKjqJMO61q3MvT9c
         LZxVC0clFRCX0hOOe73u5vu3kAKt6Q3yFr8LxRki8TmJdSdWzUcGOgi0ZnQ2cgC//xZh
         VCwVuzlt5afwLPTNCtR75VrJzzauBzFQcme+PJ0kdnTq3QTe2ht/KElihMI/aC7/kcfe
         5FuwrgJeX1A7y1G7aL3W6liyXX4RXk2rdACuM3R4azkw8FyDOCLqYBltqi/wBqMBfyaD
         6DkyEkGDrLsZ7p1R/p3bkYYfWfegwbqHxWMIZyEjA4i8ET/K1VP2F43fNJs2KfPfG39b
         GmPA==
X-Forwarded-Encrypted: i=1; AJvYcCUJsdHz/3PfuLf5OsK2CXyWoWWmPbctN5dvb5TDszIZYYwpfFe2KiOt7+1MRQyVgdxeC1Q=@vger.kernel.org, AJvYcCV566LW0ByFX6SwlaP6w0ufS8WbsDBjZMJ0qWmqvXPBAJ/A/08ZKed9pLNByI3GT5PfLmwhfGYMUQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzpfEjmZiXHyWxLGymDlZLiAWGMgp/uPh+xenKimumwVu+287iI
	BrOZKhGNg9HsadU2XdPNN9xKvbuabYuBUzI3zvHnnCiyCMCf1nfncsMUTiOqdu0aV8JPDOYqEtZ
	ZZ8BIBMHt919wYLDfgWmxC1Zjbl8=
X-Gm-Gg: ASbGncv8PDl69LWk6h6+OmbgEHgwUglWFEhrfQftszoxwH7GUWzS9t46cjZzIMdPgH0
	oY3d3lqyBpm2AtmCs5gGQ9DjMZDlBN5OdWYYMFT+MmW//gIzI4Aik31ebZuQmTnp2iFVMgBof3k
	RIF/GsUIigUWRAIwP6PAqXdWdr8bosxIvEpOkvrA==
X-Google-Smtp-Source: AGHT+IGrUqxmd7GEll9x16bPm5oP514HdrUKs460TYRTctuChevPAIdEZhSZ9gQA2l7jzc7On9xzYjNf95ows3ekw4Q=
X-Received: by 2002:a05:6000:659:20b0:39e:cbc7:ad38 with SMTP id
 ffacd0b85a97d-3a074e3748amr1950214f8f.32.1745613031968; Fri, 25 Apr 2025
 13:30:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAADnVQL+-LiJGXwxD3jEUrOonO-fX0SZC8496dVzUXvfkB7gYQ@mail.gmail.com>
 <m2v7qsglbx.fsf@gmail.com> <m2h62cgh7y.fsf@gmail.com> <CAADnVQJQuAkmE_D_ATp-hZeTtUK4Tn=BOOOx+wPtUB1QpzeQuA@mail.gmail.com>
 <m2r01gf0pn.fsf@gmail.com>
In-Reply-To: <m2r01gf0pn.fsf@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 25 Apr 2025 13:30:20 -0700
X-Gm-Features: ATxdqUH2ciDfWEjaAnAHr5VJ5PryKKQVx9ran8tpaBW7m_PDoPlVtYVR7ITXKHE
Message-ID: <CAADnVQKEmZmTdHeyvNaFEwk_5HjSh1v_CpsAtw+wQ5ECXGzFYQ@mail.gmail.com>
Subject: Re: pahole and gcc-14 issues
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Ihor Solodrai <ihor.solodrai@linux.dev>, bpf <bpf@vger.kernel.org>, 
	dwarves@vger.kernel.org, Kumar Kartikeya Dwivedi <memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 25, 2025 at 1:25=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:
>
> [...]
>
> >> $ diff -pruN ~/tmp/task_struct.ko.c ~/tmp/task_struct.vmlinux.c
> >> --- /home/ezingerman/tmp/task_struct.ko.c       2025-04-25 12:37:48.31=
2480603 -0700
> >> +++ /home/ezingerman/tmp/task_struct.vmlinux.c  2025-04-25 12:38:03.09=
6644654 -0700
> >> @@ -18,7 +18,6 @@ struct task_struct {
> >>         int static_prio;
> >>         int normal_prio;
> >>         unsigned int rt_priority;
> >> -       long: 0;
> >>         struct sched_entity se;
> >
> > I reproed this issue with default .ko build that includes:
> > --btf_features=3Ddistilled_base
> >
> > Once I disabled it and did
> > bpftool btf dump file ./bpf_testmod.ko --base-btf .../vmlinux format c
> > the task_struct from vmlinux.h and from testmod.h became exactly the sa=
me.
> > So it sounds like the 3rd issue :)
> > bpftool dump of distilled btf needs work.
>
> Mystery upon mystery.
> Here is a continuation of the last one.
> This is raw BTF for .ko:
>
>   [509] STRUCT 'task_struct' size=3D10496 vlen=3D268
>           ...
>           'rt_priority' type_id=3D3 bits_offset=3D960
>           ...
>
> And this is raw BTF for vmlinux:
>
>   [1] INT 'long unsigned int' size=3D8 bits_offset=3D0 nr_bits=3D64 encod=
ing=3D(none)
>   [2] CONST '(anon)' type_id=3D1
>   [3] VOLATILE '(anon)' type_id=3D2
>   ...
>   [9] INT 'unsigned int' size=3D4 bits_offset=3D0 nr_bits=3D32 encoding=
=3D(none)
>   ...
>   [111] STRUCT 'task_struct' size=3D10496 vlen=3D268
>           ...
>           'rt_priority' type_id=3D9 bits_offset=3D960
>           ...
>
> Note type conflict 'volatile const long' vs 'unsigned int'.
> Either something is very broken or I completely messed up the build.

You didn't turn off distilled_base :)

