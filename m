Return-Path: <bpf+bounces-36153-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CEE3943401
	for <lists+bpf@lfdr.de>; Wed, 31 Jul 2024 18:17:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FC151C21FC3
	for <lists+bpf@lfdr.de>; Wed, 31 Jul 2024 16:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7B4C1BBBE2;
	Wed, 31 Jul 2024 16:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="epy2dB4o"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f66.google.com (mail-lf1-f66.google.com [209.85.167.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD6217BA0;
	Wed, 31 Jul 2024 16:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722442613; cv=none; b=WuDotAtsQ3yOggb9x6q5Nni5ub9d/Pa95zLb/TvzxYtiEJ9iOIW5BPrd5IAVk8p1kPIrIdnMucOkK0ehG3OdayokTZXLqZ3dYeg7ZAjhubzMR20OQsEE2Brlckt1maMtmMi333EmmAjWuGmIJWWtOjbZ6p0g5I6es70CesiIB1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722442613; c=relaxed/simple;
	bh=IR/YNpr68KziMcdRBY+HsG260wQgKcdN3jPXrQjiE9o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jcwHUPOU3Io7RYMDI825ZZGjS6WUHosb5k04XCCbzR/WZKyfZ0GEr6OhKqVEgvTE6FhsNUlL8dX/wqt1MrkVmDySQFF2KAEbN+BOP1Eqoy20Np8hPVNzaTqylNRcXRTkoHlJsrG7m5vQPn+tnhPecCf5REifBHXw3FoYjK15WbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=epy2dB4o; arc=none smtp.client-ip=209.85.167.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f66.google.com with SMTP id 2adb3069b0e04-530ae4ef29dso2376253e87.3;
        Wed, 31 Jul 2024 09:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722442609; x=1723047409; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bLPlwYJBWZ1/QGdua3E+Mxqj1bUxHbPJr0Utwwaid6k=;
        b=epy2dB4oGzLQcHja4bjiCWEWzDKx4W7mArqouf0zCq4PF2hCrXNPwPnuk96l+jFSN4
         cSDFK7fsLvp2OF+J4obv7v+MA4+In2immJyo+/h9Alrr3f3KLgrzE3Bx/io1tN0yH2i4
         +d4p+MKNV+kj0D4IbxTp1rGmpj3BdPpMaTIX6pbeKFedtEgRVSOVHElN2AA/J8G5fZDH
         tdEmnJEzLFqcKDOlNZeWNDqWXUvBRxm75DBhi2xav5WUPSJAuYi2Bxce96B1Lsg0ajKx
         j501/Je22yuK/3e9RK7Ajbb2OcvvEnxBCa4UpRjaIKYoi5usCN0/J+qFONLIl0VpSNl6
         f6kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722442609; x=1723047409;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bLPlwYJBWZ1/QGdua3E+Mxqj1bUxHbPJr0Utwwaid6k=;
        b=ii+XJk/qlP9zF4EWOGGWdeyhnraZFf4jB7GvdIneHy7q37eO7nMUKmi+Q/LSFR+iZ0
         eNsmvUvV3rbKejJJwZhMalnyo7GcgHgrKOWr5B+I4tIr/IIFUBFWCHu0wBb0eUJa1QW1
         hXy2I0fyYEc0UWObk0lwIpMOLbYLKaCX0rbtbPLR1qpYdNcvA4fH5dEeLoTVGu7uarV7
         hZZgyiVOgx9pV3fNr7M/VgEjaNKX/B31R6UpiUevPkX1nJ1ksGpswCMxPqSMS/3c9LFn
         5vdXxidugEYrMGYW9APoPEdh9eRJ10xc2yrNijX/uAu1DCfIuy0C1V+BWTtnDn8wXHrg
         r+Bw==
X-Forwarded-Encrypted: i=1; AJvYcCXMP/VzXomifRlO1zE7spH6bqQToafEkksxi3Wjv/s1jCUkDbNLXhjCLvKwyBztCmk3JaD0G8BgqwBYAEcTAP/UbUPIjjv9MlW6xEYIV3nC7cYxh85bJaVw/jHeT8leOKXxMtw5D+C1Zj1KTJprUcvE5ZoyiNwc3LE+
X-Gm-Message-State: AOJu0YxMVlo5sypD0UXAy0m2clrsX2x0w7eOu4yb9BY2aW0YZ8OM9sAk
	lomsc/hHbD8FFeze77POt5BuOrmh1KUYujfFE47DGDMbra+edeuG7vpeC9fEhbonHQ99XWH/hQi
	jL3nJIZDWMT1hcNYGwLpWiz/6uIQ=
X-Google-Smtp-Source: AGHT+IF0od7jelwpBygbVjydtPTZGw/Iri+jqBFo5aPrcfsO1kpf+FRSsCin+ENYMYJRVBr4EYxMQwECeBW7JANhhrE=
X-Received: by 2002:a05:6512:40a:b0:52e:9f1b:517 with SMTP id
 2adb3069b0e04-5309b2811aamr12244347e87.25.1722442609088; Wed, 31 Jul 2024
 09:16:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <AM6PR03MB58488045E4D0FA6AEDC8BDE099A52@AM6PR03MB5848.eurprd03.prod.outlook.com>
 <etzm4h5qm2jhgi6d4pevooy2sebrvgb3lsa67ym4x7zbh5bgnj@feoli4hj22so> <AM6PR03MB5848CA34B5B68C90F210285E99B12@AM6PR03MB5848.eurprd03.prod.outlook.com>
In-Reply-To: <AM6PR03MB5848CA34B5B68C90F210285E99B12@AM6PR03MB5848.eurprd03.prod.outlook.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Wed, 31 Jul 2024 18:16:12 +0200
Message-ID: <CAP01T75na=fz7EhrP4Aw0WZ33R7jTbZ4BcmY56S1xTWczxHXWw@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next RESEND 00/16] bpf: Checkpoint/Restore In eBPF (CRIB)
To: Juntong Deng <juntong.deng@outlook.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, ast@kernel.org, daniel@iogearbox.net, 
	john.fastabend@gmail.com, martin.lau@linux.dev, eddyz87@gmail.com, 
	song@kernel.org, yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, andrii@kernel.org, avagin@gmail.com, 
	snorcht@gmail.com, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 31 Jul 2024 at 15:10, Juntong Deng <juntong.deng@outlook.com> wrote:
>
> On 2024/7/23 00:47, Alexei Starovoitov wrote:
> > On Thu, Jul 11, 2024 at 12:10:17PM +0100, Juntong Deng wrote:
> >>
> >> In restore_udp_socket I had to add a struct bpf_crib_skb_info for
> >> restoring packets, this is because there is currently no BPF_CORE_WRITE.
> >>
> >> I am not sure what the current attitude of the kernel community
> >> towards BPF_CORE_WRITE is, personally I think it is well worth adding,
> >> as we need a portable way to change the value in the kernel.
> >>
> >> This not only allows more complexity in the CRIB restoring part to
> >> be transferred from CRIB kfuncs to CRIB ebpf programs, but also allows
> >> ebpf to unlock more possible application scenarios.
> >
> > There are lots of interesting ideas in this patch set, but it seems they are
> > doing the 'C-checkpoint' part of CRIx and something like BPF_CORE_WRITE
> > is necessary for 'R-restore'.
> > I'm afraid BPF_CORE_WRITE cannot be introduced without breaking all safety nets.
> > It will make bpf just as unsafe as any kernel module if bpf progs can start
> > writing into arbitrary kernel data structures. So it's a show stopper.
> > If you think there is a value in adding all these iterators for 'checkpoint'
> > part alone we can discuss and generalize individual patches.
> >
>
> Thanks for your review!
>
> I agree, BPF_CORE_WRITE will compromise the safety of ebpf programs,
> which may be a Pandora's box.
>
> But without BPF_CORE_WRITE, CRIB cannot achieve portable restoration,
> so the restoration part is put on hold for now.

I think then you should rethink how to do restoration in CRIB.
It is better to anticipate some solution, even if you don't implement
it right away.
It will be necessary for an end-to-end solution.

I think BPF_CORE_WRITE will be a non-starter.
The best that can be done is teaching the kernel specific fields which
are writable, but that doesn't scale.

The conventional method with CRIU was to replicate the same steps that
led to a certain state for a kernel object.
The way you propose is more akin to direct serialization/deserialization.

It's better to rely on restoration helpers if it's necessary.

>
> In the next version of the patch set, I will focus on implementing
> checkpointing (dumping) via CRIB for better dumping performance and more
> extensibility (which still has a lot of benefits).
>
> > High level feedback:
> >
> > - no need for BPF_PROG_TYPE_CRIB program type. Existing syscall type should fit.
> >
>
> - If we use BPF_PROG_TYPE_SYSCALL for CRIB programs, will it cause
> confusion in the functionality of bpf program types?
> (BPF_PROG_TYPE_SYSCALL was originally designed to execute syscalls)
>
> - Is it good to expose all kfuncs needed for checkpointing to
> BPF_PROG_TYPE_SYSCALL? (Maybe we need a separate ebpf program type to
> restrict the kfuncs that can be used)
>

I think it's become a more generic program type to invoke kfuncs from
task context.
E.g. the upcoming sched-ext uses it to invoke kfuncs to gracefully
exit a scheduler etc.
We didn't have a separate BPF_PROG_TYPE_SCX_TASK_CTX.

Also, you should not think about the kfuncs as being specific to
checkpointing or CRIB.
Try to keep them generic so they could be useful beyond use cases that
you have thought of right now.
Place reasonable constraints that are limited to enforcing safe use
from BPF programs.
Just as an illustration, all of the existing BPF infra/iterators you
used to implement CRIB were never designed with checkpointing in mind.

> - Maybe CRIB needs more specific ebpf program running restrictions?
> (for example, not allowed to modify the context, dumped data can only
> be returned via ringbuf, context is only used to identify the process
> that needs to dump and the part of the data that needs to be dumped)
>

Why would you want to do that?
Maybe someone needs a different way or comes up with a better way of
communicating with userspace?

There are different ways of doing checkpointing.
Some checkpointing systems propose ideas of keeping histories of a
process's state.
This allows possibly reverting process state to some point in the past
(as a way to rollback execution).
There, when you checkpoint stuff, you would store all state as part of
your BPF program in maps or arenas, and may not even send it to user
space.
Then it can be finally dumped when necessary to a user space agent, or
discarded.

> The above three points were my considerations when I originally added
> BPF_PROG_TYPE_CRIB, maybe we can have more discussion?
>

I think it feels unnecessary. So far I don't see a strong reason.
Adding a new program type means remembering everywhere in the verifier
how it needs to be handled.
Or whether it requires a special consideration for some check (esp.
since you want to restrict a lot of stuff).
It's better to decompose CRIB into individual useful parts that are
useful beyond checkpointing.
It's better to think in terms of providing useful basic building
blocks, how people use them shouldn't strongly be dictated by us.

> > - proposed file/socket iterators are somewhat unnecessary in this open coded form.
> >    there is already file/socket iterator. From the selftests it looks like it
> >    can be used to do 'checkpoint' part already.
> >
>
> If you mean iterators like iter/task_file, iter/tcp, etc., then I think
> that is not flexible enough for checkpointing.
>
> This is because the context of bpf iterators is fixed and bpf iterators
> cannot be nested. This means that a bpf iterator program can only
> complete a specific small iterative dump task, and cannot dump
> multi-level data.
>
> An example, when we need to dump all the sockets of a process, we need
> to iterate over all the files (sockets) of the process, and iterate over
> the all packets in the queue of each socket, and iterate over all data
> in each packet.
>
> If we use bpf iterator, since the iterator can not be nested, we need to
> use socket iterator program to get all the basic information of all
> sockets (pass pid as filter), and then use packet iterator program to
> get the basic information of all packets of a specific socket (pass pid,
> fd as filter), and then use packet data iterator program to get all the
> data of a specific packet (pass pid, fd, packet index as filter).
>
> This would be complicated and require a lot of (each iteration)
> bpf program startup and exit (leading to poor performance).
>
> By comparison, open coded iterator is much more flexible, we can iterate
> in any context, at any time, and iteration can be nested, so we can
> achieve more flexible and more elegant dumping through open coded
> iterators.
>
> With open coded iterators, all of the above can be done in a single
> bpf program, and with nested iterators, everything becomes compact
> and simple.

This does make sense to me, but I'd still try to limit what you
introduce to only what you need initially, for the next version, and
let's go from there.

>
> Also, bpf iterators transmit data to user space through seq_file,
> which involves a lot of open (bpf_iter_create), read, close syscalls,
> context switching, memory copying, and cannot achieve the performance
> of using ringbuf.
>
> The bpf iterator is more like an advanced procfs, but still not CRIB.
>
> > - KF_ITER_GETTER is a good addition, but we should be able to do it without these flags.
> >    kfunc-s should be able to accept iterator as an argument. Some __suffix annotation
> >    may be necessary to help verifier if BTF type alone of the argument won't be enough.
> >
>
> I agree, kfuncs can accept iterators as arguments and we can
> use __suffix.
>
> But here is a question, should we consider these kfuncs as iter kfuncs?
>
> That is, should we impose specific constraints on these functions?
> For example, specific naming patterns (bpf_iter_<type>_ prefix),
> GETTER methods cannot take extra arguments (like next methods), etc.
>
> Currently the verifier applies these constraints based on flags.
>
> > - KF_OBTAIN looks like a broken hammer to bypass safety. Like:
> >
> >    > Currently we cannot pass the pointer returned by the iterator next
> >    > method as argument to the KF_TRUSTED_ARGS kfuncs, because the pointer
> >    > returned by the iterator next method is not "valid".
> >
> >    It's true, but should be fixable directly. Make return pointer of iter_next() to be trusted.
> >
>
> I agree that KF_OBTAIN currently is not a good solution.
>
> For case 1, I tried the ref_obj_id method mentioned by Kumar and
> it worked, solving the ownership and lifetime problems. I will include
> it in the next version of the patch.
>
> For case 2, Kumar mentioned that it had been fixed by Matt, but I found
> there are still some problems.
>
> More details can be found in my reply to Kumar (in the same email thread)
>
> For iter_next(), I currently have an idea to add new flags to allow
> iter_next() to decide whether the return value is trusted or not,
> such as KF_RET_TRUSTED.
>
> What do you think?

Why shouldn't the return value always be trusted?
We eventually want to switch over to trusted by default everywhere.
It would be nice not to go further in the opposite direction (i.e.
having to manually annotate trusted) if we can avoid it.

>
> Also, for these improvements to the chain of trust, do you think I
> should send them out as separate patches? (rather than as part of
> the CRIB patch set)
>
> > - iterators for skb data don't feel right. bpf_dynptr_from_skb() should do the trick already.
> >
>
> I agree that using bpf_dynptr would be better, but probably would
> not change much...
>
> This is because, we cannot guarantee that the user provided a large
> enough buffer, the buffer provided by the user may not be able to hold
> all the data of the packet (but we need to dump the whole packet, the
> packet may be very large, which is different from the case of reading
> only a fixed size protocol header for filtering), which means we need to
> read the data in batches (iteratively), so we still need an iterator.
>
> (Back to the BPF_PROG_TYPE_CRIB discussion, BPF_PROG_TYPE_SYSCALL cannot
> use bpf_dynptr_from_skb, but should we expose bpf_dynptr_from_skb to
> BPF_PROG_TYPE_SYSCALL? Maybe we need a separate program type...)

It can be exposed, we'd just have to ensure syscall programs get
access to an skb that can be passed into the kfunc that is
well-formed.
Someone who wants to call that kfunc on an skb will instead use
prog_type_crib from user space, if we separate them. So it adds no
value.

