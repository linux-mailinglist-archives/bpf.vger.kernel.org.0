Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E749A2CED94
	for <lists+bpf@lfdr.de>; Fri,  4 Dec 2020 12:54:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730130AbgLDLxm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Dec 2020 06:53:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:31029 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730135AbgLDLxl (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 4 Dec 2020 06:53:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607082734;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IK/QJ/mwWf6qYNme1m53SvUyoc+tECiyzDRKMtRU8jo=;
        b=Sjlujd57bh8FzQpguB/8lHFDAidt/KIjok2eG5p2vtn4wRmKtomTcciZ0+avcoPvNXukJP
        l+zXMtSgy6ll+hHlMkXCFOOLRyqf2sb+S6nODUrk+zjsUSs3K4temFmD5LeFvsMUNP4pDG
        8dD+jSGMZ8NAJpJgDIzFPufVDLt9RtM=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-48-WNHGLF_nOnCrX9InBfsQNg-1; Fri, 04 Dec 2020 06:52:13 -0500
X-MC-Unique: WNHGLF_nOnCrX9InBfsQNg-1
Received: by mail-ed1-f72.google.com with SMTP id bc27so2256614edb.18
        for <bpf@vger.kernel.org>; Fri, 04 Dec 2020 03:52:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=IK/QJ/mwWf6qYNme1m53SvUyoc+tECiyzDRKMtRU8jo=;
        b=tMkshQckWWV1/RD+g5czDH3oaFV9Jy5tNRzV0sxtrXAkIkyTYCg6fZD8/F88xSuyPO
         90G7Lk7o6+kc87CovaMI5HfE8bwtPAHOjqwu5ZBnWAsA6O5xI14OHzcC7Fg4zM//9aoK
         DULBQJRcc0kx6Shmk7lau3y1e+NnTOAmwhg9yqXZqDW6I7Wvmzwyfci7K8b+xRy7ZtbC
         u+6uTjiMBAiC2GvRYEr2t1x8hVSmRUFr6PxLEfJG7KfdIYjbkJWzZ7QFBfkbWdgY66hP
         z48xPvcFl3Ie/YmzcXCwfkkfLaCrt9J3VIgPH2mKDwQA/BXmgROyCPFByV6bn/J9o4Vq
         PXOQ==
X-Gm-Message-State: AOAM531fNThKMsXVM64Uy73+56CVjBtyTtyryIagT/yjvXe1+u7Qv2+x
        p4q5Pv35OUWYC9cjdMN4qZ/ytiNjWKCGjhfHBHntyDFpEmPfVFfQQ20pBqvuJ8QLIe9rPLyohfp
        is4COB5VkM/s7
X-Received: by 2002:a17:906:e082:: with SMTP id gh2mr6434428ejb.406.1607082731593;
        Fri, 04 Dec 2020 03:52:11 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwJnmnrQQFUZtCpPBo0okVYdCn+4YqUFrQtfBWBO5pOeK9MIHcNI5YMcL0nBkzararsSM8lqA==
X-Received: by 2002:a17:906:e082:: with SMTP id gh2mr6434391ejb.406.1607082731155;
        Fri, 04 Dec 2020 03:52:11 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id e12sm3344289edm.48.2020.12.04.03.52.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 03:52:10 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id C9F751843EC; Fri,  4 Dec 2020 12:52:08 +0100 (CET)
Subject: [PATCH bpf v2 6/7] selftests/bpf/test_offload.py: reset ethtool
 features after failed setting
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
Date:   Fri, 04 Dec 2020 12:52:08 +0100
Message-ID: <160708272873.192754.13552481233579004069.stgit@toke.dk>
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

When setting the ethtool feature flag fails (as expected for the test), the
kernel now tracks that the feature was requested to be 'off' and refuses to
subsequently disable it again. So reset it back to 'on' so a subsequent
disable (that's not supposed to fail) can succeed.

Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 tools/testing/selftests/bpf/test_offload.py |    1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/bpf/test_offload.py b/tools/testing/selftests/bpf/test_offload.py
index 51a5e4d939cc..2128fbd8414b 100755
--- a/tools/testing/selftests/bpf/test_offload.py
+++ b/tools/testing/selftests/bpf/test_offload.py
@@ -946,6 +946,7 @@ try:
     start_test("Test disabling TC offloads is rejected while filters installed...")
     ret, _ = sim.set_ethtool_tc_offloads(False, fail=False)
     fail(ret == 0, "Driver should refuse to disable TC offloads with filters installed...")
+    sim.set_ethtool_tc_offloads(True)
 
     start_test("Test qdisc removal frees things...")
     sim.tc_flush_filters()

