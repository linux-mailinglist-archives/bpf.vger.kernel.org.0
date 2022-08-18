Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 330F0598984
	for <lists+bpf@lfdr.de>; Thu, 18 Aug 2022 19:01:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345185AbiHRQ7Y (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 18 Aug 2022 12:59:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345183AbiHRQ7V (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 18 Aug 2022 12:59:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AC4C606AD
        for <bpf@vger.kernel.org>; Thu, 18 Aug 2022 09:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660841957;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=ZlTKI8rs1NnVLrkDzcJ8S1M2o6u4KNDE+orUNleUFbY=;
        b=JmJfTOD9eAmHzHJ5anzoXFb6qstBJKM1J1H5oiWGigk6WkKomUGk7FRZntB3vK7kwaKzvZ
        jEUZjjvKStd54M4uYqJ9sdKSwFsLj6E/sqMWPcPLe7XU8NOKOXj51H0qFs3gdr1VeZ6vH7
        x8eKfpKf5WRqkYHbCsy6qlx5CfssdGg=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-275-CmoZNbe9OEiFgMQKKAPF2A-1; Thu, 18 Aug 2022 12:59:14 -0400
X-MC-Unique: CmoZNbe9OEiFgMQKKAPF2A-1
Received: by mail-ej1-f72.google.com with SMTP id go15-20020a1709070d8f00b00730ab9dd8c6so873586ejc.6
        for <bpf@vger.kernel.org>; Thu, 18 Aug 2022 09:59:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=ZlTKI8rs1NnVLrkDzcJ8S1M2o6u4KNDE+orUNleUFbY=;
        b=hB+bOxkipDWjImIo3QYqfUqwjUj3aNYW7/la6yg4ETXkrb7TsPzBhalSMRCCCgscxT
         q2g8lu4uUGSFf0AVnY0Tq/CgeIzjji5O4ki14iiKiOp83445gt8A+u5U6QxDtv320aRy
         mAb9L38vTHez09BST4KvVgJe18rCVPrC9t3/Wzxgf8407rpVL7Y/oaXVA0qg6n05Somn
         zWR135RP7ybEb19xi5Km8b1oWV7iVmqKV38AMDMWJA/4CEzjJMUWILph8SAv0lGiOcRH
         djs+itq2oasJNtmjbPClBaJVhEIHAwCnIdJ1KxjPLhuj+TCQtq/wBvWPSXsgV8n3TzPD
         i0XA==
X-Gm-Message-State: ACgBeo0QbuAnlvvLKsHvbpth3+jeHyZV3wzJTYTpq8MuUBYejn7bDHWZ
        KSU5iBaqA+Of+i5wvkrvtT0dMmu35fs6Q3CoPquWPbFnRj5jFTY89WkbZgtPkMyBeh8yXSN02tk
        j/nvTwK//xJ5T
X-Received: by 2002:a17:907:7ea8:b0:731:4fa1:d034 with SMTP id qb40-20020a1709077ea800b007314fa1d034mr2421958ejc.758.1660841952606;
        Thu, 18 Aug 2022 09:59:12 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7amDBe+GaQgxSIh9KPRUEy0hkGeT3hH11PgkDlFhoM2Pt4/yq/b+5z5dxnfP/+Nxuh1ldxlQ==
X-Received: by 2002:a17:907:7ea8:b0:731:4fa1:d034 with SMTP id qb40-20020a1709077ea800b007314fa1d034mr2421863ejc.758.1660841950337;
        Thu, 18 Aug 2022 09:59:10 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id d23-20020a056402145700b00445e930e20esm1431180edx.64.2022.08.18.09.59.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 09:59:09 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id E108755FA95; Thu, 18 Aug 2022 18:59:08 +0200 (CEST)
From:   =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Jonathan Lemon <jonathan.lemon@gmail.com>
Cc:     =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        bpf@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH bpf-next 0/3] A couple of small refactorings of BPF program call sites
Date:   Thu, 18 Aug 2022 18:59:02 +0200
Message-Id: <20220818165906.64450-1-toke@redhat.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
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

[0] https://lore.kernel.org/r/CAKH8qBtdnku7StcQ-SamadvAF==DRuLLZO94yOR1WJ9Bg=uX1w@mail.gmail.com

Kumar Kartikeya Dwivedi (1):
  bpf: Use 64-bit return value for bpf_prog_run

Toke Høiland-Jørgensen (2):
  dev: Move received_rps counter next to RPS members in softnet data
  bpf: Expand map key argument of bpf_redirect_map to u64

 include/linux/bpf-cgroup.h | 12 +++++-----
 include/linux/bpf.h        | 16 ++++++-------
 include/linux/filter.h     | 46 +++++++++++++++++++-------------------
 include/linux/netdevice.h  |  2 +-
 include/uapi/linux/bpf.h   |  2 +-
 kernel/bpf/cgroup.c        | 12 +++++-----
 kernel/bpf/core.c          | 14 ++++++------
 kernel/bpf/cpumap.c        |  4 ++--
 kernel/bpf/devmap.c        |  4 ++--
 kernel/bpf/offload.c       |  4 ++--
 kernel/bpf/verifier.c      |  2 +-
 net/bpf/test_run.c         | 21 +++++++++--------
 net/core/filter.c          |  4 ++--
 net/packet/af_packet.c     |  7 ++++--
 net/xdp/xskmap.c           |  4 ++--
 15 files changed, 80 insertions(+), 74 deletions(-)

-- 
2.37.2

