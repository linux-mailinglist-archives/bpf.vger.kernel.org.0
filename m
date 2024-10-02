Return-Path: <bpf+bounces-40730-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C61498CACF
	for <lists+bpf@lfdr.de>; Wed,  2 Oct 2024 03:26:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20F381F24909
	for <lists+bpf@lfdr.de>; Wed,  2 Oct 2024 01:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0603567D;
	Wed,  2 Oct 2024 01:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EnJ1/+IV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6B55227
	for <bpf@vger.kernel.org>; Wed,  2 Oct 2024 01:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727832400; cv=none; b=L4sTiQZNIg8EylWPFb0L3o6W7jbRND5gG6ywYym7G3dduC9Re3ytuBx4PMSkX+qKMHITuGrrNHKNwVqmc2Qs1hA3fXzaSNYbo3Q74eHUwfacjFpg/I05vPnIA8Z0+UePx1Gk6lgkPPoA3WD4r8iCJ7J5CLMfdA/ldLZwsci20y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727832400; c=relaxed/simple;
	bh=rhUGtUli9rFATAaV6LQyzHWKWxwkm75KNlla+51yEQ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ChJknpneK0ZvAOmDVxnFQJ+I0KID+Bs2rWS1RAvcKHsDWI0jPi4kgsMoj1G56yWMgSyFCSy7GS233fQKS0t7agnGa0YNf6DktUSdPah6zP2mOVmh/hN1RXgycwIievLcwMt/IOd1zv3k4poHuxr7cbsQdDZY0R2FONZxqa41WYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EnJ1/+IV; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-37cc4e718ecso4131875f8f.0
        for <bpf@vger.kernel.org>; Tue, 01 Oct 2024 18:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727832397; x=1728437197; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/2yQdV37RicR2e94C0fOAhHFcCMUyNQ9bVmMc/POWCM=;
        b=EnJ1/+IVw1qpsM65kdjLF3a6t3l48vgvf4lBHKc7X7f10ryqjtktcAlq/wi9PRCU1n
         GVvJBG9R1DJacbYN/vgrv9hoFk1uBX+XBu8WOrt2kBwy0X4D6sI+MrUxhm9tg/Vs1XSy
         fySWmQauOmuUekfBh9fFQzTC1Uahr6kk2nYrlk93VbyHEeU4nW/p7oECOU3HrXRxBF34
         KrSZDKJp/NslK4+TAPHWFnrtFfXihDwA4vrWVZC8MCSaZ+z3Szr7tjnwvzi4QaqbhB7R
         C4XLUzfcWHPhSHu9ns59xwjWL03srvfRX9PBZ3FqIyI61nAO70veKu9+OkT49MRCdVWV
         YsWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727832397; x=1728437197;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/2yQdV37RicR2e94C0fOAhHFcCMUyNQ9bVmMc/POWCM=;
        b=o51W6QIliu+PX9oK5MCcJRLa0ohCoumYZSK16joayu9+ITZcnlJmp2pTaUoxGs4aXN
         N1epe11L/EazinVLyJRrJE51EWo5QeooB6ehpbbCqSAZIHO9BMHTle4O79SPkdOxkWZb
         xRsku3QL2q5dHGs6/KlfbqhblN7E/21YHhqDLk/3NO3rG3WngUFcAMVp1pzy9uu+RBKC
         +z7AUV9BfQeUkQrumFKTa8NsiQ0Ruu4zmsQ95w5x/FipTLe9tDmJvzcvVebkw9YCExaL
         QzQX9lYdUulJO/NS6jkKyza/jcoaSxcjF5mrCCIUr+lZ8pjGiiGtZcElYu8jFlcumSfa
         OVfw==
X-Forwarded-Encrypted: i=1; AJvYcCXAwLn16sCZFuhuRPLe1jgUCO0XpnOoSWHv1X26GvZ0yws+tSPCTLruoyNXHp/gBPcJs/Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRM+66LAb1uzjGgKuy6285obaDOMexnVMaedenaH30G6hi6a/0
	vaj/5TBep1D2EqgjknA8QcmR5N+CHzU1qt6bHHmFTR6cMi+96rHQepB1iFce+SP11Ukdm+f+mCp
	N+uWZle0S4Nv2GJjsXUuS3sYwBoA=
