Return-Path: <bpf+bounces-43985-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47BD49BC2D9
	for <lists+bpf@lfdr.de>; Tue,  5 Nov 2024 02:55:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B4F31C21F13
	for <lists+bpf@lfdr.de>; Tue,  5 Nov 2024 01:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D33F027713;
	Tue,  5 Nov 2024 01:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WeFEflO6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9DE1210FB
	for <bpf@vger.kernel.org>; Tue,  5 Nov 2024 01:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730771754; cv=none; b=PqdNTzvl/snQ/Ns3mqZu3DbWxzcqzgAlwTR6OQOteaaDktyTKk5qxW25FsN7n6dANi0yiq1+y124aJ/1utd2rW6/CQUGNZCDAXvz10sSZ2tnsT5t8TbYh+6iW1TQJ1+dxuoIIBP8OOc3hTn3NIeUKwDroUX/zKdi74dv0cTt1SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730771754; c=relaxed/simple;
	bh=8Yj3KQw008TR2GYP99UOvN47Oab4tmB6maq0PCUi+2M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WHpR0v1chDXjkM1ZV1NUnlPtfSByde3ZH3D4as7b7vGMuap6jE2cBliqR6fDI5z4g93gOV0VhWP1TnFjr3QwrLlPc9kmZjCnESbIn/cY8SX+4IT6PnwkdvI9f1a+6IKyU4HaiZvaAUWLTRUvw9Jg00KO36zEUwrERCxRBj6giqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WeFEflO6; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4319399a411so42122705e9.2
        for <bpf@vger.kernel.org>; Mon, 04 Nov 2024 17:55:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730771751; x=1731376551; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WuynxBiB7Yz4nsFp+kFqlRBUoncep751GvtS0Or5OeM=;
        b=WeFEflO6kDglrccIHdTOI+0RPaalw42AMGk61nB4YuLH23TWpClD+qf1PGjph+I0Go
         mDojWMYJp4TJkFtjcMS07JC4cJXvuFDKnxo8ksh0DiaQcmM9IgQ5mlEXzotwB5so/6zu
         lUFIvONbmARsMqIO76oTORcaKn4uOuXKH5kPArngGC6+yxyTiihT4CTDtUFRgFn7Eo6t
         bxcnmaNE0T4MaFEpQ3WjqTBmdQ+0iJxI4zlQGdgrXj0WqGrAR5mkZmVob6GN3ZSrxXd1
         kaOmYRE2NVPmesTieyE35xz7OAXz8Ewpy9HGJIcmZAjk9VyhDnIbwvVqWpArqbFAtbJJ
         Oa7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730771751; x=1731376551;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WuynxBiB7Yz4nsFp+kFqlRBUoncep751GvtS0Or5OeM=;
        b=TlP3NDatvV5lCgWkyDh+PXGeoe950Vp7/iP/hZMhqfGWbeH8FcqS8imIhOtPqHXPiE
         maIQLp2uncQFDc7ZAbZK/kwtSxvK9ClhtQAgJ6BpIjWALi29KkKvadg+s8QTMxiHInNu
         ic/v91KYSlFKtzf6B70RErDPFFD4XKqe3hQjm614sNcPFuIPfRpzS1bgVspIn8kIhdgl
         G/4ty4tF4VLasZvjeTfi/LvQ4qjioPk2GgwPpxlftonamLUH7OTw/YVpL/Y3oCMirShJ
         h6ka3OPUb9E0v0QLp9uLzn2gEUqyP0986NZ6B32GyOOslTlbqkleNPJuOC8ge4PRzNEb
         /U3g==
X-Gm-Message-State: AOJu0YzI3dc7B6GX2/vBgr5ZSrCWb5FJKFmdXvIZ43h+kgogt3bDmAfP
	N9v90uNytHnYppJIzpuw3iHbyvJfdNv5v2id2E+b4LQookPYIJLwQplmaBJPH0Zh4O0rnlIQTWq
	+JI8k3hC9qygFozz7u5Ry7olQcLA=
X-Google-Smtp-Source: AGHT+IFT+o4zxdh7QRTg0FMUeYlH2v1nsiqSE5A5mY6z60EqDalo5BmKu/fX0XdyEVQ1BRVuqrXjofI1Vs85zGpP25A=
X-Received: by 2002:a05:600c:4ecb:b0:42e:75a6:bb60 with SMTP id
 5b1f17b1804b1-4319acb8fcbmr294643545e9.19.1730771750964; Mon, 04 Nov 2024
 17:55:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241104193455.3241859-1-yonghong.song@linux.dev>
 <20241104193505.3242662-1-yonghong.song@linux.dev> <CAADnVQLr5Rz+L=4CWPxjBGLcYEctLRpPfh642LtNjXKTbyKPgQ@mail.gmail.com>
 <36294e71-4d0b-465d-9bf5-c5640aa3a089@linux.dev>
In-Reply-To: <36294e71-4d0b-465d-9bf5-c5640aa3a089@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 4 Nov 2024 17:55:39 -0800
Message-ID: <CAADnVQLXbsuzHX6no+CSTAOYxt27jNY5qgtrML6vqEVsggfgRQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v9 02/10] bpf: Return false for
 bpf_prog_check_recur() default case
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>, Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 4, 2024 at 5:35=E2=80=AFPM Yonghong Song <yonghong.song@linux.d=
ev> wrote:
>
>
> On 11/4/24 5:21 PM, Alexei Starovoitov wrote:
> > On Mon, Nov 4, 2024 at 11:35=E2=80=AFAM Yonghong Song <yonghong.song@li=
nux.dev> wrote:
> >> The bpf_prog_check_recur() funciton is currently used by trampoline
> >> and tracing programs (also using trampoline) to check whether a
> >> particular prog supports recursion checking or not. The default case
> >> (non-trampoline progs) return true in the current implementation.
> >>
> >> Let us make the non-trampoline prog recursion check return false
> >> instead. It does not impact any existing use cases and allows the
> >> function to be used outside the trampoline context in the next patch.
> > Does not impact ?! But it does.
> > This patch removes recursion check from fentry progs.
> > This cannot be right.
>
> The original bpf_prog_check_recur() implementation:
>
> static inline bool bpf_prog_check_recur(const struct bpf_prog *prog)
> {
>          switch (resolve_prog_type(prog)) {
>          case BPF_PROG_TYPE_TRACING:
>                  return prog->expected_attach_type !=3D BPF_TRACE_ITER;
>          case BPF_PROG_TYPE_STRUCT_OPS:
>          case BPF_PROG_TYPE_LSM:
>                  return false;
>          default:
>                  return true;
>          }
> }
>
> fentry prog is a TRACING prog, so it is covered. Did I miss anything?

I see. This is way too subtle.
You're correct that fentry is TYPE_TRACING,
so it could have "worked" if it was used to build trampolines only.

But this helper is called for other prog types:

        case BPF_FUNC_task_storage_get:
                if (bpf_prog_check_recur(prog))
                        return &bpf_task_storage_get_recur_proto;
                return &bpf_task_storage_get_proto;

so it's still not correct, but for a different reason.

