Return-Path: <bpf+bounces-51992-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE9BBA3CBAE
	for <lists+bpf@lfdr.de>; Wed, 19 Feb 2025 22:42:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DB5E16EE48
	for <lists+bpf@lfdr.de>; Wed, 19 Feb 2025 21:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E4DE2580D2;
	Wed, 19 Feb 2025 21:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cPrtQNYB"
X-Original-To: bpf@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 436692580CA
	for <bpf@vger.kernel.org>; Wed, 19 Feb 2025 21:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740001340; cv=none; b=samWtX/bxauXrMClV4Scxnf9GxPlJIMarwAgEhlBDa6STdOoqcLy6QF6sixCP+bwCi+s+3Nj4wuNmvT3Uw8PjPFZt0UzJmeX6uTRI/LmwVhXfLW6d6RMw6L1pzOY4QnmzCNYECVxHY8T5GNtOeEhI5h6J6GgJjUFDbpVM2OevWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740001340; c=relaxed/simple;
	bh=KvzdbWYnu2chtTnLzLTllw0jpbhUGMOQ6Si9OC9REVk=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=H6sMqdBt5cVHCH6HDwxHvGOMy+GiG5qnM/2wA6Sf6WWoIOknhCpj4zTeaqx/aS2D4JjPg3pU4Kx2N/RHa3AJtqcx1IAsuXQa1BzyQD5y0ztyiMeVZunF1aVMsX6yXooQ6wBiYPBnChbMJmq0h4+u8oQrCfYIoWbnX2Ygd8tx6w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cPrtQNYB; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740001324;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KvzdbWYnu2chtTnLzLTllw0jpbhUGMOQ6Si9OC9REVk=;
	b=cPrtQNYBbcITs2jsmt6+j/pEQfk2XGkz30gBsyltAqB0nmLMcqK/qEk/sxTW5MY0kwTZ/+
	XMfSWkihRxTQ8BjqGJJAJkHj8uTCyNKNVnA+VnjgmS+yAPXgnUHuYpvPP4yyxcBRCqMOp9
	dnuPx6skfx7N6D1YmHSkviX2qxTbLtE=
Date: Wed, 19 Feb 2025 21:42:00 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Ihor Solodrai" <ihor.solodrai@linux.dev>
Message-ID: <959439509729b0d29c3ab48997bb8956c329f2e1@linux.dev>
TLS-Required: No
Subject: Re: [PATCH bpf-next v3 0/4] btf_encoder: emit type tags for
 bpf_arena pointers
To: alan.maguire@oracle.com, acme@kernel.org
Cc: ast@kernel.org, andrii@kernel.org, eddyz87@gmail.com, mykolal@fb.com,
 kernel-team@meta.com, bpf@vger.kernel.org, dwarves@vger.kernel.org
In-Reply-To: <20250219210520.2245369-1-ihor.solodrai@linux.dev>
References: <20250219210520.2245369-1-ihor.solodrai@linux.dev>
X-Migadu-Flow: FLOW_OUT

On 2/19/25 1:05 PM, Ihor Solodrai wrote:
> This patch series implements emitting appropriate BTF type tags for
> argument and return types of kfuncs marked with KF_ARENA_* flags.

Alan, Arnaldo,

I accidentally put "bpf-next" tag in the subject instead of "dwarves".
Please let me know if I should resend.

> [...]

