Return-Path: <bpf+bounces-33377-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90AAD91C892
	for <lists+bpf@lfdr.de>; Fri, 28 Jun 2024 23:51:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B61C31C22510
	for <lists+bpf@lfdr.de>; Fri, 28 Jun 2024 21:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E19278060A;
	Fri, 28 Jun 2024 21:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="CZYcD9np"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF04F7FBC1;
	Fri, 28 Jun 2024 21:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719611477; cv=none; b=LMRvEMZbwJXqv82gGWeD1JnfydFf526FxR+Q0Aj8GRAJkkONhqJqMu6UaSxPSWUrAUEd3O6I233aiGxDDTAEXvOZhM92wJTWKMnx/n4/wUDOjdUvp5B7r9owUyvXqmq9Gfwjr9OZ49Asi6pqwxXaIb8drNaZKtD9HeIwHDz1p+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719611477; c=relaxed/simple;
	bh=2rjEDgKi7xQFtf4FbbysIWcRSYbDXu+SjlOYC23cArI=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=qIpNWXyLA0jSoE5cjg130Xs8MAUAXwMjLBsd2M+RVxpMuiC4VZBi/Z/eR5e91w0/MHQPOGKDh48FB/tliJrpzhATFS3JCL2Bw0cq+Se1mhaQHTlxaPSok7EQM58g9Co7smDUkzHxwROvi0sgTn9oMmqGAfY3a+gRkAdczg4QUF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=CZYcD9np; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=hi+8ifoED1WW8434q/I6jfbO+YdnwwfKA3rmH9p49XE=; b=CZYcD9np4Xr1+BLDiSVgq++gS6
	swbFbaegcsaqA+76EpPIfFlhKoffhT9fv+LXdxPUoyQUhj49kM+12LcWMFApazsJ04IBMJE3YWBEE
	rpvdpv1PfMM69OWVm27SAPwuOnHWjpJ/mDGBG6ocoH88/TgFeNmVHKl7IhRmWWP2HhVncAtWYQpnO
	dD1G3n/2YHzQ7d2K7MFhE25ErkhsuASL7XjX5FZi4jkM0XP8eEyX3v5Y+vp8SKgedd/6STxWHWlfG
	PXeAJgCXMx7vcdPbVmeMuzjqlycq+tr3GeYF+sSeYAUyqCzvL/vObmaiYb7R7f+rdGFMHV5AzQEBF
	lF/fqgQg==;
Received: from sslproxy04.your-server.de ([78.46.152.42])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1sNJ9Y-000KK1-FP; Fri, 28 Jun 2024 23:29:08 +0200
Received: from [178.197.249.38] (helo=linux.home)
	by sslproxy04.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1sNJ9X-0003Mu-0C;
	Fri, 28 Jun 2024 23:29:07 +0200
Subject: Re: [PATCH v5 bpf-next 3/3] selftests/bpf: Add selftest for
 bpf_xdp_flow_lookup kfunc
To: Lorenzo Bianconi <lorenzo@kernel.org>, bpf@vger.kernel.org
Cc: pablo@netfilter.org, kadlec@netfilter.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netfilter-devel@vger.kernel.org, netdev@vger.kernel.org, ast@kernel.org,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com,
 lorenzo.bianconi@redhat.com, toke@redhat.com, fw@strlen.de, hawk@kernel.org,
 horms@kernel.org, donhunte@redhat.com, memxor@gmail.com
References: <cover.1718379122.git.lorenzo@kernel.org>
 <6472c7a775f6a329d16352092071fda8676c2809.1718379122.git.lorenzo@kernel.org>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <89bd0cd7-ed01-a343-d873-dc0c6d2810f2@iogearbox.net>
Date: Fri, 28 Jun 2024 23:29:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <6472c7a775f6a329d16352092071fda8676c2809.1718379122.git.lorenzo@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27320/Fri Jun 28 10:37:18 2024)

On 6/14/24 5:40 PM, Lorenzo Bianconi wrote:
[...]
> +void test_xdp_flowtable(void)
> +{
> +	struct xdp_flowtable *skel = NULL;
> +	struct nstoken *tok = NULL;
> +	int iifindex, stats_fd;
> +	__u32 value, key = 0;
> +	struct bpf_link *link;
> +
> +	if (SYS_NOFAIL("nft -v")) {
> +		fprintf(stdout, "Missing required nft tool\n");
> +		test__skip();
> +		return;

Bit unfortunate that upstream CI skips the test case at the moment:

   #542/2   xdp_devmap_attach/DEVMAP with frags programs in entries:OK
   #542/3   xdp_devmap_attach/Verifier check of DEVMAP programs:OK
   #542     xdp_devmap_attach:OK
   #543     xdp_do_redirect:OK
   #544     xdp_flowtable:SKIP
[...]

> +out:
> +	xdp_flowtable__destroy(skel);
> +	if (tok)
> +		close_netns(tok);
> +	SYS_NOFAIL("ip netns del " TX_NETNS_NAME);
> +	SYS_NOFAIL("ip netns del " RX_NETNS_NAME);
> +}
> diff --git a/tools/testing/selftests/bpf/progs/xdp_flowtable.c b/tools/testing/selftests/bpf/progs/xdp_flowtable.c
> new file mode 100644
> index 0000000000000..8297b30b0764b
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/xdp_flowtable.c
> @@ -0,0 +1,146 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#define BPF_NO_KFUNC_PROTOTYPES
> +#include <vmlinux.h>
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_endian.h>
> +
> +#define MAX_ERRNO	4095

nit: unused?

> +#define ETH_P_IP	0x0800
> +#define ETH_P_IPV6	0x86dd
> +#define IP_MF		0x2000	/* "More Fragments" */
> +#define IP_OFFSET	0x1fff	/* "Fragment Offset" */
> +#define AF_INET		2
> +#define AF_INET6	10
> +
> +struct bpf_flowtable_opts___local {
> +	s32 error;
> +};
> +
> +struct flow_offload_tuple_rhash *
> +bpf_xdp_flow_lookup(struct xdp_md *, struct bpf_fib_lookup *,
> +		    struct bpf_flowtable_opts___local *, u32) __ksym;
> +
> +struct {
> +	__uint(type, BPF_MAP_TYPE_ARRAY);
> +	__type(key, __u32);
> +	__type(value, __u32);
> +	__uint(max_entries, 1);
> +} stats SEC(".maps");
> +
[...]

