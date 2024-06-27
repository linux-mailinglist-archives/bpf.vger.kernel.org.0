Return-Path: <bpf+bounces-33255-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8774391A7DD
	for <lists+bpf@lfdr.de>; Thu, 27 Jun 2024 15:29:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9C2F1C23AD9
	for <lists+bpf@lfdr.de>; Thu, 27 Jun 2024 13:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8271B193092;
	Thu, 27 Jun 2024 13:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="R4Zwmcfh"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F74193071;
	Thu, 27 Jun 2024 13:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719494964; cv=none; b=nGdWFb8mScAwf9Aw2wyWhojCkGbL+PdK2e2Byypa/5wSdwxkoXEC0swIfLe9nClqZDpSewfeLl1aEILWXognOpZqp2gRENAIrkt+EruUyCqKtOhjnptcCQ9/D3Dkne4XNr4fiyv5E/U1XB2NAda+zaWzwJY1wSmfuivvh4RsG+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719494964; c=relaxed/simple;
	bh=tdUqQ/Xb77gV4nfR1cl4SEauQBWSZn1KAJXPOLJ9E4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=osbSe6xsae30W1zxYvredN4yn2AAa8IMMyMF1TyMmpG0Yn9OjJ9t41+s2SxFeQfk5Ba0rPlmtpw8KdSqCjBMg05i02f05islTr/ne6j+0JhzjTpjuzw98+c5cAx5W6OOjKGyPJKTcJLylzoLSN5BpjBsrrx2a+V/OAySa3gTzNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=R4Zwmcfh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43477C2BBFC;
	Thu, 27 Jun 2024 13:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1719494963;
	bh=tdUqQ/Xb77gV4nfR1cl4SEauQBWSZn1KAJXPOLJ9E4s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R4ZwmcfhHcEbWQnaE7mjR+rYwh2M+pS1G6cIas/iil+23t/u8vXJOVfiAAVC02OIq
	 HjUsyt2o+QvCWO562fry/JakMbfaeRQaMi62z45dzwv9Q5oVfkh7dWtST4Wj3snWRt
	 XUNkcacn9RsJs0JBLNZ7FGNrP8wFMrJytrljvKUg=
Date: Thu, 27 Jun 2024 15:29:20 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Cc: cve@kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	Stanislav Fomichev <sdf@google.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>
Subject: Re: CVE-2024-38564: bpf: Add BPF_PROG_TYPE_CGROUP_SKB attach type
 enforcement in BPF_LINK_CREATE
Message-ID: <2024062755-crestless-yam-9f2b@gregkh>
References: <2024061955-CVE-2024-38564-b069@gregkh>
 <sgnl2ithdfmum4jlgbqcbhenm2roioypqk2ndmyq4xd2h4svwp@s3dmiiaxh3jf>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <sgnl2ithdfmum4jlgbqcbhenm2roioypqk2ndmyq4xd2h4svwp@s3dmiiaxh3jf>

On Wed, Jun 26, 2024 at 02:44:31PM +0800, Shung-Hsi Yu wrote:
> On Wed, Jun 19, 2024 at 03:36:13PM GMT, Greg Kroah-Hartman wrote:
> > In the Linux kernel, the following vulnerability has been resolved:
> > 
> > bpf: Add BPF_PROG_TYPE_CGROUP_SKB attach type enforcement in BPF_LINK_CREATE
> > 
> > bpf_prog_attach uses attach_type_to_prog_type to enforce proper
> > attach type for BPF_PROG_TYPE_CGROUP_SKB. link_create uses
> > bpf_prog_get and relies on bpf_prog_attach_check_attach_type
> > to properly verify prog_type <> attach_type association.
> > 
> > Add missing attach_type enforcement for the link_create case.
> > Otherwise, it's currently possible to attach cgroup_skb prog
> > types to other cgroup hooks.
> > 
> > The Linux kernel CVE team has assigned CVE-2024-38564 to this issue.
> > 
> > 
> > Affected and fixed versions
> > ===========================
> > 
> > 	Issue introduced in 5.7 with commit af6eea57437a and fixed in 6.6.33 with commit 6675c541f540
> > 	Issue introduced in 5.7 with commit af6eea57437a and fixed in 6.8.12 with commit 67929e973f5a
> > 	Issue introduced in 5.7 with commit af6eea57437a and fixed in 6.9.3 with commit b34bbc766510
> > 	Issue introduced in 5.7 with commit af6eea57437a and fixed in 6.10-rc1 with commit 543576ec15b1
> 
> I'd like to dispute the affected commit for this CVE.
> 
> The commit that introduced the issue should instead be commit
> 4a1e7c0c63e02 ("bpf: Support attaching freplace programs to multiple
> attach points") in 5.10.
> 
> When link_create() was added in commit af6eea57437a, it uses
> bpf_prog_get_type(attr->link_create.prog_fd, ptype) to resolve struct
> bpf_prog, which effectively does the requried
> 
> 	prog->type == attach_type_to_prog_type(attach_type)
> 
> check through bpf_prog_get_ok(), and thus would not allow
> BPF_PROG_TYPE_CGROUP_SKB to be attached to other cgroup hooks.
> 
> It is in commit 4a1e7c0c63e02 ("bpf: Support attaching freplace programs
> to multiple attach points") that had bpf_prog_get_type() replaced with
> bpf_prog_get() and lead to the removal of such check, making it possible
> to attach BPF_PROG_TYPE_CGROUP_SKB to other cgroup hooks.
> 
> [...]

Thanks for the information, we have now adjusted the vulnerable commit
and pushed out the new json information to cve.org

greg k-h

