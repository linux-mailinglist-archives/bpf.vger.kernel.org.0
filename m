Return-Path: <bpf+bounces-13868-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB7997DE9BE
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 01:55:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64254B210A4
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 00:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C08E010F9;
	Thu,  2 Nov 2023 00:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="c2mKIK//"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F56610E7
	for <bpf@vger.kernel.org>; Thu,  2 Nov 2023 00:54:54 +0000 (UTC)
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [IPv6:2001:41d0:1004:224b::b4])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07C1812C
	for <bpf@vger.kernel.org>; Wed,  1 Nov 2023 17:54:48 -0700 (PDT)
Message-ID: <1b100f73-7625-4c1f-3ae5-50ecf84d3ff0@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1698886487;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tu7k6GVhfgFhyMGos5ea7K7iPu9zjOW8Thc9RPv8WD4=;
	b=c2mKIK//3VxZk2cBDDifUgrTY4YqW1HmdVkOfIZ9hV6kg6RMk/4dr/R6gifq5IqzJVdVC2
	DL2ppZuAc87sNNDfozwdhMwb4xrkochWXMGRshkuWKc0A5Yi2OH2tqN5y28W9uSkXQjARZ
	kiU2Gq+at/tCnukZiadM6lWuIRVNUaQ=
Date: Thu, 2 Nov 2023 00:54:45 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 2/2] selftests: bpf: crypto skcipher algo
 selftests
Content-Language: en-US
To: Martin KaFai Lau <martin.lau@linux.dev>, Vadim Fedorenko <vadfed@meta.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
 linux-crypto@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Mykola Lysenko <mykolal@fb.com>
References: <20231031134900.1432945-1-vadfed@meta.com>
 <20231031134900.1432945-2-vadfed@meta.com>
 <0568c28a-f631-a12c-97ce-dbc9e5ee62b4@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <0568c28a-f631-a12c-97ce-dbc9e5ee62b4@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 01.11.2023 22:53, Martin KaFai Lau wrote:
