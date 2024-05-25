Return-Path: <bpf+bounces-30591-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55B328CF036
	for <lists+bpf@lfdr.de>; Sat, 25 May 2024 18:48:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB3DFB20F4D
	for <lists+bpf@lfdr.de>; Sat, 25 May 2024 16:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61F8185C77;
	Sat, 25 May 2024 16:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YsA6NCRJ"
X-Original-To: bpf@vger.kernel.org
Received: from out-175.mta0.migadu.com (out-175.mta0.migadu.com [91.218.175.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE3FF4FC
	for <bpf@vger.kernel.org>; Sat, 25 May 2024 16:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716655673; cv=none; b=EknhqXE5aDI+l8d6ODeVC3cCrOFVGWcdRpDZYzB37F/rieR/BUupftaNQsLtcFpfDoiZ0V4Y6eWccQQBX9AbbX4kxgoV75PV9D5L7C+vINyI6t/ggHRroyuxLnD20slxJSlb3MSJ/908CSMp0ufGxva4+hD2ZzHcg/+Hgr9jGJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716655673; c=relaxed/simple;
	bh=2OHeLUnmbZjbaUZnPFFJJgxuAYMZJl3JfL88n959kPA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s/96x4fefebhoTRZ/mH6XzWDmLRdDbrwxyw5y87DzSNm16RlLtJj4ODTUeQVRoZngTzhGsvuRyAuxUVwxSzWI9w2fDKpMHQ1ZHaozvNKcATViWYvC3hfytkZNlHnL+zkvPx5NKsll58zuVF9CHYFJq86/uTFLkJniaKQnBMI3XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YsA6NCRJ; arc=none smtp.client-ip=91.218.175.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: dthaler1968@googlemail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1716655668;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2OHeLUnmbZjbaUZnPFFJJgxuAYMZJl3JfL88n959kPA=;
	b=YsA6NCRJRGkxXhv82Mu4j3UzOod3SIQqEGyI266HZMo+KSpawxlahW+oHgJoEdskmRejXg
	NQjG39ut2gWxPX2YlKePOaxHL0ppDt+OoItTLRplsJY3WRhegP451TjXvNLBaQ8MgJdkX7
	G0ui/NgC1I3O1qoNgLzNriA4MeMOrso=
X-Envelope-To: bpf@vger.kernel.org
X-Envelope-To: bpf@ietf.org
X-Envelope-To: dthaler1968@gmail.com
Message-ID: <317b6459-43e9-44b5-a7ee-3af094a131a0@linux.dev>
Date: Sat, 25 May 2024 09:47:41 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] bpf, docs: Clarify call local offset
Content-Language: en-GB
To: Dave Thaler <dthaler1968@googlemail.com>, bpf@vger.kernel.org
Cc: bpf@ietf.org, Dave Thaler <dthaler1968@gmail.com>
References: <20240525153332.21355-1-dthaler1968@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20240525153332.21355-1-dthaler1968@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 5/25/24 9:33 AM, Dave Thaler wrote:
> In the Jump instructions section it explains that the offset is
> "relative to the instruction following the jump instruction".
> But the program-local section confusingly said "referenced by
> offset from the call instruction, similar to JA".
>
> This patch updates that sentence with consistent wording, saying
> it's relative to the instruction following the call instruction.
>
> Signed-off-by: Dave Thaler <dthaler1968@gmail.com>

Acked-by: Yonghong Song <yonghong.song@linux.dev>


