Return-Path: <bpf+bounces-55800-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A2A2BA868E4
	for <lists+bpf@lfdr.de>; Sat, 12 Apr 2025 00:34:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B57761BA32AF
	for <lists+bpf@lfdr.de>; Fri, 11 Apr 2025 22:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B671F29DB97;
	Fri, 11 Apr 2025 22:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IWbwFLB9"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 344CA221FDA;
	Fri, 11 Apr 2025 22:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744410872; cv=none; b=BOvSgus+2xwM9nZFVpHWHDPTj11ogWQLkB7PlP9NxgpeE4im51lrlEFDnYkU7p9bVS8a9y+y+q3q531RyuX2nRWOSNz4oBXAtwJDOTRjWeUGzkWPDzLNnGbFGJtCA6pZFH8DaMJTm16+jjv53eYZ9nx+sHDex3F3Ebbhv2Z6SAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744410872; c=relaxed/simple;
	bh=IJVHtolrjrUUgBGSALBhI1zt4156D2MFsEdtgePT11s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J9PgYj0TphLmEh84TYG22DuFZpum+DDhaKHbaHvVe1SnTFD1BXOuzU05SIFYImYFMjQWOsD5eSoEKusYP98H9llnuMuwM+6zCuAE67WEstpt42wqyi2ujj285CFoDzU2b1U5ONLEFL0b8XVgSG2MRyd8ZKEuT/iWVHKgw57NKew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IWbwFLB9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0885CC4CEE2;
	Fri, 11 Apr 2025 22:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744410871;
	bh=IJVHtolrjrUUgBGSALBhI1zt4156D2MFsEdtgePT11s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IWbwFLB92lbbltn7jrVBWUYtenz3L5Ri+lthZDJLfpiGHUN7R+UQwiSzAd8SHHj6f
	 IoWgp7+Gb7Vu+DZL6R4bMeAaPNIdHaV+r9FfQFOBNHgC+vFUDFItrKk/Vj+dvYv9l4
	 EO68TG4MSKeCAMVQJ2SKNPao/j3xgUlFbuzKdprejBGj9fg5LuYr0xD3OJhnJ0LJy4
	 m/PNQfrcOVXiAJJVuMnoB5bojY1/UcVYaQ7ilz/execCRj80ZyUUvDqnt/UlhdSCvT
	 1vEUC7bFWBqnHiRshRKYxCe7anvqPG1HkrT18VMvEu2nZMi8cZjCa73ZmD5WXM2YnO
	 VEiozyn+pjdpA==
Date: Fri, 11 Apr 2025 15:34:29 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: syzbot <syzbot+46043677477d6064a1a0@syzkaller.appspotmail.com>
Cc: andrii@kernel.org, ast@kernel.org, bjorn@kernel.org,
 bpf@vger.kernel.org, daniel@iogearbox.net, davem@davemloft.net,
 edumazet@google.com, horms@kernel.org, jonathan.lemon@gmail.com,
 linux-kernel@vger.kernel.org, maciej.fijalkowski@intel.com,
 magnus.karlsson@intel.com, netdev@vger.kernel.org, pabeni@redhat.com,
 syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bpf?] [net?] possible deadlock in xsk_bind
Message-ID: <20250411153429.697267f9@kernel.org>
In-Reply-To: <67f72e6d.050a0220.258fea.0027.GAE@google.com>
References: <67f72e6d.050a0220.258fea.0027.GAE@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 09 Apr 2025 19:35:25 -0700 syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    61f96e684edd Merge tag 'net-6.15-rc1' of git://git.kernel...
> git tree:       net
> console output: https://syzkaller.appspot.com/x/log.txt?x=1635523f980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=f2054704dd53fb80
> dashboard link: https://syzkaller.appspot.com/bug?extid=46043677477d6064a1a0
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

#syz dup: possible deadlock in xsk_diag_dump

