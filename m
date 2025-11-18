Return-Path: <bpf+bounces-74828-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FB47C66C1F
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 01:58:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BCC683528A3
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 00:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 134CF2FD663;
	Tue, 18 Nov 2025 00:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="SZ62LKPT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133C42737F8
	for <bpf@vger.kernel.org>; Tue, 18 Nov 2025 00:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763427195; cv=none; b=ktVAR75wdkhMrZSLM47yn+PPza25aGtTZRz+CpS5ptzw57fzc97rBH1uftUfDxCyYY2xhrAbtivI25nV0aD1TyEE5VVek66fxbJjTCkdw0QyhurYKqiuPEVH92Iu9bDtb3FoI7YC6lbPQ2sDSuM/YvBGMQnTliduEXsyTdXsijs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763427195; c=relaxed/simple;
	bh=pfVZo5pq81wNsPJgUa90qDINb3FW9xgTlXqCyicI4LE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ECiLmAl0+10JHnxDqfau3EWrw4th155ARqwV3RPVbHK0ykAnu0qFqxQf0N31nq+WowOSeDhPtOnp4BIDOKh1ub1BooMLWklYQ4EcKEmzUHBCx2l4ZjbLZ0TuhK42TEmFB+jGt9OUEwZOQWcBiKbofy3cwnyZhnXlzIfXnNShEPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=SZ62LKPT; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-299e43c1adbso2068835ad.3
        for <bpf@vger.kernel.org>; Mon, 17 Nov 2025 16:53:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1763427192; x=1764031992; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ECcRFPnZSJ/74qLcUT1nDtXwbFmCLS0/Z+AkSmPgFFQ=;
        b=SZ62LKPTWjF6hTBBYSlyaox+K/WBPQXcYPxjjrjtA/949L02VfY5p8P9uDDxZXRlOz
         R1o5oVkGdqbqqK8Y0ZkO3B9hbvNl1LmXl3AsZA4jjz85zF0+Hq/JplC/Kzh3d1K7YwYT
         hjB6D8v46JaV5zmLdFat+rgySdm6PyqK0gCuhp8cRFXs9wwCqOi6S0x2x+Mtaxlfg+/a
         aMoCcjWjrA7apOCO//WGPWb+flSNVGC0lHXuaQETt8B8aNYhggtGNrImLe2NAD9AKoT3
         0qoGOvh1xNjSFPtaa+F7vuoPe3gJLtXw2mV3yri+1WJt5C8gKGf0aD4ylnkdtAgdPHGS
         xmPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763427192; x=1764031992;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ECcRFPnZSJ/74qLcUT1nDtXwbFmCLS0/Z+AkSmPgFFQ=;
        b=wgQclMVmsYY5sVrXPUIzNwaZ+QgEk3WyCMBOv2VEIZzslGzo2oo9WX7ImlAphvDsdv
         VF3w4hpPXFVAadl5qcHsCbw4ayfLhqEvP53MDOD8GAPFAqM4du0WIbztPTOXhZVUTOse
         hUACeSNf1M/Vqm/6Pv+5rf3LVczgQIf3l0UKrqZds/zpO+WbF0O1rSDgL5I/lbwT0pBz
         M867XduEK+yc24oObRmqHir7JBY/l11f/xAHLPkimGpsHPFE6sXglck/fLJt8huxCFQ3
         xqZfNxNEx28iMapiVEl7fkJxNIYOldFPNrIWvIdse4OcgLOS55YbCa3h7pz+YbM/mVg8
         YIMg==
X-Gm-Message-State: AOJu0YyE8TVyQd1xnbdCerP+IkY0ZpDRktaYuQkaiSXB4CbKtcTPIXIz
	MxbMyTkv0wldSurb5PIRAjnS4PIr1AOXQ+h0anOEed5JGRy54WcJnQfTeeGzauZwKCJLZOizUz9
	lgK/4
