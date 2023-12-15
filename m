Return-Path: <bpf+bounces-17951-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A8E58140AD
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 04:33:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC15B1C222D0
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 03:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9D76539D;
	Fri, 15 Dec 2023 03:33:41 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E888ACA70
	for <bpf@vger.kernel.org>; Fri, 15 Dec 2023 03:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4SrvvF6y0bz4f3l1q
	for <bpf@vger.kernel.org>; Fri, 15 Dec 2023 11:33:29 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 050D91A01C2
	for <bpf@vger.kernel.org>; Fri, 15 Dec 2023 11:33:35 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP3 (Coremail) with SMTP id _Ch0CgCH6bcLyXtlXPN_Dg--.9715S2;
	Fri, 15 Dec 2023 11:33:34 +0800 (CST)
Subject: Re: [PATCH bpf-next v2 6/6] selftests/bpf: Cope with 512 bytes limit
 with bpf_global_percpu_ma
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
 Martin KaFai Lau <martin.lau@kernel.org>
References: <20231215001152.3249146-1-yonghong.song@linux.dev>
 <20231215001227.3254314-1-yonghong.song@linux.dev>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <64834348-0758-e388-e57f-0b71d0be42c9@huaweicloud.com>
Date: Fri, 15 Dec 2023 11:33:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20231215001227.3254314-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:_Ch0CgCH6bcLyXtlXPN_Dg--.9715S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWr1xAr4DKw47GryDJryxZrb_yoWrGrWDpa
	48Aa4Fyr1vqw12g3W3tw4jkryrXrs2qFy5A3yfJry8Zr9Iq34xXr4Fk3W5JF98Ca929w13
	AasagFZrCF1xC3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUk0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
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

On 12/15/2023 8:12 AM, Yonghong Song wrote:
> In the previous patch, the maximum data size for bpf_global_percpu_ma
> is 512 bytes. This breaks selftest test_bpf_ma. Let us adjust it
> accordingly. Also added a selftest to capture the verification failure
> when the allocation size is greater than 512.
>
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---
>  .../selftests/bpf/progs/percpu_alloc_fail.c    | 18 ++++++++++++++++++
>  .../testing/selftests/bpf/progs/test_bpf_ma.c  |  9 ---------
>  2 files changed, 18 insertions(+), 9 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/progs/percpu_alloc_fail.c b/tools/testing/selftests/bpf/progs/percpu_alloc_fail.c
> index 1a891d30f1fe..f2b8eb2ff76f 100644
> --- a/tools/testing/selftests/bpf/progs/percpu_alloc_fail.c
> +++ b/tools/testing/selftests/bpf/progs/percpu_alloc_fail.c
> @@ -17,6 +17,10 @@ struct val_with_rb_root_t {
>  	struct bpf_spin_lock lock;
>  };
>  
> +struct val_600b_t {
> +	char b[600];
> +};
> +
>  struct elem {
>  	long sum;
>  	struct val_t __percpu_kptr *pc;
> @@ -161,4 +165,18 @@ int BPF_PROG(test_array_map_7)
>  	return 0;
>  }
>  
> +SEC("?fentry.s/bpf_fentry_test1")
> +__failure __msg("bpf_percpu_obj_new type size (600) is greater than 512")
> +int BPF_PROG(test_array_map_8)
> +{
> +	struct val_600b_t __percpu_kptr *p;
> +
> +	p = bpf_percpu_obj_new(struct val_600b_t);
> +	if (!p)
> +		return 0;
> +
> +	bpf_percpu_obj_drop(p);
> +	return 0;
> +}
> +
>  char _license[] SEC("license") = "GPL";
> diff --git a/tools/testing/selftests/bpf/progs/test_bpf_ma.c b/tools/testing/selftests/bpf/progs/test_bpf_ma.c
> index b685a4aba6bd..68cba55eb828 100644
> --- a/tools/testing/selftests/bpf/progs/test_bpf_ma.c
> +++ b/tools/testing/selftests/bpf/progs/test_bpf_ma.c
> @@ -188,9 +188,6 @@ DEFINE_ARRAY_WITH_PERCPU_KPTR(128);
>  DEFINE_ARRAY_WITH_PERCPU_KPTR(192);
>  DEFINE_ARRAY_WITH_PERCPU_KPTR(256);
>  DEFINE_ARRAY_WITH_PERCPU_KPTR(512);
> -DEFINE_ARRAY_WITH_PERCPU_KPTR(1024);
> -DEFINE_ARRAY_WITH_PERCPU_KPTR(2048);
> -DEFINE_ARRAY_WITH_PERCPU_KPTR(4096);

Considering the update in patch "bpf: Avoid unnecessary extra percpu
memory allocation", the definition of DEFINE_ARRAY_WITH_PERCPU_KPTR()
needs update as well, because for 512-sized per-cpu kptr, the tests only
allocate for (512 - sizeof(void *)) bytes. And we could do
DEFINE_ARRAY_WITH_PERCPU_KPTR(8) test after the update. I could do that
after the patch-set is landed if you don't have time to do that.

A bit of off-topic, but it is still relevant. I have a question about
how to forcibly generate BTF info for struct definition in the test ?
Currently, I have to include  bin_data_xx in the definition of
map_value, but I don't want to increase the size of map_value. I had
tried to use BTF_TYPE_EMIT() in prog just like in linux kernel, but it
didn't work.
>  
>  SEC("?fentry/" SYS_PREFIX "sys_nanosleep")
>  int test_batch_alloc_free(void *ctx)
> @@ -259,9 +256,6 @@ int test_batch_percpu_alloc_free(void *ctx)
>  	CALL_BATCH_PERCPU_ALLOC_FREE(192, 128, 6);
>  	CALL_BATCH_PERCPU_ALLOC_FREE(256, 128, 7);
>  	CALL_BATCH_PERCPU_ALLOC_FREE(512, 64, 8);
> -	CALL_BATCH_PERCPU_ALLOC_FREE(1024, 32, 9);
> -	CALL_BATCH_PERCPU_ALLOC_FREE(2048, 16, 10);
> -	CALL_BATCH_PERCPU_ALLOC_FREE(4096, 8, 11);
>  
>  	return 0;
>  }
> @@ -283,9 +277,6 @@ int test_percpu_free_through_map_free(void *ctx)
>  	CALL_BATCH_PERCPU_ALLOC(192, 128, 6);
>  	CALL_BATCH_PERCPU_ALLOC(256, 128, 7);
>  	CALL_BATCH_PERCPU_ALLOC(512, 64, 8);
> -	CALL_BATCH_PERCPU_ALLOC(1024, 32, 9);
> -	CALL_BATCH_PERCPU_ALLOC(2048, 16, 10);
> -	CALL_BATCH_PERCPU_ALLOC(4096, 8, 11);
>  
>  	return 0;
>  }


