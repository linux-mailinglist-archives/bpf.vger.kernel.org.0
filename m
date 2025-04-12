Return-Path: <bpf+bounces-55826-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E4964A86FF3
	for <lists+bpf@lfdr.de>; Sun, 13 Apr 2025 00:10:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE3127B0BE0
	for <lists+bpf@lfdr.de>; Sat, 12 Apr 2025 22:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90E3F20E700;
	Sat, 12 Apr 2025 22:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X8CfQ49H"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B3DBF4ED;
	Sat, 12 Apr 2025 22:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744495820; cv=none; b=X9PXYWCPfHWo5bg7Z3fxQqXjD6Bjdg5bSYStA7F+HS4upqqwPa/hakuRZnGqZdPE9qXMLr67Wfe0CT351F/gn4NjN18iSHa1YKRVeHqxDgwhvA2wb3C3ZLQPulFAjEuGuKoXlzzeNzpXMXqtAOlA/+mK7CkBQY0+Ru1hWQ4bQdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744495820; c=relaxed/simple;
	bh=Lomi+rDeikQZ//txMKfu2DTk7uH+GVOm/i76eZj/JAA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CLP9tWC6fmWoOQu6oItz7/Q8bXulEKg8FmoUCALTE1mvdq4KuU4BB97stGKCyff2QKzGG4DPH8q6kQx/mG2g0Mz0gTgUo/abwa28YwKR1FFDkdyhHb/J9zy9YmC1BokDfi7XgSG/3abThK5Gu8Cr6ajRZTJP8ZIZ2OqX1PbjLVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X8CfQ49H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8549C4CEE3;
	Sat, 12 Apr 2025 22:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744495816;
	bh=Lomi+rDeikQZ//txMKfu2DTk7uH+GVOm/i76eZj/JAA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=X8CfQ49HwVVCE+LoeVrPX8zD/Ypp2tq0BdBntSXcnBKN0gmdNRH5YnetRlrkUNdtd
	 JdqTYe+wIjuUWH/TBPhEYMlQ1sF1+UZdO+d4xMxQdmQUuyLmHIxbI5UGja44JVoHeq
	 +FsreJBnHVPUFtEzkPk8oXQ1nz5DySPHYCBz0ZcrZWx5rU4RrDaCDX7WJopEf+NkiQ
	 WrimKWGW9GdavKp4lzaEXTZp7qbuFV8r/fZ7BB+HwBB3YwV2vpXPvdFhCvZlC7Zf8h
	 T6/JLPS1k3HiVs9IPkQ3tfml8IxEFN8GLzFpNnR6gW/Y/yicrDu+pxyjUYNxc4LEmM
	 4e42zwh/8wKgg==
Date: Sat, 12 Apr 2025 15:10:14 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: syzbot <syzbot+6f588c78bf765b62b450@syzkaller.appspotmail.com>
Cc: andrii@kernel.org, ast@kernel.org, bjorn@kernel.org,
 bpf@vger.kernel.org, daniel@iogearbox.net, davem@davemloft.net,
 edumazet@google.com, horms@kernel.org, jonathan.lemon@gmail.com,
 linux-kernel@vger.kernel.org, maciej.fijalkowski@intel.com,
 magnus.karlsson@intel.com, netdev@vger.kernel.org, pabeni@redhat.com,
 syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bpf?] [net?] possible deadlock in xsk_notifier (2)
Message-ID: <20250412151014.1f0679ec@kernel.org>
In-Reply-To: <67f9ed1a.050a0220.379d84.0005.GAE@google.com>
References: <67f9ed1a.050a0220.379d84.0005.GAE@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 11 Apr 2025 21:33:30 -0700 syzbot wrote:
> syzbot found the following issue on:
> 
> HEAD commit:    900241a5cc15 Merge tag 'drm-fixes-2025-04-11-1' of https:/..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=1604ef4c580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=eecd7902e39d7933
> dashboard link: https://syzkaller.appspot.com/bug?extid=6f588c78bf765b62b450
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> userspace arch: i386
> 
> Unfortunately, I don't have any reproducer for this issue yet.

#syz dup: possible deadlock in xsk_diag_dump

