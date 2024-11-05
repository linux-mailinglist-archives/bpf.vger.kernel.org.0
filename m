Return-Path: <bpf+bounces-44075-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF7269BD7D9
	for <lists+bpf@lfdr.de>; Tue,  5 Nov 2024 22:53:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E6072841F2
	for <lists+bpf@lfdr.de>; Tue,  5 Nov 2024 21:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 746C22161F6;
	Tue,  5 Nov 2024 21:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HhM26ZCB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5A51D5CEB
	for <bpf@vger.kernel.org>; Tue,  5 Nov 2024 21:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730843587; cv=none; b=VNQsVJvzfpA+E2FHTK11LbeVd8EBMYzPqCButJjNOu9lZPfduoX+/ckMh1bqn5mTOU9gsPl5PxglqONG6lZL70Zoib/viuEk7ihM+YTSCPY+4hHHDYES6mI+o69lgtzIwCodbVLttCX8Wy4JDoj1pFjxXMa00zZAaJ/o1QamAhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730843587; c=relaxed/simple;
	bh=NYFoKJOGistxVosEdS/hLW+AVP0y0eCwegy1KPa2TcA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lKoNGh9Zu/pyYGsiGpkgEh6tdSpFxOkNa6Iu+KWFSDqOcC+awWisLTfSO/pkkeIelSDo4rRJOVliMSNJzNS/GIgt6y/rg+AVoneKxHkT+AcOc3LpNTjsz8aD/qp6+K36EMfVaHBQKDYu1FDSJGgC4BuBJWIoLeGEorr0CkDffxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HhM26ZCB; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-37d533b5412so3543742f8f.2
        for <bpf@vger.kernel.org>; Tue, 05 Nov 2024 13:53:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730843583; x=1731448383; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nf1YrT3fkiZtgnuwR4Rq3XBRq6+gWSg10Ewu0BT8rzU=;
        b=HhM26ZCB0J+HMyKpCoXU5jv+ufT3Iayz6at+viE3wui+F/oIa/UJU+7PPzDxvDw0AS
         I9x5m9eMU664Up5xpO1W/W96DIm0qdIg486dz6WlEdr80qy+YpHjenIdjrYegThyOoKo
         oDbG58gwd/rHMzpTTWzGbzXAcr2TYJUyCjyGMG0laOD73MLCjCGBmliPv5q9HETrRWjR
         1l+KFHpdSiPAu8oABjt72OmoaywctB+MLoMtTttUaUUD+HY8PkBQU7KhLMZ7keS+i5ij
         P9KCqe08igfyHCHvNw6V96idxe23KcIrGuj+8EG52vBNH9bbBDi3qMHBlnmQR+hPVahV
         JA/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730843583; x=1731448383;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nf1YrT3fkiZtgnuwR4Rq3XBRq6+gWSg10Ewu0BT8rzU=;
        b=Jp/1DDSHpRdYjaEIBYA3OEKr7nkwB9lY0/eMbjTtxPGy5TZG9Gr9uMw4yrGQh3HYOC
         WsGDVtFf6dCbSB0LAg3Bhe1geAHxrZ4zKSnGoNqz6dA22gsHtmx7HSnheYU8Uuc8s2LC
         1BCnbD1LKZwv1zQN64Ier5HrZ7pwVP8qy0MxW3NI8SuW4+yLTpo5wO+NtolFLIIxKSlG
         hL4zo4iGeT1Qwoqqjg1C5FwATN3Ps4DYbdU4KUkKBb2ORO9oNrC7s4SJ5+kGF64EuYuB
         1STMp7C/GuBUa6nDnPz3y2UA9I9TSaF50iFYj4mBAWCWXn6Hs8KwIC5PZro20XsdJj2I
         aEnA==
X-Gm-Message-State: AOJu0YzPb1eQvdi2e2yUr46JrEiGBJZfAJXigW3peaZOBuAwdwk3wC2e
	NT/yu6cGn/SxkKxsXGqJnklcSL5eJaSjmtEDSZQbuO2OnJWOiEjtRSCebBWVib5q9AbFiC2tORO
	N/LUu2q1CI+1M1xK/VktrbvutdNw=
X-Google-Smtp-Source: AGHT+IHVGdo8ItlE43DEzoxicTadGvFxHjkmeQFOu29sHCqL0XggIXClAS1uFUI4W+hHbNFSS78w/C2mL8T3zo63oB4=
X-Received: by 2002:adf:eac9:0:b0:37d:4ebe:164c with SMTP id
 ffacd0b85a97d-38061200742mr27293477f8f.45.1730843583226; Tue, 05 Nov 2024
 13:53:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241104193455.3241859-1-yonghong.song@linux.dev>
 <20241104193515.3243315-1-yonghong.song@linux.dev> <CAADnVQL3MkDgZykq1H3NhJio8gZDnf3+kXXw7AQ36uT8yw5UfQ@mail.gmail.com>
 <a34f5be8-8cf9-4659-badd-32c387cefe29@linux.dev> <CAADnVQJzV_eRaNMzYP5Fj-FsSNx7-1-f0yXjtXSpeOqr9tBVAg@mail.gmail.com>
 <c00685dc-c51b-4058-8373-93b01443143d@linux.dev>
