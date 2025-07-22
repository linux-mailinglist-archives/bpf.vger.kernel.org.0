Return-Path: <bpf+bounces-63998-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 827D8B0D166
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 07:49:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF3417A93BA
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 05:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAABE28C84A;
	Tue, 22 Jul 2025 05:49:45 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22DDB28C030
	for <bpf@vger.kernel.org>; Tue, 22 Jul 2025 05:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753163385; cv=none; b=YKM+4ikRp6mwbi0yG2N36MMaVqzk6fE7NRqRwDQU0JbQqirADK/C9fePDb2YLriKzqCgagt/Qqe/TZL1H5N4EyEk0IJ+HbQ+MT3wL7h7sXsvS/jRT++Qya4WLLrxH+3mWVbEYY8dTsD309gv2HwQNYspwDnKMKzINpNupYGS/IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753163385; c=relaxed/simple;
	bh=OLmQBVvr8sUK94FODMo2oPiARQIUhTsc6GYXGiLNw7A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qgxZnKr6IzVlUYCluos+rqXBbU4ODErz8jzClvgVH4dY8SpgrMt2gC/JqmBQJWngHgaj5yRN3uiakpaTs0k5XzYKN544W+J/TGSmtjHmiy2cJfFREwkbd4i6VyYt7V+GctNXmcJ40w4iQoEBc2WtNvuKjSF8UobuPEQ8yxsJGIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DEB04152B;
	Mon, 21 Jul 2025 22:49:36 -0700 (PDT)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 68B153F59E;
	Mon, 21 Jul 2025 22:49:36 -0700 (PDT)
Date: Tue, 22 Jul 2025 06:49:32 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Pingfan Liu <piliu@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jeremy Linton <jeremy.linton@arm.com>,
	Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
	Simon Horman <horms@kernel.org>, Gerd Hoffmann <kraxel@redhat.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Philipp Rudo <prudo@redhat.com>, Viktor Malik <vmalik@redhat.com>,
	Jan Hendrik Farr <kernel@jfarr.cc>, Baoquan He <bhe@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	kexec@lists.infradead.org, bpf@vger.kernel.org
Subject: Re: [PATCHv4 10/12] arm64/kexec: Add PE image format support
Message-ID: <aH8mbFzwiKM9MMgm@arm.com>
References: <20250722020319.5837-1-piliu@redhat.com>
 <20250722020319.5837-11-piliu@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250722020319.5837-11-piliu@redhat.com>

On Tue, Jul 22, 2025 at 10:03:17AM +0800, Pingfan Liu wrote:
> Now everything is ready for kexec PE image parser. Select it on arm64
> for zboot and UKI image support.
> 
> Signed-off-by: Pingfan Liu <piliu@redhat.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> To: linux-arm-kernel@lists.infradead.org

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

