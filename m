Return-Path: <bpf+bounces-44966-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A9FEA9CF20F
	for <lists+bpf@lfdr.de>; Fri, 15 Nov 2024 17:49:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB764B2B16F
	for <lists+bpf@lfdr.de>; Fri, 15 Nov 2024 15:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2E181D5ABF;
	Fri, 15 Nov 2024 15:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dnd3hVW4"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329851BD507;
	Fri, 15 Nov 2024 15:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731686058; cv=none; b=jmEnZmttSZhXhRZzFpoK4wRculEVbzm2SKRR2ycEH0Dw5G+oyfqrqopq6RO2vyLwA7XxfbeZwsr1th0vWZ1IEj2UUI9781aw65ofSeE1mHEzFxCMnxmo/ehqtTt7bYjVQGQTfdwUXkfe9Rg4JyYtcP2opFUD/V4E5Uw2uNrA880=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731686058; c=relaxed/simple;
	bh=gb74Kc/q+nFSszw5N2j1YB6+1HAF1gP9acQGIF9Ek3o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TXqBAk9JtQQJ1DLK8q5dQ2Riyq1WV4MoG+nbrHgzztJyNmbtZSKJtCfqYJMwmJWI11n9wjOt+EFMxBrlalinA/MqdvHBtlCA2wz2thn9uWuJWoBPJvCrtVQAzejy19WPjfi74DYjExg4UnmaYF9s/oyXCSlfO3doHVBSLjMDZ5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dnd3hVW4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E4B5C4CECF;
	Fri, 15 Nov 2024 15:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731686056;
	bh=gb74Kc/q+nFSszw5N2j1YB6+1HAF1gP9acQGIF9Ek3o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dnd3hVW4g4lR9Z57JVZivswvhqCqws67TI7Ir0rI3QGgeGonPWu8jXoQwC9CoCfe/
	 Ot/jK0HULKEI3hsTVcAX//Oy+Fq91rnoPnPM9d02khpsB9c+leoOh6RmWbOP3gNSSb
	 5mk1qVtKiwoFIEItrupJ8s6uxU8CDwGoRv2r2vMzE00IfO/wIIoDBXR9v8XdKAEvjd
	 07YhujJ/CHplW2+M7YzaCBO8Bu+YmbvdrUsiSl52984wfLwDq84eKMX7aZiAN6bdmR
	 fUrcgzsHik5hFqXGpZMiPZkces3jurBCuyjxiKhbPosnmdwMNHOi35ktcl+i/hKCwz
	 nqKUVvcloiFTA==
Date: Fri, 15 Nov 2024 12:54:14 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: yonghong.song@linux.dev, dwarves@vger.kernel.org, ast@kernel.org,
	andrii@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net,
	kernel-team@fb.com, song@kernel.org, eddyz87@gmail.com,
	olsajiri@gmail.com
Subject: Re: [PATCH v3 dwarves 0/2] Check DW_OP_[GNU_]entry_value for
 possible parameter matching
Message-ID: <Zzdupj2ifjERTijl@x1>
References: <20241115113605.1504796-1-alan.maguire@oracle.com>
 <a1ffc678-5d72-45f5-a304-07be3cca7f86@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a1ffc678-5d72-45f5-a304-07be3cca7f86@oracle.com>

On Fri, Nov 15, 2024 at 11:40:16AM +0000, Alan Maguire wrote:
> On 15/11/2024 11:36, Alan Maguire wrote:
> > Currently, pahole relies on DWARF to find whether a particular func
> > has its parameter mismatched with standard or optimized away.
> > In both these cases, the func will not be put in BTF and this
> > will prevent fentry/fexit tracing for these functions.
> > 
> > The current parameter checking focuses on the first location/expression
> > to match intended parameter register. But in some cases, the first
> > location/expression does not have expected matching information,
> > but further location like DW_OP_[GNU_]entry_value can provide
> > information which matches the expected parameter register.
> > 
> > Patch 1 supports this; patch 2 adds locking around dwarf_getlocation*
> > as it is unsafe in a multithreaded environment.
> >
> 
> apologies, forgot to note
> 
> Changes since v2:
> 
> - handle multiple DW_OP_entry_value expressions by bailing if the
> register matches expected, otherwise save reg in return value (Eduard
> Yonghong, Jiri, patch 1)

Thanks, applied locally, will perform tests and push publicly later
today.

- Arnaldo
 
> > Alan Maguire (1):
> >   dwarf_loader: use libdw__lock for dwarf_getlocation(s)
> > 
> > Eduard Zingerman (1):
> >   dwarf_loader: Check DW_OP_[GNU_]entry_value for possible parameter
> >     matching
> > 
> >  dwarf_loader.c | 123 +++++++++++++++++++++++++++++++++++++++----------
> >  1 file changed, 98 insertions(+), 25 deletions(-)
> > 

