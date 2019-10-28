Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4053E77A8
	for <lists+bpf@lfdr.de>; Mon, 28 Oct 2019 18:35:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbfJ1Rf1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 28 Oct 2019 13:35:27 -0400
Received: from www62.your-server.de ([213.133.104.62]:50340 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725773AbfJ1Rf1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 28 Oct 2019 13:35:27 -0400
Received: from 49.249.197.178.dynamic.dsl-lte-bonding.lssmb00p-msn.res.cust.swisscom.ch ([178.197.249.49] helo=localhost)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1iP8vL-0007eb-4r; Mon, 28 Oct 2019 18:35:23 +0100
Date:   Mon, 28 Oct 2019 18:35:22 +0100
From:   Daniel Borkmann <daniel@iogearbox.net>
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Alexei Starovoitov <ast@kernel.org>, bpf@vger.kernel.org,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Andrii Nakryiko <andriin@fb.com>
Subject: Re: [PATCH bpf-next v2] selftests/bpf: restore $(OUTPUT)/test_stub.o
 rule
Message-ID: <20191028173522.GI14547@pc-63.home>
References: <20191028102110.7545-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191028102110.7545-1-iii@linux.ibm.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.101.4/25616/Mon Oct 28 09:57:02 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Oct 28, 2019 at 11:21:10AM +0100, Ilya Leoshkevich wrote:
> `make O=/linux-build kselftest TARGETS=bpf` fails with
> 
> 	make[3]: *** No rule to make target '/linux-build/bpf/test_stub.o', needed by '/linux-build/bpf/test_verifier'
> 
> The same command without the O= part works, presumably thanks to the
> implicit rule.
> 
> Fix by restoring the explicit $(OUTPUT)/test_stub.o rule.
> 
> Fixes: 74b5a5968fe8 ("selftests/bpf: Replace test_progs and test_maps w/ general rule")
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> Acked-by: Andrii Nakryiko <andriin@fb.com>

Applied, thanks!
