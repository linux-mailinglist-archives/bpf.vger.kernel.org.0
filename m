Return-Path: <bpf+bounces-48459-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 755C8A0822D
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 22:21:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75C3B3A5179
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 21:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5E3E202F9D;
	Thu,  9 Jan 2025 21:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PILpHPWF"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283544A1A;
	Thu,  9 Jan 2025 21:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736457672; cv=none; b=ltEiuX3XOI/HrNTD4NE7mF79+KKHzxYXncGVJJRFXuJWtr4BEAnBPlHZ9/tNYw1dBkgWkxDNdDqpYpvwixGTWBeyo3rMJQK2o1VZZ5Bi1JOyAi3rTPE7Qq2lFJ02fa3Et6ykEVXKM2IrE9tTqBcHoJL0MBUS6Pe3xO4n9ElYBbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736457672; c=relaxed/simple;
	bh=5eke31Xn2vgm4qap8irbfg9uOT0d8RFWOkMEN0yJSCI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ElK/QeRSDjd1GkDhsus+OArGrjPwaz+PQd/TnMIqFI2yvjAjytacEyH5OUh4VqayMUmh/yC8mbzHxqB+Xdem8kC7eTZkDmS4mwu85vUK0RNkdLer09h1F4iR5V8x+6rokZn6/rsQicP2INvCGNnCYsEMp4rVLg4soSIDH5K/YX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PILpHPWF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70FB0C4CED2;
	Thu,  9 Jan 2025 21:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736457671;
	bh=5eke31Xn2vgm4qap8irbfg9uOT0d8RFWOkMEN0yJSCI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PILpHPWFeqUTEiuS6cJSy128EsobswUe/zXIX2Fii7ZhtY2/GogSb+EesJ2NZqzRs
	 WOJ8OCzaDBHrgqUs53uKwHyJ667csPb1NmIpMdEmPs5e2v+bEwVcOzFhgOKlHYOvE6
	 5syIN/hNNX9cNoboK9/KVdf+hm6ihjQC/A18jG4f5On6tixqnERsRrFlKT/6EeqFRX
	 RI1m308/q4eMFGZpGl6iNwrRnUcCnOp4PmWT8jvx/pxjj1LHQSX6yjl0G/y8jey0+G
	 JqMNeQWTIc5uZEYvmfzCHB4vVMLG9ynpwsp7SSeLskfzHt8w3nolf8ePIzM0ueBr8+
	 I0yPvZxiJ5Qbw==
Date: Thu, 9 Jan 2025 18:21:08 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: dwarves@vger.kernel.org, bpf@vger.kernel.org, alan.maguire@oracle.com,
	eddyz87@gmail.com, andrii@kernel.org, mykolal@fb.com,
	olsajiri@gmail.com
Subject: Re: [PATCH dwarves v4 00/10] pahole: faster reproducible BTF encoding
Message-ID: <Z4A9xAHiNxoNihYe@x1>
References: <20250107190855.2312210-1-ihor.solodrai@pm.me>
 <Z4AWJBNsGJvBU7ZY@x1>
 <0gG5e2QvD6I6CuApCVn4O0ph5_k_fnKodGP2wGhm6oxiLKh5A_v1mTeezCjU_oEwQxUwRMN9yycf5xbLfIviTlAg-qm6dxHK-PkgVTFDLQ8=@pm.me>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0gG5e2QvD6I6CuApCVn4O0ph5_k_fnKodGP2wGhm6oxiLKh5A_v1mTeezCjU_oEwQxUwRMN9yycf5xbLfIviTlAg-qm6dxHK-PkgVTFDLQ8=@pm.me>

On Thu, Jan 09, 2025 at 06:38:57PM +0000, Ihor Solodrai wrote:
> On Thursday, January 9th, 2025 at 10:32 AM, Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> 
> > 
> > 
> > On Tue, Jan 07, 2025 at 07:08:59PM +0000, Ihor Solodrai wrote:
> > 
> > > This is v4 of the series aiming to speed up parallel reproducible BTF
> > > encoding. This version mostly addresses feedback from Jiri Olsa on v3.
> > 
> > 
> > b4 is having trouble with this series, I'm trying to cherry pick
> > things...
> 
> Sorry, I think I messed up some patches with manual changes before submitting.
> I'll resend a clean series in a bit.

