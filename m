Return-Path: <bpf+bounces-75808-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DA688C97E02
	for <lists+bpf@lfdr.de>; Mon, 01 Dec 2025 15:39:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5B9A54E3247
	for <lists+bpf@lfdr.de>; Mon,  1 Dec 2025 14:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72BA031AF10;
	Mon,  1 Dec 2025 14:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WfC5dtn+"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60E931A571;
	Mon,  1 Dec 2025 14:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764599937; cv=none; b=NC8iKJXf1rR3gMtmtdcpdZdB8pym5wiiV0D9n2vz3z7SPwEEz6f+d3/hhhaX9eSAuUf/HvXYjm1c+7caqHq9DIp982znT2pnZp9rjnpxXDyGE2xWyr/4aCtHEQDdBvq9gGA1JSYlhpiuv+tlGlbyb2YFIq7jYF1yMMSChhuHycI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764599937; c=relaxed/simple;
	bh=yW+sOXih+CLGwUctcH2iHTN+9YC5Pg+tYmbUnjut2mk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u9Vk3p86fihSwFlIKQAKNA65UnmfoikUv+hhhu9vKJsUtc+7XNWW6WJLeWmxQvwAGLs/4FPB135LDizxqRMB8rxasXXx4VMlVqcbL61Mo8yZJudu9tdW8kELNR88GRGvZeRM+z1Vj1lMw+c7nHEpnc/bE4zMBqOhXnsdep42qt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WfC5dtn+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2759FC16AAE;
	Mon,  1 Dec 2025 14:38:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764599936;
	bh=yW+sOXih+CLGwUctcH2iHTN+9YC5Pg+tYmbUnjut2mk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WfC5dtn+4JmURdF52RQ08zTX1C301e9FxJUJ9i86OKurVVHa3fcj/3cTxYXIza0Pq
	 AXqNjv3f3yUAr98DQdG6gTsL7BNutITR/SZAZ0M+/hAn7ZxLgRqxYdty4VxJf70aaU
	 Q3N1pr2nLn3z31I1VpqpDSMtJmQoNGCDPhK2bEjRChVxndsqvlwIidoFqZtwv5U27E
	 gthUUH5gxq/MZt28iHAMds7H2af2K8e9VidQzA0Rs8xwiLAMyj4RBW+Dt3Yd/9Rfci
	 3bfBw/vi/L0++dOxqKnhAPU/5Tce2OkM3oNcEFs4zzSZXwN6rtYMXCqNIF1sj3m21s
	 xBv2tsLQjVGTw==
Date: Mon, 1 Dec 2025 07:38:53 -0700
From: Tycho Andersen <tycho@kernel.org>
To: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Cc: kees@kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	Andy Lutomirski <luto@amacapital.net>,
	Will Drewry <wad@chromium.org>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <shuah@kernel.org>, Andrei Vagin <avagin@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	=?iso-8859-1?Q?St=E9phane?= Graber <stgraber@stgraber.org>
Subject: Re: [PATCH v1 4/6] seccomp: handle multiple listeners case
Message-ID: <aS2offcUPOkfkye1@tycho.pizza>
References: <20251201122406.105045-1-aleksandr.mikhalitsyn@canonical.com>
 <20251201122406.105045-5-aleksandr.mikhalitsyn@canonical.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251201122406.105045-5-aleksandr.mikhalitsyn@canonical.com>

On Mon, Dec 01, 2025 at 01:24:01PM +0100, Alexander Mikhalitsyn wrote:
> If we have more than one listener in the tree and lower listener
> wants us to continue syscall (SECCOMP_USER_NOTIF_FLAG_CONTINUE)
> we must consult with upper listeners first, otherwise it is a
> clear seccomp restrictions bypass scenario.
> 
> Cc: linux-kernel@vger.kernel.org
> Cc: bpf@vger.kernel.org
> Cc: Kees Cook <kees@kernel.org>
> Cc: Andy Lutomirski <luto@amacapital.net>
> Cc: Will Drewry <wad@chromium.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: Tycho Andersen <tycho@tycho.pizza>
> Cc: Andrei Vagin <avagin@gmail.com>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Stéphane Graber <stgraber@stgraber.org>
> Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
> ---
>  kernel/seccomp.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/seccomp.c b/kernel/seccomp.c
> index ded3f6a6430b..ad733f849e0f 100644
> --- a/kernel/seccomp.c
> +++ b/kernel/seccomp.c
> @@ -450,6 +450,9 @@ static u32 seccomp_run_filters(const struct seccomp_data *sd,
>  			ret = cur_ret;
>  			matches->n = 1;
>  			matches->filters[0] = f;
> +		} else if ((ACTION_ONLY(cur_ret) == ACTION_ONLY(ret)) &&
> +			    ACTION_ONLY(cur_ret) == SECCOMP_RET_USER_NOTIF) {
> +			matches->filters[matches->n++] = f;
>  		}
>  	}
>  	return ret;
> @@ -1362,8 +1365,17 @@ static int __seccomp_filter(int this_syscall, const bool recheck_after_trace)
>  		return 0;
>  
>  	case SECCOMP_RET_USER_NOTIF:
> -		if (seccomp_do_user_notification(match, &sd))
> -			goto skip;
> +		for (unsigned char i = 0; i < matches.n; i++) {
> +			match = matches.filters[i];
> +			/*
> +			 * If userspace wants us to skip this syscall, do so.
> +			 * But if userspace wants to continue syscall, we
> +			 * must consult with the upper-level filters listeners
> +			 * and act accordingly.

This looks reasonable to me, pending whatever the outcome is of your
discussion of plumber's (I won't be there), feel free to add:

Reviewed-by: Tycho Andersen (AMD) <tycho@kernel.org>

I did have to think a bit about why matches.filters would be
guaranteed to have a user notification for this filter, but it's
because of your == check above in seccomp_run_filters(). Maybe worth
noting that here.

Tycho

