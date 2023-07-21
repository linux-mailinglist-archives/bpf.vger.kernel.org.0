Return-Path: <bpf+bounces-5645-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06B6975D05D
	for <lists+bpf@lfdr.de>; Fri, 21 Jul 2023 19:08:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B68B1C2172D
	for <lists+bpf@lfdr.de>; Fri, 21 Jul 2023 17:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79874200AE;
	Fri, 21 Jul 2023 17:08:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A0727F00
	for <bpf@vger.kernel.org>; Fri, 21 Jul 2023 17:08:32 +0000 (UTC)
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91D80E6F
	for <bpf@vger.kernel.org>; Fri, 21 Jul 2023 10:08:31 -0700 (PDT)
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7656652da3cso184036985a.1
        for <bpf@vger.kernel.org>; Fri, 21 Jul 2023 10:08:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689959310; x=1690564110;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gya8EGKPA3sm2cDghhL4fhnxm+DjlM2tMq1NImLGPrI=;
        b=A6nPi09cizCensBhoZBaoUmV2DrFTgL7mTp4JFzAjcYpXVJ8JuP2KTULZOkFGomMKl
         xrxH2n10zgSYpWm6J06pQdac5coi6pu9SY8I6ck3/bfG9BK5K092i4TyI1as8HaAd6d/
         fl85qhAq4zBLqFM9UWqJ9dsQ0BuPBsu9YYKXJdrJVfCKOkIxFVq2wiHOuM8F7K7PvY7u
         ExnPL6h9zviZwBT+sJjnLOJ1FlpkZtjIhWxWnNnBRqlbrCaO7lDu0nYidz8kR9dSBq/2
         u4bG0xGQV3UGrNb78WovsaiopVSg5IDax2QG8t/9ru+rK5sMyolHpf2mwG5ElEMIQIws
         cIww==
X-Gm-Message-State: ABy/qLagLdLOuR1WLoNCOkn2nmiR8lSRV8M0I7yOb2o0ZzS6LLi+qsLF
	ZSFyVrtqCcCOmKZ75e+y3Ac=
X-Google-Smtp-Source: APBJJlGsrCo2dF2KpJ7z+rd6n1nxYrZnIS1nJFUhbpONS4TbIa+fs1VWBOLAZsy1Rqcv8NjwzuzQxg==
X-Received: by 2002:a05:620a:28cd:b0:765:8986:a3bd with SMTP id l13-20020a05620a28cd00b007658986a3bdmr722852qkp.69.1689959310583;
        Fri, 21 Jul 2023 10:08:30 -0700 (PDT)
Received: from maniforge ([2620:10d:c091:400::5:fac6])
        by smtp.gmail.com with ESMTPSA id w26-20020a05620a149a00b00767ceac979asm1235446qkj.42.2023.07.21.10.08.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 10:08:30 -0700 (PDT)
Date: Fri, 21 Jul 2023 12:08:28 -0500
From: David Vernet <void@manifault.com>
To: Matt Bobrowski <mattbobrowski@google.com>
Cc: bpf@vger.kernel.org, memxor@gmail.com
Subject: Re: BPF/Question: PTR_TRUSTED vs PTR_UNTRUSTED
Message-ID: <20230721170828.GD52260@maniforge>
References: <ZIl0+n1Q5yn2r5vL@google.com>
 <20230615174033.GA2915572@maniforge>
 <ZLlEt0J+O7XqnQFb@google.com>
 <20230720151622.GA52260@maniforge>
 <ZLq15qZWLhHzXJli@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZLq15qZWLhHzXJli@google.com>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jul 21, 2023 at 04:44:22PM +0000, Matt Bobrowski wrote:
> On Thu, Jul 20, 2023 at 10:16:22AM -0500, David Vernet wrote:
> > > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > > index fa43dc8e85b9..8b8ccde342f9 100644
> > > > --- a/kernel/bpf/verifier.c
> > > > +++ b/kernel/bpf/verifier.c
> > > > @@ -5857,6 +5857,7 @@ BTF_TYPE_SAFE_RCU(struct task_struct) {
> > > >         struct css_set __rcu *cgroups;
> > > >         struct task_struct __rcu *real_parent;
> > > >         struct task_struct *group_leader;
> > > > + struct fs_struct *fs;
> > > >  };
> > > 
> > > Oh, right. So, if we explicitly dereference the struct fs_struct
> > > member of struct task_struct within a RCU read-side critical section,
> > > the BPF verifier considers the pointer to struct fs_struct as being
> > > safe and trusted. Is that right?
> > 
> > With the above patch, yes.
> 
> After conducting some further tests today, it turns out that making
> amendments to the struct task_struct BTF_TYPE_SAFE_RCU definition
> perhaps isn't actually necessary? As of commit afeebf9f57a49 ("bpf:
> Undo strict enforcement for walking untagged fields"), if a trusted
> pointer (in this case being struct task_struct obtained via
> bpf_get_current_task_btf()) is dereferenced within a RCU read-side
> critical section, then the pointer that is yielded as a result of the
> walk/dereference operation is a PTR_TO_BTF_ID. It is neither trusted
> or untrusted and therefore carries the same level of semantics as a
> dereferenced pointer before any trust status for pointers was
> introduced within the BPF verifier.
> 
> Have I misunderstood something here?

No, that's correct. You only need the aforementioned patch if you need
the pointer to be a trusted or RCU pointer.

> > > Why is it that we need to explicitly add it to such lists so that
> > > they're considered to be trusted and cannot simply perform the
> > > bpf_rcu_read_lock/unlock() dance from within the BPF program? Also,
> > > should we not add the field to BTF_TYPE_SAFE_RCU_OR_NULL() instead of
> > > BTF_TYPE_SAFE_RCU(), as struct fs_struct could perhaps be NULL in some
> > > circumstances?
> > 
> > I recommend doing some git log / git blame digging. All of this
> > information was captured in prior discussions. For example, in the patch
> > [0] which added these structs.
> > 
> > [0]: https://lore.kernel.org/bpf/20230303041446.3630-7-alexei.starovoitov@gmail.com/
> > 
> > > Are you OK with me carrying this recommended patch to the mailing
> > > list?
> > 
> > Of course
> 
> Based on what I've mentioned above, perhaps sending through a patch no
> longer is necessary?

If you only need to call bpf_d_path() then yes, you shouldn't need the
patch.

