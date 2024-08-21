Return-Path: <bpf+bounces-37758-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5DA695A4DE
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 20:45:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA25CB21AEC
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 18:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE70C1B3B0E;
	Wed, 21 Aug 2024 18:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fWi6u5Oi"
X-Original-To: bpf@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A97416D4FC
	for <bpf@vger.kernel.org>; Wed, 21 Aug 2024 18:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724265908; cv=none; b=k51msdtxCO08F7gZuMjVA3mTsguNVtkltYES9FF19D7ucaWXoXdswkLnNUs37dCQOXy7YWWTyQrEaII5dC5NtWfXaVPDNmLTqchE8VqVPzO5nV3N2HNS8bP104dhM5ycTZ/iEgFUyRVeo2j6cJkbC4lyrLbgnXil/gAY3etpvs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724265908; c=relaxed/simple;
	bh=TX5s92+TVhuZMU9AZQyjIAcTZ2oRFVtucS+9h5RV9cM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VyNs8YjL/7hV+BA7u6qzof1MXgqT9I9rzfvGTLyC5J9NTLjpR801pwSQ9omejJhI5Wa82g+U90G/IK/uRDlQclvL9dHGzPEu9glws8rIHezTEgx/5uDad68N/VhcjgQse+PhjUK3/0FNk6jCy+xUCSahIzYqSmqzEItVm4riSNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fWi6u5Oi; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <b007ee0b-ff90-43ff-91a1-44882bf0e799@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724265904;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6xYdDGp9cZcugtgHBeqcbLyntEez0XWBUyxTHat7Hc8=;
	b=fWi6u5OiQ+Kqss7H6N0eyuu56xh6u+34e0xCWYECGBCxuRkTqNm+D7wcD0AhTWM8jiEXx0
	v5s81aW8FcrLngLXE3thncpOMYUMc6YyayVg7hUBwm1v3id4LZJCTlbLfbm63i2KI7lWCd
	4Kz9UHTNkxvcMBkewyXBCm1+XPX6Iiw=
Date: Wed, 21 Aug 2024 11:44:52 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net v4] bpf, net: Check cgroup_bpf_enabled() only once in
 do_sock_getsockopt()
Content-Language: en-GB
To: Tze-nan Wu <Tze-nan.Wu@mediatek.com>, netdev@vger.kernel.org,
 bpf@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Stanislav Fomichev <sdf@fomichev.me>
Cc: bobule.chang@mediatek.com, wsd_upstream@mediatek.com,
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
 Kuniyuki Iwashima <kuniyu@amazon.com>, Yanghui Li <yanghui.li@mediatek.com>,
 Cheng-Jui Wang <cheng-jui.wang@mediatek.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, KP Singh <kpsingh@kernel.org>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 linux-arm-kernel@lists.infradead.org
