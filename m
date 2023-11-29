Return-Path: <bpf+bounces-16107-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 609827FCE01
	for <lists+bpf@lfdr.de>; Wed, 29 Nov 2023 05:42:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A73FA2831EF
	for <lists+bpf@lfdr.de>; Wed, 29 Nov 2023 04:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61DAB3FFE;
	Wed, 29 Nov 2023 04:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jqBM/9BJ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF2FD6FA5
	for <bpf@vger.kernel.org>; Wed, 29 Nov 2023 04:42:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D434FC433C7;
	Wed, 29 Nov 2023 04:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701232931;
	bh=1LVirSriegKhP6Z/Y3qmyocBcXCTZCynUckR9oUqC8A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jqBM/9BJgHyGIJ1bPabdH22VqMUKibraS89fIVlAM8MmOYTFC6waUJoo+J4VAJUnC
	 kjLbagxfk3CvDm7qTVQDL+tRU4qdF3b3uv4GNk9p5t/Ra0HnfpQgzOv20U28HK2N0E
	 7pM5I9hnyfkJNcWTOvzsm9EnQ1al3I1sEWDmHK8U4hFM9wv8EIyxdQWqOlbii/P/1G
	 6WQ56TlTg0CugzVbUa8WZ0S2rxdr3tXHFoSivXpqawl4VRCv9IYwv4burRa7WUfO9p
	 wS4w8u5wUAFOje1/wDZdOTZTNH30MrsPMj1R7swJPpFIQcfFp5NbKIwTTzz38CX9li
	 cTPi7qX/UbNBw==
Date: Tue, 28 Nov 2023 20:42:08 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: mingo@redhat.com, tglx@linutronix.de, bp@alien8.de, x86@kernel.org,
	leit@meta.com, linux-kernel@vger.kernel.org,
	pawan.kumar.gupta@linux.intel.com,
	"open list:BPF [MISC]:Keyword:(?:b|_)bpf(?:b|_)" <bpf@vger.kernel.org>
Subject: Re: [PATCH v6 00/13] x86/bugs: Add a separate config for each
 mitigation
Message-ID: <20231129044208.v4crl7yfibuw6rfx@treble>
References: <20231121160740.1249350-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231121160740.1249350-1-leitao@debian.org>

On Tue, Nov 21, 2023 at 08:07:27AM -0800, Breno Leitao wrote:
> Currently, the CONFIG_SPECULATION_MITIGATIONS is halfway populated,
> where some mitigations have entries in Kconfig, and they could be
> modified, while others mitigations do not have Kconfig entries, and
> could not be controlled at build time.

All looks good to me, thanks!

Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>

-- 
Josh

