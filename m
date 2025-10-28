Return-Path: <bpf+bounces-72576-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F178DC15BD2
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 17:19:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15D6A1C261B1
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 16:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C422C34574B;
	Tue, 28 Oct 2025 16:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b="JL1ErWn0"
X-Original-To: bpf@vger.kernel.org
Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A874C273D77
	for <bpf@vger.kernel.org>; Tue, 28 Oct 2025 16:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.72.0.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761668014; cv=none; b=Fn2g4wfSyTd8rAlnQGcNvfPDJhMHXB+OwiJyQSwGqSiMJfqGOUXI4VgvdoidfOBzLFXaui8XID1vzkYtEF9PBzpF78k1z2FJB/ymxorIvUvqTfFBS/aidRnqORUX0sFCcyccUzz66H/hvvVExvP1vRj5KLTZ2WAxC0u+Bpv+wjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761668014; c=relaxed/simple;
	bh=aDZFA/XJVv1lEwaX7z09NSQIhGALV+zbSDqdbk5QFJI=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=dw2O2MWHLpw7/j5MZwV3iYqxw6DCgHFrse4+fLXSiW+7n9nMgm8BzLEI4SfvzntpaeOTAuH1IA0oCPHrec1lrV2F0Y8QBKB61uus0JfVeSMJCM/F7w1Ks7altVfBVtnPWKOQwoI8iQKNTtvTdw4HVh6xWmOFRcZJkCOwhjqIr2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org; spf=pass smtp.mailfrom=gentwo.org; dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b=JL1ErWn0; arc=none smtp.client-ip=62.72.0.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentwo.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.org;
	s=default; t=1761668005;
	bh=aDZFA/XJVv1lEwaX7z09NSQIhGALV+zbSDqdbk5QFJI=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=JL1ErWn07WSNBO4rKcJvhCafQNw7jJ+gPbxMmmddQel5oKJ+/xeh32N1ne5d1zZLk
	 vB2Og2skj6jjkFx17UsWNRxn+CxWWd1lZNbmTqHskyZNpUEnpSWZBkEveAd2a6b8c3
	 jpND3fRWAjZ+gYNrRLlhT2AtSCWNCbNDKCf3wiT4=
Received: by gentwo.org (Postfix, from userid 1003)
	id 0DB21402C4; Tue, 28 Oct 2025 09:13:25 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTP id 0B71C402BD;
	Tue, 28 Oct 2025 09:13:25 -0700 (PDT)
Date: Tue, 28 Oct 2025 09:13:25 -0700 (PDT)
From: "Christoph Lameter (Ampere)" <cl@gentwo.org>
To: Ankur Arora <ankur.a.arora@oracle.com>
cc: bpf@vger.kernel.org, arnd@arndb.de, catalin.marinas@arm.com, 
    will@kernel.org, peterz@infradead.org, akpm@linux-foundation.org, 
    mark.rutland@arm.com, harisokn@amazon.com, ast@kernel.org, 
    rafael@kernel.org, daniel.lezcano@linaro.org, memxor@gmail.com, 
    zhenglifeng1@huawei.com, xueshuai@linux.alibaba.com, 
    joao.m.martins@oracle.com, boris.ostrovsky@oracle.com, 
    konrad.wilk@oracle.com
Subject: Re: [RESEND PATCH v7 1/7] asm-generic: barrier: Add
 smp_cond_load_relaxed_timeout()
In-Reply-To: <20251028053136.692462-2-ankur.a.arora@oracle.com>
Message-ID: <d1e505ee-5c64-4f7d-6349-e59e99518b90@gentwo.org>
References: <20251028053136.692462-1-ankur.a.arora@oracle.com> <20251028053136.692462-2-ankur.a.arora@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII


Reviewed-by: Christoph Lameter (Ampere) <cl@gentwo.org>


