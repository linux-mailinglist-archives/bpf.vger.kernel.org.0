Return-Path: <bpf+bounces-64064-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68E12B0DFED
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 17:06:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C29C6C367D
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 15:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04C5A2EE293;
	Tue, 22 Jul 2025 15:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iCDgh9AH"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C55240BF5;
	Tue, 22 Jul 2025 15:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753196545; cv=none; b=cFEven4qFn7dxQXGskZOtdgXNE4Ax+0OnXAKFdgORvO0XzZ4CXIV5D3zrx4ddaCIrTifCrvh8J81eA9tRUpmFUbU5dDoIGULTVPJ+KNeWGdTsDEbNl8iy8UYXdLZCo8g6ppp6hseE2xnWZ0AR+L8JXlqpWr6IKEeWlSik5k52Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753196545; c=relaxed/simple;
	bh=eYADMR6LO4fHCLCJvykODtjoG7IOJ0s2vHb6JBwmIV8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aIstBkete+Lq5bBK0xRn+7+dlYF93u31icD+QnyKTM/Y0ciGwPb81L42GkOfDKdSmLw6Cy+zfxvndYfhLMWRHr5tWplUu9/obvsmzCvnRm/f2GeyJ5eeVueCAjaqehe9wqKUFdtb5FChi1nTi53beU0IlFoEYR/2utzQ+WDZ+K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iCDgh9AH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5354EC4CEF9;
	Tue, 22 Jul 2025 15:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753196545;
	bh=eYADMR6LO4fHCLCJvykODtjoG7IOJ0s2vHb6JBwmIV8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=iCDgh9AHBayEk9cF6vgzaxQUFF3Ny2e09DsikQgzHEzTvKuX0/+DXQnoWcS49m8+I
	 uzng26X5THwPiBtHmKA9GAAz6c/o1mzbc9ygUY9ixg6a4LnSHDuEcZegkTdoNExHyC
	 9Dnzg/NZ3Xj0AgEbJyf8nXoVxVm5wUrnDG5qzBwhcaJ3OB24BnE6TCAa7xaJFICL9N
	 X7TsdnjuhTsj8vDIvhM3vFKqgnyQCNN0JQBJy+hiSZfDmP53MV1GIakidk8K+8Ffe+
	 EQf86qEupaQha7ts6er8w0guj6RyGZUiAtoK3MIOUQpfqBQXVlQ1jSNF2XwnOkm41e
	 Yfw0U24qtL78Q==
Message-ID: <ba84629f-5675-4793-9320-25d9029d2a35@kernel.org>
Date: Tue, 22 Jul 2025 16:02:21 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 3/3] bpftool: Add bash completion for token
 argument
To: Tao Chen <chen.dylane@linux.dev>, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, davem@davemloft.net,
 kuba@kernel.org, hawk@kernel.org
Cc: linux-kernel@vger.kernel.org, bpf@vger.kernel.org, netdev@vger.kernel.org
References: <20250722120912.1391604-1-chen.dylane@linux.dev>
 <20250722120912.1391604-3-chen.dylane@linux.dev>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <20250722120912.1391604-3-chen.dylane@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2025-07-22 20:09 UTC+0800 ~ Tao Chen <chen.dylane@linux.dev>
> This commit updates the bash completion script with the new token
> argument.
> $ bpftool
> batch       cgroup      gen         iter        map         perf        struct_ops
> btf         feature     help        link        net         prog        token


This is a terrible example, offering "token" as completion for just
"bpftool [tab]" works without this patch :) The main commands are parsed
from the output of "bpftool help" so it should work after your first
patch. In this one, we add "list", "show" and "help" for completing
"bpftool token [tab]".


> 
> Signed-off-by: Tao Chen <chen.dylane@linux.dev>
> ---
>  tools/bpf/bpftool/bash-completion/bpftool | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/tools/bpf/bpftool/bash-completion/bpftool b/tools/bpf/bpftool/bash-completion/bpftool
> index a759ba24471..527bb47ac46 100644
> --- a/tools/bpf/bpftool/bash-completion/bpftool
> +++ b/tools/bpf/bpftool/bash-completion/bpftool
> @@ -1215,6 +1215,17 @@ _bpftool()
>                      ;;
>              esac
>              ;;
> +        token)
> +            case $command in
> +               show|list)
> +                   return 0
> +                   ;;
> +               *)
> +                   [[ $prev == $object ]] && \
> +                       COMPREPLY=( $( compgen -W 'help show list' -- "$cur" ) )
> +                   ;;
> +            esac
> +            ;;
>      esac
>  } &&
>  complete -F _bpftool bpftool


Other than the example in the description, this looks good.

Reviewed-by: Quentin Monnet <qmo@kernel.org>

Thanks

