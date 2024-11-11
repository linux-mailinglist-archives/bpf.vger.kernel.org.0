Return-Path: <bpf+bounces-44537-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FA8B9C4525
	for <lists+bpf@lfdr.de>; Mon, 11 Nov 2024 19:42:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43A6C280A8B
	for <lists+bpf@lfdr.de>; Mon, 11 Nov 2024 18:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A43E91AA7AE;
	Mon, 11 Nov 2024 18:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MoAaWyJj"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C76B78C9C
	for <bpf@vger.kernel.org>; Mon, 11 Nov 2024 18:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731350527; cv=none; b=Tox/GoXzNsn6zP+j2fl92QBFxuuZvCWztZElcajJNBN1UUPu5e5zjhSMyZ8+/YIXoLjye+tMZMV04EWnOFzncjJKjaThSsgycmSu3pIcjBtTn5PhYbRA/800dJ7m1aj2tQ6b2nZY3ImBS6/k2RVHyuPt1p6g42M0E8zkwhHXcwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731350527; c=relaxed/simple;
	bh=MN41gILKgpYit5vtWB8O8uSZtfamfkLu2BYQeA9KOz0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pUdnoi0fwbVJd4fXxgm9GM5kSkHJEvm8FKqgeKAfmRtAhSqBqmtmB4JMhwJvaYYHcmvj5Jm+38yJyxKunOeULcXuklsiAIZqnlTVi3RSie7nI2RP9it+E/wiKX7JnHJRw+HnilMLLGCWl+4kO8Lc+K+b6NzKR8Fro9ij9v0lW4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MoAaWyJj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70EACC4CECF;
	Mon, 11 Nov 2024 18:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731350525;
	bh=MN41gILKgpYit5vtWB8O8uSZtfamfkLu2BYQeA9KOz0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=MoAaWyJjNlja6rgDE5UeR4xYAkB9KpGNZQ7Z0o6vU/ns3njfAKEnabVrHAobYqOC2
	 rZk2lmGgCrStMa+I6fk/H2U+QSBxNS4kDh3WxI95pCHQsrl3csjDBeelTBjpmkBezw
	 2bQWwpgwOHzxhgjAAOos+zwlLI3lzmoBYKyXOGIbR7p7sYbcwgEn4z6XMi13Co/kDL
	 PcmuqvxQE6tfuDVUvhCtSASF+yrp1NcB/WivscfCpqgTaScDGrRrIBB+1thTSaH88S
	 JtZ+gmSloWfTPD+W626a8lSBNsb7ODCsNv/SVrJMzv8IgdGaMOpE3ZtqTnsrEI3Evz
	 TH4FhZAF2L1Tw==
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 94C93164CC9D; Mon, 11 Nov 2024 19:42:02 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org, ast@kernel.org
Cc: andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
 kernel-team@fb.com, yonghong.song@linux.dev, memxor@gmail.com, Jesper
 Dangaard Brouer <hawk@kernel.org>
Subject: Re: [RFC bpf-next 00/11] bpf: inlinable kfuncs for BPF
In-Reply-To: <df225223880f0afe898d6e766da22f1c4df6b580.camel@gmail.com>
References: <20241107175040.1659341-1-eddyz87@gmail.com>
 <87v7wx5uh7.fsf@toke.dk>
 <df225223880f0afe898d6e766da22f1c4df6b580.camel@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Mon, 11 Nov 2024 19:42:02 +0100
Message-ID: <87o72l4nph.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Eduard Zingerman <eddyz87@gmail.com> writes:

> On Fri, 2024-11-08 at 21:41 +0100, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>
> [...]
>
> Hi Toke,
>
>> Back when we settled on the kfunc approach to reading metadata, we were
>> discussing this overhead, obviously, and whether we should do the
>> bespoke BPF assembly type inlining that we currently do for map lookups
>> and that sort of thing. We were told that the "right" way to do the
>> inlining is something along the lines of what you are proposing here, so
>> I would very much encourage you to continue working on this!
>>=20
>> One complication for the XDP kfuncs is that the kfunc that the BPF
>> program calls is actually a stub function in the kernel core; at
>> verification time, the actual function call is replaced with one from
>> the network driver (see bpf_dev_bound_resolve_kfunc()). So somehow
>> supporting this (with kfuncs defined in drivers, i.e., in modules) would
>> be needed for the XDP use case.
>
> Thank you for the pointer to bpf_dev_bound_resolve_kfunc().
> Looking at specialize_kfunc(), I will have to extend the interface for
> selecting inlinable function body. The inlinable kfuncs already could
> be defined in modules, so this should be a relatively small adjustment.

Awesome!

>> Happy to help with benchmarking for the XDP use case when/if this can be
>> supported, of course! :)
>>=20
>> (+Jesper, who I'm sure will be happy to help as well)
>
> Thank you, help with benchmarking is most welcome.
> Very interested in real-world benchmarks, as I'm not fully sold on
> this feature, it adds significant layer of complexity to the verifier.
> I'll reach to you and Jesper after adding support for inlining of XDP
> metadata kfuncs.

Sounds good, thanks!

-Toke

