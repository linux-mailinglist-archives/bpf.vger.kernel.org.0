Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82A6459E83C
	for <lists+bpf@lfdr.de>; Tue, 23 Aug 2022 19:07:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343684AbiHWRBy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Aug 2022 13:01:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245694AbiHWQ7W (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 23 Aug 2022 12:59:22 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 376CD14C7A9
        for <bpf@vger.kernel.org>; Tue, 23 Aug 2022 06:30:32 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id n7so17019758wrv.4
        for <bpf@vger.kernel.org>; Tue, 23 Aug 2022 06:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metanetworks.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=Q2HgncRTCHYMk2G6UxbD+Qvr25oBP+xN7VSMnx5SJzA=;
        b=KNx51M/KkTAEh+25nJwXOTFkm1OwfVRiH+8rcefYdvWcSlSOvR8PrXO+iVLn00NotG
         vTgrnoeba/YnBKYUp4dGQ1xLpnEFmb+6nqjppxyagh/JlyoDDtx5G8dz3au9XFhLqN7Y
         Uuz1aJcbHjMGl8KCIhkbF8flOHlVDPl421a7g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=Q2HgncRTCHYMk2G6UxbD+Qvr25oBP+xN7VSMnx5SJzA=;
        b=T/fW838ZWuTDswhCr0Dcb8STsjvBQ9K4sH3Yw8A5HAVBiDv1Ci6crIr16MwnfUWXiK
         7pYIVOxEnvrfDAMePidCxJDuwrxXrePs+fg0E4tB5MVo293Gqwk2EuxV0tn775LjDAsk
         ZDs5NThr5MDNJYennEN4xvb0JLJookgUt+o/A6s/VvppVxV3nCjArRSUfxcxyojMHiC4
         R7D0RPtH12ZzVXoPr/TN3kggjNKfbBexqdpAqf/EucAgUlTOa3IK/MhSg9CX0+29P/ZZ
         FUWqWhNcN07eEmnMJb3MZ54M/LQ6lEEvuJnnR0Vsn/Zr0ushQ82WWrB6rR4LE7vO+nP1
         8NpQ==
X-Gm-Message-State: ACgBeo18JNzU+51DVlK/IrWpea+/JT5vUx7Ku5sip1HAN4Kzn16ZoDSi
        xH3sao6pe/RW7JitF1TDhU6RzznoRUpuO5YPz2v6fNbXs9LRufhtywjx0pomCIJTwCemof87Av5
        LemMqNaaWTuLf0L3GyTAubTo40XRPjtx5Z+w55VTd063x0PQidm8r0MO+2NAPbJTRzIazmr0x
X-Google-Smtp-Source: AA6agR6en+lHLtIh7J2iRxG9dMJUzLwJy5NqkPFElQ3MCHNE13Fhcoe10ikEl8McFbdvyGiRej8H8A==
X-Received: by 2002:a5d:4a01:0:b0:21d:8ce1:8b6d with SMTP id m1-20020a5d4a01000000b0021d8ce18b6dmr13542822wrq.718.1661261430251;
        Tue, 23 Aug 2022 06:30:30 -0700 (PDT)
Received: from blondie.home ([94.230.83.151])
        by smtp.gmail.com with ESMTPSA id t9-20020a05600c198900b003a4efb794d7sm19264891wmq.36.2022.08.23.06.30.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 06:30:29 -0700 (PDT)
From:   Shmulik Ladkani <shmulik@metanetworks.com>
X-Google-Original-From: Shmulik Ladkani <shmulik.ladkani@gmail.com>
To:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>,
        Paul Chaignon <paul@isovalent.com>,
        Shmulik Ladkani <shmulik.ladkani@gmail.com>
Subject: [PATCH v4 bpf-next 0/4] bpf: Support setting variable-length tunnel options
Date:   Tue, 23 Aug 2022 16:30:16 +0300
Message-Id: <20220823133020.73872-1-shmulik.ladkani@gmail.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Introduce 'skb_set_tunnel_opt_dynptr' to allow setting tunnel options of
dynamic length.

v2:
- Place test_tunnel's local route in a custom table, to ensure the IP
  isn't considered assigned to a device.
v3:
- Avoid 'inline' for the __bpf_skb_set_tunopt helper function
v4:
- change API to be based on bpf_dynptr,
  suggested by John Fastabend <john.fastabend@gmail.com>

Shmulik Ladkani (4):
  bpf: Add 'bpf_dynptr_get_data' helper
  bpf: Support setting variable-length tunnel options
  selftests/bpf: Simplify test_tunnel setup for allowing non-local
    tunnel traffic
  selftests/bpf: Add geneve with bpf_skb_set_tunnel_opt_dynptr test-case
    to test_progs

 include/linux/bpf.h                           |   1 +
 include/uapi/linux/bpf.h                      |  12 ++
 kernel/bpf/helpers.c                          |  10 +
 net/core/filter.c                             |  36 +++-
 tools/include/uapi/linux/bpf.h                |  12 ++
 .../selftests/bpf/prog_tests/test_tunnel.c    | 131 ++++++++++--
 .../selftests/bpf/progs/test_tunnel_kern.c    | 200 ++++++++++++------
 7 files changed, 322 insertions(+), 80 deletions(-)

-- 
2.37.2

