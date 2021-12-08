Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 700C546DCE1
	for <lists+bpf@lfdr.de>; Wed,  8 Dec 2021 21:17:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240134AbhLHUVL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Dec 2021 15:21:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232356AbhLHUVL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 Dec 2021 15:21:11 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5926FC061746;
        Wed,  8 Dec 2021 12:17:39 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id k21so4168297ioh.4;
        Wed, 08 Dec 2021 12:17:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=1IlLvcNlcDJQez/IYxBKSedQgBs5DpWYIT3HtbvTn/U=;
        b=mxu9JbEUJ+Pjv54HKBrBNHCLKoxNi0tfhUxC9wBtrfqdivylb7RF073IwuKy4vKc6a
         La57De5dW5zpWkdPm77QS3HGKDsnlb0K9tVABG/t5ror6rlmYWyP1/zrpOXjESXbMvfW
         8VZcfRGFaLDdCprXzio+VpHAlyxBjAU6zqdGRRz1dBUpWPRn8guxgb0FCSB6i3BBXyXS
         dGiII+VlcYuUSlQQXM8dLHK0RQfbQKB9k+AmemZfXK97wtSTyhWphOXNbi4I6pXkgJUz
         QqeEneIb9ebTAI7vBmmNOdvMBRrzGUy89dTFX3ykspqEEv4rPLGDRvzJLAwBx0b2Oe56
         xugw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=1IlLvcNlcDJQez/IYxBKSedQgBs5DpWYIT3HtbvTn/U=;
        b=uU9474+YyR24P+HB1JzzYBjzH0Gvjc3zfwoE7jVArsSRcO3D6AUOI8OJF+GKjnoA36
         OI9h+LKqD33LPRC/Lj/egRP0nIrQ0zInQeopuJ8orzTCAUyimd8gKSHbNfO9ge0A2Nlw
         1vQzf45+Mk0is9adj3LbQ/Ksux2X8q3whGDCoDHT6U2Oxqe3Fi+3Vw+o8UokfcAKjywR
         uRUNZqlliH+Og2xemxwMQ1wapNFuV7e2ICn8pg6Zsma0l1PKJi7BhQcMlWY/D5LvjStx
         aWF7l19DqB3qAr83W64fEHg1G8vFUFEW/AMzhYmg+ILBmLJrvIJbnpkSJtyN4bjdSC/l
         96gQ==
X-Gm-Message-State: AOAM5312j99kVRikZEbL30cM5VPp2y0tVEtYXCwkdLBCQGQNuNwbtFFn
        WTBJpGgizqS8CHoyvrRiLt0zBVaxJLe1Xw==
X-Google-Smtp-Source: ABdhPJzlpDudPI4/6dCizKa+bIRsa8n3xcxcMKehFOVquxdBUnIHqkdhpAk7z23teoRMpoYw7Un1sA==
X-Received: by 2002:a05:6638:24ca:: with SMTP id y10mr2280676jat.109.1638994658649;
        Wed, 08 Dec 2021 12:17:38 -0800 (PST)
Received: from localhost ([172.243.151.11])
        by smtp.gmail.com with ESMTPSA id q4sm2585797ilj.7.2021.12.08.12.17.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 12:17:37 -0800 (PST)
Date:   Wed, 08 Dec 2021 12:17:30 -0800
From:   John Fastabend <john.fastabend@gmail.com>
To:     Luca Boccassi <bluca@debian.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Matteo Croce <mcroce@linux.microsoft.com>
Cc:     bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        keyrings@vger.kernel.org,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>
Message-ID: <61b112daa1b84_94d5c208c7@john.notmuch>
In-Reply-To: <f63bef1a56b12a06ed980f9b5e094f84f2434333.camel@debian.org>
References: <20211203191844.69709-1-mcroce@linux.microsoft.com>
 <CAADnVQLDEPxOvGn8CxwcG7phy26BKuOqpSQ5j7yZhZeEVoCC4w@mail.gmail.com>
 <CAFnufp1_p8XCUf-RdHpByKnR9MfXQoDWw6Pvm_dtuH4nD6dZnQ@mail.gmail.com>
 <CAADnVQ+DSGoF2YoTrp2kTLoFBNAgdU8KbcCupicrVGCWvdxZ7w@mail.gmail.com>
 <86e70da74cb34b59c53b1e5e4d94375c1ef30aa1.camel@debian.org>
 <CAADnVQLCmbUJD29y2ovD+SV93r8jon2-f+fJzJFp6qZOUTWA4w@mail.gmail.com>
 <CAFnufp2S7fPt7CKSjH+MBBvvFu9F9Yop_RAkX_3ZtgtZhRqrHw@mail.gmail.com>
 <CAADnVQ+WLGiQvaoTPwu_oRj54h4oMwh-z5RV0WAMFRA9Wco_iA@mail.gmail.com>
 <61aae2da8c7b0_68de0208dd@john.notmuch>
 <0079fd757676e62f45f28510a5fd13a9996870be.camel@debian.org>
 <61ae75487d445_c5bd20827@john.notmuch>
 <7ae146389b58f521166e9569be6c64f87359777a.camel@debian.org>
 <f63bef1a56b12a06ed980f9b5e094f84f2434333.camel@debian.org>
