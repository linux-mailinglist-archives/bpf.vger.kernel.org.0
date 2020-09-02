Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 152D025B609
	for <lists+bpf@lfdr.de>; Wed,  2 Sep 2020 23:40:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbgIBVkI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Sep 2020 17:40:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726226AbgIBVkG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Sep 2020 17:40:06 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0590BC061244
        for <bpf@vger.kernel.org>; Wed,  2 Sep 2020 14:40:06 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id l191so381562pgd.5
        for <bpf@vger.kernel.org>; Wed, 02 Sep 2020 14:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=4A67n7L95z6S4mFnMNUruyRw3Rlv4pF+Qs7my+KkLPI=;
        b=mcHKFTyB96ei/GPlzYwsJnLEqYgXIo2ADr97+VjyZ19AF2r8qIOTJ1xNOp0xuYQef8
         yWsvuGHoip6VVxebTqjpiPSd7lyvCJuI3QWSoPrVjdCXok/0veHuhNmGAdlb2xfdwLbv
         lUW0epUwspqoIz/8MmTRngaXiVop9zzv8Pv6Tq4oJq+7wyeHYDQfItlppz77iNp+cieo
         KZ4p/HgJtEwxiRttu8oT3StpEvby3KyU1y7oO9EwCFsNXuWtwh4L4pmLD8yRIB9JnIcU
         UQNsivg1ZCwFT9VyqpwJK3RvV+qYC6le2qZ2aUJUMkPtmaD0nBsOq9HoEFwmK01ZpiIj
         euBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=4A67n7L95z6S4mFnMNUruyRw3Rlv4pF+Qs7my+KkLPI=;
        b=QQcQvoMcWSxGPvB+jJN9g0b47YCt4N5Orvnooi5puU32qa3apJX/dUI22pGbfb8NYD
         Z+bjVir5fkdw1qSzhxEQmhBSrIjioDzK6geq7os9ZlT1WjV67phRIgCG03QFfTNenyq4
         x360X9hB0repQTk6Vy3sCYQk9eYcpFH8lRpxoKPFJI3aABZd/UHfrwIidjKdG9ZdvsE1
         BUZYfxHjnh0UpFqsirWRYR8XIy/7yAE7zUREygQXh9TDnU2vGJxTbSqwhl6jVi7Vz9ey
         sgG903OU3WHyy89nnMNaMhpxjCXoRDAfiVqbjjcQHdSt2aEuzTB9YwayF+c/HcTt7jqa
         DbfA==
X-Gm-Message-State: AOAM532jCeSSdHE5sjYs6EK6FNRSk+MpVYlk/n4uFEdaQNBskgFC0Zn9
        Kmrj/0VJoFkf8yHs6YSYlq4=
X-Google-Smtp-Source: ABdhPJzroi3nPrx7uslctGzIuvvUJtqvnpckxLK0Jfl7H74TWCEm8wuhy5eKS3V1vMK/ylY/BVSb5g==
X-Received: by 2002:a62:82c3:: with SMTP id w186mr372890pfd.287.1599082805363;
        Wed, 02 Sep 2020 14:40:05 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:400::5:b65c])
        by smtp.gmail.com with ESMTPSA id 205sm507763pfz.14.2020.09.02.14.40.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2020 14:40:04 -0700 (PDT)
Date:   Wed, 2 Sep 2020 14:40:02 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Cc:     Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: fix a verifier failure with xor
Message-ID: <20200902214002.ciczljw7wrbznper@ast-mbp.dhcp.thefacebook.com>
References: <20200825064608.2017878-1-yhs@fb.com>
 <20200825064608.2017937-1-yhs@fb.com>
 <CAEf4Bzb89dz_Sjy14LjQSDWrQ=TpSHAfgf=_Sa=bWUKGqJHCgQ@mail.gmail.com>
 <465da51a-793e-5ea0-85dc-56ab4f36ae34@fb.com>
 <87d034ikve.fsf@toke.dk>
 <20200902142158.hp26mv7dxphzyhun@ast-mbp.dhcp.thefacebook.com>
 <871rjki5nw.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <871rjki5nw.fsf@toke.dk>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Sep 02, 2020 at 05:01:39PM +0200, Toke Høiland-Jørgensen wrote:
> Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:
> 
> > On Wed, Sep 02, 2020 at 11:33:09AM +0200, Toke HÃƒÂ¸iland-JÃƒÂ¸rgensen wrote:
> >> Yonghong Song <yhs@fb.com> writes:
> >> 
> >> > On 9/1/20 1:07 PM, Andrii Nakryiko wrote:
> >> >> On Mon, Aug 24, 2020 at 11:47 PM Yonghong Song <yhs@fb.com> wrote:
> >> >>>
> >> >>> bpf selftest test_progs/test_sk_assign failed with llvm 11 and llvm 12.
> >> >>> Compared to llvm 10, llvm 11 and 12 generates xor instruction which
> >> >> 
> >> >> Does this mean that some perfectly working BPF programs will now fail
> >> >> to verify on older kernels, if compiled with llvm 11 or llvm 12? If
> >> >
> >> > Right.
> >> >
> >> >> yes, is there something that one can do to prevent Clang from using
> >> >> xor in such situations?
> >> >
> >> > The xor is generated by the combination of llvm simplifyCFG and 
> >> > instrCombine phase.
> >> >
> >> > The following is a hack to prevent compiler from generating xor's.
> >> 
> >> Wait, so this means that we can no longer tell people to just use the
> >> newest LLVM version - now we have to keep track of a minimum *and*
> >> maximum LLVM version for each kernel version?
> >
> > No. The only way is forward. Everyone has to upgrade their llvm periodically.
> 
> Right, great! But surely that implies that a regression such as that
> described here, where a new LLVM version turns a previously-valid
> program into one that no longer verifies is a bug, no?

It's not a regression. Previous valid _compiled_ programs will load.
Nothing guarantees that recompiled program will keep loading.
Even if you keep compiler and source code constant the environment could change.
That risk always existed in libbcc and in anything that compiles on the fly.
A new version of bpftrace may suddenly start failing existing bpftrace scripts.
No one wants this, of course, but we cannot guarantee 100%.

> 
> >> Could we maybe try to not *keep* making it harder for people to use BPF? :/
> >
> > Whom do you mean by "we" ?
> 
> I mean "we as a community who would like BPF to be as useful as possible
> to as many people as possible". Usability is a big part of this.

Of course. I completely agree, but your previous statement said
that somebody "is making it harder for people to use BPF"...
and I asked whom did you point finger at.
Sounds like you're saying that you are not a compiler person,
so it's not your fault and some compiler person must be responsible?
Well, we are all in the same boat and all are responsible for the outcome.

> 
> >> As for the patch, sure, make the verifier smarter, but I also feel like
> >> LLVM should be fixed to not suddenly emit such xor instructions...
> >
> > I don't think there is anything to be "fixed". It's not a bug form
> > llvm developers point of view. At least I suspect that's the response
> > you will get if you post the same sentence on llvm-dev mailing list.
> > If you care to help, please bisect which llvm commit introduced this
> > change. May be author (whoever that was) will have ideas how to
> > pessimize it specifically for bpf backend. But I suspect they will
> > refuse to do so. The discussion about partial disable of optimizations
> > was brought up several times. tldr optimizations cannot be disabled
> > effectively. Pretty much all of them may cause trouble for the
> > verifier and all of them are often necessary for the verifier as well.
> > Please read this thread:
> > http://clang-developers.42468.n3.nabble.com/Disable-certain-llvm-optimizations-at-clang-frontend-tp4068601.html
> 
> I am not enough of a compiler person to get the nuances of that
> discussion, but it seems that the last message[0] by Y Song seems to
> imply that you guys do want to fix such issues in LLVM, just not by
> disabling the optimisation, but at a later stage in the processing
> pipeline?

Not really. The "fix such issues in LLVM" statement is missing the point.
There is no _issue_ in LLVM and there is no _issue_ in the verifier.
The word "fix" assigns the blame and implies a bug.
The verifier is getting smarter. LLVM is getting smarter, but they
follow different religions, so to speak. Reconciling the differences
is what should happen.
Inserting inline asm barriers at different stages of the compilation
is a fragile hack. Both the verifier and the LLVM need to work
towards each other. BPF programs are a pain to write. People keep
fighting the verifier and fighting LLVM. Large progs are full of
inline asm hacks (mostly written by humans) to please the verifier
and force LLVM to do something that is against LLVM objectives.
Yonghong is trying to come up with a set of heuristics to do this
asm insertion automatically. It will help, for sure, but won't
close every corner case. The verifier needs to get smarter too.
Recognizing XORs in the verifier is the right thing to do.
Missing XORs in older kernels is not a bug, but we might consider it
a bug and backport this verifier feature to older kernels.
LLVM vs verifier contest is outside of typical kernel bug vs feature
classification of patches. I think we need to be creative here.
