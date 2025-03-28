Return-Path: <bpf+bounces-54876-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BB01A751A9
	for <lists+bpf@lfdr.de>; Fri, 28 Mar 2025 21:52:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D08F189303B
	for <lists+bpf@lfdr.de>; Fri, 28 Mar 2025 20:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABDDB1E8358;
	Fri, 28 Mar 2025 20:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eQy3NdGw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF91AE545
	for <bpf@vger.kernel.org>; Fri, 28 Mar 2025 20:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743195159; cv=none; b=XhNJycH4E14Wmt3jVSeb0NA6FFnTu0UxexuDVGmWmYtlbmO78pxajWuLhdCVI6Y/FxdPtc82TJJiZs64e7VUlieuMSmOMGSff0u67YyK1QXfOyCHCGl/Eo17QJ4M9JuiBHSnG6CVjmUg6kLgn/qTlEPrrna/3NIgkNIVzYF6M4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743195159; c=relaxed/simple;
	bh=o0Hu2LiSErqJAdNbF+wmL9QZXpswtGXt+oe4Hd4D314=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DrxLL46ppyit7f0fJcSzLbth12intG1/AHlzwHXbqEv7WqPdmz3yhI8iJnn/+PZlPKTn64k9K/DwzLFaKIfibAhpKY/Br6ak3c/mueNodlxswOmHXolTsfJdpREefz0zUuD0NdLHgMrlI7IS8H+2L/a/hlt+vttOwzdG1wObcWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eQy3NdGw; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-301a4d5156aso4146604a91.1
        for <bpf@vger.kernel.org>; Fri, 28 Mar 2025 13:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743195157; x=1743799957; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qxQKZVmKyV9m1ibiDzwCdit5nG4P2FHfiljCH5uWOiA=;
        b=eQy3NdGwbTl07PUCY2/t/gsXD7U4fDGE9OnLa0SdhF2gztBmBGYNgiaprYtRlC0lcJ
         xTT694MUYFbtQ9MqNEKR6NWVShBKfBOarIV2w1MamkhIDhjkgWEdzBBd6HDzaxTv0xn/
         uKT14eLybfSRKFKdr7OEo865qufLmehnJersZELeabVGcuYyYVHDwA5leFZLM2GtQehb
         dgZ48TW2unGD9di2xaSSCxSDkBi7EQHzSmYKftdCOnlUF0AVkqgyD8ciujiTDWGlX6EE
         94LK0hxqZ7TT5rIl/wTR1GAudtPVj8d5OjaqgwFlSbp3hd48Ynn3qP4vGf+XNZvq4Mfn
         567g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743195157; x=1743799957;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qxQKZVmKyV9m1ibiDzwCdit5nG4P2FHfiljCH5uWOiA=;
        b=iVGoZEQxhd1IWom30tyecOgWi75gwy4CWpZavEsPK5V6g1/KeMbRBtfJo3bhuIolt/
         T7h732hE/ZsoGd015tQMwcj5CS9Pd01kBYlcWhz8nS6DB6BJG2nIE1wiOakWJlPCh956
         sPWmaO0hoV0NNpCcFZiIgCpjwFvO/HrGLUaaACwZ9c+oed3s4lsXn8s+m9U+CiLR06Ee
         TnFsjrLOAA4fVWuErE91hx5UN/+WDWNwB4m3os9MF13TVbIEdNV3XDpKwP+wiz40bma3
         g9dw6NsnhN0dtrvbRmOkd4HeMVKHwHLjgEmtMwMM0KLM/ulbi52/xblvZTl4rBOn6oU5
         E1rQ==
X-Gm-Message-State: AOJu0YzuZDSJXliNsa/6Xo+4uzS/ds4S8O8X8TDXYruRFJ4u/bplffnx
	1POOAN3iWGrOwAFSU6x+nCKWX9UHvhLF+qo+GIHRgm+xRd7fb7AFkuYcdcgcy0sIa1nghDkAP0/
	4/xgcWe6CbPfQv4zHLvlWmweMf/5cPQ==
X-Gm-Gg: ASbGnctaqZI4mx1Szmc5hhF2RzHSTHrIblL0XdQ3LHsOBE2a0zajBzcbW+QODPOvev4
	GyFUA3vKd0N9ZZf7JZCEhMURJl5+AAUkd0icRv7orrjex+z3cz0k9EmG1zSYBtAM3N+qcHJAwqa
	rgN9yEKyjdZyIyQGN2nZH8SZA9ygQDJ4xajaVOW/NsDA==
