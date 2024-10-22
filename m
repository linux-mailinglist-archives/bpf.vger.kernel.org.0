Return-Path: <bpf+bounces-42839-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B8E09AB929
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 23:58:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D607283954
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 21:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55C561CC150;
	Tue, 22 Oct 2024 21:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cuf1RIkP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F6A4126C05
	for <bpf@vger.kernel.org>; Tue, 22 Oct 2024 21:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729634281; cv=none; b=q0Uf72ChPAMj+lc0SeztxoR+arfU74uqRaJW49YkIxNH6+ug/LF49B2pT7DJjuSguwKxdl1OP0gQ16bD/CNxeUpbvtgdPCFGgtna44+TIwGkXaQtald7kabBZwo8h4OvgxK1BDxzJb07lPMW1AhOnm4BzjwIvZYfrl0n9BU0SBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729634281; c=relaxed/simple;
	bh=AKKV4ds6tAkUVC9tNVhsIITo8upL1leif/H14QlOweI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vAA+LReKkhaEta1a5N+Tc4xjFBxXYVeg+1A3RZGeoYqyDoTPr2KvmaIO2ZKwEELxsXUmkGfBz/AhciX7OWBMH0KUwhjb1oCkpVvHyFn3rKqOy1juYqfRWLjisYlgA+2NKm28jY+6jgzFIppIInXqkpdQDzOE2+DI9e+HtPUqbJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cuf1RIkP; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43168d9c6c9so41390205e9.3
        for <bpf@vger.kernel.org>; Tue, 22 Oct 2024 14:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729634278; x=1730239078; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qya2zhOp37CxZhsjqfhG7diN8d5Rd50lvyhmHgKoEVI=;
        b=cuf1RIkPdH0Wux0WwBo9pKVaOX2bIDsUxsmsz7HXCRUKVPOE/W/qSVCxf4vYvGtmeJ
         zLR4v8fcJk2cWFrkz8QSS5V7zlSDw8FvubArGzXt/pzGvF8G9fLfJ+Jyzt2Iv3W0jcwx
         6J2VZjEvfrb+9sVUK1FY8RGnRxbbHa+piOLQCAIScwvFc+3J7x/+aoi4z/vBc20GhSbU
         +skg/DJLCZrotlWEER8AiImOE77mRcUX+TcWLmISV/VgMwDFtwIjjXDj1ImENE4c8bpf
         enqRoounvxIsjkOzdF9a2kk94Uv+nFmQIi3CKN0JfG48wfA0Rfr8gKVevL+NYhALcv8Z
         B+mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729634278; x=1730239078;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qya2zhOp37CxZhsjqfhG7diN8d5Rd50lvyhmHgKoEVI=;
        b=UEY9DfHPUGXP5Ds5vFglcx8sei8IJPQT6JSkIfByvuikxS0rlUikvaE7tRp7bb01M4
         eqM43bcW35jzhWXMYxAoBKDYsSH+DmiHz4WDHpRYOHGA/VIs2/aht4ZAlhxEUyVo4YjH
         bq6DiuxZrah1rFqvRqnWOTesb7ZPIc527ZQs0HK07K57Nejx/ClDL2HTiL1mFWNj0q6E
         wGMfPlRplauUi2lMfS37LGIKGnMq1cGQV98VdaF/v8qCojXDcpUDCavWQfVp+aqE4Wbh
         bzYkJ1PDkn2Qbvku1cQBLACN/DqeQVuyzq904Yb0NTZGFOvMidHUbaVSrBXSkH42yGR0
         nDxw==
X-Gm-Message-State: AOJu0YyVpeJF9zZiD/6Tomw1KpPr9lQUUSbGr1FS2STcoLFhVCCxBKKH
	SXqtny+PlonbLp8IpeRSiG4FUGpGyhNjCYxEDTEcrzaNp9HK8QN3ME1v3/iZ6dBRNJX3Hftu2S8
	NdYiNyXxWHsn2hFEBExQu0MsBwGasLRt7
X-Google-Smtp-Source: AGHT+IF+yTKOFjzhqoMFpZT3SBSHHTztjzQPRXLQkUSs4+drBjxJBSKZB3lH35X+p0OeK8e8NM5OwEumNeNS1VvWG90=
X-Received: by 2002:a5d:4e12:0:b0:37d:50f8:a7f4 with SMTP id
 ffacd0b85a97d-37efcf933f7mr239213f8f.52.1729634277921; Tue, 22 Oct 2024
 14:57:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241020191341.2104841-1-yonghong.song@linux.dev>
 <20241020191347.2105090-1-yonghong.song@linux.dev> <CAADnVQ+ZXMh_QKy0nd-n7my1SETroockPjpVVJOAWsE3tB_5sg@mail.gmail.com>
 <c6e5040b-9558-481f-b1fc-f77dc9ce90c1@linux.dev> <CAADnVQJCfiNEgrvf6GuaUadz6rDSNU6QB3grpOfk2-jQP6is4Q@mail.gmail.com>
 <179d5f87-4c70-438b-9809-cc05dffc13de@linux.dev> <CAADnVQL3+o7xV2LQcO-AArBmSEV=CQ7TQsuzBfTUnc_g+MhoMw@mail.gmail.com>
 <489b0524-49bc-4df4-8744-1badd40824be@linux.dev>
In-Reply-To: <489b0524-49bc-4df4-8744-1badd40824be@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 22 Oct 2024 14:57:46 -0700
Message-ID: <CAADnVQJJxyoLvFY88OEGzy0MUnL5O8KCMdedDdAvqYcWDJsDXw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 1/9] bpf: Allow each subprog having stack size
 of 512 bytes
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>, Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 22, 2024 at 2:43=E2=80=AFPM Yonghong Song <yonghong.song@linux.=
dev> wrote:
>
> To handle a subprog may be used in more than one
> subtree (subprog 0 tree or async tree), I need to
> add a 'visited' field to bpf_subprog_info.
> I think this should work.

This is getting quite complicated.

But looks like we have even bigger problem:

SEC("lsm/...")
int BPF_PROG(...)
{
  volatile char buf[..];
  buf[..] =3D
}

The approach to have per-prog per-cpu priv stack
doesn't work for the above.
Sleepable and non-sleepable LSM progs are preemptible.
Multiple tasks can be running the same program on the same cpu
preempting each other.
The priv stack of this prog will be corrupted.

Maybe it won't be an issue for sched-ext prog
attached to a cgroup, but it feels fragile for bpf infra
to rely on implementation detail of another subsystem.
We probably need to go back to the drawing board.

