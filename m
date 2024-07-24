Return-Path: <bpf+bounces-35470-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6919A93ABB9
	for <lists+bpf@lfdr.de>; Wed, 24 Jul 2024 06:06:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F592283D98
	for <lists+bpf@lfdr.de>; Wed, 24 Jul 2024 04:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DF101CAB8;
	Wed, 24 Jul 2024 04:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CNkwS7tR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408E910F4
	for <bpf@vger.kernel.org>; Wed, 24 Jul 2024 04:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721794001; cv=none; b=OEOpTOxtxLycte65TbVUM0Jv4QK6Zge7tWGIWeGjFEu+KB+vuHSzPAK88VU8vabEirOaoj+MoNHjEyw/gPsOEXqUeXor/kHYBP60Poyxfc6qreUsqbaREHOcaSd0wSe3jHjx9lO/tTg71ukeTX9UGBJZaPqY/v+PBDRMIlwIo2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721794001; c=relaxed/simple;
	bh=7llLNpU6EA2+g0tJRBSCO2uhVoj1EuwUfhqMgfbeJ3s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fJeBnoHLyQsf1qV2vz6zEw8d5oS53f/PguRkVTChe/dISLYImbjLjqwqyuZZ8RaVpJLEnZ8X/MY7sjNzOrOfjmhWrRoqcfPK2uIrbhzNW9IRvXPd0//VT29Cw2svHn8g3yo6gSxp4ThpkKJYAPpo/B0kPXnZM5UN8PQAMcVICWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CNkwS7tR; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-78aeee1068aso991683a12.2
        for <bpf@vger.kernel.org>; Tue, 23 Jul 2024 21:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721793999; x=1722398799; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=icEtrnI+1NpmMdVL0fXr0dqFJ26szCemzOjx1V6a3CE=;
        b=CNkwS7tRuiuCNDkh8dH+KHKFCCMDya8ByWXofS7S29XrtBYO9RnrD5Wkru+DVoVuZQ
         oTlprVLvSFWGjKXgZQdz4aSPDkPYcNYbETEvf42pQbG7b+M8ztut+ZUd/pPfVT2/aCnC
         sV+FihbQEAbwUAxg/qDrVItvpd8IgEiKNBjxJ6HFpyFdvw06wcClb+ZivcpbR282/44N
         sm/U1D2KWQzZ5390a/nLoDYmB/cMjB0RaX5IJzgfdXNDdkxDt4Ltrh9PGxkTVClueDIM
         z75ddnAJl6QWh05OkYkov301t0mcWJv+qLYnBDQnEYZlzAQUCjjCcPwAZLcvZK6777VC
         NYew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721793999; x=1722398799;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=icEtrnI+1NpmMdVL0fXr0dqFJ26szCemzOjx1V6a3CE=;
        b=QZd6Ho4KzhkSJhjeV2DYyHUGLNru5m/0lnwCc0mLq5fJtG5IE9S5vg8j0I7uxVh2gE
         5OHYwaPQIDQjkU9kSuhnlSjMm1FCYt/Jrk0A2MhnXzKKD2pIThJjUuCaIx9f4r8DT1BY
         +VJTjPIH6XW98e6nDVuekbj7gXFmPLt2FMzSreLB6/LDbnwg4MwiGEM5aYaSsgD8Hoi2
         mWgBJzvBZIL700QNygWv5h403ZOmn0uwO8wMgGLnAsXITKW0axYvNN6OLIk/CeTkKXXa
         Ju1fHnvyDMB56+eMxg6KyERjwxuUvUCXcXWRbEKtLv12T9Sxsd0jIuQNQ76+h9DWr5oL
         Vj3A==
X-Forwarded-Encrypted: i=1; AJvYcCViSdg6Dej8wJRCGtUrWJDDlVt5L/IvJF6yAb7GEpwgkaNq3NFUajEWuzlYRWTdKhmftDQSlJbIGHCOMxuhNrekGfA8
X-Gm-Message-State: AOJu0YzDcyOq/yy0Il1mX4i6AZ7vIJWnhYI7/GT7h8zKf9kwJ2cKvj0q
	6n4doE9LwkhxMU9HkmmQflOVzFRbmaJkxr0//igO2fcpU4J31ReiMnxuKnc3oVmgl5LaxuapCSp
	rdrKk0DQSvhr+zAQSUJapcBtyMwE=
