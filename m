Return-Path: <bpf+bounces-8097-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0FB278125C
	for <lists+bpf@lfdr.de>; Fri, 18 Aug 2023 19:51:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 666292821C3
	for <lists+bpf@lfdr.de>; Fri, 18 Aug 2023 17:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAB1E19BDD;
	Fri, 18 Aug 2023 17:51:08 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81CF7469F
	for <bpf@vger.kernel.org>; Fri, 18 Aug 2023 17:51:08 +0000 (UTC)
Received: from out-7.mta1.migadu.com (out-7.mta1.migadu.com [IPv6:2001:41d0:203:375::7])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91A84271B
	for <bpf@vger.kernel.org>; Fri, 18 Aug 2023 10:50:37 -0700 (PDT)
Message-ID: <817af9ec-0ba3-fab0-6d8a-4529ede337b5@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1692381035; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hqxWvBhaCsyfEq5wGsBx9n9QLyA/MnvQvOYFUo4ueBs=;
	b=PWqcNg7ZjSYdMSk9lLy7m8evQejk3eQNAdF2jUKrwyNYzB1dfFUnxIm99B5i4eQOnjCFc7
	GYQRWZbolKNGfrgQqufAl0cZiULtTUY1Su+VDfkW5hOcuZTnB4FZgOp6U9jX35MSwsln4K
	7mvSW8C3LmSC00nhdVV9wBbaHqPxm40=
Date: Fri, 18 Aug 2023 10:50:30 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: yonghong.song@linux.dev
Subject: Re: [PATCH bpf-next v5] selftests/bpf: trace_helpers.c: optimize
 kallsyms cache
Content-Language: en-US
To: Rong Tao <rtoax@foxmail.com>, olsajiri@gmail.com
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
 daniel@iogearbox.net, haoluo@google.com, john.fastabend@gmail.com,
 kpsingh@kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, martin.lau@linux.dev, mykolal@fb.com,
 rongtao@cestc.cn, sdf@google.com, shuah@kernel.org, song@kernel.org
References: <ZN9iDSj3/vdk5pRX@krava>
 <tencent_6F0CBE858CB29E2E63544C5FF7461710E909@qq.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <tencent_6F0CBE858CB29E2E63544C5FF7461710E909@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 8/18/23 8:36 AM, Rong Tao wrote:
> Hi, jirka
> 
> Sadly, we can't include libbpf_internal.h in trace_helpers.{h,c}.
> we only have the following headers when compile samples/bpf/:
> 
> tree of samples/bpf/libbpf/
>      +-- bpf_helper_defs.h
>      +-- include
>      |   '-- bpf
>      |       +-- bpf_core_read.h
>      |       +-- bpf_endian.h
>      |       +-- bpf.h
>      |       +-- bpf_helper_defs.h
>      |       +-- bpf_helpers.h
>      |       +-- bpf_tracing.h
>      |       +-- btf.h
>      |       +-- libbpf_common.h
>      |       +-- libbpf.h
>      |       +-- libbpf_legacy.h
>      |       +-- libbpf_version.h
>      |       +-- skel_internal.h
>      |       '-- usdt.bpf.h
>      +-- libbpf.a
> 
> No libbpf_internal.h here.
> 
> What if we add a declaration to libbpf_ensure_mem() in trace_helpers.c?

[~/work/bpf-next/tools/testing/selftests/bpf/prog_tests (master)]$ grep 
libbpf_internal.h *
cpu_mask.c:#include "bpf/libbpf_internal.h"
kprobe_multi_test.c:#include "bpf/libbpf_internal.h"
kprobe_multi_testmod_test.c:#include "bpf/libbpf_internal.h"
module_fentry_shadow.c:#include "bpf/libbpf_internal.h"
perf_branches.c:#include "bpf/libbpf_internal.h"
perf_buffer.c:#include "bpf/libbpf_internal.h"
raw_tp_test_run.c:#include "bpf/libbpf_internal.h"
[~/work/bpf-next/tools/testing/selftests/bpf/prog_tests (master)]$ grep 
libbpf_ensure_mem *.c
kprobe_multi_test.c:            err = libbpf_ensure_mem((void **) &syms, 
&cap,
[~/work/bpf-next/tools/testing/selftests/bpf/prog_tests (master)]$

Looks like it is already used for selftets.

The libbpf_internal.h exists in the following directory when you build
the selftest.

[~/work/bpf-next/tools/testing/selftests/bpf/tools/include/bpf (master)]$ ls
bpf_core_read.h  bpf.h              bpf_helpers.h  btf.h 
libbpf_common.h  libbpf_internal.h  libbpf_version.h  relo_core.h 
usdt.bpf.h
bpf_endian.h     bpf_helper_defs.h  bpf_tracing.h  hashmap.h  libbpf.h 
       libbpf_legacy.h    nlattr.h          skel_internal.h


> 
> Good Day,
> Rong Tao
> 
> 

