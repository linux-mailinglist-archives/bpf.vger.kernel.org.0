Return-Path: <bpf+bounces-46623-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E236D9ECD10
	for <lists+bpf@lfdr.de>; Wed, 11 Dec 2024 14:19:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCDF218840A0
	for <lists+bpf@lfdr.de>; Wed, 11 Dec 2024 13:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E978229126;
	Wed, 11 Dec 2024 13:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="PLZOYcKq"
X-Original-To: bpf@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F12E211A26
	for <bpf@vger.kernel.org>; Wed, 11 Dec 2024 13:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733923140; cv=none; b=dPdCLUPolZ3SR4XrrcND3ri8D5S7BGD2DLBBMY7mhrjzCdYP+fNJx47BTHt/u1m9BGqhVi7Sb2nhYu8hja5BtQ7rxrdBc3j3MOaSpMidnLh7NFlISvx1sG3SLPT6fVeq1lvm/kyMlOu/46F9SlF2sjaBElTp1fa770mjHRyYy8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733923140; c=relaxed/simple;
	bh=0BAVGXNmr29gyNAiZphZQqT7iy671vFWmAbgfaRCCNg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Eu0D8pWTnU8JUi0ilFO62RaOzH9mTVR+3ZsyTvJNtO6qGTBYHYaJYt6bHrgy5167LnQFMkDrcvIAMWyeDnu8QOKlNLJwbnnDHO/EgCn7LtoZNTD7jQeC0YpQJ3Lds9GktVyENmIRwhlIYsnrT5ubrpPjhuOZKYcTyMSvmMML5kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=PLZOYcKq; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-102-3.bstnma.fios.verizon.net [173.48.102.3])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 4BBDI4h6018729
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Dec 2024 08:18:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1733923090; bh=gi4bqeC1xRqwvT/VF8q1VhKSDS3m7sf4PVUwbny9KIA=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=PLZOYcKq8FoBjvOrAvFvTv+oXACy+CGaLNIbiA4Lo0ND1dVkIh4kwBg/TSTJgCnFU
	 /h6yP+xlNj43cqFrSFG0+c/ABitPdbmutfPk4FTb0yRPVGs+6t081qxjDQItuOQn6j
	 jaXlF91pcsAS26Ou8Edu5EPIZhIj/onZFbBZ+KVMfYRS3rNoBCeBF+impAQZgrdT7o
	 ZHdtsv27acQidbUYAJ3j4Yy53KOXfmhKvBsUIedf02VYaiquliiA9dgqoH9kjk5UrD
	 stcADOvEAGBegY4nf8fXfxVyqwr/H3NPzkRFPE6Zh3sQI/Ib9jp7t0r5Sd+a4cjZek
	 l5Zf9vg6GVWiA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 7ABDB15C6796; Wed, 11 Dec 2024 08:18:04 -0500 (EST)
Date: Wed, 11 Dec 2024 08:18:04 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Song Liu <song@kernel.org>
Cc: bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
        kernel-team@meta.com, andrii@kernel.org, eddyz87@gmail.com,
        ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
        kpsingh@kernel.org, mattbobrowski@google.com, liamwisehart@meta.com,
        shankaran@meta.com
Subject: Re: [PATCH v3 bpf-next 0/6] Enable writing xattr from BPF programs
Message-ID: <20241211131804.GA1912640@mit.edu>
References: <20241210220627.2800362-1-song@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241210220627.2800362-1-song@kernel.org>

On Tue, Dec 10, 2024 at 02:06:21PM -0800, Song Liu wrote:
> Add support to set and remove xattr from BPF program. Also add
> security.bpf. xattr name prefix.

If the system allows for the execution of unprivileged BPF programs
(e.g., ones where a random user can load their own BPF programs), will
they have hte ability to set and remove security.bpf.* xattrs?  If the
answer is yes, should this be disallowed?

I note that one of the use cases seems to be BPF-based LSM's, so we
may want to have something even more restrictive since otherwise any
BPF program could potentially have the same power as the LSM?

    	    	  	      	       	    - Ted

