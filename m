Return-Path: <bpf+bounces-27874-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EE5D18B2E0A
	for <lists+bpf@lfdr.de>; Fri, 26 Apr 2024 02:29:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50E4DB245C8
	for <lists+bpf@lfdr.de>; Fri, 26 Apr 2024 00:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 820B6620;
	Fri, 26 Apr 2024 00:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="hjikKoJt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gdf9uJHX"
X-Original-To: bpf@vger.kernel.org
Received: from wfout8-smtp.messagingengine.com (wfout8-smtp.messagingengine.com [64.147.123.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820D8184D
	for <bpf@vger.kernel.org>; Fri, 26 Apr 2024 00:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714091353; cv=none; b=etJo0vW1/usANXMzGXgQp0EciBTUHJugheYrWQ8nN/+Byf7kFQziqtQdLRwcTmdlVuVFbx5RhrvZBSseexBJOaLB3yPsBpBGdzNcIaeOU4qjUAXbcgNhxa34H01VKTijkOrLzosWdnWdifuxkLdG2Greqhcujn4RANrRNCOfN2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714091353; c=relaxed/simple;
	bh=QXKoTGM09eQqJLWeYRYyMdBbzAa1LAKBjwTsxlQiULI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Rvaam4jV1eLii8xUJJ0VGQ69yC/0+WWxSZYQ6Q7GhLecvsmWB1iDyg1l9ReVYG5gsCxR49sSV29ApRJMu7xoKotnmc7iPsTxE5oABuhqo0cfExEMjVMYZwNAxILzSrSlGLWtDPZZCirZJmCP+JxBMBqeRy4ZqCAU2MNcNfvo8XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=hjikKoJt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gdf9uJHX; arc=none smtp.client-ip=64.147.123.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.west.internal (Postfix) with ESMTP id EA3C51C00112;
	Thu, 25 Apr 2024 20:29:09 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 25 Apr 2024 20:29:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm2; t=1714091349; x=1714177749; bh=VQTp9HAnZK6XP49EkB/e5
	85P1Vaj6gEWVb27/FaGafw=; b=hjikKoJt7mgRDHB5U4dUXw7tMXLy4vsxwUSjI
	vlEZDoA8HXICn7M21z6T29rK6zxOXvk9qnW3XWLrSnG9Xv6gpv3tnHLhWeloJHQj
	P6pfHD0VvTI/A24MEyVK3KcFtx/1tVan6ux83QLA0AairLM+jG6fzf8Q4Yqv9Nvl
	G/aJNC8bkxsUXjC7HG4UfB4VQWCaSNkwpnp+3QMvWF9Ry8HdD7Cc1ShSCfah15a2
	DVwDBNlDl2PN1ah7N2HTuKOvFsTp7hZLTKgaBEfgFOr3REnxec2mB8tv3cpmmK1S
	nnhHE0jbnAW7kTVokWw8E2a3adtxgNIULEE11bznQ1dE/yfJg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714091349; x=1714177749; bh=VQTp9HAnZK6XP49EkB/e585P1Vaj
	6gEWVb27/FaGafw=; b=gdf9uJHXQsxqiER97hIVGRCLrIfjViwI839g19al9AHO
	Bhw6jSWU5TXuzPBAcMJRL24lPxQPict7tCy0NxUVgMKKZHUWWLBS3IkT1qASPZ8j
	+m/BbLlwpIARjH1J0aG6tAKq7rAqRTsALIy1dcqWzGH4bOrZd+NG/ltqyvnKuLCF
	ObO6E71enPOv7liaXdXkeKrTMQL4xrOZO3EnA+91GBd9e9Afw8/+Zs0V9ISlNcWt
	0gQRxV8ha7925igvT1JMc/SejhvJxO0hbBZ3hDvISzSvfVCqByWXjxmJJvv+wyi5
	C+xHSBA9jU7o94im8asae9v5Y7pXqWRrTgoDuXN7xg==
X-ME-Sender: <xms:VPUqZnzVxOPPIN0IRmcLbpnUkIcCIyzMXc73RBfMDhj9q9-k06TXNw>
    <xme:VPUqZvRp4nC6pc40ay0TYqJHNV8OkkqS5Yb_d6hul_nfb2rBxk9JhFWdOminWPvhQ
    3G9x5ueaf36QLpJxg>
X-ME-Received: <xmr:VPUqZhWt6Ler0h_gplnCU-72Oks7T_6ihYofTEZg1o9kxyIHmMNYcGRDZ0zliBQ9gT49ubyWLIKvYwLvOI8LyBdpCAZ0QVTEcJZ0IfJzLHY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudelkedgfeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdljedtmdenucfjughrpefhvf
    evufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeffrghnihgvlhcuighuuceougig
    uhesugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnhepvdeggfetgfelhefhueefke
    duvdfguedvhfegleejudduffffgfetueduieeikeejnecuvehluhhsthgvrhfuihiivgep
    tdenucfrrghrrghmpehmrghilhhfrhhomhepugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:VPUqZhj80WMhHUUgzABsdCTAwrIcbRgGrWkdrEmhquLkn-4qtTdEBQ>
    <xmx:VfUqZpCqSZsqbRBsnKnYQ0WW0XRyLrySfoKAI1TLmit1otKKzYZlTA>
    <xmx:VfUqZqKbQeuDdz4-bPrdL-meqYdii1cxp_c5Tz2H3H5GG-15gN2nOQ>
    <xmx:VfUqZoBhuITFETbN6TItyjjsydVXcICUqnXYGfyNJ6O2o88kQOA3ZA>
    <xmx:VfUqZttSPlQCgRxPixKnp4cciepdHE280o8oRPwz3Torp5Y1YqqFGJfV>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Apr 2024 20:29:08 -0400 (EDT)
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
Subject: [PATCH dwarves v8 0/3] pahole: Inject kfunc decl tags into BTF
Date: Thu, 25 Apr 2024 18:28:38 -0600
Message-ID: <cover.1714091281.git.dxu@dxuuu.xyz>
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

Changes from v7:
* Fix/support detached BTF encoding

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

Daniel Xu (3):
  pahole: Save input filename separate from output
  pahole: Add --btf_feature=decl_tag_kfuncs feature
  pahole: Inject kfunc decl tags into BTF

 btf_encoder.c      | 377 +++++++++++++++++++++++++++++++++++++++++++++
 dwarves.h          |   1 +
 man-pages/pahole.1 |   1 +
 pahole.c           |   1 +
 4 files changed, 380 insertions(+)

-- 
2.44.0


