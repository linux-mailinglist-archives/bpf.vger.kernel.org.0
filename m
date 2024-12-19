Return-Path: <bpf+bounces-47361-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E8C6A9F873D
	for <lists+bpf@lfdr.de>; Thu, 19 Dec 2024 22:42:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D32A17A25F0
	for <lists+bpf@lfdr.de>; Thu, 19 Dec 2024 21:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D2301C5CA8;
	Thu, 19 Dec 2024 21:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="LFEo2N3+"
X-Original-To: bpf@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098E31B9835;
	Thu, 19 Dec 2024 21:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734644521; cv=none; b=f0D66sMB9g8uwiy1b+UXGJdYE9p4um9p31Pt2a86K6lbiyl828VOmJQAD8PcxIDq/tC4a+LDnLCQgm6wp7UlJo6BVJTm3FMsMfPqdj1nBVLe5jFT5wFqJdfmhPzRzDYvBaDnfhZQ9VjtAX4JEBMs9PGBMjHEoHEAczZiGVVOOhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734644521; c=relaxed/simple;
	bh=N7zV5DkWHia7sGpJsVWCCVm57p6Exu7y9drwz1qt3gc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=jJefJq1P0SWTNxxZkCJ2KfQyPqnyxU8gGuok08vUL2IhPxGoH0vAqOofjx84YofphI3KyMcrGa3XWHqDUU/+1EdBWx5ERY+NqE6fPflYsHiXbrPHfI6/rDHm/dqjXhndFo9l3EKsZ5EvenJ9VXiTyyd6ke0rzjKcPful37wG/U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=LFEo2N3+; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1734644507;
	bh=N7zV5DkWHia7sGpJsVWCCVm57p6Exu7y9drwz1qt3gc=;
	h=From:Date:Subject:To:Cc:From;
	b=LFEo2N3+luM1YsgF48hDz2mZ2DVOe0xDDbAv1SK4X6DEh2qBzDa1v47lDKDO8OKKF
	 0jYJxSsVNT08lA9n3eqjgHfAVjaEbh9HaYEanq/4QBVoIo9e0CBpW4r1DltMBObo5y
	 T1bUyIyDoQzTHfulA5NSvKqMhOOJkz80VBm2lRn8=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Thu, 19 Dec 2024 22:41:41 +0100
Subject: [PATCH] bpf: Fix holes in special_kfunc_list if !CONFIG_NET
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241219-bpf-fix-special_kfunc_list-v1-1-d9d50dd61505@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIABSTZGcC/x3M0QqDMAxA0V+RPBuwZRu4XxGRNk1nmNTSqAjiv
 6/s8cDlXqBchBXezQWFD1FZU4VpG6DZpQ+jhGqwnX0Ya3r0OWKUEzUziVumb9wTTYvohhQCxc6
 7pzUvqINcuJb/+TDe9w9/r9EXbAAAAA==
X-Change-ID: 20241219-bpf-fix-special_kfunc_list-cddcf0ba5216
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 Alexei Starovoitov <ast@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734644507; l=1201;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=N7zV5DkWHia7sGpJsVWCCVm57p6Exu7y9drwz1qt3gc=;
 b=a9MvAkf6zdk7yLL/tKIQON4suaDXbNvR7+hkdIqWCu6MjC9U05t0kgMVv/mCkrrHTdP5CVQ2q
 1H4AHRHkWkODEQmLOdCrwSbKoPAceiM+04bW98+smLTkrk6OQhBpTTx
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

If the function is not available its entry has to be replaced with
BTF_ID_UNUSED instead of skipped.
Otherwise the list doesn't work correctly.

Reported-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Closes: https://lore.kernel.org/lkml/CAADnVQJQpVziHzrPCCpGE5=8uzw2OkxP8gqe1FkJ6_XVVyVbNw@mail.gmail.com/
Fixes: 00a5acdbf398 ("bpf: Fix configuration-dependent BTF function references")
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 kernel/bpf/verifier.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index f27274e933e55342dcefa482a9ac75313d0d3469..44616b492f87cf4e1dc354e34d9158f13079dda7 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -11739,6 +11739,9 @@ BTF_ID(func, bpf_rbtree_first)
 #ifdef CONFIG_NET
 BTF_ID(func, bpf_dynptr_from_skb)
 BTF_ID(func, bpf_dynptr_from_xdp)
+#else
+BTF_ID_UNUSED
+BTF_ID_UNUSED
 #endif
 BTF_ID(func, bpf_dynptr_slice)
 BTF_ID(func, bpf_dynptr_slice_rdwr)

---
base-commit: c2ce3bb13ae7f4445a5e8fb12254b2dacefd309c
change-id: 20241219-bpf-fix-special_kfunc_list-cddcf0ba5216

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


