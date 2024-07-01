Return-Path: <bpf+bounces-33483-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC71D91DD44
	for <lists+bpf@lfdr.de>; Mon,  1 Jul 2024 12:58:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2950280DDB
	for <lists+bpf@lfdr.de>; Mon,  1 Jul 2024 10:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FEDE13C68A;
	Mon,  1 Jul 2024 10:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YTDxw0B6"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9934C12E1EE;
	Mon,  1 Jul 2024 10:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719831467; cv=none; b=p/GnHrg08fEgKKSKcsUFYsAqOhBwEEC+MvnwJxFtHQwemhC2l9wJU7nxzFZhMgX3QF6Ldk8K9V+ljZTx0lsRqgT+EBwqxELoNY3vbx4AoxVqINm7aIQvG7tQtYLD0h4pqwq8RkgO0BHpV+PjaqOOkg1tPioA24Mhw6VP1VXes+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719831467; c=relaxed/simple;
	bh=9iRKN74MFBTZRi3zU6PPebs8wEeq12DdyWV46oZgJS0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vn0Ue4V7YMQFRrOE+m4sghACv4rCOL3KMldlJfZ0DWIOdGGt7WmQ8PyoVTMWoC3sxH9aKQCM7SH0hTo0deEwtlN9h3MuiwIwnwx6fnHPPBXtCZWUT3tphHoO1Ak1Syz6ZjvjVgNmh5o6nbgee3hygCMqX0IrD3D2H06dI1tYnIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YTDxw0B6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1303C32786;
	Mon,  1 Jul 2024 10:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719831467;
	bh=9iRKN74MFBTZRi3zU6PPebs8wEeq12DdyWV46oZgJS0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YTDxw0B6P06l95kjEajvJKiWxpOOdBjewOTfah6mLGyAit+C+b/jI2n8OjTIUtrfS
	 zRAu4NeYEzcBsYSew/ia7b6zL/XUiLPVlZpmWzAGgxqCDusqD5YSjewrz5d/rXDz7U
	 LzJjS0OyWsiTx899k1m4TJqWK0E6ZYVStq89moCnwgZOz+7pUsYj5NgF4lvpSsmkTO
	 SjnIqXobZJrvpmxN4Swu/SqlPVJvUb5UoplSjW3NKfS3wtlAD+FiODQ7AAWJ0ZLAaK
	 IUKGp3k4+sO1rmTwOpBNDG1G5SwO/OQ9PS+wiNZbOhD0ZDSbM2Bd8sCwG2xOglFc91
	 f/VFurdVbX+xg==
Date: Mon, 1 Jul 2024 11:57:42 +0100
From: Simon Horman <horms@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>, kuba@kernel.org, neilb@suse.de,
	jlayton@kernel.org, kolga@netapp.com, Dai.Ngo@oracle.com,
	tom@talpey.com, netdev@vger.kernel.org, bpf@vger.kernel.org,
	Lex Siegel <usiegl00@gmail.com>
Subject: Re: [PATCH net v2] net, sunrpc: Remap EPERM in case of connection
 failure in xs_tcp_setup_socket
Message-ID: <20240701105742.GV17134@kernel.org>
References: <2e62f0fc284b2f27156cd497fbb733b55a5ade43.1719592013.git.daniel@iogearbox.net>
 <Zn7wtStV+iafWRXj@tissot.1015granger.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zn7wtStV+iafWRXj@tissot.1015granger.net>

On Fri, Jun 28, 2024 at 01:19:49PM -0400, Chuck Lever wrote:
> On Fri, Jun 28, 2024 at 06:31:23PM +0200, Daniel Borkmann wrote:
> > When using a BPF program on kernel_connect(), the call can return -EPERM. This
> > causes xs_tcp_setup_socket() to loop forever, filling up the syslog and causing
> > the kernel to potentially freeze up.
> > 
> > Neil suggested:
> > 
> >   This will propagate -EPERM up into other layers which might not be ready
> >   to handle it. It might be safer to map EPERM to an error we would be more
> >   likely to expect from the network system - such as ECONNREFUSED or ENETDOWN.
> > 
> > ECONNREFUSED as error seems reasonable. For programs setting a different error
> > can be out of reach (see handling in 4fbac77d2d09) in particular on kernels
> > which do not have f10d05966196 ("bpf: Make BPF_PROG_RUN_ARRAY return -err
> > instead of allow boolean"), thus given that it is better to simply remap for
> > consistent behavior. UDP does handle EPERM in xs_udp_send_request().
> > 
> > Fixes: d74bad4e74ee ("bpf: Hooks for sys_connect")
> > Fixes: 4fbac77d2d09 ("bpf: Hooks for sys_bind")
> > Co-developed-by: Lex Siegel <usiegl00@gmail.com>
> > Signed-off-by: Lex Siegel <usiegl00@gmail.com>
> > Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> > Link: https://github.com/cilium/cilium/issues/33395
> > Link: https://lore.kernel.org/bpf/171374175513.12877.8993642908082014881@noble.neil.brown.name
> > ---
> >  [ Fixes tags are set to the orig connect commit so that stable team
> >    can pick this up. ]
> > 
> >  v1 -> v2:
> >    - Plain resend, adding more sunrpc folks to Cc
> > 
> >  net/sunrpc/xprtsock.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> > 
> > diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
> > index dfc353eea8ed..0e1691316f42 100644
> > --- a/net/sunrpc/xprtsock.c
> > +++ b/net/sunrpc/xprtsock.c
> > @@ -2441,6 +2441,13 @@ static void xs_tcp_setup_socket(struct work_struct *work)
> >  		transport->srcport = 0;
> >  		status = -EAGAIN;
> >  		break;
> > +	case -EPERM:
> > +		/* Happens, for instance, if a BPF program is preventing
> > +		 * the connect. Remap the error so upper layers can better
> > +		 * deal with it.
> > +		 */
> > +		status = -ECONNREFUSED;
> > +		fallthrough;
> >  	case -EINVAL:
> >  		/* Happens, for instance, if the user specified a link
> >  		 * local IPv6 address without a scope-id.
> > -- 
> > 2.21.0
> > 
> 
> Hi Daniel -
> 
> I know this is not documented in MAINTAINERS, but changes to
> net/sunrpc/xprtsock.c go to Anna Schumaker and Trond Myklebust,
> cc: linux-nfs@vger.

Would it be possible to update MAINTAINERS accordingly?

