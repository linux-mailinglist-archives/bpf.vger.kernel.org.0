Return-Path: <bpf+bounces-8495-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74E167877AC
	for <lists+bpf@lfdr.de>; Thu, 24 Aug 2023 20:21:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E724281647
	for <lists+bpf@lfdr.de>; Thu, 24 Aug 2023 18:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF5AD156FD;
	Thu, 24 Aug 2023 18:21:20 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A212513AF2
	for <bpf@vger.kernel.org>; Thu, 24 Aug 2023 18:21:20 +0000 (UTC)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FB601BE9;
	Thu, 24 Aug 2023 11:21:19 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37OILAa6130187;
	Thu, 24 Aug 2023 13:21:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1692901270;
	bh=29ZAGUFfTvoDgh18sncsggcW+sW03zKhCPzpLwmnsKY=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=srM3I9UgYqF1B5+XpKCeIn+FhKCHYfyOKd0CTSB1CFMvrZEfhzE7QVSbjHdVy930M
	 rarMfAY/77L9x88p0xZQY4z1qjOh/cRru+yDnA8fIUNzYPqBMIElzk0+rvsUd4Qvhc
	 Z7M7aei1CApBCrP77IpRzSlEvm1WkTUWg8n8T56o=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37OILAcA018998
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 24 Aug 2023 13:21:10 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 24
 Aug 2023 13:21:09 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 24 Aug 2023 13:21:10 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
	by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37OIL9Of054532;
	Thu, 24 Aug 2023 13:21:10 -0500
From: Nishanth Menon <nm@ti.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jonathan Corbet
	<corbet@lwn.net>
CC: <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <bpf@vger.kernel.org>,
        Heinrich Schuchardt
	<heinrich.schuchardt@canonical.com>,
        Mattijs Korpershoek
	<mkorpershoek@baylibre.com>,
        Simon Glass <sjg@chromium.org>, Tom Rini
	<trini@konsulko.com>,
        Neha Francis <n-francis@ti.com>, Nishanth Menon
	<nm@ti.com>
Subject: [PATCH 1/2] Documentation: sphinx: Add sphinx-prompt
Date: Thu, 24 Aug 2023 13:21:06 -0500
Message-ID: <20230824182107.3702766-2-nm@ti.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230824182107.3702766-1-nm@ti.com>
References: <20230824182107.3702766-1-nm@ti.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Sphinx-prompt[1] helps bring-in '.. prompt::' option that allows a
better rendered documentation, yet be able to copy paste without
picking up the prompt from the rendered documentation.

[1] https://pypi.org/project/sphinx-prompt/
Link: https://lore.kernel.org/all/87fs48rgto.fsf@baylibre.com/
Suggested-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Suggested-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
---
I would have added Reported-by for Simon, since he reported the issue in
the first place.. but it was for the u-boot documentation, so skipping
here.

 Documentation/conf.py                 | 2 +-
 Documentation/sphinx/requirements.txt | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/conf.py b/Documentation/conf.py
index d4fdf6a3875a..2eff713c4728 100644
--- a/Documentation/conf.py
+++ b/Documentation/conf.py
@@ -55,7 +55,7 @@ needs_sphinx = '1.7'
 extensions = ['kerneldoc', 'rstFlatTable', 'kernel_include',
               'kfigure', 'sphinx.ext.ifconfig', 'automarkup',
               'maintainers_include', 'sphinx.ext.autosectionlabel',
-              'kernel_abi', 'kernel_feat']
+              'kernel_abi', 'kernel_feat', 'sphinx-prompt']
 
 if major >= 3:
     if (major > 3) or (minor > 0 or patch >= 2):
diff --git a/Documentation/sphinx/requirements.txt b/Documentation/sphinx/requirements.txt
index 335b53df35e2..24a59ceda582 100644
--- a/Documentation/sphinx/requirements.txt
+++ b/Documentation/sphinx/requirements.txt
@@ -1,3 +1,4 @@
 # jinja2>=3.1 is not compatible with Sphinx<4.0
 jinja2<3.1
 Sphinx==2.4.4
+sphinx-prompt==1.5.0
-- 
2.40.0


