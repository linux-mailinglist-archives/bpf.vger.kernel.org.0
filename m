Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8F6E31EA58
	for <lists+bpf@lfdr.de>; Thu, 18 Feb 2021 14:17:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231609AbhBRNQk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 18 Feb 2021 08:16:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41036 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230315AbhBRLv2 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 18 Feb 2021 06:51:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613649001;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=bfx4uOIYBbffRNq4QrTFg2f7wSMAvvhECfB/otGbxHo=;
        b=em1ZgghdOz4EbRE8lHyftcORtguSl9Hf+vk3R5AM/3AYkEZBuJZpUeVyhDbZkLmSjPLNpU
        ivYDpU6AUOp6o8vqhyj5zgMS2JVLo4pTBFvGS/iUiVI4tFVuXeG4LZDBm6AsSenG3BE7oU
        rbvlK/jwlte7dFKCWk/4TTLh1Iyqfrs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-15-TZDH2S9rNJ-lVV_tiqbbgQ-1; Thu, 18 Feb 2021 06:49:59 -0500
X-MC-Unique: TZDH2S9rNJ-lVV_tiqbbgQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2977C835E22;
        Thu, 18 Feb 2021 11:49:58 +0000 (UTC)
Received: from firesoul.localdomain (unknown [10.40.208.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C9E995C1C4;
        Thu, 18 Feb 2021 11:49:54 +0000 (UTC)
Received: from [192.168.42.3] (localhost [IPv6:::1])
        by firesoul.localdomain (Postfix) with ESMTP id 86C4830736C73;
        Thu, 18 Feb 2021 12:49:53 +0100 (CET)
Subject: [PATCH bpf-next V2 0/2] bpf: Updates for BPF-helper bpf_check_mtu
From:   Jesper Dangaard Brouer <brouer@redhat.com>
To:     bpf@vger.kernel.org
Cc:     Jesper Dangaard Brouer <brouer@redhat.com>, netdev@vger.kernel.org,
        Daniel Borkmann <borkmann@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 18 Feb 2021 12:49:53 +0100
Message-ID: <161364896576.1250213.8059418482723660876.stgit@firesoul>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The FIB lookup example[1] show how the IP-header field tot_len
(iph->tot_len) is used as input to perform the MTU check. The recently
added MTU check helper bpf_check_mtu() should also support this type
of MTU check.

Lets add this feature before merge window, please. This is a followup
to 34b2021cc616 ("bpf: Add BPF-helper for MTU checking").

[1] samples/bpf/xdp_fwd_kern.c

V2: Fixed spelling and added ACKs from John
---

Jesper Dangaard Brouer (2):
      bpf: BPF-helper for MTU checking add length input
      selftests/bpf: Tests using bpf_check_mtu BPF-helper input mtu_len param


 include/uapi/linux/bpf.h                           |   17 ++--
 net/core/filter.c                                  |   12 ++-
 tools/testing/selftests/bpf/prog_tests/check_mtu.c |    4 +
 tools/testing/selftests/bpf/progs/test_check_mtu.c |   92 ++++++++++++++++++++
 4 files changed, 117 insertions(+), 8 deletions(-)

--

