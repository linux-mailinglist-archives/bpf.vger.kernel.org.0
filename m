Return-Path: <bpf+bounces-44967-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E16B9CF266
	for <lists+bpf@lfdr.de>; Fri, 15 Nov 2024 18:08:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24485B34777
	for <lists+bpf@lfdr.de>; Fri, 15 Nov 2024 15:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C68618B484;
	Fri, 15 Nov 2024 15:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vahedi.org header.i=@vahedi.org header.b="tuYIJEXb"
X-Original-To: bpf@vger.kernel.org
Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B65B1C07EE
	for <bpf@vger.kernel.org>; Fri, 15 Nov 2024 15:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731686157; cv=none; b=c17PfbeGsoaUnGCNcUqFizP7er3cHNze+9bx0W7yqGvWm8r0FANfs9G0tMHxPcmhZqzcb4he0M1mOD22mYtM+FiVCmGspq9zdcuFu2q4wtG2zYEj4IldlGj16B6tKl1lFPlNoHbh5ryxDa5NZitCz+q2Hj4SVW6W4vlLoniewNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731686157; c=relaxed/simple;
	bh=HdWjOHueCR6/5j65kCwu4Zc3r5ik3HUAa5hvMDkF9UU=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=c5BzWPyKHpUwheUGmDRCben1cflVdo8M9XBfD6+FJWfWDb2gHQOsV1er2Y/2egu5ZU1c24ov6hdbIxT78sJgrpJnoPN4hbxp+5/g2tBAwbiwHGA8/0RXYE5uZ7Fb25venETA4+KzVFiHpyBilcIp5j9Fd/36xlZczhpENO93pn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vahedi.org; spf=pass smtp.mailfrom=vahedi.org; dkim=pass (2048-bit key) header.d=vahedi.org header.i=@vahedi.org header.b=tuYIJEXb; arc=none smtp.client-ip=95.215.58.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vahedi.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vahedi.org
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vahedi.org; s=key1;
	t=1731686146;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HdWjOHueCR6/5j65kCwu4Zc3r5ik3HUAa5hvMDkF9UU=;
	b=tuYIJEXbIJ92o4581lKLOsQO76OU5Ni2ZxiKU5sCYcalYdUOBSX0Bdz0/q16PXvT/+TeH4
	pFXIHV3+F5o+gPbHTT3pFvcwHRWj14mgrlrAxMRJcSmuaJNW972j50FheZqs2GpGRm3Pk9
	1ou93iJYHP6copcs2FWuCXwc4iQvR4TUs67jo/ghdxH1YD6LDsEmLhQmkDgBB5VR9FLel+
	GLG+JVrPKijvs/1UcMTbyDKRyjshMm0yybf4WkEYjjOIlcl6bUMo4J+hyO3RNMa2urGwGV
	Douas6ye4fGV10pRXssIc4kQlj9wOaWVXI5ga7b/CN2C76+D1J01XyROLMNBdg==
Date: Fri, 15 Nov 2024 15:55:40 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Shahab Vahedi" <list+bpf@vahedi.org>
Message-ID: <f5f49eee8979985439408e7bd6fbd1534e91a115@vahedi.org>
TLS-Required: No
Subject: Re: [PATCH v2] ARC: bpf: Correct conditional check in 'check_jmp_32'
To: "Vineet Gupta" <vineet.gupta@linux.dev>
Cc: vadim.fedorenko@linux.dev, tarang.raval@siliconsignals.io, "Vineet Gupta"
 <vgupta@kernel.org>, bpf@vger.kernel.org,
 linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
 "Hardevsinh Palaniya" <hardevsinh.palaniya@siliconsignals.io>, "Shahab
 Vahedi" <list+bpf@vahedi.org>
In-Reply-To: <920e71ab-2375-4722-bcf3-d6aaf8e68b3a@vahedi.org>
References: <20241113134142.14970-1-hardevsinh.palaniya@siliconsignals.io>
 <920e71ab-2375-4722-bcf3-d6aaf8e68b3a@vahedi.org>
X-Migadu-Flow: FLOW_OUT

Hi Vineet,

Could you pick up this patch [1] in your "next"?

Thanks,
Shahab

[1]
https://lore.kernel.org/bpf/920e71ab-2375-4722-bcf3-d6aaf8e68b3a@vahedi.o=
rg/T/#t

