Return-Path: <bpf+bounces-12938-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 398E47D225D
	for <lists+bpf@lfdr.de>; Sun, 22 Oct 2023 11:33:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 855C9281680
	for <lists+bpf@lfdr.de>; Sun, 22 Oct 2023 09:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3819A17E6;
	Sun, 22 Oct 2023 09:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m5gWwvDu"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3228F566C
	for <bpf@vger.kernel.org>; Sun, 22 Oct 2023 09:33:22 +0000 (UTC)
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7DFB93;
	Sun, 22 Oct 2023 02:33:20 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id af79cd13be357-7788f727dd7so139942385a.1;
        Sun, 22 Oct 2023 02:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697967200; x=1698572000; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JU1qseP4EfX8zx4vZ7JMnjfTVYuZaNIDuUmyb2QENVM=;
        b=m5gWwvDuxfds7/AhiA3iY0U0R3TPlcH0PeaIrZ31l+WcY63/XKwr4wQp2x6s7FFj7I
         2tcxviYBvMDTRjVZKzxki0boqYNY0xLbnnmCAw2aBLTE+E0G2lw78cNoq2CiK76AGKry
         Rr9BBCCymSgpFvhi51tYGOfNu8unYaQ1nqFlkbx30WXZZSD8yv5nEnR4w/4Zmvi2HJYW
         vLGRYMKUWH74N/QHRmeBtBAGbx6JOzvisNJIGoLNmNIfwIGNomvGTkBDgaFVfMeI1IA+
         FyZgwYkTPQZdPwrafyUb7PhGuXb2Q2ifMvfjP5r9xYSP75MJvTs3APTma5TXmdSohvBN
         8ukA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697967200; x=1698572000;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JU1qseP4EfX8zx4vZ7JMnjfTVYuZaNIDuUmyb2QENVM=;
        b=GYGDfpJ392KBzV8tphkUJlSJfNgRJnJWjoqrHxe5oRblL0UmO8/WbHqGSnQU1SjXaq
         hf/PKBFmUzTlTSRcWfM8i0ZUkeYe/GSLAfKo6cUiJGA3881tQfTLLnxbwasVWA4sV6EC
         T22F0ofuCMAs4hKOdag4LfF3pO52ngdH27n8SIru8JjAVL1+UQdcIaJfCA4hdCZKc2Va
         iYBwnpzUGkSto5O8APxEhPib9geF0zsW+ocPARUyGW4A6FHe6k6aM+jr+A3lnYE2/5jh
         FQ38zyOg5luayvcp6xeEz5oLByZtIlIj2UJtQAZhgcTCUBbNpa/GOBJsvOuo3NG2DzsB
         UGww==
X-Gm-Message-State: AOJu0YzvEUr1L7VBeUKCnOzxWfFg6Mz28DSBP4F+tOyspe6nikUCazlb
	YoYR/C+r+PzlFCFQ4YCoHxvdF7R6HxA2YiWMusQ=
X-Google-Smtp-Source: AGHT+IE8XDs81Ed55IcmyiA+YvourVcN1oua+zQ0npm4I82d6RewypOBG90Cg/gIkHC/2Sp5mEzsBZgSssnFCfgG+nk=
X-Received: by 2002:a05:6214:5298:b0:66d:13b5:9283 with SMTP id
 kj24-20020a056214529800b0066d13b59283mr7726003qvb.29.1697967199660; Sun, 22
 Oct 2023 02:33:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231017124546.24608-1-laoar.shao@gmail.com> <20231017124546.24608-2-laoar.shao@gmail.com>
 <ZS-m3t-_daPzEsJL@slm.duckdns.org> <CALOAHbAd2S--=72c2267Lrcj_czkitdG9j97pai2zGqdAskvQQ@mail.gmail.com>
 <ZTF-nOb4HDvjTSca@slm.duckdns.org> <09ff4166-bcc2-989b-97ce-a6574120eea7@redhat.com>
 <CALOAHbDO=gzkn=7e+6LMJNwKUPxexJfg=L1J+KZG9a9Zk9LZUg@mail.gmail.com> <ZTK-CI9juS31kMSX@slm.duckdns.org>
In-Reply-To: <ZTK-CI9juS31kMSX@slm.duckdns.org>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Sun, 22 Oct 2023 17:32:43 +0800
Message-ID: <CALOAHbDiLBqse11ZJpNXdvCw8baCzRQMe+BhbtOEV3C=bZhXjQ@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next v2 1/9] cgroup: Make operations on the cgroup
 root_list RCU safe
To: Tejun Heo <tj@kernel.org>
Cc: Waiman Long <longman@redhat.com>, ast@kernel.org, daniel@iogearbox.net, 
	john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev, 
	song@kernel.org, yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com, 
	haoluo@google.com, jolsa@kernel.org, lizefan.x@bytedance.com, 
	hannes@cmpxchg.org, yosryahmed@google.com, mkoutny@suse.com, 
	sinquersw@gmail.com, cgroups@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 21, 2023 at 1:51=E2=80=AFAM Tejun Heo <tj@kernel.org> wrote:
>
> On Fri, Oct 20, 2023 at 05:36:57PM +0800, Yafang Shao wrote:
> > On Fri, Oct 20, 2023 at 3:43=E2=80=AFAM Waiman Long <longman@redhat.com=
> wrote:
> > >
> > > On 10/19/23 15:08, Tejun Heo wrote:
> > > > On Thu, Oct 19, 2023 at 02:38:52PM +0800, Yafang Shao wrote:
> > > >>>> -     BUG_ON(!res_cgroup);
> > > >>>> +     WARN_ON_ONCE(!res_cgroup && lockdep_is_held(&cgroup_mutex)=
);
> > > >>> This doesn't work. lockdep_is_held() is always true if !PROVE_LOC=
KING.
> > > >> will use mutex_is_locked() instead.
> > > > But then, someone else can hold the lock and trigger the condition
> > > > spuriously. The kernel doesn't track who's holding the lock unless =
lockdep
> > > > is enabled.
> > >
> > > It is actually possible to detect if the current process is the owner=
 of
> > > a mutex since there is a owner field in the mutex structure. However,
> > > the owner field also contains additional information which need to be
> > > masked off before comparing with "current". If such a functionality i=
s
> > > really needed, we will have to add a helper function mutex_is_held(),
> > > for example, to kernel/locking/mutex.c.
> > =E3=80=81
> > Agreed. We should first introduce mutex_is_held(). Thanks for your sugg=
estion.
>
> I'm not sure this is the right occassion to add such thing. It's just a
> warn_on, we can either pass in the necessary condition from the callers o=
r
> just drop the warning.

OK. will just drop the warning.

--=20
Regards
Yafang

