Return-Path: <bpf+bounces-52509-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BFB15A44198
	for <lists+bpf@lfdr.de>; Tue, 25 Feb 2025 15:02:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F026A16A9A4
	for <lists+bpf@lfdr.de>; Tue, 25 Feb 2025 14:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2685526A091;
	Tue, 25 Feb 2025 13:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KrwhNbdM"
X-Original-To: bpf@vger.kernel.org
Received: from out-175.mta0.migadu.com (out-175.mta0.migadu.com [91.218.175.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C98269CEC
	for <bpf@vger.kernel.org>; Tue, 25 Feb 2025 13:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740491961; cv=none; b=FavWzdovkTjF7gK+TWWhJMnc/wxHDiHh3q6SNFEDQur9+loVTVGd/6kgMoDwMQq59EgGAhrvSimp+bWXGiKmllx0LojTFr767ifJxUMVhxuvRavP1AfiBZBLSCZbw3SgHU14r4zLL4NKVNvYxH8d8JEO1WXyuXOgigqG5h5koaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740491961; c=relaxed/simple;
	bh=hg16TLwQbJWsZVy3UJV4JhmcAM4CbHfhHMv9GyWWVtE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dQ6CC+Lx/6z8RRVuMwr9ErsAVEcA1xaHeKTcGVPApt2K9edFbWx+j5vYkic+kn0cJTadKtpG0lqQvGUHGGqJgLdEHGf2H+1/B3lXTIZUgmpiRdAh5zGWekQQmo8D0+3sFSMv1Y18fHgvIDEmmp8TNEDqlHKCuTifONTU3gxtWso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KrwhNbdM; arc=none smtp.client-ip=91.218.175.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f6a428a0-9016-4c38-b03f-f47504d08826@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740491956;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dN7lZEN0TfVY1w2Wt2zDFPFUKtAnZ+UdwmCJjuDzP9k=;
	b=KrwhNbdMb5L6cFEisqz6cAo+8icYgm53cLxTktrJtqqjPorEmSbiR8GndoZZ5XMu0JeG2b
	JJDndUcILUvLw1Yd18KWz8iueFt5J++Url3SbNt4XjfPXDID92SPjxz8L1CBnxC0ILJyw3
	agpSNJ417MQn+9XqsThwCzBSiFOKuwo=
Date: Tue, 25 Feb 2025 21:59:03 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v4 2/4] bpf: Improve error reporting for freplace
 attachment failure
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Song Liu <song@kernel.org>,
 Eddy Z <eddyz87@gmail.com>, Manjusaka <me@manjusaka.me>,
 kernel-patches-bot@fb.com
References: <20250224153352.64689-1-leon.hwang@linux.dev>
 <20250224153352.64689-3-leon.hwang@linux.dev>
 <CAADnVQKOeKfxL_3tCw1xWNS1CpXz-6pVUG-1UWhZwpPjRy+32A@mail.gmail.com>
 <CAEf4BzaE+sRmnPMN_ePQ1sa7wHuRNn9zktu85Z5=BRyyVEXM=A@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <CAEf4BzaE+sRmnPMN_ePQ1sa7wHuRNn9zktu85Z5=BRyyVEXM=A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 2025/2/25 06:08, Andrii Nakryiko wrote:
> On Mon, Feb 24, 2025 at 11:41 AM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
>>
>> On Mon, Feb 24, 2025 at 7:34 AM Leon Hwang <leon.hwang@linux.dev> wrote:
>>>
>>> @@ -3539,7 +3540,7 @@ static int bpf_tracing_prog_attach(struct bpf_prog *prog,
>>>                  */
>>>                 struct bpf_attach_target_info tgt_info = {};
>>>
>>> -               err = bpf_check_attach_target(NULL, prog, tgt_prog, btf_id,
>>> +               err = bpf_check_attach_target(log, prog, tgt_prog, btf_id,
>>>                                               &tgt_info);
>>
>> I still don't like this uapi addition.
>>
>> It only helps a rare corner case of freplace usage:
>>                 /* If there is no saved target, or the specified target is
>>                  * different from the destination specified at load time, we
>>                  * need a new trampoline and a check for compatibility
>>                  */
>>
>> If it was useful in more than one case we could consider it,
>> but uapi addition for a single rare use, is imo wrong trade off.
> 
> Agreed. I think the idea of verbose log is useful for bpf() syscall,
> given how complicated some of its conditions are. But it should be
> done more generically, ideally at syscall (or at least the entire BPF
> command) level, not for one particular kind of link.
> 

Cool!

But, how can we achieve it?

Thanks,
Leon


