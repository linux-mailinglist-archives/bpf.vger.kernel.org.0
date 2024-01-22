Return-Path: <bpf+bounces-19983-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A40EE835A3A
	for <lists+bpf@lfdr.de>; Mon, 22 Jan 2024 06:20:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1100B2293E
	for <lists+bpf@lfdr.de>; Mon, 22 Jan 2024 05:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F24B54C83;
	Mon, 22 Jan 2024 05:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Q8zxH4Eb"
X-Original-To: bpf@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0872C4C6F
	for <bpf@vger.kernel.org>; Mon, 22 Jan 2024 05:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705900817; cv=none; b=ZIg9fun9lroA9zm1r0pOKxXV1od5zxBHzooMiQWt6oSMeHSR8B+28yCak/aNolqlsWIACH0WwNdQJJ/efCTxEZGQIThOZviB+fidpt5o11WyOJu0bH2OU98TVIPnDZt1Mf8hhdrDKr4F7ut22+5Nml4v+m/RmmPOr1fYcxz8Rr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705900817; c=relaxed/simple;
	bh=q6Yi23jyk67ozFsHkWC5iODKTs9CS156P/Y9YutQdUA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=V+3iumhFV5eh33lSqUprSoxmDaajjXNEDRY9Ls5j81jW7uVuGLUPQJEysT84onFGVqVniNZjPdPMkI9ZB97am2dUD71aaXwU/DFyaabcgbcPV/32ROhJT1dQMxpiZUQAHRDLsNmbc/G++8wQ6Q9NXftfssC5AmOrR1x6ea8L2WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Q8zxH4Eb; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <e4ad870a-a1dd-471a-ba78-da9a6273d76c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1705900813;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q6Yi23jyk67ozFsHkWC5iODKTs9CS156P/Y9YutQdUA=;
	b=Q8zxH4EbTQdYOsYOcbsWA+Al+QnyZRYWgbLE0MGxLmNlUavqgHjuhZUINKHaIFTjoBTViB
	1KrGzWf7Rex3v2E2XWw72tepVSwXL+k/tWIRPKbDe5mtxOpA7IoM54oDfvfBP0t4cQZcP2
	OBoUw7+KOqrN0ysVlTC9FGHBxh2VcAs=
Date: Sun, 21 Jan 2024 21:20:10 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] Correct bpf_core_read.h comment wrt
 bpf_core_relo struct
Content-Language: en-GB
To: Dima Tisnek <dimaqq@gmail.com>, bpf@vger.kernel.org
References: <20240121060126.15650-1-dimaqq@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20240121060126.15650-1-dimaqq@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 1/20/24 10:01 PM, Dima Tisnek wrote:
> Past commits, like 28b93c64499ae09d9dc8c04123b15f8654a93c4c, have removed the last
> vestiges of struct bpf_field_reloc, it's called struct bpf_core_relo now.
>
> Signed-off-by: Dima Tisnek <dimaqq@gmail.com>

Acked-by: Yonghong Song <yonghong.song@linux.dev>


