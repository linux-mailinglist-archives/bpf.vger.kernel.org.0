Return-Path: <bpf+bounces-31838-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 08C61903E90
	for <lists+bpf@lfdr.de>; Tue, 11 Jun 2024 16:21:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4F431F2214E
	for <lists+bpf@lfdr.de>; Tue, 11 Jun 2024 14:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 866E817D379;
	Tue, 11 Jun 2024 14:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="deiSql5b"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A3EAD2C;
	Tue, 11 Jun 2024 14:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718115670; cv=none; b=qx4KEemrT4k2kiYM/RypWyzQytCYmnD1IF2JE/24rVV03N9rgogWp0af4YZAGVnNahqh7VvjhcWd/ePKF3hi6ZO8eoHFxwMY9GHlnq+JBUKfS4lPaxjEppgFP11yjiEM4+zMk8xnoLLCJ8wAdB9DGu+p44AjPuRKet95IX1V4AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718115670; c=relaxed/simple;
	bh=h0cT46XFD18L3fdBOg889TlsdB4P2eXmaz/sVkaitBM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ms1FRHOurQRExHbeVLXh5cqT5IppwErFYrOfzxCMbj0BuB6qGspzD+jRix796w/jlCYnmx/y5iPms3bNIdx8VytNiAN1X2qvN8ND7ZXgyD6pYpfZiwXE2//M+QqxqsMUOa7rIxDM3g8z43SwVoW7vqkPUJd5AI3ir7liG7M+zf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=deiSql5b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB24CC32789;
	Tue, 11 Jun 2024 14:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718115669;
	bh=h0cT46XFD18L3fdBOg889TlsdB4P2eXmaz/sVkaitBM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=deiSql5bv/XD/n1Yvnliyt4y77RO7CctzLCs4B1aBReuTPEqwWdhpQrPuK4RlOoDt
	 e/mj3nTok9jLhkjhi8rs8O7ZgvtTcusiDzzHruTJOJUZq3BfcmEP7ie+XDmZ4U3c/r
	 LkHkQ2aXPUQbuFwmlzDR6ZfnExBTUfj95G/nBA5q8+wMRzerRMXgylsR2qoK3LDuJP
	 pGnzs/fGhV4E8gcUhrDfxXkNVtC79Y7ZX5XLzc9hiMKO5vmzO9ArqOIpxnJ+ra5myn
	 Wy3fOgW1LLxgt1s+9g0iZgaVUVkOo1TjUejqmKsOs2+PnKbyuyDeatyXqar/JOw3PJ
	 xUnbjl/FXl9BA==
Date: Tue, 11 Jun 2024 07:21:07 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, deb.chatterjee@intel.com,
 anjali.singhai@intel.com, namrata.limaye@intel.com, tom@sipanda.io,
 mleitner@redhat.com, Mahesh.Shirshyad@amd.com, tomasz.osinski@intel.com,
 jiri@resnulli.us, xiyou.wangcong@gmail.com, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, vladbu@nvidia.com,
 horms@kernel.org, khalidm@nvidia.com, toke@redhat.com, victor@mojatatu.com,
 pctammela@mojatatu.com, Vipin.Jain@amd.com, dan.daly@intel.com,
 andy.fingerhut@gmail.com, chris.sommers@keysight.com, mattyk@nvidia.com,
 bpf@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH net-next v16  00/15] Introducing P4TC (series 1)
Message-ID: <20240611072107.5a4d4594@kernel.org>
In-Reply-To: <20240410140141.495384-1-jhs@mojatatu.com>
References: <20240410140141.495384-1-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Since the inevitable LWN article has been written, let me put more
detail into what I already mentioned here:

https://lore.kernel.org/all/20240301090020.7c9ebc1d@kernel.org/

for the benefit of non-networking people.

On Wed, 10 Apr 2024 10:01:26 -0400 Jamal Hadi Salim wrote:
> P4TC builds on top of many years of Linux TC experiences of a netlink
> control path interface coupled with a software datapath with an equivalent
> offloadable hardware datapath.

The point of having SW datapath is to provide a blueprint for the
behavior. This is completely moot for P4 which comes as a standard.

Besides we already have 5 (or more) flow offloads, we don't need
a 6th, completely disconnected from the existing ones. Leaving
users guessing which one to use, and how they interact.

In my opinion, reasonable way to implement programmable parser for
Linux is:

 1. User writes their parser in whatever DSL they want
 2. User compiles the parser in user space
   2.1 Compiler embeds a representation of the graph in the blob
 3. User puts the blob in /lib/firmware
 4. devlink dev $dev reload action parser-fetch $filename
 5. devlink loads the file, parses it to extract the representation
    from 2.1, and passes the blob to the driver
   5.1 driver/fw reinitializes the HW parser
   5.2 user can inspect the graph by dumping the common representation
       from 2.1 (via something like devlink dpipe, perhaps)
 6. The parser tables are annotated with Linux offload targets (routes,
    classic ntuple, nftables, flower etc.) with some tables being left
    as "raw"* (* better name would be great)
 7. ethtool ntuple is extended to support insertion of arbitrary rules
    into the "raw" tables
 8. The other tables can only be inserted into using the subsystem they
    are annotated for

This builds on how some devices _already_ operate. Gives the benefits
of expressing parser information and ability to insert rules for
uncommon protocols also for devices which are not programmable.
And it uses ethtool ntuple, which SW people actually want to use.

Before the tin foil hats gather - we have no use for any of this at
Meta, I'm not trying to twist the design to fit the use cases of big
bad hyperscalers.

