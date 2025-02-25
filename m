Return-Path: <bpf+bounces-52468-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 78A33A43194
	for <lists+bpf@lfdr.de>; Tue, 25 Feb 2025 01:07:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7105E7A7928
	for <lists+bpf@lfdr.de>; Tue, 25 Feb 2025 00:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA6B810F1;
	Tue, 25 Feb 2025 00:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BJZRwHA1"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5594A1A;
	Tue, 25 Feb 2025 00:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740442028; cv=none; b=utpEVTrtmT/HirtzZ9e4MN+IfOZVo2EPItIj8Y2DTRR1zmRe1LRy1enZh8j8dMlcB1ruQvFBA96A6RxCoWu+H4rKRs2Dk7U7Ifg+Z1guWOh4mfdkVAVgZAFdRzWZNSOiPUKrh0W3JOZVQVBkER5NXvVvP417HhGzktYLvnlEawk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740442028; c=relaxed/simple;
	bh=O3kyg0KR41txLm2kmqnoKuQSLqyFajP6gvDa6HFFiCE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oOTbqXcBscGqT6NmJ/4vY6ziuLQlvCWLJhaDFn5IaYaKcMuH5z9gnkYnjG33WkgNrMDiBO+a7Zh1ECP+L9nZC6F5+2ijVWrkwfWaPEm8q4ZkWZmntL28S3+NMctHQZNc/0PpTVpG5JqkL3V5dsdSNK1xISOs0bnG66ZJHJZZzO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BJZRwHA1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D307C4CED6;
	Tue, 25 Feb 2025 00:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740442027;
	bh=O3kyg0KR41txLm2kmqnoKuQSLqyFajP6gvDa6HFFiCE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BJZRwHA1Rpm8bvcceOd75Jb6prEzFSMu35Q30bw/ZCz2YabVhUYmv7HmICmmzJAuE
	 zld8KCnH+7zc8++/sYx3n9jMWSUqQoUXoHeVqdCnNqlPwtei4ESvue/f2cHfzUitZ/
	 Br0kr0SnbPl+IprsU3uraOXI3A8Z0KzG+qNHf318RFKXAch2wtDIS+RPUyMsZGsJWk
	 lPFPm+8TLHWB0en2Y9ckcCLE0GjX2tc41JSlwj1T8MPz9AW8UfSmJOgryq1ncLHQ2E
	 ObwfCchsULJcwGvyeI/lk8Cdr7+jxUqqY/0Cj5OcPEofoYAgBzKvxr3wul7Kf7IGUB
	 npCMg6vm6GCZg==
Date: Mon, 24 Feb 2025 16:07:06 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, ricardo@marliere.net, viro@zeniv.linux.org.uk,
 dmantipov@yandex.ru, aleksander.lobakin@intel.com,
 linux-ppp@vger.kernel.org, linux-kernel@vger.kernel.org, mrpre@163.com,
 syzbot+853242d9c9917165d791@syzkaller.appspotmail.com
Subject: Re: [PATCH net-next v2 1/1] ppp: Fix KMSAN warning by initializing
 2-byte header
Message-ID: <20250224160706.1ebde164@kernel.org>
In-Reply-To: <fm6hvchejtwpqp55te7rbiwt6y2pmjywikfdpnfv5ao5otxzm3@yxfem4zhdqkp>
References: <20250221061219.295590-1-jiayuan.chen@linux.dev>
	<20250221061219.295590-2-jiayuan.chen@linux.dev>
	<20250224142644.7c084e9e@kernel.org>
	<fm6hvchejtwpqp55te7rbiwt6y2pmjywikfdpnfv5ao5otxzm3@yxfem4zhdqkp>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 25 Feb 2025 07:20:08 +0800 Jiayuan Chen wrote:
> I apologize for the mistake, I've investigated the original maintainer's
> user-space PPP implementation and libpcap's behavior, and found that
> initializing the first byte to 0 or 1 is necessary, it indicates
> direction, which is used in libpcap to distinguish between inbound and
> outbound traffic.
> For more details, please refer to the cover letter of my v3 patch.
> 
> https://lore.kernel.org/linux-ppp/20250222092556.274267-1-jiayuan.chen@linux.dev/T/#t

You can still use the htons() there, it's cleaner.

