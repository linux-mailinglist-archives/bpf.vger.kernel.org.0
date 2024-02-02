Return-Path: <bpf+bounces-21058-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF8DC847280
	for <lists+bpf@lfdr.de>; Fri,  2 Feb 2024 16:03:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 520EE1F2AEF5
	for <lists+bpf@lfdr.de>; Fri,  2 Feb 2024 15:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 302B3144627;
	Fri,  2 Feb 2024 15:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gud/uUv9"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B055A1C33
	for <bpf@vger.kernel.org>; Fri,  2 Feb 2024 15:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706886212; cv=none; b=j013RgECIShO6P1D6cEGEGva9F4WnCgbPLFl5ZEwaU0G9eF8DfTLQD0XbuCRDg6suQizqzfCT72Y6s7k3c8RBFWrBVotW3RmXx3NrgTiTiGuXk205j7ViMUxh38epEOeShalEFv1/i1Jtn+9roFlGzlaynQOhGWqHy5FysEGxBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706886212; c=relaxed/simple;
	bh=lLgm/eXI7qyJYxPz4O5+fCxDwZlgjulJIsqzUzMdvXY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dg2T0X3Uew9VDH+7BiCApGqi6j6X/wkbPi0kpSM3GnPNrmtvVF/wEht7c3EvNcg7sINruHHN1NMY7DMWxQw+66iBw8s3Cud0af1tyQO/QiUCmYB85gn93MHR3bfOXbw/teFwLMZfkc39Rw83spIy/dgddkhwsRP2J9GmjdM6H6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gud/uUv9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00AA5C433C7;
	Fri,  2 Feb 2024 15:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706886212;
	bh=lLgm/eXI7qyJYxPz4O5+fCxDwZlgjulJIsqzUzMdvXY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gud/uUv9hYEnNypS+5E5D/s2TGCzxFddR13zBohTE1wcGc0Qt4ORBA0FOhueDxtO0
	 rqhDv71Ktu3UU9McXffsyl98l4ntKGPntv6F2gPgj0pZYQBeM0DmXADn5e8ZTGismh
	 1FhmyPxvNFHF3traL4DgPFvTryenbe5qN9C0/778=
Date: Fri, 2 Feb 2024 07:03:30 -0800
From: Greg KH <gregkh@linuxfoundation.org>
To: Lucien Wang <lcnwed@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	john.fastabend@gmail.com
Subject: Re: There has a backport bug between v5.10.79 and v5.10.80 when run
 bpf selftest "test_sockmap" on 5.10 lts kernel
Message-ID: <2024020216-expenses-slobbery-9100@gregkh>
References: <CAHViUT2y81_JHsuSDfH9Vu_KRbanvmGY_1Bs4jfrGyZPGHCbdg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHViUT2y81_JHsuSDfH9Vu_KRbanvmGY_1Bs4jfrGyZPGHCbdg@mail.gmail.com>

On Fri, Feb 02, 2024 at 11:40:38AM +0800, Lucien Wang wrote:
> Kernel version：16ad71c250c1 (HEAD -> linux-5.10.y, tag: v5.10.209,
> origin/linux-5.10.y) Linux 5.10.209
> 
> Bug reproduced steps：
> 1.  cd (kernel source tree root)/tools/testing/selftests/bpf
> 2.  make test_sockmap ; make test_progs
> 3.  ./test_sockmap
> # 1/ 6  sockmap::txmsg test passthrough:OK
> # 2/ 6  sockmap::txmsg test redirect:OK
> # 3/ 6  sockmap::txmsg test drop:OK
> # 4/ 6  sockmap::txmsg test ingress redirect:OK
> 
> After "# 4/ 6  sockmap::txmsg test ingress redirect:OK" display from
> terminal, the main process stucks and sends nothing.
> 4. In other terminal run " ps fax |grep sockmap " ,below is output
>   13076 pts/0    S+     0:00  |           \_ ./test_sockmap
>   13129 pts/0    S+     0:00  |               \_ ./test_sockmap
>   13130 pts/0    Z+     0:00  |               \_ [test_sockmap] <defunct>
>   13237 pts/1    S+     0:00              \_ grep --color=auto sockmap
> Obversely, because of child process 13129 sleep, so the main process is stuck.
> 
> My research:
> I use Bisection method to find the bug patch " c842a4c4ae7f bpf:
> sockmap, strparser, and tls are reusing qdisc_skb_cb and colliding
> "(on linux-5.10.y branch), it backport from v5.16-rc1 ,
> It must due to merge high patches incompletely, Please take a few
> moment for this.

I do not understand, sorry, what exactly do you want us to do here?

confused,

greg k-h

