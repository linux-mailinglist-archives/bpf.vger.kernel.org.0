Return-Path: <bpf+bounces-18864-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E93C9822F61
	for <lists+bpf@lfdr.de>; Wed,  3 Jan 2024 15:26:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9889D286B18
	for <lists+bpf@lfdr.de>; Wed,  3 Jan 2024 14:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 652811A599;
	Wed,  3 Jan 2024 14:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P7w1hLWO"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90901A58F;
	Wed,  3 Jan 2024 14:26:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8832CC433C9;
	Wed,  3 Jan 2024 14:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704291961;
	bh=ppXwmUWXscMRJlq+nDKeDC844N+d7GoUgbuzFLGPuBc=;
	h=From:To:Cc:Subject:Date:From;
	b=P7w1hLWOW94yhbswf636CeaSF5q3njSWJOhF5h0lAY9m4WdnsicVWkUsH0eYvhVvn
	 vnsvyV5U2dLSG4W/9UONwDBqAIdQoGji2M1PL3t3u7SmHJ+ZLnAh1oR68c08C9l4P2
	 A3Ia9zDpJS/k/HSYW65GvdqE1ULDNJ/Y+L+Ohua2UcAik5rqenac5Uo6Cu6/+iM4g0
	 Go93v6WXlpM52If2+TMhjQEivcSTc099kKlTp4EqkWRSebnxqvKjd4n6ysquF9S9ny
	 hKqkXgOKbNNwb8RBYw16SpFGwsWWw0SojpXHUa5OnKXzhvFctMTlztRyVM25ZXRq3u
	 fApu8p5rdVTgA==
From: Jiri Olsa <jolsa@kernel.org>
To: stable@vger.kernel.org
Cc: bpf@vger.kernel.org,
	Lee Jones <lee@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: [PATCH stable 5.15 0/1] bpf: Fix map poke update
Date: Wed,  3 Jan 2024 15:25:56 +0100
Message-ID: <20240103142557.4009040-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hi,
sending the 5.15 backport of map poke update fix [1].

It's not straight backport, the details are in changelog. I also backported
the bpf selftest [2] to reproduce the issue and verify the fix, but it's more
deviated from the upstream so I decided not to post it. Also I had to fix bpf
selftests on other place to be able to compile them.

thanks,
jirka


[1] 4b7de801606e ("bpf: Fix prog_array_map_poke_run map poke update")
[2] ffed24eff9e0 ("selftests/bpf: Add test for early update in prog_array_map_poke_run")
---
Jiri Olsa (1):
      bpf: Fix prog_array_map_poke_run map poke update

 arch/x86/net/bpf_jit_comp.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/bpf.h         |  3 +++
 kernel/bpf/arraymap.c       | 58 ++++++++++------------------------------------------------
 3 files changed, 59 insertions(+), 48 deletions(-)

