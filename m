Return-Path: <bpf+bounces-20103-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C109839694
	for <lists+bpf@lfdr.de>; Tue, 23 Jan 2024 18:40:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1B64284799
	for <lists+bpf@lfdr.de>; Tue, 23 Jan 2024 17:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8859980047;
	Tue, 23 Jan 2024 17:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d3HEU7me"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082217FBA1;
	Tue, 23 Jan 2024 17:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706031611; cv=none; b=LqZzVbHPujIDCksMxpoWVhedaHryKJqe5a3bCIracQbgHUr3id4lDu3+5JgLMaj+sHoQPZYj1Gn21xRclsHiRbP3bcrL+Qg0PWvmZtoMCTnez2BPB81MZb3voaHFCyrv57MwFwrHCK+PX3vD7JkdK26o0MxfEww+wwFvoyoonzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706031611; c=relaxed/simple;
	bh=3StveZ7O01KUMKkYSW0OiZTG31utUIkqY45LlOjxvBw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AJuxxWaaec25KBNQBa8uJEXpbghAlVSK6BEvW/hLxGBQTdMx02GSMgzxqr/XgfGRnKZdGT0YkhErtqJ/o1D/boDnRqA1z6z5HiQ6hwOkZtpeFGw23guJz/t736tEmfC99J2sXnQVndHsSisCMye3yHhqf9hRdTRtQn27LrAnFf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d3HEU7me; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEC2AC433F1;
	Tue, 23 Jan 2024 17:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706031610;
	bh=3StveZ7O01KUMKkYSW0OiZTG31utUIkqY45LlOjxvBw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d3HEU7meYerxBi+D51f6kVazcNp4V04WVj8EZprWX19a4JQnMEKWvD+QQTAb7Nb5T
	 25d4jPu+ddlrrnp3tlkUvyki8ElAjECaCLRnYan5JHntJm4sQ3WgDyjghdmk5DrRNq
	 MAxa6wXR0MG8oSvStdYv18Z4YQ87KUIb/OeDr5auu/OCkUn+8ZwAV0sTa2XJai9rS2
	 wyhab2tfozpAGfRKUc3tfWnp2EY1PXdLxnNtO0SoY+0hsIiHdJI0EqR7CoCUfmZAjX
	 RsCj1YwMUHCOpFah/sgiPnUVYfkMqWFsw4lztEtwfB64WfdCn10n7JW5AvBfxvKl6A
	 4lMs3PwwmznSg==
Date: Tue, 23 Jan 2024 17:40:02 +0000
From: Simon Horman <horms@kernel.org>
To: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, cake@lists.bufferbloat.net,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Stephen Hemminger <stephen@networkplumber.org>,
	Petr Pavlu <ppavlu@suse.cz>, Michal Kubecek <mkubecek@suse.cz>,
	Martin Wilck <mwilck@suse.com>,
	Pedro Tammela <pctammela@mojatatu.com>
Subject: Re: [PATCH v4 3/4] net/sched: Load modules via their alias
Message-ID: <20240123174002.GN254773@kernel.org>
References: <20240123135242.11430-1-mkoutny@suse.com>
 <20240123135242.11430-4-mkoutny@suse.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240123135242.11430-4-mkoutny@suse.com>

On Tue, Jan 23, 2024 at 02:52:41PM +0100, Michal Koutný wrote:
> The cls_,sch_,act_ modules may be loaded lazily during network
> configuration but without user's awareness and control.
> 
> Switch the lazy loading from canonical module names to a module alias.
> This allows finer control over lazy loading, the precedent from
> commit 7f78e0351394 ("fs: Limit sys_mount to only request filesystem
> modules.") explains it already:
> 
> 	Using aliases means user space can control the policy of which
> 	filesystem^W net/sched modules are auto-loaded by editing
> 	/etc/modprobe.d/*.conf with blacklist and alias directives.
> 	Allowing simple, safe, well understood work-arounds to known
> 	problematic software.
> 
> By default, nothing changes. However, if a specific module is
> blacklisted (its canonical name), it won't be modprobe'd when requested
> under its alias (i.e. kernel auto-loading). It would appear as if the
> given module was unknown.
> 
> The module can still be loaded under its canonical name, which is an
> explicit (privileged) user action.
> 
> Signed-off-by: Michal Koutný <mkoutny@suse.com>
> ---
>  net/sched/act_api.c | 2 +-
>  net/sched/cls_api.c | 2 +-
>  net/sched/sch_api.c | 4 ++--
>  3 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/net/sched/act_api.c b/net/sched/act_api.c
> index 3e30d7260493..60c0fadfac6d 100644
> --- a/net/sched/act_api.c
> +++ b/net/sched/act_api.c
> @@ -1363,7 +1363,7 @@ struct tc_action_ops *tc_action_load_ops(struct nlattr *nla, u32 flags,
>  
>  		if (rtnl_held)
>  			rtnl_unlock();
> -		request_module("act_%s", act_name);
> +		request_module(NET_ACT_ALIAS_PREFIX "%s", name);

Hi Michal,

name doesn't exist in this context, perhaps the line above should be:

		request_module(NET_ACT_ALIAS_PREFIX "%s", act_name);

>  		if (rtnl_held)
>  			rtnl_lock();
>  
> diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
> index 92a12e3d0fe6..b31b832598e7 100644
> --- a/net/sched/cls_api.c
> +++ b/net/sched/cls_api.c
> @@ -257,7 +257,7 @@ tcf_proto_lookup_ops(const char *kind, bool rtnl_held,
>  #ifdef CONFIG_MODULES
>  	if (rtnl_held)
>  		rtnl_unlock();
> -	request_module("cls_%s", kind);
> +	request_module(NET_CLS_ALIAS_PREFIX "%s", name);

Likewise, perhaps the line above should be:

	request_module(NET_CLS_ALIAS_PREFIX "%s", kind);

>  	if (rtnl_held)
>  		rtnl_lock();
>  	ops = __tcf_proto_lookup_ops(kind);

...

-- 
pw-bot: changes-requested

