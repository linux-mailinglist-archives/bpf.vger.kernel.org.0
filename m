Return-Path: <bpf+bounces-28420-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 931D78B93D6
	for <lists+bpf@lfdr.de>; Thu,  2 May 2024 06:23:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DA1A1C21520
	for <lists+bpf@lfdr.de>; Thu,  2 May 2024 04:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D0371BF47;
	Thu,  2 May 2024 04:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="RaHOUhGC"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62699171AA
	for <bpf@vger.kernel.org>; Thu,  2 May 2024 04:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714623829; cv=none; b=f4JSo6lzxFs8aZ1ns6XyxareaucbBkRZHuqE58grEiF4LEZ6qoC8Ss7v2L0Dc+XiUFtudOkuvW13cx9fstlY5lewuSRq9geqPII0FsnvQXt/LMy5i7H1W8MT1gc6u9kLFBBJc/oItQyDRGzz5X2K2GbAbGwVOGIcJrrlX84aRuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714623829; c=relaxed/simple;
	bh=9loqrPzqZAxVOaUc4oopSnUKFBSd2uYPXYpzR5q9FAU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EEIP3CPzG5UNJIAD0jPgchQ+IG65vIgxB+VNIVBDFU1SmEHVbwWcCSrRBvA6/URv7K4SXXd+nQAF8VMSVbUuOvBvC95OnUr9N9vmJWGHIeDd7Sc5B/s4WpN4sUYyVTXXpZ/tzooki+70aEcjfGpuKkDHVDOGmH1dkzsE7N+8qGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=RaHOUhGC; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 441Mjqpm010650
	for <bpf@vger.kernel.org>; Wed, 1 May 2024 21:23:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=s2048-2021-q4;
 bh=TO1PSaKRd633vyRFurgOUtsTs/4pfrreyOBxMprrjDI=;
 b=RaHOUhGCOTO8nhlHvVCSpuaHMR5lCZLS4e+R/PZeKQ4I1ZN+gUov+ya/75UAXUArk/NS
 EaxiAWRKzD/7+g+SlTF+y0BSZfTx0TEuZVMmhyQb/MMW1M56JoLDi8o2ZEkvzM7edDIT
 3tteickO2quAFXRaFBuP/OnzrD1nOGy7Wmp0FyYBYK5ttG+/N9e/BoBtcdPS5PgKWtPq
 sDEenRUJ/i7qROB47WQIfPGD577rzdkPz2kSuzXcTmALh/tF9Ur5CF8b5QoPusG26KLH
 2ZmfuYWkOktnzYsivXOIp8AGiSIfI7hL3WATUReMTIWcMVeKO+BQ2sc9WTki1i5laUoj 7g== 
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3xuxtmhhjt-6
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Wed, 01 May 2024 21:23:47 -0700
Received: from twshared53332.38.frc1.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:11d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 2 May 2024 04:23:45 +0000
Received: by devvm15954.vll0.facebook.com (Postfix, from userid 420730)
	id 53D20CB261CF; Wed,  1 May 2024 21:23:30 -0700 (PDT)
From: Miao Xu <miaxu@meta.com>
To: Eric Dumazet <edumazet@google.com>,
        "David S . Miller"
	<davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>,
        David Ahern <dsahern@kernel.org>, Martin Lau
	<kafai@meta.com>
CC: <netdev@vger.kernel.org>, <bpf@vger.kernel.org>, Miao Xu <miaxu@meta.com>
Subject: [PATCH net-next v3 0/3] Add new args into tcp_congestion_ops' cong_control
Date: Wed, 1 May 2024 21:23:15 -0700
Message-ID: <20240502042318.801932-1-miaxu@meta.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: ux_bGmHcqVRZn4_T7hQ-RmqVkrg7dhzW
X-Proofpoint-GUID: ux_bGmHcqVRZn4_T7hQ-RmqVkrg7dhzW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-01_16,2024-04-30_01,2023-05-22_02

This patchset attempts to add two new arguments into the hookpoint
cong_control in tcp_congestion_ops. The new arguments are inherited
from the caller tcp_cong_control and can be used by any bpf cc prog
that implements its own logic inside this hookpoint.

Please review. Thanks a lot!

Changelog
=3D=3D=3D=3D=3D
v2->v3:
  - Fixed the broken selftest caused by the new arguments.
  - Renamed the selftest file name and bpf prog name.

v1->v2:
  - Split the patchset into 3 separate patches.
  - Added highlights in the selftest prog.
  - Removed the dependency on bpf_tcp_helpers.h.

Miao Xu (3):
  tcp: Add new args for cong_control in tcp_congestion_ops
  bpf: tcp: Allow to write tp->snd_cwnd_stamp in bpf_tcp_ca
  selftests/bpf: Add test for the use of new args in cong_control

 include/net/tcp.h                             |   2 +-
 net/ipv4/bpf_tcp_ca.c                         |   6 +-
 net/ipv4/tcp_bbr.c                            |   2 +-
 net/ipv4/tcp_input.c                          |   2 +-
 .../selftests/bpf/progs/bpf_cc_cubic.c        | 206 ++++++++++++++++++
 .../selftests/bpf/progs/bpf_tracing_net.h     |  10 +
 .../selftests/bpf/progs/tcp_ca_kfunc.c        |   6 +-
 7 files changed, 227 insertions(+), 7 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_cc_cubic.c

--=20
2.43.0


