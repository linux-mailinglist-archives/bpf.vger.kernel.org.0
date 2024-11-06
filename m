Return-Path: <bpf+bounces-44131-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B30449BF195
	for <lists+bpf@lfdr.de>; Wed,  6 Nov 2024 16:26:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D66851C218AB
	for <lists+bpf@lfdr.de>; Wed,  6 Nov 2024 15:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08EE5203709;
	Wed,  6 Nov 2024 15:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jpGkGJhQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75192036ED
	for <bpf@vger.kernel.org>; Wed,  6 Nov 2024 15:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730906779; cv=none; b=tjIAOHpvRQXtXPteRltp5CbYjEIRNZa56+NScLlSWfHkE4zETXJ5ex56nPDngWeA259nlidjBR9V3LbpBvS9IMjVW5Yax71Bm3mFUFDozSGouCOCF6Afo4KsZuXzMBy+E8IAMhQv4lZRlZY2yMORvprJM1466q+SPBrd8lJWCpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730906779; c=relaxed/simple;
	bh=72m4P9XQBsPHrSVBPZ2coUA5Dl/HSVI7GYTs9fq3rFU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fHv9OhZCXxveMlWtIElY7E95oY76gMhu1GrmjEyc6iJ8px6Z82JxkBDC4u7xEUy29boQoWIgN+QCsWVYXY/srZ4rIK3wLTnASjZ4nZvS+yQ6stUb1Dyc6dqSybRl2v3OVTOgewmXfICZRqmxupWCkOuDJ5DAW7Kt92r8ezvPuLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jpGkGJhQ; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4319399a411so58255285e9.2
        for <bpf@vger.kernel.org>; Wed, 06 Nov 2024 07:26:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730906776; x=1731511576; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EmcYFjqsavGFVgnxENx05kYnDua8JfOyAgo1z8SPk5w=;
        b=jpGkGJhQBkgs8xRFASn9+4eEnsBa4ni0Oe5FxahciMl/bB1Yb1BrpY05IaDTd//pfb
         gK0dXnrWTFhhzpj559mpZ6BAuizN8/kWncTYxAw5GC9Z+mtFK4UZzRTSOwSKtgm78eDh
         aqp0Efr0D5CDZ6yzI0lObUzPA0tlkTm+Y8sGZUVVQbIamANzPnswL3dWs5U3EfUz+Wgm
         mZDN79UxgWGwxgcOMd10oPQR/SVft+SF6DjrmoeSbcU5rHverp0wj9YzcPcwLKm+AV89
         XxJ7+29DtTjtcIdyzvNsj3L/QUGGhpbXWPtFLBjFquOtutvWm9LNe20dBQp/kdcHRS35
         fn3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730906776; x=1731511576;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EmcYFjqsavGFVgnxENx05kYnDua8JfOyAgo1z8SPk5w=;
        b=w7sQ4IVdkH/rCTk0xXb/xNpNlYhuza8QlDtvZ3c24pKniuaYLBZUtuqUO3fYTDpi9o
         FyBIEpUrZTYR46LR0vNC0H+35o8P6CPnyojb2VK704Mli/H1WEGH6OdWxi7K+dJI+cU8
         Ot9bfTHNo5FEEMVuJWVfoiOp6NXdhgT+X6I4wsHsqQCa/8P2L5mvmsEabFVDvZYOWznr
         WwoZnlqFL1k//sktqqse4hJdtCeJf1N/APQonwgv2OL+ix7qGssDFfuiwRtBQUu5gsFE
         ZO00vR6+wB2wD9SmYZVDZQ5g3hHpCLSEqmujPhZLVSqC6sq0HcVoGAe/r8dQOpLg4Ybd
         kNAw==
X-Gm-Message-State: AOJu0Yw3X7AJKVXVxumSZKft1XAf3W/uEx3ZC5kjdacr0X/LAyzgtFoD
	yTxmVcSw1VNML/94wwP7nAVh7caqjyZVs0rjL4RKMv/iB7qyh7zNsaZpWj2PaAvXxP9aJqEL+rx
	69+P0fnpe/NbPHVC1iZf8//b85Pw=
X-Google-Smtp-Source: AGHT+IHqogHoVgmcT3AmHw1D+WZ3LBRzsgw6FkK1lofvA0ZrJ9w0tCFvb8BBqHcX+QRECho42973ZrJk61i3Fd7PZ3o=
X-Received: by 2002:a05:600c:458e:b0:42c:baf9:bee7 with SMTP id
 5b1f17b1804b1-4328250f211mr206394875e9.12.1730906775871; Wed, 06 Nov 2024
 07:26:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241104193455.3241859-1-yonghong.song@linux.dev>
 <20241104193515.3243315-1-yonghong.song@linux.dev> <CAADnVQL3MkDgZykq1H3NhJio8gZDnf3+kXXw7AQ36uT8yw5UfQ@mail.gmail.com>
 <a34f5be8-8cf9-4659-badd-32c387cefe29@linux.dev> <CAADnVQJzV_eRaNMzYP5Fj-FsSNx7-1-f0yXjtXSpeOqr9tBVAg@mail.gmail.com>
 <c00685dc-c51b-4058-8373-93b01443143d@linux.dev> <CAADnVQ+PsQpo-aFhUJhUaOSJSPX7A9ffmTVFtc96xLLCrtSBsg@mail.gmail.com>
 <a95f0953-1901-471f-8313-dac03efef9e2@linux.dev> <CAADnVQ+ohxtXEc8WufQoJQByRFMSD9427X_dsKWQFBv9dGzveA@mail.gmail.com>
 <97aa51b0-5c12-4f5b-bd35-5abfcee9a715@linux.dev>