X-Google-Smtp-Source: AGHT+IENnmOA+CyFW0kRM3aKyfowBnERUZgO7kQzeOy1LX/Ln2m2kaAgVbjoNNyVc4Zhl/ALq3bFE353eVDdsgSlHLg=
X-Received: by 2002:a05:6000:2ab:b0:371:8319:4dbd with SMTP id
 ffacd0b85a97d-37cfb8b9775mr1113206f8f.17.1727832396895; Tue, 01 Oct 2024
 18:26:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240926234506.1769256-1-yonghong.song@linux.dev>
 <20240926234526.1770736-1-yonghong.song@linux.dev> <CAADnVQ+v3u=9PEHQ0xJEf6wSRc2iR928Sc+6CULh390i3TDR=w@mail.gmail.com>
 <CAP01T77-bU5Ewu79QLJDTnt_E8h_VFHuABOD5=oct7_TC_yYGQ@mail.gmail.com>
 <CAP01T76UnVfn3x7zZH4vJgZMGv_Ygewxg=9gUA-xuOa7pwGr3A@mail.gmail.com>
 <CAADnVQ+caNh8+fgCj2XeZDrXniYif5Y+rw6vsMOojBO3Qwk+Nw@mail.gmail.com>
 <CAADnVQKLWi_TfpbiYb1vPMYMqPOPWPS-RGbB0FksEQW5i36poQ@mail.gmail.com>
 <CAP01T77q_H31mPXPQV4xHifutxxFeuoD8eg75C717MZ=OOeHew@mail.gmail.com>
 <CAADnVQLfWgpu6WvZRCFo39YHJ=zSSQWcOnaCOqdfyCg8uRoddg@mail.gmail.com> <CAP01T77G63MGvomrd3563bgBcNKUZg0Jc=GGmcGO0zPLS0hcHA@mail.gmail.com>
In-Reply-To: <CAP01T77G63MGvomrd3563bgBcNKUZg0Jc=GGmcGO0zPLS0hcHA@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 1 Oct 2024 18:26:25 -0700
Message-ID: <CAADnVQ+z-s07V_KU91+zGRB3qXGR9nr3w1dMBfCEEgunyes7EA@mail.gmail.com>
Subject: Re: yet another approach Was: [PATCH bpf-next v3 4/5] bpf, x86: Add
 jit support for private stack
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Kernel Team <kernel-team@fb.com>, 
	Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 1, 2024 at 5:23=E2=80=AFPM Kumar Kartikeya Dwivedi <memxor@gmai=
l.com> wrote:
>
> Makes sense, though will we have cases where hierarchical scheduling
> attaches the same prog at different points of the hierarchy?

I'm not sure anyone was asking for such a use case.

> Then the
> limit of 4 may not be enough (e.g. say with cgroup nested levels > 4).

Well, 4 was the number from TJ.

Anyway the proposed pseudo code:

__bpf_prog_enter_recur_limited()
{
  cnt =3D this_cpu_inc_return(*(prog->active));
  if (cnt > 4) {
     inc_miss
     return 0;
  }
 // pass cnt into bpf prog somehow, like %rdx ?
 // or re-read prog->active from prog
}


then in the prologue emit:

push rbp
mov rbp, rsp
if %rdx =3D=3D 1
   // main prog is called for the first time
   mov rsp, pcpu_priv_stack_top
else
   // 2+nd time main prog is called or 1+ time subprog
  sub rsp, stack_size
  if rsp < pcpu_priv_stack_bottom
    goto exit  // stack is too small, exit
fi

Since stack bottom/top are known at JIT time we can
generate reliable stack overflow checks.
Much better than guard pages and -fstack-protector.
The prog can alloc percpu
(stack size of main prog + subprogs + extra) * 4
and it likely will be enough.
If not, the stack protection will gently exit the prog
when the stack is too deep.
kfunc won't have such a check, so we need a buffer zone.
Can have a guard page too, but feels like overkill.

