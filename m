Return-Path: <bpf+bounces-70274-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7579BB5D92
	for <lists+bpf@lfdr.de>; Fri, 03 Oct 2025 05:18:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7FE03AEB80
	for <lists+bpf@lfdr.de>; Fri,  3 Oct 2025 03:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80CD62556E;
	Fri,  3 Oct 2025 03:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="b96IYRWp"
X-Original-To: bpf@vger.kernel.org
Received: from out162-62-57-87.mail.qq.com (out162-62-57-87.mail.qq.com [162.62.57.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A5E14A8B
	for <bpf@vger.kernel.org>; Fri,  3 Oct 2025 03:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759461498; cv=none; b=enGLRqbOpFhL5o68JoHt4ktHgZ1DnScqw+Ih5FfUdkj6ExwmHPxpD3QC0waOIToglhidWwDkkrEVynrCuGgw8HcfDKXJQvJiy4O9rYghuJ761WG5sqDNQUjMKkauVp/vqkV0o96e1PBXB946FqcKGI8ws3h4SbWLwk8ouKSf56A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759461498; c=relaxed/simple;
	bh=kZ7Zf+7o+2/H3fSNoKmoIv/iJboBsocyiRKGfyLkVuM=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=V6XtLRLTJcDreuDm54ZOfu5r5cBuDAN2nhFnd9Q/eu/P5WJijc4HqgqA75FDTMHHUAV0zx01Ky2ToNN6zhAhSRNTuEzbPVH1UVgkpG9dfYJIa+DnlLldCxzT7G0S8ncjOOFLIapxMmqfTk0rQZTkBm8k7XNXIHWZxBY+m9hIdRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=b96IYRWp; arc=none smtp.client-ip=162.62.57.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1759461178;
	bh=kZ7Zf+7o+2/H3fSNoKmoIv/iJboBsocyiRKGfyLkVuM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=b96IYRWpG+pY9PJIRLnWAJU3l6+SX80s9aijQaiCaCshJ79/1s0aFZilVBtvqSyFA
	 dQ60kHBzXAiqiyYWNKHoYFxWJk7YxDJkLs4eYGoF1Ut+W2Ro2V1/a52utM992DQQBi
	 CEgwh//HYS934AYG+3ujJYeTDCShrfp7jsphRN78=
Received: from wolframium.tail477849.ts.net ([112.10.248.244])
	by newxmesmtplogicsvrszc41-0.qq.com (NewEsmtp) with SMTP
	id 33705821; Fri, 03 Oct 2025 11:12:55 +0800
X-QQ-mid: xmsmtpt1759461175t6q4y56gl
Message-ID: <tencent_2F76E206702452E76A0A4F9A4C815F4CC008@qq.com>
X-QQ-XMAILINFO: NY3HYYTs4gYSys4j2vL+X6DG4lMROfL27u9QWWYQbr+M9p1EJ8Zglfkqtx3s19
	 O0pCjptK2kyEi90IXux5SFy/QzaFTN6+wiIN4m40WgztkBPaK+8ajjLxwvvOuwtkAbaep3FRNg4K
	 AyxVi8hsRk7VVcoXRJT4UCCdIzTDbuQSUT6zKxcVpu5S7hKJqI89bUo6fzn0FOXPmTNxMpkRt6DG
	 Hh6c6kOHmLXi3B2ul/nq6SVzLG7/tkUjP8o3JG/ofFY6RwrdaWH5RWDI6AkmH6dCLVCFwR896T9z
	 zwA5BLWXXteaOzZA9A86qfq7vn/b+d/YhLytT6yn7DREqxG0/arp3VfVs6OYwjlxNj9tLUH0Sbqh
	 E0LjmdClFwovZUP9egyxIfkSwvVriQfNc4k22ikayNvEAQpWEwf9/PbNTGWxhyp8Rx5jTa1E2tsA
	 z/FwMFBesW1zwxZuPJzpvgy4PPszwRzdnGkPdBVmzXtz6Lf8n9jZleWzrOro51Mot/JMwP54YXVR
	 /nAH/WmD6kGX1Tc/kWSCH9MHQ1LlYtb+90HXc4lsi4hxMcs2IUHPUEJuFl/lDh5Bp64XLAEqkM/0
	 jytCyv5ez/AEKYWQjyLmM+Sa/1g2eEZjbvS30nZ55UYNRNhrC1rJMnbPk+pL2ZkyNo998tnz2IjD
	 SwuzkXlwD0Yam517HAyd8iyr5QZ3T6N0b8PCmTLJJTIw9ojHgnNCT/hq8nsy+rT4qr4HLbSwaRCT
	 ciJiC3KfmtB0SxPsSYxMHmBge0Wu6S6o7rdcoaL9sbFC2nm9oSqqrxh/VcdjNoIMM3onUfu889TG
	 chNDrBVUlrLtOQhDYL9/UTxU6G6pdWLyJ5LbQw4tNnR+yAbURFcBfALysUNaZu3F8eTf/xKp/zRL
	 fj9vPRw3CoCw9ePw9d33lRS6xby7ZzbmFUq3FurlTv109CVhkjdoyAqjYLDd+ZiMPz0PvOVBFdWl
	 1lxTc1gIMflC0pGoSI48tPqpaSbPkM0FxcjWncjNc6IP/806cUT9mAClmAqslw1asTaTjv590=
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
From: Yazhou Tang <yazhoutang@foxmail.com>
To: eddyz87@gmail.com,
	yonghong.song@linux.dev,
	ast@kernel.org
Cc: andrii@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	haoluo@google.com,
	john.fastabend@gmail.com,
	jolsa@kernel.org,
	kpsingh@kernel.org,
	martin.lau@linux.dev,
	sdf@fomichev.me,
	shenghaoyuan0928@163.com,
	song@kernel.org,
	tangyazhou518@outlook.com,
	yazhoutang@foxmail.com,
	ziye@zju.edu.cn
Subject: Re: [PATCH bpf] bpf: Correctly reject negative offsets for ALU ops
Date: Fri,  3 Oct 2025 11:12:55 +0800
X-OQ-MSGID: <20251003031255.11143-1-yazhoutang@foxmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <77da14fed4467c76d6f8f55a620f79988f0fe04d.camel@gmail.com>
References: <77da14fed4467c76d6f8f55a620f79988f0fe04d.camel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Eduard, Alexei, and Yonghong,

Thank you all for the reviews, feedback, and for applying the patch. My apologies for the delay in my response.

Eduard, thank you so much for adding the selftest yourself to meet the deadline for the pull request. I really appreciate you taking the time to do that, and it's a great example for me to learn from.

Yonghong, thank you for the review and the Acked-by tag.

Alexei, thank you for applying the fix.

As I'm still new to the community, I'm learning to keep up with the pace and workflow. Thanks again to everyone involved for your help and understanding.

Best regards,
Yazhou


