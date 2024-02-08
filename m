Return-Path: <bpf+bounces-21474-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92A0F84DA05
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 07:24:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24B281F22E3C
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 06:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CDEE67C7E;
	Thu,  8 Feb 2024 06:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EpyvYrgJ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1320E63410;
	Thu,  8 Feb 2024 06:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707373477; cv=none; b=GHx8FRO5OQWiqwnMES/S/sbBq2//X9GYhpFaH3JK3yRqEWyjVVOwPGjxFWs/brc9ZCXxprJwxy0uuJkVX/wJDUxjmEFDdAq7JL6alAGkGdxiJH81hvElSY+sYTdHiv9HR3kYhbyD3DsjcoumKLk1ehhuHWTnvuzDrMfk+uQ5I9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707373477; c=relaxed/simple;
	bh=1gRee1fTWbTgSN2Dc7h9oxWcKfQYqM7+XvY08sPiR+U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZI+ZXfeSvzw5Pjr8u/ywN7uKpsc/PV5Ek+9k23UE6eaQEUWLEWo2nSUKfHwy817x3tpMI9kecnvwckBT5ORE5T+1LhvfySwSawwQHDJVQVPD/KG4y8ZbRYx7iQ/xgZtKW8MH/zzUI/1FIlyN9qMdN0urfbfxQZ61QDiyxaO+8WE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EpyvYrgJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8B6CC433F1;
	Thu,  8 Feb 2024 06:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707373476;
	bh=1gRee1fTWbTgSN2Dc7h9oxWcKfQYqM7+XvY08sPiR+U=;
	h=From:To:Cc:Subject:Date:From;
	b=EpyvYrgJCeVLYTgS1f1hbP4lbjuNrog8nx6jbrzzPMU0+ZkPz0NsWhQ/Z6raNc9cx
	 zXhvErJ3SefBlRq7hUG7YhcBQTJOxXXbxpvRYQXEVarWlDJ11orWxG6Z0k0NNR0Bzd
	 1uMlVtc2EuETr9TZ6g4CYH7Pkbj/fJD+q3xi+deHgvZF3c+L+IhtKofzEZhpLBSlHf
	 Y4DNqHDYvw05+Vr7UejGlJi0OwST9oFND5RydWtOG7gWorpO4cN1gCiqKJQGIjZziU
	 d7hDGJzo2/6JnYmQRZDP7uwiQowL5bXlbZYRo4U4b33KGbzLXzmYht/UWx0COobbOd
	 Sqc6Wqs4ygnKA==
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
Subject: [PATCH bpf-next v5 0/3] bpf, btf: Add DEBUG_INFO_BTF checks for __register_bpf_struct_ops
Date: Thu,  8 Feb 2024 14:24:20 +0800
Message-Id: <cover.1707373307.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

v5:
 - drop CONFIG_MODULE_ALLOW_BTF_MISMATCH check as Martin suggested.

v4:
 - add a new patch to fix error checks for btf_get_module_btf.
 - rename the helper to check_btf_kconfigs.

v3:
 - fix this build error:
kernel/bpf/btf.c:7750:11: error: incomplete definition of type 'struct module'

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202402040934.Fph0XeEo-lkp@intel.com/

v2:
 - add register_check_missing_btf helper as Jiri suggested.

Geliang Tang (3):
  bpf, btf: Fix return value of register_btf_id_dtor_kfuncs
  bpf, btf: Add check_btf_kconfigs helper
  bpf, btf: Check btf for register_bpf_struct_ops

 kernel/bpf/btf.c | 39 ++++++++++++++++++---------------------
 1 file changed, 18 insertions(+), 21 deletions(-)

-- 
2.40.1