Subject: Re: [PATCH bpf-next 0/3] bpf: add signature
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

[...]

> > > > Hope this makes sense. Thanks!
> > > =

> > > I think I understand your use case. When done as BPF helper you
> > > can get the behavior you want with a one line BPF program
> > > loaded at boot.
> > > =

> > > int verify_all(struct bpf_prog **prog) {
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return verify_signa=
ture(prog->insn,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0prog->len * sizeof(struct=
 bpf_insn),
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 signature, KEYRING, BPF_SIGTYP=
E);
> > > }
> > > =

> > > And I can write some more specific things as,
> > > =

> > > int verify_blobs(void data) {
> > > =C2=A0 int reject =3D verify_signature(data, data_len, sig, KEYRING=
, TYPE);
> > > =C2=A0 struct policy_key *key =3D map_get_key();
> > > =

> > > =C2=A0 return policy(key, reject);=C2=A0 =

> > > }
> > > =

> > > map_get_key() looks into some datastor with the policy likely using=

> > > 'current' to dig something up. It doesn't just apply to BPF progs
> > > we can use it on other executables more generally. And I get more
> > > interesting use cases like, allowing 'tc' programs unsigned, but
> > > requiring kernel memory reads to require signatures or any N
> > > other policies that may have value. Or only allowing my dbg user
> > > to run read-only programs, because the dbg maybe shouldn't ever
> > > be writing into packets, etc. Driving least privilege use cases
> > > in fine detail.
> > > =

> > > By making it a BPF program we side step the debate where the kernel=

> > > tries to get the 'right' policy for you, me, everyone now and in
> > > the future. The only way I can see to do this without getting N
> > > policies baked into the kernel and at M different hook points is vi=
a
> > > a BPF helper.
> > > =

> > > Thanks,
> > > John
> > =

> > Now this sounds like something that could work - we can prove that th=
is
> > could be loaded before any writable fs comes up anywhere, so in
> > principle I think it would be acceptable and free of races. Matteo, w=
e
> > should talk about this tomorrow.
> > And this requires some infrastructure work right? Is there a WIP git
> > tree somewhere that we can test out?
> > =

> > Thank you!
> =


I don't have a WIP tree, but I believe it should be fairly easy.
First I would add a wrapper BPF helper for verify_signature() so
we can call it from fentry/freturn context. That can be done on
its own IMO as its a generally useful operation.

Then I would stub a hook point into the BPF load path. The exact
place to put this is going to have some debate I think, but I
would place it immediately after the check_bpf call.

With above two you have enough to do sig verification iiuc.

Early boot loading I would have to check its current status. But I know
folks have been working on it. Maybe its done?

> One question more question: with the signature + kconfig approach,
> nothing can disable the signature check. But if the signature checker
> is itself a bpf program, is there/can there be anything stopping root
> from unloading it?

Interesting. Not that I'm aware of. Currently something with sufficient
privileges could unload the program. Maybe we should have a flag so
early boot programs can signal they shouldn't be unloaded ever. I would
be OK with this and also seems generally useful. I have a case where
I want to always set the socket cookie and we leave it running all the
time. It would be nice if it came up and was pinned at boot.

Maybe slightly better than a flag would be to have a new CAP support
that only early boot has like CAP_BPF_EARLY. From my point of view
this both seems doable with just some smallish changes on BPF side.

Thanks,
John=
