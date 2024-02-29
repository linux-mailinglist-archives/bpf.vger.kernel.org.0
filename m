Return-Path: <bpf+bounces-23069-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0EAB86D256
	for <lists+bpf@lfdr.de>; Thu, 29 Feb 2024 19:30:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 205EA1C211FF
	for <lists+bpf@lfdr.de>; Thu, 29 Feb 2024 18:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E945113441E;
	Thu, 29 Feb 2024 18:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="EPJm0YDP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC277D412
	for <bpf@vger.kernel.org>; Thu, 29 Feb 2024 18:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709231426; cv=none; b=RYoWigTqMonJ2EXhAipGv8bGaADx3EQMaVKpSmi0uJC7rwa8lo6RfesjKZqJfVnf5cD7xOr6XyaH1IIgZEble7kNTXqSeV4wIhcI8G3EVn51/sg1ZbiDjqUso3yRNSZfYOdF7nrUuYDaICEa69PECe4FI6U3CaYKXlg4gqGrQ8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709231426; c=relaxed/simple;
	bh=fIDzt/zIvmS+WF3x2U2l/YsvsBtPs1hW02ywHV62az0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RwlSbNrCVMisv2whiI9cL+c2f2UZqbFqWWiPgOoqChiYmsNABh7mNK8TxJp109x7TL+nI+4E+zT12yh5Lbtvv7dwfqypeCKUS0bTv0V96WxHcfLrcVyvk0DhA5gqQ5EfaZiipuz7+mO+UnmBWtcHDrGVq1cqvO9jkogbXDUlZes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=EPJm0YDP; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6096ff3e4abso8653617b3.0
        for <bpf@vger.kernel.org>; Thu, 29 Feb 2024 10:30:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1709231424; x=1709836224; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=baWFsDRpOZwDlTtI3eTOs150HYfeSnKMsWGIClmqta0=;
        b=EPJm0YDPS1zhGGUUemd7s6UZZTtLW1oyfisnj9dcQcELyAWHVJB3tkUqoo7JTGLtyn
         1ZX0d4nLtCpJwQX/2FgUOHHU6yu2mz83icrhkw1Kv4I8Gw5GKE6KvltnTKT4q5AWkAlG
         0ltN6WhU9SLHHpPyBhSyUyhM6sDisFpZIeW56Q+q5Cpyx2WW+Acz8l4W0T3eI84OTI+S
         tMiFjmN3xoUWbp37JZQv/luPmS+PfOGAWq7pG4pj+LA9Dt+xF2d9/vqhJ17FSyOU4tSv
         f42g2DS7lkzlGuGKtFwKYh7gHpPJ0S+8Q/QsF0MSLclFmt10R16WPCrt6aucSN9Bw4cY
         7keA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709231424; x=1709836224;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=baWFsDRpOZwDlTtI3eTOs150HYfeSnKMsWGIClmqta0=;
        b=AM1vPR8gzR31PytLqVXWNbpAC45n4bBP7KSvtdAyUOykGvDalpqj+QbnB6lPUda8tu
         adXfJ4/QVc0xVR8lAfci6NTxRznUsnTgXblUz7vWrMFsV00jJU/Zln1TjwvtVDdAfXYu
         S2Fd2XPJdYmLlMIa8eWucgC3ND+hN47hleFsrt/2ys+6bHoABchOGoQczIw5UU25qXJD
         h/qV4IkFtoQTifDdclsQPG/QkN5emBmzabmsXnc3BWYp5Lzl5YftlAhZBNGCuwj6GL9Y
         HEwIO9/LpUgg6AvmmHaQ3cBmpC2DOWzfU1V3z8Nf8Be/oNU947nZwLtNLImWPyrFM5mU
         EArw==
X-Forwarded-Encrypted: i=1; AJvYcCXug16E96v09vAmfwL+yT6l7/LbfMHIN4hWvBdqBi/r8gH1hNW1DpriMjqQC6a7oT8d8Cx3DnAqUqGjddVk4Ebt1Lvb
X-Gm-Message-State: AOJu0YwTbVzOA+Ni4EDK7XwMqcfXFu6oLTUlwVN9rIbBvO+vModAhMls
	HoFtuYcZ50caU4nTymnATJThuLHCtWtEexaXpaJgoBWfCgW7LJMZVv+yOLKrNfvnqmGtijXu4zQ
	IHmSCDc2kzAsaG80Vlv0yvwnszRyaWgVFEmsA