In-Reply-To: <c00685dc-c51b-4058-8373-93b01443143d@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 5 Nov 2024 13:52:52 -0800
Message-ID: <CAADnVQ+PsQpo-aFhUJhUaOSJSPX7A9ffmTVFtc96xLLCrtSBsg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v9 04/10] bpf: Check potential private stack
 recursion for progs with async callback
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>, Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 5, 2024 at 1:26=E2=80=AFPM Yonghong Song <yonghong.song@linux.d=
ev> wrote:
>
> > I see. I think it works, but feels complicated.
> > It feels it should be possible to do without extra flags. Like
> > check_max_stack_depth_subprog() will know whether it was called
> > to verify async_cb or not.
> > So it's just a matter of adding single 'if' to it:
> > if (subprog[idx].use_priv_stack && checking_async_cb)
> >     /* reset to false due to potential recursion */
> >     subprog[idx].use_priv_stack =3D false;
> >
> > check_max_stack_depth() starts with i=3D=3D0,
> > so reachable and eligible subprogs will be marked with use_priv_stack.
> > Then check_max_stack_depth_subprog() will be called again
> > to verify async. If it sees the mark it's a bad case.
> > what am I missing?
>
> First I think we still want to mark some subprogs in async tree
> to use private stack, right? If this is the case, then let us see
> the following examle:
>
> main_prog:
>     sub1: use_priv_stack =3D true
>     sub2" use_priv_stack =3D true
>
> async: /* calling sub1 twice */
>     sub1
>       <=3D=3D=3D we do
>              if (subprog[idx].use_priv_stack && checking_async_cb)
>                  subprog[idx].use_priv_stack =3D false;
>     sub1
>       <=3D=3D=3D here we have subprog[idx].use_priv_stack =3D false;
>            we could mark use_priv_stack =3D true again here
>            since logic didn't keep track of sub1 has been
>            visited before.

This case needs a sticky state to solve.
Instead of bool use_priv_stack it can be tri-state:
no_priv_stack
priv_stack_unknown <- start state
priv_stack_maybe

main_prog pass will set it to priv_stack_maybe
while async pass will clear it to no_priv_stack
and it cannot be bumped up.

> To solve the above issue, we need one visited bit in bpf_subprog_info.
> After finishing async tree, if for any subprog,
>    visited_bit && subprog[idx].use_priv_stack
> is true, we can mark subprog[idx].use_priv_stack =3D false
>
> So one visited bit is enough.
>
> More complicated case is two asyncs. For example:
>
> main_prog:
>    sub1
>    sub2
>
> async1:
>    sub3
>
> async2:
>    sub3
>
> If async1/sub3 and async2/sub3 can be nested, then we will
> need two visited bits as I have above.
> If async1/sub3 and async2/sub3 cannot be nested, then one
> visited bit should be enough, since we can traverse
> async1/async2 with 'visited' marking and then compare against
> main prog.
>
> So the question would be:
>    1. Is it possible that two async call backs may nest with
>       each other? I actually do not know the answer.

I think we have to assume that they can. Doing otherwise
would subject us to implementation details.
I think above tri-state approach works for two callbacks case too:
async1 will bump sub3 to priv_stack_maybe
while async2 will clear it to sticky no_priv_stack.

Ideally we reuse the same enum for this algorithm and for earlier
patches.

>    2. Do we want to allow subprogs in async tree to use private
>       stacks?

yes. when sched-ext requests priv stack it would want it everywhere.
I think the request_priv_stack should be treated as
PRIV_STACK_ADAPTIVE. Meaning that subprogs with stack_depth < 64
don't need to use it.
In other words struct_ops prog with request_priv_stack =3D=3D true
tells the verifier: add run-time recursion check at main prog entry,
otherwise treat it like fentry and pick priv stack vs normal
as the best for performance.

Then for both fentry and struct_ops w/request_priv_stack
the async callbacks will be considered for priv stack too and
will be cleared to normals stack when potential recursion via async
is detected.
I don't think it's an error for either prog type.
Overall we shouldn't treat struct_ops too special.
fentry progs with large stack are automatically candidates for priv stack.
struct_ops w/request_priv_stack are in the same category.

