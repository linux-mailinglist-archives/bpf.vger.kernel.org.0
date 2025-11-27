Return-Path: <bpf+bounces-75662-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BEBEC9004B
	for <lists+bpf@lfdr.de>; Thu, 27 Nov 2025 20:29:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 846E73470CE
	for <lists+bpf@lfdr.de>; Thu, 27 Nov 2025 19:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D86FC304BDC;
	Thu, 27 Nov 2025 19:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vBZklfQR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7843043DB
	for <bpf@vger.kernel.org>; Thu, 27 Nov 2025 19:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764271766; cv=none; b=CcLzr3AszwVIyIq9jVfdsN6Fz+n9jX7gHD2zuibtbxWUXV198UKYtRh+c1Cfq40XCyHokoU3hnGG/dMcOEFrJVu5P1NRKYyDcRigajClwJHBNo7TZMNSSj4bz7mFkm5VEM2X1Qo1b2IPqfURG/Ujq+ylB7X7fu4q1A3yhhSdvsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764271766; c=relaxed/simple;
	bh=k5fxLNRqsW+8ryiSr+lWXV0En8JIsiil8v85H9BzdfU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YWtdtiAcxdK/bIBlQyAdLaob2NpSh7EyRrYe6SLpafVfXmPq5wzulc+Llebne3WSE5f65e/W1CLkGvR8zro2pJIt2S2beJRyK8kzUY0HhfIBXzcq++ceV09Fgp5wVGZHKzG3h6+GnwMoYQqk5D+VC9uDh8/IPkguI59+v7TgU54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vBZklfQR; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4ee243b98caso289701cf.1
        for <bpf@vger.kernel.org>; Thu, 27 Nov 2025 11:29:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764271762; x=1764876562; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DoIF1SGGEVRiz/EuDnanHFl7GK3C8LRxCxceA/BH30I=;
        b=vBZklfQRebQXKQxyOEr17+YGz2VRgHzstipaQf5wLd9/9Y3GVbAdPn0QJDLlB43YvL
         izCCFdBegHCudbU51PzUEjfoNOnTdl3Ltw9t10w1NNgkCu38KbEo4izZ3REM5hqDL5BA
         lP4mESNSqKoCL3r/xLrthcnzEFOVpdC4qOIpru4m4rkluHZksJs3eypZE8CeKjgzK0yZ
         lfgK0EPE1RrOYFMMrGOepUVpiCr8BmGHOVzQ/9/iGoTZ7/zqV39HIzvLu89DTufSd6gM
         cZVMtXGq7giNoXytorwL0C//nyOP/vJwBQ3aN3knYYwmPAWXfSjd8lfEIJyhbxF65sz9
         5Wkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764271762; x=1764876562;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DoIF1SGGEVRiz/EuDnanHFl7GK3C8LRxCxceA/BH30I=;
        b=HjeEuS0XequiSGc0bQcZ9U+P7Tz4Uo4c5a3xO/JsJM3LJfsVcQ9X1gLrh0lBSmvYhr
         bjAsSr3vZEjObHrsCPuXqo6SBEMjxgoMv9dlp86j3+kN+u1yYguAVctKrz97arZa7pZB
         nsW6XoScoXnVRimasqHVL0oOdp86+52XpIMgbcjm2P6OVk/TuaZ/oMDDekB4AfptcM42
         NrNoubCMB0rdavTvP/z77BBwkQtZNYdET7qnmlcPPZ/D2TzAdbCjcWhiZ/Lo9hDtCT6O
         TiV506IBnX3hLlMjI49uWlRNMOx7sYrVikdMmN8kCzfsUlM+RzGKFBOOuxrsz9KqcrLF
         RGWA==
X-Forwarded-Encrypted: i=1; AJvYcCWdw7IOPaHwjoXlJE19LmsepsqvdAoDgp84eqXwQMEP/YGfh4rw4HwOvpjU2serf/Nn0z8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCMARGQRTetOErfoz/M35IRlfPTYHJCANmJJFdXGkJLDsSGX2O
	yN14wZE7wc6gqdIYXpTJddAF3rAao9V3iOJIXi3E4Tm/a3cxtolEe77vtpOxzMwK3HX4V1tsn9j
	+lLf9NTZmHtOu9WRLMGVicFTJWb4plHBu7eLKWtMS
