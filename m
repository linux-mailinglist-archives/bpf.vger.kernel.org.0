Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4097A2D43F7
	for <lists+bpf@lfdr.de>; Wed,  9 Dec 2020 15:11:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbgLIOI6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Dec 2020 09:08:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59328 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732385AbgLIOIe (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 9 Dec 2020 09:08:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607522828;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rdg7j0aoyv9xFKjTcy/3BS13uPnBUVbkHjhjaK6AxE0=;
        b=I6h6SWYXZIpcFjnNgICf8Bq700BbcqXbmKYEZ+x4C9qRIj7lcwk8n3aetg3ztKvP475jLw
        Qa79/oFLaXAT4pDadKQI59xdFC9b7SkzCDKPUNKY1o47GXtoQPpeHSTu5EEMrIuwihTmop
        psV3WmTMYhNtpTmRPCfecl6RReMvmLw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-163-StnI1pStPBaelk95I_ASZw-1; Wed, 09 Dec 2020 09:07:05 -0500
X-MC-Unique: StnI1pStPBaelk95I_ASZw-1
Received: by mail-wr1-f70.google.com with SMTP id 91so697028wrk.17
        for <bpf@vger.kernel.org>; Wed, 09 Dec 2020 06:07:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=rdg7j0aoyv9xFKjTcy/3BS13uPnBUVbkHjhjaK6AxE0=;
        b=RP1ZI0n+V8wLgAMnwY9QF8EBBSI1c/GgIx0nLSB4tTBMWAQC3thfd0VvSB/+rOKwTh
         tWIlX1uYs3d8ByXs5tf3U4mIhvfLUys22KtGThw1wk0C6AphI5JA9w9xXymmIcTrC9i4
         eiYHQvA1Qqt91v7l1GBRsMiyzq9i+SRwEmhub4FKeP0jvpZiVra6YH3tgza5yoetbkpR
         IfUS4XEkbbc7ZuZTv8hAM7nq6u5zs8QjgGzRmZbL1I8VDlD/7Swmm75qGZlTPJclAteN
         OIH0+Vi8ndulLSxom4HCbP5sd9RURymPvmL3aQZASyxTUlPzFYB97akeh5Ux69SIsvpj
         5kCw==
X-Gm-Message-State: AOAM532KtMjbRv36+UYZYOKmujJnZPft1rTMWZSAhfo2aFGSpsyoq1np
        cgKb1vzCCLpZLYg+lIMdA2CImhFvk79XDjSIPxGqU1HGVC+cjZ0AW2zFpKAbaYUo5RhDvrcGQMO
        xb8DqgfZTZoiy
X-Received: by 2002:a1c:46c5:: with SMTP id t188mr3013061wma.3.1607522823812;
        Wed, 09 Dec 2020 06:07:03 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx+Ew79AWAb2eVVXBNYJt577k9hNL/BcjdQGZ+/GFKRTnBKgZn2s6FjYBgEED9OemSjK1JRAA==
X-Received: by 2002:a1c:46c5:: with SMTP id t188mr3013003wma.3.1607522823228;
        Wed, 09 Dec 2020 06:07:03 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id g192sm3570968wme.48.2020.12.09.06.07.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 06:07:02 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id E2915180004; Wed,  9 Dec 2020 14:57:43 +0100 (CET)
Subject: [PATCH bpf v4 7/7] selftests/bpf/test_offload.py: filter bpftool
 internal map when counting maps
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
Date:   Wed, 09 Dec 2020 14:57:43 +0100
Message-ID: <160752226387.110217.9887866138149423444.stgit@toke.dk>
In-Reply-To: <160752225643.110217.4104692937165406635.stgit@toke.dk>
References: <160752225643.110217.4104692937165406635.stgit@toke.dk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Toke Høiland-Jørgensen <toke@redhat.com>

A few of the tests in test_offload.py expects to see a certain number of
maps created, and checks this by counting the number of maps returned by
bpftool. There is already a filter that will remove any maps already there
at the beginning of the test, but bpftool now creates a map for the PID
iterator rodata on each invocation, which makes the map count wrong. Fix
this by also filtering the pid_iter.rodata map by name when counting.

Fixes: d53dee3fe013 ("tools/bpftool: Show info for processes holding BPF map/prog/link/btf FDs")
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 tools/testing/selftests/bpf/test_offload.py |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_offload.py b/tools/testing/selftests/bpf/test_offload.py
index 2128fbd8414b..b99bb8ed3ed4 100755
--- a/tools/testing/selftests/bpf/test_offload.py
+++ b/tools/testing/selftests/bpf/test_offload.py
@@ -184,9 +184,7 @@ def bpftool_prog_list(expected=None, ns=""):
 def bpftool_map_list(expected=None, ns=""):
     _, maps = bpftool("map show", JSON=True, ns=ns, fail=True)
     # Remove the base maps
-    for m in base_maps:
-        if m in maps:
-            maps.remove(m)
+    maps = [m for m in maps if m not in base_maps and m.get('name') not in base_map_names]
     if expected is not None:
         if len(maps) != expected:
             fail(True, "%d BPF maps loaded, expected %d" %
@@ -770,6 +768,9 @@ ret, progs = bpftool("prog", fail=False)
 skip(ret != 0, "bpftool not installed")
 base_progs = progs
 _, base_maps = bpftool("map")
+base_map_names = [
+    'pid_iter.rodata' # created on each bpftool invocation
+]
 
 # Check netdevsim
 ret, out = cmd("modprobe netdevsim", fail=False)

