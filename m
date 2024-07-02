Return-Path: <bpf+bounces-33659-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A23F924766
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 20:40:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15884288881
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 18:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CC971CD5BD;
	Tue,  2 Jul 2024 18:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h+wi4Ob6"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D08EA1DFE3;
	Tue,  2 Jul 2024 18:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719945628; cv=none; b=ZMICyctFPxqVbb5pFmbfWtOABTMsjNPH8RRakfOb6IuCGFiwYt4jJpblsl+uWTW2QhDkzEvvrPkCL92znS3gFa7R6mUloyNcfyY2lFx9UlcuCE5F0E4fNfQ1mLgZmQh7z1rx57AfKoWpuMeLkC28krDUTVvnP91WZNB4lwR4CWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719945628; c=relaxed/simple;
	bh=JoUNhJKdDEN3RYQhJzhOpSG5BQd7+bo0EiMrC2sQIGw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J1fadlgTOrjheI6L7Mdlrl4CkVPSQk1ZifIejbVrp0QS7EGfRF7cUWZtsDBHlKFGis3a/SSLchfH9EAee1DJPoqbDxUrTGoRJcHJW5nWrUjauUMyxbo9S5SFuzNGNapP2/3g0kyxGIYGf1YjrNq9RrJdFWBDIaSs0ZQfBIGutaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h+wi4Ob6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FF07C116B1;
	Tue,  2 Jul 2024 18:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719945628;
	bh=JoUNhJKdDEN3RYQhJzhOpSG5BQd7+bo0EiMrC2sQIGw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=h+wi4Ob6dowjBLypFV28ctg32SyErLY9V/bOnS1oTnq73Rnmlm8bQdqec98HdkVHN
	 B/UekECPjwJdo6Rg1iPJziBr90/7asxzYe4/N2hpA1Wl89TU0M4sgvi1sMHsVQwrlO
	 3W39HmXS+zSG81yXPSnWjJg6zRlwr8SUVYKC/BDMykWJ1zKaNI6mPnow0rVZFZ29lL
	 l4McHngjUfTAWiyf5/JkNiNkbPSKVZ0Qc9NxBWQC6lzDJRYLSdd3+R7OUKBkapkwRb
	 nn26lBTfW9CGjdekb0iVCNgf04ndh2DIcWlQBOKYBoOmWL0UDCyjJWcB74pHxT/NL3
	 d8idpsdo67qoA==
Date: Tue, 2 Jul 2024 11:40:26 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: syzbot <syzbot+08811615f0e17bc6708b@syzkaller.appspotmail.com>,
 andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
 daniel@iogearbox.net, davem@davemloft.net, eddyz87@gmail.com,
 haoluo@google.com, hawk@kernel.org, john.fastabend@gmail.com,
 jolsa@kernel.org, kpsingh@kernel.org, linux-kernel@vger.kernel.org,
 martin.lau@linux.dev, netdev@vger.kernel.org, sdf@fomichev.me,
 song@kernel.org, syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Subject: Re: [syzbot] [net?] [bpf?] general protection fault in
 dev_map_redirect
Message-ID: <20240702114026.1e1f72b7@kernel.org>
In-Reply-To: <000000000000adb970061c354f06@google.com>
References: <000000000000adb970061c354f06@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 01 Jul 2024 13:19:15 -0700 syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    74564adfd352 Add linux-next specific files for 20240701
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=12e5b0e1980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=111e4e0e6fbde8f0
> dashboard link: https://syzkaller.appspot.com/bug?extid=08811615f0e17bc6708b
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> 
> Unfortunately, I don't have any reproducer for this issue yet.

Hi Sebastian!

We have a few of these:

https://lore.kernel.org/all/0000000000008f77c2061c357383@google.com/
https://lore.kernel.org/all/00000000000079d168061c36ce83@google.com/
https://lore.kernel.org/all/000000000000357ea9061c384d6d@google.com/

tun's local XDP and XDP generic also need to be covered.

