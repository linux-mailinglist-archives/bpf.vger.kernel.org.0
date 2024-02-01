Return-Path: <bpf+bounces-20964-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1830B845D20
	for <lists+bpf@lfdr.de>; Thu,  1 Feb 2024 17:23:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3A652905AF
	for <lists+bpf@lfdr.de>; Thu,  1 Feb 2024 16:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E9AD5A4E4;
	Thu,  1 Feb 2024 16:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="a2KVUKsx"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8095A4DF
	for <bpf@vger.kernel.org>; Thu,  1 Feb 2024 16:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706804379; cv=none; b=nm8ldL6CRLjaG2icqZVfcXH+qRHSVPcVBwuKj2eSsPbZBldCEJxjn+5g6kzbn821IS2vRLpNKb99EEpSHPEIzYFz3Feoh0+AjKVRpQtVYtBkNjMTgxvzVH+3MkNAK4NzMDNv3R6IVwhOL1loG1Bn0EQgDef7FapICPd41IBAlq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706804379; c=relaxed/simple;
	bh=1LOA0s39t6AGK6gfVqWnmFNTpAGBKNIqzvVBXr6iZLM=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=oDnqhe66o+48/vYsX57S/Bvg/reDwta5+F9jmBDz0FW/ky0jza+u9yOKyIWrAGqUSJkGcF/wm37m5pSfjRKubCgV8lccjOTzAfvPRTUAUdnR/vhrHUv7L/i+s6O0DbnCp/xvlOa+Kub/od+0We12cPnfZm0Y/FjjJTChgChBGBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=a2KVUKsx; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=405Re/EwLs8CTU/h64UIjqQHZsPEHLfPrrDME1aBab8=; b=a2KVUKsxmBQ4wCR+kGpmhJHG+o
	4lFwEuKOIxRP0/jB4V4LMrrEeID7xe74gEkIRo8fN43dAt/EUkTZSyYBhn9PAG2SMvKXK8x7eQv81
	TYjOo26xyLn4tZx6LVCv56K1g8Os2Mxs4L8Y6gn/80gxr+0JKJxuKaaxl22ZJwS6EyBmJBEWvNfB1
	y7U6MSQLA6AuiHol2YdX26KD2RoeZrh6kLYnsVxX5ZT7/xYsZIzb5Ux0WVnYpGhB9TJ6R5E0N/Uqi
	ugKB9dKAKlps5sYSnel7Mg9k+6d7JQGZDPvOzu6JxigjLEuVWKH2fPdUcQ+cEzeNpya6Bg5HGeSRK
	hqXSI6qQ==;
Received: from sslproxy04.your-server.de ([78.46.152.42])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1rVZLt-000Hcv-U4; Thu, 01 Feb 2024 16:51:45 +0100
Received: from [85.1.206.226] (helo=linux.home)
	by sslproxy04.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1rVZLs-000KPd-PU; Thu, 01 Feb 2024 16:51:44 +0100
Subject: Re: [PATCH bpf-next v2 1/2] tools/resolve_btfids: Refactor set
 sorting with types from btf_ids.h
To: Viktor Malik <vmalik@redhat.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Alexey Dobriyan <adobriyan@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>
References: <cover.1706717857.git.vmalik@redhat.com>
 <eafd46de2ff1bfc6103ec466d4fba0861ce416a6.1706717857.git.vmalik@redhat.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <f932fb45-3cd3-c603-027a-a81f8a63c76e@iogearbox.net>
Date: Thu, 1 Feb 2024 16:51:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <eafd46de2ff1bfc6103ec466d4fba0861ce416a6.1706717857.git.vmalik@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27172/Thu Feb  1 10:40:50 2024)

