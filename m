Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27B472CE0DD
	for <lists+bpf@lfdr.de>; Thu,  3 Dec 2020 22:37:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389380AbgLCVgz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Dec 2020 16:36:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48714 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387799AbgLCVgz (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 3 Dec 2020 16:36:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607031329;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PTgt64JimZPJAfS0azcJyT5Hi69osAbP/LoiBoFsy8w=;
        b=EWyEmez1lx5rriV7kYf10JqW85m5bWGex25IG6d9swHhBXlbFpxHmj0mor5ZtrdVQGaJuE
        y9adem4HEq3BlHdS2EeuqOyDlk0aiiqucX9TD6Kgud2qiu8x+CYP6aDXnMeEbAoXjQ+7Pi
        PU4OdgrnoVjSRCtoKnDhrWZtoiLY6wg=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-495-j-HW2jBYPuakmrASTpNMjg-1; Thu, 03 Dec 2020 16:35:27 -0500
X-MC-Unique: j-HW2jBYPuakmrASTpNMjg-1
Received: by mail-qt1-f197.google.com with SMTP id f19so2699168qtx.6
        for <bpf@vger.kernel.org>; Thu, 03 Dec 2020 13:35:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=PTgt64JimZPJAfS0azcJyT5Hi69osAbP/LoiBoFsy8w=;
        b=iDLDWw0ctVOZLjw6Yq8fnvUIn4RRE0/z+0lUidWmgpKvdyA968OwwrWsA6zHg/pPwM
         +wayDp1zU/T/f40jgJQHi7o3TIilAVIPEY8daz+nQhj1de98QqC08nH+gtVjK3M0qs6j
         G8FEAfOzBCcl3XAI5ueFNKGz7UthrxLPO5pVlLlpoc79eK/WBdzYQNNSSqrpl5twyYz+
         b60Vs2rnP4UMi6KN6adK/skEnY9p4efzgVSnVb2Re1o53EsdvS+mXLAW78GcMtcd7xLi
         071RQPqKcjFeutVdMEeY1If/mpXIAG1UKyxzV7M87KO3THJPyyJjA28uIxurtc4C2wH3
         +Y0A==
X-Gm-Message-State: AOAM533b/Ae+GFHnKRm1i+e/PsgeIAuUrX/75gACIPutG2t7FYZW1A3o
        GAU6SS+mNP+Nq0sQL3l5uRY6HeTIZ7EH1qqmGfwNq3XCgnGVimJmRq/IZRsdrqQ94W+XCGmV4B1
        JN663TDby3UKw
X-Received: by 2002:a05:620a:10a3:: with SMTP id h3mr5238098qkk.459.1607031326260;
        Thu, 03 Dec 2020 13:35:26 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzy9GQDy+cijqSCW+9W5nUJfm+RHoN1wNqylY2fwJyS9UHaqVAcN4FgNBoHUM9SzN0bMGGmUA==
X-Received: by 2002:a05:620a:10a3:: with SMTP id h3mr5238025qkk.459.1607031325675;
        Thu, 03 Dec 2020 13:35:25 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id f8sm2339143qtp.91.2020.12.03.13.35.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 13:35:24 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 9ED7D1843EF; Thu,  3 Dec 2020 22:35:22 +0100 (CET)
Subject: [PATCH bpf 5/7] selftests/bpf/test_offload.py: fix expected case of
 extack messages
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
Date:   Thu, 03 Dec 2020 22:35:22 +0100
Message-ID: <160703132255.162669.6025526680043801946.stgit@toke.dk>
In-Reply-To: <160703131710.162669.9632344967082582016.stgit@toke.dk>
References: <160703131710.162669.9632344967082582016.stgit@toke.dk>
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
index 6f8ff2f27027..5b0fe8e0b2d2 100755
--- a/tools/testing/selftests/bpf/test_offload.py
+++ b/tools/testing/selftests/bpf/test_offload.py
@@ -998,7 +998,7 @@ try:
                               fail=False, include_stderr=True)
     fail(ret == 0, "Replaced XDP program with a program in different mode")
     check_extack(err,
-                 "native and generic XDP can't be active at the same time.",
+                 "Native and generic XDP can't be active at the same time.",
                  args)
 
     start_test("Test MTU restrictions...")
@@ -1029,7 +1029,7 @@ try:
     offload = bpf_pinned("/sys/fs/bpf/offload")
     ret, _, err = sim.set_xdp(offload, "drv", fail=False, include_stderr=True)
     fail(ret == 0, "attached offloaded XDP program to drv")
-    check_extack(err, "using device-bound program without HW_MODE flag is not supported.", args)
+    check_extack(err, "Using device-bound program without HW_MODE flag is not supported.", args)
     rm("/sys/fs/bpf/offload")
     sim.wait_for_flush()
 

