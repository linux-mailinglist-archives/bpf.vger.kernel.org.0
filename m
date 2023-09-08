Return-Path: <bpf+bounces-9570-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B37557992BA
	for <lists+bpf@lfdr.de>; Sat,  9 Sep 2023 01:17:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2D191C20DC8
	for <lists+bpf@lfdr.de>; Fri,  8 Sep 2023 23:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EE2A7466;
	Fri,  8 Sep 2023 23:16:57 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F951FBF
	for <bpf@vger.kernel.org>; Fri,  8 Sep 2023 23:16:56 +0000 (UTC)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59A9E1705
	for <bpf@vger.kernel.org>; Fri,  8 Sep 2023 16:16:53 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-5007f3d3235so4275350e87.2
        for <bpf@vger.kernel.org>; Fri, 08 Sep 2023 16:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694215011; x=1694819811; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s38iIII6F5nYcm5tee1EzF7riv9/OAew417btcAY230=;
        b=eJxlqINZi2rAk3Ddl5iRrOaDBsarmqiApnEgh9UAalPyoiYaIqC5xgFyyv9WTWpESV
         c4EJEs3qJx14HI4KJPVKWDM8JKiE/6eisqfRHETAiIyMEGRkAEO5bjwxWxkZaH8Ii1HF
         aMft4gD3LL1pSyQJTMIXbWPTUbLw+kibuIamoddhgEQBSgWgErGyiuU7nL47CRygtAUs
         d90so8aWbO/QVTBU9lKE/NeQwNhtMUJi0L0uPh1w3XaIwob8Uc4z55PaAplFjN6q2e7l
         SGKgijQZuNoaol4RuMWmNZS+4PBHw6kHsKTvw55pa3ZKjUfo+ZSolNm60U/xQAxzLMUz
         lyKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694215011; x=1694819811;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s38iIII6F5nYcm5tee1EzF7riv9/OAew417btcAY230=;
        b=PUmxHTyPjCxrOjD93tDkCh9sHx9Eea3pri+v9B0ZXeDZSwWVS84ETDbR/pRfMWFfDz
         gBS7sKxTLNj/vuXqyrfp2IsMYkuaUhvtQlI7csDxr4iPkfrcX61llp/apE7ZpVXyGRXR
         c64eA9WDd/U+IGSf/5DrT4rJvXpaVb8+qqlUduJHWmE0yz2BFKQiWGYDtyeQDIk0ZdPv
         SDOUmK1deSFlNDrjQX8AZZTQbwCrw6La9WwAhjD3GybAuUTjI0rLHEfQ9WuS4gHdo0YZ
         fquyO1eZp7m6l08KQOqTssESM367t7CjgI05aJbYRB5LWl9rwPq/4KvPlqGDLe9LsDHs
         3gTw==
X-Gm-Message-State: AOJu0YyAVFQk8FiCUJRyE6k1thJhgKy9PQRvAYfpGHS/FBZvXo/kje/R
	+kt4BNMRC+m/zvMImLIjovNZtmW8xECfrrEQjaU=
X-Google-Smtp-Source: AGHT+IENpgvTu3dFyYxJNJrl577Xn7P1QiEo91UV4eewQtj2viArpi4fmw9FTjq5J8K6JT7XB4GUC3qDxDYdvUqrF30=
X-Received: by 2002:a05:6512:3d09:b0:4f8:5635:2cd8 with SMTP id
 d9-20020a0565123d0900b004f856352cd8mr4007258lfv.32.1694215011181; Fri, 08 Sep
 2023 16:16:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABk29NuQ4C-w_JA-zev796Nr_vx932qC4_OcdH=gMM6HZ_r4WQ@mail.gmail.com>
 <33f06fa6-2f4d-4e50-a87e-0d6604d3c413@paulmck-laptop> <CABk29Nva+c6oBZra6srWGcfxMEquOP30dReM-PgW_Wh+zKiBuQ@mail.gmail.com>
 <ZPubIZLXFuAsfN7a@slm.duckdns.org>
In-Reply-To: <ZPubIZLXFuAsfN7a@slm.duckdns.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 8 Sep 2023 16:16:39 -0700
Message-ID: <CAADnVQLkHQO_WjkdhmR3XAJOXY=QCGKAe6GFi8Q4YiOf5Dm+iw@mail.gmail.com>
Subject: Re: BPF memory model
To: Tejun Heo <tj@kernel.org>
Cc: Josh Don <joshdon@google.com>, "Paul E. McKenney" <paulmck@kernel.org>, Hao Luo <haoluo@google.com>, 
	Dave Marchevsky <davemarchevsky@meta.com>, David Vernet <dvernet@meta.com>, 
	Neel Natu <neelnatu@google.com>, Jack Humphries <jhumphri@google.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Christoph Hellwig <hch@infradead.org>, Dave Thaler <dthaler@microsoft.com>, 
	"Jose E. Marchesi" <jose.marchesi@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Sep 8, 2023 at 3:07=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote:
>
> Hello,
>
> On Fri, Sep 08, 2023 at 01:26:11PM -0700, Josh Don wrote:
> > I'm writing BPF programs for scheduling (ie. sched_ext), so these are
> > getting invoked in hot paths and invoked concurrently across multiple
> > cpus (for example, pick_next_task, enqueue_task, etc.). The kernel is
> > responsible for relaying ground truth, userspace makes O(ms)
> > scheduling decisions, and BPF makes O(us) scheduling decisions.
> > BPF-BPF concurrency is possible with spinlocks and RMW, BPF-userspace
> > can currently only really use RMW. My line of questioning is more
> > forward looking, as I'm preemptively thinking of how to ensure
> > kernel-like scheduling performance, since BPF spinlock or RMW is
> > sometimes overkill :) I would think that barrier() and smp_mb() would
> > probably be the minimum viable set (at least for x86) that people
> > would find useful, but maybe others can chime in.
>
> My personal favorite set is store_release/load_acquire(). I have a hard t=
ime
> thinking up cases which can't be covered by them and they're basically fr=
ee
> on x86.

First of all, Thanks Josh for highlighting this topic and
gently nudging Paul to continue his work :)

It's absolutely essential for BPF to have a well defined memory model.

It's necessary for fast sched-ext bpf progs and for HW offloads too.
As a minimum we need to document it in Documentation/bpf/standardization/.
It's much more challenging than it looks.
Unlike traditional ISAs. We cannot say that memory consistency is
similar to x86 or arm64 or riscv.
bpf memory consistency cannot pick the lower common denominator either.
bpf memory model most likely going to be pretty close to kernel memory mode=
l
instead of HW or C.

In parallel we can start adding new concurrency primitives.
Sounds like smp_load_acquire()/store_release should be the first pair.
Here it's also more challenging than in the kernel.
We cannot define bpf_smp_load_acquire() as a macro.
It needs to be a new flavor of BPF_LDX instruction that JITs
will convert into a proper sequence of insns.
On x86-64 it will remain normal load,
while on arm64 it will be LDAR instead of LDR and so on.

Some of the barriers we can implement as kfuncs since they're slow anyway.
Some other barriers would need to be new instructions too.
The design would need to take into account multiple architectures,
gcc/llvm consideration, verifier complexity, and,
of course, include bpf IETF standardization working group.

