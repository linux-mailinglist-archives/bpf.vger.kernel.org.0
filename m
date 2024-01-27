Return-Path: <bpf+bounces-20442-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D809783E7E0
	for <lists+bpf@lfdr.de>; Sat, 27 Jan 2024 01:10:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E18E28EB8B
	for <lists+bpf@lfdr.de>; Sat, 27 Jan 2024 00:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E73421FAF;
	Sat, 27 Jan 2024 00:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C+1XxkzR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B701D17D3
	for <bpf@vger.kernel.org>; Sat, 27 Jan 2024 00:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706313698; cv=none; b=hqNOrAW6dMUG2UxtdcLNbly4Yo7LsL6inGjsm20L4ClIi0NQJblnjaO8gMsYUf7N+3DG7Q11xqVpQmyfC/p4+5Pekm3OAgnXrFYbqo/U40SVafLlvXyWOFxRd+gN8+ld2qNEiDws1ybFg6brbMEqVIe2x57hD4f72QZHXe8TVQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706313698; c=relaxed/simple;
	bh=LBb5h70aAaA00by5ONCpxbvVM4+X7G1ZCo5xXQjZfjU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=acaqeILQYKRw/2UQuM/siguXA0KR54TqAsYRGCBH5CJjRwIhTbgFY/il/Z14fBXScdcJ22bfTnd/2rwHY3NHQlNsQOsRyBuH6JNXsdAD+KdANUyY7LttIM7AOvTbW68/WGDnEemy2zPu0DMd+isI8ArWioqH65c5RkDE4+Go0jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C+1XxkzR; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3367a304091so1397026f8f.3
        for <bpf@vger.kernel.org>; Fri, 26 Jan 2024 16:01:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706313695; x=1706918495; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TfrvDj/C5h/4XpSSwgZdUUWpyrSw0Fvr6/VMRmoVgYs=;
        b=C+1XxkzRjXqRNf8/wPZHx9arO4nk/pVwboE/bb8+hTF/C2gUAJnCVO8MLqDX/N1NcC
         tdsIOAjM2nz6W/2AZlzzR3By0EJCR2ZQiu6bFlPbAV1K7nox1rpHmq4v1p55eQg8GTF5
         tc60MErXX1IuoCSgsPr3aSuZAZ/tGtQghW+IMn1zPyqLd2HmdiYWRfv3VFgqESHaBS7p
         DjaEBPW0vM4OMMvBmga9pi8SYm3sUhZIvmXUNbKCpqpNR0UUDHecQpwfDiVPFygKHgl9
         0Tf5aJus+JvEIlDA5LW0K80G7bya2tKaV42z8GqWk86hhEkVK2H0y69qnEBAeqNFGtLf
         x6SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706313695; x=1706918495;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TfrvDj/C5h/4XpSSwgZdUUWpyrSw0Fvr6/VMRmoVgYs=;
        b=HB1HHQX+5XdlH9CZJHecRElDVssOxY9solWn1QGId3Ds8L/e//HN+dwhSD02DriGn+
         bi8mZ1wWR2Oc/JZ7LMR5w7Bi0Fdv0Zc3W9W8m3p6+L4VjywlWAO6ma6j3IwPNAJksccS
         6C7S1C+Bbavf+8owbE8i3ss1iDQky4+WrRwk5rw1GSIwvfAQoQgUwtTMNexc9qZ+E9Yz
         hItvrS/vcGak32pQ81ucgcAJz1GFYd5QDRAymAJtpPqoYbQ9qBK4Zwf8J8G7Ny/qT6nv
         aHILl77b917fHMLfA47Xv2aVU0dhgMmQ3SpHA7fugzILR8tzxJqhbp3kHqK2canKHvmR
         kYNg==
X-Gm-Message-State: AOJu0Yz28pm+1YkzO66IiA19UDKb5Lmw1kLQp0soBatiNohWxBWGTyNV
	gjloDCAfa1wwN6MOiidDjoYnE+5StqdurphrcnqJpjFiORLm0cwYzLT30q3IgZN0TypzpQ0KkO3
	lYb+tMu2DEWM4SsZWDwn67tY1OmQ=
X-Google-Smtp-Source: AGHT+IHddAcLedUGWvLmJZqGGTNaHZGHq9BYlb/PfDmJideuadpyOFA5FxA7JO+o65m+Sj0d3FMzru6A+XKhEMUyreU=
X-Received: by 2002:a5d:5264:0:b0:337:bf81:e07f with SMTP id
 l4-20020a5d5264000000b00337bf81e07fmr229302wrc.52.1706313694574; Fri, 26 Jan
 2024 16:01:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240122212217.1391878-1-thinker.li@gmail.com> <CAEf4BzbQJXGw3w0RnjuUg=RRMDE9jGgOYxVcA9q9hbYnvFBHhg@mail.gmail.com>
