Return-Path: <bpf+bounces-35308-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C65C693979A
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 02:50:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 472791F222DA
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 00:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B770132106;
	Tue, 23 Jul 2024 00:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JBAvUBzj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com [209.85.218.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1707DDDD9;
	Tue, 23 Jul 2024 00:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721695818; cv=none; b=Pp+BlS3TY/G7d1YWuhpKjqRL3zYr2XPGl6y+xXFtlvbPcXaQ19zT7GiSFvy9REmwAzXl/eh1fXT9AGCDGtwDYxJfcefKonqoc+Ugnt7LoloC6uwQKO/8NZfO7r1q2QqFVD17QqucGK8oq8qbAGZ/pPwYR9SZLlXS0w1DW07sWJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721695818; c=relaxed/simple;
	bh=f7An+hOQChGRZ63zy/0BwSmHzXYDydCle2zF/jyJZl0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N8V4/V7i/ajNeZnjFzxNXZgDz7BaxqnkgjAibwx5F5d8LNNJjSOFyAFdsWYGqUOMoudnTNWs4nS/7gVzxeLeOr/PQD3E31PVKLQhgej/LyRiUns0XWJIgeBxkzYt/z4Fb2QA2c23hutU5VEV5X9sMn7NFofNxmoXDRy61edPRG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JBAvUBzj; arc=none smtp.client-ip=209.85.218.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f68.google.com with SMTP id a640c23a62f3a-a7a8caef11fso34621966b.0;
        Mon, 22 Jul 2024 17:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721695815; x=1722300615; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rlWGR3g6n4FbilGIWF8jJ19Dxa2VbECckU48Rpf9erk=;
        b=JBAvUBzjEokExRSDj3mzEjDDI2HRuC6noYbd29b78ozFC8S+u44yGIB71sgWbRE1PI
         LOeiIEtvmKKutDEpgABmZVKCk00ZnLOPTMGr9nRZlUHdV9ouqZGlB2CO6Es6DCoB2XMS
         8X6W2W2Ttzv8kuexeWqVSGQNzBSvCy3h0KSHLhTi06qSJv0glJaiZ4GE1Bb8sEA1HzBe
         JBqOF2Y+s9ZZLtE33LtBUVCeShaMkkZ2yaTk/dR77BS5TNSO6YpE5kRtx45bRYHDV95e
         dOrJ1WvVPnWm+k81OJpoqS3xNi9fOZWss8aKE2mIMxNmgekAs8SPW7ePAbgsFz+SSNCb
         Qnhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721695815; x=1722300615;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rlWGR3g6n4FbilGIWF8jJ19Dxa2VbECckU48Rpf9erk=;
        b=WdAvmv+mK3+3knES6GkQDzJPOjopmHjxrigxsIG1nhwoCvB4XTKoxL1L5/aDsoyVPl
         kiXvNl3XMVxUcJNIU9CRQnvAvj7Mthf4JWGQ/68r89zLvjhp1mQHfAiKMtDXugpY/5Og
         m8zDdRiMS8EF6WYgbjqGhQiA4NjxdFuLFxQK8JZIysG0lCbZvXDO3LgMMuswVidWfjb1
         VIV/qkNyTB9jVc0oLaV86jxc0a1QZu9J/5ORKg5LiW/XbWYylVWYKHpsqp3xIloMzB4I
         d8kXTzLy41QDk4Q3egyx+eakJzIA0tfTh3qojTm6ThghXnvZV1ZXE0pu6LvIakyEvYYr
         qd+g==
X-Forwarded-Encrypted: i=1; AJvYcCXDPXmILjHa+Z0lCfU6YkJiL51rbirG3v89n9aBNhqP+2J94N73O4N62QaJ2ZGTA+5igi+2t1cmF6e9+ObKwecLDICKox1PRmIpfcgCc1wYAv/rQMu8hcgAtmnkClcjCaKQaoi3IuHo/Tul4vEePh4wY7sskx6n9tt+
X-Gm-Message-State: AOJu0YxRqCjeuuVDDaiqAN0vqbvrrMGtfj95C9wsvSzgY7PNE7jQpCME
	8LTj1J4Qf/LAr6j4UBeJXDn1s84ZnjOlO6TGdqrpr4uAiumInhS9lor3ZmHi69Ohj1gPweXMGIJ
	FjdHaDI0nkCTV7bH1c29uZTRS+iY=
X-Google-Smtp-Source: AGHT+IEOctkEL8SbBF2y/KBV79IgxQkRZGAheeZvjWBEYQhQ/mLMd8znZWTqR0Bnc8ylaJ3+eeWkB450K7nMIbWAlek=
X-Received: by 2002:a17:907:3da2:b0:a7a:302a:50c8 with SMTP id
 a640c23a62f3a-a7a87ccfe94mr113801366b.32.1721695815238; Mon, 22 Jul 2024
 17:50:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <AM6PR03MB58488045E4D0FA6AEDC8BDE099A52@AM6PR03MB5848.eurprd03.prod.outlook.com>
 <etzm4h5qm2jhgi6d4pevooy2sebrvgb3lsa67ym4x7zbh5bgnj@feoli4hj22so>
In-Reply-To: <etzm4h5qm2jhgi6d4pevooy2sebrvgb3lsa67ym4x7zbh5bgnj@feoli4hj22so>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Tue, 23 Jul 2024 02:49:38 +0200
Message-ID: <CAP01T76LCr5GdihuULk1-qB9uLdn99B1fMmb2vMHBJUos+yHKg@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next RESEND 00/16] bpf: Checkpoint/Restore In eBPF (CRIB)
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Juntong Deng <juntong.deng@outlook.com>, ast@kernel.org, daniel@iogearbox.net, 
	john.fastabend@gmail.com, martin.lau@linux.dev, eddyz87@gmail.com, 
	song@kernel.org, yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, andrii@kernel.org, avagin@gmail.com, 
	snorcht@gmail.com, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 23 Jul 2024 at 01:47, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Jul 11, 2024 at 12:10:17PM +0100, Juntong Deng wrote:
