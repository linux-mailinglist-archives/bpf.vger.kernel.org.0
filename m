Return-Path: <bpf+bounces-54328-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A35AA6779D
	for <lists+bpf@lfdr.de>; Tue, 18 Mar 2025 16:22:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E2813B35C5
	for <lists+bpf@lfdr.de>; Tue, 18 Mar 2025 15:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 881B820E6F9;
	Tue, 18 Mar 2025 15:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="u58P+tRC"
X-Original-To: bpf@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C0820DD7B
	for <bpf@vger.kernel.org>; Tue, 18 Mar 2025 15:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742311232; cv=none; b=czn915iYDcyBhY1tsfFwzePJ0dWmRHxHL7aOda4yEiH/ozhR/BsqxAAo5gwMyT7xppOT8EjptanxTQq86CbnpIQhSUlZGEFFXASCiBqqvxKz2K2QwovCh/IGQUZtG1dODH+IelLR2gKKcUDMcVklDOy7r18p80110UgiiUWET+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742311232; c=relaxed/simple;
	bh=/Nf2WgEB7ZxfmF5hTBb2omhK58IQDRjvAppogOSWPjQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pYds6O+b9FSOXZb7PknE5Ru/Ayu5SUhg09BY+Ku3LOzyag5d4hoGbe0HY/7pIP4fwW/Z9D8XnDri8eVA434BPVAJQV53uV9U5zy0+ld9hQUqvq7XPsEombCk6VVtq25LYTGaHYfxsnANLHTzBRF532Rd4LbKLyurombuPW6Vn+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=u58P+tRC; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <0e3bd726-f0d8-4e50-832f-5a341486632f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1742311218;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kc5eGOqSPSf6D9ZMVn/2teA8AR7WkwdTnTP3LraKcT4=;
	b=u58P+tRCkN4eQaFqUlo8SuHKApGsIDIz2HadIKE6k4jIMtEQ6CpxQ/MdpV20qMYB4fxeNp
	UbZnui++HsRt5/SP/4sdJu4X9ZLgdYmZrH872/S+MyJ+CTvtUjlbynLWG96MBOOcmbXalG
	BtNxr90IrOV4qWHBmBCCkARK65OHvRE=
Date: Tue, 18 Mar 2025 23:20:06 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] bpf: Define bpf_token_show_fdinfo with
 CONFIG_PROC_FS
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Jiri Olsa <olsajiri@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eddy Z <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Christian Brauner <brauner@kernel.org>, bpf <bpf@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
References: <20250318062557.3001333-1-chen.dylane@linux.dev>
 <Z9k8216IwpMZnHaA@krava>
 <CAADnVQLULbENAnJqOVn4m_xmS+T7FvYSFf70mxVSdusgL85m8Q@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Tao Chen <chen.dylane@linux.dev>
In-Reply-To: <CAADnVQLULbENAnJqOVn4m_xmS+T7FvYSFf70mxVSdusgL85m8Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2025/3/18 22:59, Alexei Starovoitov 写道:
> On Tue, Mar 18, 2025 at 2:29 AM Jiri Olsa <olsajiri@gmail.com> wrote:
>>
>> On Tue, Mar 18, 2025 at 02:25:57PM +0800, Tao Chen wrote:
>>> Protect bpf_token_show_fdinfo with CONFIG_PROC_FS check, follow the
>>> pattern used with other *_show_fdinfo functions.
>>>
>>> Fixes: 35f96de04127 ("bpf: Introduce BPF token object")
>>> Signed-off-by: Tao Chen <chen.dylane@linux.dev>
>>> ---
>>>   kernel/bpf/token.c | 4 ++++
>>>   1 file changed, 4 insertions(+)
>>>
>>> diff --git a/kernel/bpf/token.c b/kernel/bpf/token.c
>>> index 26057aa13..104ca37e9 100644
>>> --- a/kernel/bpf/token.c
>>> +++ b/kernel/bpf/token.c
>>> @@ -65,6 +65,7 @@ static int bpf_token_release(struct inode *inode, struct file *filp)
>>>        return 0;
>>>   }
>>>
>>> +#ifdef CONFIG_PROC_FS
>>>   static void bpf_token_show_fdinfo(struct seq_file *m, struct file *filp)
>>>   {
>>>        struct bpf_token *token = filp->private_data;
>>> @@ -98,6 +99,7 @@ static void bpf_token_show_fdinfo(struct seq_file *m, struct file *filp)
>>>        else
>>>                seq_printf(m, "allowed_attachs:\t0x%llx\n", token->allowed_attachs);
>>>   }
>>> +#endif
>>>
>>>   #define BPF_TOKEN_INODE_NAME "bpf-token"
>>>
>>> @@ -105,7 +107,9 @@ static const struct inode_operations bpf_token_iops = { };
>>>
>>>   static const struct file_operations bpf_token_fops = {
>>>        .release        = bpf_token_release,
>>> +#ifdef CONFIG_PROC_FS
>>>        .show_fdinfo    = bpf_token_show_fdinfo,
>>> +#endif
>>
>> there's many more of such cases.. I'm not sure if it makes sense to fix that,
>> because it does not break the build and only save space for !CONFIG_PROC_FS
>> kernels
> 
> +1.
> let's keep the code as-is.
> 

Got it, thanks anyway.

> pw-bot: cr


-- 
Best Regards
Tao Chen

