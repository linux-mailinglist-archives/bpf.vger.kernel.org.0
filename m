Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26BD3643828
	for <lists+bpf@lfdr.de>; Mon,  5 Dec 2022 23:31:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233086AbiLEWbt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 5 Dec 2022 17:31:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231940AbiLEWbs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 5 Dec 2022 17:31:48 -0500
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 565C95FCD
        for <bpf@vger.kernel.org>; Mon,  5 Dec 2022 14:31:47 -0800 (PST)
Received: from sslproxy03.your-server.de ([88.198.220.132])
        by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <daniel@iogearbox.net>)
        id 1p2K01-000Pvn-0f; Mon, 05 Dec 2022 23:31:45 +0100
Received: from [85.1.206.226] (helo=linux.home)
        by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1p2K00-000THE-L7; Mon, 05 Dec 2022 23:31:44 +0100
Subject: Re: [PATCH net-next v2 2/2] Add a selftest for devmap pinning.
To:     Pramukh Naduthota <pnaduthota@google.com>, bpf@vger.kernel.org
Cc:     ast@kernel.org, andrii@kernel.org, martin.lau@linux.dev,
        song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org
References: <20221201011135.1589838-1-pnaduthota@google.com>
 <20221201011135.1589838-3-pnaduthota@google.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <55bc0068-880d-4715-0fb5-a2b384951c1d@iogearbox.net>
Date:   Mon, 5 Dec 2022 23:31:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20221201011135.1589838-3-pnaduthota@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.7/26741/Mon Dec  5 09:16:09 2022)
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 12/1/22 2:11 AM, Pramukh Naduthota wrote:
> Add a selftest
> 
> Signed-off-by: Pramukh Naduthota <pnaduthota@google.com>
> ---
>   .../testing/selftests/bpf/prog_tests/devmap.c | 20 +++++++++++++++++++
>   .../selftests/bpf/progs/test_pinned_devmap.c  | 17 ++++++++++++++++
>   2 files changed, 37 insertions(+)
>   create mode 100644 tools/testing/selftests/bpf/prog_tests/devmap.c
>   create mode 100644 tools/testing/selftests/bpf/progs/test_pinned_devmap.c
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/devmap.c b/tools/testing/selftests/bpf/prog_tests/devmap.c
> new file mode 100644
> index 000000000000..50c5006c1416
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/devmap.c
> @@ -0,0 +1,20 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2022 Google */
> +#include "testing_helpers.h"
> +#include "test_progs.h"
> +#include "test_pinned_devmap.skel.h"
> +
> +void test_devmap_pinning(void)
> +{
> +	struct test_pinned_devmap *ptr;
> +
> +	ptr = test_pinned_devmap__open_and_load()
> +	ASSERT_OK_PTR(ptr, "first load");

Looks like you never actually compiled your selftest? :(

     [...]
     TEST-OBJ [test_progs] rcu_read_lock.test.o
     TEST-OBJ [test_progs] btf_dump.test.o
   In file included from /tmp/work/bpf/bpf/tools/testing/selftests/bpf/prog_tests/devmap.c:4:
   /tmp/work/bpf/bpf/tools/testing/selftests/bpf/prog_tests/devmap.c: In function ‘test_devmap_pinning’:
   ./test_progs.h:352:35: error: expected expression before ‘{’ token
     352 | #define ASSERT_OK_PTR(ptr, name) ({     \
         |                                   ^
   /tmp/work/bpf/bpf/tools/testing/selftests/bpf/prog_tests/devmap.c:12:2: note: in expansion of macro ‘ASSERT_OK_PTR’
      12 |  ASSERT_OK_PTR(ptr, "first load");
         |  ^~~~~~~~~~~~~
   /tmp/work/bpf/bpf/tools/testing/selftests/bpf/prog_tests/devmap.c:11:8: error: called object is not a function or function pointer
      11 |  ptr = test_pinned_devmap__open_and_load()
         |        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   make: *** [Makefile:539: /tmp/work/bpf/bpf/tools/testing/selftests/bpf/devmap.test.o] Error 1
   make: *** Waiting for unfinished jobs....
   make: Leaving directory '/tmp/work/bpf/bpf/tools/testing/selftests/bpf'
   Error: Process completed with exit code 2.

> +	test_pinned_devmap__destroy(ptr);
> +	ASSERT_OK_PTR(test_pinned_devmap__open_and_load(), "re-load");
> +}
> +
> +void test_devmap(void)
> +{
> +	test_devmap_pinning();
> +}
> diff --git a/tools/testing/selftests/bpf/progs/test_pinned_devmap.c b/tools/testing/selftests/bpf/progs/test_pinned_devmap.c
> new file mode 100644
> index 000000000000..2e9b25fe657c
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/test_pinned_devmap.c
> @@ -0,0 +1,17 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2022 Google */
> +#include <stddef.h>
> +#include <linux/bpf.h>
> +#include <linux/types.h>
> +#include <bpf/bpf_helpers.h>
> +
> +struct {
> +	__uint(type, BPF_MAP_TYPE_DEVMAP_HASH);
> +	__uint(max_entries, 32);
> +	__type(key, int);
> +	__type(value, int);
> +	__uint(pinning, LIBBPF_PIN_BY_NAME);
> +} repinned_dev_map SEC(".maps");
> +
> +
> +char _license[] SEC("license") = "GPL";
> 