X-Gm-Gg: ASbGncspW1msWo2gi+uIOsFIzoQQcJvrbFhik2twZSd2HDeko5RZs9xGiZMjJ1Qw9s4
	CEW7GfW2CZQYaNiC3jy7hEq7gXvW1lguj0004h7ZzTj5JdhnRanZNGB2NM1rNVpXh5gu9B0ZORB
	3KfgWxjl0TxIn9/3FMnkI+notd7ri8JKm/LRCE8S3RlezdHlGw7xL+wkN1jahtly+VYZh4OfQuN
	fPwuKvCob8PCSxr3djpw5ZBnxu50uReGv3q+07y8n6GQV5uSHKB2CbewQI2EB4LVqP/h3SbrnP3
	T98G
X-Google-Smtp-Source: AGHT+IGxLUEzc3Reot726IcmLgjq3nKIC/pLTC27EX/OZL86TUpoASPm9EUrUhNIVGTyzCyI1smo65AvyrNtEbv7AJM=
X-Received: by 2002:a05:622a:346:b0:4ed:b665:3779 with SMTP id
 d75a77b69052e-4efd0cadedemr5566471cf.16.1764271761856; Thu, 27 Nov 2025
 11:29:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910-slub-percpu-caches-v8-0-ca3099d8352c@suse.cz>
 <20250910-slub-percpu-caches-v8-4-ca3099d8352c@suse.cz> <0406562e-2066-4cf8-9902-b2b0616dd742@kernel.org>
 <aQge2rmgRvd1JKxc@harry> <1bda09da-93be-4737-aef0-d47f8c5c9301@suse.cz> <1c34bf75-0ea3-490d-b412-288c7452904e@kernel.org>
In-Reply-To: <1c34bf75-0ea3-490d-b412-288c7452904e@kernel.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 27 Nov 2025 11:29:10 -0800
X-Gm-Features: AWmQ_bnMUm6fpw8I5CiW8EnlZf9RdB2BGr-Nmfr3npUmVluTVAnisr9aMXu_kzM
Message-ID: <CAJuCfpFTMQD6oyR_Q1ds7XL4Km7h2mmzSv4z7f5fFnQ14=+g_A@mail.gmail.com>
Subject: Re: [PATCH v8 04/23] slab: add sheaf support for batching kfree_rcu() operations
To: Daniel Gomez <da.gomez@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, Harry Yoo <harry.yoo@oracle.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Christoph Lameter <cl@gentwo.org>, 
	David Rientjes <rientjes@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Uladzislau Rezki <urezki@gmail.com>, Sidhartha Kumar <sidhartha.kumar@oracle.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org, 
	maple-tree@lists.infradead.org, linux-modules@vger.kernel.org, 
	bpf@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, 
	Lucas De Marchi <lucas.demarchi@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 27, 2025 at 6:01=E2=80=AFAM Daniel Gomez <da.gomez@kernel.org> =
wrote:
>
>
>
> On 05/11/2025 12.25, Vlastimil Babka wrote:
> > On 11/3/25 04:17, Harry Yoo wrote:
> >> On Fri, Oct 31, 2025 at 10:32:54PM +0100, Daniel Gomez wrote:
> >>>
> >>>
> >>> On 10/09/2025 10.01, Vlastimil Babka wrote:
> >>>> Extend the sheaf infrastructure for more efficient kfree_rcu() handl=
ing.
> >>>> For caches with sheaves, on each cpu maintain a rcu_free sheaf in
> >>>> addition to main and spare sheaves.
> >>>>
> >>>> kfree_rcu() operations will try to put objects on this sheaf. Once f=
ull,
> >>>> the sheaf is detached and submitted to call_rcu() with a handler tha=
t
> >>>> will try to put it in the barn, or flush to slab pages using bulk fr=
ee,
> >>>> when the barn is full. Then a new empty sheaf must be obtained to pu=
t
> >>>> more objects there.
> >>>>
> >>>> It's possible that no free sheaves are available to use for a new
> >>>> rcu_free sheaf, and the allocation in kfree_rcu() context can only u=
se
> >>>> GFP_NOWAIT and thus may fail. In that case, fall back to the existin=
g
> >>>> kfree_rcu() implementation.
> >>>>
> >>>> Expected advantages:
> >>>> - batching the kfree_rcu() operations, that could eventually replace=
 the
