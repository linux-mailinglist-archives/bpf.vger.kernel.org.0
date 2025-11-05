Return-Path: <bpf+bounces-73655-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1007BC3641A
	for <lists+bpf@lfdr.de>; Wed, 05 Nov 2025 16:12:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9283A6249C8
	for <lists+bpf@lfdr.de>; Wed,  5 Nov 2025 15:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09AC432E140;
	Wed,  5 Nov 2025 14:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pfiz2aB9"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75BB33128D0;
	Wed,  5 Nov 2025 14:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762354794; cv=none; b=Q5hNKn/NJJ1PabfzbqqnszEoY/eTO0UikfozvjD47mQVby1LwoDePK6SG6QNJ36yR59Fr/ivRSu0+uOCstXzPorWwLZUeSLbdCD0KyvfRr7QNquhpXj5eZj6BS94pUUlADyaVPofzkm+eJJBxHLKyXbxpX1FR3Gi/8hxxv1D7zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762354794; c=relaxed/simple;
	bh=ZhyBtgzPeikFKSjIZ69tWkFShHDeHs5VfEJxFcPZVHg=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=R0X3C2bHLNIS+ybkuh6QrdHY9l4q+D7ZgpWhYgGOPA2oOSCTf65V6GE+0N/0axgigf2NSgJwVysO6ljpt9ZEg/DedywUg/ibf0kK3/alw5ZAkpYqooZ2NomrP90QD8ynT+gvwzl6pOHkFRjObwn4TlcCHlcmIitT04ySjuJ6WRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pfiz2aB9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DE61C4CEF5;
	Wed,  5 Nov 2025 14:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762354794;
	bh=ZhyBtgzPeikFKSjIZ69tWkFShHDeHs5VfEJxFcPZVHg=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=pfiz2aB9Ju/H7axy4bb3UdtyD4oh/ClIC552luOY6w8Swkw5M+xnwXdHrpF8Mx9Pp
	 Sdi/hFNgEl8KIyOe03BbFxI8WufFKZCd3zxa2PgD0rECZy6cGWMTgZJgVdPdzgUj5O
	 Jz0d6bh7UnMAlOQSbW+KaKKwtAwXHRTQOGX59qlMEQzJ7aNdk8ELj4qBr7FfKc0DDF
	 4YxjbD6eVl/H6Nxjzeu5fBPsv46vD6gn2NGgMv0EvLDPXO9E7eK5ToSShEHcvMh97J
	 fnoynyn8BHHiPgxiSEYWouaBglxy160dvlPWbnhyFElgz8gAgdf+sHY514U7tKuAyD
	 y0g0nFsW2lRvQ==
Content-Type: multipart/mixed; boundary="===============3355875946286134360=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <451acb410ee1ce42f7fb2da9f3b8162708f40788cb849cc0f50851ad16813349@mail.kernel.org>
In-Reply-To: <20251105142319.1139183-3-pmladek@suse.com>
References: <20251105142319.1139183-3-pmladek@suse.com>
Subject: Re: [PATCH 2/6] kallsyms: Cleanup code for appending the module buildid
From: bot+bpf-ci@kernel.org
To: pmladek@suse.com,petr.pavlu@suse.com,rostedt@goodmis.org,ast@kernel.org,akpm@linux-foundation.org,kees@kernel.org
Cc: daniel@iogearbox.net,john.fastabend@gmail.com,mhiramat@kernel.org,mark.rutland@arm.com,mcgrof@kernel.org,da.gomez@kernel.org,samitolvanen@google.com,linux-kernel@vger.kernel.org,bpf@vger.kernel.org,linux-modules@vger.kernel.org,linux-trace-kernel@vger.kernel.org,pmladek@suse.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed,  5 Nov 2025 14:59:53 +0000 (UTC)

--===============3355875946286134360==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
> index 1e7635864..9455e3bb0 100644
> --- a/kernel/kallsyms.c
> +++ b/kernel/kallsyms.c
> @@ -423,6 +423,37 @@ int lookup_symbol_name(unsigned long addr, char *symname)
>  	return lookup_module_symbol_name(addr, symname);
>  }
>
> +#ifdef CONFIG_STACKTRACE_BUILD_ID
> +
> +static int append_buildid(char *buffer,  const char *modname,
> +			  const unsigned char *buildid)
> +{
> +	if (!modname)
> +		return 0;
> +
> +	if (!buildid) {
> +		pr_warn_once("Undefined buildid for the module %s\n", modname);
> +		return 0;
> +	}

When ftrace_mod_address_lookup() succeeds in kallsyms_lookup_buildid(),
it sets *modname but doesn't initialize *modbuildid. This leaves the
buildid variable uninitialized when __sprint_symbol() calls
append_buildid(). Can the check above read uninitialized memory?

Looking at kallsyms_lookup_buildid():
- module_address_lookup() properly initializes both modname and
  modbuildid
- bpf_address_lookup() sets modname=NULL (so append_buildid isn't
  called)
- ftrace_mod_address_lookup() sets modname=mod_map->mod->name but has
  no modbuildid parameter

The commit message mentions wanting to catch when lookup functions don't
handle buildid, but shouldn't kallsyms_lookup_buildid() initialize
*modbuildid=NULL before calling the lookup functions to avoid undefined
behavior?

> +
> +	/* build ID should match length of sprintf */
> +#ifdef CONFIG_MODULES
> +	static_assert(sizeof(typeof_member(struct module, build_id)) == 20);
> +#endif
> +
> +	return sprintf(buffer, " %20phN", buildid);
> +}

[ ... ]

> @@ -445,15 +476,8 @@ static int __sprint_symbol(char *buffer, unsigned long address,
>
>  	if (modname) {
>  		len += sprintf(buffer + len, " [%s", modname);
> -#if IS_ENABLED(CONFIG_STACKTRACE_BUILD_ID)
> -		if (add_buildid && buildid) {
> -			/* build ID should match length of sprintf */
> -#if IS_ENABLED(CONFIG_MODULES)
> -			static_assert(sizeof(typeof_member(struct module, build_id)) == 20);
> -#endif
> -			len += sprintf(buffer + len, " %20phN", buildid);
> -		}
> -#endif
> +		if (add_buildid)
> +			len += append_buildid(buffer + len, modname, buildid);
>  		len += sprintf(buffer + len, "]");
>  	}


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/19105560191

--===============3355875946286134360==--