> On 10/31/23 6:49 AM, Vadim Fedorenko wrote:
>> Add simple tc hook selftests to show the way to work with new crypto
>> BPF API. Some weird structre and map are added to setup program to make
>> verifier happy about dynptr initialization from memory. Simple AES-ECB
>> algo is used to demonstrate encryption and decryption of fixed size
>> buffers.
>>
>> Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
>> ---
>> v2 -> v3:
>> - disable tests on s390 and aarch64 because of unknown Fatal exception
>>    in sg_init_one
>> v1 -> v2:
>> - add CONFIG_CRYPTO_AES and CONFIG_CRYPTO_ECB to selftest build config
>>    suggested by Daniel
>>
>>   kernel/bpf/crypto.c                           |   5 +-
>>   tools/testing/selftests/bpf/DENYLIST.aarch64  |   1 +
>>   tools/testing/selftests/bpf/DENYLIST.s390x    |   1 +
>>   tools/testing/selftests/bpf/config            |   3 +
>>   .../selftests/bpf/prog_tests/crypto_sanity.c  | 129 +++++++++++++++
>>   .../selftests/bpf/progs/crypto_common.h       | 103 ++++++++++++
>>   .../selftests/bpf/progs/crypto_sanity.c       | 154 ++++++++++++++++++
>>   7 files changed, 394 insertions(+), 2 deletions(-)
>>   create mode 100644 tools/testing/selftests/bpf/prog_tests/crypto_sanity.c
>>   create mode 100644 tools/testing/selftests/bpf/progs/crypto_common.h
>>   create mode 100644 tools/testing/selftests/bpf/progs/crypto_sanity.c
>>
>> diff --git a/kernel/bpf/crypto.c b/kernel/bpf/crypto.c
>> index c2a0703934fc..4ee6193165ca 100644
>> --- a/kernel/bpf/crypto.c
>> +++ b/kernel/bpf/crypto.c
>> @@ -65,8 +65,9 @@ static void *__bpf_dynptr_data_ptr(const struct 
>> bpf_dynptr_kern *ptr)
>>    *
>>    * bpf_crypto_skcipher_ctx_create() allocates memory using the BPF memory
>>    * allocator, and will not block. It may return NULL if no memory is available.
>> - * @algo: bpf_dynptr which holds string representation of algorithm.
>> - * @key:  bpf_dynptr which holds cipher key to do crypto.
>> + * @palgo: bpf_dynptr which holds string representation of algorithm.
>> + * @pkey:  bpf_dynptr which holds cipher key to do crypto.
>> + * @err:   integer to store error code when NULL is returned
>>    */
>>   __bpf_kfunc struct bpf_crypto_skcipher_ctx *
>>   bpf_crypto_skcipher_ctx_create(const struct bpf_dynptr_kern *palgo,
>> diff --git a/tools/testing/selftests/bpf/DENYLIST.aarch64 
>> b/tools/testing/selftests/bpf/DENYLIST.aarch64
>> index 5c2cc7e8c5d0..72c7ef3e5872 100644
>> --- a/tools/testing/selftests/bpf/DENYLIST.aarch64
>> +++ b/tools/testing/selftests/bpf/DENYLIST.aarch64
>> @@ -1,5 +1,6 @@
>>   bpf_cookie/multi_kprobe_attach_api               # 
>> kprobe_multi_link_api_subtest:FAIL:fentry_raw_skel_load unexpected error: -3
>>   bpf_cookie/multi_kprobe_link_api                 # 
>> kprobe_multi_link_api_subtest:FAIL:fentry_raw_skel_load unexpected error: -3
>> +crypto_sanity                     # sg_init_one has exception on aarch64
> 
> What is the exception? Is arm64 just lacking the support?

I have no idea, TBH. Might be because of different aligment requirements, but
it's just guess.

> 
>>   exceptions                     # JIT does not support calling kfunc 
>> bpf_throw: -524
>>   fexit_sleep                                      # The test never returns. 
>> The remaining tests cannot start.
>>   kprobe_multi_bench_attach                        # needs CONFIG_FPROBE
>> diff --git a/tools/testing/selftests/bpf/DENYLIST.s390x 
>> b/tools/testing/selftests/bpf/DENYLIST.s390x
>> index 1a63996c0304..8ab7485bedb1 100644
>> --- a/tools/testing/selftests/bpf/DENYLIST.s390x
>> +++ b/tools/testing/selftests/bpf/DENYLIST.s390x
>> @@ -1,5 +1,6 @@
>>   # TEMPORARY
>>   # Alphabetical order
>> +crypto_sanity                 # sg_init_one has exception on 
>> s390                           (exceptions)
>>   exceptions                 # JIT does not support calling kfunc 
>> bpf_throw                       (exceptions)
>>   get_stack_raw_tp                         # user_stack corrupted user 
>> stack                                             (no backchain userspace)
>>   stacktrace_build_id                      # compare_map_keys stackid_hmap vs. 
>> stackmap err -2 errno 2                   (?)
>> diff --git a/tools/testing/selftests/bpf/config 
>> b/tools/testing/selftests/bpf/config
>> index 02dd4409200e..48b570fd1752 100644
>> --- a/tools/testing/selftests/bpf/config
>> +++ b/tools/testing/selftests/bpf/config
>> @@ -14,6 +14,9 @@ CONFIG_CGROUP_BPF=y
>>   CONFIG_CRYPTO_HMAC=y
>>   CONFIG_CRYPTO_SHA256=y
>>   CONFIG_CRYPTO_USER_API_HASH=y
>> +CONFIG_CRYPTO_SKCIPHER=y
>> +CONFIG_CRYPTO_ECB=y
>> +CONFIG_CRYPTO_AES=y
>>   CONFIG_DEBUG_INFO=y
>>   CONFIG_DEBUG_INFO_BTF=y
>>   CONFIG_DEBUG_INFO_DWARF4=y
>> diff --git a/tools/testing/selftests/bpf/prog_tests/crypto_sanity.c 
>> b/tools/testing/selftests/bpf/prog_tests/crypto_sanity.c
>> new file mode 100644
>> index 000000000000..a43969da6d15
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/prog_tests/crypto_sanity.c
>> @@ -0,0 +1,129 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/* Copyright (c) 2022 Meta Platforms, Inc. and affiliates. */
> 
> s/2022/2023/ :)

