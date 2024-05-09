Return-Path: <bpf+bounces-29174-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB6AD8C107E
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 15:41:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18A551C2150D
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 13:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A4F9157A41;
	Thu,  9 May 2024 13:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="eEVcmX8d"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7A113174D
	for <bpf@vger.kernel.org>; Thu,  9 May 2024 13:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715262054; cv=none; b=WfM3ZV0K1OtHAs3FsAFRXp2QQZTw0EB51y0sc+wYAqQ+i2hqaltKEtuYCFSrX4wz7DBeBBEdkNCFmEDnronTTmzpLpI74/azE+Ypnx13aiEdc+ilPilkr8an1PJ5GA8jZE+lsV/nQWUHu+hEUHqFEwuJkKXWdOJk64JoMDQZyFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715262054; c=relaxed/simple;
	bh=BJFhS4IvdePLydz0QfwnqA3hkkpTdlf8ICG6XGFKVP8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=a3fFryKKHiqdZrffUr2rVyhMqHLaGRkNuYNTjhFnHa2Lf43QqUTFERBdwUwOJ2tLusj9/3mARCIF9V4LZ/nfKzLC5nOWfNbL7TO1SgGgbHhtweWXjzlWKgYKeN3duPy52YCPgA+DNI1PiPdl1YhOX4jcWtbjvWsbC40FPcx4ves=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=eEVcmX8d; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 449DOpC4001589;
	Thu, 9 May 2024 06:40:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=s2048-2021-q4;
 bh=0BSf0uFfcplFKIhAANFJlGFa6FKnwUPyZPWdUFR6H+s=;
 b=eEVcmX8d+YiigRlm73SjOjuFKp0/qvNI01myv4OJ+Wm4Bt/gsMzRPQ1oxwvpabO2lFHd
 F754bu5l6VjYHtxw10kOufAhOhQlg2AVFRX1E31kwYpPNOzIrp+vdvhH8nW8fe5N/H1L
 ecVQSzdhs8HxhYBpgKvdn+SKViN12RdZxlCEoTNLSQwwjvvzysqv8RtWdSxjs9w4CzOy
 +aaYlgJX/H4TPbe64/Vq81N5eFFXgxRQg69KnHy1qh9Hx0DlUr7sY/X8ZXQH+To6Rpiu
 8l42Z/JsoYrXcgnEltaIP672+OYH3Aor9m5MFbgENnmcWydoRN0YYVQGA8J711mq2uVY FA== 
Received: from maileast.thefacebook.com ([163.114.130.16])
	by m0001303.ppops.net (PPS) with ESMTPS id 3y0e7umtpu-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 09 May 2024 06:40:39 -0700
Received: from devvm4158.cln0.facebook.com (2620:10d:c0a8:1b::8e35) by
 mail.thefacebook.com (2620:10d:c0a8:83::8) with Microsoft SMTP Server id
 15.1.2507.35; Thu, 9 May 2024 13:40:34 +0000
From: Vadim Fedorenko <vadfed@meta.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
        Martin KaFai Lau
	<martin.lau@linux.dev>,
        Andrii Nakryiko <andrii@kernel.org>,
        "Alexei
 Starovoitov" <ast@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>, Jakub
 Kicinski <kuba@kernel.org>
CC: Vadim Fedorenko <vadfed@meta.com>, <bpf@vger.kernel.org>
Subject: [PATCH bpf-next 0/4] bpf: make trusted args nullable
Date: Thu, 9 May 2024 06:40:19 -0700
Message-ID: <20240509134023.1289303-1-vadfed@meta.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 2HzhmNHnHY3rQIYIop8iUxjotNjH3LGd
X-Proofpoint-ORIG-GUID: 2HzhmNHnHY3rQIYIop8iUxjotNjH3LGd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-09_06,2024-05-09_01,2023-05-22_02

Current verifier checks for the arg to be nullable after checking for
certain pointer types. It prevents programs to pass NULL to kfunc args
even if they are marked as nullable. This patchset adjusts verifier and
changes bpf crypto kfuncs to allow null for IV parameter which is
optional for some ciphers. Benchmark shows ~4% improvements when there
is no need to initialise 0-sized dynptr.

Vadim Fedorenko (4):
  bpf: verifier: make kfuncs args nullalble
  bpf: crypto: make state and IV dynptr nullable
  selftests: bpf: crypto: use NULL instead of 0-sized dynptr
  selftests: bpf: crypto: adjust bench to use nullable IV

 kernel/bpf/crypto.c                              | 10 +++++-----
 kernel/bpf/verifier.c                            |  6 +++---
 tools/testing/selftests/bpf/progs/crypto_bench.c | 10 ++++------
 .../testing/selftests/bpf/progs/crypto_sanity.c  | 16 ++++------------
 4 files changed, 16 insertions(+), 26 deletions(-)

-- 
2.43.0


