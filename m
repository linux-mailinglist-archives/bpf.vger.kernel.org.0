Return-Path: <bpf+bounces-21252-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 131D284A75C
	for <lists+bpf@lfdr.de>; Mon,  5 Feb 2024 22:29:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 763041F29D26
	for <lists+bpf@lfdr.de>; Mon,  5 Feb 2024 21:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E0257E56E;
	Mon,  5 Feb 2024 19:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="VmBdh4b+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XidVdSBc"
X-Original-To: bpf@vger.kernel.org
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2789C7E76F
	for <bpf@vger.kernel.org>; Mon,  5 Feb 2024 19:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707162337; cv=none; b=fdZpRHp/NNHo6WotwZzRYHX6PiHz86NgLVMQjjKomwtzTLLxuLYONGDQukHArIDE9QL6uErTJ2lVFADR3W5tKJEndWtjYGr7q88rn8hgSJZIJK8bsLKWNZsP+WR8h1sjERYyFDw2gqakyvUzeRMbWhypgTt+m4Z1PfZF4F0sov4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707162337; c=relaxed/simple;
	bh=AAu7Do7d+ERMBUjJyFj6W32QWstyxqOPekwvVeItK8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zu084gzM8sTOx2LiPnRZfVHvmYimMaovQanlgj92NscQXs0vfr0JzqeuDO21AWHUGhhCKUACB+UuRlq3EGRJ3l04P4vfHFrnC1VIaIcSd9qiu0iTDUryljCth7MRErzWcIFylwK/fdvxWin9/GQtI9/xkpN49cEU5f0CHquEZ6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=VmBdh4b+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XidVdSBc; arc=none smtp.client-ip=66.111.4.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 019EC5C0189;
	Mon,  5 Feb 2024 14:45:34 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 05 Feb 2024 14:45:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1707162333; x=1707248733; bh=J9YU+r51QS
	1ixHfPMGuG1ibk1S2IkslLaxVl/8rupXM=; b=VmBdh4b+FsM2m9bamFb/58C2xV
	MeBbkZJLcBCP38AeC250UIlnrZ2lKPowNi1oBj38wZr5jVD86tsw1iKAnwCboWyI
	dTFQIok8XXgUBeVuqXqnA40xvN3lmcNqu2tWli5Pkh0ZR92mI8FnZjXzde/rD9Gc
	h9+fexSIRepsYenHpIdfzpvulCaCPqaAYYpKWnFc7kBjfVBxFBmFr6fflUicJFye
	Yoa/gdLODFVOqdL2f2yuINKQnxhvVrLjEHW8gTx5pBu6ifn3p64sj91zTfY2GMye
	e6BkfNEArWaT4hZzZzUMTmJ7jDObDjNmjIByrYQ88nNlfcwu9NSgvyjVY+7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1707162333; x=1707248733; bh=J9YU+r51QS1ixHfPMGuG1ibk1S2I
	kslLaxVl/8rupXM=; b=XidVdSBci6FbMzs+oqfGRHe4I+PdXpk3cF4M6AOU/Huz
	XbadDSxj9O+0JFkNmGTxba39iYRL1nEowiUiaIsxCrk6YwBYxbRm53YYSb3zeGDH
	uRAMxxQq/zqFH+HgTi7CAtczHY8qKUPTTqFO8idHvQJmBBRKE2JLUkhzDQ09nEv9
	D7cyCUepJoWvcvl8KQHs5jU6fVrKIWdZ48In+UCtcMFriqRx1ygVnpNSk0MHFTyp
	d+UOpC5A5zEFSoHA/y36lrHBBJIryvx5hWxrN/YOMsi17Fs4yubcRps3i5qT0tra
	JQgE0ApWp7pEh3e3y8WU3R6Mgnawcl9iWzd5X24pkQ==
