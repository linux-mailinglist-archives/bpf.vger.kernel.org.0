Return-Path: <bpf+bounces-20375-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75A3483D3E3
	for <lists+bpf@lfdr.de>; Fri, 26 Jan 2024 06:12:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 772511C24459
	for <lists+bpf@lfdr.de>; Fri, 26 Jan 2024 05:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB58DBA33;
	Fri, 26 Jan 2024 05:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="eAwg1tWu"
X-Original-To: bpf@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23ED2BA2D
	for <bpf@vger.kernel.org>; Fri, 26 Jan 2024 05:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706245950; cv=none; b=Q/Va5EpASgr/hqY20ryXy5iAvSH1fRLYBTaLKvk21Y13xxLNABxjLa7WwCDJlSCygwTchIr2c88x1Gz6QgqCgTOyfR04LlOpOIhZu77T74RrHWDMpH8LU9u7kOdH3Suk80dTpKLusMG9T/kbEkiSzYzpd9WUUWyXCK6Qri+cIik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706245950; c=relaxed/simple;
	bh=YcThGL3ya6LgHZTsllu1U6305lplcDWet/H7XFgjp2Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RXRNrX1zUqPUN3shmT/xGoJWg3wmFGMzjOrZGHTKCLwrRc4K3aZd/yf1ZzuJXfwrhuSrk3Y6KJf8bowb4cHyHSeRGZY8iRy7y9PyAypefuV2h++TKpG3GmS6nZABa6zAIGSQLfv/MOUUnxIXY5lIeKfGZYtMQH594OTBB08J5Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=eAwg1tWu; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <68a15df5-dbb8-481a-812e-2b361dc2a915@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1706245944;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YcThGL3ya6LgHZTsllu1U6305lplcDWet/H7XFgjp2Q=;
	b=eAwg1tWumUo30cBWqH9icBru2E5Zaz9t9cIlCCyGUu8tSi8TwaWMeZP1aosUdpVVUjwT+D
	x9FEpG2gVLvxVeLbICPt/dePnRBl6ssxo8nYGSrRDKfVIh6UDHYsKvL9ajPejkqy1IbYkF
	ocAZPPmje4ItVXnEm/1AFKVlHzxFXU8=
Date: Thu, 25 Jan 2024 21:12:16 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] bpf, docs: Clarify definitions of various
 instructions
Content-Language: en-GB
To: Dave Thaler <dthaler1968@googlemail.com>, bpf@vger.kernel.org
Cc: bpf@ietf.org, Dave Thaler <dthaler1968@gmail.com>
References: <20240126040050.8464-1-dthaler1968@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20240126040050.8464-1-dthaler1968@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 1/25/24 8:00 PM, Dave Thaler wrote:
> Clarify definitions of several instructions:
> * BPF_NEG does not support BPF_X
> * BPF_CALL does not support BPF_JMP32 or BPF_X
> * BPF_EXIT does not support BPF_X
> * BPF_JA does not support BPF_X (was implied but not explicitly stated)
>
> Also fix a typo in the wide instruction figure where
> the field is actually named "opcode" not "code".
>
> Signed-off-by: Dave Thaler <dthaler1968@gmail.com>

Acked-by: Yonghong Song <yonghong.song@linux.dev>


