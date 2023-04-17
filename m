Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33F316E4C39
	for <lists+bpf@lfdr.de>; Mon, 17 Apr 2023 16:59:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbjDQO7w (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 17 Apr 2023 10:59:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231168AbjDQO7a (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 17 Apr 2023 10:59:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5E78BB9B
        for <bpf@vger.kernel.org>; Mon, 17 Apr 2023 07:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681743428;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=h3iGQcB3e7F3+oGwghn9gsZP1jI84iVAMvZuMJ+erzM=;
        b=NqWPmMovoWUY7pRCxay0as3hOqrK8Dx57MDcwqJEom/iWEmk8hjr2qg+7XH+ULLL4JZ83Q
        iZt3N0g57ymWE5DA49CRkzw9L70b16aU9xhOoxoz1Tj5gIqYbwhNLq5+VguAwKCpmxGPgU
        5Zw79itUj72p4lXeapoHIWDQMf15yRA=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-532-M2QY-31ONNC_ldxX-K4nqA-1; Mon, 17 Apr 2023 10:57:05 -0400
X-MC-Unique: M2QY-31ONNC_ldxX-K4nqA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 458671C0907B;
        Mon, 17 Apr 2023 14:57:04 +0000 (UTC)
Received: from firesoul.localdomain (unknown [10.45.242.22])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C20DB7D283;
        Mon, 17 Apr 2023 14:57:03 +0000 (UTC)
Received: from [10.1.1.1] (localhost [IPv6:::1])
        by firesoul.localdomain (Postfix) with ESMTP id CCAAE307372E8;
        Mon, 17 Apr 2023 16:57:02 +0200 (CEST)
Subject: [PATCH bpf-next V1 0/5] XDP-hints: XDP kfunc metadata for driver igc
From:   Jesper Dangaard Brouer <brouer@redhat.com>
To:     bpf@vger.kernel.org, Stanislav Fomichev <sdf@google.com>,
        =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Cc:     Jesper Dangaard Brouer <brouer@redhat.com>, netdev@vger.kernel.org,
        martin.lau@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        alexandr.lobakin@intel.com, larysa.zaremba@intel.com,
        xdp-hints@xdp-project.net, yoong.siang.song@intel.com,
        intel-wired-lan@lists.osuosl.org, pabeni@redhat.com,
        jesse.brandeburg@intel.com, kuba@kernel.org, edumazet@google.com,
        john.fastabend@gmail.com, hawk@kernel.org, davem@davemloft.net
Date:   Mon, 17 Apr 2023 16:57:02 +0200
Message-ID: <168174338054.593471.8312147519616671551.stgit@firesoul>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Implement both RX hash and RX timestamp XDP hints kfunc metadata
for driver igc.

First patch fix RX hashing for igc in general.

Last patch change test program xdp_hw_metadata to track more
timestamps, which helps us correlate the hardware RX timestamp
with something.

---
To maintainers: I'm uncertain which git tree this should be sent
against. This is primary NIC driver code (net-next), but it's
BPF/XDP related (bpf-next) via xdp_metadata_ops.


Jesper Dangaard Brouer (5):
      igc: enable and fix RX hash usage by netstack
      igc: add igc_xdp_buff wrapper for xdp_buff in driver
      igc: add XDP hints kfuncs for RX timestamp
      igc: add XDP hints kfuncs for RX hash
      selftests/bpf: xdp_hw_metadata track more timestamps


 drivers/net/ethernet/intel/igc/igc.h          |  35 ++++++
 drivers/net/ethernet/intel/igc/igc_main.c     | 116 ++++++++++++++++--
 .../selftests/bpf/progs/xdp_hw_metadata.c     |   4 +-
 tools/testing/selftests/bpf/xdp_hw_metadata.c |  47 ++++++-
 tools/testing/selftests/bpf/xdp_metadata.h    |   1 +
 5 files changed, 186 insertions(+), 17 deletions(-)

--