X-ME-Sender: <xms:3TrBZQM8xBJCPrzh7XaIQkRp3GN-0Qs_U-Bt1WeXNXEPVuNQOcrnfg>
    <xme:3TrBZW9bMoA-2Yze2EmQWiKT7JRHSqOqeSyhVV37flS6cD_Kih8YcgTrMOXJJ6Bl_
    yB0Uy61gbl2eEX32A>
X-ME-Received: <xmr:3TrBZXQAS1euYml7SQvfqwJLvLrh4MaelVYRhGXFnAmA2eSeFkgz00RzfVyllHsPrDGn-bsla8owMcgLZu-vUdyYlL156PbZ7Q97qik>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedvuddgfeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdlfeehmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdfstddt
    tddvnecuhfhrohhmpeffrghnihgvlhcuighuuceougiguhesugiguhhuuhdrgiihiieqne
    cuggftrfgrthhtvghrnhepvdefkeetuddufeeigedtheefffekuedukeehudffudfffffg
    geeitdetgfdvhfdvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:3TrBZYvVKtUUvWUStaTEmfqKumHuegqgH1z2nB0O59taptzGbxhVNQ>
    <xmx:3TrBZYeSf-G2m4DI9_W6x8q0D-GMAqKs2aP4kj9hfFLj8ZoA2-0MGQ>
    <xmx:3TrBZc1JUUjzK8ja8JWOWMPnTj3rVSdKM3eQkzHiDENbt47odCs2Aw>
    <xmx:3TrBZbubigrGIAekdNG68eCw2Tbr7cLS6gjUtvKpVUc_G8q7sfTfPA>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Feb 2024 14:45:32 -0500 (EST)
Date: Mon, 5 Feb 2024 12:45:30 -0700
From: Daniel Xu <dxu@dxuuu.xyz>
To: Viktor Malik <vmalik@redhat.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Alexey Dobriyan <adobriyan@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Manu Bretelle <chantr4@gmail.com>
Subject: Re: [PATCH bpf-next v3 1/2] tools/resolve_btfids: Refactor set
 sorting with types from btf_ids.h
Message-ID: <uk5wsboc2rfloizsah5d4vb3tid55diiejkutfgsvr6qn7u5vn@ka3u4e7usa3z>
References: <cover.1707157553.git.vmalik@redhat.com>
 <8e84b14c36d2a855071edfb9121787e7f0f0ddca.1707157553.git.vmalik@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8e84b14c36d2a855071edfb9121787e7f0f0ddca.1707157553.git.vmalik@redhat.com>

