Return-Path: <bpf+bounces-2439-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B935172CF31
	for <lists+bpf@lfdr.de>; Mon, 12 Jun 2023 21:17:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EA1528107D
	for <lists+bpf@lfdr.de>; Mon, 12 Jun 2023 19:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4E178BE8;
	Mon, 12 Jun 2023 19:16:52 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78992882A
	for <bpf@vger.kernel.org>; Mon, 12 Jun 2023 19:16:52 +0000 (UTC)
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96A9E171F
	for <bpf@vger.kernel.org>; Mon, 12 Jun 2023 12:16:50 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id 5614622812f47-39c84b14d6aso1779903b6e.2
        for <bpf@vger.kernel.org>; Mon, 12 Jun 2023 12:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686597409; x=1689189409;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=L4qPLustSvNtRsxMvmGqkNJ510ELslvqQ9JxXRLcQ7Q=;
        b=EZeo3UxPrQlftsBlQcgKOy8EamxlCxA84HSEneKgr7oRXz+axpXvXqQN2dddqzE7sN
         qFLwsOqbjJDb6/ujEkxis7GeITyLQ0LBuj74Hn4TBv31T8gcjgjWaGWOVvV6Jjwhk6nW
         GDD2Xzt6a9PAY1rmClw4CyS0She/zX5Ig+sc3q47w+3KXJDCvuOPffieNHPE7RR+5GVN
         ew06Yyw0eKoWLHDVJOTbyynp5k4JKdFOYHfmbZ/3RHfUSoJ2sI6cUFHdtvYrDFuNjOsb
         /iWtkKKQ/LyroqzdWB9h3UrXF0zaN0+E0LkmSYXK7HgyRRO7qZX1+/NfnNdQzI45lSRk
         uE2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686597409; x=1689189409;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L4qPLustSvNtRsxMvmGqkNJ510ELslvqQ9JxXRLcQ7Q=;
        b=XI7NTpJP1kY4JJCZxycoD7IHZV12KRG+ycPOFdwIA3mP9i7t7BGlq7mWmsgXIqM0Br
         lNKDHBOtwcuRtpUUCYV7K7a+rCUFG7pCxc1UmfDFOwy+6br883TuDDBDJZPZK1CCfk7x
         HH2zFF4iBrr6m/7wmT2ZvlpEQHDS4xTrjCMJ6dPfytfQwW2j1x6rWyyaOBIjsoJTAXYu
         +SNInK5zFgBr7zGuQOflwON3N8WdjLhbGS+/nl+MlTX95FZKSG5nJDsvb0vM1D5QMWfm
         ki/sUsvs0oghY4Kh8dV12p9OzIqnsaWRiWo+cjFfuaYquNrjizPltMm1SgGdzvZzKqEz
         YIiw==
X-Gm-Message-State: AC+VfDyDkuy1r//QzRgcxNxGk27muTRgyNEr8Fm8M5t3l4IoMmGR1sXX
	VouYHa72hduRK12z0ZMgb5ydmmxCicc=
X-Google-Smtp-Source: ACHHUZ5X4lBhqWwH2amayVM2/Ik5lw7c3y74N/Fs6JwTckR2IX4i3fz0V3qpzsQOv6yvZf6kcjvfdw==
X-Received: by 2002:a05:6359:a24:b0:129:cbaf:e22e with SMTP id el36-20020a0563590a2400b00129cbafe22emr2972898rwb.6.1686597409372;
        Mon, 12 Jun 2023 12:16:49 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:df5d:2d08:1aa:9ce3])
        by smtp.gmail.com with ESMTPSA id y14-20020a25ad0e000000b00bc6a712c523sm1292607ybi.64.2023.06.12.12.16.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 12:16:48 -0700 (PDT)
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
Subject: [PATCH bpf-next 0/2] Fix missing synack in BPF cgroup_skb filters
Date: Mon, 12 Jun 2023 12:16:39 -0700
Message-Id: <20230612191641.441774-1-kuifeng@meta.com>
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
owner of the sk_buff. Specifically, in our situation, the SYN/ACK
sk_buff is owned by a struct request_sock instance, but the sending
socket is the listener socket we use to receive incoming
connections. The request_sock is created to manage an incoming
connection.

It has been determined that checking the owner of a sk_buff against
the sending socket is not required. Removing this check will allow the
filters to receive SYN/ACK packets.

To ensure that cgroup_skb filters can receive all signaling packets,
including SYN, SYN/ACK, ACK, FIN, and FIN/ACK. A new self-test has
been added as well.

Kui-Feng Lee (2):
  net: bpf: Always call BPF cgroup filters for egress.
  selftests/bpf: Verify that the cgroup_skb filters receive expected
    packets.

 include/linux/bpf-cgroup.h                    |   2 +-
 tools/testing/selftests/bpf/cgroup_helpers.c  |  12 +
 tools/testing/selftests/bpf/cgroup_helpers.h  |   1 +
 tools/testing/selftests/bpf/cgroup_tcp_skb.h  |  35 ++
 .../selftests/bpf/prog_tests/cgroup_tcp_skb.c | 363 ++++++++++++++++++
 .../selftests/bpf/progs/cgroup_tcp_skb.c      | 340 ++++++++++++++++
 6 files changed, 752 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/cgroup_tcp_skb.h
 create mode 100644 tools/testing/selftests/bpf/prog_tests/cgroup_tcp_skb.c
 create mode 100644 tools/testing/selftests/bpf/progs/cgroup_tcp_skb.c

-- 
2.34.1


