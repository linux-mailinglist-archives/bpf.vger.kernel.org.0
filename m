Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6EB48E0C95
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2019 21:29:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731436AbfJVT34 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 22 Oct 2019 15:29:56 -0400
Received: from www62.your-server.de ([213.133.104.62]:43840 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729696AbfJVT34 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 22 Oct 2019 15:29:56 -0400
Received: from 13.249.197.178.dynamic.dsl-lte-bonding.lssmb00p-msn.res.cust.swisscom.ch ([178.197.249.13] helo=localhost)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1iMzqs-0004fV-1e; Tue, 22 Oct 2019 21:29:54 +0200
Date:   Tue, 22 Oct 2019 21:29:53 +0200
From:   Daniel Borkmann <daniel@iogearbox.net>
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@fb.com>,
        kernel-team@fb.com, Jiong Wang <jiong.wang@netronome.com>
Subject: Re: [PATCH bpf-next v2] tools/bpf: turn on llvm alu32 attribute by
 default
Message-ID: <20191022192953.GB31343@pc-66.home>
References: <20191022043119.2625263-1-yhs@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191022043119.2625263-1-yhs@fb.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.101.4/25610/Tue Oct 22 10:54:26 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Oct 21, 2019 at 09:31:19PM -0700, Yonghong Song wrote:
> llvm alu32 was introduced in llvm7:
>   https://reviews.llvm.org/rL325987
>   https://reviews.llvm.org/rL325989
> Experiments showed that in general performance
> is better with alu32 enabled:
>   https://lwn.net/Articles/775316/
> 
> This patch turned on alu32 with no-flavor test_progs
> which is tested most often. The flavor test at
> no_alu32/test_progs can be used to test without
> alu32 enabled. The Makefile check for whether
> llvm supports '-mattr=+alu32 -mcpu=v3' is
> removed as llvm7 should be available for recent
> distributions and also latest llvm is preferred
> to run bpf selftests.
> 
> Note that jmp32 is checked by -mcpu=probe and
> will be enabled if the host kernel supports it.
> 
> Cc: Jiong Wang <jiong.wang@netronome.com>
> Acked-by: Andrii Nakryiko <andriin@fb.com>
> Signed-off-by: Yonghong Song <yhs@fb.com>

Applied, thanks!

Would it make sense to include -mattr=+alu32 also into -mcpu=probe
on LLVM side or is the rationale to not do it that this causes a
penalty for various other, non-x86 archs when done by default
(although they could opt-out at the same time via -mattr=-alu32)?
