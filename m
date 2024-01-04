Return-Path: <bpf+bounces-19077-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A386824B21
	for <lists+bpf@lfdr.de>; Thu,  4 Jan 2024 23:46:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4A501F229A1
	for <lists+bpf@lfdr.de>; Thu,  4 Jan 2024 22:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AF6E2D040;
	Thu,  4 Jan 2024 22:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IQgzbLnF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E2B2CCB2;
	Thu,  4 Jan 2024 22:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-556aa7fe765so1146783a12.2;
        Thu, 04 Jan 2024 14:46:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704408368; x=1705013168; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=06lPjTfo3YdRLLJ7lhbrUqAnozPaB9BqiqaizfWnuOM=;
        b=IQgzbLnFGdO+4MBt6ztnHKGXNezZFRB7ucHqKPakO5MjdHU1sp8etNPSdXRyhWKmol
         9rNyhc4udwC4VDtxzdsbqN+emtTzhdEz46t7UTd3CaVTbF/gpavy6UxlYaCUU1p29EWZ
         ZfxgH2AqaEGTgPAPCaBWb5gFIugUaa6BxWk6F5NAXAabFaOmLIvyf9yHD9AqQsDPYgsH
         XXliaECHgt3YFKuXGIcF76mI+sbdWoEmsMAsflyaBYP/8zUd+apoGHSn3lXF+/Sry65Q
         gWuNgmoxyZ1ZuZvUYmeDI7447L9ViAIQhkhqkbprJmCAmdid1yhVBSFJ5JxFvScIWuHV
         S3Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704408368; x=1705013168;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=06lPjTfo3YdRLLJ7lhbrUqAnozPaB9BqiqaizfWnuOM=;
        b=M8eBBILl9+idCXYwSVsDUgf7OIm+wj7bj29mMG5YRyMTHJwvHOvD+V0lj/yYjHMJ6x
         J6r0hCDuWneSKlcHki0XYbQ/HZO9HY4Y0IxMpNRD+UNlrvVfPFWPkXmsHeGohxVpRYpe
         mFalkA84ZHbNXWmE2W6KVUcbMGqXl5heBF7GywU/8AMDd0GksHh8lTlrH15mu24guNeS
         sf6p+QnoUqUHIAdeamVFeXeTz7hyChoUsdKd1wqkzK3vrIgCWp9cu2dZYTBH1NAJe++H
         0wN7qgDrbFhnaq5ez/kUA//cYY3OyAR10EOA5wjUKTLHnYv6uz/o+xZQQtEhFqZ/lJ3p
         nPTg==
X-Gm-Message-State: AOJu0YwOBhhECEfUg9xA3QS08J3O8wSzIM5lLBM2s2VjkddqUROHARIT
	7NSQRdWo7BAsgVy+kUbTuaGw54X4Sg+k65bwuOs=
X-Google-Smtp-Source: AGHT+IEvXzOjgkjtMlZPKJt0H3xhedbOAegeiCnY8TSorXC5N7cWhhDeTHTcmRD7oblIzYW2yCNaZ+G3A757U8v7bxI=
X-Received: by 2002:a17:906:c55:b0:a28:77b:bb36 with SMTP id
 t21-20020a1709060c5500b00a28077bbb36mr625274ejf.134.1704408368287; Thu, 04
 Jan 2024 14:46:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240103153307.553838-1-brho@google.com> <20240103153307.553838-3-brho@google.com>
 <CAEf4BzbKT3LbHQSFwpAfoJuhyGy2NpHk7A6ivkFiutN_jnKHYg@mail.gmail.com> <0d9f51e9-7e07-48dd-bf18-ea28ab6b1e83@google.com>
In-Reply-To: <0d9f51e9-7e07-48dd-bf18-ea28ab6b1e83@google.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 4 Jan 2024 14:45:56 -0800
Message-ID: <CAEf4Bzb8RviBbC0fVMzKmoY6oU0B1v_8CrnUr1RaffPWb7SpLQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: add inline assembly helpers
 to access array elements
To: Barret Rhoden <brho@google.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, mattbobrowski@google.com, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 4, 2024 at 1:37=E2=80=AFPM Barret Rhoden <brho@google.com> wrot=
e:
>
> On 1/3/24 14:51, Andrii Nakryiko wrote:
> >> +
> >> +/*
> >> + * Helper to load and run a program.
> >> + * Call must define skel, map_elems, and bss_elems.
> >> + * Destroy the skel when you're done.
> >> + */
> >> +#define load_and_run(PROG) ({
> > does this have to be a macro? Can you write it as a function?
>
> can do.  (if we keep these patches).
>
> i used a macro for the ## PROG below, but i can do something with ints
> and switches to turn on the autoload for a single prog.  or just
> copy-paste the boilerplate.

why can't you pass the `struct bpf_program *prog` parameter?

>
> >> +       int err;                                                      =
  \
> >> +       skel =3D array_elem_test__open();                             =
    \
> >> +       if (!ASSERT_OK_PTR(skel, "array_elem_test open"))             =
  \
> >> +               return;                                               =
  \
> >> +       bpf_program__set_autoload(skel->progs.x_ ## PROG, true);      =
  \
>
> thanks,
>
> barret
>
>

