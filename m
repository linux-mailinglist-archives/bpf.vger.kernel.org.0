Return-Path: <bpf+bounces-21263-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D16E84AB70
	for <lists+bpf@lfdr.de>; Tue,  6 Feb 2024 02:11:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAC7F1F25B2B
	for <lists+bpf@lfdr.de>; Tue,  6 Feb 2024 01:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57E394A12;
	Tue,  6 Feb 2024 01:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fd8VQlP6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA59AD4E
	for <bpf@vger.kernel.org>; Tue,  6 Feb 2024 01:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707181806; cv=none; b=vGfq/kBJcYy0a6kRanV8+zSB1XRFq2cSTdUfh2kv2Iuzk5jeyB64UA09kzWEM3CHeNEiINwjNKxV908GkD7LOANlahZrMOUCBABoaURCqf+F1vpCEun8B87WYyxC0St4DQNJPf5GVnx1vxW/w+XRK6FxqQ4kDVl0XegODi0UnCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707181806; c=relaxed/simple;
	bh=gP9IB/7WY5Nh6HvGaUjftagq5Fd3AxPL9xAxjl4iQY4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u8XhLSNZ8o4fB61KQFbYljFXtHBtZ3xL8IZG7BMSKlTwXvr86XWB5XoIFd6otfVEaPacc5fAiFOXaepmQ355BdRCJsD0t3dMlhrNCNL76OEu+fOt8gQWXx7w0dVJ369UAdjCxSZsAUZK3fxwp6Up1ltoQfkglvWJkXsOChs9GfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fd8VQlP6; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-40fe2744e5cso296355e9.1
        for <bpf@vger.kernel.org>; Mon, 05 Feb 2024 17:10:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707181803; x=1707786603; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zr/505kskMYMOgDa1R2CAoK5LonsOcj2mh5k5pHXi8Q=;
        b=Fd8VQlP6aEpch1xPw5lHm4VQeV/4oN/ii01sHVAPl/egSfBIfQp8oiQAEaYqgLH8lZ
         +sNGbPStkUtG0Lb6uVMRu30FBahJGlGG0NLcgtfVKqkf1TC8E8BNBxkQrMPQRlitprYo
         vyEuVak/Kicog+vXxbmCw/Dvf9G7ClAr6FkpaojLW8dd1iX+0oDsRukJSNPdgzwHcqym
         POPFSeg6Spu+Ir/ExT6N6nT6GWPbccq56Qa680Z9V2MEgISC71EgCSKTdENLz2z3ezWy
         cuKiP9u4A0Ipj6nqDKvlx9vIVRA8w0as4/lRtU2jOXv5j3/OZc5NwsrXX1sA6+IHks+6
         fZUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707181803; x=1707786603;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zr/505kskMYMOgDa1R2CAoK5LonsOcj2mh5k5pHXi8Q=;
        b=FsRM4DCuyTapEyLbExqkEDdmr+ZvsJlRdQL0Iajj3oIxWVcp3I9hcMtiQlTzuHgW4X
         EG4gG5gv1Ppu4Yre02G+xfrTQfBwQi2uYI4CY+igA409ZGOIyeTM5UsbUiL1FEe2oHmz
         w8HV25TvWYP+AqI5m1N/3TkDFGr5AdNqCJhpmZKMu0j5P4434xWxCIspqzFLH4IW6v0L
         jSKMa3SbSicpy388tV6QEEH4ZysWh1OmB0FjFHlpAVholCTgxm00W+yNGHbTlgnSRqqX
         Y2nD4FQMYKlqFSGnGf8ZlukO88GU2Uf4fRF/URp7oa7WfUO4uNp/iKGpIT+YacIExWhF
         gFcg==
X-Gm-Message-State: AOJu0YwPuCRQLdbPx6xkpFB3R+MAVaTivDL1l+K7+69FjZZDrhY89+09
	niYhpP1FbtovK+cYMhToQBtbCxTGjjqxTET6Xkg3LHXbG8dnckwYmoJnjVvA9YmGZU3NTpklU7g
	C5lYSIHouFAqOu6ayfGeE1HapwGg=
X-Google-Smtp-Source: AGHT+IFUk8XRZLisc/6JYR65or0ylVwRjBsNFXSQForPeHEqOAX/8kysSEOerOVqFvJwHM1XmqVO4DPvQcwEBCV7vSc=
X-Received: by 2002:a05:600c:3b19:b0:40e:45c0:ad64 with SMTP id
 m25-20020a05600c3b1900b0040e45c0ad64mr954631wms.14.1707181803237; Mon, 05 Feb
 2024 17:10:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240202162813.4184616-1-aspsk@isovalent.com> <20240202162813.4184616-4-aspsk@isovalent.com>
In-Reply-To: <20240202162813.4184616-4-aspsk@isovalent.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 5 Feb 2024 17:09:51 -0800
Message-ID: <CAADnVQLnk=UyKBkRAC1tNkiaF7C4+FG7V-b2xrR3oa_E4+QX7Q@mail.gmail.com>
Subject: Re: [PATCH v1 bpf-next 3/9] bpf: expose how xlated insns map to
 jitted insns
To: Anton Protopopov <aspsk@isovalent.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jiri Olsa <jolsa@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Stanislav Fomichev <sdf@google.com>, 
	Yonghong Song <yonghong.song@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Quentin Monnet <quentin@isovalent.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 2, 2024 at 8:34=E2=80=AFAM Anton Protopopov <aspsk@isovalent.co=
m> wrote:
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 4def3dde35f6..bdd6be718e82 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1524,6 +1524,13 @@ struct bpf_prog_aux {
>         };
>         /* an array of original indexes for all xlated instructions */
>         u32 *orig_idx;
> +       /* for every xlated instruction point to all generated jited
> +        * instructions, if allocated
> +        */
> +       struct {
> +               u32 off;        /* local offset in the jitted code */
> +               u32 len;        /* the total len of generated jit code */
> +       } *xlated_to_jit;

Simply put Nack to this approach.

Patches 2 and 3 add an extreme amount of memory overhead.

As we discussed during office hours we need a "pointer to insn" concept
aka "index on insn".
The verifier would need to track that such things exist and adjust
indices of insns when patching affects those indices.

For every static branch there will be one such "pointer to insn".
Different algorithms can be used to keep them correct.
The simplest 'lets iterate over all such pointers and update them'
during patch_insn() may even be ok to start.

Such "pointer to insn" won't add any memory overhead.
When patch+jit is done all such "pointer to insn" are fixed value.

