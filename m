Return-Path: <bpf+bounces-44457-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECC0E9C31CC
	for <lists+bpf@lfdr.de>; Sun, 10 Nov 2024 12:37:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DF661C20985
	for <lists+bpf@lfdr.de>; Sun, 10 Nov 2024 11:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5D98155CA5;
	Sun, 10 Nov 2024 11:37:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mx.der-flo.net (mx.der-flo.net [193.160.39.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A1661494B5
	for <bpf@vger.kernel.org>; Sun, 10 Nov 2024 11:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.160.39.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731238648; cv=none; b=tJQ5DHRldyBK+VNFibpOYxMYLWRZ7PEe35kcWtFGxiilq1bQyaUnp7ZCXJoIYWnZd7g7qFGKS/bDfRff2qHJc2+ZawmF1Qa0/wbhsDQYZ8VuewvWzquK6koQXAQpvwzmiaoqHX42ZtXXcjbM4lK/MwfbkOXZl/BDdvFJHb2Vcuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731238648; c=relaxed/simple;
	bh=MT/hBeHLsTrtOnKS4H86XC/AHRqj02GqG07HL+46VNM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q3C9ugtzy4F4sBnnRRWVfwHNIVm0+xU9MeEmdtoB1zoxcfkm/wHfvH60JFRjTAdWX9S5XRVErAqqIAdfdO/o9wOA+2gyRJ2UOtuFX7m40rElhdg8Zab5ZzBdxKSi8eZJX7NHNQwDsMPj6A6+HYzteypc/d9eYJA7W++2Xs2prnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=der-flo.net; spf=pass smtp.mailfrom=der-flo.net; arc=none smtp.client-ip=193.160.39.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=der-flo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=der-flo.net
From: Florian Lehner <dev@der-flo.net>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	aspsk@isovalent.com,
	kees@kernel.org,
	quic_abchauha@quicinc.com,
	martin.kelly@crowdstrike.com,
	mykolal@fb.com,
	shuah@kernel.org,
	yikai.lin@vivo.com,
	Florian Lehner <dev@der-flo.net>
Subject: [bpf-next 0/2] bpf: Add flag for batch operation
Date: Sun, 10 Nov 2024 12:29:02 +0100
Message-ID: <20241110112905.64616-1-dev@der-flo.net>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce a new flag for batch operations that allows the deletion process
to continue even if certain keys are missing. This simplifies map flushing
by eliminating the requirement to maintain a separate list of keys and
makes sure maps can be flushed with a single batch delete operation.

Florian Lehner (2):
  bpf: Add flag to continue batch operation
  selftests/bpf: Add a test for batch operation flag

 include/uapi/linux/bpf.h                      |  5 +++++
 kernel/bpf/syscall.c                          | 14 ++++++++++---
 tools/include/uapi/linux/bpf.h                |  5 +++++
 .../bpf/map_tests/htab_map_batch_ops.c        | 20 ++++++++++++++++++-
 4 files changed, 40 insertions(+), 4 deletions(-)

-- 
2.47.0


