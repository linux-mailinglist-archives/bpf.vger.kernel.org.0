Return-Path: <bpf+bounces-76963-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 41809CCABCE
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 08:52:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 62CB03007B46
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 07:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39E7E2E36F3;
	Thu, 18 Dec 2025 07:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gt8bWe3X"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA04A2D9EED;
	Thu, 18 Dec 2025 07:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766044340; cv=none; b=XTfi76U9SJf8WJcMRaIKkih3acQiEIavnzOIvjuUgS/MILyJxNDFLdQA/ktTdFCqfi3jTQHcG5y+O9mrpImH5sD+Ru5zZQOLkCN1GKG4Uyhbv938vPFLzRF+KVdCPFu0c7qMznQlDnFUgUuZPhzDDiOsdx+dngkTfqy2bRMZ7Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766044340; c=relaxed/simple;
	bh=z7L/COQjj+dxj156zLOK5p2xjWggF5cjflPxJeDDgmc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ag8+xNqhP08s+PkbYXJB4UjjR4iU2mL3O94HJW7xf7Q0TicO8hGOXdHjw080NU/kcKtiKEseIYwQxC9tVMAie9UftD4gfPpsatiIDORaLKtrJDVyTjSG3aonMpXDocuU0EBU7pgEVneUgZ0Zm3MBn+PQeFjQHDXCCrTk6g+xoJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gt8bWe3X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1335C4CEFB;
	Thu, 18 Dec 2025 07:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766044340;
	bh=z7L/COQjj+dxj156zLOK5p2xjWggF5cjflPxJeDDgmc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Gt8bWe3XjkS5yiewXH+wkKJpwHQZ7eU0DgDYmQJsraZPH48T4U8/IvENlrMLeaNB9
	 BydYKjugZeEMqFOU02jXXydkdM/Bt5a1zw+1ydmJQH/qgwfQkC5ROkUTDfuthjygh0
	 Dc8Y3wB/XmMGiQN8kt0Juxzz5Y1VVNDa8KCsT84hzx3ddKt0COqGOc79Ai19bJO0js
	 quoBd/AgFwgSHnCvWq7oQBLHugjgdD2y9+4H7ZVkquN5N1XCzacYAd3Fm23Yv/ZR21
	 uauRJxOG7K8+wFuwcTSmKaIbm3/Dqchzi2yHkiCcGOIfMnrb3Q9yTOqCWhYd10tXpl
	 8O1zFP3JAppkg==
Message-ID: <1e4c889c-f594-4d1c-92cb-e94af04acc91@kernel.org>
Date: Thu, 18 Dec 2025 08:52:10 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] introduce pagetable_alloc_nolock()
To: Vlastimil Babka <vbabka@suse.cz>, Brendan Jackman <jackmanb@google.com>,
 Yeoreum Yun <yeoreum.yun@arm.com>, Ryan Roberts <ryan.roberts@arm.com>
Cc: akpm@linux-foundation.org, lorenzo.stoakes@oracle.com,
 Liam.Howlett@oracle.com, rppt@kernel.org, surenb@google.com,
 mhocko@suse.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, hannes@cmpxchg.org,
 ziy@nvidia.com, bigeasy@linutronix.de, clrkwllms@kernel.org,
 rostedt@goodmis.org, catalin.marinas@arm.com, will@kernel.org,
 kevin.brodsky@arm.com, dev.jain@arm.com, yang@os.amperecomputing.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-rt-devel@lists.linux.dev, linux-arm-kernel@lists.infradead.org
References: <20251212161832.2067134-1-yeoreum.yun@arm.com>
 <916c17ba-22b1-456e-a184-cb3f60249af7@arm.com>
 <aUGOPd7gNRf1xHEc@e129823.arm.com>
 <100cc8da-b826-4fc2-a624-746bf6fb049d@arm.com>
 <aUKKZR0u22KOPfd7@e129823.arm.com>
 <d96ac977-222e-4e8d-9487-da1306198419@arm.com>
 <aUKnfU/3FREY13g1@e129823.arm.com>
 <d912480a-5229-4efe-9336-b31acded30f5@suse.cz>
 <DF0J58HOVLL4.2E16Q87D2UXRW@google.com>
 <d5354d96-6f28-41d7-9f66-64c254d9477b@suse.cz>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <d5354d96-6f28-41d7-9f66-64c254d9477b@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


>>
>> Link: https://lore.kernel.org/all/d912480a-5229-4efe-9336-b31acded30f5@suse.cz/
>> Signed-off-by: Brendan Jackman <jackmanb@google.com>
> 
> Acked-by: Vlastimil Babka <vbabka@suse.cz>

Clarifies things for me

Acked-by: David Hildenbrand (Red Hat) <david@kernel.org>

-- 
Cheers

David

