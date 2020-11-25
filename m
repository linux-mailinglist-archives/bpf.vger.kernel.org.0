Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1ED92C4BA9
	for <lists+bpf@lfdr.de>; Thu, 26 Nov 2020 00:37:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbgKYXh1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 25 Nov 2020 18:37:27 -0500
Received: from www62.your-server.de ([213.133.104.62]:52594 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726471AbgKYXh1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 25 Nov 2020 18:37:27 -0500
Received: from sslproxy01.your-server.de ([78.46.139.224])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1ki4Lm-0003pP-12; Thu, 26 Nov 2020 00:37:26 +0100
Received: from [85.7.101.30] (helo=pc-9.home)
        by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1ki4Ll-000VEX-9Z; Thu, 26 Nov 2020 00:37:25 +0100
Subject: Re: [PATCH bpf-next] selftest/bpf: fix compilation on clang 11
To:     Andrei Matei <andreimatei1@gmail.com>, bpf@vger.kernel.org
Cc:     andrii@kernel.org
References: <20201125035255.17970-1-andreimatei1@gmail.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <9213c34c-e40c-61a5-c3d1-61dcb6449c09@iogearbox.net>
Date:   Thu, 26 Nov 2020 00:37:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20201125035255.17970-1-andreimatei1@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.4/25999/Wed Nov 25 15:06:38 2020)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 11/25/20 4:52 AM, Andrei Matei wrote:
> Before this patch, profiler.inc.h wouldn't compile with clang-11 (before
> the __builtin_preserve_enum_value LLVM builtin was introduced in
> https://reviews.llvm.org/D83242).
> Another test that uses this builtin (test_core_enumval) is conditionally
> skipped if the compiler is too old. In that spirit, this patch inhibits
> part of populate_cgroup_info(), which needs this CO-RE builtin. The
> selftests build again on clang-11.  The affected test (the profiler
> test) doesn't pass on clang-11 because it's missing
> https://reviews.llvm.org/D85570, but at least the test suite as a whole
> compiles. The test's expected failure is already called out in the
> README.
> 
> Signed-off-by: Andrei Matei <andreimatei1@gmail.com>

Looks good, applied, thanks!
