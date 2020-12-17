Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 392902DD61F
	for <lists+bpf@lfdr.de>; Thu, 17 Dec 2020 18:29:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728837AbgLQR14 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Dec 2020 12:27:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42901 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727857AbgLQR14 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 17 Dec 2020 12:27:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608225989;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=BM1F0PE8lpiUbd2bfhs+wn8dNdpgXKJpmrHOKmIZMTA=;
        b=dKff9kjaowsASo7MFm4/4dBILikKvPzpJhgg/fDojQmWEln3G9VHRPFqcoGCCgt0Iq71RK
        JNUyIStVaA+0oaxAdmT3rTqA9tYPtKRPYmL9pBmz/M6ApXqQYQoAjd+95dhzelDnjT/vZd
        2fQ7h4ZHtFsP6k14RKxMoze0uONr8J0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-517-JlmB7X3DNpO55ipV5_lqkw-1; Thu, 17 Dec 2020 12:26:25 -0500
X-MC-Unique: JlmB7X3DNpO55ipV5_lqkw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E043D107ACE4;
        Thu, 17 Dec 2020 17:26:21 +0000 (UTC)
Received: from firesoul.localdomain (unknown [10.40.208.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7A6422C159;
        Thu, 17 Dec 2020 17:26:16 +0000 (UTC)
Received: from [192.168.42.3] (localhost [IPv6:::1])
        by firesoul.localdomain (Postfix) with ESMTP id 6865A32138454;
        Thu, 17 Dec 2020 18:26:15 +0100 (CET)
Subject: [PATCH bpf-next V9 0/7] bpf: New approach for BPF MTU handling
From:   Jesper Dangaard Brouer <brouer@redhat.com>
To:     bpf@vger.kernel.org
Cc:     Jesper Dangaard Brouer <brouer@redhat.com>, netdev@vger.kernel.org,
        Daniel Borkmann <borkmann@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        maze@google.com, lmb@cloudflare.com, shaun@tigera.io,
        Lorenzo Bianconi <lorenzo@kernel.org>, marek@cloudflare.com,
        John Fastabend <john.fastabend@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>, eyal.birger@gmail.com,
        colrack@gmail.com
Date:   Thu, 17 Dec 2020 18:26:15 +0100
Message-ID: <160822594178.3481451.1208057539613401103.stgit@firesoul>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patchset drops all the MTU checks in TC BPF-helpers that limits
growing the packet size. This is done because these BPF-helpers doesn't
take redirect into account, which can result in their MTU check being done
against the wrong netdev.

The new approach is to give BPF-programs knowledge about the MTU on a
netdev (via ifindex) and fib route lookup level. Meaning some BPF-helpers
are added and extended to make it possible to do MTU checks in the
BPF-code.

If BPF-prog doesn't comply with the MTU then the packet will eventually
get dropped as some other layer. In some cases the existing kernel MTU
checks will drop the packet, but there are also cases where BPF can bypass
these checks. Specifically doing TC-redirect from ingress step
(sch_handle_ingress) into egress code path (basically calling
dev_queue_xmit()). It is left up to driver code to handle these kind of
MTU violations.

One advantage of this approach is that it ingress-to-egress BPF-prog can
send information via packet data. With the MTU checks removed in the
helpers, and also not done in skb_do_redirect() call, this allows for an
ingress BPF-prog to communicate with an egress BPF-prog via packet data,
as long as egress BPF-prog remove this prior to transmitting packet.

This patchset is primarily focused on TC-BPF, but I've made sure that the
MTU BPF-helpers also works for XDP BPF-programs.

V2: Change BPF-helper API from lookup to check.
V3: Drop enforcement of MTU in net-core, leave it to drivers.
V4: Keep sanity limit + netdev "up" checks + rename BPF-helper.
V5: Fix uninit variable + name struct output member mtu_result.
V6: Use bpf_check_mtu() in selftest
V7: Fix logic using tot_len and add another selftest
V8: Add better selftests for BPF-helper bpf_check_mtu
V9: Remove patch that use skb_set_redirected

---

Jesper Dangaard Brouer (7):
      bpf: Remove MTU check in __bpf_skb_max_len
      bpf: fix bpf_fib_lookup helper MTU check for SKB ctx
      bpf: bpf_fib_lookup return MTU value as output when looked up
      bpf: add BPF-helper for MTU checking
      bpf: drop MTU check when doing TC-BPF redirect to ingress
      selftests/bpf: use bpf_check_mtu in selftest test_cls_redirect
      bpf/selftests: tests using bpf_check_mtu BPF-helper


 include/linux/netdevice.h                          |   31 +++
 include/uapi/linux/bpf.h                           |   78 +++++++-
 net/core/dev.c                                     |   19 --
 net/core/filter.c                                  |  184 ++++++++++++++++--
 tools/include/uapi/linux/bpf.h                     |   78 +++++++-
 tools/testing/selftests/bpf/prog_tests/check_mtu.c |  204 ++++++++++++++++++++
 tools/testing/selftests/bpf/progs/test_check_mtu.c |  196 +++++++++++++++++++
 .../selftests/bpf/progs/test_cls_redirect.c        |    7 +
 8 files changed, 754 insertions(+), 43 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/check_mtu.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_check_mtu.c

--

