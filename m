Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0D4149FA59
	for <lists+bpf@lfdr.de>; Fri, 28 Jan 2022 14:07:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241360AbiA1NHv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 28 Jan 2022 08:07:51 -0500
Received: from www62.your-server.de ([213.133.104.62]:34338 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241382AbiA1NHu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 28 Jan 2022 08:07:50 -0500
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1nDQyi-0006Qp-Hq; Fri, 28 Jan 2022 14:07:48 +0100
Received: from [85.1.206.226] (helo=linux.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1nDQyi-000P2c-C1; Fri, 28 Jan 2022 14:07:48 +0100
Subject: Re: [PATCH bpf-next v2 0/4] migrate from bpf_prog_test_run{,_xattr}
To:     Delyan Kratunov <delyank@fb.com>, bpf@vger.kernel.org,
        ast@kernel.org, andrii@kernel.org
Cc:     lmb@cloudflare.com
References: <20220128012319.2494472-1-delyank@fb.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <310cca5f-ecca-5624-e4c2-e2ee79069e0b@iogearbox.net>
Date:   Fri, 28 Jan 2022 14:07:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20220128012319.2494472-1-delyank@fb.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.5/26436/Fri Jan 28 10:22:17 2022)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 1/28/22 2:23 AM, Delyan Kratunov wrote:
> Fairly straight-forward mechanical transformation from bpf_prog_test_run
> and bpf_prog_test_run_xattr to the bpf_prog_test_run_opts goodness.
> Most of the changes are in tests, though bpftool and libbpf (xsk.c) have one
> call site each as well.
> 
> The only aspect that's still a bit RFC is that prog_run_xattr is testing
> behavior specific to bpf_prog_test_run_xattr, which does not exist in prog_run_opts.
> Namely, -EINVAL return on data_out == NULL && data_size_out > 0.
> Adding this behavior to prog_test_run_opts is one option, keeping the test as-is
> and cloning it to use bpf_prog_test_run_opts is another possibility.

I would suggest to do the former rather than duplicating, if there's nothing
particularly blocking us from adding this to prog_test_run_opts.

> The current version just suppresses the deprecation warning.
> 
> As an aside, checkpatch really doesn't like that LIBBPF_OPTS looks like
> a function call but is formatted like a struct declaration. If anyone
> cares about formatting, now would be a good time to mention it.

As you have it looks good to me. One small nit, please also add a non-empty
commit message with rationale to each of the patches rather than just SoB alone.

Thanks a lot!

> v1 -> v2:
> Split selftests/bpf changes into two commits to appease the mailing list.
> 
> Delyan Kratunov (4):
>    selftests: bpf: migrate from bpf_prog_test_run
>    selftests: bpf: migrate from bpf_prog_test_run_xattr
>    bpftool: migrate from bpf_prog_test_run_xattr
>    libbpf: Deprecate bpf_prog_test_run_xattr and bpf_prog_test_run
> 
