Return-Path: <bpf+bounces-35215-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10B5A938BA6
	for <lists+bpf@lfdr.de>; Mon, 22 Jul 2024 10:58:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A55C21F21A63
	for <lists+bpf@lfdr.de>; Mon, 22 Jul 2024 08:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37F3E16B39D;
	Mon, 22 Jul 2024 08:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iB+yf3iZ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B66C1182BD
	for <bpf@vger.kernel.org>; Mon, 22 Jul 2024 08:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721638671; cv=none; b=JQ1a1iOFAqW3LwoVh0uLxRELy8ybam71RUJxh+pxPUthh7Ag3K2sXThGGEInliA1f/A2oXVW95OMbJKXODEvQwY7MV9s1ukulx155A4PWpu+YBYH8PZQROskiP/poc8/7b5bON1m9cVN/D9Oc8pwiZKfGhqz2l3t4KQQ9TI/Bfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721638671; c=relaxed/simple;
	bh=yIs6yEKDk7VgyErW2Gra9a3a+a/0nMwGbvoNmYVHu0s=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:Cc:Date; b=mcWy1B+CGO6Cw/hkunCht6Lv6mPN3x5cKO8ILyqftxV1P1ugkJiBuZEZxmbpTmK8IFuhUxVRePPRRcigtcMQCGZZYrcATygGqbdtcT3+4WqpaizK20/v7DOVsAUEm3ktxCDbv+H7wQb8U2OAqUdrUxrO8uvjRQsc8mI76D71fzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iB+yf3iZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FBEDC116B1;
	Mon, 22 Jul 2024 08:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721638671;
	bh=yIs6yEKDk7VgyErW2Gra9a3a+a/0nMwGbvoNmYVHu0s=;
	h=In-Reply-To:References:Subject:From:Cc:Date:From;
	b=iB+yf3iZ4r5LtQUJArvWfZ3P6MJwFavaVGTV5TOOs6sQRs7tz7nc2ucba9Y1+Mkee
	 y+tqeQh2VWAMcpMYqRrz9rU5beNzw7GXb0zHC1cq9K4AFWR+pXvklSvO8ln63pg3lW
	 cFuGDklT2h8vmQRmVnvAYj1PmFaCrtH9LfUMuM5s5ZmZcTJ1H3FJ21gLIBw8iiTFuT
	 Dl8/pAdrXHUWwUQ535K8oksmA67vn/Nun0AbIWBjrZ0HdAKerOvHz2Xkj/PwnSfR04
	 9ixk8zkYqel4oQA7LeplN/IlesbBYmwEBS87g/dwHnCPufQCz5OpecW6G/Oyue1SX/
	 z/2tY2bdph4QQ==
Content-Type: multipart/mixed; boundary="===============3295564600368584079=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <ba5f4af55d48223db3027ceb1e077e2609f6b9643ba720c106cb8fc7b88a2710@mail.kernel.org>
In-Reply-To: <20240722083305.4009723-1-liwei.song.lsong@gmail.com>
References: <20240722083305.4009723-1-liwei.song.lsong@gmail.com>
Subject: Re: [PATCH] tools/resolve_btfids: fix comparison of distinct pointer types warning in resolve_btfids
From: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org,kernel-ci@meta.com
Date: Mon, 22 Jul 2024 08:57:51 +0000 (UTC)

--===============3295564600368584079==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Dear patch submitter,

CI has tested the following submission:
Status:     FAILURE
Name:       tools/resolve_btfids: fix comparison of distinct pointer types warning in resolve_btfids
Patchwork:  https://patchwork.kernel.org/project/netdevbpf/list/?series=872877&state=*
Matrix:     https://github.com/kernel-patches/bpf/actions/runs/10037557445

Failed jobs:
test_progs_no_alu32-x86_64-llvm-17: https://github.com/kernel-patches/bpf/actions/runs/10037557445/job/27737836978

First test_progs failure (test_progs_no_alu32-x86_64-llvm-17):
#55 cgrp_local_storage
cgrp2_local_storage:PASS:join_cgroup /cgrp_local_storage 0 nsec
#55/2 cgrp_local_storage/attach_cgroup
test_attach_cgroup:PASS:skel_open 0 nsec
test_attach_cgroup:PASS:prog_attach 0 nsec
test_attach_cgroup:PASS:prog_attach 0 nsec
test_attach_cgroup:PASS:prog_attach 0 nsec
test_attach_cgroup:PASS:start_server 0 nsec
test_attach_cgroup:PASS:connect_to_fd 0 nsec
test_attach_cgroup:FAIL:map_lookup(socket_cookies) unexpected error: -2 (errno 2)


Please note: this email is coming from an unmonitored mailbox. If you have
questions or feedback, please reach out to the Meta Kernel CI team at
kernel-ci@meta.com.

--===============3295564600368584079==--

