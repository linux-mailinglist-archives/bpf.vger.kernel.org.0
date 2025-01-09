Return-Path: <bpf+bounces-48430-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DFE10A07FD2
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 19:32:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A782D7A2AB8
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 18:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4221B194A6C;
	Thu,  9 Jan 2025 18:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="goC4FoPM"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9128747F;
	Thu,  9 Jan 2025 18:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736447527; cv=none; b=Da8ZplfJBdvXFfeIg9WvJntJG35GjIq7lL+67Uiu2w5KAzjnpUI9/zk6mY5v3bi2ovWy66H6Pal680PGQ6+OxDfmtItkVE8xfG3Rnb/e8Kg1kYDii9IHuAu9zQEM9sbo8fynjj5A3x9+zq/KTzCzwuVoKN0Jkc5bDEN22JY3N50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736447527; c=relaxed/simple;
	bh=TTPHjvQpuKlIG82Iqn4T4BsnkKxPcvh7ubUXeDUEmyA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tQoo1EAtNicCLH9N2oAMV3L8QsD7Tz5Py2DKKLm/xq0z9D3pkQ9TIC1y0ADievURpi8zM+z0MrdNnHYh+ov9SweXyO8lZlZfUBoejBbG62IV6QZzKY+geKx1ORAIrrbwrGnRLgkXggOqjvIoNu54Vgq0YDoqoxZZwtCEnv8dmCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=goC4FoPM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7166C4CED2;
	Thu,  9 Jan 2025 18:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736447527;
	bh=TTPHjvQpuKlIG82Iqn4T4BsnkKxPcvh7ubUXeDUEmyA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=goC4FoPMCnEQpu749JRoNU2lxtdTmpRtjXWETy1dFr7PAZtzXJCtfmJEtM8rGX6+/
	 q20SSg/XbVMoKohUg+spao++iDecQLkuK0w+s3SZYFvhTa7X42RwnEk966Hpyj4zM5
	 iHQXxCkjzET47UbQFTvLs0vvWgFWXpAkiP/0LVfzo7OV1UygXyy42v/HHk9eeEh3aX
	 HMwlNLCaSa5dzU9neMZJVbKAFzrDl4xpbVZrjZmUpbic2sVvytnqaNOBkN12twk1pK
	 EnUNaxZfIFZJgamDeGAQbvVIZqqhGAZELxPDTcoSfOghaozi037bfGjiBgZWqMdnUm
	 HctdxbaKByfDA==
Date: Thu, 9 Jan 2025 15:32:04 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: dwarves@vger.kernel.org, bpf@vger.kernel.org, alan.maguire@oracle.com,
	eddyz87@gmail.com, andrii@kernel.org, mykolal@fb.com,
	olsajiri@gmail.com
Subject: Re: [PATCH dwarves v4 00/10] pahole: faster reproducible BTF encoding
Message-ID: <Z4AWJBNsGJvBU7ZY@x1>
References: <20250107190855.2312210-1-ihor.solodrai@pm.me>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250107190855.2312210-1-ihor.solodrai@pm.me>

On Tue, Jan 07, 2025 at 07:08:59PM +0000, Ihor Solodrai wrote:
> This is v4 of the series aiming to speed up parallel reproducible BTF
> encoding. This version mostly addresses feedback from Jiri Olsa on v3.
> 

b4 is having trouble with this series, I'm trying to cherry pick
things...

⬢ [acme@toolbox pahole]$ b4 am -ctsl --cc-trailers 20250107190855.2312210-1-ihor.solodrai@pm.me
Grabbing thread from lore.kernel.org/all/20250107190855.2312210-1-ihor.solodrai@pm.me/t.mbox.gz
Checking for newer revisions
Grabbing search results from lore.kernel.org
Analyzing 13 messages in the thread
WARNING: duplicate messages found at index 1
   Subject 1: dwarf_loader: multithreading with a job/worker model
   Subject 2: btf_encoder: simplify function encoding
  2 is not a reply... assume additional patch
Assuming new revision: v2 ([PATCH dwarves v4] btf_encoder: switch func_states from a list to an array)
Will use the latest revision: v4
You can pick other revisions using the -vN flag
Checking attestation on all messages, may take a moment...
---
  ✗ [PATCH v4] dwarf_loader: multithreading with a job/worker model
    ✗ BADSIG: DKIM/pm.me
    + Link: https://lore.kernel.org/r/20250107190855.2312210-9-ihor.solodrai@pm.me
    + Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
  ✗ [PATCH v4 1/10] btf_encoder: simplify function encoding
    ✗ BADSIG: DKIM/pm.me
    + Acked-by: Eduard Zingerman <eddyz87@gmail.com> (✗ DKIM/gmail.com)
    + Acked-by: Jiri Olsa <jolsa@kernel.org> (✗ DKIM/gmail.com)
    + Link: https://lore.kernel.org/r/20250107190855.2312210-2-ihor.solodrai@pm.me
    + Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
  ✗ [PATCH v4 3/10] btf_encoder: separate elf function, saved function representations
    ✗ BADSIG: DKIM/pm.me
    + Link: https://lore.kernel.org/r/20250107190855.2312210-4-ihor.solodrai@pm.me
    + Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
  ✗ [PATCH v4 4/10] btf_encoder: introduce elf_functions struct type
    ✗ BADSIG: DKIM/pm.me
    + Link: https://lore.kernel.org/r/20250107190855.2312210-5-ihor.solodrai@pm.me
    + Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
  ✗ [PATCH v4 5/10] btf_encoder: introduce elf_functions_list
    ✗ BADSIG: DKIM/pm.me
    + Link: https://lore.kernel.org/r/20250107190855.2312210-6-ihor.solodrai@pm.me
    + Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
  ✗ [PATCH v4 6/10] btf_encoder: remove skip_encoding_inconsistent_proto
    ✗ BADSIG: DKIM/pm.me
    + Link: https://lore.kernel.org/r/20250107190855.2312210-7-ihor.solodrai@pm.me
    + Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
  ✗ [PATCH v4 7/10] dwarf_loader: introduce cu->id
    ✗ BADSIG: DKIM/pm.me
    + Link: https://lore.kernel.org/r/20250107190855.2312210-8-ihor.solodrai@pm.me
    + Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
  ERROR: missing [8/10]!
  ✗ [PATCH v4 9/10] btf_encoder: clean up global encoders list
    ✗ BADSIG: DKIM/pm.me
    + Link: https://lore.kernel.org/r/20250107190855.2312210-10-ihor.solodrai@pm.me
    + Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
  ERROR: missing [10/10]!
  ERROR: missing [11/10]!
---
Total patches: 8
---
WARNING: Thread incomplete!
Cover: ./v4_20250107_ihor_solodrai_pahole_faster_reproducible_btf_encoding.cover
 Link: https://lore.kernel.org/r/20250107190855.2312210-1-ihor.solodrai@pm.me
 Base: not specified
       git am ./v4_20250107_ihor_solodrai_pahole_faster_reproducible_btf_encoding.mbx
⬢ [acme@toolbox pahole]$ 

> A notable adition is a patch 10/10, which changes func_states in
> btf_encoder from a list to an array.



