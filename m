Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 674CE1CD886
	for <lists+bpf@lfdr.de>; Mon, 11 May 2020 13:34:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729631AbgEKLcm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 11 May 2020 07:32:42 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:53394 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729618AbgEKLcl (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 11 May 2020 07:32:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589196760;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=hQUkEydOpp6BWEZjpv9SKHKYKamnTJBvfR8HfV65p3I=;
        b=EDO5PDlEgc1bPLhwB19nvgl8ml0KnuapWx2+XqyDYhtZ/6w0Vc+NdWD1gK1cVpm7lTYamY
        tiXvWy5oTfSJayUs3Gcw4M4wNCZnOHdVa87x4eWfavqoy/aVXTToxogobP+jtxHumOwqYT
        MOeL5XHkoB/gPYgS8S2W6Cj+57QkJtk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-142-_vGi6L6kMzekVUSZ7xTomQ-1; Mon, 11 May 2020 07:32:39 -0400
X-MC-Unique: _vGi6L6kMzekVUSZ7xTomQ-1
Received: by mail-wm1-f69.google.com with SMTP id h6so8187954wmi.7
        for <bpf@vger.kernel.org>; Mon, 11 May 2020 04:32:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hQUkEydOpp6BWEZjpv9SKHKYKamnTJBvfR8HfV65p3I=;
        b=jCO38VkrUDj6RKcUDk9GJ7P2CdCkqnQ96McXguEdcmynAN6GCioy57l6m5K2ELxMH7
         zr+1CewoWyPQj5DoON6fZqv6Z5Le8Vh9F8QPaRE+ykDJDmGr9Dmj598H2qZ2UAxigEw3
         TBx595n0kQr1K+UKoPTO6+C0zeHgQZVAcvFENKNeTPXV39yu0TkuVuheqS4ha2vTlKTO
         rOXVbSAszrC4NdpXYujKs10yA0i+Mh6L+UOwlT1Xr3SBQlvKFYhBrdgcVzPxp/eD4gjq
         0U3/tgW8S/u1qNC1C5egdbHw71vqDUu75vgHwxxc2vI50rioM8RoSfgw9xARvcWiSOjf
         q5Yw==
X-Gm-Message-State: AGi0PuY42qsdFWLDR/le+b9zqwxCeq817HXyrRn2mDlOTNfxWAlH4bpI
        SkV3lENn4bj6AqE2KvmPv3VIIlyFwez5L6CK5881U/CCyx+ooYLdTrOKCsjqgUGs7cljhGsOVRJ
        5SdbevSMtdR1C
X-Received: by 2002:adf:f6c4:: with SMTP id y4mr19901702wrp.81.1589196757832;
        Mon, 11 May 2020 04:32:37 -0700 (PDT)
X-Google-Smtp-Source: APiQypJ3X2Ouavx+PztaCv6hUD+xToftSDRS9MEcEfVLu6LTOlsm3dxf6NwZdhPy6/02ob/g675gpA==
X-Received: by 2002:adf:f6c4:: with SMTP id y4mr19901675wrp.81.1589196757643;
        Mon, 11 May 2020 04:32:37 -0700 (PDT)
Received: from raver.teknoraver.net (net-2-44-90-75.cust.vodafonedsl.it. [2.44.90.75])
        by smtp.gmail.com with ESMTPSA id e22sm1835043wrc.41.2020.05.11.04.32.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 04:32:36 -0700 (PDT)
From:   Matteo Croce <mcroce@redhat.com>
To:     bpf@vger.kernel.org, netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Joe Stringer <joe@ovn.org>, Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH bpf] samples: bpf: fix build error
Date:   Mon, 11 May 2020 13:32:34 +0200
Message-Id: <20200511113234.80722-1-mcroce@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

GCC 10 is very strict about symbol clash, and lwt_len_hist_user contains
a symbol which clashes with libbpf:

/usr/bin/ld: samples/bpf/lwt_len_hist_user.o:(.bss+0x0): multiple definition of `bpf_log_buf'; samples/bpf/bpf_load.o:(.bss+0x8c0): first defined here
collect2: error: ld returned 1 exit status

bpf_log_buf here seems to be a leftover, so removing it.

Signed-off-by: Matteo Croce <mcroce@redhat.com>
---
 samples/bpf/lwt_len_hist_user.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/samples/bpf/lwt_len_hist_user.c b/samples/bpf/lwt_len_hist_user.c
index 587b68b1f8dd..430a4b7e353e 100644
--- a/samples/bpf/lwt_len_hist_user.c
+++ b/samples/bpf/lwt_len_hist_user.c
@@ -15,8 +15,6 @@
 #define MAX_INDEX 64
 #define MAX_STARS 38
 
-char bpf_log_buf[BPF_LOG_BUF_SIZE];
-
 static void stars(char *str, long val, long max, int width)
 {
 	int i;
-- 
2.26.2