On 1/31/24 5:24 PM, Viktor Malik wrote:
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
>   tools/bpf/resolve_btfids/main.c | 30 ++++++++++++++++++++++--------
>   tools/include/linux/btf_ids.h   |  9 +++++++++
>   2 files changed, 31 insertions(+), 8 deletions(-)
> 
> diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/main.c
> index 27a23196d58e..7badf1557e5c 100644
> --- a/tools/bpf/resolve_btfids/main.c
> +++ b/tools/bpf/resolve_btfids/main.c
> @@ -70,6 +70,7 @@
>   #include <sys/stat.h>
>   #include <fcntl.h>
>   #include <errno.h>
> +#include <linux/btf_ids.h>
>   #include <linux/rbtree.h>
>   #include <linux/zalloc.h>
>   #include <linux/err.h>
> @@ -78,7 +79,7 @@
>   #include <subcmd/parse-options.h>
>   
>   #define BTF_IDS_SECTION	".BTF_ids"
> -#define BTF_ID		"__BTF_ID__"
> +#define BTF_ID_PREFIX	"__BTF_ID__"
>   
>   #define BTF_STRUCT	"struct"
>   #define BTF_UNION	"union"
> @@ -161,7 +162,7 @@ static int eprintf(int level, int var, const char *fmt, ...)
>   
>   static bool is_btf_id(const char *name)
>   {
> -	return name && !strncmp(name, BTF_ID, sizeof(BTF_ID) - 1);
> +	return name && !strncmp(name, BTF_ID_PREFIX, sizeof(BTF_ID_PREFIX) - 1);
>   }
>   
>   static struct btf_id *btf_id__find(struct rb_root *root, const char *name)
> @@ -441,7 +442,7 @@ static int symbols_collect(struct object *obj)
>   		 * __BTF_ID__TYPE__vfs_truncate__0
>   		 * prefix =  ^
>   		 */
> -		prefix = name + sizeof(BTF_ID) - 1;
> +		prefix = name + sizeof(BTF_ID_PREFIX) - 1;
>   
>   		/* struct */
>   		if (!strncmp(prefix, BTF_STRUCT, sizeof(BTF_STRUCT) - 1)) {
> @@ -656,8 +657,8 @@ static int sets_patch(struct object *obj)
>   	while (next) {
>   		unsigned long addr, idx;
>   		struct btf_id *id;
> -		int *base;
> -		int cnt;
> +		void *base;
> +		int cnt, size;
>   
>   		id   = rb_entry(next, struct btf_id, rb_node);
>   		addr = id->addr[0];
> @@ -671,13 +672,26 @@ static int sets_patch(struct object *obj)
>   		}
>   
>   		idx = idx / sizeof(int);
> -		base = &ptr[idx] + (id->is_set8 ? 2 : 1);
> -		cnt = ptr[idx];
> +		if (id->is_set) {
> +			struct btf_id_set *set;
> +
> +			set = (struct btf_id_set *)&ptr[idx];
> +			base = set->ids;
> +			cnt = set->cnt;
> +			size = sizeof(set->ids[0]);
> +		} else {
> +			struct btf_id_set8 *set8;
> +
> +			set8 = (struct btf_id_set8 *)&ptr[idx];
> +			base = set8->pairs;
> +			cnt = set8->cnt;
> +			size = sizeof(set8->pairs[0]);
> +		}
>   
>   		pr_debug("sorting  addr %5lu: cnt %6d [%s]\n",
>   			 (idx + 1) * sizeof(int), cnt, id->name);
>   
> -		qsort(base, cnt, id->is_set8 ? sizeof(uint64_t) : sizeof(int), cmp_id);
> +		qsort(base, cnt, size, cmp_id);

Looks good to me, one small remark: perhaps it would also make sense to have an assert
on the id location, such that we have a build error in case the id would not be the
first in the struct / pairs array anymore given then cmp_id would look at wrong data
for the latter given the plain int cast from there.

>   		next = rb_next(next);
>   	}
> diff --git a/tools/include/linux/btf_ids.h b/tools/include/linux/btf_ids.h
> index 2f882d5cb30f..72535f00572f 100644
> --- a/tools/include/linux/btf_ids.h
> +++ b/tools/include/linux/btf_ids.h
> @@ -8,6 +8,15 @@ struct btf_id_set {
>   	u32 ids[];
>   };
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
>   #ifdef CONFIG_DEBUG_INFO_BTF
>   
>   #include <linux/compiler.h> /* for __PASTE */
> 