> >
> > In restore_udp_socket I had to add a struct bpf_crib_skb_info for
> > restoring packets, this is because there is currently no BPF_CORE_WRITE.
> >
> > I am not sure what the current attitude of the kernel community
> > towards BPF_CORE_WRITE is, personally I think it is well worth adding,
> > as we need a portable way to change the value in the kernel.
> >
> > This not only allows more complexity in the CRIB restoring part to
> > be transferred from CRIB kfuncs to CRIB ebpf programs, but also allows
> > ebpf to unlock more possible application scenarios.
>
> There are lots of interesting ideas in this patch set, but it seems they are
> doing the 'C-checkpoint' part of CRIx and something like BPF_CORE_WRITE
> is necessary for 'R-restore'.
> I'm afraid BPF_CORE_WRITE cannot be introduced without breaking all safety nets.
> It will make bpf just as unsafe as any kernel module if bpf progs can start
> writing into arbitrary kernel data structures. So it's a show stopper.
> If you think there is a value in adding all these iterators for 'checkpoint'
> part alone we can discuss and generalize individual patches.

I think it would be better to focus on the particular problem Juntong
wants to solve, and go from there.
That might help in cutting down the size of the patch set.
It seems the main problem was restoring UDP sockets, but it got lost
among all the other stuff.
It's better to begin the discussion from there, which can still be
rooted in what you believe CRIB in general is useful for.

Also, information is missing on what the previous attempts at solving
this UDP problem were, and why they were insufficient such that BPF
was necessary.
What motivates the examples included as part of this set?
I think this particular GSoC project is not new, so what were the
limitations in previous attempts at restoring UDP sockets?
Adding kfuncs makes it easier to checkpoint and restore state, but it
also carries a maintenance cost.

Using BPF to speed up task state dump is going to be beneficial, but
is an orthogonal problem (and doesn't have to be CRIU specific, the
primitives that CRIU requires can be generic and used by others as
well).

You're also skirting all kinds of compatibility concerns if you encode
state to restore into structs, not getting into specifics, but if this
pattern is followed, what happens on a kernel where say a particular
field isn't available? It is a possibility that kfuncs may change
their behavior due to kernel changes (not CRIB changes particularly),
so how does user space respond to that? Sometimes, patches are
backported, how does feature detection work?

What happens when the struct used to restore is grown to accomodate
more state to restore? Kfuncs will have to detect the size of the
structure and work with multiple versions (like what nf_conntrack_bpf
kfuncs try to do with opts__sz).

I tried to add io_uring and epoll iterators for capturing state
(https://lore.kernel.org/bpf/20211201042333.2035153-1-memxor@gmail.com)
a couple of years back, although I didn't have time to pursue it
further after GSoC. But I tried to minimize the restoration interfaces
exposed precisely because the above is hard to ensure. The more kfuncs
you expose to restore state, the deeper the hole becomes, since it's
meant to be a relatively user-friendly interface for CRIU to use, and
work across different kernel versions.

Can the values passed through the struct to restore state be trusted?
I'm not very well versed with the net/, but I think
bpf_restore_skb_rcv_queue isn't doing much sanitization and taking in
whatever was passed by the program. It would be helpful to explain why
that is or is not ok.

It's easier to review if we just focus on a particular problem. I
think let's start with the UDP case, and then look at everything else
later.

>
> High level feedback:
>
> - no need for BPF_PROG_TYPE_CRIB program type. Existing syscall type should fit.
>

+1

> - proposed file/socket iterators are somewhat unnecessary in this open coded form.
>   there is already file/socket iterator. From the selftests it looks like it
>   can be used to do 'checkpoint' part already.

+1

>
> - KF_ITER_GETTER is a good addition, but we should be able to do it without these flags.
>   kfunc-s should be able to accept iterator as an argument. Some __suffix annotation
>   may be necessary to help verifier if BTF type alone of the argument won't be enough.
>
> - KF_OBTAIN looks like a broken hammer to bypass safety. Like:
>
>   > Currently we cannot pass the pointer returned by the iterator next
>   > method as argument to the KF_TRUSTED_ARGS kfuncs, because the pointer
>   > returned by the iterator next method is not "valid".

I've replied to this particular patch to explain what exact unsafety
it might introduce.
I also think the 2nd use case might be fixed by a recent patch.

[...]

