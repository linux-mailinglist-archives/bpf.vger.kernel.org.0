Return-Path: <bpf+bounces-830-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2230F70758C
	for <lists+bpf@lfdr.de>; Thu, 18 May 2023 00:41:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9A1F2816CF
	for <lists+bpf@lfdr.de>; Wed, 17 May 2023 22:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 908FF2A9C6;
	Wed, 17 May 2023 22:41:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6330915A5
	for <bpf@vger.kernel.org>; Wed, 17 May 2023 22:41:17 +0000 (UTC)
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D810CC6
	for <bpf@vger.kernel.org>; Wed, 17 May 2023 15:41:15 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-52caed90d17so905122a12.0
        for <bpf@vger.kernel.org>; Wed, 17 May 2023 15:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684363275; x=1686955275;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eSOnOiGURN9IlUBVUVJKS+oHB37Pcso5YekuVJUsr/E=;
        b=k9SAVy3i61gFQnhSDvRLUcJMUgnlT05RRx+q8v8ni7kVQsOJ3RR+MZL/kix0oyocqD
         CZ48QD6xaGcA7H3S6w+YGTSFg/e570KeCFpQYWpVjT+LuqhII5icwaoQzwljJ4HHj9C6
         P61n5m6zxZC9cbLJFBuS7yke2AElrOkujVNkccizZJK559WM6JaLg+9xI9WQB1Mvm6ua
         V8MHNY3nBx/ywIGkCdhhcIHH6ZTkm15NEoMYd4dsu3uMD5qckqowsmR8rE/F1NN5t8mS
         a9Nr2JR/mk4hilMkBccJaOHWCj9Q43SCzLZy9Gc7f1WkVHKl72lb3CZjkm09n2gp6Syl
         obxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684363275; x=1686955275;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eSOnOiGURN9IlUBVUVJKS+oHB37Pcso5YekuVJUsr/E=;
        b=brWA+X/DkVvVIDauHGXlSXacymAzjllhkMHKYSnPbq6GS27OeQIdRQMHDynua88X9A
         c6QWGesM8xZ1jJb9q9wCeNq5WJMwQiGEbNaJG2xl+THeYsxWH8kJPjtehTvmA2PSqy6r
         qGe0ktl2IxC/ki5Wj1qqgKWBe5W9VwMkwGE+b58JLzXc8T5ayRP0AyqLgNXBF0Bmh4Y5
         rhhGH7rf28zBfvm4VR7nbcP+RgjOe3ucAeHMIg8EIuttNofSDkAC/5XTijGa7imYiT/1
         2lsEqGoJAt4mUp++uBqV54YjSpwRnRk4h5qOQFKi7dme99y6Go3wkuoO8N1ADwZZqDLV
         jUVg==
X-Gm-Message-State: AC+VfDw1FqBT9ZWz8dIPIce43kMfkgOZrKMZLVq6vWXKSJpGqlCAUk7m
	JToBMxAwsrbSAiKgn49wzXfS9Yg+hmSO4jMliVvzcg==
X-Google-Smtp-Source: ACHHUZ7eE1dIFjdzKovqao/cblKkcZWyrdN0VFnyPmKpWBw/LHBEGhiAj8J76+YxV6LqHDJOJNrNVTklyPG0W0U5Bto=
X-Received: by 2002:a17:902:ead4:b0:1ae:4013:986c with SMTP id
 p20-20020a170902ead400b001ae4013986cmr255969pld.63.1684363275258; Wed, 17 May
 2023 15:41:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230511172054.1892665-1-sdf@google.com> <20230511172054.1892665-5-sdf@google.com>
 <CAEf4Bzam+Cy+qmf5dH5=_36QuOd94_EmqnUW6nkxo0Y_EmirOA@mail.gmail.com>
 <CAKH8qBv80U_G4M0sCW_hJuJB63BrHJcrWAZNsHX9e52MMi3=5A@mail.gmail.com> <CAADnVQ+76eN6DgRV7Tcs0Y+7cvMhG4KLCgaCOwVB-7SnOiGX_A@mail.gmail.com>
In-Reply-To: <CAADnVQ+76eN6DgRV7Tcs0Y+7cvMhG4KLCgaCOwVB-7SnOiGX_A@mail.gmail.com>
From: Stanislav Fomichev <sdf@google.com>
Date: Wed, 17 May 2023 15:41:03 -0700
Message-ID: <CAKH8qBuCd=iJmQDSMWasmQB4ZiKzj4NmMw_rUz8=2smJtRTDvA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 4/4] bpf: query effective progs without cgroup_mutex
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Hao Luo <haoluo@google.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, May 17, 2023 at 3:25=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, May 16, 2023 at 5:02=E2=80=AFPM Stanislav Fomichev <sdf@google.co=
m> wrote:
> >
> > > So taking a bit of a step back. In cover letter you mentioned:
> > >
> > >   > We're observing some stalls on the heavily loaded machines
> > >   > in the cgroup_bpf_prog_query path. This is likely due to
> > >   > being blocked on cgroup_mutex.
> > >
> > > Is that likely an unconfirmed suspicion or you did see that
> > > cgroup_mutex lock is causing stalls?
> >
> > My intuition: we know that we have multiple-second stalls due
> > cgroup_mutex elsewhere and I don't see any other locks in the
> > prog_query path.
>
> I think more debugging is necessary here to root cause this multi-second =
stalls.
> Sounds like they're real. We have to understand them and fix
> the root issue.
> "Let's make cgroup_bpf_query lockless, because we can, and hope that
> it will help" is not a data driven development.
>
> I can imagine that copy_to_user-s done from __cgroup_bpf_query
> with cgroup_lock taken are causing delay, but multi-second ?!
> There must be something else.
> If copy_to_user is indeed the issue, we can move just that part
> to be done after cgroup_unlock.
> Note cgroup_bpf_attach/detach don't do user access, so shouldn't
> be influenced by faults in user space.

It's definitely not our path that is slow. Some other path that grabs
cgroup_mutex can hold it for arbitrary time which makes our bpf_query
path wait on it.
That's why I was hoping that we can just avoid locking cgroup_mutex
where possible (at least query/read paths).
Hao, can you share more about what particular path is causing the
issue? I don't see anything mentioned on the internal bug, but maybe
you have something to share?

