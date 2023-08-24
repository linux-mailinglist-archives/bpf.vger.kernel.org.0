Return-Path: <bpf+bounces-8497-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 406257877AE
	for <lists+bpf@lfdr.de>; Thu, 24 Aug 2023 20:21:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECD9F2815FC
	for <lists+bpf@lfdr.de>; Thu, 24 Aug 2023 18:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E8EE15AD6;
	Thu, 24 Aug 2023 18:21:21 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1383615AC8
	for <bpf@vger.kernel.org>; Thu, 24 Aug 2023 18:21:21 +0000 (UTC)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F11391BEB;
	Thu, 24 Aug 2023 11:21:19 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37OILAZf119095;
	Thu, 24 Aug 2023 13:21:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1692901270;
	bh=YBXfK1ffDRuuw2ZjihAgBCtqcWGidH+IMIvNmqD53/8=;
	h=From:To:CC:Subject:Date;
	b=yIREnAI9X+ZuUAEpYkqFXuVo7Ultu4Z8rH5Ge1rZkuN0wKgpBjQH12Mh/fn0KYodE
	 I2YGvHW8wi0m5rTYJa1+NOeox7uzrRFchtBzL9SmKv+0fIe7b9SLr+JkD65EORfaVJ
	 yhMJUWqTaNEMFw9DHhPxysh5JRIYHr/EREDkR16w=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37OILAJv019000
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 24 Aug 2023 13:21:10 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 24
 Aug 2023 13:21:09 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 24 Aug 2023 13:21:09 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
	by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37OIL9qJ075286;
	Thu, 24 Aug 2023 13:21:09 -0500
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
Subject: [PATCH 0/2] Documentation: sphinx: Add sphinx-prompt
Date: Thu, 24 Aug 2023 13:21:05 -0500
Message-ID: <20230824182107.3702766-1-nm@ti.com>
X-Mailer: git-send-email 2.40.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,
Discussion started off in u-boot documentation[1] and Heinrich
suggested[2] getting something similar done for kernel as well.

https://youtu.be/ItjdVa59jjE shows how this change helps.

I have picked just a trivial file to show the impact, but it can
probably get done for other files as well.

NOTE: I am a sphinx noob, so, there might be better approaches.
Suggestions welcome.

Nishanth Menon (2):
  Documentation: sphinx: Add sphinx-prompt
  Documentation: bpf: Use sphinx-prompt

 Documentation/bpf/libbpf/libbpf_build.rst | 20 ++++++++++----------
 Documentation/conf.py                     |  2 +-
 Documentation/sphinx/requirements.txt     |  1 +
 3 files changed, 12 insertions(+), 11 deletions(-)

[1] https://lore.kernel.org/all/87fs48rgto.fsf@baylibre.com/
[2] https://lore.kernel.org/r/Datecc5d8c56-546a-4cd7-6a78-1206e9675555@canonical.com
-- 
2.40.0


