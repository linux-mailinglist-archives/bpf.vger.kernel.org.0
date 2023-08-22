Return-Path: <bpf+bounces-8293-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8496784ACB
	for <lists+bpf@lfdr.de>; Tue, 22 Aug 2023 21:47:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 718602811E6
	for <lists+bpf@lfdr.de>; Tue, 22 Aug 2023 19:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B70E42019B;
	Tue, 22 Aug 2023 19:46:47 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE9920186
	for <bpf@vger.kernel.org>; Tue, 22 Aug 2023 19:46:47 +0000 (UTC)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64995CCB
	for <bpf@vger.kernel.org>; Tue, 22 Aug 2023 12:46:46 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1bc0d39b52cso32292495ad.2
        for <bpf@vger.kernel.org>; Tue, 22 Aug 2023 12:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692733606; x=1693338406;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mpUd4Xvv/qtthQLCrnM4XyQiw1F8WSpBmS6+o7vPpS0=;
        b=Am0OEo6geCDvXWXr4jXbYYjDBEEl+IGnfvWf9JdN6wyHzKXOp+AO6y+DLzvR21c9gH
         BXiJC2XGDAUIa4+TSxBjwNtu1EBde8lYmZcX3n4u+j8vGQ4bS4vB0Iltbcbp3ZImuShr
         hu/AmgY7+gL5JPEXfZ4+fFhepSrlpNRLVq4sVvEXDyiA9+WXxpas6rNWRytdzCxQwTuP
         7+tVtBjyvxFt2s7fD/fQxQ+XMYX3EysMAaQGQKKZDB9sfapwOhr4ZPaSv8vQDR9kjTeu
         0+ZH1sd86+5qwbgvJm321TzllU07ap0eWKOeClWu5VcRJZiwMrC5M3TfYDir8HFmclYz
         H/VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692733606; x=1693338406;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mpUd4Xvv/qtthQLCrnM4XyQiw1F8WSpBmS6+o7vPpS0=;
        b=ew1A/sgEhuAL/znjEC+uCD4oNBd5C1XNB/kCt9JSjAQZAkJZnZSg1Gs6+H3s/8EQyL
         2mmwKTcRevT+DPCUCk3KNXeoIBMY63wjrv3GJjr/a6YopQCDmpfKZcysIG58eizP0l3w
         HA03LG8aoyZvsHHvaTANWg5hypbRSrFh3Inyjb8qa1FYFKi3TNX1vmt4YSBhg6bqEQtC
         2FZkUrN5aihOQNF15wq5ZCOt85Y3nzZbBVmBlDaMUgFgvt5zKadj3kh/Qq3TT0jjXWqW
         NDfX+VBnLbyUAV0fiswRhIm//1TmtHcA55BEa4HdZMWoKr1znxxNOanRvDOWKtmPri1K
         7vDw==
X-Gm-Message-State: AOJu0Yy15pq2YEPjViFJ8kO+u7N0VENecRNug9QddGr8nHPJUn6VIdzc
	kXijkWdqFE0HJlwK/LpyURSl32GHLjQ=
X-Google-Smtp-Source: AGHT+IGvplrUEBZ81iw8Mwug+Zg+A7HBtFgHZgbpZTgPBJpjp/pcX0R3m73UM29nXsXRH/4rGUlKkA==
X-Received: by 2002:a17:902:e5d2:b0:1bc:81f2:ddf0 with SMTP id u18-20020a170902e5d200b001bc81f2ddf0mr8949705plf.67.1692733605647;
        Tue, 22 Aug 2023 12:46:45 -0700 (PDT)
Received: from MacBook-Pro-8.local ([2620:10d:c090:500::6:2150])
        by smtp.gmail.com with ESMTPSA id y6-20020a17090322c600b001b8a3dd5a4asm9371831plg.283.2023.08.22.12.46.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 12:46:45 -0700 (PDT)
Date: Tue, 22 Aug 2023 12:46:42 -0700
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: Dave Marchevsky <davemarchevsky@fb.com>, bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH v2 bpf-next 6/7] bpf: Allow bpf_spin_{lock,unlock} in
 sleepable progs
Message-ID: <20230822194642.rt4plvim7m77tlkh@MacBook-Pro-8.local>
References: <20230821193311.3290257-1-davemarchevsky@fb.com>
 <20230821193311.3290257-7-davemarchevsky@fb.com>
 <3a24babf-c4e0-11a2-e4a7-3d14b8858d88@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a24babf-c4e0-11a2-e4a7-3d14b8858d88@linux.dev>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Aug 21, 2023 at 07:53:22PM -0700, Yonghong Song wrote:
> 
> 
> On 8/21/23 12:33 PM, Dave Marchevsky wrote:
> > Commit 9e7a4d9831e8 ("bpf: Allow LSM programs to use bpf spin locks")
> > disabled bpf_spin_lock usage in sleepable progs, stating:
> > 
> >   Sleepable LSM programs can be preempted which means that allowng spin
> >   locks will need more work (disabling preemption and the verifier
> >   ensuring that no sleepable helpers are called when a spin lock is
> >   held).
> > 
> > This patch disables preemption before grabbing bpf_spin_lock. The second
> > requirement above "no sleepable helpers are called when a spin lock is
> > held" is implicitly enforced by current verifier logic due to helper
> > calls in spin_lock CS being disabled except for a few exceptions, none
> > of which sleep.
> > 
> > Due to above preemption changes, bpf_spin_lock CS can also be considered
> > a RCU CS, so verifier's in_rcu_cs check is modified to account for this.
> > 
> > Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
> > ---
> >   kernel/bpf/helpers.c  | 2 ++
> >   kernel/bpf/verifier.c | 9 +++------
> >   2 files changed, 5 insertions(+), 6 deletions(-)
> > 
> > diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> > index 945a85e25ac5..8bd3812fb8df 100644
> > --- a/kernel/bpf/helpers.c
> > +++ b/kernel/bpf/helpers.c
> > @@ -286,6 +286,7 @@ static inline void __bpf_spin_lock(struct bpf_spin_lock *lock)
> >   	compiletime_assert(u.val == 0, "__ARCH_SPIN_LOCK_UNLOCKED not 0");
> >   	BUILD_BUG_ON(sizeof(*l) != sizeof(__u32));
> >   	BUILD_BUG_ON(sizeof(*lock) != sizeof(__u32));
> > +	preempt_disable();
> >   	arch_spin_lock(l);
> >   }
> > @@ -294,6 +295,7 @@ static inline void __bpf_spin_unlock(struct bpf_spin_lock *lock)
> >   	arch_spinlock_t *l = (void *)lock;
> >   	arch_spin_unlock(l);
> > +	preempt_enable();
> >   }
> 
> preempt_disable()/preempt_enable() is not needed. Is it possible we can

preempt_disable is needed in all cases. This mistake slipped in when
we converted preempt disabled bpf progs into migrate disabled.
For example, see how raw_spin_lock is doing it.

