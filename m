Return-Path: <bpf+bounces-71608-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 16EC8BF7EFC
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 19:42:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AA12B358602
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 17:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48D5234C154;
	Tue, 21 Oct 2025 17:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b="Mc5NG8Ut"
X-Original-To: bpf@vger.kernel.org
Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4E61E511
	for <bpf@vger.kernel.org>; Tue, 21 Oct 2025 17:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.72.0.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761068565; cv=none; b=gaAj9r1gUD1q9JVRSwk1GGU7+CqA6zeKrNO+dvTp+Vqv5joZDMAHjxVMydZ/91ncCaZtbJ7se//YTHtBCl++lrEQk2pG/Q2Wa8MArfxAldAs2vF6DLzFV4+cuw2e9CEjEjGwOUTu09vdm7qStmQ33nBCBMAZUFBSz+7QjLMrqlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761068565; c=relaxed/simple;
	bh=aDZFA/XJVv1lEwaX7z09NSQIhGALV+zbSDqdbk5QFJI=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=U3A7wD33XrwLrl0qlD6DRy99Rh8sEO+l0q3FdqorpyJTO0U8FoL7YtRu9CEQbClCi5FlEJs3o48eMdDt/zhnSD+/V3CSpxXK5ronOEjAoH0GHZUtqKq4SWD+13hHy9x5CF8ltWIYqes6SviaGJxSRaB8dfEzUUT8PSJkb6mw9hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org; spf=pass smtp.mailfrom=gentwo.org; dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b=Mc5NG8Ut; arc=none smtp.client-ip=62.72.0.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentwo.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.org;
	s=default; t=1761068564;
	bh=aDZFA/XJVv1lEwaX7z09NSQIhGALV+zbSDqdbk5QFJI=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=Mc5NG8UthXNGMlr+FHJ+Q0a6GTp5Mu7BmIBDeSxnOzwCtbY91vFxzKTQ4PAo/2Wcf
	 CNT1BspmWsl6yj22Jj/fLMMJHBpjEUlObECOQ4iVar97Qq73sPctvpt0YkyeiFAdhB
	 hnUE8RV/G7IbTGsbMk18KFf7EJvNvgKdMvv+OLM0=
Received: by gentwo.org (Postfix, from userid 1003)
	id 03BDD4028E; Tue, 21 Oct 2025 10:42:44 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTP id 00B5B4015D;
	Tue, 21 Oct 2025 10:42:43 -0700 (PDT)
Date: Tue, 21 Oct 2025 10:42:43 -0700 (PDT)
From: "Christoph Lameter (Ampere)" <cl@gentwo.org>
To: Ankur Arora <ankur.a.arora@oracle.com>
cc: bpf@vger.kernel.org, arnd@arndb.de, catalin.marinas@arm.com, 
    will@kernel.org, peterz@infradead.org, akpm@linux-foundation.org, 
    mark.rutland@arm.com, harisokn@amazon.com, ast@kernel.org, 
    rafael@kernel.org, daniel.lezcano@linaro.org, memxor@gmail.com, 
    zhenglifeng1@huawei.com, xueshuai@linux.alibaba.com, 
    joao.m.martins@oracle.com, boris.ostrovsky@oracle.com, 
    konrad.wilk@oracle.com
Subject: Re: [PATCH v7 7/7] cpuidle/poll_state: Poll via
 smp_cond_load_relaxed_timeout()
In-Reply-To: <20251017061606.455701-8-ankur.a.arora@oracle.com>
Message-ID: <12a2a48d-b7c0-542b-60e9-9a920f7baf1b@gentwo.org>
References: <20251017061606.455701-1-ankur.a.arora@oracle.com> <20251017061606.455701-8-ankur.a.arora@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII


Reviewed-by: Christoph Lameter (Ampere) <cl@gentwo.org>


