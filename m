Return-Path: <bpf+bounces-26670-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B6E98A37AF
	for <lists+bpf@lfdr.de>; Fri, 12 Apr 2024 23:13:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36F862813B2
	for <lists+bpf@lfdr.de>; Fri, 12 Apr 2024 21:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76F3515218A;
	Fri, 12 Apr 2024 21:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JOXjBjMz"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD021514EF;
	Fri, 12 Apr 2024 21:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712956148; cv=none; b=R274oU0cgyrAotSr1gXXpi9CRjNFb53I0/vhH5Jmvp4VggS7Ob14LeCjWJOWWirJGhyyyxAZOdehitlFLDR/ph55TkpckTGWoOoPOTtLWSyNdN2cUGVuC/FPxvRaNzqtr+k4pL0SyCufhyQv7srcroBDU3UcKk0uIlXpVfqo2hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712956148; c=relaxed/simple;
	bh=ACmPMwfcnfU0/+SOBeXJp7biGwYBHQv3ZtVuFx8xAm8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZBbqJVF3hZUbntxGuLLYBz2dCdR6/hXNFr2R/nke41FRT4DXxFjPORn71SizNfW2NZOpgmu3Uo9q9G9anNehRwjd0QjowoT2l4/qXHhJyLrtnAAV4iWQ1dlHlwlT1ewNBT9wPqnYlgRXuxQ5A/PguOGQjFeAHCNqOTBUOJLLYjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JOXjBjMz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EEF2C113CC;
	Fri, 12 Apr 2024 21:09:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712956147;
	bh=ACmPMwfcnfU0/+SOBeXJp7biGwYBHQv3ZtVuFx8xAm8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JOXjBjMzv3+e/7xnWoecmLYYZW+ZyNVMcxnASSpXXZHGOIHyN8r+W+YlAOSe7eHx1
	 +R+MXQ2Hd2XTyaFCQM0BFQ2AMKiQhTGQfh+xtZr3CVwt3mmx1lVTb/uEWTQt48l4cs
	 xVmxwFFKPES+Aizj2MZZmPWvmlFGessWvt8uUaE6LY1AOGKzYnipR38Z8TXOUHoEjn
	 L5lvb1gBRWbvge9wz11xRwm5q8DLSpJvLeEBu/3CmtUSwnjvzZ23duy1xsFcxJsd/g
	 VeaQJW0B2GBNqGqZhWWLxTTnYpQArMy6xhyRe0+jK6QnR55JBEEMQiXUcV/4hO8dUM
	 5Cy04jTRPQktQ==
Date: Fri, 12 Apr 2024 18:09:04 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>, dwarves@vger.kernel.org,
	Jiri Olsa <jolsa@kernel.org>, Clark Williams <williams@redhat.com>,
	Kate Carcia <kcarcia@redhat.com>, bpf@vger.kernel.org,
	Kui-Feng Lee <kuifeng@fb.com>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Subject: Re: [RFC/PATCHES 00/12] pahole: Reproducible parallel DWARF
 loading/serial BTF encoding
Message-ID: <Zhmi8OEthfzafTIh@x1>
References: <20240402193945.17327-1-acme@kernel.org>
 <747816d2edd61a075d200ffa5da680d2cc2d6854.camel@gmail.com>
 <64bfcf02-030d-471a-871a-e7490d74ca28@oracle.com>
 <db6480e9378f59c367b03f7455372caf7b593348.camel@gmail.com>
 <ZhmbiFdtYN3tlG6u@x1>
 <fcaf2c3d2134ae6ecbfbd17dbaa574373ff7ab03.camel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fcaf2c3d2134ae6ecbfbd17dbaa574373ff7ab03.camel@gmail.com>

On Fri, Apr 12, 2024 at 11:40:44PM +0300, Eduard Zingerman wrote:
> On Fri, 2024-04-12 at 17:37 -0300, Arnaldo Carvalho de Melo wrote:
> > On Tue, Apr 09, 2024 at 05:34:46PM +0300, Eduard Zingerman wrote:
> > > Still, there are a few discrepancies in generated BTFs: some function
> > > prototypes are included twice at random (about 30 IDs added/deleted).
> > > This might be connected to Alan's suggestion and requires
> > > further investigation.
> > > 
> > > All in all, Arnaldo's approach with CU ordering looks simpler.
> > 
> > I'm going, for now, with the simple approach, can I take your comments
> > as a Reviewed-by: you?
> 
> If you are going to post next version I'll go through the new series
> and ack the patches (I understand the main idea but did not read the
> series in detail).

Ok, its now in the next branch, I'll repost here as well.

- Arnaldo