References: <20240821093016.2533-1-Tze-nan.Wu@mediatek.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20240821093016.2533-1-Tze-nan.Wu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 8/21/24 2:30 AM, Tze-nan Wu wrote:
> The return value from `cgroup_bpf_enabled(CGROUP_GETSOCKOPT)` can change
> between the invocations of `BPF_CGROUP_GETSOCKOPT_MAX_OPTLEN` and
> `BPF_CGROUP_RUN_PROG_GETSOCKOPT`.
>
> If `cgroup_bpf_enabled(CGROUP_GETSOCKOPT)` changes from "false" to
> "true" between the invocations of `BPF_CGROUP_GETSOCKOPT_MAX_OPTLEN` and
> `BPF_CGROUP_RUN_PROG_GETSOCKOPT`, `BPF_CGROUP_RUN_PROG_GETSOCKOPT` will
> receive an -EFAULT from `__cgroup_bpf_run_filter_getsockopt(max_optlen=0)`
> due to `get_user()` was not reached in `BPF_CGROUP_GETSOCKOPT_MAX_OPTLEN`.
>
> Scenario shown as below:
>
>             `process A`                      `process B`
>             -----------                      ------------
>    BPF_CGROUP_GETSOCKOPT_MAX_OPTLEN
>                                              enable CGROUP_GETSOCKOPT
>    BPF_CGROUP_RUN_PROG_GETSOCKOPT (-EFAULT)
>
> To prevent this, invoke `cgroup_bpf_enabled()` only once and cache the
> result in a newly added local variable `enabled`.
> Both `BPF_CGROUP_*` macros in `do_sock_getsockopt` will then check their
> condition using the same `enabled` variable as the condition variable,
> instead of using the return values from `cgroup_bpf_enabled` called by
> themselves as the condition variable(which could yield different results).
> This ensures that either both `BPF_CGROUP_*` macros pass the condition
> or neither does.
>
> Fixes: 0d01da6afc54 ("bpf: implement getsockopt and setsockopt hooks")
> Co-developed-by: Yanghui Li <yanghui.li@mediatek.com>
> Signed-off-by: Yanghui Li <yanghui.li@mediatek.com>
> Co-developed-by: Cheng-Jui Wang <cheng-jui.wang@mediatek.com>
> Signed-off-by: Cheng-Jui Wang <cheng-jui.wang@mediatek.com>
> Signed-off-by: Tze-nan Wu <Tze-nan.Wu@mediatek.com>
> ---
>
> Chagnes from v1 to v2: https://lore.kernel.org/all/20240819082513.27176-1-Tze-nan.Wu@mediatek.com/
>    Instead of using cgroup_lock in the fastpath, invoke cgroup_bpf_enabled
>    only once and cache the value in the newly added variable `enabled`.
>    `BPF_CGROUP_*` macros in do_sock_getsockopt can then both check their
>    condition with the new variable `enable`, ensuring that either they both
>    passing the condition or both do not.
>
> Chagnes from v2 to v3: https://lore.kernel.org/all/20240819155627.1367-1-Tze-nan.Wu@mediatek.com/
>    Hide cgroup_bpf_enabled in the macro, and some modifications to adapt
>    the coding style.
>
> Chagnes from v3 to v4: https://lore.kernel.org/all/20240820092942.16654-1-Tze-nan.Wu@mediatek.com/
>    Add bpf tag to subject, and Fixes tag in body.
>
> ---
>   include/linux/bpf-cgroup.h | 15 ++++++++-------
>   net/socket.c               |  5 +++--
>   2 files changed, 11 insertions(+), 9 deletions(-)
>
> diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
> index fb3c3e7181e6..5afa2ac76aae 100644
> --- a/include/linux/bpf-cgroup.h
> +++ b/include/linux/bpf-cgroup.h
> @@ -390,20 +390,20 @@ static inline bool cgroup_bpf_sock_enabled(struct sock *sk,
>   	__ret;								       \
>   })
>   
> -#define BPF_CGROUP_GETSOCKOPT_MAX_OPTLEN(optlen)			       \
> +#define BPF_CGROUP_GETSOCKOPT_MAX_OPTLEN(optlen, enabled)		       \
>   ({									       \
>   	int __ret = 0;							       \
> -	if (cgroup_bpf_enabled(CGROUP_GETSOCKOPT))			       \
> +	enabled = cgroup_bpf_enabled(CGROUP_GETSOCKOPT);		       \
> +	if (enabled)							       \
>   		copy_from_sockptr(&__ret, optlen, sizeof(int));		       \
>   	__ret;								       \
>   })
>   
>   #define BPF_CGROUP_RUN_PROG_GETSOCKOPT(sock, level, optname, optval, optlen,   \
> -				       max_optlen, retval)		       \
> +				       max_optlen, retval, enabled)	       \
>   ({									       \
>   	int __ret = retval;						       \
> -	if (cgroup_bpf_enabled(CGROUP_GETSOCKOPT) &&			       \
> -	    cgroup_bpf_sock_enabled(sock, CGROUP_GETSOCKOPT))		       \
> +	if (enabled && cgroup_bpf_sock_enabled(sock, CGROUP_GETSOCKOPT))       \
>   		if (!(sock)->sk_prot->bpf_bypass_getsockopt ||		       \
>   		    !INDIRECT_CALL_INET_1((sock)->sk_prot->bpf_bypass_getsockopt, \
>   					tcp_bpf_bypass_getsockopt,	       \
> @@ -518,9 +518,10 @@ static inline int bpf_percpu_cgroup_storage_update(struct bpf_map *map,
>   #define BPF_CGROUP_RUN_PROG_SOCK_OPS(sock_ops) ({ 0; })
>   #define BPF_CGROUP_RUN_PROG_DEVICE_CGROUP(atype, major, minor, access) ({ 0; })
>   #define BPF_CGROUP_RUN_PROG_SYSCTL(head,table,write,buf,count,pos) ({ 0; })
> -#define BPF_CGROUP_GETSOCKOPT_MAX_OPTLEN(optlen) ({ 0; })
> +#define BPF_CGROUP_GETSOCKOPT_MAX_OPTLEN(optlen, enabled) ({ 0; })
>   #define BPF_CGROUP_RUN_PROG_GETSOCKOPT(sock, level, optname, optval, \
> -				       optlen, max_optlen, retval) ({ retval; })
> +				       optlen, max_optlen, retval, \
> +				       enabled) ({ retval; })
>   #define BPF_CGROUP_RUN_PROG_GETSOCKOPT_KERN(sock, level, optname, optval, \
>   					    optlen, retval) ({ retval; })
>   #define BPF_CGROUP_RUN_PROG_SETSOCKOPT(sock, level, optname, optval, optlen, \
> diff --git a/net/socket.c b/net/socket.c
> index fcbdd5bc47ac..0b465dc8a789 100644
> --- a/net/socket.c
> +++ b/net/socket.c
> @@ -2363,6 +2363,7 @@ int do_sock_getsockopt(struct socket *sock, bool compat, int level,
>   		       int optname, sockptr_t optval, sockptr_t optlen)
>   {
>   	int max_optlen __maybe_unused;
> +	bool enabled __maybe_unused;
>   	const struct proto_ops *ops;
>   	int err;
>   
> @@ -2371,7 +2372,7 @@ int do_sock_getsockopt(struct socket *sock, bool compat, int level,
>   		return err;
>   
>   	if (!compat)
> -		max_optlen = BPF_CGROUP_GETSOCKOPT_MAX_OPTLEN(optlen);
> +		max_optlen = BPF_CGROUP_GETSOCKOPT_MAX_OPTLEN(optlen, enabled);

Here, 'enabled' is actually assigned with a value in the macro. I am not sure
whether this is a common practice or not. At least from macro, it is not clear
about this.

Maybe we can do
	max_optlen = BPF_CGROUP_GETSOCKOPT_MAX_OPTLEN(optlen, &enabled);

The &enabled signals that its value could change. And indeed
the macro will store the proper value to &enabled properly.

Just my 2 cents.

>   
>   	ops = READ_ONCE(sock->ops);
>   	if (level == SOL_SOCKET) {
> @@ -2390,7 +2391,7 @@ int do_sock_getsockopt(struct socket *sock, bool compat, int level,
>   	if (!compat)
>   		err = BPF_CGROUP_RUN_PROG_GETSOCKOPT(sock->sk, level, optname,
>   						     optval, optlen, max_optlen,
> -						     err);
> +						     err, enabled);
>   
>   	return err;
>   }

