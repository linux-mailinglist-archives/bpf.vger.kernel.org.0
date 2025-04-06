Return-Path: <bpf+bounces-55372-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F2FDA7CD5D
	for <lists+bpf@lfdr.de>; Sun,  6 Apr 2025 11:00:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A66316D966
	for <lists+bpf@lfdr.de>; Sun,  6 Apr 2025 09:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27E2F19D8BC;
	Sun,  6 Apr 2025 08:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b="gYLcMJU0"
X-Original-To: bpf@vger.kernel.org
Received: from serv108.segi.ulg.ac.be (serv108.segi.ulg.ac.be [139.165.32.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E8C1CA81;
	Sun,  6 Apr 2025 08:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.165.32.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743929996; cv=none; b=QyLS19s6McNyy7Umgkpe4HHo2dmdDBDdwB/HuhnotoerCsJat5nevTn0cq6HiJWb7zGPTPV0IKw+g7bGe2IBl7AmOWyM2fi+amiJLvF6HMUFzcNiA2vQJSuer71SWqFm0xL+3UGLyH7ZLo3iVCnzysEVWJsgyPqKnD2dFrtvf14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743929996; c=relaxed/simple;
	bh=znUiQ7nEvQsIIRG/t14PN6fPEKSI1DMQVqiqgCnShPQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oVcgm/eeZTQ+DHr6lhQYBKj9cUttQFvcBG9IXUa3lGOLQe2sJC0h1n0pgYBwP6TmLRQ4/AvYo1SQUxh4J49jBSE8CU3Yxwdz4CqlXL6//1yIyC1U9eArQVJsaPSVX+ySmzCzyVUvbCUwFuD0CrDkU4csrgjqi5+sf+wtdCNYncM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be; spf=pass smtp.mailfrom=uliege.be; dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b=gYLcMJU0; arc=none smtp.client-ip=139.165.32.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uliege.be
Received: from [192.168.1.27] (220.24-245-81.adsl-dyn.isp.belgacom.be [81.245.24.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by serv108.segi.ulg.ac.be (Postfix) with ESMTPSA id EE74E200CCE5;
	Sun,  6 Apr 2025 10:59:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 serv108.segi.ulg.ac.be EE74E200CCE5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uliege.be;
	s=ulg20190529; t=1743929986;
	bh=Wd0TkGpUOfwJghLvDFQAWDgju4Zck/CVHBum3JMhe/0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gYLcMJU05bMVfZYtPKIGJM82LEA37v7GhiTBzwqE0iQxaNxclFY4wQriZrdZ1OkZo
	 y2ceIoxjefLBfdYbBBa0p82hYuRuZNaDCF8DByx2h6NfMQRoRK7AxME09hDal2gWVw
	 GitILXT70aUXijCu5/0yA7CMGrKV7P/WVuggLXDkxYxMkDHvRqKb5SpkRnCG/vGedj
	 Yn3IDhrsVBS8i0OAxnoXtiYLN4VtlQi3PtU/8tCIxK/JlvlbuOLvoVASHoMsP6uXXZ
	 mSHRNIJkzcVZYIL/6Xugw8brN97a1ZNj71/scJAggGoxjL0IIOQtrG9V5j4zPuY9ax
	 lELNnQHZGbBgA==
Message-ID: <85eefdd9-ec5d-4113-8a50-5d9ea11c8bf5@uliege.be>
Date: Sun, 6 Apr 2025 10:59:45 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: lwtunnel: disable preemption when required
To: Sebastian Sewior <bigeasy@linutronix.de>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Stanislav Fomichev <stfomichev@gmail.com>,
 Network Development <netdev@vger.kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
 bpf <bpf@vger.kernel.org>
References: <20250403083956.13946-1-justin.iurman@uliege.be>
 <Z-62MSCyMsqtMW1N@mini-arch> <cb0df409-ebbf-4970-b10c-4ea9f863ff00@uliege.be>
 <CAADnVQLiM5MA3Xyrkqmubku6751ZPrDk6v-HmC1jnOaL47=t+g@mail.gmail.com>
 <20250404141955.7Rcvv7nB@linutronix.de>
Content-Language: en-US
From: Justin Iurman <justin.iurman@uliege.be>
In-Reply-To: <20250404141955.7Rcvv7nB@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/4/25 16:19, Sebastian Sewior wrote:
> Alexei, thank you for the Cc.
> 
> On 2025-04-03 13:35:10 [-0700], Alexei Starovoitov wrote:
>> Stating the obvious...
>> Sebastian did a lot of work removing preempt_disable from the networking
>> stack.
>> We're certainly not adding them back.
>> This patch is no go.
> 
> While looking through the code, it looks as if lwtunnel_xmit() lacks a
> local_bh_disable().

Thanks Sebastian for the confirmation, as the initial idea was to use 
local_bh_disable() as well. Then I thought preempt_disable() would be 
enough in this context, but I didn't realize you made efforts to remove 
it from the networking stack.

@Alexei, just to clarify: would you ACK this patch if we do 
s/preempt_{disable|enable}()/local_bh_{disable|enable}()/g ?

> Sebastian

