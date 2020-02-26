Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6BA3E1705CA
	for <lists+bpf@lfdr.de>; Wed, 26 Feb 2020 18:14:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726148AbgBZRON (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 26 Feb 2020 12:14:13 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40101 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726561AbgBZRON (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 26 Feb 2020 12:14:13 -0500
Received: by mail-wm1-f68.google.com with SMTP id t14so25855wmi.5
        for <bpf@vger.kernel.org>; Wed, 26 Feb 2020 09:14:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hs1Dnv8OkUX4sAKXU675PNsCaAiph3nxzHoSQ2tz4mY=;
        b=Fvd0znyFAvs/Z+RQe56DZVCoHHGI0mH5KwABX5dKxqnpfPB7pd+27P572tMfDmx2j3
         7EF0B55OLQsWoPY1hL5SbRUynxBS/H+uH1GznO+Atf27r7N5lH/asoNTIdVEaSotqztW
         RmKHurYYiqYble4Xz7rs7l3LBe0IpJ6FEF7+YWLWIxRH+tKdBV+lm2oYFiHn+HL7HQ4w
         w8BtJiFBtWziNs1/rxN2+YwTbBwcBlfNJBI42jIYoZCpjKtTGO/In6/LOS5w2zYI4XOZ
         QrTxhoYpWQbdW3UTUOWIVk5tb/ny+k/yxes6JSYrmoI8XoaE8X5R8aVUFMU2h8VB/Fn9
         3CeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hs1Dnv8OkUX4sAKXU675PNsCaAiph3nxzHoSQ2tz4mY=;
        b=hTeqZJIMLk5DKBUgIDzzZSnR7VJazi1p1FTlaq0VqE6ZaEsJl5gcdyoDtiuK44iDve
         ZIHtsurwPxSmqLatPfd82MLfqPFzaILt815VYdAH1pY9Y8Izwx2sGvoScQTpZh98bacB
         zOzFmt96fDmw3Z2KgAJW18qdnlDhmEnPTpWf5p2/sPY4DkMQazInYJ4reQ+9MI0VcqHR
         rR5AD5kCnboB38UFi9hNKY8WNY0HQkwgsDNvRW7VWG2xtst6kGGyyjCUAd+lUFzWS891
         bpY21aR7NCRgghJ9MsODPD4V8xAn5s4hfXY5a29iKRrh/WE/fgXQKMTAWLZMCcRUigAO
         F1Cw==
X-Gm-Message-State: APjAAAV6TDCT+ka9H/66/sOl+4Zo2GF2v6B7YYNKuCSCv+thz1hKpKgN
        K4NuK/W5ldSLnDyCCTEdfGVg/A==
X-Google-Smtp-Source: APXvYqxVisx0WWuxbZMRqmE/joqQNU3c6aUjq7FmETJiXmXkhS0yvH+WurdWR1QhvsZ+k3KlpLyI2Q==
X-Received: by 2002:a7b:c8d7:: with SMTP id f23mr6436992wml.173.1582737250916;
        Wed, 26 Feb 2020 09:14:10 -0800 (PST)
Received: from localhost.localdomain ([194.35.116.65])
        by smtp.gmail.com with ESMTPSA id b10sm3962802wrw.61.2020.02.26.09.14.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2020 09:14:10 -0800 (PST)
From:   Quentin Monnet <quentin@isovalent.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        Quentin Monnet <quentin@isovalent.com>
Subject: [PATCH bpf] mailmap: update email address
Date:   Wed, 26 Feb 2020 17:13:53 +0000
Message-Id: <20200226171353.18982-1-quentin@isovalent.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

My Netronome address is no longer active. I am no maintainer, but
get_maintainer.pl sometimes returns my name for a small number of files
(BPF-related). Add an entry to .mailmap for good measure.

Signed-off-by: Quentin Monnet <quentin@isovalent.com>
---
 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index ffb8f28290c7..a0dfce8de1ba 100644
--- a/.mailmap
+++ b/.mailmap
@@ -225,6 +225,7 @@ Pratyush Anand <pratyush.anand@gmail.com> <pratyush.anand@st.com>
 Praveen BP <praveenbp@ti.com>
 Punit Agrawal <punitagrawal@gmail.com> <punit.agrawal@arm.com>
 Qais Yousef <qsyousef@gmail.com> <qais.yousef@imgtec.com>
+Quentin Monnet <quentin@isovalent.com> <quentin.monnet@netronome.com>
 Quentin Perret <qperret@qperret.net> <quentin.perret@arm.com>
 Rafael J. Wysocki <rjw@rjwysocki.net> <rjw@sisk.pl>
 Rajesh Shah <rajesh.shah@intel.com>
-- 
2.20.1

