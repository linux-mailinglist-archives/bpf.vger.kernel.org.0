Return-Path: <bpf+bounces-57914-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5505AB1C9B
	for <lists+bpf@lfdr.de>; Fri,  9 May 2025 20:48:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6371E17D1FD
	for <lists+bpf@lfdr.de>; Fri,  9 May 2025 18:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD25623F431;
	Fri,  9 May 2025 18:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m+h+PhCG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B00B01E1DE8
	for <bpf@vger.kernel.org>; Fri,  9 May 2025 18:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746816500; cv=none; b=DZcZaiYbDicCc/RcBq74ZtVQ+sId8TnrYI95TMh/om9pqRsapmvcS4mzmuZIs2MfDbcQzm1yiyqKebrL/89vL+p62y7w4eFbVnuYNCGICUCwLZqFhtTWs1pTzwZjA690ZIsx+7L2SrJbqeq9N1+5ee/QpU7q1Wduhit3aBPRTdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746816500; c=relaxed/simple;
	bh=uJFP9Eg4f5upcUtln77jepf91gXMUlwxJWSVZs08gy4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JS6ltMIBAZ+obBhjvWteGeUdwNe0uQYOoCxMdw0XBKmx6X+sEuWYJ/Ti73/QaA9HqVEBvz6otzM6l+FUIv5+QwoAUpR5KIQq4YnSbAhu/ghh5qBnapwGs6J1RJgzgAblhpJjq4oaHh0MXxKj13yvS62KaaHl7aXIRWOoL4rEUVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m+h+PhCG; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43cec5cd73bso16130825e9.3
        for <bpf@vger.kernel.org>; Fri, 09 May 2025 11:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746816496; x=1747421296; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rlnHImP46LdnLqhAnSyQ5VZnClzAiVuHg2ziQWLzqlg=;
        b=m+h+PhCGkMRD2tHti1s+KxBB67RPb0chnoeqkb/8FrEk1RT4rwYJmlWTPLJs6SAsyZ
         U7vxLf5DHBO401BP+98cFqMfK7OLEUQD23432lf2bWOazF39u/jSeNkk0AFBQRJApNiZ
         NAh+zOytrOLxHcE3aXVeAmlpSjLdOAY6B++DUO8U55zDkIDcvAtuRa9t/PXsiz5PgooU
         VWmvtZ60UEPhl6nP41ZeMhZ3Byd/MwlKimElIlM8b8GbRvRB+9UP0E71NxqKXduZJo2z
         bB6wO24y5lOC9/0PsRtS8cAdgb44J+OwOK6TpNxb1TxBJOmVraEA6+WMTkYvv2mwdXkr
         z6Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746816496; x=1747421296;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rlnHImP46LdnLqhAnSyQ5VZnClzAiVuHg2ziQWLzqlg=;
        b=UdaiQ2mcBd7kwl1RCn5NsKuRmSzul/OKWVAE0tdJ09IkGdRWHnsTNwyK3T89rZtW2D
         PxYolMCOLJDZmYXSZjV8eAadmUWPSeiBqvXUd3GD3SgtuIpfOmziQZdA/9DtsjLOiPpI
         /O3TkxfEpj0yuEsJOUzWSyAv6m1EnZnQwLlX4TrPZW2WjNpwTM38abf5AmWjChcOsZEy
         jSGo53JslXv7RCm6m197W1EYDITIrutOfmaUY9Smlhuv8tIycogggrlvKhU/ViGXsPeo
         ZnCUz/XgpCHi7dYK226Jy1MDdaMSuGvRr0FO3hqBMqKcIHzEiOtx+jpdHZZGtJv+xoaV
         zAeQ==
