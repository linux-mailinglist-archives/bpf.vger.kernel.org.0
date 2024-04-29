Return-Path: <bpf+bounces-28199-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E8658B65E3
	for <lists+bpf@lfdr.de>; Tue, 30 Apr 2024 00:46:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33B9B283173
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 22:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88D2624B2F;
	Mon, 29 Apr 2024 22:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="s0z+8CcK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XLuhPl2b"
X-Original-To: bpf@vger.kernel.org
Received: from wfout2-smtp.messagingengine.com (wfout2-smtp.messagingengine.com [64.147.123.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879931863C
	for <bpf@vger.kernel.org>; Mon, 29 Apr 2024 22:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714430783; cv=none; b=hD6rjAOtI07GqXG8HanHQIsOUc8SmsF03hDMaTGmcm2GUaAycJCbZSntUvrxrPhycUQtvmtAqVHDhCBakuipp53ojUcPcasR3nntG/L0L6J8V1W2nrGKiJa4CsvjzxvPsUk9OgmjnSFPfDtY4KAYsSdbjxaxogCdRnTxsAgz81A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714430783; c=relaxed/simple;
	bh=kXtJSplZMDSurohOoiOT1pxTnmkCmpi03KvhKnj6nNc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AglGGcu7I0BJCZu/v5cHy1TE/S1pX8987O/EfwfQ41sT8zSxCxmHF1XvGuuD3x28t1xtAe9GuqudQr0vcLeOE117o47xv2ybwpBQ/BB2jwMjP06PQ3mjv0PtF9Id2MZUk+nIVI85IGeecX4n2BtngTIDvOr5k3+rHBhSX5H00lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=s0z+8CcK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XLuhPl2b; arc=none smtp.client-ip=64.147.123.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.west.internal (Postfix) with ESMTP id 2FDDD1C0007D;
	Mon, 29 Apr 2024 18:46:19 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 29 Apr 2024 18:46:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm2; t=1714430778; x=1714517178; bh=EITwsVzXT0iTXs6xHdOjY
	nN43rYyVAe4lgSr0tUIFnU=; b=s0z+8CcKgev5S+DKcJqIxBMBOY6CSqirL7+rE
	PQ/TvBo5bGrwoW60iEH++kazoRlyEN/PBmMU+B/qjBNsuiaREUUtauYPlg+UdCKX
	CQQpLI/IklOBVHMg74UKiFqC5jkmyHvE6mKt52p7vfZVXe00r3J+G2RFeUmZVHkR
	1WWNDtnqJ/SQHkmEGSDsZ6hxyPTj+67w/vkPNXo54+GRl7JKgyGTyhzT2GInH69v
	J9E8eeobTW9wK5T1oCU1ARZ7lVBWXKpPXjuKpOHpEIjFVkWxMxeoKVS+XoHzmSxg
	9DQuuRPnB8WBsgrJqPcyCknF0/xVfTRR93udWfTd33ndmnWJA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714430778; x=1714517178; bh=EITwsVzXT0iTXs6xHdOjYnN43rYy
	VAe4lgSr0tUIFnU=; b=XLuhPl2b8Q+Uied/snvm84r2yJzFr/2rtWSUgFBI7kPD
	B7NPqIKbMmMuFT4St4fV8mH0Wd5+6h8TYkVHxQoUoynBdI8RJQRhzgx9QznPWz9Z
	R7KHceEZrCUMh+fW6fP9OsZWHkChoUYppqmQjWLs1oz2a9lcLG0sN0D+VIlrTtV5
	HNGvoAjIVjq/dWMMDzN/6cFN5ovf/Vp6LKICWt/mn+ksynHKmLjWAD/zxzUbxz2R
	tnnIFRrBQlUCAT+uRigM9qTDuDH9iLGkbnJbC0SmgSpqOrFYt/gqVaEAl8NHu47s
	QNuafle7jdey5NDTLgueq5Z55SNIR+lqNcN9cglk3Q==
X-ME-Sender: <xms:OiMwZiMfHPr0j7Ihs6tfCRRl6vNC8K7MgPbu_adup2CNthtIaO5eXw>
    <xme:OiMwZg_QLBiVhgUcuj94KKIQLjUZPld90PO19bMkM_NCSd7Qd7nkPhXxqAvdRXfZS
    fJsVhn-vQvzk2nAog>
X-ME-Received: <xmr:OiMwZpRoNlWwAziRAmFzRfGgt2Q0ullVg76qGjPFbenmAtvONIST85s6XKfR2IIEztTtwZgsisycc1u6cddNdPmFOcwwgnPDZvMCC6pLzxo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdduvddgudegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdlvdefmdenucfjughrpefhvf
    evufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeffrghnihgvlhcuighuuceougig
    uhesugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnhepvdeggfetgfelhefhueefke
    duvdfguedvhfegleejudduffffgfetueduieeikeejnecuvehluhhsthgvrhfuihiivgep
    tdenucfrrghrrghmpehmrghilhhfrhhomhepugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:OiMwZivrci8uVNpFydYiwXDAr4T0eVcM9mHVA9m5RO5Y1_-icqrZXg>
    <xmx:OiMwZqeHHsVLhmfSLtWr2lJxFWRMMaRPLsg3V1bezzpkYChfcf8pew>
    <xmx:OiMwZm1ourxsbPf0fdvLWqelh_sIXxuFitHywWxh1TjldKlu20f5-w>
    <xmx:OiMwZu_1SRJHXVXO1XlvKPYEoBrmItj9j7oQxntaI5pATHo2Ldsmhg>
    <xmx:OiMwZq4slb65A_-WInZCsdO2adkLlANnY4InVM2beS4kQfwlPt4GLLBV>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Apr 2024 18:46:17 -0400 (EDT)
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
Subject: [PATCH dwarves v9 0/3] pahole: Inject kfunc decl tags into BTF
Date: Mon, 29 Apr 2024 16:45:57 -0600
Message-ID: <cover.1714430735.git.dxu@dxuuu.xyz>
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

Tested-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>

=== Changelog ===

Changes from v8:
* Fix another get_func_name() edge case

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


