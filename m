Return-Path: <bpf+bounces-16709-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77678804A64
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 07:39:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E1681F2147E
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 06:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E7DA12E5D;
	Tue,  5 Dec 2023 06:39:19 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68FEAFA
	for <bpf@vger.kernel.org>; Mon,  4 Dec 2023 22:39:15 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4SkrV36DgCz4f3l1W
	for <bpf@vger.kernel.org>; Tue,  5 Dec 2023 14:39:07 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 8D9841A04B0
	for <bpf@vger.kernel.org>; Tue,  5 Dec 2023 14:39:12 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP2 (Coremail) with SMTP id Syh0CgBH60mNxW5l9k5+Cw--.1332S2;
	Tue, 05 Dec 2023 14:39:12 +0800 (CST)
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: Fix flaky test_btf_id test
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
 Martin KaFai Lau <martin.lau@kernel.org>
References: <20231205060450.3577161-1-yonghong.song@linux.dev>
 <20231205060455.3577644-1-yonghong.song@linux.dev>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <8f19799f-ecbc-acee-4892-13cb1a50db7f@huaweicloud.com>
Date: Tue, 5 Dec 2023 14:39:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20231205060455.3577644-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID:Syh0CgBH60mNxW5l9k5+Cw--.1332S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Aw1UCrWUWr4DCw1DGF1fXrb_yoW8ZrWxpa
	yrJr4YkrW0ka1UZr1rJw4agFW0krnxJ345AF1xKry5ArWDXa4xXr1Iga15ZFZxKrZ5Z34a
	v3W8K393u3yxAFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUk0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42
	xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv
	6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUOyCJDUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

Hi,

On 12/5/2023 2:04 PM, Yonghong Song wrote:
> With previous patch, one of subtests in test_btf_id becomes
> flaky and may fail. The following is a failing example:
>
>   Error: #26 btf
>   Error: #26/174 btf/BTF ID
>     Error: #26/174 btf/BTF ID
>     btf_raw_create:PASS:check 0 nsec
>     btf_raw_create:PASS:check 0 nsec
>     test_btf_id:PASS:check 0 nsec
>     ...
>     test_btf_id:PASS:check 0 nsec
>     test_btf_id:FAIL:check BTF lingersdo_test_get_info:FAIL:check failed: -1
>
> The test tries to prove a btf_id not available after the map is closed.
> But btf_id is freed only after workqueue and a rcu grace period, compared
> to previous case just after a rcu grade period.

It is not accurate. Before applying the patch, the btf_id will be
released in btf_put() and there is no RCU grace period involved. After
applying the patch, the btf_id will be released after the running of
bpf_map_free_deferred kworker.
>
> To fix the flaky test, I added a kern_sync_rcu() after closing map and
> before querying btf id availability, essentially ensuring a rcu grace
> period in the kernel, which seems making the test happy.

kern_sync_rcu() doesn't guarantee the bpf_map_free_deferred kworker will
complete, so why not remove the test case instead ?
>
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---
>  tools/testing/selftests/bpf/prog_tests/btf.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/btf.c b/tools/testing/selftests/bpf/prog_tests/btf.c
> index 8fb4a04fbbc0..7feb4223bbac 100644
> --- a/tools/testing/selftests/bpf/prog_tests/btf.c
> +++ b/tools/testing/selftests/bpf/prog_tests/btf.c
> @@ -4629,6 +4629,7 @@ static int test_btf_id(unsigned int test_num)
>  
>  	/* The map holds the last ref to BTF and its btf_id */
>  	close(map_fd);
> +	kern_sync_rcu();
>  	map_fd = -1;
>  	btf_fd[0] = bpf_btf_get_fd_by_id(map_info.btf_id);
>  	if (CHECK(btf_fd[0] >= 0, "BTF lingers")) {


