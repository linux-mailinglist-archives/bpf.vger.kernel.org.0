Return-Path: <bpf+bounces-50297-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F20DA24D00
	for <lists+bpf@lfdr.de>; Sun,  2 Feb 2025 08:53:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 831D6168218
	for <lists+bpf@lfdr.de>; Sun,  2 Feb 2025 07:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE1141DDC0A;
	Sun,  2 Feb 2025 07:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nppct.ru header.i=@nppct.ru header.b="bs7uuZaN"
X-Original-To: bpf@vger.kernel.org
Received: from mail.nppct.ru (mail.nppct.ru [195.133.245.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96A91DB527
	for <bpf@vger.kernel.org>; Sun,  2 Feb 2025 07:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.133.245.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738482657; cv=none; b=IPNtKtZ/LzInvs8CTacT68abVJdXb0cw+waFsMhLiJ+Nbx06iPao+5F4Z1KTvm2zy/iVQ3u1/FE2qMvcApymyDdqYc0Kqu1ljdB7yHlhr/WYE2uzptK9mURNelm9MytvI4VZj6k/jM0lHTgBwbb3EiKhdtXsrs4nWOc10MNMd2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738482657; c=relaxed/simple;
	bh=kyQ9akgwVX8wxCsx2V+xoWQH+koRQPP7eyCpSK9HL0k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z54iCQOGcykmP280HrO6IoYMXQU3c3/BYbrLeD/GHe9HJ/OvU5beEeFdS779VZQbp5I2V1l2948G6I4SQr7NlV+JXBY4yvBlkAoekLJv5ttjuj3OJtLFE1Ow9Zl1ng/OOC/j2dGAR/NhpIpKDwlwBzVsC9572Y1azIdNhlj6Cfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nppct.ru; spf=pass smtp.mailfrom=nppct.ru; dkim=pass (1024-bit key) header.d=nppct.ru header.i=@nppct.ru header.b=bs7uuZaN; arc=none smtp.client-ip=195.133.245.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nppct.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nppct.ru
Received: from mail.nppct.ru (localhost [127.0.0.1])
	by mail.nppct.ru (Postfix) with ESMTP id 426E71C2431
	for <bpf@vger.kernel.org>; Sun,  2 Feb 2025 10:50:54 +0300 (MSK)
Authentication-Results: mail.nppct.ru (amavisd-new); dkim=pass (1024-bit key)
	reason="pass (just generated, assumed good)" header.d=nppct.ru
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nppct.ru; h=
	content-transfer-encoding:content-type:content-type:mime-version
	:references:in-reply-to:x-mailer:message-id:date:date:subject
	:subject:to:from:from; s=dkim; t=1738482653; x=1739346654; bh=ky
	Q9akgwVX8wxCsx2V+xoWQH+koRQPP7eyCpSK9HL0k=; b=bs7uuZaNuMQ8NxRfmJ
	p94a/Brz68mBUrAOoILK+Fm3zSo9eBY5q+WBHte9B9y5CaM+z0VZRHHvy5snKM5C
	BwGhDVovngJtIhhPTWjIFL12lb8BuDlTVvUQNbgwFKPNyuKtTuVPhZJCmP5OsSQS
	PVNx9gQUuaHxdXzBIYDH50iNw=
X-Virus-Scanned: Debian amavisd-new at mail.nppct.ru
Received: from mail.nppct.ru ([127.0.0.1])
	by mail.nppct.ru (mail.nppct.ru [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id AEMTUN4dS8jq for <bpf@vger.kernel.org>;
	Sun,  2 Feb 2025 10:50:53 +0300 (MSK)
Received: from localhost.localdomain (unknown [87.249.24.51])
	by mail.nppct.ru (Postfix) with ESMTPSA id 8D0761C19B7;
	Sun,  2 Feb 2025 10:50:25 +0300 (MSK)
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
	lvc-project@linuxtesting.org,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Hou Tao <houtao1@huawei.com>
Subject: [PATCH 6.1 15/16] bpf: Remove unnecessary check when updating LPM trie
Date: Sun,  2 Feb 2025 07:46:52 +0000
Message-ID: <20250202074709.932174-16-sdl@nppct.ru>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250202074709.932174-1-sdl@nppct.ru>
References: <20250202074709.932174-1-sdl@nppct.ru>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Hou Tao <houtao1@huawei.com>

commit 156c977c539e87e173f505b23989d7b0ec0bc7d8 upstream.

When "node->prefixlen == matchlen" is true, it means that the node is
fully matched. If "node->prefixlen == key->prefixlen" is false, it means
the prefix length of key is greater than the prefix length of node,
otherwise, matchlen will not be equal with node->prefixlen. However, it
also implies that the prefix length of node must be less than
max_prefixlen.

Therefore, "node->prefixlen == trie->max_prefixlen" will always be false
when the check of "node->prefixlen == key->prefixlen" returns false.
Remove this unnecessary comparison.

Reviewed-by: Toke Høiland-Jørgensen <toke@redhat.com>
Acked-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Hou Tao <houtao1@huawei.com>
Link: https://lore.kernel.org/r/20241206110622.1161752-2-houtao@huaweicloud.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Alexey Nepomnyashih <sdl@nppct.ru>
---
 kernel/bpf/lpm_trie.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/bpf/lpm_trie.c b/kernel/bpf/lpm_trie.c
index fd6e31e72290..6c96241f49a4 100644
--- a/kernel/bpf/lpm_trie.c
+++ b/kernel/bpf/lpm_trie.c
@@ -358,8 +358,7 @@ static int trie_update_elem(struct bpf_map *map,
 		matchlen = longest_prefix_match(trie, node, key);
 
 		if (node->prefixlen != matchlen ||
-		    node->prefixlen == key->prefixlen ||
-		    node->prefixlen == trie->max_prefixlen)
+		    node->prefixlen == key->prefixlen)
 			break;
 
 		next_bit = extract_bit(key->data, node->prefixlen);
-- 
2.43.0


