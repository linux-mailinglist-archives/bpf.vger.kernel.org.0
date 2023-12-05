Return-Path: <bpf+bounces-16680-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6446280440F
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 02:28:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 872731C20C70
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 01:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E7981C13;
	Tue,  5 Dec 2023 01:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TNw9MOV3"
X-Original-To: bpf@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E59BD7
	for <bpf@vger.kernel.org>; Mon,  4 Dec 2023 17:28:16 -0800 (PST)
Message-ID: <dbee6a35-0f6c-4125-a1b9-ff8ad3370fe5@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1701739693;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Lzv8E/raHGzwAjGaJlYoRPv/Yqac0JeM8OtgOnQCmyc=;
	b=TNw9MOV3UyosB++4eweYPJqDDpvKARMr01HzWQqmrYsvOcGbxwhwzZ/ec/cEJW7jUzyTKv
	x9gB7Ye9cDnyhrCUr9PAvpNOp7yyAhgbHwzE6cSeLUeFof2HoiJx/wwIq8f0ceAVVQP2u8
	rhcAxKHN5+Ba4nCAgZ4c2tTVOmIt7XU=
Date: Mon, 4 Dec 2023 17:28:05 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v7 3/3] selftests: bpf: crypto skcipher algo
 selftests
Content-Language: en-US
To: Vadim Fedorenko <vadfed@meta.com>
Cc: netdev@vger.kernel.org, linux-crypto@vger.kernel.org,
 bpf@vger.kernel.org, Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Jakub Kicinski <kuba@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
 Herbert Xu <herbert@gondor.apana.org.au>
References: <20231202010604.1877561-1-vadfed@meta.com>
 <20231202010604.1877561-3-vadfed@meta.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20231202010604.1877561-3-vadfed@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 12/1/23 5:06 PM, Vadim Fedorenko wrote:
> Add simple tc hook selftests to show the way to work with new crypto
> BPF API. Some weird structre and map are added to setup program to make
> verifier happy about dynptr initialization from memory. Simple AES-ECB
> algo is used to demonstrate encryption and decryption of fixed size
> buffers.
> 
> Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
> ---
> v6 -> v7:
> - style issues
> v5 -> v6:
> - use AF_ALG socket to confirm proper algorithm test
> - adjust test kernel config to include AF_ALG
> v4 -> v5:
> - adjust selftests to use new naming
> - restore tests on aarch64 and s390 as no sg lists are used
> v3 -> v4:
> - adjust selftests to use new syntax of helpers
> - add tests for acquire and release
> v2 -> v3:
> - disable tests on s390 and aarch64 because of unknown Fatal exception
>    in sg_init_one
> v1 -> v2:
> - add CONFIG_CRYPTO_AES and CONFIG_CRYPTO_ECB to selftest build config
>    suggested by Daniel
> ---
>   tools/testing/selftests/bpf/config            |   5 +
>   .../selftests/bpf/prog_tests/crypto_sanity.c  | 215 ++++++++++++++++++
>   .../selftests/bpf/progs/crypto_common.h       |  67 ++++++
>   .../selftests/bpf/progs/crypto_sanity.c       | 192 ++++++++++++++++
>   4 files changed, 479 insertions(+)
>   create mode 100644 tools/testing/selftests/bpf/prog_tests/crypto_sanity.c
>   create mode 100644 tools/testing/selftests/bpf/progs/crypto_common.h
>   create mode 100644 tools/testing/selftests/bpf/progs/crypto_sanity.c
> 
> diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftests/bpf/config
> index c125c441abc7..2221994a36d6 100644
> --- a/tools/testing/selftests/bpf/config
> +++ b/tools/testing/selftests/bpf/config
> @@ -13,7 +13,12 @@ CONFIG_BPF_SYSCALL=y
>   CONFIG_CGROUP_BPF=y
>   CONFIG_CRYPTO_HMAC=y
>   CONFIG_CRYPTO_SHA256=y
> +CONFIG_CRYPTO_USER_API=y
>   CONFIG_CRYPTO_USER_API_HASH=y
> +CONFIG_CRYPTO_USER_API_SKCIPHER=y
> +CONFIG_CRYPTO_SKCIPHER=y
> +CONFIG_CRYPTO_ECB=y
> +CONFIG_CRYPTO_AES=y
>   CONFIG_DEBUG_INFO=y
>   CONFIG_DEBUG_INFO_BTF=y
>   CONFIG_DEBUG_INFO_DWARF4=y
> diff --git a/tools/testing/selftests/bpf/prog_tests/crypto_sanity.c b/tools/testing/selftests/bpf/prog_tests/crypto_sanity.c
> new file mode 100644
> index 000000000000..2dd73cb248be
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/crypto_sanity.c
> @@ -0,0 +1,215 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2023 Meta Platforms, Inc. and affiliates. */
> +
> +#include <sys/types.h>
> +#include <sys/socket.h>
> +#include <net/if.h>
> +#include <linux/in6.h>
> +#include <linux/if_alg.h>
> +
> +#include "test_progs.h"
> +#include "network_helpers.h"
> +#include "crypto_sanity.skel.h"
> +
> +#define NS_TEST "crypto_sanity_ns"
> +#define IPV6_IFACE_ADDR "face::1"
> +#define UDP_TEST_PORT 7777
> +static const unsigned char crypto_key[] = "testtest12345678";
> +static const char plain_text[] = "stringtoencrypt0";
> +static int opfd, tfmfd;

