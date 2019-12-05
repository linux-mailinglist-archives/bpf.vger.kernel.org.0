Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3BC011389D
	for <lists+bpf@lfdr.de>; Thu,  5 Dec 2019 01:24:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728132AbfLEAYP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 4 Dec 2019 19:24:15 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:44556 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728011AbfLEAYO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 4 Dec 2019 19:24:14 -0500
Received: by mail-lf1-f66.google.com with SMTP id v201so994367lfa.11
        for <bpf@vger.kernel.org>; Wed, 04 Dec 2019 16:24:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=WlXLW2RI1tJQOcMNYgc98Qgcf4rYrGp8OIDLgoJCH0c=;
        b=fNwiQqfGnNsyEJYMPlge43hvB2JRQtOIQ7khRISVYNFdvNINB6iKEx0QoEJON7A4qg
         omWu6pKQJ8w6HgqGWf/MIO65vwjCsdYIYZYEtD4ySqIzqRvyd8CP/lBjPg1J2ol2FgZj
         Rs1eI4tDR3rz0hMU1ncrKBRIHY2AAMoHQEfbmMNudMkELJbUTpVZklq88nj/dZVis8EY
         vYBkyTnAjEkqNk34aamGnLh3muzsO95SpMOL7Or6FmPVzQ8pC2c2KY4yI/reU3XsRvOn
         lb3ahcDI3+7vyUAVoS7mXj4eE6EF+IQqduJA1uUjhXuEQ5sxhx8d3EDrxT5l2KHwEN2P
         ZkLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=WlXLW2RI1tJQOcMNYgc98Qgcf4rYrGp8OIDLgoJCH0c=;
        b=h/zl4979FWdyWAHkDAo09zP1Czr+4ig5fvWapVcRjwkq05/iuJdiWJ1VyUucSdIftK
         vYVxTCgq5Ka8kvRrRbd8Y+BNw5Nh5+l32AvXVAKMmD/7GNfWFQ0GkmRobVCu43k3b+R/
         ogqULHlKsBdUz3RKfZrEDTjbap8ItwdjdfpHttzPCqP3rkKppK9V1kOFG1JIe0ScgoI1
         9rlMLFcg7SUmliLnSfdQBdchgvXfA5vtMt5lqBG7oE3mnCDWsNMXLBjBtwfqpgW51YcK
         EYKjds4rsmdQoUQhIIfkPOl7eWU7U9dmymXoMnR2WWN1su+rpzxfilpvuccKNQb1IygC
         eMjg==
X-Gm-Message-State: APjAAAUg/DsUvTZ2Lq7KpN4xpoJ+JpZEKFA7cXJUpNNiLT1KADtICy3v
        Xcl5e8X4XgdDmju4yj9aoY2Jhw==
X-Google-Smtp-Source: APXvYqy7QeMNXACuTpx2U0w7soJGbGDcz1sK5VXmG2ytucMOOYNINLaDrgync325PZJQuq3Nc0rb3g==
X-Received: by 2002:a19:c7c5:: with SMTP id x188mr3580128lff.22.1575505452514;
        Wed, 04 Dec 2019 16:24:12 -0800 (PST)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id l7sm4054402lfc.80.2019.12.04.16.24.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2019 16:24:12 -0800 (PST)
Date:   Wed, 4 Dec 2019 16:23:48 -0800
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Toke =?UTF-8?B?SMO4aWxh?= =?UTF-8?B?bmQtSsO4cmdlbnNlbg==?= 
        <toke@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Quentin Monnet <quentin.monnet@netronome.com>
Subject: Re: [PATCHv4 0/6] perf/bpftool: Allow to link libbpf dynamically
Message-ID: <20191204162348.49be5f1b@cakuba.netronome.com>
In-Reply-To: <20191204233948.opvlopjkxe5o66lr@ast-mbp.dhcp.thefacebook.com>
References: <20191202131847.30837-1-jolsa@kernel.org>
        <CAEf4BzY_D9JHjuU6K=ciS70NSy2UvSm_uf1NfN_tmFz1445Jiw@mail.gmail.com>
        <87wobepgy0.fsf@toke.dk>
        <CAADnVQK-arrrNrgtu48_f--WCwR5ki2KGaX=mN2qmW_AcRyb=w@mail.gmail.com>
        <CAEf4BzZ+0XpH_zJ0P78vjzmFAH3kGZ21w3-LcSEG=B=+ZQWJ=w@mail.gmail.com>
        <20191204135405.3ffb9ad6@cakuba.netronome.com>
        <20191204233948.opvlopjkxe5o66lr@ast-mbp.dhcp.thefacebook.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 4 Dec 2019 15:39:49 -0800, Alexei Starovoitov wrote:
> > Agreed. Having libbpf on GH is definitely useful today, but one can hope
> > a day will come when distroes will get up to speed on packaging libbpf,
> > and perhaps we can retire it? Maybe 2, 3 years from now? Putting
> > bpftool in the same boat is just more baggage. =20
>=20
> Distros should be packaging libbpf and bpftool from single repo on github.
> Kernel tree is for packaging kernel.

Okay, single repo on GitHub:

https://github.com/torvalds/linux

we are in agreement =F0=9F=98=9D

Jokes aside, you may need to provide some reasoning on this one..
The recommendation for packaging libbpf from GitHub never had any=20
clear justification either AFAICR.

I honestly don't see why location matters. bpftool started out on GitHub
but we moved it into the tree for... ease of packaging/distribution(?!)
Now it's handy to have it in the tree to reuse the uapi headers.

As much as I don't care if we move it (back) out of the tree - having
two copies makes no sense to me. As does having it in the libbpf repo.
The sync effort is not warranted. User confusion is not warranted.

The distroes already package bpftool from the kernel sources, people had
put in time to get to this stage and there aren't any complaints.

In fact all the BPF projects and test suites we are involved in at
Netronome are entirely happy the packaged versions of LLVM and libbpf
in Fedora _today_, IOW the GH libbpf is irrelevant to us already.

As for the problem which sparked this discussion - I disagree that
bpftool should have "special relationship" with the library. In fact
bpftool uses the widest range of libbpf's interfaces of all known
projects so it's invaluable for making sure that those interfaces are
usable, consistent and complete.

You also said a few times you don't want to merge fixes into bpf/net.
That divergence from kernel development process is worrying.

None of this makes very much sense to me. We're diverging from well
established development practices without as much as a justification.

Perhaps I'm not clever enough to follow. But if I'm allowed to make an
uneducated guess it would be that it's some Facebook internal reason,
like it's hard to do backports? :/
