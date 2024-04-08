Return-Path: <bpf+bounces-26132-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A582A89B54D
	for <lists+bpf@lfdr.de>; Mon,  8 Apr 2024 03:37:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D7951F21426
	for <lists+bpf@lfdr.de>; Mon,  8 Apr 2024 01:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 664B1EBB;
	Mon,  8 Apr 2024 01:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R4lLhY0u"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB03B15A8;
	Mon,  8 Apr 2024 01:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712540217; cv=none; b=MkkposOXG/pcyIoL0DFBHzmvO11fnttt26ITtWSl2/yaJvqm1c3j7yF9u0qUHOTc8DOLqJPigCcc9733YaiaYi/2S0juzbM8f4brOUcHLxR75vf4EaHPAK77vG6Zs3P1rwVhJP0alose7BLA5yepASvsItkBNxbBCoTLyBscq0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712540217; c=relaxed/simple;
	bh=RVZ4fWIaP6IkTFxSplanoo7QUKrtDeQ9Xtuch5dmv78=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SVdru5L70BO8+7IOw6WlfALMm0bnC79y+GdYzDI595nqY9rVQmADrC4d1ZURdWhXfi2rqPMa5H9j5GL04zDtla27lLGILfVXmRDwOGhcJ7KCR2WYR8ReiPM/48f9gJ43KD8Cv7Z6na70/SAGLZrhaAuchKqfmIY6QqX/mtaAWxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R4lLhY0u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B379C433C7;
	Mon,  8 Apr 2024 01:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712540216;
	bh=RVZ4fWIaP6IkTFxSplanoo7QUKrtDeQ9Xtuch5dmv78=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R4lLhY0umj7k0Umxz5i4vPnUyLYD/Y3k7PFrB80+2vYSnBkgc+ARayCO8eA9W85kD
	 3MrZkUQkJ1OvSrYczAqFmpndz4kwVlzvscQOpsvdp2mcY9xRuxhX9i1YzmT2Fw9eAi
	 t4LF4meLOONUSF2WehB8dGa4G8Gu0hoK5byA0fPfCR8fMQiCnB4j43heVAuJxiTBU/
	 cGwdjQJnMaFKEsxWKBYJB7VCsXbxPYgTT1JFbWnCag39tCRy/PNBv4lzR2vPvJgm95
	 6jbmR3CDD7zXqKPSyCU5neBK+JJHmTm2nszKMoS7qGmHmMXpkC8ZiiEaXeRDx1Yc9G
	 QJHvH5RvxxG3g==
From: Geliang Tang <geliang@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Mykola Lysenko <mykolal@fb.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Jakub Sitnicki <jakub@cloudflare.com>
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	bpf@vger.kernel.org,
	mptcp@lists.linux.dev
Subject: [PATCH bpf-next v3 2/2] selftests/bpf: Fix umount cgroup2 error in test_sockmap
Date: Mon,  8 Apr 2024 09:36:30 +0800
Message-Id: <5dcde0bcff8d37a5ffe61dbd51848385ddaf2951.1712539403.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1712539403.git.tanggeliang@kylinos.cn>
References: <cover.1712539403.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch fixes the following "umount cgroup2" error in test_sockmap.c:

 (cgroup_helpers.c:353: errno: Device or resource busy) umount cgroup2

Cgroup fd cg_fd should be closed before cleanup_cgroup_environment().

Fixes: 13a5f3ffd202 ("bpf: Selftests, sockmap test prog run without setting cgroup")
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/test_sockmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/test_sockmap.c b/tools/testing/selftests/bpf/test_sockmap.c
index 4f32a5eb3864..520b7d0dadda 100644
--- a/tools/testing/selftests/bpf/test_sockmap.c
+++ b/tools/testing/selftests/bpf/test_sockmap.c
@@ -2107,9 +2107,9 @@ int main(int argc, char **argv)
 		free(options.whitelist);
 	if (options.blacklist)
 		free(options.blacklist);
+	close(cg_fd);
 	if (cg_created)
 		cleanup_cgroup_environment();
-	close(cg_fd);
 	return err;
 }
 
-- 
2.40.1


