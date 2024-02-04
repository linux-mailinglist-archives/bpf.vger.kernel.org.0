Return-Path: <bpf+bounces-21161-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD4EE848FF4
	for <lists+bpf@lfdr.de>; Sun,  4 Feb 2024 19:41:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80D18283494
	for <lists+bpf@lfdr.de>; Sun,  4 Feb 2024 18:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D2FC24B21;
	Sun,  4 Feb 2024 18:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="lMub7fQ1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DnK33Bci"
X-Original-To: bpf@vger.kernel.org
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981DAF4FA
	for <bpf@vger.kernel.org>; Sun,  4 Feb 2024 18:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707072053; cv=none; b=HLrFys3jEJ2aJUyxYR2vaECNIWevTo3sgjRwzeduKY0N7ImCCXG6JKSdrUuRhuDT3mnCCeEBlApWGzgGK+iOIZJekv4Fec87eF0mJ0xj5xSc/JXVoH8MhoGW4s8uXeHy1cVmBatcGW0junSB5yytwyzQR+9I6/ql0mOImUO9vic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707072053; c=relaxed/simple;
	bh=0e6Yxrofw629Hag4mxzQ7gQEWa5GP7o+EomhK2ik0iQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mklJf6XWEdgROsZznLTt6O0AIYE7fHRXjBCICCWXLW6AxF7dd3DRUaAqEMHKIkDjzFbyGFPzdeBoh4Kc3WFwJIRQNQHSN5bVcI1k0mxYLC4eSdRcWfM54s1L/YXW76GqDa+WraBIpf789cL1QmH1KVPJzVorvgXA7GqmCv8XYDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=lMub7fQ1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DnK33Bci; arc=none smtp.client-ip=64.147.123.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id C76483200AA9;
	Sun,  4 Feb 2024 13:40:49 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sun, 04 Feb 2024 13:40:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm2; t=1707072049; x=1707158449; bh=LoPMlpv8INMjAIFkIp1Px
	GmJ3PBRUa9Kwk1wXk9RVuQ=; b=lMub7fQ1XhLfw6toTTp95VmOW3GOuDMQOP7oo
	QodimUh5fiHG3ugVd8Pk69KuEtULJDkkVyidHa4o8ccUNIn0QLzNrJt+/UDnZR+X
	yPwtVXnhIvkApaW672UajLfKv7JXHd2/45Xt4i+0M7J9urX6HaS3CwmmKS/1Blxf
	TZHM82Y4c+J9ODvGdDdDsS7RAz1y9MtJzurXK0AJk5j3JxFBl71HK6Zu/hNnxtt3
	SOKS4XjEwz6em5DQUBrLDc5LvR2h2CUDC7vlf2u2QwE7EMFghOi05XQJNE0gqq2K
	DAEQuHTTW6qFAoqKcI7GLLWCz4urYJ1KSaZtI0QiLPvHTcI2Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1707072049; x=1707158449; bh=LoPMlpv8INMjAIFkIp1PxGmJ3PBR
	Ua9Kwk1wXk9RVuQ=; b=DnK33BciLqTAtiFSUKFNwRLYEvv3QN4vTARJzHJ/LTFb
	o7HeMJ45+e1iEz/Xc9pTrGv1+oNt9nJnyQuIhhHN+lD4gG3D9yNAEVAbAP6ZKfW4
	B7b6ngFtlz8pVE8hg183aAtCKxUXj9xeDqQYg7peQgqDruYVzh8OUW+rvs0jwkCX
	v/UkMLYjLHb8Eq7qnpPQKoJIg+Bn0T9xUag5/enFVbx1v6AzyJSVvEPnl0nQLrPN
	XAEFfnyvn6Si5p1jXdVwH+wobda2W6WRf8f/T0l3g1avS/KLh6p6RfrUpR8b/Ioo
	2JqxbAzlxUXjp6S4GV5FNcYU1BuOOt2xDWX2LdCVMg==
