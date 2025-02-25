Return-Path: <bpf+bounces-52508-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E2C8A4414D
	for <lists+bpf@lfdr.de>; Tue, 25 Feb 2025 14:51:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E0E53B591D
	for <lists+bpf@lfdr.de>; Tue, 25 Feb 2025 13:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C753C26988C;
	Tue, 25 Feb 2025 13:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fT3K2jTe"
X-Original-To: bpf@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD782AF11
	for <bpf@vger.kernel.org>; Tue, 25 Feb 2025 13:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740491434; cv=none; b=AdTngp62Cy0FA0AsZZhB5B5mbZdxXfsSfgmLdVQDvGQZk5A9K9Y5TS2MEvbuUIcbkp8+tQEoHfQNaZDGoEqMzfsRR4so1J6Hqk9MO27Bk3gAl4b8Fi1zCSqH7QLoWkCaa74mPNNNCAdTBzNI8Lc2w8f4cAxZ499qBjDarXksTVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740491434; c=relaxed/simple;
	bh=vX46K+jCKSxOvIyi+hwWuxW2QdvD0i5rBgsDOn+4Qzc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EAfGuMzZ5NJrybbpyyIlM1cj8DSHg+AbXVbk48bpSG+X+xx7k4T9XRW8dVBq4JFtk+qIDnGRHkeLLPuprJTmpK+wjxshNLTAnKLrhubboBcSOJ18b8CPe2CR0ab6XOfTahZFJYI6nC1bCgr2kkms+1E2lI52vOn9KBfCm5G5BVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fT3K2jTe; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ebc973a9-2e61-4e3a-89e0-492823ded721@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740491430;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M/k8N0CQ0BerQ+X2864fL0JTRVq99i+a5ih7MzAWffQ=;
	b=fT3K2jTeArShfJHozi8eN3Fjeq4uEvxpmEG2ZidNQWOL8duGzcTkfuX6GMfCsUEvhYHh/c
	XJFKGsPJmz1+coiXn/+IW/RfUqu/Eub0yc+mxoxQrli28EptLSpFFYZyAsIcn3aLTpv9St
	sF4WV5ys2v2LwspOW+i2dcdpQIMSTQA=
Date: Tue, 25 Feb 2025 21:50:17 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v4 2/4] bpf: Improve error reporting for freplace
 attachment failure
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Song Liu <song@kernel.org>,
 Eddy Z <eddyz87@gmail.com>, Manjusaka <me@manjusaka.me>,
 kernel-patches-bot@fb.com
References: <20250224153352.64689-1-leon.hwang@linux.dev>
 <20250224153352.64689-3-leon.hwang@linux.dev>
 <CAADnVQKOeKfxL_3tCw1xWNS1CpXz-6pVUG-1UWhZwpPjRy+32A@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <CAADnVQKOeKfxL_3tCw1xWNS1CpXz-6pVUG-1UWhZwpPjRy+32A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 2025/2/25 03:41, Alexei Starovoitov wrote:
> On Mon, Feb 24, 2025 at 7:34 AM Leon Hwang <leon.hwang@linux.dev> wrote:
>>
>> @@ -3539,7 +3540,7 @@ static int bpf_tracing_prog_attach(struct bpf_prog *prog,
>>                  */
>>                 struct bpf_attach_target_info tgt_info = {};
>>
>> -               err = bpf_check_attach_target(NULL, prog, tgt_prog, btf_id,
>> +               err = bpf_check_attach_target(log, prog, tgt_prog, btf_id,
>>                                               &tgt_info);
> 
> I still don't like this uapi addition.
> 
> It only helps a rare corner case of freplace usage:
>                 /* If there is no saved target, or the specified target is
>                  * different from the destination specified at load time, we
>                  * need a new trampoline and a check for compatibility
>                  */
> 
> If it was useful in more than one case we could consider it,
> but uapi addition for a single rare use, is imo wrong trade off.
> 

Got it.

I'm planning to implement a restrict version of
"bpf: make tracing program support multi-link"[0]. With log buffer, it
will be helpful to report the reason for declining attaching, especially
to report the tracee info that causes the attachment failure.

[0]
https://lore.kernel.org/bpf/20240311093526.1010158-1-dongmenglong.8@bytedance.com/

Thanks,
Leon


