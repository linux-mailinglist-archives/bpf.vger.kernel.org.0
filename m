Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22ECA1EEEA5
	for <lists+bpf@lfdr.de>; Fri,  5 Jun 2020 02:08:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726039AbgFEAIi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 4 Jun 2020 20:08:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725986AbgFEAIi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 4 Jun 2020 20:08:38 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4515EC08C5C0
        for <bpf@vger.kernel.org>; Thu,  4 Jun 2020 17:08:37 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id b5so7872397iln.5
        for <bpf@vger.kernel.org>; Thu, 04 Jun 2020 17:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KI71mqTj7xcHC5oZSzHurelNo314XP1LX5fW+78VDlA=;
        b=CaxAlyEFpXnM5qqxBfzdMgUx7pqUuq23c5W207eDYCp2X2PrRdr2x1P4uNlib2O0pY
         A7fkAQ3yJcVuCKNgnsVu+NQ6Lras3ND/0KkR/guaB+a9yRGH9OMBMHx3l7lUPDiG7Czp
         VHrFa3clRiswbF/883KL/GqoK9As1AWaeBiXj/jGtW5WwPnhBVNbJB5dmn1zep8+L9ox
         5coS/i7cf8Wm0uD75+2ed1bEXlu90x87J991xMxcN3wHOdtrUzW1YowPEVypllztZskd
         EjnXthfZrADHQhhNKjied7Yl5Ztc8pNgCdK3VFciBSwjV8lx7Kt/65hoqlcxDgkW9cHa
         D0OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KI71mqTj7xcHC5oZSzHurelNo314XP1LX5fW+78VDlA=;
        b=ZCh8Ymglky5pmkIhRKwsLWmxSaHKtY7BMY4Lgm6KzL4TkzCdsgmY1ynJkFVtmTLBuC
         mxCPNEeCHPtaZHG4wg1KI3OoZueqYsgqv4CZSswIW+P4Xm/ihHh8nbcfmSQYpXPLXzxR
         fi0BEVj62oakwW4uImmRq5Ss+QLk6tX24rx+TDyGDzaCvR7uZ32kdVh5TRKLmyMGDMUd
         Gsi2Xa77NRrEPUuRMnplXVjeXlYmToOUROnSbLXI8PtVV+vR/JWc+OAjgmMlTTc7FWJ4
         87iUW+4TGlNnSdYhIkNYV5OHc9VhQ3HufLR4YxxcRCIHdNkrxungkIfQ1J5p89UIg14y
         G0Gg==
X-Gm-Message-State: AOAM530PCvGDVe4AHGIRsAgnyPpXvi50P43ZCzjvBG96nLgXQrrKboZ4
        63k1V+0AFfob4QHb7+WyVe3CSE/LhwJSkw==
X-Google-Smtp-Source: ABdhPJxReW4QJzze6Ul6tWMgGe8ZOx0iHN8Ltor47OTyHs5PpZM4I8z8n9CcWHhUz0tMZ4VAQgA2SQ==
X-Received: by 2002:a92:b704:: with SMTP id k4mr6071055ili.129.1591315716247;
        Thu, 04 Jun 2020 17:08:36 -0700 (PDT)
Received: from localhost.localdomain (host-173-230-99-2.tnkngak.clients.pavlovmedia.com. [173.230.99.2])
        by smtp.gmail.com with ESMTPSA id y3sm557661ioy.40.2020.06.04.17.08.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2020 17:08:35 -0700 (PDT)
From:   YiFei Zhu <zhuyifei1999@gmail.com>
X-Google-Original-From: YiFei Zhu <zhuyifei@google.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Stanislav Fomichev <sdf@google.com>,
        YiFei Zhu <zhuyifei@google.com>
Subject: [PATCH bpf 0/2] Fix bpf_skb_load_bytes_relative for cgroup_skb/egress
Date:   Thu,  4 Jun 2020 19:07:37 -0500
Message-Id: <cover.1591315176.git.zhuyifei@google.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

When cgroup_skb/egress triggers the MAC header is not set. On the other hand,
load_bytes_relative unconditionally calls skb_mac_header which, when MC not
set, returns a pointer after the tail pointer, breaking the logic even if the
caller requested the NET header.

Fix is to conditionally use skb_mac_header or skb_network_header depending on
the requested header, -EFAULT when the header is not set. Added a test that
asserts during cgroup_skb/egress request for MAC header returns -EFAULT and
request for NET header succeeds.

YiFei Zhu (2):
  net/filter: Permit reading NET in load_bytes_relative when MAC not set
  selftests/bpf: Add cgroup_skb/egress test for load_bytes_relative

 net/core/filter.c                             | 16 +++--
 .../bpf/prog_tests/load_bytes_relative.c      | 71 +++++++++++++++++++
 .../selftests/bpf/progs/load_bytes_relative.c | 44 ++++++++++++
 3 files changed, 124 insertions(+), 7 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/load_bytes_relative.c
 create mode 100644 tools/testing/selftests/bpf/progs/load_bytes_relative.c

--
2.27.0
