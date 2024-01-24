Return-Path: <bpf+bounces-20276-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AA8383B3E3
	for <lists+bpf@lfdr.de>; Wed, 24 Jan 2024 22:27:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A69E1C234C3
	for <lists+bpf@lfdr.de>; Wed, 24 Jan 2024 21:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 718C51353EE;
	Wed, 24 Jan 2024 21:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZHbdblsJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E9B1353E4;
	Wed, 24 Jan 2024 21:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706131614; cv=none; b=ZpeMPVeYKSas37UCo63gchAgycPKu1ZN5nDj0ZogBr8xhTxfMgGi+XwGzMrVag+c/Z4i17GglXCWxiE1SCJXSkltvpJswndXEqDTktOz9jNnBZj3t8eHOMWuIOEgzHKmME87ETFYZXNuLuZbTQkQAKn+SLPsaGBet1rFp4bSHrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706131614; c=relaxed/simple;
	bh=H6YCWFpgFZL7NLFgdGThexdus+4Hedfg4t+SJwkh4MU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cyc3ukPDBQDMgrOwKqaimCiWIMTy2XJFcYHxxjdecW5EolEvc2dG/F5aZD3vDHPVCHmCuO76EU3ZUFEnFbGmwMIBxgh2y23YDn6zhiD5Pwrut7xgxa54JkJZ0xnUj2Qg+VeCNsUUfFWWAwN5v1qHNiy+GGV2vwuWXH27yPp3j6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZHbdblsJ; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-dc21d7a7042so5269755276.2;
        Wed, 24 Jan 2024 13:26:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706131611; x=1706736411; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tQb6eeyYQvtBbuj0NGUA9A2xXIeGznudwBN6pDUiWBA=;
        b=ZHbdblsJwoaYApuYu8K+MevFLycrTnRfl4KCMOPpiam+ml4uf9FhJpGXkAc0RoBe19
         IOxSyIn6m9G/r9APi63CSm2tPo/OmzxWk3KHpYtzDQJAd3HwhZmer7MF5je7Jhe5jd64
         T6DL/EmJK4hZSiN4LFRzLhiY9vJ4Y99F+gVbEcuxQQ9qOak2OMC4nDOwIQkxWAjLF0Cs
         L8U1ZurLlzOFBt3dpw1YTJzgQeQT79uXAs0OxxCFAjcJ5DIno+pgUb+HA/lh0bNxybdh
         4lotPL2V5dPEmaZuEvto6fLBrgO4xZlXaAMEVXL2SexCu7LgSCxXe6sIf9fxZtxjJF0b
         T3Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706131611; x=1706736411;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tQb6eeyYQvtBbuj0NGUA9A2xXIeGznudwBN6pDUiWBA=;
        b=mPKhmjuTBQNcGWZKpZuBt59mjeAYRQBvdbXxa1YNVWV+ztIJWq7hNjhCx6z/hs9miB
         dMAkV+XQXjq+1iTokaDhCN13xJotxtR8xRoohTRDwyEWhPNOB8in6PCSoN9wau0VC2Gb
         uKzAz5uegtjWftRin1F+VZDTjf3dGmIZOkY3AWeWk94/hTTCG9pRFVtDSFgKTYTFcZ9T
         9HGDQlCwSZ26us23rmTsamq1IWMvRIIFBUUe85rm7fIlQNNJohtEQ3hjgMmhkgjiAJoV
         hahA/aMm0gYuD+qScpqfUu3lQ/uhFrCwI8WEXLfyMSBsTd/h2MJqIJvFCNYAtqaegING
         rfJg==
X-Gm-Message-State: AOJu0YxHMTQtEWBb0p5VXfmSbc74UwrRSNIdmH22dgBS65eUkneiAYcU
	KuUhmjCaxYX823eJW4Ql93vLJ8lqP8QYTokiaWXOHrLaobTLrwAHkMdZQqS45x46Dmsev2rLuVM
	wffzksveHXOYa90LbO4sJWpFFgzE=
