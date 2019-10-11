Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02C13D34BF
	for <lists+bpf@lfdr.de>; Fri, 11 Oct 2019 02:01:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725951AbfJKABC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Oct 2019 20:01:02 -0400
Received: from www62.your-server.de ([213.133.104.62]:42016 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726827AbfJKABC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 10 Oct 2019 20:01:02 -0400
Received: from 55.249.197.178.dynamic.dsl-lte-bonding.lssmb00p-msn.res.cust.swisscom.ch ([178.197.249.55] helo=localhost)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1iIiMb-0002Th-3f; Fri, 11 Oct 2019 02:00:57 +0200
Date:   Fri, 11 Oct 2019 02:00:56 +0200
From:   Daniel Borkmann <daniel@iogearbox.net>
To:     Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Cc:     ast@kernel.org, yhs@fb.com, davem@davemloft.net,
        jakub.kicinski@netronome.com, hawk@kernel.org,
        john.fastabend@gmail.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        clang-built-linux@googlegroups.com, ilias.apalodimas@linaro.org,
        sergei.shtylyov@cogentembedded.com
Subject: Re: [PATCH v4 bpf-next 00/15] samples: bpf: improve/fix
 cross-compilation
Message-ID: <20191011000056.GD20202@pc-63.home>
References: <20191009204134.26960-1-ivan.khoronzhuk@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191009204134.26960-1-ivan.khoronzhuk@linaro.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.101.4/25598/Thu Oct 10 10:50:35 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Oct 09, 2019 at 11:41:19PM +0300, Ivan Khoronzhuk wrote:
> This series contains mainly fixes/improvements for cross-compilation
> but not only, tested for arm, arm64, and intended for any arch.
> Also verified on native build (not cross compilation) for x86_64
> and arm, arm64.
[...]

There are multiple SOBs missing, please fix. Thanks!

[...]
 5 files changed, 218 insertions(+), 99 deletions(-)
 create mode 100644 samples/bpf/Makefile.target
 rename tools/lib/bpf/{test_libbpf.cpp => test_libbpf.c} (61%)
Deleted branch mbox (was 9f35d1d0c8f0).
Commit 9f35d1d0c8f0 ("samples/bpf: Add preparation steps and sysroot info to readme")
	author Signed-off-by missing
	committer Signed-off-by missing
	author email:    ivan.khoronzhuk@linaro.org
	committer email: daniel@iogearbox.net


Commit 1878c1de4607 ("samples/bpf: Use __LINUX_ARM_ARCH__ selector for arm")
	author Signed-off-by missing
	committer Signed-off-by missing
	author email:    ivan.khoronzhuk@linaro.org
	committer email: daniel@iogearbox.net


Errors in tree with Signed-off-by, please fix!
