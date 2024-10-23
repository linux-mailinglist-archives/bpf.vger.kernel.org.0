Return-Path: <bpf+bounces-42916-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BB2F9ACFB5
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 18:04:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 295321F22909
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 16:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC4361CBE93;
	Wed, 23 Oct 2024 16:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eb1II1cZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBCCB4436E
	for <bpf@vger.kernel.org>; Wed, 23 Oct 2024 16:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729699459; cv=none; b=IV9YqCvnaSEBrnXVFFtd+C2206Zxy6VSHKykP7i0R2D2WsDnY2Li8tUft2SNT3L9yYjQgqwFL5Y83RXvUh5NqymikB7jJ1rgmDD7Bfe5Qh2Pehrr/RVaTPhzAtRur3evGdyX/zK7snouVZ/eT8Jim8zlQ6h/NiBFs2hkmdMrXmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729699459; c=relaxed/simple;
	bh=YpzpLk6dZic2l3yhT0+ePugdDCoFGouR91rC501Hs6Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SLFKykacori0EbsKpDxZEleWq2nxKC/95NW+WiTgytf+WCsvJE2cza/9gkFE2rWZ6r2PmoIDmOaPv9kgS+ct/dzdh4BJEubdo9Qqjccqr6uNW0Ojw4FhbuQWQjmOoMCPa1Uw29n18PV8TYl8QM6T0cjA84aYV+8/MndoG6RY8NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Eb1II1cZ; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7ea8c4ce232so5872103a12.0
        for <bpf@vger.kernel.org>; Wed, 23 Oct 2024 09:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729699456; x=1730304256; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gA1TjFiONnRSSmOs06QSuY2W5YZG7YXSWDFGFZ2S3Cc=;
        b=Eb1II1cZclmnGMFa0twIo9+wv+TYg1qlcsXuUB52ejOL24LYf+M8ajxyUhB6VfQhDC
         emv4EpYDyiQXhqIz/A7MSyGczVsYMQXblQkC9yf88pNdR/wte1Fzr+3aLuwIiLZ9JZkF
         BH9B9Yb96Hmlt/G5x5oCJXatpRRX2HBGl5LiZzmmL/6HFt8Z8aR1VL5qJBKm+vnZz01L
         EM6ESPjJDZlZrBgbn2093sjLYviXDwJ85tM10xudd6LmvPJ3HkiYgx8DBkzlksptZyBO
         vezvHAcXUIfFTU5cKsyAXdVP4Z9/p3EYit73gY3kI2EQnHhCGe8UjcLe+dd7jp/VMem2
         4xUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729699456; x=1730304256;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gA1TjFiONnRSSmOs06QSuY2W5YZG7YXSWDFGFZ2S3Cc=;
        b=f7iDKTa1GjZiZxSfj1BbXPCtUEt5ex2DePLeK7h6CbCiETyZUDp0RlY94CfoLK4W+i
         MRFSiEhlUCJWU0+aCJRXk2Gf77ysq5q4Cj3xCs6hDYeajgZJEkZY4QLj0o/0TFyIKeP5
         O6JjIT9IUanD6vQqo8Hv1u//bGs1yzynMIDFLuKxoeeKtmVpr0AzZjvJ8DylFl5bAxG5
         plVj+mHj7hxbjq5Uu5mQFbQf4iHnmwTM0v32xcg2UJUZV64xh/F1b8t8AORCDiZZZBO4
         x4tvZv0SyGfhrBRKVF8x3cBFl3K9OcrTPiPNhgOjrOZUpQFMHcIRDKnzqSOTkID7PKex
         7bAw==
X-Forwarded-Encrypted: i=1; AJvYcCXduMrOrnhNH/ABbRASw63tTPp/fKvXNaOObdyzilFF6592yhH6R8qmDtI7F337y3LEJ/4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsGmDYkPkbnfVsjswsLtabnaiPia6Ap3FF6b0GUKthapGVtjbJ
	LcoM6Og3HuDGaHK+7udrlWjDuCXPom2JMlUJm20BQPB5K7w8wJZd+0jQiYhq4DERz3M/xft6KS9
	X/RBvJMHOsje/bhKGzRnwsrbEGPs=
X-Google-Smtp-Source: AGHT+IEDbHD/QAuSR2Q+0Oy7cmUaVAMQCmgUHr14j3yrhDRBljyF+0nPb54YLLidwqaYfC0pkf68lEd2RUCjcVYgHtM=
X-Received: by 2002:a05:6a20:d806:b0:1d9:21fb:d31c with SMTP id
 adf61e73a8af0-1d978b328c1mr3350405637.24.1729699454609; Wed, 23 Oct 2024
 09:04:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240404002640.1774210-1-andrii@kernel.org> <20240404002640.1774210-3-andrii@kernel.org>
 <jnasedlxo42dwibgynuwlccwql2ca7abdoz7ihnyccer3kdaj4@idpkucm7ohj5>
In-Reply-To: <jnasedlxo42dwibgynuwlccwql2ca7abdoz7ihnyccer3kdaj4@idpkucm7ohj5>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 23 Oct 2024 09:04:02 -0700
Message-ID: <CAEf4BzYJ+GZpoJ4aMCM09T8Zzrvq05kHrv=xS9NxL5smbqYPrg@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 2/2] bpf: inline bpf_get_branch_snapshot() helper
To: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@kernel.org, kernel-team@meta.com, 
	John Fastabend <john.fastabend@gmail.com>, Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 23, 2024 at 1:29=E2=80=AFAM Shung-Hsi Yu <shung-hsi.yu@suse.com=
> wrote:
>
> Hi Andrii,
>
> I was looking around in do_misc_fixups() and came across this
>
> ...
> > +                     new_prog =3D bpf_patch_insn_data(env, i + delta, =
insn_buf, cnt);
> > +                     if (!new_prog)
> > +                             return -ENOMEM;
> > +
> > +                     delta    +=3D cnt - 1;
> > +                     env->prog =3D prog =3D new_prog;
> > +                     insn      =3D new_prog->insnsi + i + delta;
> > +                     continue;
>
> Should the above be turned into "goto next_insn" like the others that
> were touched by commit 011832b97b31 "bpf: Introduce may_goto
> instruction"?
>

Yep, seems so, thanks for catching. I'll send a fix.

> > +             }
> > +
> >               /* Implement bpf_kptr_xchg inline */
> >               if (prog->jit_requested && BITS_PER_LONG =3D=3D 64 &&
> >                   insn->imm =3D=3D BPF_FUNC_kptr_xchg &&