On Mon, Feb 05, 2024 at 07:39:22PM +0100, Viktor Malik wrote:
> Instead of using magic offsets to access BTF ID set data, leverage types
> from btf_ids.h (btf_id_set and btf_id_set8) which define the actual
> layout of the data. Thanks to this change, set sorting should also
> continue working if the layout changes.
> 
> This requires to sync the definition of 'struct btf_id_set8' from
> include/linux/btf_ids.h to tools/include/linux/btf_ids.h. We don't sync
> the rest of the file at the moment, b/c that would require to also sync
> multiple dependent headers and we don't need any other defs from
> btf_ids.h.
> 
> Signed-off-by: Viktor Malik <vmalik@redhat.com>
> ---
>  tools/bpf/resolve_btfids/main.c | 29 +++++++++++++++++++----------
>  tools/include/linux/btf_ids.h   |  9 +++++++++
>  2 files changed, 28 insertions(+), 10 deletions(-)
> 
> diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/main.c
> index 27a23196d58e..9ffe8163081a 100644
> --- a/tools/bpf/resolve_btfids/main.c
> +++ b/tools/bpf/resolve_btfids/main.c
> @@ -70,6 +70,7 @@
>  #include <sys/stat.h>
>  #include <fcntl.h>
>  #include <errno.h>
> +#include <linux/btf_ids.h>
>  #include <linux/rbtree.h>
>  #include <linux/zalloc.h>
>  #include <linux/err.h>
> @@ -78,7 +79,7 @@
>  #include <subcmd/parse-options.h>
>  
>  #define BTF_IDS_SECTION	".BTF_ids"
> -#define BTF_ID		"__BTF_ID__"
> +#define BTF_ID_PREFIX	"__BTF_ID__"
>  
>  #define BTF_STRUCT	"struct"
>  #define BTF_UNION	"union"
> @@ -161,7 +162,7 @@ static int eprintf(int level, int var, const char *fmt, ...)
>  
>  static bool is_btf_id(const char *name)
>  {
> -	return name && !strncmp(name, BTF_ID, sizeof(BTF_ID) - 1);
> +	return name && !strncmp(name, BTF_ID_PREFIX, sizeof(BTF_ID_PREFIX) - 1);
>  }
>  
>  static struct btf_id *btf_id__find(struct rb_root *root, const char *name)
> @@ -441,7 +442,7 @@ static int symbols_collect(struct object *obj)
>  		 * __BTF_ID__TYPE__vfs_truncate__0
>  		 * prefix =  ^
>  		 */
> -		prefix = name + sizeof(BTF_ID) - 1;
> +		prefix = name + sizeof(BTF_ID_PREFIX) - 1;
>  
>  		/* struct */
>  		if (!strncmp(prefix, BTF_STRUCT, sizeof(BTF_STRUCT) - 1)) {
> @@ -654,10 +655,10 @@ static int sets_patch(struct object *obj)
>  
>  	next = rb_first(&obj->sets);
>  	while (next) {
> +		struct btf_id_set8 *set8;
> +		struct btf_id_set *set;
>  		unsigned long addr, idx;
>  		struct btf_id *id;
> -		int *base;
> -		int cnt;
>  
>  		id   = rb_entry(next, struct btf_id, rb_node);
>  		addr = id->addr[0];
> @@ -671,13 +672,21 @@ static int sets_patch(struct object *obj)
>  		}
>  
>  		idx = idx / sizeof(int);
> -		base = &ptr[idx] + (id->is_set8 ? 2 : 1);
> -		cnt = ptr[idx];
> +		if (id->is_set) {
> +			set = (struct btf_id_set *)&ptr[idx];

Nit: should be able to simplify logic a bit like this:

        int off = addr - obj->efile.idlist_addr;
        set8 = data->d_buf + off;

Don't think that `idx`, `ptr` or casts are necessary anymore.

> +			qsort(set->ids, set->cnt, sizeof(set->ids[0]), cmp_id);
> +		} else {
> +			set8 = (struct btf_id_set8 *)&ptr[idx];
> +			/*
> +			 * Make sure id is at the beginning of the pairs
> +			 * struct, otherwise the below qsort would not work.
> +			 */
> +			BUILD_BUG_ON(set8->pairs != &set8->pairs[0].id);
> +			qsort(set8->pairs, set8->cnt, sizeof(set8->pairs[0]), cmp_id);
> +		}
>  
>  		pr_debug("sorting  addr %5lu: cnt %6d [%s]\n",
> -			 (idx + 1) * sizeof(int), cnt, id->name);
> -
> -		qsort(base, cnt, id->is_set8 ? sizeof(uint64_t) : sizeof(int), cmp_id);
> +			 (idx + 1) * sizeof(int), id->is_set ? set->cnt : set8->cnt, id->name);
>  
>  		next = rb_next(next);
>  	}
> diff --git a/tools/include/linux/btf_ids.h b/tools/include/linux/btf_ids.h
> index 2f882d5cb30f..72535f00572f 100644
> --- a/tools/include/linux/btf_ids.h
> +++ b/tools/include/linux/btf_ids.h
> @@ -8,6 +8,15 @@ struct btf_id_set {
>  	u32 ids[];
>  };
>  
> +struct btf_id_set8 {
> +	u32 cnt;
> +	u32 flags;
> +	struct {
> +		u32 id;
> +		u32 flags;
> +	} pairs[];
> +};
> +
>  #ifdef CONFIG_DEBUG_INFO_BTF
>  
>  #include <linux/compiler.h> /* for __PASTE */
> -- 
> 2.43.0
> 

