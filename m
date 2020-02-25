Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C2AC16F0AB
	for <lists+bpf@lfdr.de>; Tue, 25 Feb 2020 21:54:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729382AbgBYUyp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 Feb 2020 15:54:45 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42791 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728654AbgBYUyp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 Feb 2020 15:54:45 -0500
Received: by mail-wr1-f67.google.com with SMTP id p18so300672wre.9
        for <bpf@vger.kernel.org>; Tue, 25 Feb 2020 12:54:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=28TDunclJ0ED67dbx8CkZqbh/7wdN9qJRWSOtwdsi1s=;
        b=UoHTD/6+hk2QYtP059qZLw3RRZ16mc3CjCh2ZZwsu0a7xHxNMua3zoubg3FnJlMpfT
         h9ft7NT72oICgPc9WavKnXNoQg4dLsDOs92lfQDDJOEaG24d44X339XfYqFwcRKl1+hz
         FaPA+pFgOHmZtoFQij9N6yoY6Gloe1pEwStUk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=28TDunclJ0ED67dbx8CkZqbh/7wdN9qJRWSOtwdsi1s=;
        b=fO5R5omWRNjHOHQk/W56G6vGxnRH8BfSKderaJuulfbF7fW6uvPNszxZop9K7cVGf/
         qp0WgsNRz9AS8y/cuCtxZ0mrX7UZ16sSwQf8W59DP/VC3bE5hR+LAEdpCTXmTE0gv7ve
         oQKTdnWQ2939AEbAZnDuSL0+gHjSji9PsVV2ix9IF0yTA7817jrgVrV6P6rfQf/2NUEm
         4RrkQTvsRbvbR7NDpjUGid+4Sh4FZj2oz2To1RaoPFxCMOri7PIr6RSzfgdBEwUvxwds
         VjeDijH33cU2XRNyD5Axu8JbQCXJfXibTONyexgkKd4FAHuj8pMSse82JE8SzcM4U0kF
         weiQ==
X-Gm-Message-State: APjAAAXrpMaRgOE26YnqPuIJVvSHoNGyY1O7lN/js3+UqYXVq56UX1Zx
        9ZqipRumWjB/RB3bBFD/IQPwPlRnOsEFUonV
X-Google-Smtp-Source: APXvYqxs5Dht7wCnHgNaDyHKMXo95ql8ZEwhG4lxizSll22ZJBzPc0J3TZ9jyuOGIAHL1lrfaQwGNg==
X-Received: by 2002:adf:de0b:: with SMTP id b11mr932096wrm.89.1582664082855;
        Tue, 25 Feb 2020 12:54:42 -0800 (PST)
Received: from lbrmn-lnxub113.broadcom.net ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id t13sm104852wrw.19.2020.02.25.12.54.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2020 12:54:42 -0800 (PST)
From:   Scott Branden <scott.branden@broadcom.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
        Yonghong Song <yhs@fb.com>, Andrii Nakryiko <andriin@fb.com>,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Scott Branden <scott.branden@broadcom.com>
Subject: [PATCH] scripts/bpf: switch to more portable python3 shebang
Date:   Tue, 25 Feb 2020 12:54:26 -0800
Message-Id: <20200225205426.6975-1-scott.branden@broadcom.com>
X-Mailer: git-send-email 2.17.1
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Change "/usr/bin/python3" to "/usr/bin/env python3" for
more portable solution in bpf_helpers_doc.py.

Signed-off-by: Scott Branden <scott.branden@broadcom.com>
---
 scripts/bpf_helpers_doc.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/bpf_helpers_doc.py b/scripts/bpf_helpers_doc.py
index 90baf7d70911..cebed6fb5bbb 100755
--- a/scripts/bpf_helpers_doc.py
+++ b/scripts/bpf_helpers_doc.py
@@ -1,4 +1,4 @@
-#!/usr/bin/python3
+#!/usr/bin/env python3
 # SPDX-License-Identifier: GPL-2.0-only
 #
 # Copyright (C) 2018-2019 Netronome Systems, Inc.
-- 
2.17.1

