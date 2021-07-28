Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9258A3D9944
	for <lists+bpf@lfdr.de>; Thu, 29 Jul 2021 01:09:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232169AbhG1XJm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 28 Jul 2021 19:09:42 -0400
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:35733 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232143AbhG1XJm (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 28 Jul 2021 19:09:42 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.west.internal (Postfix) with ESMTP id 6F2B7320094A;
        Wed, 28 Jul 2021 19:09:39 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 28 Jul 2021 19:09:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm1; bh=G4waoIhk41AWPXK4ZjIDKTU0Dl
        X3UQm/vowYvkaU7gE=; b=cPT2sPy2R0BnFEKKrlQDYfMdjz+xuMEysxKw8ViKfR
        dCJU+Whs1gX22hA8t3MDUTiiCTwzic/tpwa/nn5zDZDze9fziSpMJYTASTQym/jG
        rC+iG+kC7HWyukcJFaLDrKvMMmjAkNuLU9+xTeUdMnkm36BaLBlLoOiWk2G/zMrs
        29Fny9tYK+7HHG4PeQfoGKtJTCSMR6jl2m1iZgWzr+WnUgiNh3KcQXxfq4zERMJO
        tCeS8ql0u2EIvUqlQ9nMNyfUttQ+aLtnZphUS+ujjUc7DtpBqyA0UxXXM640jxrc
        IZXctxysE13x0zicAMcPcovUFDGVCuRKFAjOKyscBcDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=G4waoIhk41AWPXK4Z
        jIDKTU0DlX3UQm/vowYvkaU7gE=; b=kiNyIwJnos8kaoGKEW5twmxhYMK+4CCqK
        F0WA3K9btft9tImnab08C0fgHty9gd1fg7VQ5lv62TZNotFzCuB9flPHIV3cwcxy
        HUz0MsrRBdiT+/dTiGL09Jjjhnj9xPXhP5myQUPYCBJ8GIqXcMX6v+SvfdUGRcr0
        bLD7DzTrWeRn8ubOQXntHtbVRCWjG/SVnDqJqsci0AkHj8o0pnjs9JZg8W2sdM/x
        wT1Dw1w13V/tdI3oFFInIZrtYyFK2aK8YUm53oNJeR95BpWE0XAh8MsblhHeqAaU
        acR4mrMstCq1lzSHs6wAEGDuMBrjzN64wis5XKS26z38dt/3QNhhA==
X-ME-Sender: <xms:suMBYfPKS0-mNJSRXWvEvx4qrOt8rDIHPm7w8ZRAEE0g3WfxyfEfBg>
    <xme:suMBYZ_XlfWEsg0cTHl41M8hNYz9WhHwdjKYlPkerMXYpblOfBFAeNUpL6fpe_SOU
    FAVRL2TUXOg4CpfHA>
X-ME-Received: <xmr:suMBYeQAetCPr6MweCF9ojawFfIOSzpoecgPLz5cslaNJ-4u06J8TxH5ak09dE4McBK3prkabPLrL_IQYptFW41CrPtHG3peKg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrhedtgddugecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecufghrlhcuvffnffculdejtddmnecujfgurhephffvuf
    ffkffoggfgsedtkeertdertddtnecuhfhrohhmpeffrghnihgvlhcuighuuceougiguhes
    ugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnhepieffgfelvdffiedtleejvdetfe
    efiedvfeehieevveejudeiiefgteeiveeiffffnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomhepugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:suMBYTul0i_xpP2LB40q4HNNUiPEtYHfI_Pw64Papjf4B56kDI_5hw>
    <xmx:suMBYXcgy1WsR_AF2Hdb_boxQMzBK3UOVpYGC_UM88QEzwKU51UYwg>
    <xmx:suMBYf1YQqeSBCLN-yfdRdh9-rO2Tnf9UKSpI2xJflZq6sb00vJryA>
    <xmx:s-MBYYolV49jHH40tATSdpJjR0E_5E9uhHjMKBFTUMNOMw8fqcdkTQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 28 Jul 2021 19:09:38 -0400 (EDT)
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     andrii@kernel.org
Cc:     Daniel Xu <dxu@dxuuu.xyz>, bpf@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH bpf] bpf: Do not close un-owned FD 0 on errors
Date:   Wed, 28 Jul 2021 16:09:21 -0700
Message-Id: <5969bb991adedb03c6ae93e051fd2a00d293cf25.1627513670.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Before this patch, btf_new() was liable to close an arbitrary FD 0 if
BTF parsing failed. This was because:

* btf->fd was initialized to 0 through the calloc()
* btf__free() (in the `done` label) closed any FDs >= 0
* btf->fd is left at 0 if parsing fails

This issue was discovered on a system using libbpf v0.3 (without
BTF_KIND_FLOAT support) but with a kernel that had BTF_KIND_FLOAT types
in BTF. Thus, parsing fails.

While this patch technically doesn't fix any issues b/c upstream libbpf
has BTF_KIND_FLOAT support, it'll help prevent issues in the future if
more BTF types are added. It also allow the fix to be backported to
older libbpf's.

Fixes: 3289959b97ca ("libbpf: Support BTF loading and raw data output in both endianness")
Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 tools/lib/bpf/btf.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index b46760b93bb4..7ff3d5ce44f9 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -804,6 +804,7 @@ static struct btf *btf_new(const void *data, __u32 size, struct btf *base_btf)
 	btf->nr_types = 0;
 	btf->start_id = 1;
 	btf->start_str_off = 0;
+	btf->fd = -1;
 
 	if (base_btf) {
 		btf->base_btf = base_btf;
@@ -832,8 +833,6 @@ static struct btf *btf_new(const void *data, __u32 size, struct btf *base_btf)
 	if (err)
 		goto done;
 
-	btf->fd = -1;
-
 done:
 	if (err) {
 		btf__free(btf);
-- 
2.31.1

