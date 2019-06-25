Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0475C51F9A
	for <lists+bpf@lfdr.de>; Tue, 25 Jun 2019 02:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729133AbfFYANx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 24 Jun 2019 20:13:53 -0400
Received: from mail-vs1-f74.google.com ([209.85.217.74]:35843 "EHLO
        mail-vs1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726453AbfFYANb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 24 Jun 2019 20:13:31 -0400
Received: by mail-vs1-f74.google.com with SMTP id j77so4394545vsd.3
        for <bpf@vger.kernel.org>; Mon, 24 Jun 2019 17:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=Q0hyqVzuncQMFkIZhAOHJkIfbxm5sDRWMvyBXtcavoo=;
        b=EssshDt/dlH+w3otVcXsWVrkwsJGAEYnRZomAA2SB8qG/Igf+gZ+Yj3LwaIyfQ+jTJ
         yZyJOFE5cqme7ibfp2WTeYILLR/Eq3LafVKKg36FAfr0rZ0zjaRRfvHudE5wa7UimQYV
         HkJr+bRcOM4asjgjGlsGVfVmMhz2WroL/8+MSe/pjIy+MSyRaLtdC1vLU7xt2FLgAbd8
         f9oP8cnro7VlgAtgCGyFmly/+lk9rLMPYRrltq92XkAexvCpDl/XhrAku4YXDNJB9kcf
         VyY2P6cHBv0xzRRb/oyueFu/ELftH6aNCIaibDzCjQkh/Fe1azRI7GgxFS6mU08mapE+
         GHPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=Q0hyqVzuncQMFkIZhAOHJkIfbxm5sDRWMvyBXtcavoo=;
        b=glWlNitCBvcLjhD+gxIJjk8LXCRAGIc3N1B1HbzjLdT+mXa/+WWXAcHHZgasukW5aL
         wxQZU9zr5zxVkae/II+OWYwI789F1Ub5TJJB13ztNiQawqTq7iHNr0b/LWk0O/IwK14Q
         YYnKVdQW0MijjqHFYWhfe9IM8/PjnDqu/89QXnKJV26KxicUD7yq/N7AFHTSAnte8w1y
         Q+R/GZKq/9mcfD+zigkbaoujB14lFGITS9yjpOPq9y/Cq6A5GG1SnfBJxOmH00bvGaWb
         J9jExXCjDwjKdbY0iDXADTRbJagLiZMlYAq3L3rDEFNBSY3uaClxB0Z5XYByBgFerGXe
         dDPg==
X-Gm-Message-State: APjAAAUGKNt/dKznF4jxaX5bGikNLyqTXFtQfgH5X3y4vwFDyRfsbwEv
        L98WQ3FmLVbCNhK5L4ShzswC+s9dXtLj/sub
X-Google-Smtp-Source: APXvYqymD+lJYYlyP2I7bp7SGi9HdcHDJCT5J5n7xkvzEZeLw9Txu07SMJTO5XtuZBxB44z+jN54bvP/ZD3J4c30
X-Received: by 2002:a1f:ec85:: with SMTP id k127mr12749816vkh.92.1561421610156;
 Mon, 24 Jun 2019 17:13:30 -0700 (PDT)
Date:   Mon, 24 Jun 2019 17:13:24 -0700
Message-Id: <20190625001326.172280-1-allanzhang@google.com>
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
