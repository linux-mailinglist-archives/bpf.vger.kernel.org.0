Return-Path: <bpf+bounces-23286-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 267B886FF71
	for <lists+bpf@lfdr.de>; Mon,  4 Mar 2024 11:51:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9F8BB233B3
	for <lists+bpf@lfdr.de>; Mon,  4 Mar 2024 10:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA0893A8C9;
	Mon,  4 Mar 2024 10:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qiHA8ALo"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7EA374FC;
	Mon,  4 Mar 2024 10:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709549393; cv=none; b=b7vxRratOmp3b1dSfgbezS+VkEVIjv5ws7oq+6eO+AOamXfxKrSEfMTNMMcWN4cdJdLRkyeJUZn2SfXYQLLxbH5upPxIMgwWvLiOBrZ6qKxgzBPb99xFYeyLLPywBAVCcX31vKo8f833EJn9UMhE/ZNVXmWXlsy89kOgk4lGnZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709549393; c=relaxed/simple;
	bh=dyvRu7sPfvPIBPjCm23KBXSnjn0QohEtsPQ0hzhgvqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L2TpeLUD6wD4PG6FLm4+ds09JhcznVaBpYILuGGXv3VEZ/pJUbHUyn+oaaptF1cUpuN9jqRFcx9DGDPdI9MNuNzvR5WKqngCejCojfHi7qKjCy04oK9IRJrreBa9wH0Cj2qCIUlgwC1A1kj+ns5nATLtOLyz9P2ysVAnjDr0rQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qiHA8ALo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 553A3C433F1;
	Mon,  4 Mar 2024 10:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709549392;
	bh=dyvRu7sPfvPIBPjCm23KBXSnjn0QohEtsPQ0hzhgvqc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qiHA8ALoQGFSD4qZBk28GoChy9AAAEj7YGlagw1/gsw3uVxcZsNZBCx+07NXKM5bX
	 GH7xjal32jFXsLXskS74rgE1UkYQq6dkjrUhuyqU4IVCwCX+Q3rJCLfwlzISo4SEtm
	 Or1m60IiaCWOh8uL7v+T3G9jTGway2jUKfeBha6o=
Date: Mon, 4 Mar 2024 11:49:50 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Vamsi Krishna Brahmajosyula <vamsi-krishna.brahmajosyula@broadcom.com>
Cc: stable@vger.kernel.org, mike.kravetz@oracle.com, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, kafai@fb.com,
	songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
	kpsingh@kernel.org, dhowells@redhat.com, viro@zeniv.linux.org.uk,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, bpf@vger.kernel.org,
	ajay.kaher@broadcom.com, alexey.makhalov@broadcom.com,
	vasavi.sirnapalli@broadcom.com, Oscar Salvador <osalvador@suse.de>,
	Michal Hocko <mhocko@suse.com>, Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v5.15-v5.4] fs,hugetlb: fix NULL pointer dereference in
 hugetlbs_fill_super
Message-ID: <2024030440-deny-console-7212@gregkh>
References: <20240301070910.1287862-1-vamsi-krishna.brahmajosyula@broadcom.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240301070910.1287862-1-vamsi-krishna.brahmajosyula@broadcom.com>

On Fri, Mar 01, 2024 at 01:09:10AM -0600, Vamsi Krishna Brahmajosyula wrote:
> From: Oscar Salvador <osalvador@suse.de>
> 
> commit 79d72c68c58784a3e1cd2378669d51bfd0cb7498 upstream.

Now queued up, thanks.

greg k-h

