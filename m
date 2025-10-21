Return-Path: <bpf+bounces-71600-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9504EBF7E5B
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 19:28:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2F41D34AD36
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 17:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7716B35580C;
	Tue, 21 Oct 2025 17:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b="bAHvNP48"
X-Original-To: bpf@vger.kernel.org
Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C99355802
	for <bpf@vger.kernel.org>; Tue, 21 Oct 2025 17:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.72.0.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761067675; cv=none; b=IaYk7r+ZjZGtsKcoIlvlcjnPUKp5ERXxh0my1vOU22BHGkXnciUUPUnykLq0u2wGs2SJenh77mA8aZ3VN9CQLMT9H4UsjRPzb0UzuqWZsymSwk9eFFMsg+EANiLHEWkUB6+QNxRqeulNjOOx3eByEtV9M89MfeabilfijcLKWf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761067675; c=relaxed/simple;
	bh=aDZFA/XJVv1lEwaX7z09NSQIhGALV+zbSDqdbk5QFJI=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=tVILgt8gLv8l3tDf1OxP/D5dT78dKDuGVSRLAv6/zS2vByzqhDgZKWAwq6QK2tvrG4KiJml/1qO5MIfjKu8I0j5/YrLFtks4i1tcdXW8WGaVNGHYs9CnVG8NI1TENSqNr0XTaTyEIXPL/+jSEz+MqFO3DDCtT15WQsjHHemNbug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org; spf=pass smtp.mailfrom=gentwo.org; dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b=bAHvNP48; arc=none smtp.client-ip=62.72.0.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentwo.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.org;
	s=default; t=1761067306;
	bh=aDZFA/XJVv1lEwaX7z09NSQIhGALV+zbSDqdbk5QFJI=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=bAHvNP48NVamnZjDJ/vxsQI7f/YDnfkfpe99y8gyVMUyLPkqutguMbtftGOKvmO4A
	 +nDPfAVj9tCakTNGLKigCg8wNd/YhxaK68MSAGiDwGhY0Jtj5kIMgFUpZPBxv+5K1j
	 zxUzs/lHCbR9+I1ilOLZ1i8uIVcAJjCJN6Dz3y9U=
Received: by gentwo.org (Postfix, from userid 1003)
	id B7D464028E; Tue, 21 Oct 2025 10:21:46 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTP id B5F664015D;
	Tue, 21 Oct 2025 10:21:46 -0700 (PDT)
Date: Tue, 21 Oct 2025 10:21:46 -0700 (PDT)
From: "Christoph Lameter (Ampere)" <cl@gentwo.org>
To: Ankur Arora <ankur.a.arora@oracle.com>
cc: bpf@vger.kernel.org, arnd@arndb.de, catalin.marinas@arm.com, 
    will@kernel.org, peterz@infradead.org, akpm@linux-foundation.org, 
    mark.rutland@arm.com, harisokn@amazon.com, ast@kernel.org, 
    rafael@kernel.org, daniel.lezcano@linaro.org, memxor@gmail.com, 
    zhenglifeng1@huawei.com, xueshuai@linux.alibaba.com, 
    joao.m.martins@oracle.com, boris.ostrovsky@oracle.com, 
    konrad.wilk@oracle.com
Subject: Re: [PATCH v7 1/7] asm-generic: barrier: Add
 smp_cond_load_relaxed_timeout()
In-Reply-To: <20251017061606.455701-2-ankur.a.arora@oracle.com>
Message-ID: <9f894121-72ca-d6f2-d1d1-9b84a5e94cf0@gentwo.org>
References: <20251017061606.455701-1-ankur.a.arora@oracle.com> <20251017061606.455701-2-ankur.a.arora@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII


Reviewed-by: Christoph Lameter (Ampere) <cl@gentwo.org>


