Return-Path: <bpf+bounces-18873-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63088823145
	for <lists+bpf@lfdr.de>; Wed,  3 Jan 2024 17:28:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAE3D282825
	for <lists+bpf@lfdr.de>; Wed,  3 Jan 2024 16:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE7531BDD5;
	Wed,  3 Jan 2024 16:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VYNNsop/"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 578A51BDC9
	for <bpf@vger.kernel.org>; Wed,  3 Jan 2024 16:27:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97D52C433C8;
	Wed,  3 Jan 2024 16:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704299265;
	bh=9ru3mfN6O6qIWL5QHufl8Z+6ewvJKNZsbNmreeb0eYE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VYNNsop/I4LaDMZsBbmmPawGbUaxbnFA4o8vS+ZDDRGP63pbvDG1NrI+ctS+PwNBB
	 XeoZrF3Erb/+cwAzTgZkfe3AYB7M28w8RxCsskX1wi88WULvHKr3KAMkDOfbzmJ7mY
	 ZcHKmPIvSwn8VG3BFPGhPqrCWIY5KI8nrpaA++lE=
Date: Wed, 3 Jan 2024 17:27:41 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Maxwell Bland <mbland@motorola.com>
Cc: "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: FW: BPF-NX+CFI is a good upstreaming candidate
Message-ID: <2024010317-undercoat-widow-e087@gregkh>
References: <SEZPR03MB6786598744F4D5DE29C46651B4602@SEZPR03MB6786.apcprd03.prod.outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SEZPR03MB6786598744F4D5DE29C46651B4602@SEZPR03MB6786.apcprd03.prod.outlook.com>

On Wed, Jan 03, 2024 at 04:06:32PM +0000, Maxwell Bland wrote:
> Forwarding to BPF mailing list as plaintext to match the mail server restrictions.
> 
> From what I understand, Linux security team is reactive rather than
> proactive, so maybe the below is a moot point, but I'd love to see
> BPF-NX+CFI if possible.

security@kernel.org is reactive, as that is it's requirement, but there
are many other groups that work on proactive security, see the
linux-hardening project for lots of work happening there that is adding
loads of good stuff to the kernel.

> 
> Originally sent to di_jin@brown.edu; v.atlidakis@gmail.com; vpk@cs.brown.edu; dborkman@kernel.org; lsf-pc@lists.linux-foundation.org; bpf@vger.kernel.org; Andrew Wheeler <awheeler@motorola.com>; Sammy BS2 Que | 阙斌生 <quebs2@motorola.com>
> 
> Dear Jin et al. Daniel Borkman, and LSF/BPF mailing lists,
> 
> Although a few months late, Jin et al.’s USENIX ATC’23 EPF publication here (https://cs.brown.edu/~vpk/papers/epf.atc23.pdf) is great. It was a relief to see the efforts in https://gitlab.com/brown-ssl/epf/-/blob/master/linux-5.10/patches/0003-Adding-BPF-NX.patch?ref_type=heads and related files.
> 
> BPF-NX+CFI would/could/should be a great upstreaming candidate. I am not sure how well BPF-NX+CFI generalizes to the full kernel ecosystem given the approach requires a dedicated vmalloc memory region, but the idea PXN is no longer be enforced at a PMD-level granularity because of eBPF is unfortunate.
> 
> BPF-ISR is likely overkill performance-wise as a mechanism and can be handled/refined via kprobes rather than direct patches.
> 
> Jin et al., do you happen to have performance numbers for just NX+CFI, or knowledge of how well this may apply to 6.*+ kernels? With your blessing, and if the mailing list peers are supportive, we should discuss your work and BPF security at https://events.linuxfoundation.org/lsfmmbpf/program/cfp/.

Are there working patches somewhere?  5.10.y is very old and obsolete.

thanks,

greg k-h