X-Gm-Gg: ASbGncsKTrXANlfAtXi4JxjSx4h6j2gemmnQSONjUOrWJ3Px1N0sv85w3mzVOlJHGWP
	pR+bPz5Kq9o5R415DTJM2SHJ6sZSjXxfXlrERBnsHkFaU8Gf1G9kQpBib6Vek9A6iH2rlJ0jSfr
	leZ3cvIsKmnIWDJ7IVaAzGvCOlXHtEXw96E3ncMN1/sRfcbjr4xlTVFMyBoYNq8k58my+Hpt6zv
	cRn4iX8zBkF2GcbC2kJKFsbX1LRk12Cy0NTBH/fXD1lWjX1on+evwsl9qFrayXm0im5gAsud6DZ
	NTfXtKZ3JGLhxLgblM2hHuXdaHdt4gmITwO6+KRYI8rrf7UxjUUT5s9fc+mcT1OfALnHbEdJdoz
	+Il4TCPND3/yuB7r4Z0dfq2xUcWoLLS3NJYPNNA7dDh5Qzp7/gXxXYcHHn+7qPNbm
X-Google-Smtp-Source: AGHT+IEjPzaJypGOyu7ighv5aVAvafyjybl9abS/IeF+SU6SIlOj40X9SRbCB6CrI/miT/nJFjWaxw==
X-Received: by 2002:a05:7300:fb05:b0:2a4:3593:5fc8 with SMTP id 5a478bee46e88-2a4abb56fe7mr4474649eec.2.1763427191866;
        Mon, 17 Nov 2025 16:53:11 -0800 (PST)
Received: from t14.. ([2001:5a8:47ec:d700:ef59:f68f:7ffe:54f2])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2a49d9ead79sm67568555eec.1.2025.11.17.16.53.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 16:53:11 -0800 (PST)
From: Jordan Rife <jordan@jrife.io>
To: bpf@vger.kernel.org
Cc: Jordan Rife <jordan@jrife.io>,
	linux-arm-kernel@lists.infradead.org,
	linux-s390@vger.kernel.org,
	x86@kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Puranjay Mohan <puranjay@kernel.org>,
	Ilya Leoshkevich <iii@linux.ibm.com>,
	Ingo Molnar <mingo@redhat.com>
Subject: [RFC PATCH bpf-next 0/7] bpf: Implement BPF_LINK_UPDATE for tracing links
Date: Mon, 17 Nov 2025 16:52:52 -0800
Message-ID: <20251118005305.27058-1-jordan@jrife.io>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement update_prog for bpf_tracing_link_lops to enable
BPF_LINK_UPDATE for fentry, fexit, fmod_ret, freplace, etc. links.

My initial motivation for this was to enable a use case where one
process creates and owns links pointing to "hooks" within a tc, xdp, ...
attachment and an external "plugin" loads freplace programs and updates
links to these hooks. Aside from that though, it seemed like it could
be useful to be able to atomically swap out the program associated with
an freplace/fentry/fexit/fmod_ret link more generally.

Implementing program updates for freplace links was fairly
straightforward but proved more difficult for the other link types. The
third patch in this series discusses some other approaches I considered
before settling on the current approach, but I'd appreciate others'
input here to see if there is a better way to implement this that
doesn't require architecture-specific changes.

Thanks!

Jordan

Jordan Rife (7):
  bpf: Set up update_prog scaffolding for bpf_tracing_link_lops
  bpf: Enable BPF_LINK_UPDATE for freplace links
  bpf: Enable BPF_LINK_UPDATE for fentry/fexit/fmod_ret links
  bpf, x86: Make program update work for trampoline ops
  bpf, s390: Make program update work for trampoline ops
  bpf, arm64: Make program update work for trampoline ops
  selftests/bpf: Test BPF_LINK_UPDATE behavior for tracing links

 arch/arm64/net/bpf_jit_comp.c                 |  23 +-
 arch/s390/net/bpf_jit_comp.c                  |  24 +-
 arch/x86/net/bpf_jit_comp.c                   |  17 +-
 include/linux/bpf.h                           |  21 +
 kernel/bpf/syscall.c                          |  68 +++
 kernel/bpf/trampoline.c                       |  75 ++-
 .../bpf/prog_tests/prog_update_tracing.c      | 460 ++++++++++++++++++
 .../selftests/bpf/progs/prog_update_tracing.c | 133 +++++
 8 files changed, 796 insertions(+), 25 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/prog_update_tracing.c
 create mode 100644 tools/testing/selftests/bpf/progs/prog_update_tracing.c

-- 
2.43.0


