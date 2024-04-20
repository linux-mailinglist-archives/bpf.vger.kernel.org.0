Return-Path: <bpf+bounces-27271-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 959C08AB833
	for <lists+bpf@lfdr.de>; Sat, 20 Apr 2024 02:56:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4B5E1C20AE3
	for <lists+bpf@lfdr.de>; Sat, 20 Apr 2024 00:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F25A410F7;
	Sat, 20 Apr 2024 00:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kMtNY03x"
X-Original-To: bpf@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D8F38B
	for <bpf@vger.kernel.org>; Sat, 20 Apr 2024 00:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713574573; cv=none; b=g0tZARr3jqCZstWjMC+WLmmsqwyfc85NerpV7yena6bqETFJBq0CJl3qWYqHk+j0VZXbZqLMuYJntvYNK9xWDEP0tehWNywPXX/dnugGPQWMZHyefFNbSqt3NhI6u5+fdCTKm/sZIkkKggt2cDvNrZ1SzQnIq9XzO/RPlabVxRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713574573; c=relaxed/simple;
	bh=hBy6UTxY8N6D6OUw4axcPvqvdd9zcGecFDPuS3bAFvg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xh/6nanjudyaRNbFdyZzbP3r7jpj027+5t6FGtQipw9GtiugygIPwfQSIiYEf6G1yiSQiHxTKZX4RnCDeUuO3GajRlof7G0Tj0QT6BU61S1HMWe6qEvs6fx06409VGnn24sITo0hLEhOVtWcS4Tpxd5wNP9LcG6sLzT2OpnMp/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kMtNY03x; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <05869e15-fb3b-494f-bf80-43d5f0be89fa@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1713574568;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TWxFuS8KOGm1Mkg9vTQ1ba95s1SAyh91PE+9f7p1nK4=;
	b=kMtNY03xnAc1GKnOG82peaexe/8RtbdsmHf8Y0xObxrAE2IPkcRjhReayXG1ObZOv4xsQp
	j5IrL9oV+whPXmEvaOB4T/svRdrS6ATTqDNE5WxzlNFvDz0wCvFft4x+5YSRxFMniD2eex
	Lo4ViX8c90sVbKuvv6O+qHN6+dlB+wk=
Date: Sat, 20 Apr 2024 01:56:06 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v9 3/4] selftests: bpf: crypto skcipher algo
 selftests
To: Martin KaFai Lau <martin.lau@linux.dev>, Vadim Fedorenko <vadfed@meta.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
 Herbert Xu <herbert@gondor.apana.org.au>, netdev@vger.kernel.org,
 linux-crypto@vger.kernel.org, bpf@vger.kernel.org
References: <20240416204004.3942393-1-vadfed@meta.com>
 <20240416204004.3942393-4-vadfed@meta.com>
 <60a88a78-d6d5-48b9-b894-47e4e54240df@linux.dev>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <60a88a78-d6d5-48b9-b894-47e4e54240df@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 19/04/2024 22:38, Martin KaFai Lau wrote:
