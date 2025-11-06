Return-Path: <bpf+bounces-73853-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D958C3B141
	for <lists+bpf@lfdr.de>; Thu, 06 Nov 2025 14:07:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 00BDB502DD7
	for <lists+bpf@lfdr.de>; Thu,  6 Nov 2025 13:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5D3A32D0E6;
	Thu,  6 Nov 2025 12:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cyOt8O6C"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D99132B98E;
	Thu,  6 Nov 2025 12:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762433688; cv=none; b=hQIrZXpza8cuOTpp7TpitTXLX+cyaDa8lKs5jFhChPUTeEgfeXJwyjnQKMGlzxB6nlInczNnUlaAVzGLriVaE8mC3YLOagXXj+ILtxwJWLdFKbTfXkm08SiDcH37b22Wds4v6t9J0o4VyCGrFpEOp7rRz200iWMLPEFzbak1kmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762433688; c=relaxed/simple;
	bh=W28dHcSlN8qh6sPyfIcXqe07mVpPpIojIVRYU4wG5xM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UFoa+Vl2u3W0UTFd097TNyBJFgyb5VaWZUPrJdNi3VDCRRogQvPlQSRh5VE2JOZDHN/J4bz58P/J5zhxNV3Mvhg4LC9VEaE0ittdauQc9Z1QckrnM+Bc4HRwUoZlCkvHfxGCGc2ccWKsTe/l3qHOKV16dODXTUD0ha1IPlE8DM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cyOt8O6C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD443C4CEF7;
	Thu,  6 Nov 2025 12:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762433688;
	bh=W28dHcSlN8qh6sPyfIcXqe07mVpPpIojIVRYU4wG5xM=;
	h=Date:Reply-To:Subject:To:Cc:References:From:In-Reply-To:From;
	b=cyOt8O6CBj0lf63GmmTG4Xi61GHtdsG5/GzAEuoyENSLpetQFbvQAhT/+x7e+LwLk
	 qRVRb9eCVFXp6yyeGkC+gwZRb+PYWlmqVX3KmOKbHCUHGmHs98Mue/Z7Hx1H4OWIx8
	 Z7b/V2Olmi80MNC0ZAUZPKS33yaSpn2da/DsZRjaBPPfuLr6vhX5NKMz2f8Jt5a6Pj
	 aw7ZJe+x2NNGnV1Vf7Ok680zC/t18J16rVxsYIt1jJsfNIkDiJG7WpPqHImsLv4LFP
	 kDQpG33bh9PpaM/bzVc0MWCsAI0CnbALaPSOXYSL6Evx2xne+uM8x4cuLPL85fbkcd
	 G9tfzh1MbqL/A==
Message-ID: <56a75d5e-1864-425b-876a-2636c4cd2ed9@kernel.org>
Date: Thu, 6 Nov 2025 13:54:42 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: Daniel Gomez <da.gomez@kernel.org>
Subject: Re: [PATCH 1/6] module: Add helper function for reading
 module_buildid()
To: Petr Mladek <pmladek@suse.com>, Petr Pavlu <petr.pavlu@suse.com>,
 Steven Rostedt <rostedt@goodmis.org>, Alexei Starovoitov <ast@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Kees Cook <kees@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Luis Chamberlain <mcgrof@kernel.org>, Sami Tolvanen
 <samitolvanen@google.com>, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, linux-modules@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
References: <20251105142319.1139183-1-pmladek@suse.com>
 <20251105142319.1139183-2-pmladek@suse.com>
Content-Language: en-US
From: Daniel Gomez <da.gomez@kernel.org>
Organization: kernel.org
In-Reply-To: <20251105142319.1139183-2-pmladek@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 05/11/2025 15.23, Petr Mladek wrote:
> Add a helper function for reading the optional "build_id" member
> of struct module. It is going to be used also in
> ftrace_mod_address_lookup().
> 
> Use "#ifdef" instead of "#if IS_ENABLED()" to match the declaration
> of the optional field in struct module.
> 
> Signed-off-by: Petr Mladek <pmladek@suse.com>

Reviewed-by: Daniel Gomez <da.gomez@samsung.com>