X-Google-Smtp-Source: AGHT+IHl+58LUxZ7t8QCrt7A9iFSCpNrVrsb8JlTdK4KXwKB/PkdvoaELedDm0lfkCY0ELUtzetRIR8WzH/GlSdPnLo=
X-Received: by 2002:a81:a0c3:0:b0:609:2c2a:1115 with SMTP id
 x186-20020a81a0c3000000b006092c2a1115mr3116390ywg.30.1709231423855; Thu, 29
 Feb 2024 10:30:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240225165447.156954-1-jhs@mojatatu.com> <20240225165447.156954-4-jhs@mojatatu.com>
 <327b473d9f6ae5e44391f75a022e4dca90a20c43.camel@redhat.com>
In-Reply-To: <327b473d9f6ae5e44391f75a022e4dca90a20c43.camel@redhat.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Thu, 29 Feb 2024 13:30:12 -0500
Message-ID: <CAM0EoMniTMq+mYqSg4DbOfsbOMc7BGkV7Z6PdA+j_214PLPOeQ@mail.gmail.com>
Subject: Re: [PATCH net-next v12 03/15] net/sched: act_api: Update
 tc_action_ops to account for P4 actions
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, deb.chatterjee@intel.com, anjali.singhai@intel.com, 
	namrata.limaye@intel.com, tom@sipanda.io, mleitner@redhat.com, 
	Mahesh.Shirshyad@amd.com, Vipin.Jain@amd.com, tomasz.osinski@intel.com, 
	jiri@resnulli.us, xiyou.wangcong@gmail.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, vladbu@nvidia.com, horms@kernel.org, 
	khalidm@nvidia.com, toke@redhat.com, daniel@iogearbox.net, 
	victor@mojatatu.com, pctammela@mojatatu.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 29, 2024 at 11:19=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wr=
ote:
>
> On Sun, 2024-02-25 at 11:54 -0500, Jamal Hadi Salim wrote:
> > The initialisation of P4TC action instances require access to a struct
> > p4tc_act (which appears in later patches) to help us to retrieve
> > information like the P4 action parameters etc. In order to retrieve
> > struct p4tc_act we need the pipeline name or id and the action name or =
id.
> > Also recall that P4TC action IDs are P4 and are net namespace specific =
and
> > not global like standard tc actions.
> > The init callback from tc_action_ops parameters had no way of
> > supplying us that information. To solve this issue, we decided to creat=
e a
> > new tc_action_ops callback (init_ops), that provies us with the
> > tc_action_ops  struct which then provides us with the pipeline and acti=
on
> > name.
>
> The new init ops looks a bit unfortunate. I *think* it would be better
> adding the new argument to the existing init op
>

Our initial goal was to avoid creating a much larger patch by changing
any other action's code and we observe that ->init() already has 8
params already ;-> And only dynamic actions need this extra extension.
If you still feel the change is needed, sure we can make that change.

> > In addition we add a new refcount to struct tc_action_ops called
> > dyn_ref, which accounts for how many action instances we have of a spec=
ific
> > action.
> >
> > Co-developed-by: Victor Nogueira <victor@mojatatu.com>
> > Signed-off-by: Victor Nogueira <victor@mojatatu.com>
> > Co-developed-by: Pedro Tammela <pctammela@mojatatu.com>
> > Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
> > Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> > Reviewed-by: Vlad Buslov <vladbu@nvidia.com>
> > Reviewed-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
> > ---
> >  include/net/act_api.h |  6 ++++++
> >  net/sched/act_api.c   | 14 +++++++++++---
> >  2 files changed, 17 insertions(+), 3 deletions(-)
> >
> > diff --git a/include/net/act_api.h b/include/net/act_api.h
> > index c839ff57c..69be5ed83 100644
> > --- a/include/net/act_api.h
> > +++ b/include/net/act_api.h
> > @@ -109,6 +109,7 @@ struct tc_action_ops {
> >       char    kind[ACTNAMSIZ];
> >       enum tca_id  id; /* identifier should match kind */
> >       unsigned int    net_id;
> > +     refcount_t p4_ref;
> >       size_t  size;
> >       struct module           *owner;
> >       int     (*act)(struct sk_buff *, const struct tc_action *,
> > @@ -120,6 +121,11 @@ struct tc_action_ops {
> >                       struct nlattr *est, struct tc_action **act,
> >                       struct tcf_proto *tp,
> >                       u32 flags, struct netlink_ext_ack *extack);
> > +     /* This should be merged with the original init action */
> > +     int     (*init_ops)(struct net *net, struct nlattr *nla,
> > +                         struct nlattr *est, struct tc_action **act,
> > +                        struct tcf_proto *tp, struct tc_action_ops *op=
s,
>
> shouldn't the 'ops' argument be 'const'?
>

As it is right now this would be hard to do because we carry around a
refcnt in that struct. We will think about it..


cheers,
jamal


> Thanks,
>
> Paolo
>