X-Forwarded-Encrypted: i=1; AJvYcCWPvx260qDIxyr2K6L8fMdBMyFKSH8wAd2p8MAg01/RJ9Mf/4UnWcGl9/CLmMlQBjSouuY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8Ut2qUmTFntf6Z8WaTZ5EKAwWNg1iUkLKgn8UVRgieU05zBle
	zUVl84FEwjlySjbzUO3SQoU4uju33u7tb6CGrCwEbsoqv+bQ+RsumTHZqJlYAgPaF1jTE81MeO+
	OcTWWb0PwUVHwNvHsWlXBFGLhGX8=
X-Gm-Gg: ASbGnctOdVQXCCdhyraGqgbjHlqXy5fPTBxahdSMXjpWajlXQ9yy/DU/q0kH3yKI+AB
	he2ASrjsrLyi6nbfJr5RG6mLpW0OiwUsn35X7jvvoT0NuagSFb1boypudVBaj031xpErqmG4/yT
	wx5K2KuDDcfCN/G/6qY3X6Hn1aKK/fh3VPsg4lcBN2Re6b5O25
X-Google-Smtp-Source: AGHT+IGrfPuImL8lmWL1UK0rwANYSKNzP70yb6icHiktjW2Qv3MWXUY+vuBjxWA8eXcsRrv+FuqfLXlpox7XYRACm7U=
X-Received: by 2002:a05:6000:2502:b0:3a0:ad55:ca0c with SMTP id
 ffacd0b85a97d-3a1f6427adfmr3834824f8f.1.1746816495822; Fri, 09 May 2025
 11:48:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250507171720.1958296-1-memxor@gmail.com> <20250507171720.1958296-11-memxor@gmail.com>
 <04332abfa1e08376c10c2830373638d545fba180.camel@gmail.com>
 <CAADnVQKN2S=yb_7NUO8bsu+7CxnaGyTML6gKcPS61EnCZtvG5g@mail.gmail.com> <9f417b403ef541af5bc8497897e4fbf88bd4023f.camel@gmail.com>
In-Reply-To: <9f417b403ef541af5bc8497897e4fbf88bd4023f.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 9 May 2025 11:48:04 -0700
X-Gm-Features: AX0GCFvSaEBVyItbz-00zpGx71Cn9uA8o3Oz5HrBndUOxMAB_OMiFysfuR_0BbQ
Message-ID: <CAADnVQLOjzmhf1d81Nr9n0zXL1hj7CGeG5_8BySuNY0HxYanSg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 10/11] bpftool: Add support for dumping streams
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Quentin Monnet <qmo@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Barret Rhoden <brho@google.com>, 
	Matt Bobrowski <mattbobrowski@google.com>, kkd@meta.com, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 9, 2025 at 11:31=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Fri, 2025-05-09 at 10:31 -0700, Alexei Starovoitov wrote:
>
> [...]
>
> > How about we extend BPF_OBJ_GET_INFO_BY_FD to return stream data?
> > Or add a new command ?
>
> You mean like this:
>
> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bp=
f.h
> index 71d5ac83cf5d..25ac28d11af5 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -6610,6 +6610,10 @@ struct bpf_prog_info {
>         __u32 verified_insns;
>         __u32 attach_btf_obj_id;
>         __u32 attach_btf_id;
> +       __u32 stdout_len; /* length of the buffer passed in 'stdout' */
> +       __u32 stderr_len; /* length of the buffer passed in 'stderr' */
> +       __aligned_u64 stdout;
> +       __aligned_u64 stderr;
>  } __attribute__((aligned(8)));
>
> And return -EAGAIN if there is more data to read?

Exactly.
The only concern that all other __aligned_u64 will probably be zero,
but kernel will still fill in all other non-pointer fields and
that information will be re-populated again and again,
so new command might be cleaner.

> Imo, having this in syscall is more convenient for the end users.
>
> Alternatively, are files in bpffs considered to be stable API?
> E.g. having something like /sys/fs/bpf/<prog-id>/std{err,out} .

yeah. Ideally the user would just 'cat /sys/.../stdout',
but we don't auto create pseudo files when progs are loaded.
Maybe we should.
'bpftool prog show' will become 'ls' in some directory.

