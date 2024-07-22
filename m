Return-Path: <bpf+bounces-35271-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A7D19394FA
	for <lists+bpf@lfdr.de>; Mon, 22 Jul 2024 22:51:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A6FC28208F
	for <lists+bpf@lfdr.de>; Mon, 22 Jul 2024 20:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E7E53770C;
	Mon, 22 Jul 2024 20:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l+K6BA1j"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C5F228DC7
	for <bpf@vger.kernel.org>; Mon, 22 Jul 2024 20:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721681507; cv=none; b=rHugAL9wlvWUMarlPaDpzlGJv9ao4Vt1KSvS9kYKB1yZ84ny16VJQERp05aG0CCIQTxIruDea1aHEhgimBVDw8L/TpQcO2nyXhAMF8F9+4g3GdS1jOhEhCcvcMWmwUr2xCtnQdEzYbWHD+8P3ylj5pp/1jEoeT1gZPmpgKwHPc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721681507; c=relaxed/simple;
	bh=ntNSqY4Zu0/cJGPdu+HE+nwUiY7ArKXmB3ra5J/eCsA=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=WC7L2eoGYJOB1DnhE1sqyRmhf/QUCFSUTsqC/E4lsFODn2BG3iggklosGoiYXved64f1502cvp2sTGmxq5DzmHvFICPLKtHeVGWVuuNwJsKAIZ26WSmjcsrrVYC0WaicYl3BZB9C4MSDrv9E6H/OXf0d5F0mtNTpMqwNpyvi2yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l+K6BA1j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 223CAC116B1;
	Mon, 22 Jul 2024 20:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721681507;
	bh=ntNSqY4Zu0/cJGPdu+HE+nwUiY7ArKXmB3ra5J/eCsA=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=l+K6BA1jE0yOk91i+kVcbNDWmF41fMz1gzKLJhJzA8Yjlo+LCENkykHxhyzsdPiXJ
	 oP9vS8CGp7kTKUhVHl1g5yZVejjaeC22y7cCX6deMOBamskjEKlp4IfWTigvVB+3Fl
	 902eBBHQKIkgUJj8Y0qRe28wg8O1s2gGbcIyibqRO+Xr4Iulpu5kX+vvPm/obrcHBB
	 7Uz9RG6b4+DQqm37qTdXbbNMyvOFV/svcUwTFyICSU0ybkyWrw81vOS2PVYTlYSkpc
	 wTMZYeaGm42SKSOtgVRqcuRU8uygMFe4LczdkT9jYLDmLYBEqFLfF9q+GtErwF/W8M
	 JFTOkxVkXDTJw==
Content-Type: multipart/mixed; boundary="===============0045003422432080309=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <fc8cac37edc10c399239e03f8c204b70cd6d9685c255b4eb333a2e4293d6c75c@mail.kernel.org>
In-Reply-To: <20240722202758.3889061-1-jolsa@kernel.org>
References: <20240722202758.3889061-1-jolsa@kernel.org>
Subject: Re: [PATCHv3 bpf-next 0/2] selftests/bpf: Add more uprobe multi tests
From: bot+bpf-ci@kernel.org
To: jolsa@kernel.org
Cc: bpf@vger.kernel.org,kernel-ci@meta.com
Date: Mon, 22 Jul 2024 20:51:47 +0000 (UTC)

--===============0045003422432080309==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Dear patch submitter,

CI has tested the following submission:
Status:     SUCCESS
Name:       [PATCHv3,bpf-next,0/2] selftests/bpf: Add more uprobe multi tests
Patchwork:  https://patchwork.kernel.org/project/netdevbpf/list/?series=873053&state=*
Matrix:     https://github.com/kernel-patches/bpf/actions/runs/10048022329

No further action is necessary on your part.


Please note: this email is coming from an unmonitored mailbox. If you have
questions or feedback, please reach out to the Meta Kernel CI team at
kernel-ci@meta.com.

--===============0045003422432080309==--

