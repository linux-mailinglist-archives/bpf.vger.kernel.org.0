Return-Path: <bpf+bounces-64078-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89EADB0E16F
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 18:14:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22D683AD4AE
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 16:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEBC225F984;
	Tue, 22 Jul 2025 16:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="u7XxY05o"
X-Original-To: bpf@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D229627990B
	for <bpf@vger.kernel.org>; Tue, 22 Jul 2025 16:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753200863; cv=none; b=pjaeqB1VAeXX1eFi8tAs3aXP5ZLdXMGqUOyVyOYmpmcEKF9XpP05FS0eZAgitry8V+x213p6l/OQQ6v4Vg61gX3VriLEz2hw6sX10HB0OHLevVR5G+g6Ia5/cTMc74aSHao/dpAHoTBBM0g/nOA96wFsj0IyAYBXgxKWeIjNqgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753200863; c=relaxed/simple;
	bh=KTqkyyoOicoJI5BEkfd5qz62KvePx3hlSaBgQWM4Tq4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LcmRmaDXjcryJEwGTa9h5Zn7/8kJZPRXXYZ3cgzDqOPUHb1149ct10IhaEXzixUeBQPc205my5mwCl7r8G1rMAWJpNNArQWim6SJol9Dg8xosPKQnHX+lMudhZJYtpArPflG7uIQqkkbTl3W7/nfETSYS4hlNDseSRoH+OK5aAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=u7XxY05o; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <368d27ec-0102-4ccc-909c-7174a096c9fd@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753200859;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rlEPwS6XRbGjrFHOB795Y3ubFb0hkoLP9W6LkkEcoOQ=;
	b=u7XxY05o+p+ypP1rVpmOiWGf+HJesQEmvpglgsUNu1Qd1wdugqvk8PnRBpY84zbVkEbWoG
	L+9Nt9HtY+phnbLDivBFXHI1x2CymDQ6ge4cfdaSnOlPtSMuBSo+Rsgd3yGCUEnP96e87w
	VGxiTRJuTYGB6vNUhSuWk3BscFKx8/4=
Date: Wed, 23 Jul 2025 00:14:03 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 2/3] bpftool: Add bpftool-token manpage
To: Quentin Monnet <qmo@kernel.org>, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, davem@davemloft.net,
 kuba@kernel.org, hawk@kernel.org
Cc: linux-kernel@vger.kernel.org, bpf@vger.kernel.org, netdev@vger.kernel.org
References: <20250722120912.1391604-1-chen.dylane@linux.dev>
 <20250722120912.1391604-2-chen.dylane@linux.dev>
 <2e3a00c0-dc18-40d4-af2a-ce8df4e54021@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Tao Chen <chen.dylane@linux.dev>
In-Reply-To: <2e3a00c0-dc18-40d4-af2a-ce8df4e54021@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2025/7/22 23:01, Quentin Monnet 写道:
> 2025-07-22 20:09 UTC+0800 ~ Tao Chen <chen.dylane@linux.dev>
>> Add bpftool-token manpage with information and examples of token-related
>> commands.
>>
>> Signed-off-by: Tao Chen <chen.dylane@linux.dev>
>> ---
>>   .../bpftool/Documentation/bpftool-token.rst   | 63 +++++++++++++++++++
>>   1 file changed, 63 insertions(+)
>>   create mode 100644 tools/bpf/bpftool/Documentation/bpftool-token.rst
>>
>> diff --git a/tools/bpf/bpftool/Documentation/bpftool-token.rst b/tools/bpf/bpftool/Documentation/bpftool-token.rst
>> new file mode 100644
>> index 00000000000..c5fe9292258
>> --- /dev/null
>> +++ b/tools/bpf/bpftool/Documentation/bpftool-token.rst
>> @@ -0,0 +1,63 @@
>> +.. SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +
>> +================
>> +bpftool-token
>> +================
>> +-------------------------------------------------------------------------------
>> +tool for inspection and simple manipulation of eBPF tokens
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
>> +    List all the speciafic allowed types for **bpf**\ () system call
> 
> 
> Typo: "speciafic".
> 

will fix it, thanks.

> 
>> +    commands, maps, programs, and attach types, as well as the
>> +    *bpffs* mount point used to set the token information.
> 
> 
> This sentence needs to be adjusted now that you can print info for
> several mountpoints.
> 
> How about:
> 
>      List BPF token information for each *bpffs* mount point containing token
>      information on the system. Information include mount point path, allowed
>      **bpf**\ () system call commands, maps, programs, and attach types for the
>      token.
> 

This really looks better, thank you for your help.

> 
>> +
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
>> +    token_info  /sys/fs/bpf/token
>> +            allowed_cmds:
>> +              map_create          prog_load
>> +            allowed_maps:
>> +            allowed_progs:
>> +              kprobe
>> +            allowed_attachs:
>> +              xdp
> 


-- 
Best Regards
Tao Chen

