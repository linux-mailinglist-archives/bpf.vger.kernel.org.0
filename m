Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5568B258275
	for <lists+bpf@lfdr.de>; Mon, 31 Aug 2020 22:24:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730012AbgHaUXv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 31 Aug 2020 16:23:51 -0400
Received: from www62.your-server.de ([213.133.104.62]:41248 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730038AbgHaUXr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 31 Aug 2020 16:23:47 -0400
Received: from sslproxy01.your-server.de ([78.46.139.224])
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1kCqLA-0004rm-99; Mon, 31 Aug 2020 22:23:44 +0200
Received: from [178.196.57.75] (helo=pc-9.home)
        by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1kCqLA-000Vd9-1j; Mon, 31 Aug 2020 22:23:44 +0200
Subject: Re: [PATCH bpf-next 0/6] tools/bpftool: Fix cross and out-of-tree
 builds
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>, ast@kernel.org
Cc:     bpf@vger.kernel.org, kafai@fb.com, songliubraving@fb.com,
        yhs@fb.com, andriin@fb.com, john.fastabend@gmail.com,
        kpsingh@chromium.org
References: <20200827153629.3820891-1-jean-philippe@linaro.org>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <9bc29e23-abdc-a6ba-b9f3-537aba20aea4@iogearbox.net>
Date:   Mon, 31 Aug 2020 22:23:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200827153629.3820891-1-jean-philippe@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.4/25916/Mon Aug 31 15:26:49 2020)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 8/27/20 5:36 PM, Jean-Philippe Brucker wrote:
> A few fixes for cross-building bpftool and runqslower, to build for
> example an arm64 bpftool on a x86 host machine and run it on an embedded
> platform. Also fix out-of-tree build, allowing for example to use the
> same source tree for different target architectures.
> 
> Patch 1 factors the HOST variables definitions. Patches 2 and 3 fix the
> bpftool build and patches 4-6 fix the runqslower build. I also have some
> fixes for the BPF selftests build which I'll send later.
> 
> Jean-Philippe Brucker (6):
>    tools: Factor HOSTCC, HOSTLD, HOSTAR definitions
>    tools/bpftool: Force clean of out-of-tree build
>    tools/bpftool: Fix cross-build
>    tools/runqslower: Use Makefile.include
>    tools/runqslower: Enable out-of-tree build
>    tools/runqslower: Build bpftool using HOSTCC
> 
>   tools/bpf/bpftool/Makefile        | 38 +++++++++++++----
>   tools/bpf/resolve_btfids/Makefile |  9 ----
>   tools/bpf/runqslower/Makefile     | 68 ++++++++++++++++++-------------
>   tools/build/Makefile              |  4 --
>   tools/objtool/Makefile            |  9 ----
>   tools/perf/Makefile.perf          |  4 --
>   tools/power/acpi/Makefile.config  |  1 -
>   tools/scripts/Makefile.include    | 10 +++++
>   8 files changed, 78 insertions(+), 65 deletions(-)

Looks like this doesn't apply cleanly and thus needs a rebase. Pls submit a
v2, thanks!
