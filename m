Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8351A644779
	for <lists+bpf@lfdr.de>; Tue,  6 Dec 2022 16:07:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234479AbiLFPHG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 6 Dec 2022 10:07:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbiLFPG1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 6 Dec 2022 10:06:27 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5B8E303CC
        for <bpf@vger.kernel.org>; Tue,  6 Dec 2022 06:59:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670338792;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Dw9LzDdkg+wvG7saGSy8g5Pbbu5VhCTac8ookPf3stw=;
        b=JeMf0NxEOJlH71bSDPPOyAk+jc2rem9UmfjyDfDnsUd1wy8cj8JyduxJoHAwOyc/UeMtpJ
        Pl+b9kCufERdDOMMQ++NcRqEyVTTHq8t4agXG7XVmOADvglIhFATuJJOeWTyMGN7eE2n5R
        vJrC/aB0UPiGUzLqbds3WFesZpIQrIM=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-561-uE6U-oznPByWDiyaxG4gog-1; Tue, 06 Dec 2022 09:59:50 -0500
X-MC-Unique: uE6U-oznPByWDiyaxG4gog-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1433A1C0A581;
        Tue,  6 Dec 2022 14:59:50 +0000 (UTC)
Received: from plouf.redhat.com (unknown [10.39.193.117])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6F43C4A9254;
        Tue,  6 Dec 2022 14:59:48 +0000 (UTC)
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Florent Revest <revest@chromium.org>,
        Jon Hunter <jonathanh@nvidia.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH HID for-next v3 4/5] selftests: hid: ensures we have the proper requirements in config
Date:   Tue,  6 Dec 2022 15:59:35 +0100
Message-Id: <20221206145936.922196-5-benjamin.tissoires@redhat.com>
In-Reply-To: <20221206145936.922196-1-benjamin.tissoires@redhat.com>
References: <20221206145936.922196-1-benjamin.tissoires@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

DYNAMIC_FTRACE_WITH_DIRECT_CALLS is implicit on x86_64 but is still a
WIP on aarm64. Ensure we get it selected to not have any surprises.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

---
no changes in v3

changes in v2:
- dropped ALLOW_ERROR_INJECTION requirement
---
 tools/testing/selftests/hid/config | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/hid/config b/tools/testing/selftests/hid/config
index d4130489c1b1..9c5a55abca6b 100644
--- a/tools/testing/selftests/hid/config
+++ b/tools/testing/selftests/hid/config
@@ -11,6 +11,7 @@ CONFIG_BPF_SYSCALL=y
 CONFIG_BPF=y
 CONFIG_CGROUP_BPF=y
 CONFIG_DEBUG_INFO_BTF=y
+CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
 CONFIG_FPROBE=y
 CONFIG_FTRACE_SYSCALLS=y
 CONFIG_FUNCTION_TRACER=y
-- 
2.38.1

