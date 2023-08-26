Return-Path: <bpf+bounces-8761-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CD747899BB
	for <lists+bpf@lfdr.de>; Sun, 27 Aug 2023 00:42:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AE7E280FFD
	for <lists+bpf@lfdr.de>; Sat, 26 Aug 2023 22:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D544710955;
	Sat, 26 Aug 2023 22:42:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7D729B0
	for <bpf@vger.kernel.org>; Sat, 26 Aug 2023 22:42:23 +0000 (UTC)
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6E54107
	for <bpf@vger.kernel.org>; Sat, 26 Aug 2023 15:42:21 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id 4fb4d7f45d1cf-52a4737a08fso2698708a12.3
        for <bpf@vger.kernel.org>; Sat, 26 Aug 2023 15:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693089740; x=1693694540;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9eZNmdljoClVtVMBzQsf2SrrhB+4tR94hqWJCtUsCQs=;
        b=gUAmr4VUGevd1BqB0KwSGQ3lyErrUKm2PCUM/TY/4GfatLNGEN7FMqpTCCRVSaC7Zm
         RNkrdYb8I2EB763mtoZJ86Qrz1PxyDr16n/01AET0pJAVbC1GdEuep6ZtXygFxVO0vhB
         71WxOYpqfZ43r76r1zoAS6efc9L2rCp59wdOwraGzvnodDBVuxk0shzWmPUU/Fh3s7oA
         YzWswPC7g7JBRO3ILOY86n/SRGACGRhgkrM8G9l3f2krAEFb7J3PktYJ6UlEjVhL2jGA
         O0pRj0vDLqdh09Gc6DX/zpirHE7W1V57T+qocuuTrjT8ktLpVbZdwnmmPNhMY2FSeT/B
         Uj+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693089740; x=1693694540;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9eZNmdljoClVtVMBzQsf2SrrhB+4tR94hqWJCtUsCQs=;
        b=RpUJsSDgkLsbpvlSZQ5NqhKH8vZNt8/yKeE+o+jdUftuCyxoz2pFau9jq2sbUjvGIh
         Viw/+U2yRfMcLPD0XVHqzTSaAviihWhcT3Suqe9ooBkqi9yPUlrhIj7gT4UH7D7IJu6s
         d/vT0Z4CrP0o3qPC2asyfofNLiUjsWgKTafpSh6yBDlpWM4esbhG71Qi0AYoXlJtMnbh
         1qN2/7YXw8Feea5qDZ1od4Q1ubDL+Y4yA2NgSrUePYoITnLfodTSwD8RrPmhchtJx/vt
         9LGv0L0Cf6Qll0ryrutDgRhiuIjbt5GiNwLQg8N2SBSlgy9TeUs/pffFkXx/fzwbzG5u
         PX4w==
X-Gm-Message-State: AOJu0YxhP8dgPZl6oc0sR8emdDOYcaMEOtYvk+aXtw5cyKlgO7fupkAX
	npXqSFzDXJ+T7cMxOrpsb7+zXwydSzuHO6Vg6Ao=
X-Google-Smtp-Source: AGHT+IGKCG7G2Uhc5i+YiDZrPr+PjH/QynVzL5i7tITcbplyoY8Eg1NBwXOGEkfAA7AGG/AIAbViPlLXRhUTP1MBCB8=
X-Received: by 2002:aa7:d058:0:b0:523:d1ab:b2ed with SMTP id
 n24-20020aa7d058000000b00523d1abb2edmr17549507edo.29.1693089740109; Sat, 26
 Aug 2023 15:42:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230809114116.3216687-1-memxor@gmail.com> <20230809114116.3216687-13-memxor@gmail.com>
 <CAEf4BzbReLRegBDM0JLCQC+fg5jR_HAEMxzCORMz_EDEW590yg@mail.gmail.com>
In-Reply-To: <CAEf4BzbReLRegBDM0JLCQC+fg5jR_HAEMxzCORMz_EDEW590yg@mail.gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Sun, 27 Aug 2023 04:11:41 +0530
Message-ID: <CAP01T77YDLU_3tNRfFXxj__SAY321K99VESO0T_58TgXZrjynw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 12/14] libbpf: Add support for custom
 exception callbacks
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Yonghong Song <yonghong.song@linux.dev>, 
	David Vernet <void@manifault.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, 26 Aug 2023 at 00:13, Andrii Nakryiko <andrii.nakryiko@gmail.com> w=
rote:
>
> On Wed, Aug 9, 2023 at 4:44=E2=80=AFAM Kumar Kartikeya Dwivedi <memxor@gm=
ail.com> wrote:
> >
> > Add support to libbpf to append exception callbacks when loading a
> > program. The exception callback is found by discovering the declaration
> > tag 'exception_callback:<value>' and finding the callback in the value
> > of the tag.
> >
> > The process is done in two steps. First, for each main program, the
> > bpf_object__sanitize_and_load_btf function finds and marks its
> > corresponding exception callback as defined by the declaration tag on
> > it. Second, bpf_object__reloc_code is modified to append the indicated
> > exception callback at the end of the instruction iteration (since
> > exception callback will never be appended in that loop, as it is not
> > directly referenced).
> >
> > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > ---
>
> Just two point before you send next version:
>
> a) it seems like this appending of exception callback logically fits
> bpf_object__relocate() step, where other subprogs are appended. Any
> reason we can't do it there?
>

We should be able to do it there as well. But I felt it is better to
do it in bpf_object__reloc_code as the logic is similar to the
handling of bpf_pseudo_func/bpf_pseudo_call insns. And then we need to
recurse using bpf_object__reloc_code for exception cb again.

> b) all the callbacks are static functions, right? Which means in the
> case of static linking, we can have multiple subprogs with the same
> name. So this whole look up by name thing doesn't guarantee unique
> match. At the very least libbpf should check that the match is unique
> and error out otherwise.

Ack, will fix this in v3.

>
> Ideally though, would be great if something like this would be
> supported instead (but I know it's way more complex, Alexei already
> mentioned that in person and on the list):
>
> try (my_callback) {
>     ... code that throws ...
> }
>
> try (my_other_callback) {
>     ... some other code that throws ...
> }
>
>
> This try() macro can be implemented in a form similar to bpf_for() by
> using fancy for() loop. It would look and feel way more like
> try/catch.
>

These try blocks are easier than having a try/catch block which the
execution jumps to when the exception is thrown. I think the latter
will involve some form of compiler support, because otherwise there is
no control flow that is seen by the compiler into the catch block,
which will mess up things, and I plan to atleast explore that approach
(already looking at LLVM) once I am done with the second part of this
feature.

Having just these try (callback) {} blocks is easier as we can record
which subprog corresponds to [begin_ip, end_ip] (per frame) and stop
unwinding when we find a suitable handler for the ip of a parent
frame. The callback will be invoked and will return to the parent
frame (or kernel if it's the main frame). So if this seems like a more
useful thing, I can make this work and send it out as a follow up to
this set.

> [...]

