Return-Path: <bpf+bounces-44975-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F4DB9CF3E2
	for <lists+bpf@lfdr.de>; Fri, 15 Nov 2024 19:25:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27C44B354F6
	for <lists+bpf@lfdr.de>; Fri, 15 Nov 2024 17:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDB421D5CEE;
	Fri, 15 Nov 2024 17:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=laura.nao@collabora.com header.b="aWZvqBfj"
X-Original-To: bpf@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B195E1AF4F6;
	Fri, 15 Nov 2024 17:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731691009; cv=pass; b=Wm4CQ/UUk7ChBQ8noyUHcENJkKoPdy4e5mHuvdKZOYyO//pABiuahNxRvrHSK99El8WH/u3u/G9cYAs9fBR/DPVnV7QY4p8YL03IOrFnXHjmNvp8ZMnYzakQghs9yDWNTkEEjr7WMqsYfUgoMjkmRR/cIPGgJUAqXsHKYEfOgEk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731691009; c=relaxed/simple;
	bh=P0SQjPygdVinvsaRou1De9yferdgwM0vFg9ryprllw8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jmGtAFwJUyl2wjOi6+hgjHibrgJ+wOfPUDt/doGV+vXIEJA1t5qzuU9HbIgVNAz1BF4pvm/QC/fbZzKk2qh5NuCGtiaJF7HUP221j39lXpdl4CUeLxrM46RHnq7PmV0Z0uROlqK28/Q9ENLbHYiU8Xj8OIzQMErOldu+OX14WIE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=laura.nao@collabora.com header.b=aWZvqBfj; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1731690995; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=jqnKaI6QCOuaeC7MpZ5upuw8KUCDmfB2amcnEqgRxBX/I5TgvB3f8Ej3Gm2yKK3sg3qHhoDTWFi6E2TZvZCp6nHaNAsOMdY3uyViar7qiYz7v5ExKefT7GxNjkXXo1wK3YkOmo+EXXnVy7afLl6F/1LTKfboDfYiGiyHCdmyfN0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1731690995; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=QY5aEW+CUnaNR5nMd8AVnCRFH1PuLn6ppZIhLRBH7IY=; 
	b=eOgjuQbNFoBrx9ThpRSWxMsNcWx3yRXYidMff5btzfWwBGzJvv/+d+wcEryLIJt8UqgpLGTYT+NjHzIExHAj+UTfLiCxmSqvAnIRiGF38D1HkVzmze/5cJ3ei/nBpflZRhOr9ddPNrZSO5M8m94NCycuzp20MyLmOlvSW3NnTvM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=laura.nao@collabora.com;
	dmarc=pass header.from=<laura.nao@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1731690995;
	s=zohomail; d=collabora.com; i=laura.nao@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Reply-To;
	bh=QY5aEW+CUnaNR5nMd8AVnCRFH1PuLn6ppZIhLRBH7IY=;
	b=aWZvqBfj/Op+zoZylP9l3vWpJV5sYl4XG0ZSGf3PTheg1u5gP4JBCNwwo/cWx1GA
	noTreI398wKve86/zb5IrIk18CC/tN3ytfnCEM2crKlMTwtAgfqlVtobzhewcn+pwUx
	w8aP/R1oa8jVDODDIp3Yy9m/M+morlNomTWpGOJA=
Received: by mx.zohomail.com with SMTPS id 1731690993371333.3476507920801;
	Fri, 15 Nov 2024 09:16:33 -0800 (PST)
From: Laura Nao <laura.nao@collabora.com>
To: laura.nao@collabora.com,
	alan.maguire@oracle.com
Cc: bpf@vger.kernel.org,
	chrome-platform@lists.linux.dev,
	kernel@collabora.com,
	linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev
Subject: Re: [REGRESSION] module BTF validation failure (Error -22) on next
Date: Fri, 15 Nov 2024 18:17:12 +0100
Message-Id: <20241115171712.427535-1-laura.nao@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20241113093703.9936-1-laura.nao@collabora.com>
References: <20241113093703.9936-1-laura.nao@collabora.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

On 11/13/24 10:37, Laura Nao wrote:
> 
> Currently, KernelCI only retains the bzImage, not the vmlinux binary. The
> bzImage can be downloaded from the same link mentioned above by selecting
> 'kernel' from the dropdown menu (modules can also be downloaded the same
> way). I’ll try to replicate the build on my end and share the vmlinux
> with DWARF data stripped for convenience.
> 

I managed to reproduce the issue locally and I've uploaded the vmlinux[1]
(stripped of DWARF data) and vmlinux.raw[2] files, as well as one of the 
modules[3] and its btf data[4] extracted with:

bpftool -B vmlinux btf dump file cros_kbd_led_backlight.ko > cros_kbd_led_backlight.ko.raw

Looking again at the logs[5], I've noticed the following is reported:

[    0.415885] BPF: 	 type_id=115803 offset=177920 size=1152
[    0.416029] BPF:  
[    0.416083] BPF: Invalid offset
[    0.416165] BPF: 

There are two different definitions of rcu_data in '.data..percpu', one
is a struct and the other is an integer:

type_id=115801 offset=177920 size=1152 (VAR 'rcu_data')
type_id=115803 offset=177920 size=1152 (VAR 'rcu_data')

[115801] VAR 'rcu_data' type_id=115572, linkage=static
[115803] VAR 'rcu_data' type_id=1, linkage=static

[115572] STRUCT 'rcu_data' size=1152 vlen=69
[1] INT 'long unsigned int' size=8 bits_offset=0 nr_bits=64 encoding=(none)

I assume that's not expected, correct?

I'll dig a bit deeper and report back if I can find anything else.

[1] https://people.collabora.com/~laura.nao/dbg-btf-mismatch-next-20241113/vmlinux
[2] https://people.collabora.com/~laura.nao/dbg-btf-mismatch-next-20241113/vmlinux.raw
[3] https://people.collabora.com/~laura.nao/dbg-btf-mismatch-next-20241113/cros_kbd_led_backlight.ko
[4] https://people.collabora.com/~laura.nao/dbg-btf-mismatch-next-20241113/cros_kbd_led_backlight.ko.raw
[5] https://pastebin.com/raw/FvvrPhAY

Best,

Laura

