Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15E551626BB
	for <lists+bpf@lfdr.de>; Tue, 18 Feb 2020 14:04:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbgBRNEO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 18 Feb 2020 08:04:14 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:55662 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726340AbgBRNEO (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 18 Feb 2020 08:04:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582031052;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=GIrGFZ0JSlt7bh77UYGwq8VnSNDnywZL5T2KJvjBXIU=;
        b=fhUzLx688e3opPHvcTYOB20uXF0A2X5aCuInK546tjgwYTiUiXIU0XBsKDdcyvqUg+aNHw
        iB1beDUY2aCgiaaDYrgYRwXwSit43L+HQuLB5wdEzKR1tJfoRdlscRIqjN1Djqq+9xmZ/d
        /akiPHW5f6LMShNjj2MGnOxdG1eDHak=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-118-Qm6pc-HSMeCDI97qichy6Q-1; Tue, 18 Feb 2020 08:04:11 -0500
X-MC-Unique: Qm6pc-HSMeCDI97qichy6Q-1
Received: by mail-lj1-f200.google.com with SMTP id y15so7113986lji.1
        for <bpf@vger.kernel.org>; Tue, 18 Feb 2020 05:04:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GIrGFZ0JSlt7bh77UYGwq8VnSNDnywZL5T2KJvjBXIU=;
        b=k07JtuG8Cyzt/sULJ+ngNWQFvLXP96dFu2z6s7/JG8OtI84zlD1cO2OZhVsHRFwa7G
         so4yV3YIuBoepfoxKGagujE9dk/VPmE1fPCG0IrCKpHShCraqmkNKX1QR64oapFidy2B
         JUrhE5zDzmHK0tDls3+/s0ahq+P2QnlVOW5jpDoy3DShrYOjCnNEn6e2wv038FUFNHzL
         d/III01KEs0L/5JPC+cD0usZXDv7SvXiGQh3UDm+ktx8H9CSQnTv1rkHs56a7C9HuuXX
         WjZCJVw7s7czw/+t6DRdaWwr8fbZoa+fVBhx5Meetph6MeQ2LaYo/iiuWSm+84q7dSw4
         /70Q==
X-Gm-Message-State: APjAAAU/+4fb9OZv2fddSjBUDVzcaJ6EfnSh0PNfJdpc9f1PfAVQFQ0q
        V02UiAmRxjboPaQYvCa5Pi8nzBObAjr306YCPWKbsjNAwHGIL8ztItk5VWb2NAoQEdeMOxJcZig
        ch+YGpH6TSS4v
X-Received: by 2002:ac2:4c84:: with SMTP id d4mr10465265lfl.64.1582031049435;
        Tue, 18 Feb 2020 05:04:09 -0800 (PST)
X-Google-Smtp-Source: APXvYqzrC2Z6mY//wkKUZYuZ5mv/ieMoyTzpwX7NytYOPWmRzTueN0cVzKV8fznNuQrf4W6pVPFKPA==
X-Received: by 2002:ac2:4c84:: with SMTP id d4mr10465253lfl.64.1582031049172;
        Tue, 18 Feb 2020 05:04:09 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id i4sm2765122lji.0.2020.02.18.05.04.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2020 05:04:08 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id BA243180365; Tue, 18 Feb 2020 14:04:06 +0100 (CET)
From:   =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     daniel@iogearbox.net, ast@fb.com
Cc:     =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        bpf@vger.kernel.org, netdev@vger.kernel.org,
        David Ahern <dsahern@gmail.com>,
        Quentin Monnet <quentin@isovalent.com>
Subject: [PATCH bpf v2] uapi/bpf: Remove text about bpf_redirect_map() giving higher performance
Date:   Tue, 18 Feb 2020 14:03:34 +0100
Message-Id: <20200218130334.29889-1-toke@redhat.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The performance of bpf_redirect() is now roughly the same as that of
bpf_redirect_map(). However, David Ahern pointed out that the header file
has not been updated to reflect this, and still says that a significant
performance increase is possible when using bpf_redirect_map(). Remove this
text from the bpf_redirect_map() description, and reword the description in
bpf_redirect() slightly. Also fix the 'Return' section of the
bpf_redirect_map() documentation.

Fixes: 1d233886dd90 ("xdp: Use bulking for non-map XDP_REDIRECT and consolidate code paths")
Reported-by: David Ahern <dsahern@gmail.com>
Reviewed-by: Quentin Monnet <quentin@isovalent.com>
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
v2:
  - Keep a reference to bpf_redirect() in bpf_redirect_map() text (Quentin)
  - Also fix up 'Return' section of bpf_redirect_map()

 include/uapi/linux/bpf.h | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index f1d74a2bd234..22f235260a3a 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1045,9 +1045,9 @@ union bpf_attr {
  * 		supports redirection to the egress interface, and accepts no
  * 		flag at all.
  *
- * 		The same effect can be attained with the more generic
- * 		**bpf_redirect_map**\ (), which requires specific maps to be
- * 		used but offers better performance.
+ * 		The same effect can also be attained with the more generic
+ * 		**bpf_redirect_map**\ (), which uses a BPF map to store the
+ * 		redirect target instead of providing it directly to the helper.
  * 	Return
  * 		For XDP, the helper returns **XDP_REDIRECT** on success or
  * 		**XDP_ABORTED** on error. For other program types, the values
@@ -1611,13 +1611,11 @@ union bpf_attr {
  * 		the caller. Any higher bits in the *flags* argument must be
  * 		unset.
  *
- * 		When used to redirect packets to net devices, this helper
- * 		provides a high performance increase over **bpf_redirect**\ ().
- * 		This is due to various implementation details of the underlying
- * 		mechanisms, one of which is the fact that **bpf_redirect_map**\
- * 		() tries to send packet as a "bulk" to the device.
+ * 		See also bpf_redirect(), which only supports redirecting to an
+ * 		ifindex, but doesn't require a map to do so.
  * 	Return
- * 		**XDP_REDIRECT** on success, or **XDP_ABORTED** on error.
+ * 		**XDP_REDIRECT** on success, or the value of the two lower bits
+ * 		of the **flags* argument on error.
  *
  * int bpf_sk_redirect_map(struct sk_buff *skb, struct bpf_map *map, u32 key, u64 flags)
  * 	Description
-- 
2.25.0

