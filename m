Return-Path: <bpf+bounces-35116-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D5CD937CB5
	for <lists+bpf@lfdr.de>; Fri, 19 Jul 2024 20:50:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B038CB20E81
	for <lists+bpf@lfdr.de>; Fri, 19 Jul 2024 18:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7369D147C76;
	Fri, 19 Jul 2024 18:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dOBBvCeP"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F17A9144D3B
	for <bpf@vger.kernel.org>; Fri, 19 Jul 2024 18:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721414996; cv=none; b=dYnh/QUDFj5/dvJjd/ANcRKSV5SSkouUJlHnl6A561W6YUNTIn3JvPIJ30BAeeRfujS/RVU8WK5vqLZvJpeOXxDebTW12SrJbFBTwAypKsDxVQhwmTAgah0tU8aOPf1UkwRFL+ZXW6vhx8EDhlC8OVAk12/B+LebkF+D7VXK2jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721414996; c=relaxed/simple;
	bh=wVhhhgQq7QogrYZTg+YDMEIgWPFl36VpD+Tdn91m80Q=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=MBMOVJJgMqxeQNk6w/UNJmW2WNJFsidPAjzajuPmteby6gL5Uw0aQIOEOeu+alC94tUf9QUc4bIuUYQ2LiOAEnoJrfCtMDAK01M0CV6EwarAKbgChBb+EVzfVu9Ed/2YN+FDWS5rPPVsAIbiglw5j5QEt4fmceEoAak+YGq6SZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dOBBvCeP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86B2FC32782;
	Fri, 19 Jul 2024 18:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721414995;
	bh=wVhhhgQq7QogrYZTg+YDMEIgWPFl36VpD+Tdn91m80Q=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=dOBBvCePGK9Up6k12fbb9TUFIi+kZL7l7xQCEh4mCnFXeH3aptW5gY1WksXZiIys7
	 0UXoyrn7l0dCBiu6yJGRePdrTVBHm8K1F1hvUF9PZc3icb5PdTciNbex7oXQ2Tu4tC
	 3QOxau8W4X/ZbFm/OE4EIEodOxF93EEAI393NCLgUhEvFEcNPH7TzU8Fwp+DlRIAUG
	 TaDUsaFjSr3HmdMvh0CfUBRyAf8pIBXDSozkiJuo4T1LHszbCgkGzO6q47F0BhuAEC
	 yJnbZvyYAarBg8FILPgpR6IFU2GT0kKm1xHvfq3XtnxN7knWjfYP3ECM+e+s5Js5RH
	 EbYh2T6lco21Q==
Content-Type: multipart/mixed; boundary="===============7169545325444662671=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <2db128400564d76a0fbd00793a8858949173bb87c94e5981dfdefeb42c187c8a@mail.kernel.org>
In-Reply-To: <20240718050228.3543663-1-yonghong.song@linux.dev>
References: <20240718050228.3543663-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: Add tests for ldsx of pkt data/data_end/data_meta accesses
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev
Cc: bpf@vger.kernel.org,kernel-ci@meta.com
Date: Fri, 19 Jul 2024 18:49:54 +0000 (UTC)

--===============7169545325444662671==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Dear patch submitter,

CI has tested the following submission:
Status:     FAILURE
Name:       [bpf-next,v2,2/2] selftests/bpf: Add tests for ldsx of pkt data/data_end/data_meta accesses
Patchwork:  https://patchwork.kernel.org/project/netdevbpf/list/?series=872131&state=*
Matrix:     https://github.com/kernel-patches/bpf/actions/runs/10012611999

Failed jobs:
test_progs_no_alu32-x86_64-gcc: https://github.com/kernel-patches/bpf/actions/runs/10012611999/job/27678870744
test_progs_cpuv4-x86_64-llvm-18: https://github.com/kernel-patches/bpf/actions/runs/10012611999/job/27678880193

First test_progs failure (test_progs_no_alu32-x86_64-gcc):
#59 connect_force_port
(network_helpers.c:104: errno: Address already in use) Failed to bind socket
test_connect_force_port:FAIL:142


Please note: this email is coming from an unmonitored mailbox. If you have
questions or feedback, please reach out to the Meta Kernel CI team at
kernel-ci@meta.com.

--===============7169545325444662671==--

