Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80BEE1F5B5E
	for <lists+bpf@lfdr.de>; Wed, 10 Jun 2020 20:41:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729112AbgFJSly (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 10 Jun 2020 14:41:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbgFJSlx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 10 Jun 2020 14:41:53 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B9D7C03E96B
        for <bpf@vger.kernel.org>; Wed, 10 Jun 2020 11:41:53 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id w18so3445733iom.5
        for <bpf@vger.kernel.org>; Wed, 10 Jun 2020 11:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TqssSk9jekCgl25sSVkHrxv5LcrDzHYWlwwhJ3PjGnc=;
        b=NcASmyezcynt5xNQRWzFnlaFXKNcdzKob9ahl75OqUA0BYOefi3vxPN2KfMSA4inQb
         INQiUwEtMRQ6F9oi2xk6CJU7ZJA7L694Be9Owf1+YOQw+UtLHF65oEGTXlUOM17nn6w+
         eg9izQhRsPjc6fi4ds3sAg+G37ByU0Eeow+cUOCIYqBxOaeQQOm04193NWkeM3w73WTt
         SVGuo768nN4DgbtbmWDytRp6KlM0NVa7Z/YhKapRdm2xp3cJnFFY1abFg4LUSeKTYpLJ
         fclRX+Deeg4bgFiGfe4Ri5VnjjkFpC5EasimA/SUQxiYN7ty0PUu1uHEqZRwIVPMMdDz
         Mvug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TqssSk9jekCgl25sSVkHrxv5LcrDzHYWlwwhJ3PjGnc=;
        b=J5pFQjaHMQm6dPBPBPQYfR8ZtrTD/Kadtb8gVGQWAOtQp8Xv2mogPWIgoFVDAcoQZp
         huC4v5VjN1UU7CoZZhC9qFvc+GPlkH/UcvL2xOC/KLVvGbRfdhDt6n3A/BWIRbpOzukk
         uFmvEA3Qqfh2ByQ2k/mCGM5eTl2FXEFGLbAxh4/5/Qf1EKsHU1XldI1oDMOvQG17Bsvs
         2SFP6qEj4uWICkX7jYJbs0DtiWD2o5OKgC5AXWWXWUiKaoMCZpkehAGpszS1e3slpzg+
         uweQPuAReVWZ100xOHh88eYsBu7AzwWm3VSPB8kmkSe0oBnKYe2KxauIeRASt6pVg5Yl
         7inA==
X-Gm-Message-State: AOAM5333HpJhEFLasX8V+jWeRtzI5SS/UPx/WMvPtQbgGOoRGM/5H6oU
        zCzHaiavrMUxtLsusm1lUSnpN/KNPOA=
X-Google-Smtp-Source: ABdhPJwL8s5bfwwb4V8sI94zxuiAhuYSp0fnIBLZ9Nh5Iq6ieI2CeHo3hJTDASHtty4RBlH4YhXXhg==
X-Received: by 2002:a5e:a705:: with SMTP id b5mr4792492iod.12.1591814512115;
        Wed, 10 Jun 2020 11:41:52 -0700 (PDT)
Received: from localhost.localdomain (host-173-230-99-2.tnkngak.clients.pavlovmedia.com. [173.230.99.2])
        by smtp.gmail.com with ESMTPSA id b13sm319587ilq.20.2020.06.10.11.41.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2020 11:41:51 -0700 (PDT)
From:   YiFei Zhu <zhuyifei1999@gmail.com>
X-Google-Original-From: YiFei Zhu <zhuyifei@google.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Stanislav Fomichev <sdf@google.com>,
        YiFei Zhu <zhuyifei@google.com>
Subject: [PATCH bpf v2 0/2] Fix bpf_skb_load_bytes_relative for cgroup_skb/egress
Date:   Wed, 10 Jun 2020 13:41:38 -0500
Message-Id: <cover.1591812755.git.zhuyifei@google.com>
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

Updates since v1:
* Reverted the bound condition check to account for bad offset parameter
  larger than data length.
* Add test asssertion for failure return code on the condition above.

YiFei Zhu (2):
  net/filter: Permit reading NET in load_bytes_relative when MAC not set
  selftests/bpf: Add cgroup_skb/egress test for load_bytes_relative

 net/core/filter.c                             | 16 +++--
 .../bpf/prog_tests/load_bytes_relative.c      | 71 +++++++++++++++++++
 .../selftests/bpf/progs/load_bytes_relative.c | 48 +++++++++++++
 3 files changed, 128 insertions(+), 7 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/load_bytes_relative.c
 create mode 100644 tools/testing/selftests/bpf/progs/load_bytes_relative.c

--
2.27.0
