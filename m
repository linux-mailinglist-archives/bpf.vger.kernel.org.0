Return-Path: <bpf+bounces-49195-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F134BA150ED
	for <lists+bpf@lfdr.de>; Fri, 17 Jan 2025 14:52:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AA6D16914D
	for <lists+bpf@lfdr.de>; Fri, 17 Jan 2025 13:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99B681FF61D;
	Fri, 17 Jan 2025 13:52:53 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from gnu.wildebeest.org (gnu.wildebeest.org [45.83.234.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F17525A62F
	for <bpf@vger.kernel.org>; Fri, 17 Jan 2025 13:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.83.234.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737121973; cv=none; b=rqEzv3HHvu/fZYfiUYFNkV9Aph9DekgXJuJQVvAdpz+Fw1KRWSBuRl11zR8emhWmGV0X4cKCrtPBaOMC8akntqIHS8DvEm10mHZgS2ktV+ho8oU/+4HF6ljKRT+vD0EcaiuELERP45VcIRnrxr5SHJw0kVKNyqOsJDkG8/MdPkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737121973; c=relaxed/simple;
	bh=wDvNPxQUP+pGGVRgl07cG67USkpxL7Yt3UwNTTU59R0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TkI5IXylOh0WuIECXbtHf9KpP0uQyOsAVC9j7rTvLl5YgBZh9Ltuh3g+t27kUSAfVdOLH6hnXT7eJI98FsnhAzvo6kH2jQhaFH33PJP/UOxTliN6gpstOWzQK0EvkCeubGhOQ9p2M2JKleWKRRC75rskboAvCE4jowfV6wScBZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=klomp.org; spf=pass smtp.mailfrom=klomp.org; arc=none smtp.client-ip=45.83.234.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=klomp.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=klomp.org
Received: by gnu.wildebeest.org (Postfix, from userid 1000)
	id E00933032F85; Fri, 17 Jan 2025 14:44:34 +0100 (CET)
Date: Fri, 17 Jan 2025 14:44:34 +0100
From: Mark Wielaard <mark@klomp.org>
To: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: Andrew Pinski via Gcc <gcc@gcc.gnu.org>, bpf <bpf@vger.kernel.org>,
	Cupertino Miranda <cupertino.miranda@oracle.com>,
	"Jose E. Marchesi" <jose.marchesi@oracle.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Manu Bretelle <chantra@meta.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Mykola Lysenko <mykolal@fb.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	David Faust <david.faust@oracle.com>,
	Andrew Pinski <pinskia@gmail.com>, fche@elastic.org
Subject: Re: Announcement: GCC BPF is now being tested on BPF CI
Message-ID: <20250117134434.GC29102@gnu.wildebeest.org>
References: <mMhcrHuvf5fyjPwMa19kug9DHQH9yYcCJXKfaFMXhfQlKIuColex7zg7G6qpPqlfF74-IqzkhpZSlzsgvgikc-u6oQp27dNzFQAAatRaEuU=@pm.me>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mMhcrHuvf5fyjPwMa19kug9DHQH9yYcCJXKfaFMXhfQlKIuColex7zg7G6qpPqlfF74-IqzkhpZSlzsgvgikc-u6oQp27dNzFQAAatRaEuU=@pm.me>
User-Agent: Mutt/1.5.21 (2010-09-15)

Hi Ihor,

On Thu, Jan 16, 2025 at 08:44:54PM +0000, Ihor Solodrai via Gcc wrote:
> An example of successful test run (you have to login to github to see
> the logs):
> https://github.com/kernel-patches/bpf/actions/runs/12816136141/job/35736973856
> 
> Currently 2513 of 4340 tests pass for GCC BPF, so a bit more than a half.

Nice. Could you make the logs public so people don't have to create a
github account? Or post the results to gcc-testresults@gcc.gnu.org so
others can easily inspect them. You can also submit them to bunsen of
course.

Thanks,

Mark

