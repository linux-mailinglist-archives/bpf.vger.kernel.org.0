Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9E6E51D82
	for <lists+bpf@lfdr.de>; Mon, 24 Jun 2019 23:58:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730227AbfFXV63 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 24 Jun 2019 17:58:29 -0400
Received: from mail-vk1-f202.google.com ([209.85.221.202]:49849 "EHLO
        mail-vk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730173AbfFXV63 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 24 Jun 2019 17:58:29 -0400
Received: by mail-vk1-f202.google.com with SMTP id o202so6932579vko.16
        for <bpf@vger.kernel.org>; Mon, 24 Jun 2019 14:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=Q0hyqVzuncQMFkIZhAOHJkIfbxm5sDRWMvyBXtcavoo=;
        b=RhTI0VON+5np3cwB/7HOu3t/iTPn2XCK9u35az8zZzqwq33aR1/TRgDApIz75TYjeD
         taeLRalcKhbhPepoAbvK52wnMDZ4a4X4rQyvghiYUBX6lvanbJlq1DeR0k4U1q7eFNYV
         BF+JEeZCIrldZEWNpdVz2IUoRYv+zgxEMD/AiCGhXJwswmAgGA3GeNHqIk31m5cbt2l1
         uwJ2HebPA8Tcrtk5Sq6k1GuOo6rkny49EjlVuC3wxvojrEBmBFbu3QlkfxniDohl6kCZ
         KUcCvCDfB5huDAVj39axpBOZIQ0XycHOBqagQKH8BqMaTmCzE2FHM+KvrEaKpSm4zON1
         p9Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=Q0hyqVzuncQMFkIZhAOHJkIfbxm5sDRWMvyBXtcavoo=;
        b=ozkre1OUqAWXy+fOi5u1xRoIT+QwsVYbDDvL6IoKKt+HVsvSg0tL9ZbuShzo1jvYAP
         Zdr3TR5gtEoTpYiokKbWZYetY+UYPsEH3QHDNqxqyva+cOCb+aJfHTVzKqZwishrU3v9
         hujv/BmQriSb0ussuY5+A463V2ux3uTcRQERi2V7SCtkmKWt+87xGG0//AVupUdftqRm
         o+v4uVt8coAPa2NpuSYvPcmR/jF0Y1icMxnBvYPAkcNJXeRh6/QMZl/+gJj+BVE8ejxJ
         82TKKxSuGPb6+JzR8Ha6xkgGY+MDgKps/8X02iGCjZ2GlLa4Jo6TCeUB4XqiIC9Ne0Vj
         89hA==
X-Gm-Message-State: APjAAAVB51ylIWf+bx3/D6c2Qe0TMc7kJ+Dy0H+9YIQEJMKAvnzG71qO
        JbKZ5UZQk9RTqXUAP+oCa1lzWh4xPFfXFuMY
X-Google-Smtp-Source: APXvYqysClsnN/4Bk4V5HqW6LruC+5/Q9jhmidRxur/KiP8HrehrQutBwAy9P5+/J7jI4WPt5SLBO8hZ4T+vVzyY
X-Received: by 2002:a1f:4107:: with SMTP id o7mr4981084vka.34.1561413508074;
 Mon, 24 Jun 2019 14:58:28 -0700 (PDT)
Date:   Mon, 24 Jun 2019 14:58:22 -0700
Message-Id: <20190624215824.118783-1-allanzhang@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH] bpf: Allow bpf_skb_event_output for a few prog types
From:   allanzhang <allanzhang@google.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     allanzhang <allanzhang@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Software event output is only enabled by a few prog types right now (TC,
LWT out, XDP, sockops). Many other skb based prog types need
bpf_skb_event_output to produce software event.

Added socket_filter, cg_skb, sk_skb prog types to generate sw event.

Test bpf code is generated from code snippet:

struct TMP {
    uint64_t tmp;
} tt;
tt.tmp = 5;
bpf_perf_event_output(skb, &connection_tracking_event_map, 0,
                      &tt, sizeof(tt));
return 1;

the bpf assembly from llvm is:
       0:       b7 02 00 00 05 00 00 00         r2 = 5
       1:       7b 2a f8 ff 00 00 00 00         *(u64 *)(r10 - 8) = r2
       2:       bf a4 00 00 00 00 00 00         r4 = r10
       3:       07 04 00 00 f8 ff ff ff         r4 += -8
       4:       18 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00    r2 = 0ll
       6:       b7 03 00 00 00 00 00 00         r3 = 0
       7:       b7 05 00 00 08 00 00 00         r5 = 8
       8:       85 00 00 00 19 00 00 00         call 25
       9:       b7 00 00 00 01 00 00 00         r0 = 1
      10:       95 00 00 00 00 00 00 00         exit

Patch 1 is enabling code.
Patch 2 is fullly covered selftest code.

Signed-off-by: allanzhang <allanzhang@google.com>
