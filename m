Return-Path: <bpf+bounces-28132-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 538298B604A
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 19:40:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 856141C2212D
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 17:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95BC01272B2;
	Mon, 29 Apr 2024 17:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="brnwMV9e"
X-Original-To: bpf@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9033126F0A
	for <bpf@vger.kernel.org>; Mon, 29 Apr 2024 17:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714412451; cv=none; b=lzMkOGMdk4IV4rKhP2oCw3j2BbzpSZZDgBPSiADUgVXYncoMyUKKLyPEY9YCaMtXzs495vLFpefvne8rvCDccODa4XAEKeFrTRNGTszLGYSTuO3qfENXteaoghDZv9XPYERrggLic/YxdEmb2xiF8J9or+7e7pCHE9QoaC8GtRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714412451; c=relaxed/simple;
	bh=3xTlTJjhRm3cXyQ8UM6bBL/hXQ1YAqOG9nl56uUW6Wo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BpDz0ExHc13ad9UWLptdASgsZhM9rTDVIXeiYlexfqJVDbAvOBqjsUoZZpoNkaQ0BlvOb9zo+5cLXI0IEQk5mwjL5qMvPpaFpiRPZh3vaSZR9ElbOZ32mbSK2CUIVEL+3a3v54X7zYnrcQMFVRyfQH+2E98DCmG8RPSBZF1ZVE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=brnwMV9e; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <62e430de-46ff-4eac-b8ba-408cb8eefac7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714412447;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+iDHGxBqKd8OEix+628lJvy5ZJIFKICpft6C1hJLvu0=;
	b=brnwMV9eoxOHdfyB/SKbUvFB9xJydfOgW9G/imP6Ne/3njy5UWV9Z7sXBLff3aVT4Eb0T+
	dm1DJaCU+fGYM4duxHdFVnEKto0fRNMG7K50ip06BZL39vLdWl6YrDIpXB27Nk+P1ApCVi
	D7mrAi16NJKmlwUqR/vVmAFJLKWljeQ=
Date: Mon, 29 Apr 2024 10:40:40 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 bpf-next 4/6] selftests/bpf: Add IPv4 and IPv6 sockaddr
 test cases
To: Jordan Rife <jrife@google.com>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 netdev@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
 Shuah Khan <shuah@kernel.org>, Kui-Feng Lee <thinker.li@gmail.com>,
 Artem Savkov <asavkov@redhat.com>, Dave Marchevsky <davemarchevsky@fb.com>,
 Menglong Dong <imagedong@tencent.com>, Daniel Xu <dxu@dxuuu.xyz>,
 David Vernet <void@manifault.com>, Daan De Meyer <daan.j.demeyer@gmail.com>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
References: <20240412165230.2009746-1-jrife@google.com>
 <20240412165230.2009746-5-jrife@google.com>
 <3df13496-a644-4a3a-9f9b-96ccc070f2a3@linux.dev>
 <CADKFtnQDJbSFRS4oyEsn3ZBDAN7T6EvxXUNdrz1kU3Bnhzfgug@mail.gmail.com>
 <f164369a-2b6b-45e0-8e3e-aa0035038cb6@linux.dev>
 <CADKFtnQHy0MFeDNg6x2gzUJpuyaF6ELLyMg3tTxze3XV28qo7w@mail.gmail.com>
 <8c9e51b2-5401-4d58-a319-ed620fadcc63@linux.dev>
 <CADKFtnQ7L_CSq+CzAOt3PM_Jz2mboGe+Si2TPByt=DuL5Nu=1g@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <CADKFtnQ7L_CSq+CzAOt3PM_Jz2mboGe+Si2TPByt=DuL5Nu=1g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 4/28/24 10:47 AM, Jordan Rife wrote:
>> Also, all this setup (and test) has to be done in a new netns. Anything blocking
>> the kfunc in patch 2 using the current task netns instead of the init_net?
>> Add nodad to the "ip -6 addr add...". just in case it may add unnecessary delay.
>> This interface/address ping should not be needed. Other tests under prog_tests/
>> don't need this interface/address ping also.
> 
> I was able to make these changes.
> 
>> Does it need a veth pair? The %s2 interface is not used.
>>
>> Can it be done in lo alone?
> 
> I think it may be better to keep it as-is for now with the veth pair.
> It turns out that these BPF programs (progs/bind6_prog.c,
> progs/bind4_prog.c, and progs/connect4_prog.c) expect the veth pair
> setup with these names (test_sock_addr1, test_sock_addr2). We may be
> able to update the logic in these BPF programs to allow us to just use
> lo, but I'm not sure if we'd be losing out on important test coverage.
> Additionally, since we aren't fully retiring test_sock_addr.c yet we'd
> also need to change test_sock_addr.sh if we changed
> progs/bind6_prog.c, progs/bind4_prog.c, and progs/connect4_prog.c. If
> there are no objections to leaving things as-is here, I will send out
> v3 with the rest of the changes listed above.

Yep, the veth cleanup could be done when the test_sock_addr.c is fully retired. 
Thanks for checking.

For the tests that moved to sock_addr.c, please also remove them from 
test_sock_addr.c.

