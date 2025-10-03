Return-Path: <bpf+bounces-70277-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D275BBB5FE0
	for <lists+bpf@lfdr.de>; Fri, 03 Oct 2025 08:44:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C2A094E4EFE
	for <lists+bpf@lfdr.de>; Fri,  3 Oct 2025 06:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45C1B2135B9;
	Fri,  3 Oct 2025 06:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KtLMK6/E"
X-Original-To: bpf@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F4721257A
	for <bpf@vger.kernel.org>; Fri,  3 Oct 2025 06:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759473870; cv=none; b=Ydsxn35f1ct8nl93wIdWJe/ju/8GR+unk9slkPMi1t7NX8F5qLhWaCZuZ3Nji6aOa7VsLBxLqEZpMloVIgQMdgINa+OG2El/W3WsYndgshZdCDJmdHXOQFy9ZmdtVJ89fbl0J/2ngbjvA+TDo5oPZfNn9pdYW/LgE299CPfjZx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759473870; c=relaxed/simple;
	bh=bUObHg2k+81a02x7bAACKW/Uat4WIu1MH9PjcD/i7F8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ji3hDth/1xxbgYVi+gPFFsiu5KpRJUpPHKBDZvnG95Q0XKykDl7uAT7WhECn0jtljw1L890ZP0lOFERxTinqWd10jnQwj0Mlpdp4K49e28uqNy4SknCRTZmBQedYgRE3NXkNrdrjGJaHAZn1S5filDMkT9c7NxbURhQeS99e+8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KtLMK6/E; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <d9140324-fc67-4b74-9e63-66e41e9c3cfa@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1759473866;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YBbirY9XIGvjegRyZyA+juBhAubmUFU1H+Ti7+My030=;
	b=KtLMK6/EbIVS/vKLELQwNFaY80U/DDg+EAK++kTAAUhhX1HNZvnCe01Z7CY9MvW0hGAq4S
	0KIg0HvEyqHZVbvlssdQuDLHa5ZpcFC0Sn8v6aD6LSJTjWlL8tcSXEMS6t/VMkwL1FD3YJ
	DoAHUa51tydJPVklPa3/u9JQTfURmjU=
Date: Fri, 3 Oct 2025 14:44:19 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [syzbot ci] Re: bpf: Extend bpf syscall with common attributes
 support
Content-Language: en-US
To: syzbot ci <syzbot+ci17fb38a78c944e07@syzkaller.appspotmail.com>,
 andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net
Cc: syzbot@lists.linux.dev, syzkaller-bugs@googlegroups.com
References: <68df6f7d.050a0220.2c17c1.001b.GAE@google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <68df6f7d.050a0220.2c17c1.001b.GAE@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 3/10/25 14:38, syzbot ci wrote:
> syzbot ci has tested the following series
> 
> [v3] bpf: Extend bpf syscall with common attributes support
> https://lore.kernel.org/all/20251002154841.99348-1-leon.hwang@linux.dev
> * [RFC PATCH bpf-next v3 01/10] bpf: Extend bpf syscall with common attributes support
> * [RFC PATCH bpf-next v3 02/10] libbpf: Add support for extended bpf syscall
> * [RFC PATCH bpf-next v3 03/10] bpf: Refactor reporting log_true_size for prog_load
> * [RFC PATCH bpf-next v3 04/10] bpf: Add common attr support for prog_load
> * [RFC PATCH bpf-next v3 05/10] bpf: Refactor reporting btf_log_true_size for btf_load
> * [RFC PATCH bpf-next v3 06/10] bpf: Add common attr support for btf_load
> * [RFC PATCH bpf-next v3 07/10] bpf: Add warnings for internal bugs in map_create
> * [RFC PATCH bpf-next v3 08/10] bpf: Add common attr support for map_create
> * [RFC PATCH bpf-next v3 09/10] libbpf: Add common attr support for map_create
> * [RFC PATCH bpf-next v3 10/10] selftests/bpf: Add cases to test map create failure log
> 
> and found the following issue:
> WARNING in map_create
> 
The added WARNINGs in map_create will be dropped in the next revision.

Thanks,
Leon

[...]

