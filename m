Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4572B87F0A
	for <lists+bpf@lfdr.de>; Fri,  9 Aug 2019 18:10:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407411AbfHIQKl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 9 Aug 2019 12:10:41 -0400
Received: from mail-qt1-f201.google.com ([209.85.160.201]:47614 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726490AbfHIQKl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 9 Aug 2019 12:10:41 -0400
Received: by mail-qt1-f201.google.com with SMTP id s9so89312787qtn.14
        for <bpf@vger.kernel.org>; Fri, 09 Aug 2019 09:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=Rlwks2ipCMMHTWuuc/0daFgqcPBRnGzn67xoeH5SLoE=;
        b=RtD6ftucSKfwfoAs2Otr2GgUw9iABu+CPWRRGb5VIv9vL599BzkmAug4vqNqmM1bBj
         K/s54iFPUMLV68vtto4ScZ8sgWWo1YQN/VGHCsDMXfM62ZiU0ytc2PUVOVr4Ml9RrNO+
         ez+tWs74XFsfZowEErk5OB7f1BG3KOBEwzgLX5vbZgAGSygy5ioK7urbb934Me6YhpEn
         sJ7m/t4q7uoe936kLYga2Xu+F66CjckiBhfNGeK0JbK9uiya/qaLdld/9KL7XAeIT/Tw
         hhEDFadiV9p1pXYFesght/Hq08AABMybwL6flNko7mUWRqFROlEXYjL5/0oSpAci2RkO
         lpEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=Rlwks2ipCMMHTWuuc/0daFgqcPBRnGzn67xoeH5SLoE=;
        b=eZl5NDwVN5hYkR1Xkw2SeCCpOT1AL06IWrtt4B1FT+rffyG+CC4w9qOlWPmOv4vril
         ySXuqHQrPCIQE5yaf9VMi484FOd+374R7GW63C4kHdmIZs4FoyyJ3dD/5q/ZTN0QV3Ih
         Sb3BHBkgoogCXZXSGRsTFgAx3Is9ovR0P+wlp8Fu5sY3SvQ34pJhv9b1FqHEybTfjnYh
         EUCtFeizdhGZoci+/zBiJ9mT5zQCBW5UVajmRlG8wUrAIKrbl7a9taHUvCyB8momBXE5
         mdfM2ZToH4n/N++CFwRzhRjHRH8jTK9MR3CjRjGyBmUBC3sFVXfYHkXmmgmcBQOOQX8u
         5HmQ==
X-Gm-Message-State: APjAAAUIliDMf37O/HGl1n+GmFSkpE9LMrxu+DhLJc+L1UjCqKHr7gi9
        PuiR7UYadHY1YqUrT8NrWR7mPoE=
X-Google-Smtp-Source: APXvYqwsTIbT4sbw5O+zmwokwI/h9Upaz9F3JQmrT3/rbVURRPtk+iw+dNegZwJ1erCostY2fPt3VVk=
X-Received: by 2002:a05:620a:143b:: with SMTP id k27mr18154715qkj.426.1565367040393;
 Fri, 09 Aug 2019 09:10:40 -0700 (PDT)
Date:   Fri,  9 Aug 2019 09:10:34 -0700
Message-Id: <20190809161038.186678-1-sdf@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
Subject: [PATCH bpf-next v2 0/4] bpf: support cloning sk storage on accept()
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>,
        Martin KaFai Lau <kafai@fb.com>, Yonghong Song <yhs@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Currently there is no way to propagate sk storage from the listener
socket to a newly accepted one. Consider the following use case:

        fd = socket();
        setsockopt(fd, SOL_IP, IP_TOS,...);
        /* ^^^ setsockopt BPF program triggers here and saves something
         * into sk storage of the listener.
         */
        listen(fd, ...);
        while (client = accept(fd)) {
                /* At this point all association between listener
                 * socket and newly accepted one is gone. New
                 * socket will not have any sk storage attached.
                 */
        }

Let's add new BPF_F_CLONE flag that can be specified when creating
a socket storage map. This new flag indicates that map contents
should be cloned when the socket is cloned.

v2:
* remove spinlocks around selem_link_map/sk (Martin KaFai Lau)
* BPF_F_CLONE on a map, not selem (Martin KaFai Lau)
* hold a map while cloning (Martin KaFai Lau)
* use BTF maps in selftests (Yonghong Song)
* do proper cleanup selftests; don't call close(-1) (Yonghong Song)
* export bpf_map_inc_not_zero

Cc: Martin KaFai Lau <kafai@fb.com>
Cc: Yonghong Song <yhs@fb.com>

Stanislav Fomichev (4):
  bpf: export bpf_map_inc_not_zero
  bpf: support cloning sk storage on accept()
  bpf: sync bpf.h to tools/
  selftests/bpf: add sockopt clone/inheritance test

 include/linux/bpf.h                           |   2 +
 include/net/bpf_sk_storage.h                  |  10 +
 include/uapi/linux/bpf.h                      |   3 +
 kernel/bpf/syscall.c                          |  16 +-
 net/core/bpf_sk_storage.c                     | 100 ++++++-
 net/core/sock.c                               |   9 +-
 tools/include/uapi/linux/bpf.h                |   3 +
 tools/testing/selftests/bpf/.gitignore        |   1 +
 tools/testing/selftests/bpf/Makefile          |   3 +-
 .../selftests/bpf/progs/sockopt_inherit.c     |  97 +++++++
 .../selftests/bpf/test_sockopt_inherit.c      | 253 ++++++++++++++++++
 11 files changed, 487 insertions(+), 10 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/sockopt_inherit.c
 create mode 100644 tools/testing/selftests/bpf/test_sockopt_inherit.c

-- 
2.23.0.rc1.153.gdeed80330f-goog