In-Reply-To: <CAEf4BzbQJXGw3w0RnjuUg=RRMDE9jGgOYxVcA9q9hbYnvFBHhg@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 26 Jan 2024 16:01:22 -0800
Message-ID: <CAADnVQKx3RK8pK4xpNEPQKYGUemO0VjdRePdr34fJwHZs6Urag@mail.gmail.com>
Subject: Re: [RFC bpf-next v3] bpf, selftests/bpf: Support PTR_MAYBE_NULL for
 struct_ops arguments.
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Kui-Feng Lee <thinker.li@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Kernel Team <kernel-team@meta.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Dave Marchevsky <davemarchevsky@meta.com>, David Vernet <dvernet@meta.com>, 
	Kui-Feng Lee <sinquersw@gmail.com>, Kui-Feng Lee <kuifeng@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 26, 2024 at 3:21=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Mon, Jan 22, 2024 at 1:22=E2=80=AFPM <thinker.li@gmail.com> wrote:
> >
> > From: Kui-Feng Lee <thinker.li@gmail.com>
> >
> > Allow passing a null pointer to the operators provided by a struct_ops
> > object. This is an RFC to collect feedbacks/opinions.
> >
> > The previous discussions against v1 came to the conclusion that the
> > developer should did it in ".is_valid_access". However, recently, kCFI =
for
> > struct_ops has been landed. We found it is possible to provide a generi=
c
> > way to annotate arguments by adding a suffix after argument names of st=
ub
> > functions. So, this RFC is resent to present the new idea.
> >
> > The function pointers that are passed to struct_ops operators (the func=
tion
> > pointers) are always considered reliable until now. They cannot be
> > null. However, in certain scenarios, it should be possible to pass null
> > pointers to these operators. For instance, sched_ext may pass a null
> > pointer in the struct task type to an operator that is provided by its
> > struct_ops objects.
> >
> > The proposed solution here is to add PTR_MAYBE_NULL annotations to
> > arguments and create instances of struct bpf_ctx_arg_aux (arg_info) for
> > these arguments. These arg_infos will be installed at
> > prog->aux->ctx_arg_info and will be checked by the BPF verifier when
> > loading the programs. When a struct_ops program accesses arguments in t=
he
> > ctx, the verifier will call btf_ctx_access() (through
> > bpf_verifier_ops->is_valid_access) to verify the access. btf_ctx_access=
()
> > will check arg_info and use the information of the matched arg_info to
> > properly set reg_type.
> >
> > For nullable arguments, this patch sets an arg_info to label them with
> > PTR_TO_BTF_ID | PTR_TRUSTED | PTR_MAYBE_NULL. This enforces the verifie=
r to
> > check programs and ensure that they properly check the pointer. The
> > programs should check if the pointer is null before reading/writing the
> > pointed memory.
> >
> > The implementer of a struct_ops should annotate the arguments that can =
be
> > null. The implementer should define a stub function (empty) as a
> > placeholder for each defined operator. The name of a stub function shou=
ld
> > be in the pattern "<st_op_type>_stub_<operator name>". For example, for
> > test_maybe_null of struct bpf_testmod_ops, it's stub function name shou=
ld
> > be "bpf_testmod_ops_stub_test_maybe_null". You mark an argument nullabl=
e by
> > suffixing the argument name with "__nullable" at the stub function.  He=
re
> > is the example in bpf_testmod.c.
> >
> >   static int bpf_testmod_ops_stub_test_maybe_null(int dummy, struct
> >                 task_struct *task__nullable)
>
> let's keep this consistent with __arg_nullable/__arg_maybe_null? ([0])
> I'd very much prefer __arg_nullable and __nullable vs
> __arg_maybe_null/__maybe_null, but Alexei didn't like the naming when
> I posted v1.

fwiw I'm aware that _Nullable is a standard and it's supported by clang,etc=
.
If folks insist on such suffix, I can live with that.
But I absolutely don't want that to be a reason to rename
PTR_MAYBE_NULL in the verifier.
My preference is for consistency in the verifier and suffixes.
Hence __maybe_null.
But I'm ok if we do __nullable and keep PTR_MAYBE_NULL.