nit. init to -1 and test for -1.

> +
> +int init_afalg(void)

static

> +{
> +	struct sockaddr_alg sa = {
> +		.salg_family = AF_ALG,
> +		.salg_type = "skcipher",
> +		.salg_name = "ecb(aes)"
> +	};
> +
> +	tfmfd = socket(AF_ALG, SOCK_SEQPACKET, 0);
> +	if (tfmfd == -1)
> +		return errno;
> +	if (bind(tfmfd, (struct sockaddr *)&sa, sizeof(sa)) == -1)
> +		return errno;
> +	if (setsockopt(tfmfd, SOL_ALG, ALG_SET_KEY, crypto_key, 16) == -1)
> +		return errno;
> +	opfd = accept(tfmfd, NULL, 0);
> +	if (opfd == -1)
> +		return errno;
> +	return 0;
> +}
> +
> +void deinit_afalg(void)

static

> +{
> +	if (tfmfd)
> +		close(tfmfd);
> +	if (opfd)
> +		close(opfd);
> +}
> +
> +void do_crypt_afalg(const void *src, void *dst, int size, bool encrypt)

static

> +{
> +	struct msghdr msg = {};
> +	struct cmsghdr *cmsg;
> +	char cbuf[CMSG_SPACE(4)] = {0};
> +	struct iovec iov;
> +
> +	msg.msg_control = cbuf;
> +	msg.msg_controllen = sizeof(cbuf);
> +
> +	cmsg = CMSG_FIRSTHDR(&msg);
> +	cmsg->cmsg_level = SOL_ALG;
> +	cmsg->cmsg_type = ALG_SET_OP;
> +	cmsg->cmsg_len = CMSG_LEN(4);
> +	*(__u32 *)CMSG_DATA(cmsg) = encrypt ? ALG_OP_ENCRYPT : ALG_OP_DECRYPT;
> +
> +	iov.iov_base = (char *)src;
> +	iov.iov_len = size;
> +
> +	msg.msg_iov = &iov;
> +	msg.msg_iovlen = 1;
> +
> +	sendmsg(opfd, &msg, 0);
> +	read(opfd, dst, size);
> +}
> +
> +void test_crypto_sanity(void)
> +{
> +	LIBBPF_OPTS(bpf_tc_hook, qdisc_hook, .attach_point = BPF_TC_EGRESS);
> +	LIBBPF_OPTS(bpf_tc_opts, tc_attach_enc);
> +	LIBBPF_OPTS(bpf_tc_opts, tc_attach_dec);
> +	LIBBPF_OPTS(bpf_test_run_opts, opts,
> +		    .repeat = 1,
> +	);
> +	struct nstoken *nstoken = NULL;
> +	struct crypto_sanity *skel;
> +	char afalg_plain[16] = {0};
> +	char afalg_dst[16] = {0};
> +	struct sockaddr_in6 addr;
> +	int sockfd, err, pfd;
> +	socklen_t addrlen;
> +
> +	skel = crypto_sanity__open();
> +	if (!ASSERT_OK_PTR(skel, "skel open"))
> +		return;
> +
> +	bpf_program__set_autoload(skel->progs.crypto_accuire, true);
> +
> +	err = crypto_sanity__load(skel);
> +	if (!ASSERT_ERR(err, "crypto_accuire unexpected load success"))
> +		goto fail;
> +
> +	crypto_sanity__destroy(skel);
> +
> +	skel = crypto_sanity__open();
> +	if (!ASSERT_OK_PTR(skel, "skel open"))
> +		return;
> +
> +	bpf_program__set_autoload(skel->progs.crypto_accuire, false);

Is it needed?

> +
> +	SYS(fail, "ip netns add %s", NS_TEST);
> +	SYS(fail, "ip -net %s -6 addr add %s/128 dev lo nodad", NS_TEST, IPV6_IFACE_ADDR);
> +	SYS(fail, "ip -net %s link set dev lo up", NS_TEST);
> +
> +	err = crypto_sanity__load(skel);
> +	if (!ASSERT_OK(err, "crypto_sanity__load"))
> +		goto fail;
> +
> +	nstoken = open_netns(NS_TEST);
> +	if (!ASSERT_OK_PTR(nstoken, "open_netns"))
> +		goto fail;
> +
> +	err = init_afalg();
> +	if (!ASSERT_OK(err, "AF_ALG init fail"))
> +		goto fail;
> +
> +	qdisc_hook.ifindex = if_nametoindex("lo");
> +	if (!ASSERT_GT(qdisc_hook.ifindex, 0, "if_nametoindex lo"))
> +		goto fail;
> +
> +	err = crypto_sanity__attach(skel);
> +	if (!ASSERT_OK(err, "crypto_sanity__attach"))
> +		goto fail;
> +
> +	pfd = bpf_program__fd(skel->progs.crypto_release);
> +	if (!ASSERT_GT(pfd, 0, "crypto_release fd"))
> +		goto fail;
> +
> +	err = bpf_prog_test_run_opts(pfd, &opts);
> +	if (!ASSERT_OK(err, "crypto_release") ||
> +	    !ASSERT_OK(opts.retval, "crypto_release retval"))
> +		goto fail;
> +
> +	pfd = bpf_program__fd(skel->progs.skb_crypto_setup);
> +	if (!ASSERT_GT(pfd, 0, "skb_crypto_setup fd"))
> +		goto fail;
> +
> +	err = bpf_prog_test_run_opts(pfd, &opts);
> +	if (!ASSERT_OK(err, "skb_crypto_setup") ||
> +	    !ASSERT_OK(opts.retval, "skb_crypto_setup retval"))
> +		goto fail;
> +
> +	if (!ASSERT_OK(skel->bss->status, "skb_crypto_setup status"))
> +		goto fail;
> +
> +	err = bpf_tc_hook_create(&qdisc_hook);
> +	if (!ASSERT_OK(err, "create qdisc hook"))
> +		goto fail;
> +
> +	addrlen = sizeof(addr);
> +	err = make_sockaddr(AF_INET6, IPV6_IFACE_ADDR, UDP_TEST_PORT,
> +			    (void *)&addr, &addrlen);
> +	if (!ASSERT_OK(err, "make_sockaddr"))
> +		goto fail;
> +
> +	tc_attach_enc.prog_fd = bpf_program__fd(skel->progs.encrypt_sanity);
> +	err = bpf_tc_attach(&qdisc_hook, &tc_attach_enc);
> +	if (!ASSERT_OK(err, "attach encrypt filter"))
> +		goto fail;
> +
> +	sockfd = socket(AF_INET6, SOCK_DGRAM, 0);
> +	if (!ASSERT_NEQ(sockfd, -1, "encrypt socket"))
> +		goto fail;
> +	err = sendto(sockfd, plain_text, 16, 0, (void *)&addr, addrlen);
> +	close(sockfd);
> +	if (!ASSERT_EQ(err, 16, "encrypt send"))
> +		goto fail;
> +
> +	do_crypt_afalg(plain_text, afalg_dst, 16, true);
> +
> +	bpf_tc_detach(&qdisc_hook, &tc_attach_enc);
> +	if (!ASSERT_OK(skel->bss->status, "encrypt status"))
> +		goto fail;
> +	if (!ASSERT_STRNEQ(skel->bss->dst, afalg_dst, sizeof(afalg_dst), "encrypt AF_ALG"))

nit. Please replace all numeric value "16" usages in this patch with sizeof() or 
a macro.

> +		goto fail;
> +
> +	tc_attach_dec.prog_fd = bpf_program__fd(skel->progs.decrypt_sanity);
> +	err = bpf_tc_attach(&qdisc_hook, &tc_attach_dec);
> +	if (!ASSERT_OK(err, "attach decrypt filter"))
> +		goto fail;
> +
> +	sockfd = socket(AF_INET6, SOCK_DGRAM, 0);
> +	if (!ASSERT_NEQ(sockfd, -1, "decrypt socket"))
> +		goto fail;
> +	err = sendto(sockfd, afalg_dst, 16, 0, (void *)&addr, addrlen);
> +	close(sockfd);
> +	if (!ASSERT_EQ(err, 16, "decrypt send"))
> +		goto fail;
> +
> +	do_crypt_afalg(afalg_dst, afalg_plain, 16, false);
> +
> +	bpf_tc_detach(&qdisc_hook, &tc_attach_dec);
> +	if (!ASSERT_OK(skel->bss->status, "decrypt status"))
> +		goto fail;
> +	if (!ASSERT_STRNEQ(skel->bss->dst, afalg_plain, sizeof(afalg_plain), "decrypt AF_ALG"))
> +		goto fail;
> +
> +fail:
> +	if (nstoken) {
> +		bpf_tc_hook_destroy(&qdisc_hook);
> +		close_netns(nstoken);
> +	}
> +	deinit_afalg();
> +	SYS_NOFAIL("ip netns del " NS_TEST " &> /dev/null");
> +	crypto_sanity__destroy(skel);
> +}

