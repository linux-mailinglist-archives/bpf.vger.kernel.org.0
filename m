Return-Path: <bpf+bounces-64081-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 52BD6B0E209
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 18:38:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E807C1C822B9
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 16:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A1CF27D776;
	Tue, 22 Jul 2025 16:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oZfSsKoX"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A5A27A45C;
	Tue, 22 Jul 2025 16:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753202266; cv=none; b=otkuERChlBDBM2amACL2llLEjcBjrruMVWcBgKlsEHy7g5NYaP7uNywoHtyKxfu2ltAkbRp86CYZCGQxfWlO/gzPwztzHw6fRrMBwk51YDKdComBdOtK0eI3NZLNBBqzGis9u/NCItQfOwdDRotro2jzJBx2BmT4R2w2N/PM8ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753202266; c=relaxed/simple;
	bh=PSZCZlgLDHJeFiBgv9CV8RQ8XZNfkVSfhfmiSDoXa44=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LVZvejGQnfhNnlHXVrg4wdZRsHXigqFerslci9fA8Uggsvm8zSrTpfZOwcN55VcMek+2Es6H+jKizia10u0g4qDxBeKC1WOo8Co5AneJSHgKK8MYE8hnRt1FOSwp1ZbwbPHBJBpIwBr2E60h+KequTWVY5CH7U0fuconQBiFcMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oZfSsKoX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0E55C4CEEB;
	Tue, 22 Jul 2025 16:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753202264;
	bh=PSZCZlgLDHJeFiBgv9CV8RQ8XZNfkVSfhfmiSDoXa44=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=oZfSsKoXODVUKw718g6ksG32T860olqq3DnOSR06GTiOm2O/Q8gb1zWKGKLri2agd
	 ImdWCXs9tdsqWIXl0nzdi5CApPwT5ILPHFUlr3+WbNmWVbE7e2ZdMwe9R9AHe31tki
	 wvW5o/uoqLr/QKx1HriBXGqpRrlivRd3vGx2wid1hhLEp0XPkDL4SeclMZFIxOpUqJ
	 XwdeJCOikLleX6EWVMuOiWdH9Nqaj//sFtVMSHet6ppZbxMMZphMKB3wsnBZ6HK+Eq
	 0TFjeGiqFl8QcYpu6SQKHfvelstWsYoj5S/e3gk9BvRMqLT92/OkDYqYd8huwLQ448
	 Vc5YK5AjLWCvg==
Message-ID: <50872d17-fd8a-4f84-826b-62c08c7d304a@kernel.org>
Date: Tue, 22 Jul 2025 17:37:40 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 3/3] bpftool: Add bash completion for token
 argument
To: Tao Chen <chen.dylane@linux.dev>, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, davem@davemloft.net,
 kuba@kernel.org, hawk@kernel.org
Cc: linux-kernel@vger.kernel.org, bpf@vger.kernel.org, netdev@vger.kernel.org
References: <20250722120912.1391604-1-chen.dylane@linux.dev>
 <20250722120912.1391604-3-chen.dylane@linux.dev>
 <ba84629f-5675-4793-9320-25d9029d2a35@kernel.org>
 <5681662e-6038-433f-9da7-438b383621b7@linux.dev>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <5681662e-6038-433f-9da7-438b383621b7@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

2025-07-23 00:35 UTC+0800 ~ Tao Chen <chen.dylane@linux.dev>
> 在 2025/7/22 23:02, Quentin Monnet 写道:
>> 2025-07-22 20:09 UTC+0800 ~ Tao Chen <chen.dylane@linux.dev>
>>> This commit updates the bash completion script with the new token
>>> argument.
>>> $ bpftool
>>> batch       cgroup      gen         iter        map        
>>> perf        struct_ops
>>> btf         feature     help        link        net        
>>> prog        token
>>
>>
>> This is a terrible example, offering "token" as completion for just
>> "bpftool [tab]" works without this patch :) The main commands are parsed
>> from the output of "bpftool help" so it should work after your first
>> patch. In this one, we add "list", "show" and "help" for completing
>> "bpftool token [tab]".
>>
> 
> As you said, how about this one? I will change it in v3, thanks.
>     $ bpftool token
>     help  list  show

Yes, perfect

