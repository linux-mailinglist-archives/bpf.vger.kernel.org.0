Return-Path: <bpf+bounces-21147-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DCB1848B99
	for <lists+bpf@lfdr.de>; Sun,  4 Feb 2024 07:58:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3DDCFB23655
	for <lists+bpf@lfdr.de>; Sun,  4 Feb 2024 06:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D60537499;
	Sun,  4 Feb 2024 06:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DbYbZy+P"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D1F47493;
	Sun,  4 Feb 2024 06:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707029906; cv=none; b=J9q/7dyLGYr0csJB0zjTU3r/LPrLQHqAWQG7PHgYzKScTnJN0zgVuepDeMEP8rerqFTXWZudc1GJPAvvLhMXQunGfduF6vlR/sulO3YLJtYmQVz2nWXpXvomVl/8ARUC/xpQEWry4g76i/qp/vGVUWwoWwx7Nzy2Yevcw0IUsWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707029906; c=relaxed/simple;
	bh=G2WggoaiJ875OWwNt8yNgdTIYrWZZv0FoObX507FdZY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YGHVvilG6x2qh0aXJve5odgMEyLCQQlaMb/sfMuY7wBjWdMt0OeyKIz2VpT74HWHrILaQ7pj/Fryjp68RPz0h+27rzGdRJ19feOn5yliPLXNyFLlQobSNiahEupAB95OhEi4CQNhRo3NRHntmnBW/jtlt9EHpNkb17gz+sze2WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DbYbZy+P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1860BC433F1;
	Sun,  4 Feb 2024 06:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707029905;
	bh=G2WggoaiJ875OWwNt8yNgdTIYrWZZv0FoObX507FdZY=;
	h=From:To:Cc:Subject:Date:From;
	b=DbYbZy+PQCM+T/3AbMvraNqeUnxZ/ABB+RNw60g0M4ruZQZ+Likp41nm1QUkQ2jUN
	 wfwXlnmhUvMlOQ5MRMA0qs65UIElBS4pPmOEIZNv0j3AkxGZqiJAIShdXYihfaFHYw
	 VFOtQoprVoE5NDUGdPsxMKADPv2SxNcK2TTgcI+Dv9i/mGCnojvrl2VflWnOmDKwI9
	 RkFFtGLFPEQuusXa/GGRN0MqnGsiY06/3gaZqb4uFBEPgxWykhdePMNSaKYnCylZBh
	 460PeNDzNjIrEzKEG076tVIxu8Hm6yJ8CIig35476kej8R1lwmtz1Ym69CRWJG4IUC
	 K5zEzCXV+aZGg==
From: Geliang Tang <geliang@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Matthieu Baerts <matttbe@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	bpf@vger.kernel.org,
	mptcp@lists.linux.dev,
	kernel test robot <lkp@intel.com>
Subject: [PATCH bpf-next v3 0/2] bpf, btf: Add DEBUG_INFO_BTF checks for __register_bpf_struct_ops
Date: Sun,  4 Feb 2024 14:58:11 +0800
Message-Id: <cover.1707029682.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

v3:
 - fix this build error:
kernel/bpf/btf.c:7750:11: error: incomplete definition of type 'struct module'

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202402040934.Fph0XeEo-lkp@intel.com/

v2:
 - add register_check_missing_btf helper as Jiri suggested.

Geliang Tang (2):
  bpf, btf: Add register_check_missing_btf helper
  bpf, btf: Check btf for register_bpf_struct_ops

 kernel/bpf/btf.c | 47 ++++++++++++++++++++++++++---------------------
 1 file changed, 26 insertions(+), 21 deletions(-)

-- 
2.40.1


