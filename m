Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0FEFC2AC0
	for <lists+bpf@lfdr.de>; Tue,  1 Oct 2019 01:18:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731985AbfI3XST (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 30 Sep 2019 19:18:19 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:32909 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727621AbfI3XST (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 30 Sep 2019 19:18:19 -0400
Received: by mail-qt1-f193.google.com with SMTP id r5so19299699qtd.0
        for <bpf@vger.kernel.org>; Mon, 30 Sep 2019 16:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=+K7vISo63seW+fv9e2awwFfZvkHDT6dGzGUlDkiOv4I=;
        b=tj5Bg7oa+tGI3KiWZ3R1MUj3EZzTH0QoravQqXqqY+q6HRaApaGPdk5Nq7LoBoycS9
         rProm0oYTx/sp2TLsZ5z41BMDy14KnrW0KwE4SLnwrPFeqHyxoLZpxhsfZ4Y2iwScuwd
         Yvy0uEkYCAnOnBmt9Fz2NuXZVd1jZqO092PylMjjlNNCgDNN60BDVNCsfFozO6O3Xxl3
         kge1NZuWf5ukSL+zKpdLDtsJQE5Po0aVY3A0DJ4WPKDDvf+Gmp/KIAAxE+cgmihfk33G
         wiqFMDWmKB0/IoOyjeDx+dJYjQPftM1ldwuJ9R5HLibd8FMByGjof5GmBaTUkHaRh2oF
         X9kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=+K7vISo63seW+fv9e2awwFfZvkHDT6dGzGUlDkiOv4I=;
        b=YKtd40LPjap5KzdaAzCRR+O1LH8fBLTms2mQiyb6mUlYPW2GRzZjGvP0S6GoFdwacg
         fPQ3xrpvm0XWBL5H6oiAEKnL2GHT/cwWIvJYNnQykmoGXDi50QxoR+fb3SH4aaOCm5je
         fqsI1mRLhoWo5GGYFBlYqbhT/l738ZreAhjYaHETGecuEYfqMsgFNfKmS/xG39h5DUD7
         dAQj3SrqW1AoyDdFn/DquoqXCZ7H3oaEJ6LyIgYWyOjHDOHRALw0rPdQWE5aFj6j0ibD
         JFxWENySy3ifkp4tCePLZdBsjuxvsIjAKKSXgVYrhXiIx9KTABNgaPV1qnj4fKH+DF5s
         wMZg==
X-Gm-Message-State: APjAAAWDPH9iGuVKQNtOTWjLxdF5u7QFjRlYfDwDsrG9Qm1XGqPpFv9J
        dxX3fBH6O7G0nbifTsUsRmnIjQ==
X-Google-Smtp-Source: APXvYqzlI5zUao25wiclYxdwIkv/zreglQewx+l+8w/s3z8i2q2KXmAR88Gq86chESrrW3V5Zzo8ZQ==
X-Received: by 2002:a0c:ffa7:: with SMTP id d7mr22258056qvv.12.1569885497995;
        Mon, 30 Sep 2019 16:18:17 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id w73sm6817942qkb.111.2019.09.30.16.18.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2019 16:18:17 -0700 (PDT)
Date:   Mon, 30 Sep 2019 16:18:14 -0700
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
Message-ID: <20190930161814.381c9bb0@cakuba.netronome.com>
In-Reply-To: <CAEf4BzaPdA+egnSKveZ_dE=hTU5ZAsOFSRpkBjmEpPsZLM=Y=Q@mail.gmail.com>
References: <20190930185855.4115372-1-andriin@fb.com>
        <20190930185855.4115372-3-andriin@fb.com>
        <CAPhsuW6RHaPceOWdqmL1w_rwz8dqq4CrfY43Gg7qVK0w1rA29w@mail.gmail.com>
        <CAEf4BzaPdA+egnSKveZ_dE=hTU5ZAsOFSRpkBjmEpPsZLM=Y=Q@mail.gmail.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 30 Sep 2019 15:58:35 -0700, Andrii Nakryiko wrote:
> On Mon, Sep 30, 2019 at 3:55 PM Song Liu <liu.song.a23@gmail.com> wrote:
> >
> > On Mon, Sep 30, 2019 at 1:43 PM Andrii Nakryiko <andriin@fb.com> wrote:  
> > >
> > > Make bpf_helpers.h and bpf_endian.h official part of libbpf. Ensure they
> > > are installed along the other libbpf headers.
> > >
> > > Signed-off-by: Andrii Nakryiko <andriin@fb.com>  
> >
> > Can we merge/rearrange 2/6 and 3/6, so they is a git-rename instead of
> > many +++ and ---?  
> 
> I arranged them that way because of Github sync. We don't sync
> selftests/bpf changes to Github, and it causes more churn if commits
> have a mix of libbpf and selftests changes.
> 
> I didn't modify bpf_helpers.h/bpf_endian.h between those patches, so
> don't worry about reviewing contents ;)

I thought we were over this :/ Please merge the patches.
