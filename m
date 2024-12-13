Return-Path: <bpf+bounces-46866-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74AB89F10B8
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 16:18:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2BB6188203F
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 15:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 533581E32DD;
	Fri, 13 Dec 2024 15:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PxREFX+O"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F201E3DC2;
	Fri, 13 Dec 2024 15:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734103081; cv=none; b=TknVf30mdyqfr3VcgWZSRuzFakeOBgxug2ZQrZEb7l7xUdPgin/HlEIcIXwVIcboa4rVm/RkuVPv2YUQm8Url8TtvRJGsvh4exNZjWAdTzkqiFAa9e879rlp5XelBozzMW9eBozL8UP9hFe7GtRDvJdNu2eSdWV5or62SDljd20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734103081; c=relaxed/simple;
	bh=txkuStX7h1Oh2pm7wdIkpU7wk9cSKWEH9ad9FDeA4Ko=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rIP35zeV8qBt5ZRdhSpxQCB5yjxOTH0KVhzyKVvB1JOPfcZdr1MW09Gqu+GjHc1Pt+CTNI4VAYvinRjHsbLJLUbsp8npBzBNPOEI9WMLAi/YFFi8Qs8n+4wovDgJTlzrr6GondBoU23j3c9Jwol0hilaLLT41Ztd8G8M369UFhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PxREFX+O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E349C4CED0;
	Fri, 13 Dec 2024 15:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734103081;
	bh=txkuStX7h1Oh2pm7wdIkpU7wk9cSKWEH9ad9FDeA4Ko=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=PxREFX+OCixhn9kMEeLYeLDSd6P3rvpVNZyHx0NR2lQ5lILt535HGSuT0euMzN38B
	 OxHY/e9ESpQPuVpLyGOhK/wv5LF55Ed6o0rdZuNj6G56IXXk8oJzkYn8GaZH1YAErD
	 axLpeo78FtcyzIwuvGz1pzI74/cY7Ta4DyP8CLnhCdVBdHRuzKbo8ex3SfiGaL/gR9
	 teFurAzuM3/cNci4zjCoDQCmu6GTrydCcqlXAr4xisrEzDMrTe/7L0/mj3lhAwdZ2y
	 t0l4Pi7nEn+FZWvfvbTKibHbUneCkTS29v3BQ3/RJ9GVebeKhzIc0a2RHCSE4vS2cr
	 y7YHTVqJ2QplQ==
Message-ID: <8372554b-0d4d-4f65-b000-a1a6c00d80ab@kernel.org>
Date: Fri, 13 Dec 2024 15:17:57 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v4 4/4] bpftool: bash: Add bash completion for
 root_id argument
To: Daniel Xu <dxu@dxuuu.xyz>, andrii@kernel.org, ast@kernel.org,
 daniel@iogearbox.net
Cc: martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, andrii.nakryiko@gmail.com, antony@phenome.org,
 toke@kernel.org
References: <cover.1734052995.git.dxu@dxuuu.xyz>
 <7aa45a2c19ac50b72be1921e0d94f9bc77c97896.1734052995.git.dxu@dxuuu.xyz>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <7aa45a2c19ac50b72be1921e0d94f9bc77c97896.1734052995.git.dxu@dxuuu.xyz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2024-12-12 18:24 UTC-0700 ~ Daniel Xu <dxu@dxuuu.xyz>
> This commit updates the bash completion script with the new root_id
> argument.
> 
> Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> ---
>  tools/bpf/bpftool/bash-completion/bpftool | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/bpf/bpftool/bash-completion/bpftool b/tools/bpf/bpftool/bash-completion/bpftool
> index 0c541498c301..097d406ee21f 100644
> --- a/tools/bpf/bpftool/bash-completion/bpftool
> +++ b/tools/bpf/bpftool/bash-completion/bpftool
> @@ -930,6 +930,9 @@ _bpftool()
>                          format)
>                              COMPREPLY=( $( compgen -W "c raw" -- "$cur" ) )
>                              ;;
> +                        root_id)
> +                            return 0;
> +                            ;;
>                          c)
>                              COMPREPLY=( $( compgen -W "unsorted" -- "$cur" ) )
>                              ;;
> @@ -937,13 +940,13 @@ _bpftool()
>                              # emit extra options
>                              case ${words[3]} in
>                                  id|file)
> -                                    _bpftool_once_attr 'format'
> +                                    _bpftool_once_attr 'format root_id'
>                                      ;;
>                                  map|prog)
>                                      if [[ ${words[3]} == "map" ]] && [[ $cword == 6 ]]; then
>                                          COMPREPLY+=( $( compgen -W "key value kv all" -- "$cur" ) )
>                                      fi
> -                                    _bpftool_once_attr 'format'
> +                                    _bpftool_once_attr 'format root_id'
>                                      ;;
>                                  *)
>                                      ;;


Thanks! If we support multiple occurrences for root_id, let's adjust the
completion (and also complete with root_id after "format c", by the way,
I missed it last time):

------
diff --git a/tools/bpf/bpftool/bash-completion/bpftool b/tools/bpf/bpftool/bash-completion/bpftool
index 0c541498c301..e5bf809656ed 100644
--- a/tools/bpf/bpftool/bash-completion/bpftool
+++ b/tools/bpf/bpftool/bash-completion/bpftool
@@ -930,19 +930,24 @@ _bpftool()
                         format)
                             COMPREPLY=( $( compgen -W "c raw" -- "$cur" ) )
                             ;;
+                        root_id)
+                            return 0
+                            ;;
                         c)
-                            COMPREPLY=( $( compgen -W "unsorted" -- "$cur" ) )
+                            COMPREPLY=( $( compgen -W "unsorted root_id" -- "$cur" ) )
                             ;;
                         *)
                             # emit extra options
                             case ${words[3]} in
                                 id|file)
+                                    COMPREPLY=( $( compgen -W "root_id" -- "$cur" ) )
                                     _bpftool_once_attr 'format'
                                     ;;
                                 map|prog)
                                     if [[ ${words[3]} == "map" ]] && [[ $cword == 6 ]]; then
                                         COMPREPLY+=( $( compgen -W "key value kv all" -- "$cur" ) )
                                     fi
+                                    COMPREPLY=( $( compgen -W "root_id" -- "$cur" ) )
                                     _bpftool_once_attr 'format'
                                     ;;
                                 *)
------