X-Google-Smtp-Source: AGHT+IH6skSMYrvUpKhIa4MtViYT7srDv4akhcs+tB0JjQ1AGfaNbsqM/TFKc8LH1CQelxCnKGRvCX5ILaqKJAR/hGE=
X-Received: by 2002:a17:90a:c17:b0:2cd:2c4d:9345 with SMTP id
 98e67ed59e1d1-2cdb5120b02mr1127892a91.6.1721793999275; Tue, 23 Jul 2024
 21:06:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240718205158.3651529-1-yonghong.song@linux.dev>
 <CAEf4BzZUT9fWZrcXN-HVM=ce6thNBCL2RrZ3sTsdMkTzmk=gwQ@mail.gmail.com>
 <CAEf4BzYktUDhfASrD0dhyBWUH4QkoRksX7JacYQ9bhC0H9gesw@mail.gmail.com>
 <CAADnVQJDE24HQD7KYRRu1Nsz9965op=62dhx7HqW2QZRzHGBKQ@mail.gmail.com>
 <CAEf4BzbC0vORHOgKhrh6UAog227u+5x9Wpgp0D3aduka=gN4pg@mail.gmail.com> <CAADnVQKXujv9+zf5fbL0cXkxRrFct=JAEjCsr3+FvpArTmcQTQ@mail.gmail.com>
In-Reply-To: <CAADnVQKXujv9+zf5fbL0cXkxRrFct=JAEjCsr3+FvpArTmcQTQ@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 23 Jul 2024 21:06:27 -0700
Message-ID: <CAEf4BzbtBDeVeFntNznFBSXMxZOgQj7v4-EzRVsNkEj0A-uxgg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Support private stack for bpf progs
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Kernel Team <kernel-team@fb.com>, 
	Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 23, 2024 at 8:17=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Jul 22, 2024 at 8:27=E2=80=AFPM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > > > We *need to support recursion* is my main point.
> > >
> > > Not quite.
> > > It's not a recursion. The stack collapsed/gone/wiped out before tail_=
call.
> >
> > Only of subprog(), not of handle_tp(). See all those "ENTRY - AFTER"
> > messages. We do return to all the nested handle_tp() calls and
> > continue just fine.
> >
> > I put the log into [0] for a bit easier visual inspection.
> >
> >   [0] https://gist.github.com/anakryiko/6ccdfc62188f8ad4991641fb637d954=
c
>
> Argh. So the pathological prog can consume 512*33 of stack.
> We have to reject it somehow in the verifier or tailor private stack
> to support it. Then private stack will be a feature and a fix for this is=
sue.
> But then it would need to preallocate 512*33 per cpu per program.
> Which is too much.
> Maybe we can preallocate _aligned_ 512 or 1k per cpu per prog,
> then adjust r9 before call or tail_call and if r9 is about to cross
> alignment before tail_call fail the tail call (like tail call cnt was
> over limit).

This is close to what I proposed to Yonghong offline. One approach I
had in mind was as follows. If we know that a BPF program can do a
tail call, then allocate some larger private stack (1KB, 4KB, 8KB,
don't know), compared what the BPF program itself would need. Then in
bpf_tail_call() helper's inlining itself check whether R9 +
<max_prog_stack_size> is larger than the private stack's size. And if
yes, then don't do tail call (as if we reached max number of tail
calls). Tail call interface allows for that.

This way we don't slow down typical non-tail call cases and don't pay
unnecessary memory price, but we still make tail call work just fine
in most cases, except some pathological ones like my example. I think
the expected situation for tail call is to replace main program with
another main program, so the typical case will work perfectly fine.

> Hopefully there are better ideas, since it's all quite messy.

