Return-Path: <bpf+bounces-22441-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D77DD85E493
	for <lists+bpf@lfdr.de>; Wed, 21 Feb 2024 18:30:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14A7E1C224F8
	for <lists+bpf@lfdr.de>; Wed, 21 Feb 2024 17:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52E3283CD7;
	Wed, 21 Feb 2024 17:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="Wbi6jkdu"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA53182D8F;
	Wed, 21 Feb 2024 17:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708536644; cv=none; b=g8LuG/gwI0UnIy0ilNShZucZOzd53i864m5apw6Iwm1kmUAalgWUoscs91wZTDXzzgI4UOVZ3eaHjC6cJasNRRRqet+iNh4UgGTCUMaiBMZ+v4Dgdje6YCkrp5hrtPo1bpELVUbhYNmXXTzefIWyjN8Vi78Zu+nqhZbhe6TBMbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708536644; c=relaxed/simple;
	bh=VVJKBus/4hY3nazwz3pZiLEtUFESTJ1fNiTVxhfAPy8=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=fM4QWwqusHPWuR64guH1A3efrUEKvGoTV2hf6QwWhtIbxyKJHSPtHI05wGN/01WX9XHMqAW3TMUZb2G7/YuSUCq7YBaJuDq1fKeXXX3cBVKaGrWc4zqaNoOM36K7kw/Yf0I5dnPBBKypgX/rwJDMwALkOVQAqThqrS5eQX/mM38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=Wbi6jkdu; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=I87YIZpurdfl8CTcBVVyeB1j4NeBVQcdCIaP0A3iopg=; b=Wbi6jkduFDxsAg3gq98PHpUcSq
	aPM+WXH/eyj6E6cMlenpE90+cdly1BVWqZB6ONVaiY8julWfqqoG3pUFl+AvtS7xqybQALkdyiCOo
	CrpduV0kwBnHP7w1Gvgch5neon/t/NXjK/tlNZVS07pUouiNswnCxjD9E1yMqrgCouzrEvUQrPdPC
	PvmbhlVxxThM7yvKKISOPzDuh4Z7w3ewE/LNdN/HqMkOSRwqdey/VluqZaJhG70tBSln8j4TL4IKe
	J8K250ppqDuGsZv87Q1bPknz68dtbZaAutZ01j6/Cxg/QAuaRWMs3tl9BP+p1AMPgMLRbm2StSITl
	Fns2ykmw==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1rcqQU-000DLL-Kx; Wed, 21 Feb 2024 18:30:34 +0100
Received: from [178.197.249.13] (helo=linux.home)
	by sslproxy01.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1rcqQT-003ehV-20;
	Wed, 21 Feb 2024 18:30:33 +0100
Subject: Re: [PATCH bpf-next 1/2] bpf: Take return from set_memory_ro() into
 account with bpf_prog_lock_ro()
To: Christophe Leroy <christophe.leroy@csgroup.eu>,
 Hengqi Chen <hengqi.chen@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Kees Cook <keescook@chromium.org>,
 "linux-hardening @ vger . kernel . org" <linux-hardening@vger.kernel.org>
References: <135feeafe6fe8d412e90865622e9601403c42be5.1708253445.git.christophe.leroy@csgroup.eu>
 <CAEyhmHT8H3AXyOKMc3eQSdM2+1UDETJDPyEQ0-AEb6E8pt9LTg@mail.gmail.com>
 <4d53e0f9-cfee-4877-8b56-9f258c8325f6@csgroup.eu>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <2abc14fc-a19e-8205-c54f-a87c11ebd5be@iogearbox.net>
Date: Wed, 21 Feb 2024 18:30:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <4d53e0f9-cfee-4877-8b56-9f258c8325f6@csgroup.eu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27192/Wed Feb 21 10:23:23 2024)

On 2/19/24 7:39 AM, Christophe Leroy wrote:
> 
> 
> Le 19/02/2024 à 02:40, Hengqi Chen a écrit :
>> [Vous ne recevez pas souvent de courriers de hengqi.chen@gmail.com. Découvrez pourquoi ceci est important à https://aka.ms/LearnAboutSenderIdentification ]
>>
>> Hello Christophe,
>>
>> On Sun, Feb 18, 2024 at 6:55 PM Christophe Leroy
>> <christophe.leroy@csgroup.eu> wrote:
>>>
>>> set_memory_ro() can fail, leaving memory unprotected.
>>>
>>> Check its return and take it into account as an error.
>>>
>>
>> I don't see a cover letter for this series, could you describe how
>> set_memory_ro() could fail.
>> (Most callsites of set_memory_ro() didn't check the return values)
> 
> Yeah, there is no cover letter because as explained in patch 2 the two
> patches are autonomous. The only reason why I sent it as a series is
> because the patches both modify include/linux/filter.h in two places
> that are too close to each other.
> 
> I should have added a link to https://github.com/KSPP/linux/issues/7
> See that link for detailed explanation.
> 
> If we take powerpc as an exemple, set_memory_ro() is a frontend to
> change_memory_attr(). When you look at change_memory_attr() you see it
> can return -EINVAL in two cases. Then it calls
> apply_to_existing_page_range(). When you go down the road you see you
> can get -EINVAL or -ENOMEM from that function or its callees.

By that logic, don't you have the same issue when undoing all of this?
E.g. take arch_protect_bpf_trampoline() / arch_unprotect_bpf_trampoline()
which is not covered in here, but what happens if you set it first to ro
and later the setting back to rw fails? How would the error path there
look like? It's something you cannot recover.

Thanks,
Daniel

