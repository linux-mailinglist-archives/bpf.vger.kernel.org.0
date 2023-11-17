Return-Path: <bpf+bounces-15225-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3479E7EF0E2
	for <lists+bpf@lfdr.de>; Fri, 17 Nov 2023 11:45:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63EE21C20A77
	for <lists+bpf@lfdr.de>; Fri, 17 Nov 2023 10:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5CB618E10;
	Fri, 17 Nov 2023 10:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B79E811D
	for <bpf@vger.kernel.org>; Fri, 17 Nov 2023 02:45:09 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4SWtp74cpSz4f3jZ1
	for <bpf@vger.kernel.org>; Fri, 17 Nov 2023 18:45:03 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 3B8651A01A1
	for <bpf@vger.kernel.org>; Fri, 17 Nov 2023 18:45:06 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP2 (Coremail) with SMTP id Syh0CgAnfUsuRFdlvfTQBA--.59012S2;
	Fri, 17 Nov 2023 18:45:06 +0800 (CST)
From: Hou Tao <houtao@huaweicloud.com>
Subject: Re: [PATCH bpf-next v11 13/13] selftests/bpf: test case for
 register_bpf_struct_ops().
To: thinker.li@gmail.com, bpf@vger.kernel.org, ast@kernel.org,
 martin.lau@linux.dev, song@kernel.org, kernel-team@meta.com,
 andrii@kernel.org, drosen@google.com
Cc: sinquersw@gmail.com, kuifeng@meta.com
References: <20231106201252.1568931-1-thinker.li@gmail.com>
 <20231106201252.1568931-14-thinker.li@gmail.com>
Message-ID: <e9360742-57db-9f40-6227-d15db29ee25f@huaweicloud.com>
Date: Fri, 17 Nov 2023 18:45:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20231106201252.1568931-14-thinker.li@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID:Syh0CgAnfUsuRFdlvfTQBA--.59012S2
X-Coremail-Antispam: 1UD129KBjvdXoWrtF18ZFW8ur4xGFy7GrW7Arb_yoWDGrXEvw
	4Iyr1kGa13Jr1rAr40vFy5CrWIg3yfGrnFq345Xw1fJw45Wa1DCF4kJ343Xa48WrZ3GrZa
	qwn8C393Wr42kjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbxAYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
	j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
	kEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xKxwCYjI0SjxkI62AI
	1cAE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8
	ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AK
	xVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07
	UWE__UUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

Hi,

On 11/7/2023 4:12 AM, thinker.li@gmail.com wrote:
> From: Kui-Feng Lee <thinker.li@gmail.com>
>
> Create a new struct_ops type called bpf_testmod_ops within the bpf_testmod
> module. When a struct_ops object is registered, the bpf_testmod module will
> invoke test_2 from the module.
>
> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
SNIP
> diff --git a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
> new file mode 100644
> index 000000000000..49f4a4460642
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
> @@ -0,0 +1,144 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2023 Meta Platforms, Inc. and affiliates. */
> +#include <test_progs.h>
> +#include <time.h>
> +
> +#include "rcu_tasks_trace_gp.skel.h"

It is no needed anymore. It seems it is a leftover from last revision.


