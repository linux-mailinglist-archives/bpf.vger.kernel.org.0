Return-Path: <bpf+bounces-2783-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42C50733E60
	for <lists+bpf@lfdr.de>; Sat, 17 Jun 2023 07:28:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 783D81C210A8
	for <lists+bpf@lfdr.de>; Sat, 17 Jun 2023 05:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 976921C36;
	Sat, 17 Jun 2023 05:28:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65CEF1C17
	for <bpf@vger.kernel.org>; Sat, 17 Jun 2023 05:28:17 +0000 (UTC)
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B98144B4
	for <bpf@vger.kernel.org>; Fri, 16 Jun 2023 22:28:02 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-5701810884aso17115987b3.0
        for <bpf@vger.kernel.org>; Fri, 16 Jun 2023 22:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686979681; x=1689571681;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JxozS2om+T2AUs3ZtNUMRlUIRSHCVQkwxxRZNeV6q7k=;
        b=jLuznLHaQNHs9m39GaaM1tsZpyyA8i8BhteHTuc49iWcSjoYkC9yXsccQcUBD+LL85
         JRuwYV512x/pTVK7SltyZfYsU7MHXHWcBNKZeTPPpneqsSH93wbi5d8Vv0+Elynz1BMR
         9nVLIHZH4xrHUjcb8QvBepft+N3k9E9XXfIm2TA/GSiZ3eCc9PgymKTD1jJwuIZjmi+w
         zO0cIgW0lb6eyYo0uog0zmQd3oD0NPIQcRTDKhBUvpVxZWafvyQm3no+0FDgz0yKNiTM
         ENtb5wCNUgE0ElARBYcChY2l0qv969HY6f2yJULR29WDDf0U13XHiBpfq3oRFn+SvnkZ
         6q3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686979681; x=1689571681;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JxozS2om+T2AUs3ZtNUMRlUIRSHCVQkwxxRZNeV6q7k=;
        b=ESDpWuZxVjKhQpLcjtPgJIAMSCyX4z4NuidL8fPwMPMcQoqEs3dgSkv/A0aheqmRb0
         eLIp7xKSHo1PvCJDIpGKFJeRNJLDuGQbx/F/2HtGYk7E+9U0L0oKDxLFCqxNoJY6AQtz
         P/x7d4Wni3z1PNd6l39k0Rbodo5PPKr/rINy/Dz+YZfSouPKHurHkSfPVO/VW7ZfpQjO
         aVTtFpzkASSpYDoO5lMuvJFam/0PHG9DPgF9AqKWJcPj/LKTp/1SYsdx25PastDcc4vY
         kjQTdwZ3LOTPY87qD3L9E41SZYnG49l73czUu0tcvEq3QBkmB0CwlJ9iyA95dtviHjV+
         thIQ==
X-Gm-Message-State: AC+VfDycNrOu+6TArG7np/SODIPd3PFtY3xA8DMonPpwTEpkZEEIcci9
	obizQxnaYVif7v9TVMbMfQinXYJ+XmQ=
X-Google-Smtp-Source: ACHHUZ4XSr1oj3f8HWPPwgA/cHpckWO5npzzrLT18lCMpUwkKtQQqM8xsp1Zrp8iq7yhV72d/X4idw==
X-Received: by 2002:a81:a511:0:b0:56d:4edb:39ba with SMTP id u17-20020a81a511000000b0056d4edb39bamr3558971ywg.33.1686979680832;
        Fri, 16 Jun 2023 22:28:00 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:a9ca:115f:d699:728])
        by smtp.gmail.com with ESMTPSA id c123-20020a0dda81000000b0056d0709e0besm4133312ywe.129.2023.06.16.22.27.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jun 2023 22:28:00 -0700 (PDT)
From: Kui-Feng Lee <thinker.li@gmail.com>
X-Google-Original-From: Kui-Feng Lee <kuifeng@meta.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	kernel-team@meta.com,
	andrii@kernel.org,
	daniel@iogearbox.net
Cc: Kui-Feng Lee <kuifeng@meta.com>
Subject: [PATCH bpf-next v2 0/2] Fix missing synack in BPF cgroup_skb filters
Date: Fri, 16 Jun 2023 22:27:54 -0700
Message-Id: <20230617052756.640916-1-kuifeng@meta.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

TCP SYN/ACK packets of connections from processes/sockets outside a
cgroup on the same host are not received by the cgroup's installed
cgroup_skb filters.

There were two BPF cgroup_skb programs attached to a cgroup named
"my_cgroup".

    SEC("cgroup_skb/ingress")
    int ingress(struct __sk_buff *skb)
    {
        /* .... process skb ... */
        return 1;
    }

    SEC("cgroup_skb/egress")
    int egress(struct __sk_buff *skb)
    {
        /* .... process skb ... */
        return 1;
    
    }

We discovered that when running the command "nc -6 -l 8000" in
"my_group" and connecting to it from outside of "my_cgroup" with the
command "nc -6 localhost 8000", the egress filter did not detect the
SYN/ACK packet. However, we did observe the SYN/ACK packet at the
ingress when connecting from a socket in "my_cgroup" to a socket
outside of it.

We came across BPF_CGROUP_RUN_PROG_INET_EGRESS(). This macro is
responsible for calling BPF programs that are attached to the egress
hook of a cgroup and it skips programs if the sending socket is not the
owner of the skb. Specifically, in our situation, the SYN/ACK
skb is owned by a struct request_sock instance, but the sending
socket is the listener socket we use to receive incoming
connections. The request_sock is created to manage an incoming
connection.

It has been determined that checking the owner of a skb against
the sending socket is not required. Removing this check will allow the
filters to receive SYN/ACK packets.

To ensure that cgroup_skb filters can receive all signaling packets,
including SYN, SYN/ACK, ACK, FIN, and FIN/ACK. A new self-test has
been added as well.

Changes from v1:

 - Check the number of observed packets instead of just sleeping.

 - Use ASSERT_XXX() instead of CHECK()/

[v1] https://lore.kernel.org/all/20230612191641.441774-1-kuifeng@meta.com/

Kui-Feng Lee (2):
  net: bpf: Always call BPF cgroup filters for egress.
  selftests/bpf: Verify that the cgroup_skb filters receive expected
    packets.

 include/linux/bpf-cgroup.h                    |   2 +-
 tools/testing/selftests/bpf/cgroup_helpers.c  |  12 +
 tools/testing/selftests/bpf/cgroup_helpers.h  |   1 +
 tools/testing/selftests/bpf/cgroup_tcp_skb.h  |  35 ++
 .../selftests/bpf/prog_tests/cgroup_tcp_skb.c | 399 ++++++++++++++++++
 .../selftests/bpf/progs/cgroup_tcp_skb.c      | 385 +++++++++++++++++
 6 files changed, 833 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/cgroup_tcp_skb.h
 create mode 100644 tools/testing/selftests/bpf/prog_tests/cgroup_tcp_skb.c
 create mode 100644 tools/testing/selftests/bpf/progs/cgroup_tcp_skb.c

-- 
2.34.1