[ ... ]

> diff --git a/tools/testing/selftests/bpf/progs/crypto_sanity.c b/tools/testing/selftests/bpf/progs/crypto_sanity.c
> new file mode 100644
> index 000000000000..f566ff189b7e
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/crypto_sanity.c
> @@ -0,0 +1,192 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2023 Meta Platforms, Inc. and affiliates. */
> +
> +#include "vmlinux.h"
> +#include "bpf_tracing_net.h"
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_endian.h>
> +#include <bpf/bpf_tracing.h>
> +#include "bpf_misc.h"
> +#include "bpf_kfuncs.h"
> +#include "crypto_common.h"
> +
> +#define UDP_TEST_PORT 7777
> +unsigned char crypto_key[16] = "testtest12345678";

nit. Initialize the crypto_key from the prog_tests/crypto_sanity.c through 
skel->bss->crypto_key.

> +char dst[32] = {};

Please add comment on why 32 is needed instead of 16.

> +int status;
> +
> +static int skb_dynptr_validate(struct __sk_buff *skb, struct bpf_dynptr *psrc)
> +{
> +	struct ipv6hdr ip6h;
> +	struct udphdr udph;
> +	u32 offset;
> +
> +	if (skb->protocol != __bpf_constant_htons(ETH_P_IPV6))
> +		return -1;
> +
> +	if (bpf_skb_load_bytes(skb, ETH_HLEN, &ip6h, sizeof(ip6h)))
> +		return -1;
> +
> +	if (ip6h.nexthdr != IPPROTO_UDP)
> +		return -1;
> +
> +	if (bpf_skb_load_bytes(skb, ETH_HLEN + sizeof(ip6h), &udph, sizeof(udph)))
> +		return -1;
> +
> +	if (udph.dest != __bpf_constant_htons(UDP_TEST_PORT))
> +		return -1;
> +
> +	offset = ETH_HLEN + sizeof(ip6h) + sizeof(udph);
> +	if (skb->len < offset + 16)
> +		return -1;
> +
> +	bpf_dynptr_from_skb(skb, 0, psrc);
> +	bpf_dynptr_adjust(psrc, offset, offset + 16);

The bpf_crypto_(de|en)crypt kfunc requires the 16 bytes to be in the linear area 
of psrc, so it is better to do a bpf_skb_pull_data() if it is not in the linear 
area. People will directly borrow the code from here.

> +
> +	return 0;
> +}
> +
> +SEC("fentry.s/bpf_fentry_test1")
> +int BPF_PROG(skb_crypto_setup)
> +{
> +	struct bpf_crypto_ctx *cctx;
> +	struct bpf_dynptr key = {};
> +	int err = 0;
> +
> +	status = 0;
> +
> +	bpf_dynptr_from_mem(crypto_key, sizeof(crypto_key), 0, &key);
> +	cctx = bpf_crypto_ctx_create("skcipher", "ecb(aes)", &key, 0, &err);
> +
> +	if (!cctx) {
> +		status = err;
> +		return 0;
> +	}
> +
> +	err = crypto_ctx_insert(cctx);
> +	if (err && err != -EEXIST)
> +		status = err;
> +
> +	return 0;
> +}
> +
> +SEC("fentry.s/bpf_fentry_test1")
> +int BPF_PROG(crypto_release)
> +{
> +	struct bpf_crypto_ctx *cctx;
> +	struct bpf_dynptr key = {};
> +	int err = 0;
> +
> +	status = 0;
> +
> +	bpf_dynptr_from_mem(crypto_key, sizeof(crypto_key), 0, &key);
> +	cctx = bpf_crypto_ctx_create("skcipher", "ecb(aes)", &key, 0, &err);
> +
> +	if (!cctx) {
> +		status = err;
> +		return 0;
> +	}
> +
> +	bpf_crypto_ctx_release(cctx);
> +
> +	return 0;
> +}
> +
> +SEC("?fentry.s/bpf_fentry_test1")
> +__failure __msg("Unreleased reference")
> +int BPF_PROG(crypto_accuire)

