Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5502FC2B09
	for <lists+bpf@lfdr.de>; Tue,  1 Oct 2019 01:43:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728440AbfI3Xnm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 30 Sep 2019 19:43:42 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:46602 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727535AbfI3Xnm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 30 Sep 2019 19:43:42 -0400
Received: by mail-qk1-f196.google.com with SMTP id 201so9453942qkd.13
        for <bpf@vger.kernel.org>; Mon, 30 Sep 2019 16:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=j7FEIc40a5brhUsW65fh97TInIL+5jCJf0kV3TigQR0=;
        b=kC0JrrjEwXbI64mH4RZ9wwZcD6K7yFZ3+gARn+geJMcVhDOe5OesnGlEh8D4ns8lxL
         NB2MtZ6J9OZmCNIhKOI6pYxf7RMmLv3qCSxY1PAS3Hk6jhtl0B90A6hR2eplUZ0uZZlo
         GQTplPo+5kAcdGIsIDnjhvmMT4JU3PThTPCgUfwhHSGoEp+Tw7AKsim9TfkB5yZKDGJc
         OFVvZUSM/kEFo0VxTf4f9Dh/N3hSGDg6pkcjRv82SQn6wsKp75ZQQR4je05Nck4H7zT0
         iAHgWTtdVLZIwcPeH5rcKMMC6LsTqbsWiJq9dfvayDZMXdrwGaZqGqVJtF41vVXaqjNj
         Dtyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=j7FEIc40a5brhUsW65fh97TInIL+5jCJf0kV3TigQR0=;
        b=r21iqI9afO6OcC45U1VDFoBRK6LE3RfPs4CnxJWoRBiBOl/2VyQgokTRzGmIPiJZU2
         hzI4TxshOOaNCP6hm7I8nzsKDpYC9UcQ98qMb/CVDnAH27fw8WfDlwVAvpqkWLEkUwO1
         KK63oVkq05QDuMe56uQ/WP1z0LeeoTRvNhhOQvOVIFZn5SdZGcz1+/iNcfTC7u5uLVBE
         Lr6RBNm88bdL3cXPMg77T3dutZcnnNgtwDbOTzZVdDKt1fhReAS7AG//pbJYvHNScEUp
         MiROcIfMCkYjPb/M+pQC8i+3uls4eHaHUXdD8895rnKdo7ZiaVwtjAyzUCX9tBlySR3h
         8yeg==
X-Gm-Message-State: APjAAAWL/Z7i/eRMCOqbkHuo3DYFbDNqEUBrVPg8b9wFp/Pdz1yjIcq5
        XsQlmHYtK+j5/822kyJ4+IoXXg==
X-Google-Smtp-Source: APXvYqyU2fv7IJAeui4AssjHvmvgGckRbJz/aZom7dPZ046isg7yL1zowFoAdXsJntnz+hEZtu5kQQ==
X-Received: by 2002:a37:c204:: with SMTP id i4mr2993539qkm.282.1569887021544;
        Mon, 30 Sep 2019 16:43:41 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id d69sm6676520qkc.87.2019.09.30.16.43.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2019 16:43:41 -0700 (PDT)
Date:   Mon, 30 Sep 2019 16:43:37 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Song Liu <liu.song.a23@gmail.com>,
        Andrii Nakryiko <andriin@fb.com>, bpf <bpf@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>,
        Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH bpf-next 2/6] libbpf: move bpf_helpers.h, bpf_endian.h
 into libbpf
Message-ID: <20190930164337.6d214cdc@cakuba.netronome.com>
In-Reply-To: <CAEf4BzYBUVJTexS8h0smJiw09V_W+C_AeRyDbFvCum2ESzPO6g@mail.gmail.com>
References: <20190930185855.4115372-1-andriin@fb.com>
        <20190930185855.4115372-3-andriin@fb.com>
        <CAPhsuW6RHaPceOWdqmL1w_rwz8dqq4CrfY43Gg7qVK0w1rA29w@mail.gmail.com>
        <CAEf4BzaPdA+egnSKveZ_dE=hTU5ZAsOFSRpkBjmEpPsZLM=Y=Q@mail.gmail.com>
        <20190930161814.381c9bb0@cakuba.netronome.com>
        <CAEf4BzYBUVJTexS8h0smJiw09V_W+C_AeRyDbFvCum2ESzPO6g@mail.gmail.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 30 Sep 2019 16:30:02 -0700, Andrii Nakryiko wrote:
> On Mon, Sep 30, 2019 at 4:18 PM Jakub Kicinski wrote:
> > On Mon, 30 Sep 2019 15:58:35 -0700, Andrii Nakryiko wrote:  
> > > On Mon, Sep 30, 2019 at 3:55 PM Song Liu <liu.song.a23@gmail.com> wrote:  
> > > >
> > > > On Mon, Sep 30, 2019 at 1:43 PM Andrii Nakryiko <andriin@fb.com> wrote:  
> > > > >
> > > > > Make bpf_helpers.h and bpf_endian.h official part of libbpf. Ensure they
> > > > > are installed along the other libbpf headers.
> > > > >
> > > > > Signed-off-by: Andrii Nakryiko <andriin@fb.com>  
> > > >
> > > > Can we merge/rearrange 2/6 and 3/6, so they is a git-rename instead of
> > > > many +++ and ---?  
> > >
> > > I arranged them that way because of Github sync. We don't sync
> > > selftests/bpf changes to Github, and it causes more churn if commits
> > > have a mix of libbpf and selftests changes.
> > >
> > > I didn't modify bpf_helpers.h/bpf_endian.h between those patches, so
> > > don't worry about reviewing contents ;)  
> >
> > I thought we were over this :/ Please merge the patches.  
> 
> I'll merge those two patches, our sync script can handle that now,
> though with a bit of human input. I'm not exactly sure on the "why"
> though

Awesome, thank you!

> I think generally splitting libbpf changes and selftests
> changes is a good thing, no?

I'm not sure, here headers are moved to a better location. To me it
seems like the logical change is move, rather than add X, remove X.
