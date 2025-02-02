Return-Path: <bpf+bounces-50282-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6778AA24CD9
	for <lists+bpf@lfdr.de>; Sun,  2 Feb 2025 08:48:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0BCA164562
	for <lists+bpf@lfdr.de>; Sun,  2 Feb 2025 07:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A773A1D5175;
	Sun,  2 Feb 2025 07:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nppct.ru header.i=@nppct.ru header.b="duyirvnC"
X-Original-To: bpf@vger.kernel.org
Received: from mail.nppct.ru (mail.nppct.ru [195.133.245.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A23A4A04
	for <bpf@vger.kernel.org>; Sun,  2 Feb 2025 07:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.133.245.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738482511; cv=none; b=pqVd/Moi/jVD9hTVtBF0F1y3JYcv5TvVR1of0tGPiiQuZwi+Tqn6gq1KzJ4niZuRnmNe6NShjEDXz7D2SgE9R0j7/rtFSbTjG0xJ0GlO8gh7uIG0k2w/FP05zGZiQNsPH98Ha0JTJJwU8nQPVQ5eUV66su7Dd64Mr7CVIYFBqzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738482511; c=relaxed/simple;
	bh=jBKl9aWHVPRunedWDfDLmp8zjxlO43EB/Sdp/YzUCJk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ti1GAEuXQarQHfr9rY97gUva6myCRZ4TCrrNfbQqd2AJY1YXOCLmGR3eZ4OxJcSTBlqT9ziSE7UXOU9cWQw7JEuF3uNiJh/O42/ZiU7KFFS79ThcE//yxuPdfHuwEoIld5zneeKDh4zxJZnafsCc/ClJCMHP4jiBxS89cZZasco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nppct.ru; spf=pass smtp.mailfrom=nppct.ru; dkim=pass (1024-bit key) header.d=nppct.ru header.i=@nppct.ru header.b=duyirvnC; arc=none smtp.client-ip=195.133.245.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nppct.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nppct.ru
Received: from mail.nppct.ru (localhost [127.0.0.1])
	by mail.nppct.ru (Postfix) with ESMTP id BD4BB1C19E1
	for <bpf@vger.kernel.org>; Sun,  2 Feb 2025 10:48:17 +0300 (MSK)
Authentication-Results: mail.nppct.ru (amavisd-new); dkim=pass (1024-bit key)
	reason="pass (just generated, assumed good)" header.d=nppct.ru
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nppct.ru; h=
	content-transfer-encoding:mime-version:x-mailer:message-id:date
	:date:subject:subject:to:from:from; s=dkim; t=1738482495; x=
	1739346496; bh=jBKl9aWHVPRunedWDfDLmp8zjxlO43EB/Sdp/YzUCJk=; b=d
	uyirvnCH2G8m3v4+0oEZlaoV4xz1ohYyYK4bkSMSMRWPF9/CVlTVUp0CdQFqjviX
	mhoKMCRxdJRw7fSS/VzWDf42heTau+jMZOYXJ6clAvMRexieNO8cqSXJNVxxAueY
	bLSY/K4c+u+xg24meHkclVDzSwT6uYFyGV/nBWWtzU=
X-Virus-Scanned: Debian amavisd-new at mail.nppct.ru
Received: from mail.nppct.ru ([127.0.0.1])
	by mail.nppct.ru (mail.nppct.ru [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id wKbxkZjHdp75 for <bpf@vger.kernel.org>;
	Sun,  2 Feb 2025 10:48:15 +0300 (MSK)
Received: from localhost.localdomain (unknown [87.249.24.51])
	by mail.nppct.ru (Postfix) with ESMTPSA id 642871C19DD;
	Sun,  2 Feb 2025 10:48:13 +0300 (MSK)
From: Alexey Nepomnyashih <sdl@nppct.ru>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alexey Nepomnyashih <sdl@nppct.ru>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yhs@fb.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <quic_neeraju@quicinc.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH 6.1 00/16] Fixes bpf and rcu
Date: Sun,  2 Feb 2025 07:46:37 +0000
Message-ID: <20250202074709.932174-1-sdl@nppct.ru>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi, this series backports fix https://syzkaller.appspot.com/bug?id=d4d4abdb121f42913b3a149f2d846a7dd7eeb7e2 linux-6.1.y

Here is the summary with links:
  - [6.1 01/16] bpf: Add a few bpf mem allocator functions.
    https://git.kernel.org/bpf/bpf/c/e65a5c6edbc6

  - [6.1 02/16] bpf: Factor out a common helper free_all().
    https://git.kernel.org/bpf/bpf/c/aa7881fcfe9d

  - [6.1 03/16] bpf: Rename few bpf_mem_alloc fields.
    https://git.kernel.org/bpf/bpf/c/12c8d0f4c870

  - [6.1 04/16] bpf: Let free_all() return the number of freed elements.
    https://git.kernel.org/bpf/bpf/c/9de3e81521b4

  - [6.1 05/16] bpf: Refactor alloc_bulk().
    https://git.kernel.org/bpf/bpf/c/05ae68656a8e

  - [6.1 07/16] bpf: Use rcu_trace_implies_rcu_gp() in bpf memory allocator.
    https://git.kernel.org/bpf/bpf/c/59be91e5e70a

  - [6.1 08/16] bpf: Further refactor alloc_bulk().
    https://git.kernel.org/bpf/bpf/c/7468048237b8

  - [6.1 09/16] bpf: Change bpf_mem_cache draining process.
    https://git.kernel.org/bpf/bpf/c/d114dde245f9

  - [6.1 10/16] bpf: Add a hint to allocated objects.
    https://git.kernel.org/bpf/bpf/c/822fb26bdb55

  - [6.1 11/16] bpf: Introduce bpf_mem_free_rcu() similar to kfree_rcu().
    https://git.kernel.org/bpf/bpf/c/5af6807bdb10

  - [6.1 12/16] rcu: Fix missing nocb gp wake on rcu_barrier()
    https://git.kernel.org/bpf/bpf/c/b8f7aca3f0e0

  - [6.1 13/16] rcu: Make call_rcu() lazy to save power
    https://git.kernel.org/bpf/bpf/c/3cb278e73be5

  - [6.1 14/16] rcu: Export rcu_request_urgent_qs_task()
    https://git.kernel.org/bpf/bpf/c/43a89baecfe2

  - [6.1 15/16] bpf: Remove unnecessary check when updating LPM trie
    https://git.kernel.org/bpf/bpf/c/156c977c539e

  - [6.1 16/16] bpf: Switch to bpf mem allocator for LPM trie
    https://git.kernel.org/bpf/bpf/c/3d8dc43eb2a3