Does it mean to be s/accuire/acquire/ ?

> +{
> +	struct bpf_crypto_ctx *cctx;
> +	struct bpf_dynptr key = {};
> +	int err = 0;
> +
> +	status = 0;
> +
> +	bpf_dynptr_from_mem(crypto_key, sizeof(crypto_key), 0, &key);
> +	cctx = bpf_crypto_ctx_create("skcipher", "ecb(aes)", &key, 0, &err);
> +
> +	if (!cctx) {
> +		status = err;
> +		return 0;
> +	}
> +
> +	cctx = bpf_crypto_ctx_acquire(cctx);
> +	if (!cctx)
> +		return -EINVAL;
> +
> +	bpf_crypto_ctx_release(cctx);
> +
> +	return 0;
> +}
> +
> +SEC("tc")
> +int decrypt_sanity(struct __sk_buff *skb)
> +{
> +	struct __crypto_ctx_value *v;
> +	struct bpf_crypto_ctx *ctx;
> +	struct bpf_dynptr psrc, pdst, iv;
> +	int err;
> +
> +	err = skb_dynptr_validate(skb, &psrc);
> +	if (err < 0) {
> +		status = err;
> +		return TC_ACT_SHOT;
> +	}
> +
> +	v = crypto_ctx_value_lookup();
> +	if (!v) {
> +		status = -ENOENT;
> +		return TC_ACT_SHOT;
> +	}
> +
> +	ctx = v->ctx;
> +	if (!ctx) {
> +		status = -ENOENT;
> +		return TC_ACT_SHOT;
> +	}
> +
> +	bpf_dynptr_from_mem(dst, sizeof(dst), 0, &pdst);
> +	bpf_dynptr_from_mem(dst, 0, 0, &iv);

This is quite non-intutive to say iv is not needed. A better user experience is 
to allow passing NULL to the kfunc. This probably could be improved in the 
future without breaking the kfunc api. Please add a comment here.

> +
> +	status = bpf_crypto_decrypt(ctx, &psrc, &pdst, &iv);
> +
> +	return TC_ACT_SHOT;
> +}
> +
> +SEC("tc")
> +int encrypt_sanity(struct __sk_buff *skb)
> +{
> +	struct __crypto_ctx_value *v;
> +	struct bpf_crypto_ctx *ctx;
> +	struct bpf_dynptr psrc, pdst, iv;
> +	int err;
> +
> +	status = 0;
> +
> +	err = skb_dynptr_validate(skb, &psrc);
> +	if (err < 0) {
> +		status = err;
> +		return TC_ACT_SHOT;
> +	}
> +
> +	v = crypto_ctx_value_lookup();
> +	if (!v) {
> +		status = -ENOENT;
> +		return TC_ACT_SHOT;
> +	}
> +
> +	ctx = v->ctx;
> +	if (!ctx) {
> +		status = -ENOENT;
> +		return TC_ACT_SHOT;
> +	}
> +
> +	bpf_dynptr_from_mem(dst, sizeof(dst), 0, &pdst);
> +	bpf_dynptr_from_mem(dst, 0, 0, &iv);
> +
> +	status = bpf_crypto_encrypt(ctx, &psrc, &pdst, &iv);
> +
> +	return TC_ACT_SHOT;
> +}
> +
> +char __license[] SEC("license") = "GPL";


