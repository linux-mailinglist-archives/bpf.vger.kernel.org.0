Return-Path: <bpf+bounces-33622-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 26B8D923E1E
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 14:46:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C32A81F2433A
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 12:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3705A16B3B4;
	Tue,  2 Jul 2024 12:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Euc/Hw1E"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B033085C74;
	Tue,  2 Jul 2024 12:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719924401; cv=none; b=IEX4z3NUc+zeconPMOOUw2Kf4DcSWmbClgNWP/bL/MqCe9vuXqJ4gzc2g7lbtU/lOPbXfV/8W5I6M76MYKJEec7Zkk875FlI7RDwd1r0WGSehflztW3vZ8/kVimUv2sf4Q8weEult4iwMVvjsv3Z/u1nECUjBBgH850EzSF6k/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719924401; c=relaxed/simple;
	bh=i0Yfsijdh94yiEq7DVgp9B4aT3nBbF8AG7rJAZLWCkY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jlPdx8e6D1CIuTTNp7yi5Tu1bbaYT3KgVCwWtkqM5AXhJcoboRYyo10HFzXnkq0NV40bDcLE34LcNiHrhXFwUrmqHd8sdX1o/S7tG3yYZTe6SYIS0V4lGxeuLNcbpi+BsvNEqwIQz0ac0lHlqS8G2U0SAESU0tMps7C/bn7cSbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Euc/Hw1E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12A31C2BD10;
	Tue,  2 Jul 2024 12:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719924401;
	bh=i0Yfsijdh94yiEq7DVgp9B4aT3nBbF8AG7rJAZLWCkY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Euc/Hw1Eb8AqkQzqy+qxCOf4dOpE8gDj5tBdTCa4V+8Rgi74Jn8c9UQG3Z3BAf0q4
	 /15aKYmA/Tv579wFiUZN+R34AtTxejvTSpOZKAmKFu3yqNd0DnbKL3mNYW32e+3Yjl
	 lYgMdAMxjQYORk129swI/Js4Fl+hUQUvRYNJ/uEB7dHZ5UVQ7kIZSen8bqRDhdXikC
	 2xZhJIkpLq3SdWBrwbOD6x/wZncyg/8sY6MIZ/7sJW/IooI4HWkr3iWKj02dh1midk
	 0tX47GOP+VCnc7S0WWJethMQYThlPGTd+rT2TkdeM8HiKPRrO6EOC0XHN0PlK06nxv
	 QvjpCFL1iOGUA==
Date: Tue, 2 Jul 2024 13:46:36 +0100
From: Simon Horman <horms@kernel.org>
To: Chuck Lever III <chuck.lever@oracle.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>,
	Jakub Kicinski <kuba@kernel.org>, Neil Brown <neilb@suse.de>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>, netdev <netdev@vger.kernel.org>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	Lex Siegel <usiegl00@gmail.com>
Subject: Re: [PATCH net v2] net, sunrpc: Remap EPERM in case of connection
 failure in xs_tcp_setup_socket
Message-ID: <20240702124636.GI598357@kernel.org>
References: <2e62f0fc284b2f27156cd497fbb733b55a5ade43.1719592013.git.daniel@iogearbox.net>
 <Zn7wtStV+iafWRXj@tissot.1015granger.net>
 <20240701105742.GV17134@kernel.org>
 <39757894-2C57-4DD6-AF93-25EA35C87C3D@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <39757894-2C57-4DD6-AF93-25EA35C87C3D@oracle.com>

On Mon, Jul 01, 2024 at 02:04:22PM +0000, Chuck Lever III wrote:
> > On Jul 1, 2024, at 6:57 AM, Simon Horman <horms@kernel.org> wrote:
> > On Fri, Jun 28, 2024 at 01:19:49PM -0400, Chuck Lever wrote:
> >> On Fri, Jun 28, 2024 at 06:31:23PM +0200, Daniel Borkmann wrote:

...

> >> Hi Daniel -
> >> 
> >> I know this is not documented in MAINTAINERS, but changes to
> >> net/sunrpc/xprtsock.c go to Anna Schumaker and Trond Myklebust,
> >> cc: linux-nfs@vger.
> > 
> > Would it be possible to update MAINTAINERS accordingly?
> 
> I can do it, of course, but I'd like to discuss this
> with the NFS client maintainers to ensure they agree
> on how the files are divided between the trees.

Hi Chuck,

Thanks in advance for raising this with the NFS client maintainers.
I do think it would be nice to resolve.

