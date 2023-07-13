Return-Path: <bpf+bounces-4969-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC278752B2E
	for <lists+bpf@lfdr.de>; Thu, 13 Jul 2023 21:48:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78BF0281F0A
	for <lists+bpf@lfdr.de>; Thu, 13 Jul 2023 19:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDD45200B8;
	Thu, 13 Jul 2023 19:48:08 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CED11ED53
	for <bpf@vger.kernel.org>; Thu, 13 Jul 2023 19:48:08 +0000 (UTC)
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5668E2724;
	Thu, 13 Jul 2023 12:48:07 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id ca18e2360f4ac-7837329a00aso39929139f.2;
        Thu, 13 Jul 2023 12:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689277686; x=1691869686;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TQKDTkoWZPUpNGxKDSJ4dzeo/1BxtJ5U/WdKrNfLRH8=;
        b=dUz9qPmFSv1nBpZjQIWVenvDX71b7rzbJPcijCEUBYXxozGAYtVnGeZXnzNXMKenT/
         R6kUxUmYqeEs2AiXZhAzy3eb3CltElJdC1vpFRz1aXdND4q6kK/ivO2BYwfU2ambpj9Q
         K0xjD0ySvtl9MpAVeI8eN4+tW2DCcMssKUJUHwq5ODW0XjVBgJgC5NwnmC52SJTq+GfT
         +vrWLIt2qEncRbOHY/VFJ4tS1ShzbxeoVi9KRpHcNi665QYbyxuIWgzPD5yk2iVe8d81
         4FLPOOQZ/yPvb5RTQAvM9rKJ5ghTKWO7La+xrsF0mcuXJ46Zq+vJEYKwm8TosZ2br1T7
         jMzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689277686; x=1691869686;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TQKDTkoWZPUpNGxKDSJ4dzeo/1BxtJ5U/WdKrNfLRH8=;
        b=H7EPTbt1wBiKyk/WTKvNX++4m5161tMC0USZNlwHx+1dsG/XUmtAFSTSBoY2TRTUPo
         hqNRVtKQeDTv7JoJurC2+0FokFC6/0xCue2Rpi8Hsx5D4h5zOzM9FV4aGVbKYIpXjTKf
         d6o0efIGMnntp0WqnnglMyng2N7Vl+m5RzXNay75mAe/sS2RbKnPoP/l97Hrs8hIkkAB
         7M44Ogw5aBWqTQYrKePGCECyMt3wMxbX8nCde+zU7NeusUACOGzpWaSu3S6vxgj9o/n0
         9+36xzf29q8sm4RmIwnPXDkVk2VhHpotavxh1tSGy1bZa/Sfnch0wzu8r6NM3oUCKDXV
         zbxQ==
X-Gm-Message-State: ABy/qLagmHgumYNwUzN4cQ58AHxZ7q6ado01XkiWUN71jTbZc4bd1pGm
	hSU7NB1GSz4GgPV+D4tLFNY=
X-Google-Smtp-Source: APBJJlGro/zqjnuY9gy47z2GPd38MalaLr8oHlhnQr67G6DOTwls4bQrnQ20nlXK3urtEgaJxCJ6Rw==
X-Received: by 2002:a5e:a519:0:b0:786:e0d0:78b4 with SMTP id 25-20020a5ea519000000b00786e0d078b4mr2881191iog.9.1689277686393;
        Thu, 13 Jul 2023 12:48:06 -0700 (PDT)
Received: from localhost (dhcp-72-235-13-41.hawaiiantel.net. [72.235.13.41])
        by smtp.gmail.com with ESMTPSA id s22-20020a02cc96000000b0041d859c5721sm2094051jap.64.2023.07.13.12.48.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 12:48:05 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Thu, 13 Jul 2023 09:48:04 -1000
From: Tejun Heo <tj@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrea Righi <andrea.righi@canonical.com>, mingo@redhat.com,
	peterz@infradead.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	bristot@redhat.com, vschneid@redhat.com, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org,
	joshdon@google.com, brho@google.com, pjt@google.com,
	derkling@google.com, haoluo@google.com, dvernet@meta.com,
	dschatzberg@meta.com, dskarlat@cs.cmu.edu, riel@surriel.com,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH 27/34] sched_ext: Implement SCX_KICK_WAIT
Message-ID: <ZLBU9O-f9vHcSmNP@slm.duckdns.org>
References: <20230711011412.100319-1-tj@kernel.org>
 <20230711011412.100319-28-tj@kernel.org>
 <ZLAAEnd2HOinKrA+@righiandr-XPS-13-7390>
 <CAHk-=wiT-nr-kRON8vToQSbMhijztp8LV=Y0PgjLJhgDPckxPA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiT-nr-kRON8vToQSbMhijztp8LV=Y0PgjLJhgDPckxPA@mail.gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello,

On Thu, Jul 13, 2023 at 11:32:37AM -0700, Linus Torvalds wrote:
> On Thu, 13 Jul 2023 at 06:46, Andrea Righi <andrea.righi@canonical.com> wrote:
> >
> > I'm not sure if we already have an equivalent of
> > smp_store_release_u64/smp_load_acquire_u64(). Otherwise, it may be worth
> > to add them to a more generic place.
> 
> Yeah, a 64-bit atomic load/store is not necessarily even possible on
> 32-bit architectures.
> 
> And when it *is* possible, it might be very very expensive indeed (eg
> on 32-bit x86, the way to do a 64-bit load would be with "cmpxchg8b",
> which is ridiculously slow)

There are two places where sched_ext is depending on atomic load/store.
One's this pnt_seq which is using smp_store_release/load_acquire(). The
other is task_struct->scx.ops_state which uses atomic64_read_acquire() and
atomic64_store_release(). atomic64's are implemented with spinlocks on
32bits by default which is probably why Andrea didn't hit it.

pnt_seq is a per-cpu counter for successful pick_next_task's from sched_ext
and used to tell "has at least one pick_next_task() succeeded after my
kicking that CPU".

p->scx_ops.state has embedded qseq counter (2bits for state flags, the rest
for the counter. I gotta change the masks to macros too.) which is used to
detect whether the task has been dequeued and re-enqueued between while a
CPU is trying to double lock rq's for task migration.

As both are used to detect races in very short and immediate time windows,
using, respectively, 32bit and 30bit, should be safe practically. e.g. while
it's theoretically possible for the task to be dequeued and re-enqueued
exactly 2^30 times while the CPU is trying to switch rq locks, I don't think
that's practically possible without something going very wrong with the
machine (e.g. NMI / SMI).

I'll note the above and change both to unsigned longs.

Thanks.

-- 
tejun