X-Google-Smtp-Source: AGHT+IFXKuNxBlarj3Q/b4HwehVL2pR53mgq3AFGwZou4mxBDnXxGeQlKAQ8it8PcEKTMDLsNf1Rj4fXpcR/MXpZzH4=
X-Received: by 2002:a5b:1cc:0:b0:dbe:9cee:7d11 with SMTP id
 f12-20020a5b01cc000000b00dbe9cee7d11mr8918ybp.59.1706131611224; Wed, 24 Jan
 2024 13:26:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1705432850.git.amery.hung@bytedance.com>
 <ZbAr_dWoRnjbvv04@google.com> <CAM0EoMkHZO9Mpz7JugN7+o95gqX8HBgAVK6R_jhRRYQ-D=QDFQ@mail.gmail.com>
 <44a35467-53cb-1031-df9d-0891d585db65@iogearbox.net> <CAM0EoMm45HX=zd1qMThugYRGA9bugM-OT9NPx++VWj_zYowDmQ@mail.gmail.com>
 <e6af0fe9-e7f0-40e7-bb80-143d99063db7@iogearbox.net>
In-Reply-To: <e6af0fe9-e7f0-40e7-bb80-143d99063db7@iogearbox.net>
From: Amery Hung <ameryhung@gmail.com>
Date: Wed, 24 Jan 2024 13:26:40 -0800
Message-ID: <CAMB2axPEO+JU36mhwp=-9FdsCsNRObbou6-YnMJnAr+A8PNwrA@mail.gmail.com>
Subject: Re: [RFC PATCH v7 0/8] net_sched: Introduce eBPF based Qdisc
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Stanislav Fomichev <sdf@google.com>, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, yangpeihao@sjtu.edu.cn, toke@redhat.com, 
	jiri@resnulli.us, xiyou.wangcong@gmail.com, yepeilin.cs@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 24, 2024 at 7:27=E2=80=AFAM Daniel Borkmann <daniel@iogearbox.n=
et> wrote:
>
> On 1/24/24 3:11 PM, Jamal Hadi Salim wrote:
> > On Wed, Jan 24, 2024 at 8:08=E2=80=AFAM Daniel Borkmann <daniel@iogearb=
ox.net> wrote:
> >> On 1/24/24 1:09 PM, Jamal Hadi Salim wrote:
> >>> On Tue, Jan 23, 2024 at 4:13=E2=80=AFPM Stanislav Fomichev <sdf@googl=
e.com> wrote:
> >>>> On 01/17, Amery Hung wrote:
> >>>>> Hi,
> >>>>>
> >>>>> I am continuing the work of ebpf-based Qdisc based on Cong=E2=80=99=
s previous
> >>>>> RFC. The followings are some use cases of eBPF Qdisc:
> >>>>>
> >>>>> 1. Allow customizing Qdiscs in an easier way. So that people don't
> >>>>>      have to write a complete Qdisc kernel module just to experimen=
t
> >>>>>      some new queuing theory.
> >>>>>
> >>>>> 2. Solve EDT's problem. EDT calcuates the "tokens" in clsact which
> >>>>>      is before enqueue, it is impossible to adjust those "tokens" a=
fter
> >>>>>      packets get dropped in enqueue. With eBPF Qdisc, it is easy to
> >>>>>      be solved with a shared map between clsact and sch_bpf.
> >>>>>
> >>>>> 3. Replace qevents, as now the user gains much more control over th=
e
> >>>>>      skb and queues.
> >>>>>
> >>>>> 4. Provide a new way to reuse TC filters. Currently TC relies on fi=
lter
> >>>>>      chain and block to reuse the TC filters, but they are too comp=
licated
> >>>>>      to understand. With eBPF helper bpf_skb_tc_classify(), we can =
invoke
> >>>>>      TC filters on _any_ Qdisc (even on a different netdev) to do t=
he
> >>>>>      classification.
> >>>>>
> >>>>> 5. Potentially pave a way for ingress to queue packets, although
> >>>>>      current implementation is still only for egress.
> >>>>>
> >>>>> I=E2=80=99ve combed through previous comments and appreciated the f=
eedbacks.
> >>>>> Some major changes in this RFC is the use of kptr to skb to maintai=
n
> >>>>> the validility of skb during its lifetime in the Qdisc, dropping rb=
tree
> >>>>> maps, and the inclusion of two examples.
> >>>>>
> >>>>> Some questions for discussion:
> >>>>>
> >>>>> 1. We now pass a trusted kptr of sk_buff to the program instead of
> >>>>>      __sk_buff. This makes most helpers using __sk_buff incompatibl=
e
> >>>>>      with eBPF qdisc. An alternative is to still use __sk_buff in t=
he
> >>>>>      context and use bpf_cast_to_kern_ctx() to acquire the kptr. Ho=
wever,
> >>>>>      this can only be applied to enqueue program, since in dequeue =
program
> >>>>>      skbs do not come from ctx but kptrs exchanged out of maps (i.e=
., there
> >>>>>      is no __sk_buff). Any suggestion for making skb kptr and helpe=
r
> >>>>>      functions compatible?
> >>>>>
> >>>>> 2. The current patchset uses netlink. Do we also want to use bpf_li=
nk
> >>>>>      for attachment?
> >>>>
> >>>> [..]
> >>>>
> >>>>> 3. People have suggested struct_ops. We chose not to use struct_ops=
 since
