Return-Path: <bpf+bounces-35265-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D2FA0939480
	for <lists+bpf@lfdr.de>; Mon, 22 Jul 2024 21:58:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E5D0B21933
	for <lists+bpf@lfdr.de>; Mon, 22 Jul 2024 19:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47FC8171640;
	Mon, 22 Jul 2024 19:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ogk2mIqW"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6FA16D9D7
	for <bpf@vger.kernel.org>; Mon, 22 Jul 2024 19:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721678271; cv=none; b=gF+3irNUurGhPZ8xFpzQ2VSx7JkmBMyF+m+R5PJ7h4y2pwKxbOqvI/OcaYRxyRz64wfqR02OKSROQjdZ9KFw9I4aAl/+OQ2/M2c+cSmRFcmQKEmp2cc13NtmZBnXm4pEJ3a4aS5myL6+EMRAj4k09H0QzRlJ08Y5Hoddqfc458g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721678271; c=relaxed/simple;
	bh=qJKd64csBB7NLT0yRGHAUH63XXobtDq1Q8nY/OhUAJE=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:Cc:Date; b=G9K8zzOhg8VMXqPaqn8j4jw8lWQpsklWlocICE/ruPHJjr4SL5YyOzU1gBH+V9LdPoyYnGviwesoAwKUKU1ilB917CfbfACyOwlMukVYyAL8TA0juKkcQI6UbOPcbbMCXIrZVBBcOXHCFUdhzWiH7XXPnGM51gvPoTwONce1Ofk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ogk2mIqW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CD0CC116B1;
	Mon, 22 Jul 2024 19:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721678271;
	bh=qJKd64csBB7NLT0yRGHAUH63XXobtDq1Q8nY/OhUAJE=;
	h=In-Reply-To:References:Subject:From:Cc:Date:From;
	b=Ogk2mIqWg+BePUIRmh+LQK/rD8jZH2SFqn6dmwFq+vflmE6h1LA87obFXXH+iY4RA
	 m3lb07/pO2mM8pwIsveWM7YHtN/+o+BQxQDjLTBC+xIwaAkjz7N1G7/2nF5DRyApT/
	 Fr0RA48W3tqjm6RJqxF3M+6kZ9w5XFA7/LMm7MlQNdWkd7ksAQ6LCY18Ro8FfluGay
	 8CwhhNUNCU3pnxLvodpRtyvEC9hBDtitrtIuu06dWxdp9CAGpXsi5a631jk7fgKJOF
	 xB/7qmoKSRV2XUJIlwkxfSJGrl1/XUjiA5zFbozuwbfm9Vsb3J4GEeYzAQx3LD5ARO
	 MFs1xhzXMFhgQ==
Content-Type: multipart/mixed; boundary="===============4839702971880735754=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <126d45c3b60565401e99b6bd1cb905f8065cf662a9280f53a38e3a4f74310a22@mail.kernel.org>
In-Reply-To: <20240719110059.797546-1-xukuohai@huaweicloud.com>
References: <20240719110059.797546-1-xukuohai@huaweicloud.com>
Subject: Re: [PATCH bpf-next v2 0/9] Add BPF LSM return value range check, BPF part
From: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org,kernel-ci@meta.com
Date: Mon, 22 Jul 2024 19:57:51 +0000 (UTC)

--===============4839702971880735754==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Dear patch submitter,

CI has tested the following submission:
Status:     FAILURE
Name:       [bpf-next,v2,0/9] Add BPF LSM return value range check, BPF part
Patchwork:  https://patchwork.kernel.org/project/netdevbpf/list/?series=872507&state=*
Matrix:     https://github.com/kernel-patches/bpf/actions/runs/10047146420

Failed jobs:
test_progs_no_alu32-aarch64-gcc: https://github.com/kernel-patches/bpf/actions/runs/10047146420/job/27768485774


Please note: this email is coming from an unmonitored mailbox. If you have
questions or feedback, please reach out to the Meta Kernel CI team at
kernel-ci@meta.com.

--===============4839702971880735754==--

