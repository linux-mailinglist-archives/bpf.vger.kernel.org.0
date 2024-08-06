Return-Path: <bpf+bounces-36450-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 741A99489C8
	for <lists+bpf@lfdr.de>; Tue,  6 Aug 2024 09:08:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC64BB24208
	for <lists+bpf@lfdr.de>; Tue,  6 Aug 2024 07:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4BC0165F1C;
	Tue,  6 Aug 2024 07:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y23GrRCM"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912B7165F08
	for <bpf@vger.kernel.org>; Tue,  6 Aug 2024 07:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722928103; cv=none; b=GFBZ3sTsm+HI8EKuqKJ0vkQp7JoC0V1gvm1JICSZzBwMbLk1TWHO/Wu8KfKNL34jmk2D4zHQ1E8JRXV+vCM25hKJ3KkZk71xByZNCoruC1Rn3hhP/jvv3m1yzSoRJ9m4vlXjjqzKzhiIhQJSIIWbBFpg+ZucsK2NsUDMNAqr5hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722928103; c=relaxed/simple;
	bh=ajLRYujjc9QWRsXrB8TNBvB8wHVcDxiY2/xpjxLe2K4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IY76xXPwrna5SUF6CmS4ldv1Ocsl8a/WR5LhvM7IGynGg7MRyZKpOQAxByO3wtwTzyY4F1caZ3qD7nFt2mjVOGWWcee2BOlGC+24eVcy+SDuZ1rvbYa6jc3ol9eJqMrWk7AsODl/elQHd6lfAgwJT0rlA6BenfYA4CazpPreC8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y23GrRCM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722928100;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E2EC28zQ430Ls/AziiSrlmM1nMGgrya6wtZKA2XHYg4=;
	b=Y23GrRCMQQmmRLADnO2NUuSlstQc7xQ4jqJKX3Za9dRr+9LqYLc8E2LjGLOMr9X/9b/Eys
	ToeD7Ld5X0+5FliXf9hXAWzGdd+HqiScic2NECFzZLtuiAhUPUKxFlonXPU9DjEVt3rAD+
	21kwasXZsRvogKdVUyKvtfHjUUbDAwA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-220-w-yL8gndOLi2irxhsD3gnA-1; Tue, 06 Aug 2024 03:08:19 -0400
X-MC-Unique: w-yL8gndOLi2irxhsD3gnA-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-428076fef5dso2869785e9.2
        for <bpf@vger.kernel.org>; Tue, 06 Aug 2024 00:08:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722928097; x=1723532897;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E2EC28zQ430Ls/AziiSrlmM1nMGgrya6wtZKA2XHYg4=;
        b=DpZV+BCRp+zPd8cnBpk7Aw14T+H/56wibaLCbRGqMptsHpeG/zFrVw7Fwvjo4ZBvmk
         ZmU1TuW4YwzgJzBxkgM3JT3u3NU043537fYTldVNioOLli680pqcMadCLKgs8hh2n/0y
         aXn1T3Fs1hiigR5Qpv+RlD+tG4BQPyKybmhihhpenDVMYvkCgdoggChk9Rznzd3FqwtR
         LlycY88MNgIN+RoQMLt+KcRjnn8tuBtj5Ht7e7nFnt+DrrCJRubbnOp09DsNjQGFinMg
         vMDQqK0X9TNXVhVSVhO8tlV7teukn9Dv5XLZ2PtbGkoWmeCubhdGi1CnlBxz4HkBLDal
         u5dw==
X-Forwarded-Encrypted: i=1; AJvYcCU6Ul9DVdlnQPXF5ztxeEfI3qMcmBl1zWcfVvaad1wnKLRSFTbz0EwHWGnUHFK6dvcdBrzjRSf0dRvWLWPE4T8hegg+
X-Gm-Message-State: AOJu0YwWcOO35VZghp0hUYr8/3phapdmojN3LT2gLykRzHqfGTccuX0u
	DtjZY2sFBS+n+4quH2wD/0kkfBf6tbrWLnpFgOYeezlhXC1/YfTfkffRr/EwATwuYA2pTpEcGzW
	rYM+7cRokLw7QdAv480ix+GtRjFT/5qlJLfWNgp9xbYzonUbq7jtdMci5pg==
X-Received: by 2002:a5d:5e11:0:b0:36b:cc42:29f9 with SMTP id ffacd0b85a97d-36bcc422dbcmr6475755f8f.51.1722928097320;
        Tue, 06 Aug 2024 00:08:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFbIEjqYZG/JsSsab+D6UceVhz0kBuqHI0/D9xOElxV5tsgsex1ZdX75f/L8FRiaklhaRxbXA==
X-Received: by 2002:a5d:5e11:0:b0:36b:cc42:29f9 with SMTP id ffacd0b85a97d-36bcc422dbcmr6475736f8f.51.1722928096819;
        Tue, 06 Aug 2024 00:08:16 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.159.67])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36bbd06df9esm11978662f8f.100.2024.08.06.00.08.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 00:08:16 -0700 (PDT)
