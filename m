Return-Path: <bpf+bounces-46076-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 359029E3EAE
	for <lists+bpf@lfdr.de>; Wed,  4 Dec 2024 16:52:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA205164F85
	for <lists+bpf@lfdr.de>; Wed,  4 Dec 2024 15:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 614FF20C47E;
	Wed,  4 Dec 2024 15:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=laura.nao@collabora.com header.b="BJwNCBh4"
X-Original-To: bpf@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54425207A33;
	Wed,  4 Dec 2024 15:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733327558; cv=pass; b=ImlO4sJUTXMb0HO5dHDJXeE7PA+cjHgBRFsYWCup0b1/2bXoGx51iUo21+p1mMCL8y4+gsWydMbsJdwyKPKvPSUhRlzsbOgMxk1FDDmX8h8QhJ+Zjj24UNHMcMgSoMRfmHkzh+M+oPZg+dhomom4BR/kn0H4N7qg3xU1q+dQGvA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733327558; c=relaxed/simple;
	bh=3GgiW3N3LZXUecZzX/Z2bD7+HxZswZiDkcxIzU0Xo+s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ABheIGRiSKyKFPcin9/5vFIelBvu4vXPyCgkHaruUc59YFTTMN9WVctHx62oNmowF7jLUrJU8vs3+2JSuGyUO5d4+1Mx1sgErGIhiRkI1rwEEdRiiN/67yjOJlt8//ewLRppMZV0DDYxuJUy5WTeZGqBWFudyRXkXAb7sbOwXY4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=laura.nao@collabora.com header.b=BJwNCBh4; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1733327539; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=hNs4+qe1RmVGYY2POaIHuG1D8b9khVvg9QRQTKlRWSOiaU7RcJ4rRAUJpSjORgMcFR61xUMNZLY5MLFTjQoEAraUwMsmwImKiZDSmZpq6cdLhGBcGxDcIDK64SJCYp30R/+pNFOUSPOdbIYkqOpTFbtAIoNKkQ0a7B/GfMHnVMo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1733327539; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=t+IOc0/iUALeNouk/Un46l8WsfTzgxm/2DTtzgWefrU=; 
	b=EqhoHs6thdnmqnu25+iGd8pnF7vHIguvkMBCXsC++uwiURKcbmaPXDhNg8Rw+e78QYTBYcBIH9h4Y6P2p12+dUXnsZkou5aG94CDy8DI7I19fAbse8Tswf52zCuuFqNSDw2EsOLAh0hCUNvl5GbyZ+xxc8YA7FfI2HsGu4bDu+I=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=laura.nao@collabora.com;
	dmarc=pass header.from=<laura.nao@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1733327539;
	s=zohomail; d=collabora.com; i=laura.nao@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=t+IOc0/iUALeNouk/Un46l8WsfTzgxm/2DTtzgWefrU=;
	b=BJwNCBh4EdmZGLio2uXycnjDwApd/XO27+TkvJMtxZT1Q1eSoAzZUaLkx6sDClH8
	Kl/F/v/sgTzd+nDGSSYhDFuC8JpmxuplaIDQ4HN40GXsBkmUTnpQyd5PyfKkC4SswaC
	NDDJA7GpSEJCyzVVapL3Aj+jOCLstz/NcnBzf9YE=
Received: by mx.zohomail.com with SMTPS id 1733327536916423.899350380492;
	Wed, 4 Dec 2024 07:52:16 -0800 (PST)
From: Laura Nao <laura.nao@collabora.com>
To: ubizjak@gmail.com
Cc: laura.nao@collabora.com,
	alan.maguire@oracle.com,
	bpf@vger.kernel.org,
	chrome-platform@lists.linux.dev,
	kernel@collabora.com,
	linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev
Subject: Re: [REGRESSION] module BTF validation failure (Error -22) on next
Date: Wed,  4 Dec 2024 16:53:05 +0100
Message-Id: <20241204155305.444280-1-laura.nao@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20241115171712.427535-1-laura.nao@collabora.com>
References: <20241115171712.427535-1-laura.nao@collabora.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

On 11/15/24 18:17, Laura Nao wrote:
> I managed to reproduce the issue locally and I've uploaded the vmlinux[1]
> (stripped of DWARF data) and vmlinux.raw[2] files, as well as one of the
> modules[3] and its btf data[4] extracted with:
> 
> bpftool -B vmlinux btf dump file cros_kbd_led_backlight.ko > cros_kbd_led_backlight.ko.raw
> 
> Looking again at the logs[5], I've noticed the following is reported:
> 
> [    0.415885] BPF: 	 type_id=115803 offset=177920 size=1152
> [    0.416029] BPF:
> [    0.416083] BPF: Invalid offset
> [    0.416165] BPF:
> 
> There are two different definitions of rcu_data in '.data..percpu', one
> is a struct and the other is an integer:
> 
> type_id=115801 offset=177920 size=1152 (VAR 'rcu_data')
> type_id=115803 offset=177920 size=1152 (VAR 'rcu_data')
> 
> [115801] VAR 'rcu_data' type_id=115572, linkage=static
> [115803] VAR 'rcu_data' type_id=1, linkage=static
> 
> [115572] STRUCT 'rcu_data' size=1152 vlen=69
> [1] INT 'long unsigned int' size=8 bits_offset=0 nr_bits=64 encoding=(none)
> 
> I assume that's not expected, correct?
> 
> I'll dig a bit deeper and report back if I can find anything else.

I ran a bisection, and it appears the culprit commit is:
https://lore.kernel.org/all/20241021080856.48746-2-ubizjak@gmail.com/

Hi Uros, do you have any suggestions or insights on resolving this issue?

This problem is now impacting mainline as well. The full context can be 
found at the beginning of this thread[1].

Thanks,

Laura

[1] https://lore.kernel.org/all/20241106160820.259829-1-laura.nao@collabora.com/

#regzbot introduced: 001217defd


