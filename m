Return-Path: <bpf+bounces-69987-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DCE91BAA711
	for <lists+bpf@lfdr.de>; Mon, 29 Sep 2025 21:17:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 657273AEFFA
	for <lists+bpf@lfdr.de>; Mon, 29 Sep 2025 19:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E180F2417E6;
	Mon, 29 Sep 2025 19:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ZXp2VoDt"
X-Original-To: bpf@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 028CB19343B;
	Mon, 29 Sep 2025 19:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759173462; cv=none; b=Ch/glLUZVIDGA6Yj518NEhPKlGHNrD2Yqbwt6z+gJsf6BEqPon09xha9Ml4HbhKy5Eht1ezlJQJPjTV6JdxW1dS6QHam9sV0x/P/FVvNwYGnAlJaKzxNbdJkOqrVVXe+rWUhhagPBb4mD81cB+E+sz7JXm6AfLhHNiiFW0/nRWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759173462; c=relaxed/simple;
	bh=6tsZa/MERNesxGFOy+Dd6WFSrpVJ+4w+3pDW0q7INFo=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZvUnqZqbc1vrP3pd7acrNXBkLAlOm345AdkATyiZ8ituv5TjGKxNNtyYbUBnQYwypw5hZ2S/+RI6uJymSfiRYp6wfDJs0GpLEQjaOe+2trr+yt2Ju8Pu5GQuWGBsiiTVYeX3i8VVMpYq3lVnnbjryRvvc6a+/fB2yyfWg6gZgTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=ZXp2VoDt; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from narnia (unknown [13.88.17.9])
	by linux.microsoft.com (Postfix) with ESMTPSA id 3DC6E2127313;
	Mon, 29 Sep 2025 12:17:39 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3DC6E2127313
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1759173460;
	bh=pW4imUcmU1Cp0sMaL/8GyVY1QQK6kUNt+BCT3yuw0+c=;
	h=From:To:Subject:In-Reply-To:References:Date:From;
	b=ZXp2VoDtNVJlfr9ZFHcMPUGvXuSThJq6Ss5HlEXjNn6Z1Y/8yphZd0PH7YrtbaL9P
	 jyQHnXP6ejNoghx1twkMAWXteQzYGxbNWUcVEW2ocg/USJMLFpfmKcK/iun9LeifQi
	 ecCY+7aesrAJw2K7xufAm5yER5oWWioqGh+RA3oo=
From: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
To: Quentin Monnet <qmo@kernel.org>, bpf@vger.kernel.org,
 linux-security-module@vger.kernel.org, kpsingh@kernel.org,
 paul@paul-moore.com, kys@microsoft.com, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org,
 James.Bottomley@hansenpartnership.com, wufan@linux.microsoft.com
Subject: Re: [PATCH bpf-next 1/2] bpf: Add hash chain signature support for
 arbitrary maps
In-Reply-To: <ab14f430-f4a7-4d5f-8062-8d2113cf8e0d@kernel.org>
References: <20250926203111.1305999-1-bboscaccy@linux.microsoft.com>
 <20250926203111.1305999-2-bboscaccy@linux.microsoft.com>
 <ab14f430-f4a7-4d5f-8062-8d2113cf8e0d@kernel.org>
Date: Mon, 29 Sep 2025 12:17:37 -0700
Message-ID: <874islysoe.fsf@microsoft.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Quentin Monnet <qmo@kernel.org> writes:

