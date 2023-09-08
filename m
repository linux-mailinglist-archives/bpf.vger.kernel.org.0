Return-Path: <bpf+bounces-9557-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BFE4B799209
	for <lists+bpf@lfdr.de>; Sat,  9 Sep 2023 00:07:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69978281C5D
	for <lists+bpf@lfdr.de>; Fri,  8 Sep 2023 22:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8277EB649;
	Fri,  8 Sep 2023 22:07:36 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F3CB643
	for <bpf@vger.kernel.org>; Fri,  8 Sep 2023 22:07:36 +0000 (UTC)
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D852F1FCA
	for <bpf@vger.kernel.org>; Fri,  8 Sep 2023 15:07:32 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-573f722b86eso1930493a12.1
        for <bpf@vger.kernel.org>; Fri, 08 Sep 2023 15:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694210852; x=1694815652; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zt6hYgn3Ous9Au4d5GwRFSvf11hCq9Ot7Mad1hvaRo8=;
        b=HoS7s5oa381GMwPR0GLL3fAmbBEGNTL2rf8ZUidHyA0J/B0sAQ3JEfx6jHdA5LHA3i
         ip37e+bqya35zB3Js9DuZuStv13FL3bfROJ330ydN444nQ3P7OWdTCfSEsfVAzBAhm3b
         kl1xURlBgAzX5O0ylGAwnK9QoqpsOf0saf5tNKBTn++lEWNAy+K9r111X+gB/X6QfBNP
         EOG/Mtya4Y95Ns9nm69utVPa0EoOzoiyD39FCx0YZInpBfnP9bgLbLzHZN1l3f3HzZJL
         AJGA5Gbs9FkQgp5kzKAV3G0HMnIdm+EXVuwqNBmiB2PbsvsRKDH98DhosZfv0LtA+E5m
         x/Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694210852; x=1694815652;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zt6hYgn3Ous9Au4d5GwRFSvf11hCq9Ot7Mad1hvaRo8=;
        b=kSvrs+4+VTmI9jyxuCYOEkQMYQlkPwh9BY6oWisRb8uqPhSoCG2BoJzWA4qe1h7t92
         2vDNdpZxUFjkj5kD5VLUlI2ms9RdyaeD/fRYvJ57bFRPR5bDMWygK4On+tNgBntbJ2ld
         F8YSeEJQAw87e0R9sQf58qfp8Rn5IxOyY0ux2o0cZVbtqpb7vaROVc7Rg7dUSsYH/nXE
         r4GTowwr7L739uXCM/SWWsQcsgTAd3ZsAJM+cAc6UTla2kFHIMQgY7Fz7E1fdJxu6cNq
         bf5ZokDwDkzht2GLfzAMmnX8lsw+o8l7XaecJ6eZQdOiNqqipPfMAAa8Z3dYy5ih54UQ
         Zibw==
X-Gm-Message-State: AOJu0YxIdYIrPmMPAAN7lI1Ru+bFUBK/CD8QCs+8VioBj8gYt/bCiQoE
	UZXGKnhaWjITZQFn4BCIZik=
X-Google-Smtp-Source: AGHT+IGNz/WWQXAA8E9yJxP5Uw5ouaZzmEuylmdxDDskkgQWznC8PmuG2Pf6zKyXEnXblTtZrm8UKg==
X-Received: by 2002:a05:6a21:4985:b0:14c:5c5e:7d42 with SMTP id ax5-20020a056a21498500b0014c5c5e7d42mr4033935pzc.35.1694210852062;
        Fri, 08 Sep 2023 15:07:32 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:2fd6])
        by smtp.gmail.com with ESMTPSA id z14-20020aa791ce000000b00686fe7b7b48sm1698843pfa.121.2023.09.08.15.07.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Sep 2023 15:07:31 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Fri, 8 Sep 2023 12:07:29 -1000
From: Tejun Heo <tj@kernel.org>
To: Josh Don <joshdon@google.com>
Cc: paulmck@kernel.org, Hao Luo <haoluo@google.com>,
	davemarchevsky@meta.com, David Vernet <dvernet@meta.com>,
	Neel Natu <neelnatu@google.com>,
	Jack Humphries <jhumphri@google.com>, bpf@vger.kernel.org,
	ast@kernel.org
Subject: Re: BPF memory model
Message-ID: <ZPubIZLXFuAsfN7a@slm.duckdns.org>
References: <CABk29NuQ4C-w_JA-zev796Nr_vx932qC4_OcdH=gMM6HZ_r4WQ@mail.gmail.com>
 <33f06fa6-2f4d-4e50-a87e-0d6604d3c413@paulmck-laptop>
 <CABk29Nva+c6oBZra6srWGcfxMEquOP30dReM-PgW_Wh+zKiBuQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABk29Nva+c6oBZra6srWGcfxMEquOP30dReM-PgW_Wh+zKiBuQ@mail.gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello,

On Fri, Sep 08, 2023 at 01:26:11PM -0700, Josh Don wrote:
> I'm writing BPF programs for scheduling (ie. sched_ext), so these are
> getting invoked in hot paths and invoked concurrently across multiple
> cpus (for example, pick_next_task, enqueue_task, etc.). The kernel is
> responsible for relaying ground truth, userspace makes O(ms)
> scheduling decisions, and BPF makes O(us) scheduling decisions.
> BPF-BPF concurrency is possible with spinlocks and RMW, BPF-userspace
> can currently only really use RMW. My line of questioning is more
> forward looking, as I'm preemptively thinking of how to ensure
> kernel-like scheduling performance, since BPF spinlock or RMW is
> sometimes overkill :) I would think that barrier() and smp_mb() would
> probably be the minimum viable set (at least for x86) that people
> would find useful, but maybe others can chime in.

My personal favorite set is store_release/load_acquire(). I have a hard time
thinking up cases which can't be covered by them and they're basically free
on x86.

Thanks.

-- 
tejun

