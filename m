Return-Path: <bpf+bounces-74294-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DC2BC52B0D
	for <lists+bpf@lfdr.de>; Wed, 12 Nov 2025 15:24:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83C023BE80C
	for <lists+bpf@lfdr.de>; Wed, 12 Nov 2025 14:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6874F277029;
	Wed, 12 Nov 2025 14:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fuw2lKM6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 517DD26A0D5
	for <bpf@vger.kernel.org>; Wed, 12 Nov 2025 14:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762956734; cv=none; b=E1kDsfNirDjCJBK48dFzEmbsGLunXahSRQMNKwqvuT9SMiZw/4U9dLvNQ2DdeJkP4z+PP++oVbNgYXalMFz+OO14BxVqq9R51UEg/OHKk1YtTqRSBtrtUkq4cLMHds8ERYZWwnmPKIUBM8ppOI4XRl6qlrcvADKQl7yAZzc5iTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762956734; c=relaxed/simple;
	bh=4gTu62Cbo/85Ca8gee18I0As80cWfB9FOIdzXKqVpRM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oIUaNc40meKomNwCl54hEVOfb7vJ4ONo6T+eyMBqFAczcHDHJOM5WVPy/3HxfjKwYJNXtGFcbmgNf+5v3S1C8pTF0+voOYhX3QCbkW7x64q6rewoa0nSmACEoFCI5HTpYVVX5p2mrjE8kUn4Z43wlaenUxZ7Iu+N657embdsSOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fuw2lKM6; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-477442b1de0so6304135e9.1
        for <bpf@vger.kernel.org>; Wed, 12 Nov 2025 06:12:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762956730; x=1763561530; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tI75hDbouZIETMFT8ke2RFFEcLU/TsScHe/NrPN9qMM=;
        b=Fuw2lKM6RluMC7ekY+j1yNwqIqsZ2np8giOXCRNC1d2NfUzW2ugs6MbFO1S8uCWJ7z
         hMDPbA/Z1dF+Sgj0IljblfCfZDqQjPTggO4WT6NM2PSUkDuOYAht81B0D33tQPCj+kRk
         Mnn2ZxMHy6s+OwaX61dpg2pznymwtXng6lec74U87QAElled5xvlz3K7uC7k59qKqB1s
         nOqf1CxX1s4GkSv8JaSlR2hRQk5yjVWtPelorQKA0dl/QXCqs94bI7Fj6tEdYHO6IZs8
         3sSitYR9V2lAmxWWa2qlBGcRN2TmIxxr6/tMbDIo6CUnnEpDtQUoDYoHaazz+sNDcvpv
         5eBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762956730; x=1763561530;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tI75hDbouZIETMFT8ke2RFFEcLU/TsScHe/NrPN9qMM=;
        b=Nj3wRR51n72U11AjJl0u5MXW2LtA/LpXQVemkGk1xwuazmH5tYJWG1NW0tifsG0jD9
         5UvMkQvECl/03oFM0OE/pMcUtuwSJaejjy6g+ob4H7rqfwQj8fjasroGoZyET+bxuUxV
         dLPcR5YKCdPCCmtFRYw+DFJEkebHEoNniBzE0Gp3mTnYLcqIW5dT1ViwuABVU71Lvufh
         nBqAT0hAbeNvUQm58DbqQmxjwFRVBiCx6gt8TMHAVPkUmTDnpJ0WKfWOaWJB76t+kMEQ
         IhnuPDKTW+fN4u5J1THgwMOIf2v1amwq60nBNdc7fawH/wnLK4E9kaCISrNE5M6x2XRE
         Wv4A==
X-Forwarded-Encrypted: i=1; AJvYcCUbK6TnvdXRfCzSnH6U6h/BON5L5JVMNWlqwF3ZSGtCeA7ya3EGy94ihLn+jRdTFrgrtGQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEzTjawD2ebHfvbmGOgmViliatLie3BfPZldHCHdG0KniGBXLG
	EtDdN7eixPhztBS93EPFQZQYI3zONLJwtTCjxUlZn3cRh7K/eZ/XmUuY