X-ME-Sender: <xms:Mdq_Zf9fS1G2JQb8pyH-LP_213YqYHFDxgMppNtAk0mjXsY09Hicxw>
    <xme:Mdq_ZbsVYT4ibGM_KIi4-UDNm-UM-oRL5inmygcloDcCFDfXu7PbvBssyLgCWuc85
    YzIi9tJFSqt451yqA>
X-ME-Received: <xmr:Mdq_ZdCaoPIB-xUqVm3We3fHobbdffaceRrVdko550Bs5erNrRn_2cemxhY3O0EIBqdQcyvlSa3RtkEqPif3Osb5PGCOHvA6YYLpfvqoZwQ4Gg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedukedgudduhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecufghrlhcuvffnffculdejtddmnecujfgurhephf
    fvvefufffkofgggfestdekredtredttdenucfhrhhomhepffgrnhhivghlucgiuhcuoegu
    gihusegugihuuhhurdighiiiqeenucggtffrrghtthgvrhhnpedvgefgtefgleehhfeufe
    ekuddvgfeuvdfhgeeljeduudfffffgteeuudeiieekjeenucevlhhushhtvghrufhiiigv
    pedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:Mdq_Zbc2HPb13mhi5FdIOKrS0Ca3iSImisDpvhGH_-xtcdwL4WTUZQ>
    <xmx:Mdq_ZUN6I4J5fJ1UR35WBFIfn8b1sTcAyF8vMpDIEpe2d2IMCBvU3g>
    <xmx:Mdq_ZdncnZndt0Wa9mJybYkhMfjmjce8DBxzGZFOfcDM2c62I7Hqyw>
    <xmx:Mdq_ZQDD3AVgmXbuND_tuA2Pq_Qxxcobf2Fh_Nzbqu8z5gFJhUctfQ>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 4 Feb 2024 13:40:48 -0500 (EST)
From: Daniel Xu <dxu@dxuuu.xyz>
To: acme@kernel.org,
	jolsa@kernel.org,
	quentin@isovalent.com,
	alan.maguire@oracle.com
Cc: andrii.nakryiko@gmail.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	bpf@vger.kernel.org
Subject: [PATCH dwarves v4 0/2] pahole: Inject kfunc decl tags into BTF
Date: Sun,  4 Feb 2024 11:40:36 -0700
Message-ID: <cover.1707071969.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.42.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset teaches pahole to parse symbols in .BTF_ids section in
vmlinux and discover exported kfuncs. Pahole then takes the list of
kfuncs and injects a BTF_KIND_DECL_TAG for each kfunc.

Example of encoding:

        $ bpftool btf dump file .tmp_vmlinux.btf | rg "DECL_TAG 'bpf_kfunc'" | wc -l
        121

        $ bpftool btf dump file .tmp_vmlinux.btf | rg 56337
        [56337] FUNC 'bpf_ct_change_timeout' type_id=56336 linkage=static
        [127861] DECL_TAG 'bpf_kfunc' type_id=56337 component_idx=-1

This enables downstream users and tools to dynamically discover which
kfuncs are available on a system by parsing vmlinux or module BTF, both
available in /sys/kernel/btf.

=== Changelog ===

Changes from v3:
* Guard kfunc tagging behind feature flag
* Use struct btf_id_set8 definition
* Remove unnecessary member from btf_encoder
* Fix code styling

Changes from v2:
* More reliably detect kfunc membership in set8 by tracking set addr ranges
* Rename some variables/functions to be more clear about kfunc vs func

Changes from v1:
* Fix resource leaks
* Fix callee -> caller typo
* Rename btf_decl_tag from kfunc -> bpf_kfunc
* Only grab btf_id_set funcs tagged kfunc
* Presort btf func list

Daniel Xu (2):
  pahole: Add --btf_feature=decl_tag_kfuncs feature
  pahole: Inject kfunc decl tags into BTF

 btf_encoder.c | 361 ++++++++++++++++++++++++++++++++++++++++++++++++++
 dwarves.h     |   1 +
 pahole.c      |   1 +
 3 files changed, 363 insertions(+)

-- 
2.42.1


