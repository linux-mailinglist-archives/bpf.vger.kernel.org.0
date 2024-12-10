Return-Path: <bpf+bounces-46502-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C215B9EB24D
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2024 14:54:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B8E5282406
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2024 13:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 123EC1AA1FB;
	Tue, 10 Dec 2024 13:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=laura.nao@collabora.com header.b="PXPTL8i7"
X-Original-To: bpf@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 081A322087;
	Tue, 10 Dec 2024 13:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733838887; cv=pass; b=qW6rjA8rgDywQ47QflBzrhDD8qlEA8T4Ilpn84cyQwo0wy0ZIqb7cj2iGNMgZleFsB+GA6MMCimvKEdn96mgxz4O8hFNXMYZbEmcJZ4USKn/6nXhrfYZm1SRXAmbLrTBAbUeZzNTVEu54/FZxFRI3mrqsYftapy2cST1lk9BLU4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733838887; c=relaxed/simple;
	bh=dst/ymbl8Rp99uil+6kvqc6lEF+yzYq7BByo2zD2l+o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Am/xvpL4FicoFibgiTw13H1lCSre8v+k80HS/AsaQWq0tJmA43kd11VkNlXEq/KpWOB/lUmIrgBna3+e26hDdR6H0aaMiaG6lXhjI6QOE/W52dbXcp9jrfXc76X5S2f4W/ZSVA5ym1STVihiYWm9eYjmrm3f8rggGNy8iVbqSaE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=laura.nao@collabora.com header.b=PXPTL8i7; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1733838869; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=YZAsY7L4zjav6r3vV8B8icXQzxtB/Hb2Jh0GluSm5J6jjalWCiHiFcpRXpLByoGdLvjuEgxfrDyIiEPwtqyw2hYnurEUou5lGWatA+HdoQ9z3G5Pos8YsUCNV8evKrtDu822pUSoCfSh4SJQTomRMMYvvGws/03vhgoHRA4wWs8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1733838869; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=YMmppZyizEstfKri+9ofz1mcWacCaY/jsGFVQd+cu04=; 
	b=hAmMBDdl7jW6Ssf+FsTeJG2kUM3GK6YEtN3Uibm0TEj9CGN+2ILFsOb4024YpGgyVqRSGJoPuW3ngDe37kOE8zrUT9zCE7hzOki3/ZKo2knRk9+//Sh1z4/lGzyi38k5gQ/M4OfVXjbDn83jZ+xXIwwuUqu76T3pSGkRqMpmNf4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=laura.nao@collabora.com;
	dmarc=pass header.from=<laura.nao@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1733838869;
	s=zohomail; d=collabora.com; i=laura.nao@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Reply-To;
	bh=YMmppZyizEstfKri+9ofz1mcWacCaY/jsGFVQd+cu04=;
	b=PXPTL8i76B99cQxhJqqbbRlwstoVGH2mtAe4ecvD7UkoxmyiHCUOfzr3lvEvvm2f
	f/0B4DVAwQ2TJICvzN+3nqoDqaVeF75kyWfjZHlU7dIkD6Eajsy8Hsh4jz4lFjoXPRN
	Rw1DdNb1NLewPZJW3bZWqQsJZMHn8JSQO8ofZ8t0=
Received: by mx.zohomail.com with SMTPS id 1733838867736641.1510856864684;
	Tue, 10 Dec 2024 05:54:27 -0800 (PST)
From: Laura Nao <laura.nao@collabora.com>
To: olsajiri@gmail.com
Cc: alan.maguire@oracle.com,
	bpf@vger.kernel.org,
	chrome-platform@lists.linux.dev,
	kernel@collabora.com,
	laura.nao@collabora.com,
	linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev
Subject: Re: [REGRESSION] module BTF validation failure (Error -22) on
Date: Tue, 10 Dec 2024 14:55:01 +0100
Message-Id: <20241210135501.251505-1-laura.nao@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <Z1LvfndLE1t1v995@krava>
References: <Z1LvfndLE1t1v995@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Hi Jiri,

Thanks for the feedback!

On 12/6/24 13:35, Jiri Olsa wrote:
> On Fri, Nov 15, 2024 at 06:17:12PM +0100, Laura Nao wrote:
>> On 11/13/24 10:37, Laura Nao wrote:
>>>
>>> Currently, KernelCI only retains the bzImage, not the vmlinux
>>> binary. The
>>> bzImage can be downloaded from the same link mentioned above by
>>> selecting
>>> 'kernel' from the dropdown menu (modules can also be downloaded the
>>> same
>>> way). I’ll try to replicate the build on my end and share the
>>> vmlinux
>>> with DWARF data stripped for convenience.
>>>
>>
>> I managed to reproduce the issue locally and I've uploaded the
>> vmlinux[1]
>> (stripped of DWARF data) and vmlinux.raw[2] files, as well as one of
>> the
>> modules[3] and its btf data[4] extracted with:
>>
>> bpftool -B vmlinux btf dump file cros_kbd_led_backlight.ko >
>> cros_kbd_led_backlight.ko.raw
>>
>> Looking again at the logs[5], I've noticed the following is reported:
>>
>> [    0.415885] BPF: 	 type_id=115803 offset=177920 size=1152
>> [    0.416029] BPF:
>> [    0.416083] BPF: Invalid offset
>> [    0.416165] BPF:
>>
>> There are two different definitions of rcu_data in '.data..percpu',
>> one
>> is a struct and the other is an integer:
>>
>> type_id=115801 offset=177920 size=1152 (VAR 'rcu_data')
>> type_id=115803 offset=177920 size=1152 (VAR 'rcu_data')
>>
>> [115801] VAR 'rcu_data' type_id=115572, linkage=static
>> [115803] VAR 'rcu_data' type_id=1, linkage=static
>>
>> [115572] STRUCT 'rcu_data' size=1152 vlen=69
>> [1] INT 'long unsigned int' size=8 bits_offset=0 nr_bits=64
>> encoding=(none)
>>
>> I assume that's not expected, correct?
> 
> yes, that seems wrong.. but I can't reproduce with your config
> together with pahole 1.24 .. could you try with latest one?

I just tested next-20241210 with the latest pahole version (1.28 from
the master branch[1]), and the issue does not occur with this version
(I can see only one instance of rcu_data in the BTF data, as expected).

I can confirm that the same kernel revision still exhibits the issue
with pahole 1.24.

If helpful, I can also test versions between 1.24 and 1.28 to identify
which ones work.

Thanks,

Laura

[1] https://git.kernel.org/pub/scm/devel/pahole/pahole.git

> 
> jirka
> 
>>
>> I'll dig a bit deeper and report back if I can find anything else.
>>
>> [1]
>> https://people.collabora.com/~laura.nao/dbg-btf-mismatch-next-20241113/vmlinux
>> [2]
>> https://people.collabora.com/~laura.nao/dbg-btf-mismatch-next-20241113/vmlinux.raw
>> [3]
>> https://people.collabora.com/~laura.nao/dbg-btf-mismatch-next-20241113/cros_kbd_led_backlight.ko
>> [4]
>> https://people.collabora.com/~laura.nao/dbg-btf-mismatch-next-20241113/cros_kbd_led_backlight.ko.raw
>> [5] https://pastebin.com/raw/FvvrPhAY
>>
>> Best,
>>
>> Laura
>>


