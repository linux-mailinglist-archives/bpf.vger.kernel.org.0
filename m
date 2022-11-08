Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 561776214F9
	for <lists+bpf@lfdr.de>; Tue,  8 Nov 2022 15:07:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235077AbiKHOHM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Nov 2022 09:07:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235092AbiKHOHH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Nov 2022 09:07:07 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6468770540
        for <bpf@vger.kernel.org>; Tue,  8 Nov 2022 06:06:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667916366;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=mhVuivBI13XN7hFJRIVsKLRsld9h+iIMpKP8ks7YdsA=;
        b=dPHY97fOjqxv+lnN7zZmLfpW9uXWKCqaRdcavGEcEphqjvmrp0boMVT8P4HaoBM8+TI7mr
        AZgcOPxdNttjzSZTsefhi/1eMZDe+V5UQcXUEEGsFEHQP2wuk895aYKBmC7kEhE/r6VBwk
        Nxol8nxWvhT7ZWN13V7/jrHt/DHGbWg=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-412--VaAZ9stPw6IyXAaLwgvPA-1; Tue, 08 Nov 2022 09:06:05 -0500
X-MC-Unique: -VaAZ9stPw6IyXAaLwgvPA-1
Received: by mail-ej1-f69.google.com with SMTP id nb1-20020a1709071c8100b007ae4083d6f5so5639113ejc.15
        for <bpf@vger.kernel.org>; Tue, 08 Nov 2022 06:06:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mhVuivBI13XN7hFJRIVsKLRsld9h+iIMpKP8ks7YdsA=;
        b=FdvrcqxL20g80V1Hyo9r02kzV+5TrLBKfe3m4vL0ZCY0Kp705onhxWB3pG5v3Ymh+h
         1sBddWEMC0L3N/iOBZ/to9pUJpCRikWPPmPPEVIu6iAoQCethYzpBB8jAyIwjYElA4fQ
         SB2EE4nRaUtX1+n6On6PF7sOyT/z2/NovkMgfLKmK6hJROq2/PS6yho2L/BdGDNSd0hU
         Ln8B6q+pMKdx/OV93PLLFA1J/xHWFvPebjU9q7wBdVW8qdBweCMFaRlKvfH9MHMv8XXo
         ME+K23ZXUvrSdELgL4rVyXxsbmPSQrI1CQPIrODblBERMDtxvzjrtqi9n9FlWA9y2FdR
         yepQ==
X-Gm-Message-State: ACrzQf2IKg75LrRLboxx8iCEHlnm5r6w16HBUHeSOj44/4L7d2fhgoe6
        KuD5jEwkalfORjhKm3ya7sombInGVT6CAGk0o6a8RCAh5NJlBmzUOyCKMeCGGjeH1OSZlh9WeiU
        SxTM599L9kkM+
X-Received: by 2002:a17:907:7fa5:b0:791:9a5f:101a with SMTP id qk37-20020a1709077fa500b007919a5f101amr53393794ejc.453.1667916364074;
        Tue, 08 Nov 2022 06:06:04 -0800 (PST)
X-Google-Smtp-Source: AMsMyM7djvw8VkYFn6W6euariW0OoAZIMaedqHxBcgsFjLFzV0ydAI5gULLr0JxSI5H6L4acct260w==
X-Received: by 2002:a17:907:7fa5:b0:791:9a5f:101a with SMTP id qk37-20020a1709077fa500b007919a5f101amr53393746ejc.453.1667916363488;
        Tue, 08 Nov 2022 06:06:03 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id w23-20020aa7dcd7000000b00443d657d8a4sm5531703edu.61.2022.11.08.06.06.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 06:06:03 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id B375678152B; Tue,  8 Nov 2022 15:06:02 +0100 (CET)
From:   =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>
Cc:     =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: [PATCH bpf-next v3 0/3] A couple of small refactorings of BPF program call sites
Date:   Tue,  8 Nov 2022 15:05:58 +0100
Message-Id: <20221108140601.149971-1-toke@redhat.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Stanislav suggested[0] that these small refactorings could be split out from the
XDP queueing RFC series and merged separately. The first change is a small
repacking of struct softnet_data, the others change the BPF call sites to
support full 64-bit values as arguments to bpf_redirect_map() and as the return
value of a BPF program, relying on the fact that BPF registers are always 64-bit
wide to maintain backwards compatibility.

Please see the individual patches for details.

v3:
- In patch 3, don't change types of return values that are copied to
  userspace (which should fix selftest errors on big-endian archs like s390)
- Rebase on bpf-next
- Collect Song's ACKs

v2:
- Rebase on bpf-next (CI failure seems to be unrelated to this series)
- Collect Stanislav's Reviewed-by

[0] https://lore.kernel.org/r/CAKH8qBtdnku7StcQ-SamadvAF==DRuLLZO94yOR1WJ9Bg=uX1w@mail.gmail.com

Kumar Kartikeya Dwivedi (1):
  bpf: Use 64-bit return value for bpf_prog_run

Toke Høiland-Jørgensen (2):
  dev: Move received_rps counter next to RPS members in softnet data
  bpf: Expand map key argument of bpf_redirect_map to u64

 include/linux/bpf-cgroup.h | 12 +++++------
 include/linux/bpf.h        | 24 +++++++++++-----------
 include/linux/filter.h     | 42 +++++++++++++++++++-------------------
 include/linux/netdevice.h  |  2 +-
 include/uapi/linux/bpf.h   |  2 +-
 kernel/bpf/cgroup.c        | 12 +++++------
 kernel/bpf/core.c          | 14 ++++++-------
 kernel/bpf/cpumap.c        |  4 ++--
 kernel/bpf/devmap.c        |  4 ++--
 kernel/bpf/offload.c       |  4 ++--
 kernel/bpf/verifier.c      |  2 +-
 net/core/filter.c          |  4 ++--
 net/packet/af_packet.c     |  7 +++++--
 net/xdp/xskmap.c           |  4 ++--
 14 files changed, 70 insertions(+), 67 deletions(-)

-- 
2.38.1

