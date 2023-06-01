Return-Path: <bpf+bounces-1588-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5203571A11E
	for <lists+bpf@lfdr.de>; Thu,  1 Jun 2023 16:57:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AED52815E9
	for <lists+bpf@lfdr.de>; Thu,  1 Jun 2023 14:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D525F21CEE;
	Thu,  1 Jun 2023 14:56:52 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20EC23A1
	for <bpf@vger.kernel.org>; Thu,  1 Jun 2023 14:56:52 +0000 (UTC)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6502107;
	Thu,  1 Jun 2023 07:56:50 -0700 (PDT)
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2af290cf9b7so12928431fa.3;
        Thu, 01 Jun 2023 07:56:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685631409; x=1688223409;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6pQX1x+nXF4H20kd14hFqiq2M6ndmVSb039N9uVMABU=;
        b=M54yAih28+g4x2/uh0AkDPpDr6CcGoY7DPAzik2ricRhJPDgWWKV646dprSX/WbM7d
         2xRTQOt1UdWPPHco9dMIegPU2zu8o0VeqlnhO2eNZz+vLqZLmTcbTNunEToGaZK8BS4b
         7JSq4hZu+N1zahd6+FCaPZT3GFowq3jFJ0sWk2lHl41+xkN4UawzDG5wzNsASeANbPs+
         9VXavpFKvSo18R3SdGXYPKJULwNjYiLLtiIklPdv6+LJnRm8aptfLSlQIyy/c0T8GeUd
         S0lZEFYajUwhgryTvwCXodfq3s1lAI7ULw10OU1nwRTqhns7HutnkX5GCI+NSFmG39un
         Sd7A==
X-Gm-Message-State: AC+VfDwH1GNgbJ2Js0jPPimdqIos28rjAJMA0SxXMUn/Dinx5Ufkt+X0
	sUbXiHto5DYNYHHrjlh4YZw=
X-Google-Smtp-Source: ACHHUZ7DsCMLYi1ie6WkKA6SYPVt8nN4gTfo/QRLz7d+scYSyBcW8yIs6iiEKel3iFDXusF7A9vqXA==
X-Received: by 2002:a2e:3203:0:b0:2ad:dd7e:6651 with SMTP id y3-20020a2e3203000000b002addd7e6651mr5556136ljy.43.1685631408555;
        Thu, 01 Jun 2023 07:56:48 -0700 (PDT)
Received: from costa-tp.bos2.lab ([2a00:a040:1a3:c11b:3ae6:1732:e587:a81f])
        by smtp.gmail.com with ESMTPSA id y24-20020a2e9d58000000b002b135080b1esm366217ljj.12.2023.06.01.07.56.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 07:56:47 -0700 (PDT)
From: Costa Shulyupin <costa.shul@redhat.com>
To: Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Costa Shulyupin <costa.shul@redhat.com>,
	linux-kernel@vger.kernel.org (open list),
	bpf@vger.kernel.org (open list:BPF [MISC])
Subject: [PATCH v3] Documentation: subsystem-apis: Categorize remaining subsystems
Date: Thu,  1 Jun 2023 17:55:55 +0300
Message-Id: <20230601145556.3927838-1-costa.shul@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <ZHgM0qKWP3OusjUW@debian.me>
References: <ZHgM0qKWP3OusjUW@debian.me>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=true
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Bagas Sanjaya <bagasdotme@gmail.com>

Add classes:
* Core subsystems
* Storage
* Networking
* Peripherals and devices
* Embedded systems
* Integrity
* Virtualization
* Miscellaneous

There is a FIXME that says to organize subsystems listed in
subsystem-apis.rst. Fulfill it by categorize remaining subsytems
by purpose/themes, while sorting entries in each category.

HID devices are already categorized in 3c591cc954d56e ("docs:
consolidate human interface subsystems").

Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>

---

Changes:
v3: add Integrity, Virtualization and Miscellaneous per Bagas Sanjaya
v2: add Core subsystems, Networking, Peripherals and Embedded
v1: add Storgre category
---
 Documentation/subsystem-apis.rst | 119 ++++++++++++++++++++++---------
 1 file changed, 86 insertions(+), 33 deletions(-)

diff --git a/Documentation/subsystem-apis.rst b/Documentation/subsystem-apis.rst
index 55c90d5383ef..2c0b18a66e4e 100644
--- a/Documentation/subsystem-apis.rst
+++ b/Documentation/subsystem-apis.rst
@@ -10,58 +10,111 @@ is taken directly from the kernel source, with supplemental material added
 as needed (or at least as we managed to add it — probably *not* all that is
 needed).
 
+Core subsystems
+---------------
+
+.. toctree::
+   :maxdepth: 1
+
+   core-api/index
+   cpu-freq/index
+   driver-api/index
+   locking/index
+   mm/index
+   power/index
+   scheduler/index
+   timers/index
+   wmi/index
+
 Human interfaces
 ----------------
 
 .. toctree::
    :maxdepth: 1
 
-   input/index
+   fb/index
+   gpu/index
    hid/index
+   input/index
    sound/index
-   gpu/index
-   fb/index
 
-**Fixme**: much more organizational work is needed here.
+Storage
+-------
 
 .. toctree::
    :maxdepth: 1
 
-   driver-api/index
-   core-api/index
-   locking/index
-   accounting/index
    block/index
    cdrom/index
-   cpu-freq/index
-   fpga/index
-   i2c/index
-   iio/index
-   isdn/index
+   filesystems/index
+   pcmcia/index
+   scsi/index
+   target/index
+
+
+Networking
+----------
+
+.. toctree::
+   :maxdepth: 1
+
+   bpf/index
    infiniband/index
-   leds/index
+   isdn/index
+   mhi/index
    netlabel/index
    networking/index
-   pcmcia/index
-   power/index
-   target/index
-   timers/index
+
+
+Peripherals and devices
+-----------------------
+
+.. toctree::
+   :maxdepth: 1
+
+   PCI/index
+   hwmon/index
+   leds/index
+   misc-devices/index
+   usb/index
+
+
+Embedded systems
+----------------
+
+.. toctree::
+   :maxdepth: 1
+
+   fpga/index
+   i2c/index
+   iio/index
+   peci/index
    spi/index
    w1/index
-   watchdog/index
+
+Integrity
+---------
+
+.. toctree::
+   :maxdepth: 1
+
+   crypto/index
+   security/index
+
+Virtualization
+--------------
+
+.. toctree::
+   :maxdepth: 1
+
    virt/index
-   hwmon/index
+
+Miscellaneous
+-------------
+
+.. toctree::
+   :maxdepth: 1
+
    accel/index
-   security/index
-   crypto/index
-   filesystems/index
-   mm/index
-   bpf/index
-   usb/index
-   PCI/index
-   scsi/index
-   misc-devices/index
-   scheduler/index
-   mhi/index
-   peci/index
-   wmi/index
+   accounting/index
+   watchdog/index
-- 
2.40.1