> 2025-09-26 13:30 UTC-0700 ~ Blaise Boscaccy <bboscaccy@linux.microsoft.com>
>> This patch introduces hash chain support for signature verification of
>> arbitrary bpf map objects which was described here:
>> https://lore.kernel.org/linux-security-module/20250721211958.1881379-1-kpsingh@kernel.org/
>> 
>> The UAPI is extended to allow for in-kernel checking of maps passed in
>> via the fd_array. A hash chain is constructed from the maps, in order
>> specified by the signature_maps field. The hash chain is terminated
>> with the hash of the program itself.
>> 
>> Signed-off-by: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
>> ---
>>  include/uapi/linux/bpf.h                      |  6 ++
>>  kernel/bpf/syscall.c                          | 73 ++++++++++++++++++-
>>  .../bpf/bpftool/Documentation/bpftool-gen.rst |  7 +-
>>  tools/bpf/bpftool/gen.c                       | 27 ++++++-
>>  tools/bpf/bpftool/main.c                      |  9 ++-
>>  tools/bpf/bpftool/main.h                      |  1 +
>>  tools/bpf/bpftool/sign.c                      | 17 ++++-
>>  tools/include/uapi/linux/bpf.h                |  6 ++
>>  tools/lib/bpf/libbpf.h                        |  3 +-
>>  tools/lib/bpf/skel_internal.h                 |  6 +-
>>  10 files changed, 143 insertions(+), 12 deletions(-)
>> 
>
> [...]
>
>> diff --git a/tools/bpf/bpftool/Documentation/bpftool-gen.rst b/tools/bpf/bpftool/Documentation/bpftool-gen.rst
>> index d0a36f442db72..b632ab87adf20 100644
>> --- a/tools/bpf/bpftool/Documentation/bpftool-gen.rst
>> +++ b/tools/bpf/bpftool/Documentation/bpftool-gen.rst
>> @@ -16,7 +16,7 @@ SYNOPSIS
>>  
>>  **bpftool** [*OPTIONS*] **gen** *COMMAND*
>>  
>> -*OPTIONS* := { |COMMON_OPTIONS| | { **-L** | **--use-loader** } | [ { **-S** | **--sign** } {**-k** <private_key.pem>} **-i** <certificate.x509> ] }
>> +*OPTIONS* := { |COMMON_OPTIONS| | { **-L** | **--use-loader** } | [ { **-S** | **--sign** } { **-M** | **--sign-maps** } {**-k** <private_key.pem>} **-i** <certificate.x509> ] }
>>  
>>  *COMMAND* := { **object** | **skeleton** | **help** }
>>  
>> @@ -190,6 +190,11 @@ OPTIONS
>>      For skeletons, generate a signed skeleton. This option must be used with
>>      **-k** and **-i**. Using this flag implicitly enables **--use-loader**.
>>  
>> +-M --sign-maps
>> +    For skeletons, generate a signed skeleton that includes a hash chain for the
>> +    skeletons maps. This option must be used with **-k** and **-i**. Using this
>> +    flag implicitly enables **--use-loader** and **--sign**.
>> +
>
>
> Hi! Pardon my ignorance, I haven't followed all the details of the
> discussions around signing. Is there a use case for signing the programs
> only (using -S) without signing the maps (using -M)? Or should we
> consider collapsing maps signing under the existing -S option?
>

Hi Quentin! Yes, there are some use cases where having both map signing
and program signing doesn't make much sense. For the light-skeleton use
case, where the map contains your actual program, it makes a lot of
sense. For other more dynamic use cases, maps can contain dynamically
generated user data or simply be providing program input and
output. Signing of those maps wouldn't provide much benefit, or even be
practical or possible in some scenarios. 

> If you do keep the new option, would you mind updating the bash
> completion file, please? Simply adding the long form like this:
>

> ------
>
> diff --git i/tools/bpf/bpftool/bash-completion/bpftool w/tools/bpf/bpftool/bash-completion/bpftool
> index 53bcfeb1a76e..f8c217f09989 100644
> --- i/tools/bpf/bpftool/bash-completion/bpftool
> +++ w/tools/bpf/bpftool/bash-completion/bpftool
> @@ -262,7 +262,7 @@ _bpftool()
>      # Deal with options
>      if [[ ${words[cword]} == -* ]]; then
>          local c='--version --json --pretty --bpffs --mapcompat --debug \
> -            --use-loader --base-btf --sign -i -k'
> +            --use-loader --base-btf --sign --sign-maps -i -k'
>          COMPREPLY=( $( compgen -W "$c" -- "$cur" ) )
>          return 0
>      fi
>
> ------

Of course. Thanks for the diff. I'll get that incorporated. 

>
> Other than that, the changes for bpftool look OK from my side. I'd
> probably split the patch further into kernel/libbpf/bpftool changes, but
> that's your call.
>

Sure, I'll get the userspace and kernel changes split out.

-blaise

> Thanks,
> Quentin

