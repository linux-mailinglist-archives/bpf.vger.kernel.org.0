Return-Path: <bpf+bounces-49619-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D36A9A1ACB4
	for <lists+bpf@lfdr.de>; Thu, 23 Jan 2025 23:32:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 969B37A454E
	for <lists+bpf@lfdr.de>; Thu, 23 Jan 2025 22:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5A101CDFA6;
	Thu, 23 Jan 2025 22:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WMwOgAyL"
X-Original-To: bpf@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 426121B4150
	for <bpf@vger.kernel.org>; Thu, 23 Jan 2025 22:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737671570; cv=none; b=g/AcAEs4aeYUNMlQRXmZCabNBj/Ka4/ceDAvqsZ4lAY2u3Z1rBsFb9y2rKdNlsJnfBrh9mDEcKh0boWFSb5iNYVMOeLZZo8diEGkCc4xttCyjjSMpyDGK+vmv0TceRt7HbEf4rRAf9QKlVTBiOBmXMHLXGGVaksfepPWPT/JsE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737671570; c=relaxed/simple;
	bh=FGOuPO+H6o9dOs6lU7snx0iLO684KQtco5iZApuRNHA=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=qLgkdZN39fHTjiVHw7gUP2OdIBG14W09svA2bRt8U22RTDMwIF613MoVMSj6LoPLq8FJNd//9uVskjwO96Ezn9W9WAetYW52NMytNc7RtvYILReAfKvrxN3t/lDFbeZxShx+9B2CjqqgbYpzCbEAs06y846ey6JGoxqzal0QL10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WMwOgAyL; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <3c841f0a-772a-406c-9888-f8e71826daff@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1737671561;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YePAs4AMAqQAOQAtmYiqqvx1YpvkRPTnNXZ/Si3Fv58=;
	b=WMwOgAyL1nlfU6D7+w3YqHsV5GwMDAZgGdptAOWeLecUAWLuyZeIqspxIhV9ZFid1J7UOZ
	aS/dMR0GV03SNgk11rme/IjjJjBR1vElspPORKvBzqZIf3TCqIzaK3D3+9nLpbSfhnbHiU
	7ZYHGnrwM3LOhKhOk66xQ1g4Jnp0Rcw=
Date: Thu, 23 Jan 2025 14:32:38 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
To: Jiri Olsa <jolsa@kernel.org>
Cc: Ilya Leoshkevich <iii@linux.ibm.com>, bpf <bpf@vger.kernel.org>
Subject: [TEST FAILURE] bpf: s390: missed/kprobe_recursion
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi Jiri,

The "missed/kprobe_recursion" fails consistently on s390. It seems to start 
failing after the recent bpf and bpf-next tree ffwd.

An example:
https://github.com/kernel-patches/bpf/actions/runs/12934431612/job/36076956920

Can you help to take a look?

afaict, it only happens on s390 so far, so cc IIya if there is any recent change 
that may ring the bell.

Thanks,
Martin

