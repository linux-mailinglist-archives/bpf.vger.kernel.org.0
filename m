Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35E4667403F
	for <lists+bpf@lfdr.de>; Thu, 19 Jan 2023 18:47:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbjASRre (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 19 Jan 2023 12:47:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbjASRrd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 19 Jan 2023 12:47:33 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC25B2728;
        Thu, 19 Jan 2023 09:47:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 40BEFCE255E;
        Thu, 19 Jan 2023 17:47:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08B1BC43392;
        Thu, 19 Jan 2023 17:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674150449;
        bh=7uPip+WeLCzhXAHS0jTrjmKLnZN8kIiWrW5fmWakqFU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D6RTXI24BvZfLJmtKH7QJ2Dl71Nt1VDHeKuGSTQAkGNrOYhkIeGkYn5m+XRDokWmB
         XpLjOiLOuWFvXUqj2CvFeYzmtMtzdpD3HxwgyUfGt5zcXzNyT9vxeES6BSMdOWNYW4
         4Lg5uC5n3t5rhkcUbBIzdm1+WzxX5XaT2v8xY5SGue7p2bS9DgdSpUMWWd8kNMm5Ue
         9tYUBfm8qGbK4/VRrH30fUQ9eV3IpWjxfmxqYDjiOu7zYx9JfCSpgzqtZ3ajvXwCew
         p0W7ZAQ1PVo3HDojdkMBXot8m7mNVYaiK7a8HXNwngEBl4ymYQr+4zMVimCEySqe4V
         jAmr+g05kD7eQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 0D599405BE; Thu, 19 Jan 2023 14:47:25 -0300 (-03)
Date:   Thu, 19 Jan 2023 14:47:25 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Andres Freund <andres@anarazel.de>,
        Quentin Monnet <quentin@isovalent.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Christy Lee <christylee@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        bpf@vger.kernel.org, Michael Petlan <mpetlan@redhat.com>,
        Ben Hutchings <ben@decadent.org.uk>
Subject: Re: [PATCH v2 0/3] Assume libbpf 1.0+
Message-ID: <Y8mCLb8t9tYYBCtt@kernel.org>
References: <20230116010115.490713-1-irogers@google.com>
 <CAP-5=fVUgc8xtBzGi66YRUxZHyXvW2kiMjGz39dywaLxrO4Hpg@mail.gmail.com>
 <Y8mAuDvs566zwG67@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8mAuDvs566zwG67@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Thu, Jan 19, 2023 at 02:41:12PM -0300, Arnaldo Carvalho de Melo escreveu:
> Anyway, just a data point, I'll check if I'm missing installing it
> somewhere.

Just asked for libbpf-dev to be installed on the debian:11 container:

[perfbuilder@five 11]$ dsh debian:11
$ bash
perfbuilder@589d1572e8cf:/$ ls -la /usr/lib/x86_64-linux-gnu/libbpf.so.0
lrwxrwxrwx. 1 root root 15 Jan 10  2021 /usr/lib/x86_64-linux-gnu/libbpf.so.0 -> libbpf.so.0.3.0
perfbuilder@589d1572e8cf:/$ dpkg -l | grep bpf
ii  libbpf-dev:amd64                   1:0.3-2                        amd64        eBPF helper library (development files)
ii  libbpf0:amd64                      1:0.3-2                        amd64        eBPF helper library (shared library)
ii  libpfm4:amd64                      4.11.1+git32-gd0b85fb-1        amd64        Library to program the performance monitoring events
perfbuilder@589d1572e8cf:/$

- Arnaldo
