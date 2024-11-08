Return-Path: <bpf+bounces-44393-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 188A39C26B1
	for <lists+bpf@lfdr.de>; Fri,  8 Nov 2024 21:42:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C49931F232D6
	for <lists+bpf@lfdr.de>; Fri,  8 Nov 2024 20:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 644311D221A;
	Fri,  8 Nov 2024 20:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rwt0qHKk"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E21D81C1F39
	for <bpf@vger.kernel.org>; Fri,  8 Nov 2024 20:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731098488; cv=none; b=Tm+9x3KJJBKopmFaxINNiZbCVYbvBBfV07b4Cd3GhwSuH+Y2nCdcdrKFcxGd/RlVkSB+uIMkKjTAzVdQK2NeXjapAp+elaieokltQYuSVI98hNUK3cy/s0JOKng/NxhR2kFJP/2kx6DkCeAKo548k8UpcBAT7Eobd2PlSM2vq8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731098488; c=relaxed/simple;
	bh=TP6vfAknshnOlqg527jUKnn0vG4L3rRRequ8mcqRQqA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RFkCd0KOE7HIIRGqYop1mq6PsrK71tSff/w7OH9CrPMtt5D/3WiB9L4viELUIXji8wYdbWx8W80hlMm1saX7OZkDmyefgyrTxZE3aCvGOd+S/laPl7G7+S+GQhGL1OP2CetNQi8T6mfaZvlP0VKFDvuy/9tSOrU+kTa1LwKQbFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rwt0qHKk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27880C4CED0;
	Fri,  8 Nov 2024 20:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731098487;
	bh=TP6vfAknshnOlqg527jUKnn0vG4L3rRRequ8mcqRQqA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Rwt0qHKkXr0uY9lVZwAu8Yn3uRQLmPtITLwnHg+wG2pcSA9Hxy6z+kOzoaFLcs/mo
	 yt1CBUGnO2w/Z9yZ7/D4rJ2TKViWHdNl+oxOGxrr4CaHzUOvJpRzawDDM2rHb2f1td
	 zqVluyX3ZBvaBKHGXHpCt7iU3FhGAR5VnBnrOeoP8I9yTyaNUPQ8fV3+nwhGKYy6J/
	 7/Vc3XQUjI7Ae33KEzaAL0dsjt+ZIPemi8tQhJSdtnLdjnLROL1LnFTRNqL4noNl0M
	 b5ugFPS6lOzOmN5GVo0L8vxV1C5GORu9zYXk9Xv7Hed+3gkupCfrk9aU4a/+YRIOYm
	 6TT3lwhvBguGg==
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 66703164C7C4; Fri, 08 Nov 2024 21:41:24 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org, ast@kernel.org
Cc: andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
 kernel-team@fb.com, yonghong.song@linux.dev, memxor@gmail.com, Eduard
 Zingerman <eddyz87@gmail.com>, Jesper Dangaard Brouer <hawk@kernel.org>
Subject: Re: [RFC bpf-next 00/11] bpf: inlinable kfuncs for BPF
In-Reply-To: <20241107175040.1659341-1-eddyz87@gmail.com>
References: <20241107175040.1659341-1-eddyz87@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Fri, 08 Nov 2024 21:41:24 +0100
Message-ID: <87v7wx5uh7.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Eduard Zingerman <eddyz87@gmail.com> writes:

> Some time ago, in an off-list discussion, Alexei Starovoitov suggested
> compiling certain kfuncs to BPF to allow inlining calls to such kfuncs
> during verification. This RFC explores the idea.
>
> This RFC introduces a notion of inlinable BPF kfuncs.
> Inlinable kfuncs are compiled to BPF and are inlined by verifier after
> program verification. Inlined kfunc bodies are subject to dead code
> removal and removal of conditional jumps, if such jumps are proved to
> always follow a single branch.

Ohh, this is very exciting!

Mostly want to comment on this bit:

> Imo, this RFC is worth following through only if number of kfuncs
> benefiting from inlining is big. If the set is limited to dynptr
> family of functions, it is simpler to add a number of hard-coded
> inlining templates for such functions (similarly to what is currently
> done for some helpers).

One place where this would definitely be applicable is in all the XDP HW
metadata kfuncs. Right now, there's a function call for each piece of HW
metadata that an XDP program wants to read, which quickly adds up. And
in XDP land we are counting function calls, as the overhead (~1.1 ns) is
directly measurable in XDP PPS performance.

Back when we settled on the kfunc approach to reading metadata, we were
discussing this overhead, obviously, and whether we should do the
bespoke BPF assembly type inlining that we currently do for map lookups
and that sort of thing. We were told that the "right" way to do the
inlining is something along the lines of what you are proposing here, so
I would very much encourage you to continue working on this!

One complication for the XDP kfuncs is that the kfunc that the BPF
program calls is actually a stub function in the kernel core; at
verification time, the actual function call is replaced with one from
the network driver (see bpf_dev_bound_resolve_kfunc()). So somehow
supporting this (with kfuncs defined in drivers, i.e., in modules) would
be needed for the XDP use case.

Happy to help with benchmarking for the XDP use case when/if this can be
supported, of course! :)

(+Jesper, who I'm sure will be happy to help as well)

-Toke

