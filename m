Return-Path: <bpf+bounces-63999-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38D80B0D1A3
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 08:07:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E7D03AA4C8
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 06:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A394328C86D;
	Tue, 22 Jul 2025 06:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rDFVuPNO"
X-Original-To: bpf@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A8C64502F
	for <bpf@vger.kernel.org>; Tue, 22 Jul 2025 06:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753164431; cv=none; b=VNOMxDYuY2j3+9Ub2NDVu3g98iKIUzSWeoAy3ZZcKR1JRhNiBhHPQRun/mCI24v9houOBM9YDETLmrGIyg1XL58Yp0B6wM69zCX1IOounwiOdDcKFjfOk/3v0an5H34yDbCgD4HSwIr0UEXh12RK4hInHFKYZcm6Xsudt1oW8Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753164431; c=relaxed/simple;
	bh=Xu1S1FDHVkYe1QdoHx9idY6UjirqhGUv/g8oY+JSOV0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y6L5OC/H7q/geQRU+vFPi63FdnuT13VyW0SZBplRJ8No2oTbwtWKjv4L2uzdI2f5d4G2DFTvk00ePRkyPFN1+DHk2EyQ/0Y4FKZWQZiC2kt2BURdPTfsfh5pdY+UqhRhKGWCCZK/5flbt+iEgMoCYzx4jXwZ02t0nE98B5nfXuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rDFVuPNO; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <629f59b1-9760-4233-bb17-6be12c0965ba@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753164425;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xVjS0EudrLw88Tcwso/HMMGV5sllQzXKCupSAMsbJFo=;
	b=rDFVuPNOYPRnROToXhdjs7ERmlcD4uk9CFgs7AO/zgMz7EonF1Yk+nmuOITj7DfRP+3aRu
	Q7tZ6pVAswPuABXBe3+RVp2yr+7hCOJaYrxADP5rx3SIpkR+iCacS4g3fIKFiKgk7N+qVA
	cTDr9oWk5A4yBf59KjG+PQqJG3tZgfE=
Date: Tue, 22 Jul 2025 14:06:51 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 2/2] bpftool: Add bpftool-token manpage
To: Quentin Monnet <qmo@kernel.org>, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, davem@davemloft.net,
 kuba@kernel.org, hawk@kernel.org
Cc: linux-kernel@vger.kernel.org, bpf@vger.kernel.org, netdev@vger.kernel.org
References: <20250720173310.1334483-1-chen.dylane@linux.dev>
 <20250720173310.1334483-2-chen.dylane@linux.dev>
 <ab308d9e-a0dc-4b57-b498-93a0f56771c4@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Tao Chen <chen.dylane@linux.dev>
In-Reply-To: <ab308d9e-a0dc-4b57-b498-93a0f56771c4@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2025/7/22 00:23, Quentin Monnet 写道:
> 2025-07-21 01:33 UTC+0800 ~ Tao Chen <chen.dylane@linux.dev>
>> Add bpftool-token manpage with information and examples of token-related
>> commands.
>>
>> Signed-off-by: Tao Chen <chen.dylane@linux.dev>
>> ---
>>   .../bpftool/Documentation/bpftool-token.rst   | 68 +++++++++++++++++++
>>   1 file changed, 68 insertions(+)
>>   create mode 100644 tools/bpf/bpftool/Documentation/bpftool-token.rst
>>
>> diff --git a/tools/bpf/bpftool/Documentation/bpftool-token.rst b/tools/bpf/bpftool/Documentation/bpftool-token.rst
>> new file mode 100644
>> index 00000000000..177f93c0bc7
>> --- /dev/null
>> +++ b/tools/bpf/bpftool/Documentation/bpftool-token.rst
>> @@ -0,0 +1,68 @@
>> +.. SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +
>> +================
>> +bpftool-token
>> +================
>> +-------------------------------------------------------------------------------
>> +tool for inspection and simple manipulation of eBPF progs
> 
> 
> Copy-pasted from bpftool-prog.rst, please update.
> 

will update it in v2, thanks.

> 
>> +-------------------------------------------------------------------------------
>> +
>> +:Manual section: 8
>> +
>> +.. include:: substitutions.rst
>> +
>> +SYNOPSIS
>> +========
>> +
>> +**bpftool** [*OPTIONS*] **token** *COMMAND*
>> +
>> +*OPTIONS* := { |COMMON_OPTIONS| }
>> +
>> +*COMMANDS* := { **show** | **list** | **help** }
>> +
>> +TOKEN COMMANDS
>> +===============
>> +
>> +| **bpftool** **token** { **show** | **list** }
>> +| **bpftool** **token help**
>> +|
>> +
>> +DESCRIPTION
>> +===========
>> +bpftool token { show | list }
>> +    List all the concrete allowed_types for cmds maps progs attachs
>> +    and the bpffs mount_point used to set the token info.
> 
> 
> This is not a summary, please let's use a more verbose description and
> avoid abbreviations:
> 
> 	List all the concrete allowed types for **bpf**\ () system call
> 	commands, maps, programs, and attach types, as well as the
> 	*bpffs* mount point used to set the token information.
> 
> What is a "concrete" allowed_type?
> 

Uh... I wanted to say speciafic allowed_type, sorry for the poor english.
  > >> +
>> +bpftool prog help
>> +    Print short help message.
>> +
>> +OPTIONS
>> +========
>> +.. include:: common_options.rst
>> +
>> +EXAMPLES
>> +========
>> +|
>> +| **# mkdir -p /sys/fs/bpf/token**
>> +| **# mount -t bpf bpffs /sys/fs/bpf/token** \
>> +|         **-o delegate_cmds=prog_load:map_create** \
>> +|         **-o delegate_progs=kprobe** \
>> +|         **-o delegate_attachs=xdp**
>> +| **# bpftool token list**
>> +
>> +::
>> +
>> +    token_info:
>> +            /sys/fs/bpf/token
>> +
>> +    allowed_cmds:
>> +            map_create          prog_load
>> +
>> +    allowed_maps:
>> +
>> +    allowed_progs:
>> +            kprobe
>> +
>> +    allowed_attachs:
>> +            xdp
>> +
> 
> 
> Please also update bpftool's bash completion file. I think it should be:
> 

will add it in v2.

>      diff --git i/tools/bpf/bpftool/bash-completion/bpftool w/tools/bpf/bpftool/bash-completion/bpftool
>      index a759ba24471d..3f119d7eae96 100644
>      --- i/tools/bpf/bpftool/bash-completion/bpftool
>      +++ w/tools/bpf/bpftool/bash-completion/bpftool
>      @@ -1215,6 +1215,17 @@ _bpftool()
>                           ;;
>                   esac
>                   ;;
>      +        token)
>      +            case $command in
>      +                show|list)
>      +                    return 0
>      +                    ;;
>      +                *)
>      +                    [[ $prev == $object ]] && \
>      +                        COMPREPLY=( $( compgen -W 'help show list' -- "$cur" ) )
>      +                    ;;
>      +            esac
>      +            ;;
>           esac
>       } &&
>       complete -F _bpftool bpftool
> 
-- 
Best Regards
Tao Chen

