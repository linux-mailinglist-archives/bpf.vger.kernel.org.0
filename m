Return-Path: <bpf+bounces-3448-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 578CE73E269
	for <lists+bpf@lfdr.de>; Mon, 26 Jun 2023 16:48:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D4911C20970
	for <lists+bpf@lfdr.de>; Mon, 26 Jun 2023 14:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E811946D;
	Mon, 26 Jun 2023 14:48:11 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC37463C0
	for <bpf@vger.kernel.org>; Mon, 26 Jun 2023 14:48:10 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73D0BE5F;
	Mon, 26 Jun 2023 07:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=w0OEQHhWTaY5+xoDZ44E+pjplhXIpJu95MgjHTt2CUk=; b=Wxx5TwxD19SCRC893FFiW41NE3
	hrK1MbW6NZ8QZdiJTMTxITsMxhBrEBgqdgAWq8tFlHCXqQpdKqFGqXGvQEJOuCONYDelPJpyEfRXs
	tocOS2jYK8isSzlKYpazknrYVIs+k90usWN8EwWd16rnNN8HOuCv4VwSmMAdPbSUfG2OPB3pyWncd
	dH/JjmDuPsQV6vheUjuxgCPU2wmmH4FpKKsknJRFoYsDznyoA9DpGgbIbBQhqwIKiVQ2OBBUJ02ja
	1czSsFQy2nFaN9i0Gy7tg3Dpy06vGxzJAEWCHNRmAYa0rPiHmS80GwGF9bsv4a9c/SJesk2LWPDZ0
	vhxLP2XQ==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qDnVS-000LNn-Fn; Mon, 26 Jun 2023 16:47:54 +0200
Received: from [85.1.206.226] (helo=linux.home)
	by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1qDnVR-000Hrk-RW; Mon, 26 Jun 2023 16:47:53 +0200
Subject: Re: [PATCH bpf-next v7 3/3] selftests/bpf: add testcase for TRACING
 with 6+ arguments
To: menglong8.dong@gmail.com, yhs@meta.com, alexei.starovoitov@gmail.com
Cc: ast@kernel.org, andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
 yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org, benbjiang@tencent.com,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 Menglong Dong <imagedong@tencent.com>, revest@chromium.org
References: <20230622075715.1818144-1-imagedong@tencent.com>
 <20230622075715.1818144-4-imagedong@tencent.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <d507239c-0e73-abb3-3863-f4363b8fdd11@iogearbox.net>
Date: Mon, 26 Jun 2023 16:47:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20230622075715.1818144-4-imagedong@tencent.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.8/26951/Mon Jun 26 09:29:31 2023)
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 6/22/23 9:57 AM, menglong8.dong@gmail.com wrote:
> From: Menglong Dong <imagedong@tencent.com>

(CC'ing also Florent wrt arm64)

> Add test9/test10 in fexit_test.c and fentry_test.c to test the fentry
> and fexit whose target function have 7/11 arguments.
> 
> Correspondingly, add bpf_testmod_fentry_test7() and
> bpf_testmod_fentry_test11() to bpf_testmod.c
> 
> Meanwhile, add bpf_modify_return_test2() to test_run.c to test the
> MODIFY_RETURN with 7 arguments.
> 
> Add bpf_testmod_test_struct_arg_7/bpf_testmod_test_struct_arg_7 in
> bpf_testmod.c to test the struct in the arguments.
> 
> And the testcases passed:
> 
> ./test_progs -t fexit
> Summary: 5/12 PASSED, 0 SKIPPED, 0 FAILED
> 
> ./test_progs -t fentry
> Summary: 3/0 PASSED, 0 SKIPPED, 0 FAILED
> 
> ./test_progs -t modify_return
> Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED
> 
> ./test_progs -t tracing_struct
> Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED
> 
> Signed-off-by: Menglong Dong <imagedong@tencent.com>
> Acked-by: Yonghong Song <yhs@fb.com>
> ---
> v6:
> - add testcases to tracing_struct.c instead of fentry_test.c and
>    fexit_test.c
> v5:
> - add testcases for MODIFY_RETURN
> v4:
> - use different type for args in bpf_testmod_fentry_test{7,12}
> - add testcase for grabage values in ctx
> v3:
> - move bpf_fentry_test{7,12} to bpf_testmod.c and rename them to
>    bpf_testmod_fentry_test{7,12} meanwhile
> - get return value by bpf_get_func_ret() in
>    "fexit/bpf_testmod_fentry_test12", as we don't change ___bpf_ctx_cast()
>    in this version
> ---
>   net/bpf/test_run.c                            | 23 ++++++--
>   .../selftests/bpf/bpf_testmod/bpf_testmod.c   | 49 ++++++++++++++++-
>   .../selftests/bpf/prog_tests/fentry_fexit.c   |  4 +-
>   .../selftests/bpf/prog_tests/fentry_test.c    |  2 +
>   .../selftests/bpf/prog_tests/fexit_test.c     |  2 +
>   .../selftests/bpf/prog_tests/modify_return.c  | 20 ++++++-
>   .../selftests/bpf/prog_tests/tracing_struct.c | 19 +++++++
>   .../testing/selftests/bpf/progs/fentry_test.c | 32 +++++++++++
>   .../testing/selftests/bpf/progs/fexit_test.c  | 33 ++++++++++++
>   .../selftests/bpf/progs/modify_return.c       | 40 ++++++++++++++
>   .../selftests/bpf/progs/tracing_struct.c      | 54 +++++++++++++++++++
>   11 files changed, 271 insertions(+), 7 deletions(-)

This triggers test failures on arm64 in BPF CI given the additions are
not yet supported there:

https://github.com/kernel-patches/bpf/actions/runs/5371020820/jobs/9743606263
https://github.com/kernel-patches/bpf/actions/runs/5371020820/jobs/9743606326

[...]
Notice: Success: 362/3077, Skipped: 12, Failed: 3
Error: #71 fentry_fexit
   Error: #71 fentry_fexit
   test_fentry_fexit:PASS:fentry_skel_load 0 nsec
   test_fentry_fexit:PASS:fexit_skel_load 0 nsec
   test_fentry_fexit:FAIL:fentry_attach unexpected error: -1 (errno 524)
Error: #72 fentry_test
   Error: #72 fentry_test
   test_fentry_test:PASS:fentry_skel_load 0 nsec
   fentry_test:FAIL:fentry_attach unexpected error: -1 (errno 524)
   test_fentry_test:FAIL:fentry_first_attach unexpected error: -1 (errno 524)
Error: #76 fexit_test
   Error: #76 fexit_test
   test_fexit_test:PASS:fexit_skel_load 0 nsec
   fexit_test:FAIL:fexit_attach unexpected error: -1 (errno 524)
   test_fexit_test:FAIL:fexit_first_attach unexpected error: -1 (errno 524)
[...]

I think probably the best way would be to separate the new test cases and
then update tools/testing/selftests/bpf/DENYLIST.aarch64 to exclude them
from being run on arm64 until support gets added there too.

Thanks,
Daniel

