Return-Path: <bpf+bounces-71606-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6252EBF7EDE
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 19:38:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F1DF1356C0A
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 17:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A403834C137;
	Tue, 21 Oct 2025 17:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b="j/HaUrQp"
X-Original-To: bpf@vger.kernel.org
Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBAE032E142
	for <bpf@vger.kernel.org>; Tue, 21 Oct 2025 17:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.72.0.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761068313; cv=none; b=Wk58GqdGd3dyzsaz3OPHauGm9psuwDZBqyB1Io3o1GiY2yJv2t5OUpCcuhvjnodG8oTC+fuxLFOux42YTBT4AByUtjYX+1gV15tA9cMwHoQ1OAitbY9VKNy6lCvu0WQndnZJwzy7dHa0gxB1QZryU8APQ4XokNLRfor+Rs87D3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761068313; c=relaxed/simple;
	bh=aDZFA/XJVv1lEwaX7z09NSQIhGALV+zbSDqdbk5QFJI=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=VHVHJhGfi17lkhdI91u/cNS6VabDYC6Ya/dD+nkINOVOCjGf+4j+8JEgQMG67YoJkZeF6E+g0NZ3bXInFvOKNYl+GCSGoqDHqbluNeirtBMb9ngHRnn0nfd8PKv9PT91UXEaIS/vAJb7J6A4T/6EYO1+pwFINw9M3krRCQqHKi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org; spf=pass smtp.mailfrom=gentwo.org; dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b=j/HaUrQp; arc=none smtp.client-ip=62.72.0.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentwo.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.org;
	s=default; t=1761068311;
	bh=aDZFA/XJVv1lEwaX7z09NSQIhGALV+zbSDqdbk5QFJI=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=j/HaUrQpvBqEj2m8nNm6YXh8EJMX/ODA0ApDJYuK1a1misy4fbiTEBhjKGgOClle/
	 o2AEjqa69hs1bTEpAZ5NVsMzqF+ETbbBJDwwM9m28e7RrK5E0BHsR9N7M/xMwhX6c1
	 k9mMcRnmr1ZV0Aof5lNpELeGqdOtVkr9plKgxIsM=
Received: by gentwo.org (Postfix, from userid 1003)
	id 20F244028E; Tue, 21 Oct 2025 10:38:31 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTP id 200E04015D;
	Tue, 21 Oct 2025 10:38:31 -0700 (PDT)
Date: Tue, 21 Oct 2025 10:38:31 -0700 (PDT)
From: "Christoph Lameter (Ampere)" <cl@gentwo.org>
To: Ankur Arora <ankur.a.arora@oracle.com>
cc: bpf@vger.kernel.org, arnd@arndb.de, catalin.marinas@arm.com, 
    will@kernel.org, peterz@infradead.org, akpm@linux-foundation.org, 
    mark.rutland@arm.com, harisokn@amazon.com, ast@kernel.org, 
    rafael@kernel.org, daniel.lezcano@linaro.org, memxor@gmail.com, 
    zhenglifeng1@huawei.com, xueshuai@linux.alibaba.com, 
    joao.m.martins@oracle.com, boris.ostrovsky@oracle.com, 
    konrad.wilk@oracle.com
Subject: Re: [PATCH v7 3/7] arm64: rqspinlock: Remove private copy of
 smp_cond_load_acquire_timewait()
In-Reply-To: <20251017061606.455701-4-ankur.a.arora@oracle.com>
Message-ID: <5342b50a-343f-b830-4373-2b7d42fd84ec@gentwo.org>
References: <20251017061606.455701-1-ankur.a.arora@oracle.com> <20251017061606.455701-4-ankur.a.arora@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII


Reviewed-by: Christoph Lameter (Ampere) <cl@gentwo.org>


