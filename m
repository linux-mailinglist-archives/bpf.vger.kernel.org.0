Return-Path: <bpf+bounces-12673-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 50E287CF043
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 08:42:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E27C71F23661
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 06:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E02C763D9;
	Thu, 19 Oct 2023 06:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d3kmRrwh"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD0846671
	for <bpf@vger.kernel.org>; Thu, 19 Oct 2023 06:42:02 +0000 (UTC)
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D161B0;
	Wed, 18 Oct 2023 23:41:58 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id 6a1803df08f44-66cee0d62fbso49584486d6.3;
        Wed, 18 Oct 2023 23:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697697717; x=1698302517; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=63OYrc+Uetap8VC2C1ohqQaTIx1FYtK1OTcxj2TAuRI=;
        b=d3kmRrwhkzVaF+EpvQiLcTbvITMqHD/aIkIGGs9CbimVqWeedg8vXcO+DV8KZSAmzd
         CgCuZxjJhEDo90qgYSLdY3rg5y0cCuufshJZJTMvT8UtEIsT7d/tqT5qAvUIKCWgwpS1
         DZSjF5ybqMxqNHi2nFq1GJ3eF6G9/9Pgip3pQJN3TuEK8mmi5ZWrMDIsg+gmPhRxr8/n
         lE6K0FE7miRDcxYiW2jkyeIyAiAe/MG5fUJIwteiwDyPGYuPpEKAyWqZgUqfW7qqdbDQ
         yd7P5kl+c1FFlUmrDt/F+v4x19itCAcAuNkeK4+JhUKCRLkCD2Vh0inbZR7rsJMKdMrW
         RwiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697697717; x=1698302517;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=63OYrc+Uetap8VC2C1ohqQaTIx1FYtK1OTcxj2TAuRI=;
        b=ELEGoL61aIJDoFtqItZQWbszoCjcgrxVrv2x3ROWBmqsVlou2rOpcdgopUxI/1C8yd
         388DmvuCSQJjl92RA53Uwi8YOda70KTwmNVn10ink2Q4GiXZL4ftQ8cBdCiYsNpNUvcA
         3+oCUaNyO3J1tvKuW2KMt6M/9/HOhXW40acHr4ZenMwT3Y5MFNHRmMGa1W7YIRTnTOb6
         r1Z/aA++Fsk9/dzoeJygKXMWQ69FPy2nXBN3mA0OFm5buBAc3vpmBbwkJre22BqK99mg
         fM3shCrbLQRVTHs1vyi55ux4fSuKxeyMwfG5leAM/oMYgRpY90FfyyeGYpxF83BBhVNM
         4eMg==
X-Gm-Message-State: AOJu0YxDq4VA6l3prmXUgGRyp3ufSpYiESjU2aHGuqeHjuh6GE8OmP3L
	nOtqQtAeYFk/giOM/4i7Qx66GJ7Naeg76CZYeQc=
X-Google-Smtp-Source: AGHT+IHyIQaKgAkVxr8+aJd1kokL5K92MbYnJY/XbimglIKlmBoQD6ZYhNOX7MNpVgEShHNSrdt94fbPoIprr6UmuAc=
X-Received: by 2002:ad4:5767:0:b0:66d:696b:db75 with SMTP id
 r7-20020ad45767000000b0066d696bdb75mr1658974qvx.32.1697697717582; Wed, 18 Oct
 2023 23:41:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231017124546.24608-1-laoar.shao@gmail.com> <20231017124546.24608-4-laoar.shao@gmail.com>
 <ZS-o5K9vzmLqnLMX@slm.duckdns.org>
In-Reply-To: <ZS-o5K9vzmLqnLMX@slm.duckdns.org>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Thu, 19 Oct 2023 14:41:21 +0800
Message-ID: <CALOAHbAOWMXFhhNjn8g5Z+DkEB3hFFmL+70ggizdup_MU7=KEg@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next v2 3/9] cgroup: Add a new helper for cgroup1 hierarchy
To: Tejun Heo <tj@kernel.org>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com, 
	haoluo@google.com, jolsa@kernel.org, lizefan.x@bytedance.com, 
	hannes@cmpxchg.org, yosryahmed@google.com, mkoutny@suse.com, 
	sinquersw@gmail.com, cgroups@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 18, 2023 at 5:44=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote:
>
> On Tue, Oct 17, 2023 at 12:45:40PM +0000, Yafang Shao wrote:
> > +/**
> > + * task_cgroup_id_within_hierarchy - Acquires the associated cgroup of=
 a task
>       ^
>       doesn't match actual function name.

Ah. forgot to change it.
will fix it.

>
> > + * within a specific cgroup1 hierarchy. The cgroup1 hierarchy is ident=
ified by
> > + * its hierarchy ID.
> > + * @tsk: The target task
> > + * @hierarchy_id: The ID of a cgroup1 hierarchy
> > + *
> > + * On success, the cgroup is returned. On failure, ERR_PTR is returned=
.
> > + * We limit it to cgroup1 only.
> > + */
> > +struct cgroup *task_get_cgroup1_within_hierarchy(struct task_struct *t=
sk, int hierarchy_id)
>
> Maybe we can just named it task_get_cgroup1()?

sure. will use it instead.

--=20
Regards
Yafang