> >>>>   existing batching
> >>>> - sheaves can be reused for allocations via barn instead of being
> >>>>   flushed to slabs, which is more efficient
> >>>>   - this includes cases where only some cpus are allowed to process =
rcu
> >>>>     callbacks (Android)
> >>>>
> >>>> Possible disadvantage:
> >>>> - objects might be waiting for more than their grace period (it is
> >>>>   determined by the last object freed into the sheaf), increasing me=
mory
> >>>>   usage - but the existing batching does that too.
> >>>>
> >>>> Only implement this for CONFIG_KVFREE_RCU_BATCHED as the tiny
> >>>> implementation favors smaller memory footprint over performance.
> >>>>
> >>>> Also for now skip the usage of rcu sheaf for CONFIG_PREEMPT_RT as th=
e
> >>>> contexts where kfree_rcu() is called might not be compatible with ta=
king
> >>>> a barn spinlock or a GFP_NOWAIT allocation of a new sheaf taking a
> >>>> spinlock - the current kfree_rcu() implementation avoids doing that.
> >>>>
> >>>> Teach kvfree_rcu_barrier() to flush all rcu_free sheaves from all ca=
ches
> >>>> that have them. This is not a cheap operation, but the barrier usage=
 is
> >>>> rare - currently kmem_cache_destroy() or on module unload.
> >>>>
> >>>> Add CONFIG_SLUB_STATS counters free_rcu_sheaf and free_rcu_sheaf_fai=
l to
> >>>> count how many kfree_rcu() used the rcu_free sheaf successfully and =
how
> >>>> many had to fall back to the existing implementation.
> >>>>
> >>>> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> >>>
> >>> Hi Vlastimil,
> >>>
> >>> This patch increases kmod selftest (stress module loader) runtime by =
about
> >>> ~50-60%, from ~200s to ~300s total execution time. My tested kernel h=
as
> >>> CONFIG_KVFREE_RCU_BATCHED enabled. Any idea or suggestions on what mi=
ght be
> >>> causing this, or how to address it?
> >>
> >> This is likely due to increased kvfree_rcu_barrier() during module unl=
oad.
> >
> > Hm so there are actually two possible sources of this. One is that the
> > module creates some kmem_cache and calls kmem_cache_destroy() on it bef=
ore
> > unloading. That does kvfree_rcu_barrier() which iterates all caches via
> > flush_all_rcu_sheaves(), but in this case it shouldn't need to - we cou=
ld
> > have a weaker form of kvfree_rcu_barrier() that only guarantees flushin=
g of
> > that single cache.
>
> Thanks for the feedback. And thanks to Jon who has revived this again.
>
> >
> > The other source is codetag_unload_module(), and I'm afraid it's this o=
ne as
> > it's hooked to evey module unload. Do you have CONFIG_CODE_TAGGING enab=
led?
>
> Yes, we do have that enabled.

Sorry I missed this discussion before.
IIUC, the performance is impacted because kvfree_rcu_barrier() has to
flush_all_rcu_sheaves(), therefore is more costly than before.

>
> > Disabling it should help in this case, if you don't need memory allocat=
ion
> > profiling for that stress test. I think there's some space for improvem=
ent -
> > when compiled in but memalloc profiling never enabled during the uptime=
,
> > this could probably be skipped? Suren?

I think yes, we should be able to skip kvfree_rcu_barrier() inside
codetag_unload_module() if profiling was not enabled.
kvfree_rcu_barrier() is there to ensure all potential kfree_rcu()'s
for module allocations are finished before destroying the tags. I'll
need to add an additional "sticky" flag to record that profiling was
used so that we detect a case when it was enabled, then disabled
before module unloading. I can work on it next week.

> >
> >> It currently iterates over all CPUs x slab caches (that enabled sheave=
s,
> >> there should be only a few now) pair to make sure rcu sheaf is flushed
> >> by the time kvfree_rcu_barrier() returns.
> >
> > Yeah, also it's done under slab_mutex. Is the stress test trying to unl=
oad
> > multiple modules in parallel? That would make things worse, although I'=
d
> > expect there's a lot serialization in this area already.
>
> AFAIK, the kmod stress test does not unload modules in parallel. Module u=
nload
> happens one at a time before each test iteration. However, test 0008 and =
0009
> run 300 total sequential module unloads.
>
> ALL_TESTS=3D"$ALL_TESTS 0008:150:1"
> ALL_TESTS=3D"$ALL_TESTS 0009:150:1"
>
> >
> > Unfortunately it will get worse with sheaves extended to all caches. We
> > could probably mark caches once they allocate their first rcu_free shea=
f
> > (should not add visible overhead) and keep skipping those that never di=
d.
> >> Just being curious, do you have any serious workload that depends on
> >> the performance of module unload?
>
> Can we have a combination of a weaker form of kvfree_rcu_barrier() + trac=
king?
> Happy to test this again if you have a patch or something in mind.
>
> In addition and AFAIK, module unloading is similar to ebpf programs. Ccin=
g bpf
> folks in case they have a workload.
>
> But I don't have a particular workload in mind.

