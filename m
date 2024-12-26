Return-Path: <bpf+bounces-47639-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D6639FCDCB
	for <lists+bpf@lfdr.de>; Thu, 26 Dec 2024 22:12:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08D0F188340C
	for <lists+bpf@lfdr.de>; Thu, 26 Dec 2024 21:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79DC7176ADE;
	Thu, 26 Dec 2024 21:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rUpgILfY"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED317155A30;
	Thu, 26 Dec 2024 21:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735247518; cv=none; b=LZIHv+OJndpLz9icuAEI7HD+8S3JSQiNgAIgb/p3/K8kK4EYTOLHi+7YYBrqG6Wh0Usw0+9pPcD4P5ipESCyC0XLaKncfoFwLYpVtiQBYY7PMQRIv4g1BArPsHTnJLt1vFQWCNaeRzchp+oeo9UukobTE8BorXMdYHjezTaK624=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735247518; c=relaxed/simple;
	bh=DHcPEY8VuZ2nscJsB7wWbIECPVRERUtAk+u+xzNjpIE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HXaW0E86WU99Py/U7XtdPNZ/ygu4AuvKa8WZQweALT656KSeWyfdH6RG5GC6oFTh7PzdsB5jApMKp691SZH7jLwHgaNSrsQDV5UGTLASGn3V2PLtF/fk2Pko/BbR0uTOUMVxdWlsGXnISeNpZ9hC1lgMqGxV+XrHLAxSiVBnufQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rUpgILfY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3A4EC4CED1;
	Thu, 26 Dec 2024 21:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735247517;
	bh=DHcPEY8VuZ2nscJsB7wWbIECPVRERUtAk+u+xzNjpIE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rUpgILfYbfwcCyRMQNsdfr2PTZME79kwD1HxgrNsPU2X06yXxdhntFHlc6pAua3fm
	 D/B3sbu5cSkUL0f3d5NCS/FaFS1/ig6kLi+HvaxxPCzLgKf7mQxcCJ9EVOgO0ss63v
	 h0jVEf7811dsLQddQqMmewp6YN2B5ItXuELLhcSPe+kBM6rL8rgxvYpxnoI1OJLAgO
	 rq78GyxM2YnPJaIqins6KA2fXvB7+53ooWQwYl/ESYtXkeVrtpvdFQKE4x7RnZjxmi
	 HHKkglP67C9IXlvwe2RowmCoBhHmuKzRV7V2U/TFn4y0ceDF/sMI9X49d6ghg0ciEZ
	 H90aDD/NcGegQ==
Date: Thu, 26 Dec 2024 18:11:54 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, dwarves@vger.kernel.org,
	arnaldo.melo@gmail.com, bpf@vger.kernel.org, kernel-team@fb.com,
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	yonghong.song@linux.dev
Subject: Re: [PATCH dwarves v1 2/2] tests: verify that pfunct prints
 btf_decl_tags read from BTF
Message-ID: <Z23Gmu_ot8svVJnx@x1>
References: <20241211021227.2341735-1-eddyz87@gmail.com>
 <20241211021227.2341735-2-eddyz87@gmail.com>
 <e7247151-ad60-402c-a3f8-ce976ea03dc0@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e7247151-ad60-402c-a3f8-ce976ea03dc0@oracle.com>

On Thu, Dec 12, 2024 at 07:50:57PM +0000, Alan Maguire wrote:
> On 11/12/2024 02:12, Eduard Zingerman wrote:
> > When using BTF as a source, pfunct should now be able to print
> > btf_decl_tags for programs like below:
> > 
> >   #define __tag(x) __attribute__((btf_decl_tag(#x)))
> >   __tag(a) __tag(b) void foo(void) {}
> > 
> > This situation arises after recent kernel changes, where tags 'kfunc'
> > and 'bpf_fastcall' are added to some functions. To avoid dependency on
> > a recent kernel version test this by compiling a small C program using
> > clang with --target=bpf, which would instruct clang to generate .BTF
> > section.
> > 
> > Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> 
> nit: the test is great but it would be good to print out a description
> even in non-verbose mode; when I run it via ./tests I see
> 
>   5: Ok
> 
> could we just echo the comment below, i.e.
> 
> 5 : Check that pfunct can print btf_decl_tags read from BTF: Ok
> 
> ?
> 
> Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
> Tested-by: Alan Maguire <alan.maguire@oracle.com>

Thanks, applied.

- Arnaldo


