Return-Path: <bpf+bounces-26694-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D9428A3A0D
	for <lists+bpf@lfdr.de>; Sat, 13 Apr 2024 03:15:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86233283369
	for <lists+bpf@lfdr.de>; Sat, 13 Apr 2024 01:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58BA64C7D;
	Sat, 13 Apr 2024 01:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iW+V1yBv"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3AEF4A33
	for <bpf@vger.kernel.org>; Sat, 13 Apr 2024 01:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712970908; cv=none; b=dWtKNxqBi4TGWpwgPGysd/2ioh/yXpVh8YbTe6Mg85ebcF+ukfIEumoREF4V0sr97j42/uXm3H5LsJT3y3h7PvoungIV3R6yEGLQjpkO9a1Pzq0/2nuCftzOENmD+L7vJoPTQpNqUm9CYTSyOfQXiREn4HjwmAvFlUTiXsBXWTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712970908; c=relaxed/simple;
	bh=7yZ9XQDXBbnI4e9LNiS4e0qSyrDDSjjVLBvdv5a1e3g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QW/RPva4oO5m15ay1dWOiEBqujUHmIp+pRpWSRs3gt0J70Y9c44t6dLeF3MG2ZFWAx5dtUU4h5kSwjIALHTayUrybSy9AQy7CWyL+GAKDGHwkyKK0HyGg+x/ka5fq46tmp0fv43SJDd7tgI65ep2C8vJlZ47opOkQnuA9ClkaIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iW+V1yBv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C2EEC113CC;
	Sat, 13 Apr 2024 01:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712970908;
	bh=7yZ9XQDXBbnI4e9LNiS4e0qSyrDDSjjVLBvdv5a1e3g=;
	h=From:To:Cc:Subject:Date:From;
	b=iW+V1yBvMQjj939Vpr+1IgFbIw0I8gF2lfuyHHvZ6AQrVENYf2/jZINBMGt3x2DG7
	 k+01L7bAwWltmqtEQwgz52cwOH/J4SF9l6n7FyFDlFC92RbsLXiMWAgfkAv30voXnB
	 GbuP6wzLjJMQdFa8OOOzHQddzOdKN9uoQRUV9M7Jwpt3K+7SBhRmHMbHoZxHKFkhfB
	 iA7Uwrv1NvkWmgyMGFmukFTQesQqJZzypf1Omsdlx2Fd0aQjlrnh9sflRNmkpBdwS2
	 esf+BKOXXM2ig91brG8U67lGoo+NqtHm0bbGHgOmgwwEMNMROXdHMGqdrFTKT/R3Id
	 VWPSrP4BDnscw==
From: Quentin Monnet <qmo@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org,
	Quentin Monnet <qmo@kernel.org>
Subject: [PATCH bpf-next 0/2] bpftool: Small fixes for documentation and bash completion
Date: Sat, 13 Apr 2024 02:14:25 +0100
Message-Id: <20240413011427.14402-1-qmo@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This small series contains two sets of fixes/clean-ups for bpftool's
documentation and bash completion, respectively.

Quentin Monnet (2):
  bpftool: Update documentation where progs/maps can be passed by name
  bpftool: Address minor issues in bash completion

 .../bpf/bpftool/Documentation/bpftool-btf.rst |  2 +-
 .../bpftool/Documentation/bpftool-cgroup.rst  |  2 +-
 .../bpf/bpftool/Documentation/bpftool-net.rst |  2 +-
 .../bpftool/Documentation/bpftool-prog.rst    |  2 +-
 tools/bpf/bpftool/bash-completion/bpftool     | 61 ++++++++-----------
 5 files changed, 29 insertions(+), 40 deletions(-)

-- 
2.34.1