X-Gm-Gg: ASbGncubCrc5lBmsB1Ywf2tVLFYYk36t+B9eRGIZayKF5tCwBeoRUIes+0J1qVFEzmQ
	OeF+xMyx5vuIyRFEXFALNDr02VyxOv6JvPDGKIICTPIw0o8gvwdcDa0AolIxHp5xijg7bfK4NM3
	T7NpefpsrDhcvdG2Diw/dRJEZcQS5d4VORfvcxeMGxLz7sM8N3hX+dIRSR1MpkiiEFYk/6qKIUa
	nYhD2NCqO80Tw61ZgNN7RsA0etb1rFd9yZXae3XOknQGIQtx9LKTK8Uw//hNSkM/KVv4m9nc6TY
	ZnQMajO4znortOdo8ho4I8U1Ajy9Nw9OgAtTUKgQf+ynNS1zPfPnm/LHpOhmG+mQot2Uvpo3AK7
	pv1UWMrX3HgJzd2J6b63aMXrOGciuIDIU+zxkJAMU88JeEBVUwAkV2v/8TzDtnyt/kwNetSgh4d
	3vXEBseAJYYNZI
X-Google-Smtp-Source: AGHT+IGyXbTaO+xgr/SsYmGbnGDHZeIma9mt9kzGgq8EkGWGngWs1vXcu5nKfKxkP0snMbzheV5Niw==
X-Received: by 2002:a05:600c:3511:b0:477:54cd:2021 with SMTP id 5b1f17b1804b1-47787041346mr31763365e9.8.1762956730247;
        Wed, 12 Nov 2025 06:12:10 -0800 (PST)
Received: from paul-Precision-5770 ([80.12.41.68])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b2b08a91esm28303603f8f.2.2025.11.12.06.12.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 06:12:09 -0800 (PST)
From: Paul Houssel <paulhoussel2@gmail.com>
X-Google-Original-From: Paul Houssel <paul.houssel@orange.com>
To: Paul Houssel <paulhoussel2@gmail.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Martin Horth <martin.horth@telecom-sudparis.eu>,
	Ouail Derghal <ouail.derghal@imt-atlantique.fr>,
	Guilhem Jazeron <guilhem.jazeron@inria.fr>,
	Ludovic Paillat <ludovic.paillat@inria.fr>,
	Robin Theveniaut <robin.theveniaut@irit.fr>,
	Tristan d'Audibert <tristan.daudibert@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Paul Houssel <paul.houssel@orange.com>
Subject: [PATCH v2 0/2] libbpf: fix BTF dedup to support recursive typedef
Date: Wed, 12 Nov 2025 15:11:32 +0100
Message-ID: <cover.1762956564.git.paul.houssel@orange.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Pahole fails to encode BTF for some Go projects (e.g. Kubernetes and
Podman) due to recursive type definitions that create reference loops
not representable in C. These recursive typedefs trigger a failure in
the BTF deduplication algorithm.

This patch extends btf_dedup_struct_types() to properly handle potential
recursion for BTF_KIND_TYPEDEF, similar to how recursion is already
handled for BTF_KIND_STRUCT. This allows pahole to successfully
generate BTF for Go binaries using recursive types without impacting
existing C-based workflows.

Changes in v2:
  1. Patch 1: Refactored code to prevent copying existing logic. Instead of
  adding a new function () we modify the existing btf_dedup_struct_type()
  function to handle the BTF_KIND_TYPEDEF case. Calls to btf_hash_struct()
  and btf_shallow_equal_struct() are replaced with calls to functions that
  select btf_hash_struct() / btf_hash_typedef() based on the type.
  2. Patch 2: Added tests

v1: https://lore.kernel.org/lkml/20251107153408.159342-1-paulhoussel2@gmail.com/

Paul Houssel (2):
  libbpf: fix BTF dedup to support recursive typedef definitions
  selftests/bpf: add BTF dedup tests for recursive typedef definitions

 tools/lib/bpf/btf.c                          | 59 +++++++++++++++----
 tools/testing/selftests/bpf/prog_tests/btf.c | 61 ++++++++++++++++++++
 2 files changed, 110 insertions(+), 10 deletions(-)

-- 
2.51.0


