Return-Path: <bpf+bounces-9179-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BBCC7915DC
	for <lists+bpf@lfdr.de>; Mon,  4 Sep 2023 12:49:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 917C31C202DC
	for <lists+bpf@lfdr.de>; Mon,  4 Sep 2023 10:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 537592100;
	Mon,  4 Sep 2023 10:49:14 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F131FAC
	for <bpf@vger.kernel.org>; Mon,  4 Sep 2023 10:49:13 +0000 (UTC)
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 655ED19B;
	Mon,  4 Sep 2023 03:49:12 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1qd78a-0000sx-EP; Mon, 04 Sep 2023 12:48:56 +0200
Date: Mon, 4 Sep 2023 12:48:56 +0200
From: Florian Westphal <fw@strlen.de>
To: David Wang <00107082@163.com>
Cc: fw@strlen.de, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH] samples/bpf: Add sample usage for BPF_PROG_TYPE_NETFILTER
Message-ID: <20230904104856.GE11802@breakpoint.cc>
References: <20230904102128.11476-1-00107082@163.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230904102128.11476-1-00107082@163.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

David Wang <00107082@163.com> wrote:
> This sample code implements a simple ipv4
> blacklist via the new bpf type BPF_PROG_TYPE_NETFILTER,
> which was introduced in 6.4.
> 
> The bpf program drops package if destination ip address
> hits a match in the map of type BPF_MAP_TYPE_LPM_TRIE,
> 
> The userspace code would load the bpf program,
> attach it to netfilter's FORWARD/OUTPUT hook,
> and then write ip patterns into the bpf map.

Thanks, I think its good to have this.

> diff --git a/samples/bpf/netfilter_ip4_blacklist.bpf.c b/samples/bpf/netfilter_ip4_blacklist.bpf.c
> new file mode 100644
> index 000000000000..d315d64fda7f
> --- /dev/null
> +++ b/samples/bpf/netfilter_ip4_blacklist.bpf.c
> @@ -0,0 +1,62 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include "vmlinux.h"
> +#include <bpf/bpf_helpers.h>
> +
> +
> +#define NF_DROP 0
> +#define NF_ACCEPT 1

If you are interested, you could send a patch for nf-next that
makes the uapi headers expose this as enum, AFAIU that would make
the verdict nanes available via vmlinux.h.

> +	/* search p->daddr in trie */
> +	key.prefixlen = 32;
> +	key.data = p->daddr;
> +	pvalue = bpf_map_lookup_elem(&ipv4_lpm_map, &key);
> +	if (pvalue) {
> +		/* cat /sys/kernel/debug/tracing/trace_pipe */
> +		bpf_printk("rule matched with %d...\n", *pvalue);

If you are interested you could send a patch that adds a kfunc to
nf_bpf_link that exposes nf_log_packet() to bpf.

nf_log_packet has a terrible api, I suggest to have the kfunc take
'struct nf_hook_state *' instead of 6+ members of that struct as
argument.

Thanks for the example.

