Return-Path: <bpf+bounces-55801-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EA91A868E8
	for <lists+bpf@lfdr.de>; Sat, 12 Apr 2025 00:38:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B0394C1483
	for <lists+bpf@lfdr.de>; Fri, 11 Apr 2025 22:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D87DE29DB9C;
	Fri, 11 Apr 2025 22:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OZT7wqr0"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5562A18B484;
	Fri, 11 Apr 2025 22:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744411104; cv=none; b=XI+cQOH7NTbYrmA44sXrTN2LYPeKbKu+MgG8D9HjTRkUSbUY9cXAQ0PQ2Ly4MtOJy/YeFIm6DtuGSGfpR1/oyoOHzENmsMw7nSucgkl50J+dta5dJ4/7Tdq/saHPaYOTTr7YGlNTrZqCrG52QxWjfKWoUVy1QWAwnu6SEgW1swI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744411104; c=relaxed/simple;
	bh=zo8MEYJ+NU1FbxcxM8Z0mj22WwuLAh1ZHhiRRt4PLDA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BlklhWX+8uv/8HyHgyB8NCqvdZqf0Vd6kPU7X7ZEMm0Iq4/MrUKDnTxE9Mn4EmcszB8RCB2/Ko1PsEGXP4Dnkr0hyxtMiryPflb4EyYaG/9QcKifZlQxWGaYaIHGb7IRQKVINZpzWtAEbMt69RPPEkieAkVYubfWw7ZJuz8GgZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OZT7wqr0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38861C4CEE2;
	Fri, 11 Apr 2025 22:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744411103;
	bh=zo8MEYJ+NU1FbxcxM8Z0mj22WwuLAh1ZHhiRRt4PLDA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OZT7wqr0yILM9VVoJdf8HuS5CHpnKPI7vHQaZ+PtArdV4kk2VP2U90vaqzG7sSeyA
	 d3m3406EfXZAbjXKjFvUBkM7lvtcHX3tA5JjpXKynFLVxzhfE7FpuE5jd8BMoMVTmZ
	 r920CJkIK8Hs3kJinQusF0XLirrb4NUtAKqhyuLHElc/zk1Kwi2jtjl/CBUKo5+bdl
	 +ILVB8k+Y4upI7vZvobSB4RNh34Yx207nDRdvo5et/TQzTEAEVxU0umhg9pF0m8u26
	 7V90XMHg7DQHcCn3fa9O6pDWhI8WC2UeOpHEpnl+dotms7c8+EpFjMmQDRzbRRPNoc
	 h/Q2mpe/FG7AA==
Date: Fri, 11 Apr 2025 15:38:22 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: syzbot <syzbot+4ebb06d5f6e3597279c0@syzkaller.appspotmail.com>
Cc: andrii@kernel.org, ast@kernel.org, bjorn@kernel.org,
 bpf@vger.kernel.org, daniel@iogearbox.net, davem@davemloft.net,
 edumazet@google.com, horms@kernel.org, jonathan.lemon@gmail.com,
 linux-kernel@vger.kernel.org, maciej.fijalkowski@intel.com,
 magnus.karlsson@intel.com, netdev@vger.kernel.org, pabeni@redhat.com,
 syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] [bpf?] possible deadlock in xsk_diag_dump
Message-ID: <20250411153822.2ff97d57@kernel.org>
In-Reply-To: <67f50e3f.050a0220.396535.0562.GAE@google.com>
References: <67f50e3f.050a0220.396535.0562.GAE@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 08 Apr 2025 04:53:35 -0700 syzbot wrote:
> Chain exists of:
>   &xs->mutex --> &rdev->wiphy.mtx --> &net->xdp.lock
> 
>  Possible unsafe locking scenario:
> 
>        CPU0                    CPU1
>        ----                    ----
>   lock(&net->xdp.lock);
>                                lock(&rdev->wiphy.mtx);
>                                lock(&net->xdp.lock);
>   lock(&xs->mutex);

After looking at it with Stanislav our best guess is that we're mixing
normal and ops locked devices in close_many. Will send a fix over the
weekend.

