Return-Path: <bpf+bounces-27709-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E020E8B1115
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 19:35:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AA681F27B14
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 17:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1742E16D326;
	Wed, 24 Apr 2024 17:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="R/QPj1RS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iEtbb5Fk"
X-Original-To: bpf@vger.kernel.org
Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6660A16D30C
	for <bpf@vger.kernel.org>; Wed, 24 Apr 2024 17:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713980090; cv=none; b=UT96eLUgcmAhlCPSo8eyuMhD0LFe74Y0Q9giH6aL7ToB8MMooRRqIJdxFM1VpqIxBkSpWZd6nGqpZ1jxY93ovNaWMRo+7HSCGvkTVXkYGxLTu9m0Zo51Nf3nGa1eQs1c+zmL8tULG4fM1jULOumDzAlt4G8xJJpeNQYC0MMIXMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713980090; c=relaxed/simple;
	bh=X0byQvqsaXSh8f5onSwrsR7/by7N4JhxBUaQ6yvZmaI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ADPkgE4EOK+NO7mmw21yY1MR1QcbfmHjyhZnoBf87LsHbxxmzuhwu3XYW2gATXV3x2WFaLV9w/8hCNDqlQzSS75AXae7WvrwsciJRZS2/ch8jXF97u/3BR0t48H9dXtEfM/BceZ3+OQ/Y4NPZsfapMLuGrMTTJZ13oeenWbJ7/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=R/QPj1RS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iEtbb5Fk; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 5E2331140118;
	Wed, 24 Apr 2024 13:34:47 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 24 Apr 2024 13:34:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm2; t=1713980087; x=1714066487; bh=Wdc6hTOHx0qmkMKNYGEb8
	j+RfRCgrgPNkto5X/edgSc=; b=R/QPj1RSWcpfKs0PV5W9sfpWODW1Ecj7dYJlh
	RGvXQxbAoUgCm1EtsaP1OzFPNnVXCDiXz+NsHw5eiKo5kWE0VLnTamWIFJyWTJ1Q
	YeQ9Yx26CYQpYJ4UiBqgDOoJ1TdSsli7RJ6SEc8unT7QPBEUFdKZwtWpRdq/fCaT
	bvhkDcWPx7u5mjafD/oj4Tq0EDpz0b0PFGq6TKzOp/av+vfLDHXRr+mQAja9+x62
	flCtx19EywPXkd5MP+TKPXgCNAUEgwzuQtvo3rtcZCmAdvyxXywr3dgZr3x/WBX0
	u0eaBXN+RT1zkNMWeiZZZgtpnfd5LU/0iahzMcBxUEp0eoPRw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1713980087; x=1714066487; bh=Wdc6hTOHx0qmkMKNYGEb8j+RfRCg
	rgPNkto5X/edgSc=; b=iEtbb5FklkKHBEaP/N419jvWTaZCji6PHWiOjjmKRn7D
	9XaPk4syqPeNNse/e1UtGfH2ImFOodkBnHq7lhrfXIRJw90NXqNZbI/idIdbj6N8
	TnrlmaU9DrluSufX/lI/mj8ZQ5Hc8CvZ02cLH/6FcV0LWJKlA0I6/KZ9oKZPl6gD
	ifWdwdWqlSDFMhWpR8cnkJETaScynR/bxUSKGvb4hWJ/GzAU0i5xnswJt/nytT+g
	y9UNndrsvBK9vxl9rEcEemiB8FTT3Vb6jIYSMcgCk2hjbtHsaM8UCn9MK+4UUb+Y
	2R5ZOPQCkV/GyzleFBdLlsN7++HNY5PWFu8Dg/OFww==
X-ME-Sender: <xms:tkIpZnsIQeJcWEMblrpdFux827oizdi3h4OGVFqjgnhmhnK_Mo_VJA>
    <xme:tkIpZoc6qYalgORvR2vJeGnk8jniiUHfUJZHbk8rnggT4wAq-21l-62Y1FRf9_gHT
    UpApYd0XkUar2OdMw>
X-ME-Received: <xmr:tkIpZqyNd17psCCXhNCKedKv18dOThi_SSxX-oX92xfKgNH72iRLx4sW6G1JYCfhGXJDHxqxeWqb_4WB16520N9XPEOUWlro9z3OR2cVJ3c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudelhedgheehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdljedtmdenucfjughrpefhvf
    evufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeffrghnihgvlhcuighuuceougig
    uhesugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnhepvdeggfetgfelhefhueefke
    duvdfguedvhfegleejudduffffgfetueduieeikeejnecuvehluhhsthgvrhfuihiivgep
    tdenucfrrghrrghmpehmrghilhhfrhhomhepugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:tkIpZmNGo6mnxZUoaMuwQOYpyxyL37wchcPe6cOUfP8FsUoIxipomw>
    <xmx:tkIpZn-uSeV6jWx9r6j1lgxMlJ8Ihfq2attFmuDLWx4bPMxO7RolGg>
    <xmx:tkIpZmUCIFPvGF3GKifkr41re5KIRTdbHewq333ZVJgpyvpUWEz0Qg>
    <xmx:tkIpZodUgWTu8YVVJATFWUPBX3HpwsnpebKfJSxHh4lD5WOBYjUFxQ>
    <xmx:t0IpZubF8noxXB1O_X41rXm94JRSeJxim55OkHUmlIG-5_OfjF7Xnn4A>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Apr 2024 13:34:46 -0400 (EDT)
From: Daniel Xu <dxu@dxuuu.xyz>
To: acme@kernel.org,
	jolsa@kernel.org,
	quentin@isovalent.com,
	alan.maguire@oracle.com,
	eddyz87@gmail.com
Cc: andrii.nakryiko@gmail.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	bpf@vger.kernel.org
Subject: [PATCH dwarves v7 0/2] pahole: Inject kfunc decl tags into BTF
Date: Wed, 24 Apr 2024 11:33:50 -0600
Message-ID: <cover.1713980005.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.44.0
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

This feature is enabled with --btf_features=decl_tag,decl_tag_kfuncs.

=== Changelog ===

Changes from v6:
* Rebase and add decl_tag_kfuncs as default feature

Changes from v5:
* Add gobuffer__sort() helper
* Use strstarts() instead of strncmp()
* Use uint64_t instead of size_t
* Add clarifying comments for get_func_name()

Changes from v4:
* Update man page with decl_tag_kfuncs feature
* Fix release mode build warnings
* Add elf_getshrstrndx() error checking
* Disable tagging if decl_tag feature is off
* Fix malformed func name handling

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

 btf_encoder.c      | 374 +++++++++++++++++++++++++++++++++++++++++++++
 dwarves.h          |   1 +
 man-pages/pahole.1 |   1 +
 pahole.c           |   1 +
 4 files changed, 377 insertions(+)

-- 
2.44.0


