Return-Path: <bpf+bounces-70346-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A12AABB8067
	for <lists+bpf@lfdr.de>; Fri, 03 Oct 2025 22:07:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 620B24C3517
	for <lists+bpf@lfdr.de>; Fri,  3 Oct 2025 20:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D10BE21D3E6;
	Fri,  3 Oct 2025 20:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b="BPdnfDUN"
X-Original-To: bpf@vger.kernel.org
Received: from mx-rz-3.rrze.uni-erlangen.de (mx-rz-3.rrze.uni-erlangen.de [131.188.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED41A204F93
	for <bpf@vger.kernel.org>; Fri,  3 Oct 2025 20:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=131.188.11.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759522024; cv=none; b=qz6dD+vWJ7yl04NgbYPyh5BzaUyyFr72+s18JzRMfXjQTLNeDk/u9aUlcwZA/tQvXvCW94m3INTOJpTRkmsuLqUtyC2IaHKGPUjLofpduDXSE7puhReFEBNr3Z5d+Qw1+gxkvdOoY5F8vkT3z1e57g6XM9GgVRzvj5bAE60c8Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759522024; c=relaxed/simple;
	bh=TWxN4otPp0pz8coB2LWoyR1N8EqwEQNr9xccToEnb6c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uHyucJqAn9kQZdq9t+WNrTUi8CqyuO2Wu7fayDvIZDzd6GtmYII1gjMPT3IQR4z6VCga0Z0cRopYAB2Zk8C/bLi2wOJESSVNoVXsO/9NYYTf7ke0N+nJREe17onshugwlfZYvw+hvsVNEgRUO72xr2brS2a0f9N0H6JV7mCJdVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fau.de; spf=pass smtp.mailfrom=fau.de; dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b=BPdnfDUN; arc=none smtp.client-ip=131.188.11.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fau.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fau.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fau.de; s=fau-2021;
	t=1759521596; bh=TWxN4otPp0pz8coB2LWoyR1N8EqwEQNr9xccToEnb6c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From:To:CC:
	 Subject;
	b=BPdnfDUNarLqrW8zBDhTmlQ+HohuG16UUBvs9jWNjgLSMWxAiMYHvZqXYex6tZen0
	 TDRtw1myRPKi2vzoBpDYVrZ+G1fR4CIt/mtIA5oesOiO01DDsEZiE8lQjeKxtUXC2z
	 Txm54R4VoaR06QTI8RbWsOF9Fv6fKZH07iIfl2+m67bPqGP1DgNG26H2JuvGX1Li6W
	 O7Tl/mVXIpcX+KMflMhCKFSBl7YgmV2lNdmEuHsSXkAIfLkhnqifcbpEWUvQJDaIJX
	 tAhFeRK7V16hj4Nv2d1ixO4BrFzKr9w4MHd666WpKZdvuDuiCY3sXFR/uD/Q1onF9D
	 KnPkP3LfoDr6Q==
Received: from mx-rz-smart.rrze.uni-erlangen.de (mx-rz-smart.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::1e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-rz-3.rrze.uni-erlangen.de (Postfix) with ESMTPS id 4cdfdm1dpMz1y2m;
	Fri,  3 Oct 2025 21:59:56 +0200 (CEST)
X-Virus-Scanned: amavisd-new at boeck2.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 2001:9e8:3625:e000:56ed:e747:251a:4bef
Received: from localhost (unknown [IPv6:2001:9e8:3625:e000:56ed:e747:251a:4bef])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: U2FsdGVkX19XDJ+MJ108UTWpr1Qf5TKL+2wPO3kUVMI=)
	by smtp-auth.uni-erlangen.de (Postfix) with ESMTPSA id 4cdfdj1F7Dz1y2V;
	Fri,  3 Oct 2025 21:59:53 +0200 (CEST)
From: Luis Gerhorst <luis.gerhorst@fau.de>
To: Hengqi Chen <hengqi.chen@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,  Andrii Nakryiko
 <andrii@kernel.org>,  Yonghong Song <yonghong.song@linux.dev>,  Eduard
 Zingerman <eddyz87@gmail.com>,  Tiezhu Yang <yangtiezhu@loongson.cn>,  bpf
 <bpf@vger.kernel.org>
Subject: Re: Some unpriv verifier tests failed due to bpf_jit_bypass_spec_v1
In-Reply-To: <CAEyhmHTvj4cDRfu1FXSEXmdCqyWfs3ehw5gtB9qJCrThuUy2Kw@mail.gmail.com>
	(Hengqi Chen's message of "Tue, 23 Sep 2025 17:52:11 +0800")
References: <CAEyhmHTvj4cDRfu1FXSEXmdCqyWfs3ehw5gtB9qJCrThuUy2Kw@mail.gmail.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Fri, 03 Oct 2025 21:59:52 +0200
Message-ID: <878qhr69jb.fsf@fau.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hengqi Chen <hengqi.chen@gmail.com> writes:

> Some unpriv verifier tests (e.g. bounds_map_value_variant_2) failed
> on LoongArch which implements bpf_jit_bypass_spec_v1().
>
> This is because some verifier paths do can_skip_alu_sanitation().
> So for such cases, the priv/unpriv test cases will have the same
> verifier error messages and the tests failed with unexpected error
> messages.
>
> How can we fix them?

Please excuse the late reply.

The most simple fix would be to add the missing '#ifdef SPEC_V1' to
these tests, however, I anyway intend to send a new version of [1] which
removes some of these errors altogether. The patch did not get merged
with the rest of the series earlier because there was a merge conflict
with another fix (now resolved).

I ran the CI with bypass_spec_v1 set for x86 to reproduce your issue [2]
and the patch fixes some of the tests as expected [3]. Can you confirm
this is the same for LoongArch?

Some test still fail because the '#ifdef SPEC_V1' is still missing for
them. I will prepare a patch to resolve this.

[1] https://lore.kernel.org/all/CAADnVQLC_zViaCs5Huu63Jr2oCx1NGY3f_VCkJhrKvqst7HL=g@mail.gmail.com/
[2] https://github.com/kernel-patches/bpf/pull/9929
[3] https://github.com/kernel-patches/bpf/pull/9927

