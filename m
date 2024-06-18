Return-Path: <bpf+bounces-32432-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A186390DCEA
	for <lists+bpf@lfdr.de>; Tue, 18 Jun 2024 21:56:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BF2A285066
	for <lists+bpf@lfdr.de>; Tue, 18 Jun 2024 19:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBA0516D4F2;
	Tue, 18 Jun 2024 19:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YTiZQXsR"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5290E15E5BB
	for <bpf@vger.kernel.org>; Tue, 18 Jun 2024 19:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718740608; cv=none; b=E/Yd5v58ZoNrFsb44MOFhqOks4gNf/krFEEWjbWoBy+foENE+mw2D4R769E9hoMQqc5cYIkz/RdkbWv2wUSIDmqsF9sdSgAkdbGd2cYefZ+3LMVmCseVSCJy7qCNHUCzOC1uwjQmKlGVngyon3LICHrs1LAFBo0sBFTJJa74NBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718740608; c=relaxed/simple;
	bh=e0CiQMJtYSv3jpn3idvu4EVI1oXxCR6BHeR3SEe2CSM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C5tIgpgoy63g4v5anqt5xEEgBtsWsCoyR0ZM4+fA47A2N1Bd92fvTqR/xqRNJPhz5jx9H/ff7SWlYr7fiHyCuEgC01I8gMHwGTyss8uawx73KXG6vo4FYkNFYZPo02EzAe8d+X8ypr2mCbKkKLEtFjWs9Nk+zl1Hgx1jLct3Kno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YTiZQXsR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8961CC3277B;
	Tue, 18 Jun 2024 19:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718740607;
	bh=e0CiQMJtYSv3jpn3idvu4EVI1oXxCR6BHeR3SEe2CSM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=YTiZQXsRrxp/0Guo9PcVxPAzFjh5SP8QVN1ikDvcDv8J3e3adXI3t9wzGGB8TWA2r
	 Fk3Zs/0WhQoY5RtocsalLQ9pLtTzNSkd0iOp1qQ45jS8gV/l9rKCjjaasd/QXKy3F2
	 V65JJuidpZ33c6SVdTHE/qg1Gerwt9nsy9mqln0NkGwx6W+iW4hKYeEFcWLnv33kGA
	 x+3SdPlNSv9Gm/jfm4jbspP0PplCYzsmcZ1IadPOTvKzogaCFvcHZHSpNMb2rARdCy
	 w7/vZbhe9qw90vZS/p4YHqBe93eLOe29DyjP8gKkyjoeh8UNd1CMgVhfCRB1zZLLiw
	 8CKXTCgbSX5vA==
Message-ID: <073d8c8c-14bf-49c0-bc14-1e1d53b3e603@kernel.org>
Date: Tue, 18 Jun 2024 20:56:44 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH bpf-next] bpftool: allow compile-time checks of BPF map
 auto-attach support in skeleton
To: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org,
 daniel@iogearbox.net, martin.lau@kernel.org
Cc: tj@kernel.org, void@manifault.com
References: <20240618183832.2535876-1-andrii@kernel.org>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <20240618183832.2535876-1-andrii@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18/06/2024 19:38, Andrii Nakryiko wrote:
> New versions of bpftool now emit additional link placeholders for BPF
> maps (struct_ops maps are the only maps right now that support
> attachment), and set up BPF skeleton in such a way that libbpf will
> auto-attach BPF maps automatically, assumming libbpf is recent enough
> (v1.5+). Old libbpf will do nothing with those links and won't attempt
> to auto-attach maps. This allows user code to handle both pre-v1.5 and
> v1.5+ versions of libbpf at runtime, if necessary.
> 
> But if users don't have (or don't want to) control bpftool version that
> generates skeleton, then they can't just assume that skeleton will have
> link placeholders. To make this detection possible and easy, let's add
> the following to generated skeleton header file:
> 
>   #define BPF_SKEL_SUPPORTS_MAP_AUTO_ATTACH 1
> 
> This can be used during compilation time to guard code that accesses
> skel->links.<map> slots.
> 
> Note, if auto-attachment is undesirable, libbpf allows to disable this
> through bpf_map__set_autoattach(map, false). This is necessary only on
> libbpf v1.5+, older libbpf doesn't support map auto-attach anyways.
> 
> Libbpf version can be detected at compilation time using
> LIBBPF_MAJOR_VERSION and LIBBPF_MINOR_VERSION macros, or at runtime with
> libbpf_major_version() and libbpf_minor_version() APIs.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Looks good, thanks.

Acked-by: Quentin Monnet <qmo@kernel.org>