> >>>>>      users might want to create multiple bpf qdiscs with different
> >>>>>      implementations. Current struct_ops attachment model does not =
seem
> >>>>>      to support replacing only functions of a specific instance of =
a module,
> >>>>>      but I might be wrong.
> >>>>
> >>>> I still feel like it deserves at leasta try. Maybe we can find some =
potential
> >>>> path where struct_ops can allow different implementations (Martin pr=
obably
> >>>> has some ideas about that). I looked at the bpf qdisc itself and it =
doesn't
> >>>> really have anything complicated (besides trying to play nicely with=
 other
> >>>> tc classes/actions, but I'm not sure how relevant that is).
> >>>
> >>> Are you suggesting that it is a nuisance to integrate with the
> >>> existing infra? I would consider it being a lot more than "trying to
> >>> play nicely". Besides, it's a kfunc and people will not be forced to
> >>> use it.
> >>
> >> What's the use case?
> >
> > What's the use case for enabling existing infra to work? Sure, let's
> > rewrite everything from scratch in ebpf. And then introduce new
> > tooling which well funded companies are capable of owning the right
> > resources to build and manage. Open source is about choices and
> > sharing and this is about choices and sharing.
> >
> >> If you already go that route to implement your own
> >> qdisc, why is there a need to take the performane hit and go all the
> >> way into old style cls/act infra when it can be done in a more straigh=
t
> >> forward way natively?
> >
> > Who is forcing you to use the kfunc? This is about choice.
> > What is ebpf these days anyways? Is it a) a programming environment or
> > b) is it the only way to do things? I see it as available infra i.e #a
> > not as the answer looking for a question.  IOW, as something we can
> > use to build the infra we need and use kfuncs when it makes sense. Not
> > everybody has infinite resources to keep hacking things into ebpf.
> >
> >> For the vast majority of cases this will be some
> >> very lightweight classification anyway (if not outsourced to tc egress
> >> given the lock). If there is a concrete production need, it could be
> >> added, otherwise if there is no immediate use case which cannot be sol=
ved
> >> otherwise I would not add unnecessary kfuncs.
> >
> > "Unnecessary" is really your view.
>
> Looks like we're talking past each other? If there is no plan to use it
> in production (I assume Amery would be able to answer?), why add it right
> now to the initial series, only to figure out later on (worst case in
> few years) when the time comes that the kfunc does not fit the actual
> need? You've probably seen the life cycle doc (Documentation/bpf/kfuncs.r=
st)
> and while changes can be made, they should still be mindful about potenti=
al
> breakages the longer it's out in the wild, hence my question if it's
> planning to be used given it wasn't in the samples.
>

We would like to reuse existing TC filters. Like Jamal says, changing
filter rules in production can be done easily with existing tooling.
Besides, when the user is only interested in exploring scheduling
algorithms but not classifying traffics, they don't need to replicate
the filter again in bpf. I can add bpf_skb_tc_classify() test cases in
the next series if that helps.

Thanks,
Amery

> Thanks,
> Daniel