> On 4/16/24 1:40 PM, Vadim Fedorenko wrote:
>> +void test_crypto_sanity(void)
>> +{
>> +    struct crypto_syscall_args sargs = {
>> +        .key_len = 16,
>> +    };
>> +    LIBBPF_OPTS(bpf_tc_hook, qdisc_hook, .attach_point = BPF_TC_EGRESS);
>> +    LIBBPF_OPTS(bpf_tc_opts, tc_attach_enc);
>> +    LIBBPF_OPTS(bpf_tc_opts, tc_attach_dec);
>> +    LIBBPF_OPTS(bpf_test_run_opts, opts,
>> +            .ctx_in = &sargs,
>> +            .ctx_size_in = sizeof(sargs),
>> +    );
>> +    struct nstoken *nstoken = NULL;
>> +    struct crypto_sanity *skel;
>> +    char afalg_plain[16] = {0};
>> +    char afalg_dst[16] = {0};
>> +    struct sockaddr_in6 addr;
>> +    int sockfd, err, pfd;
>> +    socklen_t addrlen;
>> +
>> +    SYS(fail, "ip netns add %s", NS_TEST);
>> +    SYS(fail, "ip -net %s -6 addr add %s/128 dev lo nodad", NS_TEST, 
>> IPV6_IFACE_ADDR);
>> +    SYS(fail, "ip -net %s link set dev lo up", NS_TEST);
>> +
>> +    nstoken = open_netns(NS_TEST);
>> +    if (!ASSERT_OK_PTR(nstoken, "open_netns"))
>> +        goto fail;
> 
> skel is not initialized. The "fail:" case needs it.
> 
>> +
>> +    err = init_afalg();
>> +    if (!ASSERT_OK(err, "AF_ALG init fail"))
>> +        goto fail;
>> +
>> +    qdisc_hook.ifindex = if_nametoindex("lo");
>> +    if (!ASSERT_GT(qdisc_hook.ifindex, 0, "if_nametoindex lo"))
>> +        goto fail;
>> +
>> +    skel = crypto_sanity__open_and_load();
>> +    if (!ASSERT_OK_PTR(skel, "skel open"))
>> +        return;
> 
> The netns "crypto_sanity_ns" is not deleted.
> 

I'll re-arrange skel init and open_netns. Dunno why it was moved, it 
should be other way.

>> +
>> +    memcpy(skel->bss->key, crypto_key, sizeof(crypto_key));
>> +    snprintf(skel->bss->algo, 128, "%s", algo);
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
>> +    err = crypto_sanity__attach(skel);
> 
> This attach is a left over from previous revision?
> 

Looks like it is.

>> +    if (!ASSERT_OK(err, "crypto_sanity__attach"))
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
>> +    tc_attach_enc.prog_fd = bpf_program__fd(skel->progs.encrypt_sanity);
>> +    err = bpf_tc_attach(&qdisc_hook, &tc_attach_enc);
>> +    if (!ASSERT_OK(err, "attach encrypt filter"))
>> +        goto fail;
>> +
>> +    sockfd = socket(AF_INET6, SOCK_DGRAM, 0);
>> +    if (!ASSERT_NEQ(sockfd, -1, "encrypt socket"))
>> +        goto fail;
>> +    err = sendto(sockfd, plain_text, sizeof(plain_text), 0, (void 
>> *)&addr, addrlen);
>> +    close(sockfd);
>> +    if (!ASSERT_EQ(err, sizeof(plain_text), "encrypt send"))
>> +        goto fail;
>> +
>> +    do_crypt_afalg(plain_text, afalg_dst, sizeof(afalg_dst), true);
>> +
>> +    bpf_tc_detach(&qdisc_hook, &tc_attach_enc);
> 
> Check error.
> 
> I suspect this detach should have failed because at least the 
> tc_attach_enc.prog_fd is not 0.
> 
> The following attach (&tc_attach_"dec") may just happen to have a higher 
> priority such that the left over here does not matter. It is still 
> better to get it right.
> 

Ok, I'll follow the way of tc_opts test

>> +    if (!ASSERT_OK(skel->bss->status, "encrypt status"))
>> +        goto fail;
>> +    if (!ASSERT_STRNEQ(skel->bss->dst, afalg_dst, sizeof(afalg_dst), 
>> "encrypt AF_ALG"))
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
>> +    err = sendto(sockfd, afalg_dst, sizeof(afalg_dst), 0, (void 
>> *)&addr, addrlen);
>> +    close(sockfd);
>> +    if (!ASSERT_EQ(err, sizeof(afalg_dst), "decrypt send"))
>> +        goto fail;
>> +
>> +    do_crypt_afalg(afalg_dst, afalg_plain, sizeof(afalg_plain), false);
>> +
>> +    bpf_tc_detach(&qdisc_hook, &tc_attach_dec);
>> +    if (!ASSERT_OK(skel->bss->status, "decrypt status"))
>> +        goto fail;
>> +    if (!ASSERT_STRNEQ(skel->bss->dst, afalg_plain, 
>> sizeof(afalg_plain), "decrypt AF_ALG"))
>> +        goto fail;
>> +
>> +fail:
>> +    if (nstoken) {
> 
> No need to check NULL. close_netns() can handle it.
> 
>> +        bpf_tc_hook_destroy(&qdisc_hook);
> 
> This also does not destroy the clsact qdisc. Although the function name 
> feels like it would, from a quick look at bpf_tc_hook_destroy, it 
> depends on both BPF_TC_INGRESS and BPF_TC_EGRESS are set in the 
> qdisc_hook.attach_point.
> 
> I would skip the whole bpf_tc_hook_destroy. It will go away together 
> with the netns.
> 

Got it

> [ ... ]
> 
>> diff --git a/tools/testing/selftests/bpf/progs/crypto_sanity.c 
>> b/tools/testing/selftests/bpf/progs/crypto_sanity.c
>> new file mode 100644
>> index 000000000000..57df5776bcaf
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/progs/crypto_sanity.c
>> @@ -0,0 +1,161 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
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
>> +unsigned char key[256] = {};
>> +char algo[128] = {};
>> +char dst[16] = {};
>> +int status;
>> +
>> +static int skb_dynptr_validate(struct __sk_buff *skb, struct 
>> bpf_dynptr *psrc)
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
>> +    if (bpf_skb_load_bytes(skb, ETH_HLEN + sizeof(ip6h), &udph, 
>> sizeof(udph)))
>> +        return -1;
>> +
>> +    if (udph.dest != __bpf_constant_htons(UDP_TEST_PORT))
>> +        return -1;
>> +
>> +    offset = ETH_HLEN + sizeof(ip6h) + sizeof(udph);
>> +    if (skb->len < offset + 16)
>> +        return -1;
>> +
>> +    /* let's make sure that 16 bytes of payload are in the linear 
>> part of skb */
>> +    bpf_skb_pull_data(skb, offset + 16);
>> +    bpf_dynptr_from_skb(skb, 0, psrc);
>> +    bpf_dynptr_adjust(psrc, offset, offset + 16);
>> +
>> +    return 0;
>> +}
>> +
>> +SEC("syscall")
>> +int skb_crypto_setup(struct crypto_syscall_args *ctx)
>> +{
>> +    struct bpf_crypto_params params = {
>> +        .type = "skcipher",
>> +        .key_len = ctx->key_len,
>> +        .authsize = ctx->authsize,
>> +    };
>> +    struct bpf_crypto_ctx *cctx;
>> +    int err = 0;
>> +
>> +    status = 0;
>> +
>> +    if (ctx->key_len > 255) {
> 
> key_len == 256 won't work ?

Yeah, you are right, I'll adjust the check

> 
>> +        status = -EINVAL;
>> +        return 0;
>> +    }
>> +
>> +    __builtin_memcpy(&params.algo, algo, sizeof(algo));
>> +    __builtin_memcpy(&params.key, key, sizeof(key));
> 
> It will be useful to comment here what problem was hit such that the key 
> cannot be passed in the "struct crypto_syscall_args" and need to go back 
> to the global variable.

Ok, I'll add some details.

> Instead of "key_len" in the crypto_syscall_args and the actual "key" in 
> global, how about skip using the "struct crypto_syscall_args" altogether 
> and put key_len (and authsize) in the global?
> 
> Put UDP_TEST_PORT as a global variable for config/filter usage also and 
> the "crypto_share.h" can go away.
> 

Yeah, I can do it.

>> +    cctx = bpf_crypto_ctx_create(&params, &err);
>> +
>> +    if (!cctx) {
>> +        status = err;
>> +        return 0;
>> +    }
>> +
>> +    err = crypto_ctx_insert(cctx);
>> +    if (err && err != -EEXIST)
>> +        status = err;
>> +
>> +    return 0;
>> +}
>> +
>> +SEC("tc")
>> +int decrypt_sanity(struct __sk_buff *skb)
>> +{
>> +    struct __crypto_ctx_value *v;
>> +    struct bpf_crypto_ctx *ctx;
>> +    struct bpf_dynptr psrc, pdst, iv;
>> +    int err;
>> +
>> +    err = skb_dynptr_validate(skb, &psrc);
>> +    if (err < 0) {
>> +        status = err;
>> +        return TC_ACT_SHOT;
>> +    }
>> +
>> +    v = crypto_ctx_value_lookup();
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
>> +    bpf_dynptr_from_mem(dst, sizeof(dst), 0, &pdst);
> 
> dst is now a global which makes it easier to test the result. A comment 
> here to note this point for people referencing this test for production 
> use case and suggest a percpu map could be used.

Ok

> It will be useful to have dynptr working with stack memory in the future.

Another follow-up?

>> +    /* iv dynptr has to be initialized with 0 size, but proper memory 
>> region
>> +     * has to be provided anyway
>> +     */
>> +    bpf_dynptr_from_mem(dst, 0, 0, &iv);
>> +
>> +    status = bpf_crypto_decrypt(ctx, &psrc, &pdst, &iv);
>> +
>> +    return TC_ACT_SHOT;
>> +}
>> +
>> +SEC("tc")
>> +int encrypt_sanity(struct __sk_buff *skb)
>> +{
>> +    struct __crypto_ctx_value *v;
>> +    struct bpf_crypto_ctx *ctx;
>> +    struct bpf_dynptr psrc, pdst, iv;
>> +    int err;
>> +
>> +    status = 0;
>> +
>> +    err = skb_dynptr_validate(skb, &psrc);
>> +    if (err < 0) {
>> +        status = err;
>> +        return TC_ACT_SHOT;
>> +    }
>> +
>> +    v = crypto_ctx_value_lookup();
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
>> +    bpf_dynptr_from_mem(dst, sizeof(dst), 0, &pdst);
>> +    /* iv dynptr has to be initialized with 0 size, but proper memory 
>> region
>> +     * has to be provided anyway
>> +     */
>> +    bpf_dynptr_from_mem(dst, 0, 0, &iv);
>> +
>> +    status = bpf_crypto_encrypt(ctx, &psrc, &pdst, &iv);
>> +
>> +    return TC_ACT_SHOT;
>> +}
>> +
>> +char __license[] SEC("license") = "GPL";
>> diff --git a/tools/testing/selftests/bpf/progs/crypto_share.h 
>> b/tools/testing/selftests/bpf/progs/crypto_share.h
>> new file mode 100644
>> index 000000000000..c5a6ef65156d
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/progs/crypto_share.h
>> @@ -0,0 +1,10 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
>> +
>> +#define UDP_TEST_PORT 7777
>> +
>> +struct crypto_syscall_args {
>> +    u32 key_len;
>> +    u32 authsize;
>> +};
>> +
> 


