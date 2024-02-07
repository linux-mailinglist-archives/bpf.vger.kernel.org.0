Return-Path: <bpf+bounces-21408-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF1F384CC57
	for <lists+bpf@lfdr.de>; Wed,  7 Feb 2024 15:08:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4254A285F90
	for <lists+bpf@lfdr.de>; Wed,  7 Feb 2024 14:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 060E67C092;
	Wed,  7 Feb 2024 14:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W31frQhh"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5AE7A73C;
	Wed,  7 Feb 2024 14:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707314891; cv=none; b=cvNI/QUejl3lzyn+TlvqawO39w/ZhudW/bWatSdvqemjYizj4mMaEN6QUN6FOslZDnA5WkuCk2VgDKh8aDnwcgWD2u+epcSH1FUR8Btqi0CFV2WFDmQuLVBtCrulu7xKY7WesTx0QvEzsoh4xvMgyhoIepKBfy+41TiuVAtGc80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707314891; c=relaxed/simple;
	bh=BFGqAPdxafkfBpmAuN1/gbsAktxUlX++Zwef2uI7qXo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oKfuMb5UJWGXsIxmj+Aoy1cDH5mY+XZgjsappmHTOf6ukvr4q+Sd4r5XlJxNJ5orn3URI+u+tAXz/wC1/Y4v/qcBAeEG2on0Jc6un8duWKfRd/iX/u1SCRkPscUjBhzbc++Ouj3PDEUzwFhu/uyPXF8gGPmt0pBmVpHenlXnS/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W31frQhh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F15D7C43394;
	Wed,  7 Feb 2024 14:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707314891;
	bh=BFGqAPdxafkfBpmAuN1/gbsAktxUlX++Zwef2uI7qXo=;
	h=From:To:Cc:Subject:Date:From;
	b=W31frQhhqq7/vCnNkIwtJKJ828o22ZH1M9yPxnJ9ihPwqzTpImspWyyktoXdKW1pY
	 q93SW1c/lOxP/KUvZJsSOh77fPLfVJqYwLRjSS2FjyGIXhy2va5PovHpw911PNIK6U
	 khwo9pEOPXEfB8x3vUMn980q+XreKDjkHbgKzY5UB7NUlf/c7Y6LetIgiBJMe53x8A
	 5tBeztqLHRBMqxrJFyKdoqK1MvpLR8wdjj9PzLZSbDxwlor3H9ZGSQuwY9ikZ6P1Ai
	 x2Xblg0ZGlLSfLeN2Glu9Lt8H3/D9DxXKveRacWiLJTgB36/v/Ft0NsqaHd93IvDu8
	 PB4IVVQ7uqSjQ==
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
Subject: [PATCH bpf-next v4 0/3] bpf, btf: Add DEBUG_INFO_BTF checks for __register_bpf_struct_ops
Date: Wed,  7 Feb 2024 22:07:53 +0800
Message-Id: <cover.1707314646.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

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
  bpf, btf: Fix error checks for btf_get_module_btf
  bpf, btf: Add check_btf_kconfigs helper
  bpf, btf: Check btf for register_bpf_struct_ops

 kernel/bpf/btf.c | 42 +++++++++++++++++++++---------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

-- 
2.40.1