Better now:

⬢ [acme@toolbox pahole]$ b4 am -ctsl --cc-trailers 20250109185950.653110-2-ihor.solodrai@pm.me
Grabbing thread from lore.kernel.org/all/20250109185950.653110-2-ihor.solodrai@pm.me/t.mbox.gz
Checking for newer revisions
Grabbing search results from lore.kernel.org
Analyzing 15 messages in the thread
Looking for additional code-review trailers on lore.kernel.org
Checking attestation on all messages, may take a moment...
---
  ✗ [PATCH v4 1/10] btf_encoder: simplify function encoding
    + Acked-by: Eduard Zingerman <eddyz87@gmail.com> (✗ DKIM/gmail.com)
    + Acked-by: Jiri Olsa <jolsa@kernel.org> (✗ DKIM/gmail.com)
    + Link: https://lore.kernel.org/r/20250109185950.653110-2-ihor.solodrai@pm.me
    + Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
  ✗ [PATCH v4 2/10] btf_encoder: free encoder->secinfo in btf_encoder__delete
    + Link: https://lore.kernel.org/r/20250109185950.653110-3-ihor.solodrai@pm.me
    + Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
  ✗ [PATCH v4 3/10] btf_encoder: separate elf function, saved function representations
    + Link: https://lore.kernel.org/r/20250109185950.653110-4-ihor.solodrai@pm.me
    + Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
  ✗ [PATCH v4 4/10] btf_encoder: introduce elf_functions struct type
    + Link: https://lore.kernel.org/r/20250109185950.653110-5-ihor.solodrai@pm.me
    + Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
  ✗ [PATCH v4 5/10] btf_encoder: introduce elf_functions_list
    + Link: https://lore.kernel.org/r/20250109185950.653110-6-ihor.solodrai@pm.me
    + Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
  ✗ [PATCH v4 6/10] btf_encoder: remove skip_encoding_inconsistent_proto
    + Link: https://lore.kernel.org/r/20250109185950.653110-7-ihor.solodrai@pm.me
    + Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
  ✗ [PATCH v4 7/10] dwarf_loader: introduce cu->id
    + Link: https://lore.kernel.org/r/20250109185950.653110-8-ihor.solodrai@pm.me
    + Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
  ✗ [PATCH v4 8/10] dwarf_loader: multithreading with a job/worker model
    + Link: https://lore.kernel.org/r/20250109185950.653110-9-ihor.solodrai@pm.me
    + Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
  ✗ [PATCH v4 9/10] btf_encoder: clean up global encoders list
    + Link: https://lore.kernel.org/r/20250109185950.653110-10-ihor.solodrai@pm.me
    + Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
  ✗ [PATCH v4 10/10] btf_encoder: switch func_states from a list to an array
    + Link: https://lore.kernel.org/r/20250109185950.653110-11-ihor.solodrai@pm.me
    + Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
  ---
  ✗ BADSIG: DKIM/pm.me
---
Total patches: 10
---
Cover: ./v4_20250109_ihor_solodrai_pahole_faster_reproducible_btf_encoding.cover
 Link: https://lore.kernel.org/r/20250109185950.653110-1-ihor.solodrai@pm.me
 Base: not specified
       git am ./v4_20250109_ihor_solodrai_pahole_faster_reproducible_btf_encoding.mbx
⬢ [acme@toolbox pahole]$        git am ./v4_20250109_ihor_solodrai_pahole_faster_reproducible_btf_encoding.mbx
Applying: btf_encoder: simplify function encoding
Applying: btf_encoder: free encoder->secinfo in btf_encoder__delete
Applying: btf_encoder: separate elf function, saved function representations
Applying: btf_encoder: introduce elf_functions struct type
Applying: btf_encoder: introduce elf_functions_list
Applying: btf_encoder: remove skip_encoding_inconsistent_proto
Applying: dwarf_loader: introduce cu->id
Applying: dwarf_loader: multithreading with a job/worker model
Applying: btf_encoder: clean up global encoders list
Applying: btf_encoder: switch func_states from a list to an array
⬢ [acme@toolbox pahole]$

