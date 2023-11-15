Return-Path: <bpf+bounces-15099-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 956327EC91D
	for <lists+bpf@lfdr.de>; Wed, 15 Nov 2023 18:00:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9C73B20C1C
	for <lists+bpf@lfdr.de>; Wed, 15 Nov 2023 17:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EED653EA88;
	Wed, 15 Nov 2023 17:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="I6Vk5XWU"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DCB43EA6F
	for <bpf@vger.kernel.org>; Wed, 15 Nov 2023 17:00:27 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68C1CFA;
	Wed, 15 Nov 2023 09:00:24 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 74C5B22914;
	Wed, 15 Nov 2023 17:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1700067621; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bzi5q2POrzZglBN2JQhbBgQiExoELJgTIynNQ9Q/jgs=;
	b=I6Vk5XWUzDNZAfxjslKVM/VVi2h5E73QmYLsb+37VSUQD/IHEbP1zxg2lUQBQgSTIB0DYm
	ep3CtN9tPb4HyyudoXMqXZ8WCEylJiET54RHr3SekXE+oNsGgY1cvEjYw9URhoDjc9N+++
	QEYH0+aAzWJ0B0TD3yP4NBDDGZ9ERGc=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 055B613592;
	Wed, 15 Nov 2023 17:00:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id uARxOiT5VGXBOwAAMHmgww
	(envelope-from <mhocko@suse.com>); Wed, 15 Nov 2023 17:00:20 +0000
Date: Wed, 15 Nov 2023 18:00:20 +0100
From: Michal Hocko <mhocko@suse.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: Casey Schaufler <casey@schaufler-ca.com>, akpm@linux-foundation.org,
	paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
	linux-mm@kvack.org, linux-security-module@vger.kernel.org,
	bpf@vger.kernel.org, ligang.bdlg@bytedance.com
Subject: Re: [RFC PATCH -mm 0/4] mm, security, bpf: Fine-grained control over
 memory policy adjustments with lsm bpf
Message-ID: <ZVT5JG_osL7yFHHA@tiehlicka>
References: <20231112073424.4216-1-laoar.shao@gmail.com>
 <188dc90e-864f-4681-88a5-87401c655878@schaufler-ca.com>
 <CALOAHbD+_0tHcm72Q6TM=EXDoZFrVWAsi4AC8_xGqK3wGkEy3g@mail.gmail.com>
 <ZVNIprbQU3NqwPi_@tiehlicka>
 <CALOAHbDi_8ERHdtPB6sJdv=qewoAfGkheCfriW+QLoN0rLUQAw@mail.gmail.com>
 <b13050b3-54f8-431a-abcf-1323a9791199@schaufler-ca.com>
 <CALOAHbBKCsdmko_ugHZ_z6Zpgo-xJ8j46oPHkHj+gBGsRCR=eA@mail.gmail.com>
 <ZVSFNzf4QCbpLGyF@tiehlicka>
 <CALOAHbAjHJ_47b15v3d+f3iZZ+vBVsLugKew_t_ZFaJoE2_3uw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALOAHbAjHJ_47b15v3d+f3iZZ+vBVsLugKew_t_ZFaJoE2_3uw@mail.gmail.com>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -1.10
X-Spamd-Result: default: False [-1.10 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 RCPT_COUNT_SEVEN(0.00)[10];
	 FREEMAIL_TO(0.00)[gmail.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_COUNT_TWO(0.00)[2];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]

On Wed 15-11-23 17:33:51, Yafang Shao wrote:
> On Wed, Nov 15, 2023 at 4:45 PM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Wed 15-11-23 09:52:38, Yafang Shao wrote:
> > > On Wed, Nov 15, 2023 at 12:58 AM Casey Schaufler <casey@schaufler-ca.com> wrote:
> > > >
> > > > On 11/14/2023 3:59 AM, Yafang Shao wrote:
> > > > > On Tue, Nov 14, 2023 at 6:15 PM Michal Hocko <mhocko@suse.com> wrote:
> > > > >> On Mon 13-11-23 11:15:06, Yafang Shao wrote:
> > > > >>> On Mon, Nov 13, 2023 at 12:45 AM Casey Schaufler <casey@schaufler-ca.com> wrote:
> > > > >>>> On 11/11/2023 11:34 PM, Yafang Shao wrote:
> > > > >>>>> Background
> > > > >>>>> ==========
> > > > >>>>>
> > > > >>>>> In our containerized environment, we've identified unexpected OOM events
> > > > >>>>> where the OOM-killer terminates tasks despite having ample free memory.
> > > > >>>>> This anomaly is traced back to tasks within a container using mbind(2) to
> > > > >>>>> bind memory to a specific NUMA node. When the allocated memory on this node
> > > > >>>>> is exhausted, the OOM-killer, prioritizing tasks based on oom_score,
> > > > >>>>> indiscriminately kills tasks. This becomes more critical with guaranteed
> > > > >>>>> tasks (oom_score_adj: -998) aggravating the issue.
> > > > >>>> Is there some reason why you can't fix the callers of mbind(2)?
> > > > >>>> This looks like an user space configuration error rather than a
> > > > >>>> system security issue.
> > > > >>> It appears my initial description may have caused confusion. In this
> > > > >>> scenario, the caller is an unprivileged user lacking any capabilities.
> > > > >>> While a privileged user, such as root, experiencing this issue might
> > > > >>> indicate a user space configuration error, the concerning aspect is
> > > > >>> the potential for an unprivileged user to disrupt the system easily.
> > > > >>> If this is perceived as a misconfiguration, the question arises: What
> > > > >>> is the correct configuration to prevent an unprivileged user from
> > > > >>> utilizing mbind(2)?"
> > > > >> How is this any different than a non NUMA (mbind) situation?
> > > > > In a UMA system, each gigabyte of memory carries the same cost.
> > > > > Conversely, in a NUMA architecture, opting to confine processes within
> > > > > a specific NUMA node incurs additional costs. In the worst-case
> > > > > scenario, if all containers opt to bind their memory exclusively to
> > > > > specific nodes, it will result in significant memory wastage.
> > > >
> > > > That still sounds like you've misconfigured your containers such
> > > > that they expect to get more memory than is available, and that
> > > > they have more control over it than they really do.
> > >
> > > And again: What configuration method is suitable to limit user control
> > > over memory policy adjustments, besides the heavyweight seccomp
> > > approach?
> >
> > This really depends on the workloads. What is the reason mbind is used
> > in the first place?
> 
> It can improve their performance.
> 
> > Is it acceptable to partition the system so that
> > there is a numa node reserved for NUMA aware workloads?
> 
> As highlighted in the commit log, our preference is to configure this
> memory policy through kubelet using cpuset.mems in the cpuset
> controller, rather than allowing individual users to set it
> independently.

OK, I have missed that part.

> > If not, have you
> > considered (already proposed numa=off)?
> 
> The challenge at hand isn't solely about whether users should bind to
> a memory node or the deployment of workloads. What we're genuinely
> dealing with is the fact that users can bind to a specific node
> without our explicit agreement or authorization.

mbind outside of the cpuset shouldn't be possible (policy_nodemask). So
if you are configuring cpusets already then mbind should add much to a
problem. I can see how you can have problems when you do not have any
NUMA partitioning in place because mixing NUMA aware and unaware
workloads doesn't really work out well when the memory is short on
supply.
-- 
Michal Hocko
SUSE Labs