ah, sure

> 
>> +
>> +#include <sys/types.h>
>> +#include <sys/socket.h>
>> +#include <net/if.h>
>> +#include <linux/in6.h>
>> +
>> +#include "test_progs.h"
>> +#include "network_helpers.h"
>> +#include "crypto_sanity.skel.h"
>> +
>> +#define NS_TEST "crypto_sanity_ns"
>> +#define IPV6_IFACE_ADDR "face::1"
>> +#define UDP_TEST_PORT 7777
>> +static const char plain_text[] = "stringtoencrypt0";
>> +static const char crypted_data[] = 
>> "\x5B\x59\x39\xEA\xD9\x7A\x2D\xAD\xA7\xE0\x43" \
>> +                   "\x37\x8A\x77\x17\xB2";
>> +
>> +void test_crypto_sanity(void)
>> +{
>> +    LIBBPF_OPTS(bpf_tc_hook, qdisc_hook, .attach_point = BPF_TC_EGRESS);
>> +    LIBBPF_OPTS(bpf_tc_opts, tc_attach_enc);
>> +    LIBBPF_OPTS(bpf_tc_opts, tc_attach_dec);
>> +    LIBBPF_OPTS(bpf_test_run_opts, opts,
>> +            .data_in = crypted_data,
>> +            .data_size_in = sizeof(crypted_data),
> 
> This should not be needed now because the test_run is on a tracing program.

yep, will remove it

> 
>> +            .repeat = 1,
>> +    );
>> +    struct nstoken *nstoken = NULL;
>> +    struct crypto_sanity *skel;
>> +    struct sockaddr_in6 addr;
>> +    int sockfd, err, pfd;
>> +    socklen_t addrlen;
>> +
>> +    skel = crypto_sanity__open();
>> +    if (!ASSERT_OK_PTR(skel, "skel open"))
>> +        return;
>> +
>> +    bpf_program__set_autoload(skel->progs.skb_crypto_setup, true);
> 
> Remove the '?' from SEC("?fentry.s/bpf_fentry_test1") should save this 
> set_autoload call

ok
.
> 
>> +
>> +    SYS(fail, "ip netns add %s", NS_TEST);
>> +    SYS(fail, "ip -net %s -6 addr add %s/128 dev lo nodad", NS_TEST, 
>> IPV6_IFACE_ADDR);
>> +    SYS(fail, "ip -net %s link set dev lo up", NS_TEST);
>> +
>> +    err = crypto_sanity__load(skel);
>> +    if (!ASSERT_OK(err, "crypto_sanity__load"))
>> +        goto fail;
>> +
>> +    nstoken = open_netns(NS_TEST);
>> +    if (!ASSERT_OK_PTR(nstoken, "open_netns"))
>> +        goto fail;
>> +
>> +    qdisc_hook.ifindex = if_nametoindex("lo");
>> +    if (!ASSERT_GT(qdisc_hook.ifindex, 0, "if_nametoindex lo"))
>> +        goto fail;
>> +
>> +    err = crypto_sanity__attach(skel);
>> +    if (!ASSERT_OK(err, "crypto_sanity__attach"))
>> +        goto fail;
>> +
>> +    pfd = bpf_program__fd(skel->progs.skb_crypto_setup);
>> +    if (!ASSERT_GT(pfd, 0, "skb_crypto_setup fd"))
>> +        goto fail;
>> +
>> +    err = bpf_prog_test_run_opts(pfd, &opts);
>> +    if (!ASSERT_OK(err, "skb_crypto_setup") ||
>> +        !ASSERT_OK(opts.retval, "skb_crypto_setup retval"))
>> +        goto fail;
>> +
>> +    if (!ASSERT_OK(skel->bss->status, "skb_crypto_setup status"))
>> +        goto fail;
>> +
>> +    err = bpf_tc_hook_create(&qdisc_hook);
>> +    if (!ASSERT_OK(err, "create qdisc hook"))
>> +        goto fail;
>> +
>> +    addrlen = sizeof(addr);
>> +    err = make_sockaddr(AF_INET6, IPV6_IFACE_ADDR, UDP_TEST_PORT,
>> +                (void *)&addr, &addrlen);
>> +    if (!ASSERT_OK(err, "make_sockaddr"))
>> +        goto fail;
>> +
>> +    tc_attach_dec.prog_fd = bpf_program__fd(skel->progs.decrypt_sanity);
>> +    err = bpf_tc_attach(&qdisc_hook, &tc_attach_dec);
>> +    if (!ASSERT_OK(err, "attach decrypt filter"))
>> +        goto fail;
>> +
>> +    sockfd = socket(AF_INET6, SOCK_DGRAM, 0);
>> +    if (!ASSERT_NEQ(sockfd, -1, "decrypt socket"))
>> +        goto fail;
>> +    err = sendto(sockfd, crypted_data, 16, 0, (void *)&addr, addrlen);
>> +    close(sockfd);
>> +    if (!ASSERT_EQ(err, 16, "decrypt send"))
>> +        goto fail;
>> +
>> +    bpf_tc_detach(&qdisc_hook, &tc_attach_dec);
>> +    if (!ASSERT_OK(skel->bss->status, "decrypt status"))
>> +        goto fail;
>> +    if (!ASSERT_STRNEQ(skel->bss->dst, plain_text, sizeof(plain_text), 
>> "decrypt"))
>> +        goto fail;
>> +
>> +    tc_attach_enc.prog_fd = bpf_program__fd(skel->progs.encrypt_sanity);
>> +    err = bpf_tc_attach(&qdisc_hook, &tc_attach_enc);
>> +    if (!ASSERT_OK(err, "attach encrypt filter"))
>> +        goto fail;
>> +
>> +    sockfd = socket(AF_INET6, SOCK_DGRAM, 0);
>> +    if (!ASSERT_NEQ(sockfd, -1, "encrypt socket"))
>> +        goto fail;
>> +    err = sendto(sockfd, plain_text, 16, 0, (void *)&addr, addrlen);
>> +    close(sockfd);
>> +    if (!ASSERT_EQ(err, 16, "encrypt send"))
>> +        goto fail;
>> +
>> +    bpf_tc_detach(&qdisc_hook, &tc_attach_enc);
>> +    if (!ASSERT_OK(skel->bss->status, "encrypt status"))
>> +        goto fail;
>> +    if (!ASSERT_STRNEQ(skel->bss->dst, crypted_data, sizeof(crypted_data), 
>> "encrypt"))
>> +        goto fail;
>> +
>> +fail:
>> +    if (nstoken) {
>> +        bpf_tc_hook_destroy(&qdisc_hook);
>> +        close_netns(nstoken);
>> +    }
>> +    SYS_NOFAIL("ip netns del " NS_TEST " &> /dev/null");
>> +    crypto_sanity__destroy(skel);
>> +}
>> diff --git a/tools/testing/selftests/bpf/progs/crypto_common.h 
>> b/tools/testing/selftests/bpf/progs/crypto_common.h
>> new file mode 100644
>> index 000000000000..584378bb6df8
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/progs/crypto_common.h
>> @@ -0,0 +1,103 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/* Copyright (c) 2023 Meta Platforms, Inc. and affiliates. */
>> +
>> +#ifndef _CRYPTO_COMMON_H
>> +#define _CRYPTO_COMMON_H
>> +
>> +#include "errno.h"
>> +#include <stdbool.h>
>> +
>> +#define private(name) SEC(".bss." #name) __hidden __attribute__((aligned(8)))
>> +private(CTX) static struct bpf_crypto_skcipher_ctx __kptr * global_crypto_ctx;
> 
> Add a test to show how it is used?

