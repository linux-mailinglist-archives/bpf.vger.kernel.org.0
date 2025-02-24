Return-Path: <bpf+bounces-52388-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46D3DA428FF
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2025 18:10:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A5CC17EAAF
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2025 17:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEE86266569;
	Mon, 24 Feb 2025 16:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oTSPNlY5"
X-Original-To: bpf@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D7E262D37
	for <bpf@vger.kernel.org>; Mon, 24 Feb 2025 16:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740416382; cv=none; b=E6MA5GZc2aOOCEF4WvIfUYiAE5sVwWt8IwwtBvrfXFNiXjbHOwbSUpQBqwUP6+o2+jenI2BBIoo5WJYxQ8cEk2kX4R3pZbkPD0P1x2e+XmGGE+2YcLKhqM6d1fqBFTHvhiWUV9UdA+0JTn9uxX/iq/PxN7KENqzmOsIqXwqPwes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740416382; c=relaxed/simple;
	bh=QFtYzMCtAYvcjsT5gslas8Q1j/fnKz+V951oSzETkRw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UxQKwyNfxOduhLhxtBsyHzeTopUw9kGzCnJyNn1Dwedx95+uSupedCYKfCarbAFBOSsL1e5B6Ioqj/MhZdBS1HRLr1dyoCT6kA06ZHlI3cQsjMXkbzyjDNcbpWe6ya+WdY0efpSLzwDAa4Oma3wSLQPH9SP569gH/AbDv1H9ilM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=oTSPNlY5; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740416377;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Pgnmm2PNiYrAIIAl+3GQWPSNpgnW+rz9YHyx1c8UIUs=;
	b=oTSPNlY543OZWNcJuWtYK79ariWYF+R34FXKcOL5a5NHo3dO2k+lLeY+agqIuue0UBmuFe
	3l69Ybp5dZ8bgM2HdOuVw/Q1ob7FQ+j7i+hazjttl1Ku+u9w4/v8D3S/aJG9yeLgoYRBlH
	F5IaDKyk+mOUByyuByk4wo13PM/vtx4=
From: Tao Chen <chen.dylane@linux.dev>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	haoluo@google.com,
	jolsa@kernel.org,
	qmo@kernel.org
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	chen.dylane@gmail.com,
	Tao Chen <chen.dylane@linux.dev>
Subject: [PATCH bpf-next v8 0/5] Add prog_kfunc feature probe
Date: Tue, 25 Feb 2025 00:59:07 +0800
Message-Id: <20250224165912.599068-1-chen.dylane@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

More and more kfunc functions are being added to the kernel.
Different prog types have different restrictions when using kfunc.
Therefore, prog_kfunc probe is added to check whether it is supported,
and the use of this api will be added to bpftool later.

Change list:
- v7 -> v8:
  - fix "kfuncs require device-bound" verifier info
  - init expected_attach_type for kprobe prog type
  - patchset Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>
- v7
  https://lore.kernel.org/bpf/20250212153912.24116-1-chen.dylane@gmail.com/  

- v6 -> v7:
  - wrap err with libbpf_err
  - comments fix
  - handle btf_fd < 0 as vmlinux
  - patchset Reviewed-by: Jiri Olsa <jolsa@kernel.org>
- v6
  https://lore.kernel.org/bpf/20250211111859.6029-1-chen.dylane@gmail.com

- v5 -> v6:
  - remove fd_array_cnt
  - test case clean code
- v5
  https://lore.kernel.org/bpf/20250210055945.27192-1-chen.dylane@gmail.com

- v4 -> v5:
  - use fd_array on stack
  - declare the scope of use of btf_fd
- v4
  https://lore.kernel.org/bpf/20250206051557.27913-1-chen.dylane@gmail.com/

- v3 -> v4:
  - add fd_array init for kfunc in mod btf
  - add test case for kfunc in mod btf
  - refactor common part as prog load type check for
    libbpf_probe_bpf_{helper,kfunc}
- v3
  https://lore.kernel.org/bpf/20250124144411.13468-1-chen.dylane@gmail.com

- v2 -> v3:
  - rename parameter off with btf_fd
  - extract the common part for libbpf_probe_bpf_{helper,kfunc}
- v2
  https://lore.kernel.org/bpf/20250123170555.291896-1-chen.dylane@gmail.com

- v1 -> v2:
  - check unsupported prog type like probe_bpf_helper
  - add off parameter for module btf
  - check verifier info when kfunc id invalid
- v1
  https://lore.kernel.org/bpf/20250122171359.232791-1-chen.dylane@gmail.com

Tao Chen (5):
  libbpf: Extract prog load type check from libbpf_probe_bpf_helper
  libbpf: Init fd_array when prog probe load
  libbpf: Add libbpf_probe_bpf_kfunc API
  libbpf: Init kprobe prog expected_attach_type for kfunc probe
  selftests/bpf: Add libbpf_probe_bpf_kfunc API selftests

 tools/lib/bpf/libbpf.h                        |  19 ++-
 tools/lib/bpf/libbpf.map                      |   1 +
 tools/lib/bpf/libbpf_probes.c                 |  90 +++++++++++---
 .../selftests/bpf/prog_tests/libbpf_probes.c  | 111 ++++++++++++++++++
 4 files changed, 205 insertions(+), 16 deletions(-)

-- 
2.43.0


