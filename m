Return-Path: <bpf+bounces-42931-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4AB99AD23D
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 19:11:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 621EE282024
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 17:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 162421C3030;
	Wed, 23 Oct 2024 17:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="U/eZAhae"
X-Original-To: bpf@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 220714087C
	for <bpf@vger.kernel.org>; Wed, 23 Oct 2024 17:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729703506; cv=none; b=TDsYYHOgP2YirbOdSCO4jbfUJVbMHygyI5OkRai7LnLjrxPijonqRfagM65yko3Cgz7N/nM+Wh+X+Jv5KopnyL+G+PBkHCEasyQd7lvMLxs3eNKN6OZeSKauBYReU00B/cU7/q9ClR5OBtUilivr4sRrze0cbhLLoUAAmnbxpq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729703506; c=relaxed/simple;
	bh=2CPDzzoPiMyg21szfXWsBAS1HoNF/2Cy/3SwU0KRzHI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FYTKxo3RpCgf3LnH0nnxfH805wprDBYlgh4h7j3aVNafrRx//a3Dhci7gVNAb9dGLUkcar/NlMwdRtiuK8IZcfAWeVZgRIwvY6kI6OPWUKVlYbF4dGjab2KbsmgXCT0deoTIZLF0Y6JuB+WrXZW4ZoWqHn0WL2YpqJCh7v2AJtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=U/eZAhae; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f56504d6-3c3a-43f3-ac56-20059bf55eec@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729703502;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2CPDzzoPiMyg21szfXWsBAS1HoNF/2Cy/3SwU0KRzHI=;
	b=U/eZAhae5aXDCo+aSioYEQEnhuY29MU8ScQcd219AXN1Y8rZv2RcopCN6KuFeJlTf9pLpH
	V3JwR72FXdwWqKiQpLZxickL33hfBuAFftgHdlIP9EYjTSvWPxBjSDIMHHWUyOv2Ebqbjd
	jJkmeRfwG3Z0lwd/m6hsmy10nkCP0b0=
Date: Wed, 23 Oct 2024 10:11:32 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf] bpf: fix do_misc_fixups() for
 bpf_get_branch_snapshot()
Content-Language: en-GB
To: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org,
 daniel@iogearbox.net, martin.lau@kernel.org
Cc: kernel-team@meta.com, Shung-Hsi Yu <shung-hsi.yu@suse.com>
References: <20241023161916.2896274-1-andrii@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20241023161916.2896274-1-andrii@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 10/23/24 9:19 AM, Andrii Nakryiko wrote:
> We need `goto next_insn;` at the end of patching instead of `continue;`.
> It currently works by accident by making verifier re-process patched
> instructions.
>
> Reported-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
> Fixes: 314a53623cd4 ("bpf: inline bpf_get_branch_snapshot() helper")
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Acked-by: Yonghong Song <yonghong.song@linux.dev>