Date: Tue, 6 Aug 2024 09:08:13 +0200
From: Juri Lelli <juri.lelli@redhat.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, bpf <bpf@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Artem Savkov <asavkov@redhat.com>
Subject: Re: NULL pointer deref when running BPF monitor program (6.11.0-rc1)
Message-ID: <ZrHL3YU1kfth3enJ@jlelli-thinkpadt14gen4.remote.csb>
References: <ZrCZS6nisraEqehw@jlelli-thinkpadt14gen4.remote.csb>
 <ZrECsnSJWDS7jFUu@krava>
 <CAADnVQLMPPavJQR6JFsi3dtaaLHB816JN4HCV_TFWohJ61D+wQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQLMPPavJQR6JFsi3dtaaLHB816JN4HCV_TFWohJ61D+wQ@mail.gmail.com>

Hi Jiri and Alexei,

On 05/08/24 10:00, Alexei Starovoitov wrote:
> On Mon, Aug 5, 2024 at 9:50 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> >
> > On Mon, Aug 05, 2024 at 11:20:11AM +0200, Juri Lelli wrote:
> >
> > SNIP
> >
> > > [  154.566882] BUG: kernel NULL pointer dereference, address: 000000000000040c
> > > [  154.573844] #PF: supervisor read access in kernel mode
> > > [  154.578982] #PF: error_code(0x0000) - not-present page
> > > [  154.584122] PGD 146fff067 P4D 146fff067 PUD 10fc00067 PMD 0
> > > [  154.589780] Oops: Oops: 0000 [#1] PREEMPT SMP NOPTI
> > > [  154.594659] CPU: 28 UID: 0 PID: 2234 Comm: thread0-13 Kdump: loaded Not tainted 6.11.0-rc1 #8
> > > [  154.603179] Hardware name: Dell Inc. PowerEdge R740/04FC42, BIOS 2.10.2 02/24/2021
> > > [  154.610744] RIP: 0010:bpf_prog_ec8173ca2868eb50_handle__sched_pi_setprio+0x22/0xd7
> > > [  154.618310] Code: cc cc cc cc cc cc cc cc 0f 1f 44 00 00 66 90 55 48 89 e5 48 81 ec 30 00 00 00 53 41 55 41 56 48 89 fb 4c 8b 6b 00 4c 8b 73 08 <41> 8b be 0c 04 00 00 48 83 ff 06 0f 85 9b 00 00 00 41 8b be c0 09
> > > [  154.637052] RSP: 0018:ffffabac60aebbc0 EFLAGS: 00010086
> > > [  154.642278] RAX: ffffffffc03fba5c RBX: ffffabac60aebc28 RCX: 000000000000001f
> > > [  154.649411] RDX: ffff95a90b4e4180 RSI: ffffabac4e639048 RDI: ffffabac60aebc28
> > > [  154.656544] RBP: ffffabac60aebc08 R08: 00000023fce7674a R09: ffff95a91d85af38
> > > [  154.663674] R10: ffff95a91d85a0c0 R11: 000000003357e518 R12: 0000000000000000
> > > [  154.670807] R13: ffff95a90b4e4180 R14: 0000000000000000 R15: 0000000000000001
> > > [  154.677939] FS:  00007ffa6d600640(0000) GS:ffff95c01bf00000(0000) knlGS:0000000000000000
> > > [  154.686026] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > [  154.691769] CR2: 000000000000040c CR3: 000000014b9f2005 CR4: 00000000007706f0
> > > [  154.698903] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > > [  154.706035] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > > [  154.713168] PKRU: 55555554
> > > [  154.715879] Call Trace:
> > > [  154.718332]  <TASK>
> > > [  154.720439]  ? __die+0x20/0x70
> > > [  154.723498]  ? page_fault_oops+0x75/0x170
> > > [  154.727508]  ? sysvec_irq_work+0xb/0x90
> > > [  154.731348]  ? exc_page_fault+0x64/0x140
> > > [  154.735275]  ? asm_exc_page_fault+0x22/0x30
> > > [  154.739461]  ? 0xffffffffc03fba5c
> > > [  154.742780]  ? bpf_prog_ec8173ca2868eb50_handle__sched_pi_setprio+0x22/0xd7
> >
> > hi,
> > reproduced.. AFAICS looks like the bpf program somehow lost the booster != NULL
> > check and just load the policy field without it and crash when booster is rubbish
> >
> > int handle__sched_pi_setprio(u64 * ctx):
> > ; int handle__sched_pi_setprio(u64 *ctx)
> >    0: (bf) r6 = r1
> > ; struct task_struct *boosted = (void *) ctx[0];
> >    1: (79) r7 = *(u64 *)(r6 +0)
> > ; struct task_struct *booster = (void *) ctx[1];
> >    2: (79) r8 = *(u64 *)(r6 +8)
> > ; if (booster->policy != SCHED_DEADLINE)
> >
> > curious why the check disappeared, because object file has it, so I guess verifier
> > took it out for some reason, will check
> 
> Juri,
> 
> Thanks for flagging!

Thanks for the super quick reply from both of you!

> Jiri,
> 
> the verifier removes the check because it assumes that pointers
> passed by the kernel into tracepoint are valid and trusted.
> In this case:
>         trace_sched_pi_setprio(p, pi_task);
> 
> pi_task can be NULL.
> 
> We cannot make all tracepoint pointers to be PTR_TRUSTED | PTR_MAYBE_NULL
> by default, since it will break a bunch of progs.
> Instead we can annotate this tracepoint arg as __nullable and
> teach the verifier to recognize such special arguments of tracepoints.
> 
> Let's think how to workaround such verifier eagerness to remove != null check.

Of course more than willing to test anything out, but no rush.

Best,
Juri


