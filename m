Return-Path: <bpf+bounces-829-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99DCD70754E
	for <lists+bpf@lfdr.de>; Thu, 18 May 2023 00:26:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8933D1C20F55
	for <lists+bpf@lfdr.de>; Wed, 17 May 2023 22:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C7A810961;
	Wed, 17 May 2023 22:25:56 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09EF433F6
	for <bpf@vger.kernel.org>; Wed, 17 May 2023 22:25:55 +0000 (UTC)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 324F949DC
	for <bpf@vger.kernel.org>; Wed, 17 May 2023 15:25:54 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4f14ec8d72aso1683831e87.1
        for <bpf@vger.kernel.org>; Wed, 17 May 2023 15:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684362352; x=1686954352;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5rLfmL7FuKqQVBqAM8s+0WpKi6hwhfQUHYp8NmAjFHk=;
        b=PpDot6aC6odxDoQ4TAgnlykE5740/d4YjLkrSAteE+fDB+0Un9pP5Acm7p7dLLktdY
         MrVNWgrcBHixlNKzAVMcR7fW2LEc3S6XVEQb5Q3ZjnzIjEdcJuPwVKMHFj22gVhcFGIl
         SkcK4oSfoE732NF5JiPnW2B5YJ28t1LYqsV7IutBkJj5Vqojz2tWLFmXZuVYpnvc3Tog
         3xn/yP/mWDxjN2UHutV00Qp0Ds2s8BXjrrN2ELbMOzWyjflqZOwm/RQPn887xO2VwHEG
         U++gyLiqupqSm3cGQ8xZGer7GfGcdtDHPfUyA92uX/vmIeF8crx2SzMycLiT2t40fK1t
         13PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684362352; x=1686954352;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5rLfmL7FuKqQVBqAM8s+0WpKi6hwhfQUHYp8NmAjFHk=;
        b=Ghz1yEf1j/jfrdvkdCfmV93dEVIHfoeOVDQFAmhcYwRKMQ9DXZkdGuNZoUUIuzvq9r
         eBkHKzOd5B6a5QU/+xFw8/cav9vQAMSwUlqPIy7pzdpU5hzErdHG/KCtEgxr2KCWpi6L
         Wy0H+nrZytiolMKYOsnFV4lRkPrz09js0Q6yFunXXXwJmUF6oiTJsdVrXs2J+dIL/iZO
         LXoazLDOSDDxmXZcUsoVb0SY5920YiiAGkK79hRmTBfuj8Hv+p6j5LhQntNni9YGHP5X
         OHTgqppkVmVMCMpQw6T1YIiy80VqWgPl/Zv+Vo/T+AJZp5v2kbRgcsRboJV3ezXX1E1u
         mUsA==
X-Gm-Message-State: AC+VfDxBZNxs+iJu67LI5e/V4D0LsPtQcDf7DDIydwtarL3n/8Ip+/6N
	f7M8Qrm8Y7HYgSGT8xGjvPBNr9TYFmlPb6bgq3s=
X-Google-Smtp-Source: ACHHUZ5k56AqsT/dmHxaD3xyDaTzR++S/d2rm7RM8AZMaHRoaiUkYETsWrPqmeptS7dR8ienLDRvxkR7zHE+o51A6S4=
X-Received: by 2002:ac2:46fc:0:b0:4e8:4abf:f19d with SMTP id
 q28-20020ac246fc000000b004e84abff19dmr787940lfo.15.1684362352038; Wed, 17 May
 2023 15:25:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230511172054.1892665-1-sdf@google.com> <20230511172054.1892665-5-sdf@google.com>
 <CAEf4Bzam+Cy+qmf5dH5=_36QuOd94_EmqnUW6nkxo0Y_EmirOA@mail.gmail.com> <CAKH8qBv80U_G4M0sCW_hJuJB63BrHJcrWAZNsHX9e52MMi3=5A@mail.gmail.com>
In-Reply-To: <CAKH8qBv80U_G4M0sCW_hJuJB63BrHJcrWAZNsHX9e52MMi3=5A@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 17 May 2023 15:25:40 -0700
Message-ID: <CAADnVQ+76eN6DgRV7Tcs0Y+7cvMhG4KLCgaCOwVB-7SnOiGX_A@mail.gmail.com>
Subject: Re: [PATCH bpf-next 4/4] bpf: query effective progs without cgroup_mutex
To: Stanislav Fomichev <sdf@google.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, May 16, 2023 at 5:02=E2=80=AFPM Stanislav Fomichev <sdf@google.com>=
 wrote:
>
> > So taking a bit of a step back. In cover letter you mentioned:
> >
> >   > We're observing some stalls on the heavily loaded machines
> >   > in the cgroup_bpf_prog_query path. This is likely due to
> >   > being blocked on cgroup_mutex.
> >
> > Is that likely an unconfirmed suspicion or you did see that
> > cgroup_mutex lock is causing stalls?
>
> My intuition: we know that we have multiple-second stalls due
> cgroup_mutex elsewhere and I don't see any other locks in the
> prog_query path.

I think more debugging is necessary here to root cause this multi-second st=
alls.
Sounds like they're real. We have to understand them and fix
the root issue.
"Let's make cgroup_bpf_query lockless, because we can, and hope that
it will help" is not a data driven development.

I can imagine that copy_to_user-s done from __cgroup_bpf_query
with cgroup_lock taken are causing delay, but multi-second ?!
There must be something else.
If copy_to_user is indeed the issue, we can move just that part
to be done after cgroup_unlock.
Note cgroup_bpf_attach/detach don't do user access, so shouldn't
be influenced by faults in user space.

