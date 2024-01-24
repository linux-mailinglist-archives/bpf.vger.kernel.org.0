Return-Path: <bpf+bounces-20259-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A6AB83B1D4
	for <lists+bpf@lfdr.de>; Wed, 24 Jan 2024 20:07:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 253E7B2C207
	for <lists+bpf@lfdr.de>; Wed, 24 Jan 2024 19:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 562A7132C0D;
	Wed, 24 Jan 2024 19:05:37 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77AD7CF3F;
	Wed, 24 Jan 2024 19:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.72.0.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706123137; cv=none; b=Xyw/3CwBMQLRM7tnbV2M2G4nrBi0l4IqRG8NuPdx+yyqQk8Ru7jFCZAlFVlDuOMX+Kwo9FPKoDHedvgwtV4GVm4/yMyYQdlpaxrQeUw9zqT5vBn7IxA5g/rXcjoSPCjQrv8O6RQ8+f0RuWJ88pbmeyLKdlovM5p1fx1YcYmP+3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706123137; c=relaxed/simple;
	bh=35mM6I4/a8/AAfo6vEpCkUubuJeihuMJQkFca3EvMAM=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=XuE8Cp2LTbgq17uvRi9Ata41y4BI5e7jlUfyX0nK4Red+ALj1TN8h3aUgYpMIzbhP0390BIYjEm69BVOVp7NS2OJpKL2lFfmN/A291H9UinoMvgeVUmdIYfO62jc6hukGXyloZ+KHRkiIolbdZNOasFPT4uYXxAq4Xk7xDknG6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=fail smtp.mailfrom=linux.com; arc=none smtp.client-ip=62.72.0.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.com
Received: by gentwo.org (Postfix, from userid 1003)
	id C086040A94; Wed, 24 Jan 2024 11:05:33 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTP id BFEA640787;
	Wed, 24 Jan 2024 11:05:33 -0800 (PST)
Date: Wed, 24 Jan 2024 11:05:33 -0800 (PST)
From: "Christoph Lameter (Ampere)" <cl@linux.com>
To: Matthew Wilcox <willy@infradead.org>
cc: David Rientjes <rientjes@google.com>, Pasha Tatashin <tatashin@google.com>, 
    Sourav Panda <souravpanda@google.com>, lsf-pc@lists.linux-foundation.org, 
    linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
    linux-block@vger.kernel.org, linux-ide@vger.kernel.org, 
    linux-scsi@vger.kernel.org, linux-nvme@lists.infradead.org, 
    bpf@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] State Of The Page
In-Reply-To: <ZbFPIidl6dK5cR0W@casper.infradead.org>
Message-ID: <52821f7a-bb6f-308c-38b0-e5e9904d4f8c@linux.com>
References: <ZaqiPSj1wMrTMdHa@casper.infradead.org> <b04b65df-b25f-4457-8952-018dd4479651@google.com> <Za2lS-jG1s-HCqbx@casper.infradead.org> <aa94b8fe-fc08-2838-50b5-d1c98058b1e0@linux.com> <ZbFPIidl6dK5cR0W@casper.infradead.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Wed, 24 Jan 2024, Matthew Wilcox wrote:

> On Wed, Jan 24, 2024 at 09:51:02AM -0800, Christoph Lameter (Ampere) wrote:
>> Can we come up with a design that uses a huge page (or some arbitrary page
>> size) and the breaks out portions of the large page? That way potentially
>> TLB use can be reduced (multiple sections of a large page use the same TLB)
>> and defragmentation occurs because allocs and frees focus on a selection of
>> large memory sections.
>
> Could I trouble you to reply in this thread:
> https://lore.kernel.org/linux-mm/Za6RXtSE_TSdrRm_@casper.infradead.org/
> where I actually outline what I think we should do next.

Ahh... ok. Will do.


