Return-Path: <bpf+bounces-46557-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FDA59EBA8D
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2024 21:02:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B19661885D3E
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2024 20:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE56222687B;
	Tue, 10 Dec 2024 20:02:06 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B74523ED5A;
	Tue, 10 Dec 2024 20:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733860926; cv=none; b=V9ayZTd8b/0ki+iv5/Ak+2eW/W9drB7YC5GfRcgnLGktWiINSsH5RkBukbQ77gKpjUYsVNfviPLUJS6K1p+YSCd/hFnwnfzU3geKgUJmB3YcO4+IgxFSpwWqdfOMhXEkftigBYwV2hBCU7on/c2j6t7eV2JGp/uYkm8oA47CVVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733860926; c=relaxed/simple;
	bh=I0Qj8NxUTp9f5YV1tI1BPeHC0ggLDs4Lt1mSXAMS8yQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eV8hhmNudhiCTCv++dvDh4GwDS8USHJSUV7g75SrKwEM55segb74bddlj/V/J9+8jXVPvu4+WZzNKRLLM06Opd3rIf+tPKHMg2dBpP55SM6hSuxRhdJrJuplqCYSb/K9Au5rMlP95qEOVtXHan6qS8+wQt1J8lRUHiyVwXlZlw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4Y78l81GySz9tMX;
	Tue, 10 Dec 2024 21:01:56 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Agk6G1NcVLjd; Tue, 10 Dec 2024 21:01:56 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4Y78l76Llsz9tMW;
	Tue, 10 Dec 2024 21:01:55 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id A260A8B778;
	Tue, 10 Dec 2024 21:01:55 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id 7E9cnDt9W5q9; Tue, 10 Dec 2024 21:01:55 +0100 (CET)
Received: from [192.168.232.97] (unknown [192.168.232.97])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 196DA8B763;
	Tue, 10 Dec 2024 21:01:54 +0100 (CET)
Message-ID: <364aaf7c-cdc4-4e57-bb4c-f62e57c23279@csgroup.eu>
Date: Tue, 10 Dec 2024 21:01:53 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] kallsyms: Emit symbol for holes in text and fix
 weak function issue
To: Martin Kelly <martin.kelly@crowdstrike.com>,
 "masahiroy@kernel.org" <masahiroy@kernel.org>,
 "ojeda@kernel.org" <ojeda@kernel.org>,
 "jpoimboe@kernel.org" <jpoimboe@kernel.org>,
 "pasha.tatashin@soleen.com" <pasha.tatashin@soleen.com>,
 "mhiramat@kernel.org" <mhiramat@kernel.org>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "james.clark@arm.com" <james.clark@arm.com>,
 "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
 "mathieu.desnoyers@efficios.com" <mathieu.desnoyers@efficios.com>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "mingo@redhat.com" <mingo@redhat.com>,
 "rostedt@goodmis.org" <rostedt@goodmis.org>,
 "nathan@kernel.org" <nathan@kernel.org>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 "christophe.leroy@csgroup.eu" <christophe.leroy@csgroup.eu>,
 "nicolas@fjasle.eu" <nicolas@fjasle.eu>,
 "surenb@google.com" <surenb@google.com>,
 "npiggin@gmail.com" <npiggin@gmail.com>,
 "mark.rutland@arm.com" <mark.rutland@arm.com>, "hpa@zytor.com"
 <hpa@zytor.com>, "peterz@infradead.org" <peterz@infradead.org>,
 "zhengyejian@huaweicloud.com" <zhengyejian@huaweicloud.com>,
 "naveen.n.rao@linux.ibm.com" <naveen.n.rao@linux.ibm.com>,
 "bp@alien8.de" <bp@alien8.de>,
 "kent.overstreet@linux.dev" <kent.overstreet@linux.dev>,
 "mcgrof@kernel.org" <mcgrof@kernel.org>
Cc: Amit Dang <amit.dang@crowdstrike.com>,
 "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
 "linux-kbuild@vger.kernel.org" <linux-kbuild@vger.kernel.org>,
 "x86@kernel.org" <x86@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
 "linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>
References: <20240723063258.2240610-1-zhengyejian@huaweicloud.com>
 <44353f4cd4d1cc7170d006031819550b37039dd2.camel@crowdstrike.com>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <44353f4cd4d1cc7170d006031819550b37039dd2.camel@crowdstrike.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

Le 10/12/2024 à 20:15, Martin Kelly a écrit :
> [Vous ne recevez pas souvent de courriers de martin.kelly@crowdstrike.com. Découvrez pourquoi ceci est important à https://aka.ms/LearnAboutSenderIdentification ]
> 
> On Tue, 2024-07-23 at 14:32 +0800, Zheng Yejian wrote:
>> Background of this patch set can be found in v1:
>>
>> https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Fall%2F20240613133711.2867745-1-zhengyejian1%40huawei.com%2F&data=05%7C02%7Cchristophe.leroy%40csgroup.eu%7Cbc4f27151ef04b74fba608dd194f0034%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C638694550404456289%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C80000%7C%7C%7C&sdata=a5XFKy9qxVrM5yXuvJuilJ%2FsUxU4j326MOmEz7dBViY%3D&reserved=0
>>
>>
>> Here add a reproduction to show the impact to livepatch:
>> 1. Add following hack to make livepatch-sample.ko do patch on
>> do_one_initcall()
>>     which has an overriden weak function behind in vmlinux, then print
>> the
>>     actually used __fentry__ location:
>>
> 
> Hi all, what is the status of this patch series? I'd really like to see
> it or some other fix to this issue merged. The underlying bug is a
> significant one that can cause ftrace/livepatch/BPF fentry to fail
> silently. I've noticed this bug in another context[1] and realized
> they're the same issue.
> 
> I'm happy to help with this patch series to address any issues as
> needed.

As far as I can see there are problems on build with patch 1, see 
https://patchwork.kernel.org/project/linux-modules/patch/20240723063258.2240610-2-zhengyejian@huaweicloud.com/

> 
> [1]
> https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Fbpf%2F7136605d24de9b1fc62d02a355ef11c950a94153.camel%40crowdstrike.com%2FT%2F%23mb7e6f84ac90fa78989e9e2c3cd8d29f65a78845b&data=05%7C02%7Cchristophe.leroy%40csgroup.eu%7Cbc4f27151ef04b74fba608dd194f0034%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C638694550404477455%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C80000%7C%7C%7C&sdata=v9qPnj%2FDDWAuSdB6dP19nyxUWijxveymI6mQb63KxbY%3D&reserved=0

Christophe



