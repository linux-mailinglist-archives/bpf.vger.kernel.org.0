Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64CF9113744
	for <lists+bpf@lfdr.de>; Wed,  4 Dec 2019 22:54:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728042AbfLDVya (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 4 Dec 2019 16:54:30 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:33791 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727989AbfLDVya (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 4 Dec 2019 16:54:30 -0500
Received: by mail-lf1-f68.google.com with SMTP id n25so814290lfl.0
        for <bpf@vger.kernel.org>; Wed, 04 Dec 2019 13:54:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=VnhsCb+n6LgjC+6907Tb3B2Vl6EZOomyJ8tnp+TG/qc=;
        b=sNHngkNWV9ev/PowIGAz1Y8jFs9+YDnaFQVf/lco03gsiAcIQu1SbZnuJ3nQdVH7NO
         dqB3KDHH54WY/F8yOmZq7+XwbP3We2KsJhXSussbQI7WEkf2pJK9Dfv4VskpP8DP0xi9
         RzokWdmqDSdtmSDaKdUMDRrvVxUrRdXp0gDizkbeHWwtxewzYwtw6aE5w/5hDpcO20SB
         74FHt6IyhRWsBnQU/vFF7rWwOcznpjo77kfAOnzsGWoZ37J6sd+cfmNms7yTG4rlocFD
         N1REEnbp/vd+gBJEzbLLWJqAMdZTJZ+uw1Sg2M976u4gSv6gz4dbBj3zq1DgrdBZ4xt+
         T2eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=VnhsCb+n6LgjC+6907Tb3B2Vl6EZOomyJ8tnp+TG/qc=;
        b=OUuBL7PQDevSoVdifRCiJN/D/PgI4O13FpuiRP7ungcCx6Jza//ISk9T2eJ2YohuFG
         HZSDYq4hpA4JQgKQGDZIWnU+Oot2pLuq8DwATSNGqCYU5vpFh9GeGeLzh3bs0lFRnF6y
         nu7hJ3EYQ5SZUBvLsGA7SQKfwneP4XCFw1wrwOLij8iQOJIbjWYAJ+LbunyHtlgCpyNy
         2y1piLbQJcqv9rXLAfACNPoA5ttyMv0cMpLR7pJn3ESykBs2gqo1Jqt+C9xIwYtJxhEx
         hw7OC0mdQuMSO8ZvD8H8G4gFPKIffisS0yQq9l2WnU+IfgNZ50tw9rA/l7msMmaWEXOb
         yXiA==
X-Gm-Message-State: APjAAAXlVUQ5Q14HDfbsg6L0N7MqqnXSjW1lFOzJpGtjKFeQS1I/4wk0
        Hsb9hmYnkTJNrwVS2z4ErtXSsA==
X-Google-Smtp-Source: APXvYqzPvrDymPjXRh9qruHs8tBDH3UgArE45+g66WgCMyK1u3JpllpAjDPD+rE9wYXI6GOY+loWbw==
X-Received: by 2002:a19:c382:: with SMTP id t124mr3210526lff.124.1575496468486;
        Wed, 04 Dec 2019 13:54:28 -0800 (PST)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id e20sm3841379ljk.44.2019.12.04.13.54.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2019 13:54:28 -0800 (PST)
Date:   Wed, 4 Dec 2019 13:54:05 -0800
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Toke =?UTF-8?B?SMO4?= =?UTF-8?B?aWxhbmQtSsO4cmdlbnNlbg==?= 
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
Message-ID: <20191204135405.3ffb9ad6@cakuba.netronome.com>
In-Reply-To: <CAEf4BzZ+0XpH_zJ0P78vjzmFAH3kGZ21w3-LcSEG=B=+ZQWJ=w@mail.gmail.com>
References: <20191202131847.30837-1-jolsa@kernel.org>
        <CAEf4BzY_D9JHjuU6K=ciS70NSy2UvSm_uf1NfN_tmFz1445Jiw@mail.gmail.com>
        <87wobepgy0.fsf@toke.dk>
        <CAADnVQK-arrrNrgtu48_f--WCwR5ki2KGaX=mN2qmW_AcRyb=w@mail.gmail.com>
        <CAEf4BzZ+0XpH_zJ0P78vjzmFAH3kGZ21w3-LcSEG=B=+ZQWJ=w@mail.gmail.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 4 Dec 2019 13:16:13 -0800, Andrii Nakryiko wrote:
> I wonder what big advantage having bpftool in libbpf's Github repo
> brings, actually? The reason we need libbpf on github is to allow
> other projects like pahole to be able to use libbpf from submodule.
> There is no such need for bpftool.
> 
> I agree about preference to release them in sync, but that could be
> easily done by releasing based on corresponding commits in github's
> libbpf repo and kernel repo. bpftool doesn't have to physically live
> next to libbpf on Github, does it?

+1

> Calling github repo a "mirror" is incorrect. It's not a 1:1 copy of
> files. We have a completely separate Makefile for libbpf, and we have
> a bunch of stuff we had to re-implement to detach libbpf code from
> kernel's non-UAPI headers. Doing this for bpftool as well seems like
> just more maintenance. Keeping github's Makefile in sync with kernel's
> Makefile (for libbpf) is PITA, I'd rather avoid similar pains for
> bpftool without a really good reason.

Agreed. Having libbpf on GH is definitely useful today, but one can hope
a day will come when distroes will get up to speed on packaging libbpf,
and perhaps we can retire it? Maybe 2, 3 years from now? Putting
bpftool in the same boat is just more baggage.
