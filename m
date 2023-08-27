Return-Path: <bpf+bounces-8815-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A41CF78A2AE
	for <lists+bpf@lfdr.de>; Mon, 28 Aug 2023 00:28:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D22B8280E33
	for <lists+bpf@lfdr.de>; Sun, 27 Aug 2023 22:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF1971429F;
	Sun, 27 Aug 2023 22:28:10 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFFFA2F3A
	for <bpf@vger.kernel.org>; Sun, 27 Aug 2023 22:28:09 +0000 (UTC)
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A15F127
	for <bpf@vger.kernel.org>; Sun, 27 Aug 2023 15:28:07 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2bcb0b973a5so39452101fa.3
        for <bpf@vger.kernel.org>; Sun, 27 Aug 2023 15:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693175286; x=1693780086;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Tvbm5EKL/pY+qIO2PcgkLpGCJosrrGhXqFugNhKm0M=;
        b=cjwgVOZ9Hx0P+4TWPQgJnOMAyLfGWzNuY2B8abmgcR6vjN7iMjsIXDMFJ5JI9/kZpx
         EH9aNe2dDAZMloBmyuA1pv/o2uiYVOsezbnhjQoeuO6EJB5+hER78ie58UwvPLQmqMnq
         CEI8fraYE+aFnPaC5pCGa6MH0U/m1ej3NRVQAbGlCx3q6y8IfUOAN/iCy+DbM5UCSzVQ
         zV8AfH+WDa2rvhw+18mu/QyDB9dzsPlh+a+fP82TU+3E22xB7+MtBR4Hbyoc4lhB1zFL
         a+tsIhh0RW3mYu8sEKxuUSVCYGAOJcHJ7Y0YYJwEdVGykujlBjT02zdz1eN+okIxdhiI
         BwKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693175286; x=1693780086;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Tvbm5EKL/pY+qIO2PcgkLpGCJosrrGhXqFugNhKm0M=;
        b=P3CHgSMeslfnszCWO+VULtVzIwSp7JML8CumfeO5bAtwdPhZlu63noHrI61b8y/fLS
         B+BbmN0zcZNqTY4NKMSqt84duoonR7b3z+uIrE6/IbBJJtMsigeCkEzKj2jlZudX4A90
         0ZXF8MR52vsIaLfTKSwOrmMwhEKJmh/avnEVq5aHfc4K4eIw53UrzJGbKYiQXNR5B8/8
         lbCAFpg8FfhS5HUJepffP3HlC9wtovyATDlNG12qrVBs6AML0ATQjVEQXVKaTkZeGemW
         cLmmoX7dC5Aa465sjtmeYW8Mg7d03xunxsUUC7Jv8Bvjpzrc28F4uQB2Ut+MlcgLqYKX
         +8tg==
X-Gm-Message-State: AOJu0YydquQeuNJqUHqcpBPR4rw7qb+0uqn8e3sOtXprrLhf44NjdgEg
	svx3wrtC3akqniTZYucfLOYcY1r1RhzrKfKWTbOmvb2u3Wk=
X-Google-Smtp-Source: AGHT+IG/7/0k+upCo+BQyDDbJUCHp+9QokavPyuQqL5qlBdgYomkZyIVdiPuU/fQHPlVa6si1jsceDUfkf6UDBfBccE=
X-Received: by 2002:a2e:3817:0:b0:2ba:18e5:1069 with SMTP id
 f23-20020a2e3817000000b002ba18e51069mr17066892lja.4.1693175285527; Sun, 27
 Aug 2023 15:28:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230809114116.3216687-1-memxor@gmail.com> <20230809114116.3216687-13-memxor@gmail.com>
 <CAEf4BzbReLRegBDM0JLCQC+fg5jR_HAEMxzCORMz_EDEW590yg@mail.gmail.com> <CAP01T77YDLU_3tNRfFXxj__SAY321K99VESO0T_58TgXZrjynw@mail.gmail.com>
In-Reply-To: <CAP01T77YDLU_3tNRfFXxj__SAY321K99VESO0T_58TgXZrjynw@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 27 Aug 2023 15:27:54 -0700
Message-ID: <CAADnVQ+awKKQ867e9ZYkCL7ecymtig6ZutEReaAO361=OypX3Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 12/14] libbpf: Add support for custom
 exception callbacks
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Yonghong Song <yonghong.song@linux.dev>, David Vernet <void@manifault.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Aug 26, 2023 at 3:42=E2=80=AFPM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> >
> > Ideally though, would be great if something like this would be
> > supported instead (but I know it's way more complex, Alexei already
> > mentioned that in person and on the list):
> >
> > try (my_callback) {
> >     ... code that throws ...
> > }
> >
> > try (my_other_callback) {
> >     ... some other code that throws ...
> > }
> >
> >
> > This try() macro can be implemented in a form similar to bpf_for() by
> > using fancy for() loop. It would look and feel way more like
> > try/catch.
> >
>
> These try blocks are easier than having a try/catch block which the
> execution jumps to when the exception is thrown. I think the latter
> will involve some form of compiler support, because otherwise there is
> no control flow that is seen by the compiler into the catch block,
> which will mess up things, and I plan to atleast explore that approach
> (already looking at LLVM) once I am done with the second part of this
> feature.
>
> Having just these try (callback) {} blocks is easier as we can record
> which subprog corresponds to [begin_ip, end_ip] (per frame) and stop
> unwinding when we find a suitable handler for the ip of a parent
> frame. The callback will be invoked and will return to the parent
> frame (or kernel if it's the main frame). So if this seems like a more
> useful thing, I can make this work and send it out as a follow up to
> this set.

I suspect even "just try {}" will not work without compiler support.
{} is a semantic structure from compiler pov. It doesn't have
any delineation in LLVM IR. They don't exist to optimization passes.

