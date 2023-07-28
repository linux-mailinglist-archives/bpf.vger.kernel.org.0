Return-Path: <bpf+bounces-6274-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88E4976789D
	for <lists+bpf@lfdr.de>; Sat, 29 Jul 2023 00:48:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F980282788
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 22:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 956EE1FB43;
	Fri, 28 Jul 2023 22:47:55 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659811BB52
	for <bpf@vger.kernel.org>; Fri, 28 Jul 2023 22:47:55 +0000 (UTC)
Received: from out-86.mta0.migadu.com (out-86.mta0.migadu.com [91.218.175.86])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D7C51BD6
	for <bpf@vger.kernel.org>; Fri, 28 Jul 2023 15:47:51 -0700 (PDT)
Message-ID: <791b919c-de82-6dc8-905a-520543f975cd@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1690584469;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rVZMCx5Zounfu2IwD4zBIt/Lk5NqzK7Uhgpsb3XYxGU=;
	b=miAD6XpnNrSPSzFemTiSEGLsOBUhb/xoNmXZEtVHXAsYbl7GcWaePtQyfPdWGvuVzUoPys
	c3WVoRo/ghKGhO2pvBCu7WXk3WdeePVw0RywsLcBzajLcA6lRmauMJEwkzVv5Sgtb/xJoj
	EnMV7xkteVq4ENQMSjMisc/CC7aMDXc=
Date: Fri, 28 Jul 2023 15:47:40 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v4 bpf 2/2] bpf: selftests: add lwt redirect regression
 test cases
Content-Language: en-US
To: Yan Zhai <yan@cloudflare.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Mykola Lysenko <mykolal@fb.com>,
 Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 kernel-team@cloudflare.com, Jordan Griege <jgriege@cloudflare.com>,
 Markus Elfring <Markus.Elfring@web.de>, Jakub Sitnicki <jakub@cloudflare.com>
References: <cover.1690332693.git.yan@cloudflare.com>
 <9c4896b109a39c3fa088844addaa1737a84bbbb5.1690332693.git.yan@cloudflare.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <9c4896b109a39c3fa088844addaa1737a84bbbb5.1690332693.git.yan@cloudflare.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 7/25/23 6:09 PM, Yan Zhai wrote:
> diff --git a/tools/testing/selftests/bpf/progs/test_lwt_redirect.c b/tools/testing/selftests/bpf/progs/test_lwt_redirect.c
> new file mode 100644
> index 000000000000..3674e101f68f
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/test_lwt_redirect.c
> @@ -0,0 +1,66 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <linux/bpf.h>
> +#include <bpf/bpf_helpers.h>
> +#include "bpf_tracing_net.h"
> +
> +/* We don't care about whether the packet can be received by network stack.
> + * Just care if the packet is sent to the correct device at correct direction
> + * and not panic the kernel.
> + */
> +static __always_inline int prepend_dummy_mac(struct __sk_buff *skb)
> +{

__always_inline is no longer a must for a long time.

> +	char mac[] = {0x1, 0x2, 0x3, 0x4, 0x5, 0x6, 0xf,
> +		      0xe, 0xd, 0xc, 0xb, 0xa, 0x08, 0x00};
> +
> +	if (bpf_skb_change_head(skb, ETH_HLEN, 0)) {
> +		bpf_printk("%s: fail to change head", __func__);

Avoid using bpf_printk(). The bpf CI runs other tests also.

> +		return -1;
> +	}
> +
> +	if (bpf_skb_store_bytes(skb, 0, mac, sizeof(mac), 0)) {
> +		bpf_printk("%s: fail to update mac", __func__);
> +		return -1;
> +	}
> +
> +	return 0;
> +}
> +
> +SEC("redir_ingress")

Use SEC("lwt_xmit"). Then the libbpf will figure out the prog type.

> +int test_lwt_redirect_in(struct __sk_buff *skb)
> +{
> +	if (prepend_dummy_mac(skb))
> +		return BPF_DROP;
> +
> +	bpf_printk("Redirect skb to link %d ingress", skb->mark);
> +	return bpf_redirect(skb->mark, BPF_F_INGRESS);
> +}
> +
> +SEC("redir_egress")
> +int test_lwt_redirect_out(struct __sk_buff *skb)
> +{
> +	if (prepend_dummy_mac(skb))
> +		return BPF_DROP;
> +
> +	bpf_printk("Redirect skb to link %d egress", skb->mark);
> +	return bpf_redirect(skb->mark, 0);
> +}
> +
> +SEC("redir_egress_nomac")
> +int test_lwt_redirect_out_nomac(struct __sk_buff *skb)
> +{
> +	int ret = bpf_redirect(skb->mark, 0);
> +
> +	bpf_printk("Redirect skb to link %d egress nomac: %d", skb->mark, ret);
> +	return ret;
> +}
> +
> +SEC("redir_ingress_nomac")
> +int test_lwt_redirect_in_nomac(struct __sk_buff *skb)
> +{
> +	int ret = bpf_redirect(skb->mark, BPF_F_INGRESS);
> +
> +	bpf_printk("Redirect skb to link %d ingress nomac: %d", skb->mark, ret);
> +	return ret;
> +}
> +
> +char _license[] SEC("license") = "GPL";
> diff --git a/tools/testing/selftests/bpf/test_lwt_redirect.sh b/tools/testing/selftests/bpf/test_lwt_redirect.sh
> new file mode 100755
> index 000000000000..1b7b78b48174
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/test_lwt_redirect.sh

This has to be written in the test_progs infrastructure in C. Only test_progs is 
run by the BPF CI. Take a look at other tests in prog_tests/. For example, 
tc_redirect.c and xdp_metadata.c which are having setup in netns/link/...etc. It 
currently has helpers to add tc qdisc and filter but not adding route yet which 
could be a useful addition.

--
pw-bot: cr


