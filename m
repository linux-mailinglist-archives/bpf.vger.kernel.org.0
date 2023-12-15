Return-Path: <bpf+bounces-17990-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35FE0814533
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 11:11:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6F1128486F
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 10:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0E9618E2B;
	Fri, 15 Dec 2023 10:11:06 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DCDE19445
	for <bpf@vger.kernel.org>; Fri, 15 Dec 2023 10:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Ss4jt3DSDz4f3khY
	for <bpf@vger.kernel.org>; Fri, 15 Dec 2023 18:10:58 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 0CE9B1A0199
	for <bpf@vger.kernel.org>; Fri, 15 Dec 2023 18:11:01 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP4 (Coremail) with SMTP id gCh0CgC3EUIvJnxlj9E_Dw--.36983S2;
	Fri, 15 Dec 2023 18:10:58 +0800 (CST)
Subject: Re: [PATCH bpf] bpf: Add missing BPF_LINK_TYPE invocations
To: Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>
Cc: Pengfei Xu <pengfei.xu@intel.com>, bpf@vger.kernel.org,
 Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
 Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>,
 KP Singh <kpsingh@chromium.org>, Stanislav Fomichev <sdf@google.com>,
 Hao Luo <haoluo@google.com>
References: <20231215091826.2467281-1-jolsa@kernel.org>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <841653bd-a32f-71db-b26a-e44fa6370358@huaweicloud.com>
Date: Fri, 15 Dec 2023 18:10:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20231215091826.2467281-1-jolsa@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID:gCh0CgC3EUIvJnxlj9E_Dw--.36983S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kw1rArW5Gr43Wr1kuw4Uurg_yoW8WFW3p3
	W5CF4DGw1Uuw4UX3sxtFWIyry0ga1DWry2gr90gr1j9ryavr429F10gryUZasIv393KFW7
	J3Z0kr97G3sxA37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvab4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q
	6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Zr0_Wr1UMIIF0xvEx4A2jsIE
	14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyT
	uYvjxUrR6zUUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/



On 12/15/2023 5:18 PM, Jiri Olsa wrote:
> Pengfei Xu reported [1] Syzkaller/KASAN issue found in bpf_link_show_fdinfo.
>
> The reason is missing BPF_LINK_TYPE invocation for uprobe multi
> link and for several other links, adding that.
>
> [1] https://lore.kernel.org/bpf/ZXptoKRSLspnk2ie@xpf.sh.intel.com/
>
> Fixes: 89ae89f53d20 ("bpf: Add multi uprobe link")
> Fixes: e420bed02507 ("bpf: Add fd-based tcx multi-prog infra with link support")
> Fixes: 84601d6ee68a ("bpf: add bpf_link support for BPF_NETFILTER programs")
> Fixes: 35dfaad7188c ("netkit, bpf: Add bpf programmable net device")
> Reported-by: Pengfei Xu <pengfei.xu@intel.com>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---

Some BPF_LINK_TYPE() definitions below can be guarded by CONFIG_xx
macro, but I think it doesn't matter here, because these definitions are
only used in bpf_link_type_strs(), so

Acked-by: Hou Tao <houtao1@huawei.com>

>  include/linux/bpf_types.h | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/include/linux/bpf_types.h b/include/linux/bpf_types.h
> index fc0d6f32c687..38cbdaec6bdf 100644
> --- a/include/linux/bpf_types.h
> +++ b/include/linux/bpf_types.h
> @@ -148,3 +148,7 @@ BPF_LINK_TYPE(BPF_LINK_TYPE_PERF_EVENT, perf)
>  #endif
>  BPF_LINK_TYPE(BPF_LINK_TYPE_KPROBE_MULTI, kprobe_multi)
>  BPF_LINK_TYPE(BPF_LINK_TYPE_STRUCT_OPS, struct_ops)
> +BPF_LINK_TYPE(BPF_LINK_TYPE_NETFILTER, netfilter)
> +BPF_LINK_TYPE(BPF_LINK_TYPE_TCX, tcx)
> +BPF_LINK_TYPE(BPF_LINK_TYPE_UPROBE_MULTI, uprobe_multi)
> +BPF_LINK_TYPE(BPF_LINK_TYPE_NETKIT, netkit)