In-Reply-To: <97aa51b0-5c12-4f5b-bd35-5abfcee9a715@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 6 Nov 2024 07:26:03 -0800
Message-ID: <CAADnVQJN7O_EGAArH_DpcLgGzZZOe21_MKVOFCi_OaBHbt8r4g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v9 04/10] bpf: Check potential private stack
 recursion for progs with async callback
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>, Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 5, 2024 at 10:55=E2=80=AFPM Yonghong Song <yonghong.song@linux.=
dev> wrote:
>
>
>
>
> On 11/5/24 5:07 PM, Alexei Starovoitov wrote:
> > On Tue, Nov 5, 2024 at 4:19=E2=80=AFPM Yonghong Song <yonghong.song@lin=
ux.dev> wrote:
> >>
> >>
> >>
> >> On 11/5/24 1:52 PM, Alexei Starovoitov wrote:
> >>> On Tue, Nov 5, 2024 at 1:26=E2=80=AFPM Yonghong Song <yonghong.song@l=
inux.dev> wrote:
> >>>>> I see. I think it works, but feels complicated.
> >>>>> It feels it should be possible to do without extra flags. Like
> >>>>> check_max_stack_depth_subprog() will know whether it was called
> >>>>> to verify async_cb or not.
> >>>>> So it's just a matter of adding single 'if' to it:
> >>>>> if (subprog[idx].use_priv_stack && checking_async_cb)
> >>>>>       /* reset to false due to potential recursion */
> >>>>>       subprog[idx].use_priv_stack =3D false;
> >>>>>
> >>>>> check_max_stack_depth() starts with i=3D=3D0,
> >>>>> so reachable and eligible subprogs will be marked with use_priv_sta=
ck.
> >>>>> Then check_max_stack_depth_subprog() will be called again
> >>>>> to verify async. If it sees the mark it's a bad case.
> >>>>> what am I missing?
> >>>> First I think we still want to mark some subprogs in async tree
> >>>> to use private stack, right? If this is the case, then let us see
> >>>> the following examle:
> >>>>
> >>>> main_prog:
> >>>>       sub1: use_priv_stack =3D true
> >>>>       sub2" use_priv_stack =3D true
> >>>>
> >>>> async: /* calling sub1 twice */
> >>>>       sub1
> >>>>         <=3D=3D=3D we do
> >>>>                if (subprog[idx].use_priv_stack && checking_async_cb)
> >>>>                    subprog[idx].use_priv_stack =3D false;
> >>>>       sub1
> >>>>         <=3D=3D=3D here we have subprog[idx].use_priv_stack =3D fals=
e;
> >>>>              we could mark use_priv_stack =3D true again here
> >>>>              since logic didn't keep track of sub1 has been
> >>>>              visited before.
> >>> This case needs a sticky state to solve.
> >>> Instead of bool use_priv_stack it can be tri-state:
> >>> no_priv_stack
> >>> priv_stack_unknown <- start state
> >>> priv_stack_maybe
> >>>
> >>> main_prog pass will set it to priv_stack_maybe
> >>> while async pass will clear it to no_priv_stack
> >>> and it cannot be bumped up.
> >> The tri-state may not work. For example,
> >>
> >> main_prog:
> >>      call sub1
> >>      call sub2
> >>      call sub1
> > sub1 cannot be called nested like this.
> > I think we discussed it already.
> >
> >>      call sub3
> >>
> >> async:
> >>      call sub4 =3D=3D> UNKNOWN -> MAYBE
> >>      call sub3
> >>      call sub4 =3D=3D> MAYBE -> NO_PRIV_STACK?
> >>
> >> For sub4 in async which is called twice, for the second sub4 call,
> >> it is not clear whether UNKNOWN->MAYBE transition happens in
> >> main_prog or async. So based on transition prototol,
> >> second sub4 call will transition to NO_PRIV_STACK which is not
> >> what we want.
> > I see. Good point.
> >
> >> So I think we still need a separate bit in bpf_subprog_info to
> >> accumulate information for main_prog tree or any async tree.
> > This is getting quite convoluted. To support priv stack
> > in multiple async cb-s we may need to remember async cb id or something=
.
> > I say let's force all subprogs in async cb to use normal stack.
>
> I did a quick prototype. Among others, tri-state (UNKNOWN, NO, ADAPTIVE)
> and reverse traversing subprogs like below diff --git
> a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c index
> cb82254484ff..1084432dbe83 100644 --- a/kernel/bpf/verifier.c +++
> b/kernel/bpf/verifier.c @@ -6192,7 +6192,7 @@ static int
> check_max_stack_depth(struct bpf_verifier_env *env) struct
> bpf_subprog_info *si =3D env->subprog_info; int ret; - for (int i =3D 0; =
i <
> env->subprog_cnt; i++) { + for (int i =3D env->subprog_cnt - 1; i >=3D 0;
> i--) { if (i && !si[i].is_async_cb) continue; works correctly.
> Basically, all async_cb touched subprogs are marked as 'NO'. Finally for
> main prog tree, UNKNOWN subprog will convert to ADAPTIVE if >=3D stack
> size threshold. Stack size checking can also be done properly for
> async_cb tree and main prog tree.

Your emailer still spits out garbage :(
but I think I got the idea. Will wait for respin.