I'm thinking if we really need this? Looks like we don't.

> 
>> +
>> +struct bpf_crypto_skcipher_ctx *bpf_crypto_skcipher_ctx_create(const struct 
>> bpf_dynptr *algo,
>> +                                   const struct bpf_dynptr *key,
>> +                                   int *err) __ksym;
>> +struct bpf_crypto_skcipher_ctx *bpf_crypto_skcipher_ctx_acquire(struct 
>> bpf_crypto_skcipher_ctx *ctx) __ksym;
>> +void bpf_crypto_skcipher_ctx_release(struct bpf_crypto_skcipher_ctx *ctx) 
>> __ksym;
> 
> Same for acquire and release kfunc. Add test cases.
> 
> btw, does it have use cases to store the same bpf_crypto_skcipher_ctx in 
> multiple maps?

Yeah, sure. You can potentially use the same algo with the same configured key
in parallel. All sensitive data is stored in the request structure.

> 
>> +int bpf_crypto_skcipher_encrypt(struct bpf_crypto_skcipher_ctx *ctx,
>> +                const struct bpf_dynptr *src, struct bpf_dynptr *dst,
>> +                const struct bpf_dynptr *iv) __ksym;
>> +int bpf_crypto_skcipher_decrypt(struct bpf_crypto_skcipher_ctx *ctx,
>> +                const struct bpf_dynptr *src, struct bpf_dynptr *dst,
>> +                const struct bpf_dynptr *iv) __ksym;
>> +
>> +struct __crypto_skcipher_ctx_value {
>> +    struct bpf_crypto_skcipher_ctx __kptr * ctx;
>> +};
>> +
>> +struct crypto_conf_value {
>> +    __u8 algo[32];
>> +    __u32 algo_size;
>> +    __u8 key[32];
>> +    __u32 key_size;
>> +    __u8 iv[32];
>> +    __u32 iv_size;
>> +    __u8 dst[32];
>> +    __u32 dst_size;
>> +};
>> +
>> +struct array_conf_map {
>> +    __uint(type, BPF_MAP_TYPE_ARRAY);
>> +    __type(key, int);
>> +    __type(value, struct crypto_conf_value);
>> +    __uint(max_entries, 1);
>> +} __crypto_conf_map SEC(".maps");
>> +
>> +struct array_map {
>> +    __uint(type, BPF_MAP_TYPE_ARRAY);
>> +    __type(key, int);
>> +    __type(value, struct __crypto_skcipher_ctx_value);
>> +    __uint(max_entries, 1);
>> +} __crypto_skcipher_ctx_map SEC(".maps");
>> +
>> +static inline struct crypto_conf_value *crypto_conf_lookup(void)
>> +{
>> +    struct crypto_conf_value *v, local = {};
>> +    u32 key = 0;
>> +
>> +    v = bpf_map_lookup_elem(&__crypto_conf_map, &key);
>> +    if (v)
>> +        return v;
>> +
>> +    bpf_map_update_elem(&__crypto_conf_map, &key, &local, 0);
>> +    return bpf_map_lookup_elem(&__crypto_conf_map, &key);
> 
> hmm... local is all 0 which became the map value. Where is it initialized?

ahh.. it's actually initialized in ctx_insert(). but looks like this part is
left from previous iteration. I'll adjust the code.

> 
>> +}
>> +
>> +static inline struct __crypto_skcipher_ctx_value 
>> *crypto_skcipher_ctx_value_lookup(void)
>> +{
>> +    u32 key = 0;
>> +
>> +    return bpf_map_lookup_elem(&__crypto_skcipher_ctx_map, &key);
>> +}
>> +
>> +static inline int crypto_skcipher_ctx_insert(struct bpf_crypto_skcipher_ctx 
>> *ctx)
>> +{
>> +    struct __crypto_skcipher_ctx_value local, *v;
>> +    long status;
> 
> nit. s/status/err/

sure

> 
>> +    struct bpf_crypto_skcipher_ctx *old;
>> +    u32 key = 0;
>> +
>> +    local.ctx = NULL;
>> +    status = bpf_map_update_elem(&__crypto_skcipher_ctx_map, &key, &local, 0);
>> +    if (status) {
>> +        bpf_crypto_skcipher_ctx_release(ctx);
>> +        return status;
>> +    }
>> +
>> +    v = bpf_map_lookup_elem(&__crypto_skcipher_ctx_map, &key);
>> +    if (!v) {
>> +        bpf_crypto_skcipher_ctx_release(ctx);
>> +        return -ENOENT;
>> +    }
>> +
>> +    old = bpf_kptr_xchg(&v->ctx, ctx);
>> +    if (old) {
>> +        bpf_crypto_skcipher_ctx_release(old);
>> +        return -EEXIST;
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>> +#endif /* _CRYPTO_COMMON_H */
>> diff --git a/tools/testing/selftests/bpf/progs/crypto_sanity.c 
>> b/tools/testing/selftests/bpf/progs/crypto_sanity.c
>> new file mode 100644
>> index 000000000000..71a172d8d2a2
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/progs/crypto_sanity.c
>> @@ -0,0 +1,154 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/* Copyright (c) 2023 Meta Platforms, Inc. and affiliates. */
>> +
>> +#include "vmlinux.h"
>> +#include "bpf_tracing_net.h"
>> +#include <bpf/bpf_helpers.h>
>> +#include <bpf/bpf_endian.h>
>> +#include <bpf/bpf_tracing.h>
>> +#include "bpf_misc.h"
>> +#include "bpf_kfuncs.h"
>> +#include "crypto_common.h"
>> +
>> +#define UDP_TEST_PORT 7777
>> +unsigned char crypto_key[16] = "testtest12345678";
>> +char crypto_algo[9] = "ecb(aes)";
>> +char dst[32] = {};
>> +int status;
>> +
>> +static inline int skb_validate_test(const struct __sk_buff *skb)
>> +{
>> +    struct ipv6hdr ip6h;
>> +    struct udphdr udph;
>> +    u32 offset;
>> +
>> +    if (skb->protocol != __bpf_constant_htons(ETH_P_IPV6))
>> +        return -1;
>> +
>> +    if (bpf_skb_load_bytes(skb, ETH_HLEN, &ip6h, sizeof(ip6h)))
>> +        return -1;
>> +
>> +    if (ip6h.nexthdr != IPPROTO_UDP)
>> +        return -1;
>> +
>> +    if (bpf_skb_load_bytes(skb, ETH_HLEN + sizeof(ip6h), &udph, sizeof(udph)))
>> +        return -1;
>> +
>> +    if (udph.dest != __bpf_constant_htons(UDP_TEST_PORT))
>> +        return -1;
>> +
>> +    offset = ETH_HLEN + sizeof(ip6h) + sizeof(udph);
>> +    if (skb->len < offset + 16)
>> +        return -1;
>> +
>> +    return offset;
>> +}
>> +
>> +SEC("?fentry.s/bpf_fentry_test1")
> 
> I wonder if others have better idea how to do this. This is basically setting up 
> the algo and key which requires to call a kfunc in sleepable context. Otherwise, 
> the tc's test_run would be a better fit.

The other way can be implement crypto API function to allocate with GFP_ATOMIC.
Currently all skcipher allocations are hard-coded to GFP_KERNEL.

> 
>> +int BPF_PROG(skb_crypto_setup)
>> +{
>> +    struct crypto_conf_value *c;
>> +    struct bpf_dynptr algo, key;
>> +    int err = 0;
>> +
>> +    status = 0;
>> +
>> +    c = crypto_conf_lookup();
> 
> "c" is not used. Why lookup is needed? May be properly setup the 
> __crypto_conf_map so the example is more complete.
> 

This is most exciting part. Without this lookup verifier complains on the 
initialization of dynptr from memory buffer. I don't really understand the
way it works or changes pointers types.

>> +    if (!c) {
>> +        status = -EINVAL;
>> +        return 0;
>> +    }
>> +
>> +    bpf_dynptr_from_mem(crypto_algo, sizeof(crypto_algo), 0, &algo);
>> +    bpf_dynptr_from_mem(crypto_key, sizeof(crypto_key), 0, &key);
>> +    struct bpf_crypto_skcipher_ctx *cctx = 
>> bpf_crypto_skcipher_ctx_create(&algo, &key, &err);
>> +
>> +    if (!cctx) {
>> +        status = err;
>> +        return 0;
>> +    }
>> +
>> +    err = crypto_skcipher_ctx_insert(cctx);
>> +    if (err && err != -EEXIST)
>> +        status = err;
>> +
>> +    return 0;
>> +}
>> +
>> +SEC("tc")
>> +int decrypt_sanity(struct __sk_buff *skb)
>> +{
>> +    struct __crypto_skcipher_ctx_value *v;
>> +    struct bpf_crypto_skcipher_ctx *ctx;
>> +    struct bpf_dynptr psrc, pdst, iv;
>> +    int err;
> 
> nit. s/err/offset/. "err" is actually the offset for the common case.
> 
> btw, considering dynptr psrc has to be created from skb anyway, is it easier to 
> use bpf_dynptr_slice(psrc, 0, NULL, ETH_HLEN + sizeof(ip6h) + sizeof(udph)) in 
> the above skb_validate_test()?

Yeah, maybe it's better. The only problem is naming then...

> 
>> +
>> +    err = skb_validate_test(skb);
>> +    if (err < 0) {
>> +        status = err;
>> +        return TC_ACT_SHOT;
>> +    }
>> +
>> +    v = crypto_skcipher_ctx_value_lookup();
>> +    if (!v) {
>> +        status = -ENOENT;
>> +        return TC_ACT_SHOT;
>> +    }
>> +
>> +    ctx = v->ctx;
>> +    if (!ctx) {
>> +        status = -ENOENT;
>> +        return TC_ACT_SHOT;
>> +    }
>> +
>> +    bpf_dynptr_from_skb(skb, 0, &psrc);
>> +    bpf_dynptr_adjust(&psrc, err, err + 16);
>> +    bpf_dynptr_from_mem(dst, sizeof(dst), 0, &pdst);
>> +    bpf_dynptr_from_mem(dst, 0, 0, &iv);
>> +
>> +    bpf_crypto_skcipher_decrypt(ctx, &psrc, &pdst, &iv);
> 
> check decrypt return value before setting "status = 0;' below.

Agree, will adjust the code.

>> +
>> +    status = 0;
>> +
>> +    return TC_ACT_SHOT;
>> +}
>> +
>> +SEC("tc")
>> +int encrypt_sanity(struct __sk_buff *skb)
>> +{
>> +    struct __crypto_skcipher_ctx_value *v;
>> +    struct bpf_crypto_skcipher_ctx *ctx;
>> +    struct bpf_dynptr psrc, pdst, iv;
>> +    int err;
>> +
>> +    status = 0;
>> +
>> +    err = skb_validate_test(skb);
>> +    if (err < 0) {
>> +        status = err;
>> +        return TC_ACT_SHOT;
>> +    }
>> +
>> +    v = crypto_skcipher_ctx_value_lookup();
>> +    if (!v) {
>> +        status = -ENOENT;
>> +        return TC_ACT_SHOT;
>> +    }
>> +
>> +    ctx = v->ctx;
>> +    if (!ctx) {
>> +        status = -ENOENT;
>> +        return TC_ACT_SHOT;
>> +    }
>> +
>> +    bpf_dynptr_from_skb(skb, 0, &psrc);
>> +    bpf_dynptr_adjust(&psrc, err, err + 16);
>> +    bpf_dynptr_from_mem(dst, sizeof(dst), 0, &pdst);
>> +    bpf_dynptr_from_mem(dst, 0, 0, &iv);
>> +
>> +    bpf_crypto_skcipher_encrypt(ctx, &psrc, &pdst, &iv);
> 
> Same here. check return value.
>

Yep.

>> +
>> +    return TC_ACT_SHOT;
>> +}
>> +
>> +char __license[] SEC("license") = "GPL";
> 