X-Google-Smtp-Source: AGHT+IFwuAOcRCe7Q/Hjhc3cckWMvRzqadmzRd3MfVjvtL4MARzhPJNSeskELaEXveDFW1pFpRtwfrAPiB7a/7KbLFE=
X-Received: by 2002:a17:90a:e183:b0:2ff:7c2d:6ff3 with SMTP id
 98e67ed59e1d1-3053215c0aemr889825a91.35.1743195156827; Fri, 28 Mar 2025
 13:52:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250326180714.44954-1-mykyta.yatsenko5@gmail.com>
 <CAEf4BzY_rbdXFDyYN=s7c25R5kwpBX5-zxQd8Q+6wX2N0r6Uhw@mail.gmail.com> <196c2eb9-aca9-4533-b927-255569154a73@gmail.com>
In-Reply-To: <196c2eb9-aca9-4533-b927-255569154a73@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 28 Mar 2025 13:52:24 -0700
X-Gm-Features: AQ5f1Jq6t_IXDFVV-VQwzIZQNkUoHM_7BAwRWBS4JtHthNxsygddEjTtnKamgSI
Message-ID: <CAEf4BzYBWGHT56b5QAN9VD2viVpgLWTH-SXosPqYjqvfbLpqCg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: add getters for BTF.ext func and line info
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, eddyz87@gmail.com, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 28, 2025 at 12:16=E2=80=AFPM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> On 28/03/2025 17:14, Andrii Nakryiko wrote:
> > On Wed, Mar 26, 2025 at 11:07=E2=80=AFAM Mykyta Yatsenko
> > <mykyta.yatsenko5@gmail.com> wrote:
> >> From: Mykyta Yatsenko <yatsenko@meta.com>
> >>
> >> Introducing new libbpf API getters for BTF.ext func and line info,
> >> namely:
> >>    bpf_program__func_info
> >>    bpf_program__func_info_cnt
> >>    bpf_program__func_info_rec_size
> >>    bpf_program__line_info
> >>    bpf_program__line_info_cnt
> >>    bpf_program__line_info_rec_size
> >>
> >> This change enables scenarios, when user needs to load bpf_program
> >> directly using `bpf_prog_load`, instead of higher-level
> >> `bpf_object__load`. Line and func info are required for checking BTF
> >> info in verifier; verification may fail without these fields if, for
> >> example, program calls `bpf_obj_new`.
> >>
> > Really, bpf_obj_new() needs func_info/line_info? Can you point where
> > in the verifier we check this, curious why we do that.
> Indirectly, yes:
> in verifier.c function check_btf_info_early sets
> `env->prog->aux->btf =3D btf;`
> only if line_info_cnt or func_info_cnt are non zero.
> and then there is a check that errors out:
> `verbose(env, "bpf_obj_new/bpf_percpu_obj_new requires prog BTF\n");`
> perhaps this can be improved as well, by setting aux->btf even if no
> func info and line info

lol, doesn't seem intentional (just in the early days prog BTF was
only referenced and used with func_info/line_info, which isn't true
anymore), we can probably swap the order and load and remember prog
BTF regardless of func_info/line_info. Feel free to send a patch.

> >
> >> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> >> ---
> >>   tools/lib/bpf/libbpf.c   | 30 ++++++++++++++++++++++++++++++
> >>   tools/lib/bpf/libbpf.h   |  8 ++++++++
> >>   tools/lib/bpf/libbpf.map |  6 ++++++
> >>   3 files changed, 44 insertions(+)
> >>

[...]

> >> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> >> index d8b71f22f197..a5d83189c084 100644
> >> --- a/tools/lib/bpf/libbpf.map
> >> +++ b/tools/lib/bpf/libbpf.map
> >> @@ -437,6 +437,12 @@ LIBBPF_1.6.0 {
> >>                  bpf_linker__add_fd;
> >>                  bpf_linker__new_fd;
> >>                  bpf_object__prepare;
> >> +               bpf_program__func_info;
> >> +               bpf_program__func_info_cnt;
> >> +               bpf_program__func_info_rec_size;
> >> +               bpf_program__line_info;
> >> +               bpf_program__line_info_cnt;
> >> +               bpf_program__line_info_rec_size;

nit: hm... please check tabs vs spaces, formatting looks off

> >>                  btf__add_decl_attr;
> >>                  btf__add_type_attr;
> >>   } LIBBPF_1.5.0;
> >> --
> >> 2.48.1
> >>
>

