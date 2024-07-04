Return-Path: <bpf+bounces-33892-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42987927840
	for <lists+bpf@lfdr.de>; Thu,  4 Jul 2024 16:24:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBF8D1F249B2
	for <lists+bpf@lfdr.de>; Thu,  4 Jul 2024 14:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE8F11B0109;
	Thu,  4 Jul 2024 14:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TIAOXV1a"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606FDD2F5;
	Thu,  4 Jul 2024 14:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720103075; cv=none; b=pfvkXWzMEb1ckQHcEi2svJI7swnzX0qabAD6oBil2ox0hflgW7ZCPcMx0GT3wRmjIgOYM2MmvcaZkqAjFzT6H+1P9+zErWIbu+WR0ox7hgeGFSNv1WxaCbEo62u9OCtC4LrDgbpgGc7KRUdNM5LHZ+ElsvlkfIlzk+9+d+kB0x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720103075; c=relaxed/simple;
	bh=7W6PGcV0q4XvpyTVd6THPTQCSRFEAPGvv2zfX0f+eKs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oGtpj38j4cBPgHD3IhhcKuXe8mrykmsKrK3Eoktcn86lWRbra9XJPLk8OC7xigyticQTsHklVaQvY86WxKXXla8MV1t/HYZxhKP6mSQihMY3qJZD4wqmdQxfuFCmPjRBtJJOM7dqdBLz0xAT3Nyl/NW7rzpr+umDx/hDHBoV+0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TIAOXV1a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EB9AC4AF0A;
	Thu,  4 Jul 2024 14:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720103075;
	bh=7W6PGcV0q4XvpyTVd6THPTQCSRFEAPGvv2zfX0f+eKs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TIAOXV1a7Asp0aXQq4HFq0Ka+zkLktSbRMop2HWZfa+z3Z5LZsF/v36ZsZPbRKuH6
	 aKvBgmyvNG0Q9hdITb7VVbkyeGNmPhPg6oPmWk0Mri3pOYZvK6+Pg69u064amRnIDt
	 Xhs/9zvfZAgOsdPgFJjY0B609ea45zyhffux+wA/InneRxqrAcLYmMa/BzY9snqa+X
	 7FuFMH9vP3W5zkCfdWOphTWMGW72tgkteT/wtSVCIcAcAWnL5YaVRHnJTXKrYo3fqV
	 Cmpv3FlqU9DYz5eaxw2jykSWjoxJA34fBQYMMbPv6xBV/Ps4vjSEZbxJS2/tkNsgEx
	 OHH30yioUC90Q==
Date: Thu, 4 Jul 2024 07:24:33 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: syzbot <syzbot+08811615f0e17bc6708b@syzkaller.appspotmail.com>,
 andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
 daniel@iogearbox.net, davem@davemloft.net, eddyz87@gmail.com,
 haoluo@google.com, hawk@kernel.org, john.fastabend@gmail.com,
 jolsa@kernel.org, kpsingh@kernel.org, linux-kernel@vger.kernel.org,
 martin.lau@linux.dev, netdev@vger.kernel.org, sdf@fomichev.me,
 song@kernel.org, syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Subject: Re: [PATCH v2 net-net] tun: Assign missing bpf_net_context.
Message-ID: <20240704072433.4531a7e1@kernel.org>
In-Reply-To: <20240704101452.NhpibjJt@linutronix.de>
References: <000000000000adb970061c354f06@google.com>
	<20240702114026.1e1f72b7@kernel.org>
	<20240703122758.i6lt_jii@linutronix.de>
	<20240703120143.43cc1770@kernel.org>
	<20240703192118.RIqHj9kS@linutronix.de>
	<20240704101452.NhpibjJt@linutronix.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 4 Jul 2024 12:14:52 +0200 Sebastian Andrzej Siewior wrote:
> Subject: [PATCH v2 net-net] tun: Assign missing bpf_net_context.

LG, but can I bother you for a repost? the subject tag is typo'ed
(net-net vs net-next) and our CI put this on top of net, since it
applies. But it doesn't build on top of net. 
Feel free to repost without any wait.

