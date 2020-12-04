Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D82182CED8B
	for <lists+bpf@lfdr.de>; Fri,  4 Dec 2020 12:54:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730111AbgLDLxi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Dec 2020 06:53:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:54047 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730126AbgLDLxi (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 4 Dec 2020 06:53:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607082731;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lUl3YRxLzhPFlWGiTKmymWpaAC8KhJLCEwifVZuc7JU=;
        b=a2UJscbar5JqjKJHQQbLFS3TVX08BPZisYSNZOCNjgUF/5VG+vBEBdhVs4uNzZje73ygre
        tJJlP6X/7wetkNePLrk9ShxhdiAu3iRHp2IhXxi0UWqJUEY+6efmmcljs71gWTQYQ6VmXu
        m/ahlJS1V6VLW2DSa9jC440eR2f861w=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-248-G4xq-_JwP8Sp-ZeNDlISYA-1; Fri, 04 Dec 2020 06:52:10 -0500
X-MC-Unique: G4xq-_JwP8Sp-ZeNDlISYA-1
Received: by mail-ed1-f72.google.com with SMTP id e11so1338667edn.11
        for <bpf@vger.kernel.org>; Fri, 04 Dec 2020 03:52:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=lUl3YRxLzhPFlWGiTKmymWpaAC8KhJLCEwifVZuc7JU=;
        b=psxBOF4FtffAr9SjRlp3bsjfspryWf4bwCu5Fc0Elgt/HPlMPNgUQ8z3/etXC9fC60
         adJB1fmFEzvP9vdLlTCmQPJnIFUsx49xvVibPQuPcuXIVHcOJ8D4S8RRHuTEl1w3BUmo
         IcxKtdiaZnJ/9KpH/hS9c9Vvqnv4JDsEC29fPWpaqP3QOoMwlpVLyT1R6h83jY4eIPt6
         JfyTA1r0oobYxeDn98OgK1WzyS8/nn9MeimCC9N+gBalU9qMYQpOVj0V/k5WoQySNw5l
         i5U3VY+HVNSUWQhNkz9jtS5/0qnTxLC2gTIGdUkkgNgJqxf4TEtUKrlACONafu4l3Fxw
         O8Cg==
X-Gm-Message-State: AOAM530hgIolNc+o/xxRFpuOPe8h/ZcRo13wo/vaZfUftfshQPh7Mhgy
        wPHROCVVBFQ6bn7naBBPzYGGNzFnE083S4YjBL3vq92fR4PUi65CzAbcR7FF4u8ue/s8TaVSKYS
        Ln8FoIgAs4czB
X-Received: by 2002:a17:906:fa13:: with SMTP id lo19mr6557293ejb.455.1607082728847;
        Fri, 04 Dec 2020 03:52:08 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxUwamXPIM/hd9eQ9ABpikH6bLI4zA+3HPcf7B32GCuXGObxGAEHI2EWUJuzvjPjmEKe00wSw==
X-Received: by 2002:a17:906:fa13:: with SMTP id lo19mr6557267ejb.455.1607082728644;
        Fri, 04 Dec 2020 03:52:08 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id h16sm2985869eji.110.2020.12.04.03.52.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 03:52:08 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id B28D81843EC; Fri,  4 Dec 2020 12:52:07 +0100 (CET)
Subject: [PATCH bpf v2 5/7] selftests/bpf/test_offload.py: fix expected case
 of extack messages
From:   =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Romain Perier <romain.perier@gmail.com>,
        Allen Pais <apais@linux.microsoft.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Simon Horman <simon.horman@netronome.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        Jiri Benc <jbenc@redhat.com>, oss-drivers@netronome.com,
        linux-omap@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Date:   Fri, 04 Dec 2020 12:52:07 +0100
Message-ID: <160708272763.192754.5153087321106504338.stgit@toke.dk>
In-Reply-To: <160708272217.192754.14019805999368221369.stgit@toke.dk>
References: <160708272217.192754.14019805999368221369.stgit@toke.dk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Toke Høiland-Jørgensen <toke@redhat.com>

Commit 7f0a838254bd ("bpf, xdp: Maintain info on attached XDP BPF programs
in net_device") changed the case of some of the extack messages being
returned when attaching of XDP programs failed. This broke test_offload.py,
so let's fix the test to reflect this.

Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 tools/testing/selftests/bpf/test_offload.py |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_offload.py b/tools/testing/selftests/bpf/test_offload.py
index 61527b43f067..51a5e4d939cc 100755
--- a/tools/testing/selftests/bpf/test_offload.py
+++ b/tools/testing/selftests/bpf/test_offload.py
@@ -1004,7 +1004,7 @@ try:
                               fail=False, include_stderr=True)
     fail(ret == 0, "Replaced XDP program with a program in different mode")
     check_extack(err,
-                 "native and generic XDP can't be active at the same time.",
+                 "Native and generic XDP can't be active at the same time.",
                  args)
 
     start_test("Test MTU restrictions...")
@@ -1035,7 +1035,7 @@ try:
     offload = bpf_pinned("/sys/fs/bpf/offload")
     ret, _, err = sim.set_xdp(offload, "drv", fail=False, include_stderr=True)
     fail(ret == 0, "attached offloaded XDP program to drv")
-    check_extack(err, "using device-bound program without HW_MODE flag is not supported.", args)
+    check_extack(err, "Using device-bound program without HW_MODE flag is not supported.", args)
     rm("/sys/fs/bpf/offload")
     sim.wait_for_flush()
 

