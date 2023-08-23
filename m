Return-Path: <bpf+bounces-8357-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 004FF785B28
	for <lists+bpf@lfdr.de>; Wed, 23 Aug 2023 16:54:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D6FA1C20CA9
	for <lists+bpf@lfdr.de>; Wed, 23 Aug 2023 14:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDE90C2E5;
	Wed, 23 Aug 2023 14:54:00 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86887C2D8
	for <bpf@vger.kernel.org>; Wed, 23 Aug 2023 14:54:00 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C44A1E6F
	for <bpf@vger.kernel.org>; Wed, 23 Aug 2023 07:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1692802438;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=cvn7J5f6wyn2z/+ezssE8xZZ0vi4dl6NMwd3DXJWnmw=;
	b=TY9bj72HHQvA9V+MQl+mOFyv/D0Rt9QVtdmNNCJZbtG554QWfj2yQNpM0wE7nSo0aqx4wl
	+TfNL+tSMvw6xu35y2N3fuCRIgICBLbhRSYuZqhwuNocTZ7WcnFGcKRaJSnK1kU1K40UnK
	MAAV4sQOypVe+Dbg5n5stRcoXVBDQnE=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-IktwONirN7yppZwVlcqLQw-1; Wed, 23 Aug 2023 10:53:56 -0400
X-MC-Unique: IktwONirN7yppZwVlcqLQw-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2bba9a3d63fso62947551fa.0
        for <bpf@vger.kernel.org>; Wed, 23 Aug 2023 07:53:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692802435; x=1693407235;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cvn7J5f6wyn2z/+ezssE8xZZ0vi4dl6NMwd3DXJWnmw=;
        b=iROsVJzcT0rIllODYiFetzwnx/zywtCbQc2hThMd5mfbtUaP68iGzbpt8tT1aZ8MTl
         dDQQiavXQbqiW0ynRG+8PLhwnNfPYHamSu1rRmiJOezK4UejOJHwgRjOXEhEYUheq724
         Qg2S585iguvqQlZwNBRUaN8mf2K8KGpgTqHhJbLFc8rfj14joq9AEwtQOCQmId8JIj8i
         R580gyv1jjnm1OXM7TEuDUp42uz+G6TKS8U0K2Uubx1V/SSJxuqsEFp2vqzNDlJlH7lb
         PdQ3IOqBaIPSd/J3hXKGaBJ4Y4hLuUk5FlZWw3DhZ8BwKVsGhURi72pVp3Pntr6pWcQu
         PMGw==
X-Gm-Message-State: AOJu0YwJ8i80F7zR2ZygreH1UINCW57VloTmsdTyGEfBRedF7f4pfCK5
	nLkZbhJcsY2leOx1WtKHaJ4KV8u/vnahf2a2ydMGTybNo56E7lUVqhVL/KgjiSXB57vt/gjc7Co
	wWW6tthiqjhRu
X-Received: by 2002:a2e:8802:0:b0:2bb:71fd:2dca with SMTP id x2-20020a2e8802000000b002bb71fd2dcamr9713290ljh.52.1692802434906;
        Wed, 23 Aug 2023 07:53:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHjBpKYECM0HL7Z/deDVRqsLPyOHaxLYT/B/CF/3ISwJLgbyX1LuJ/J36XXVf2eysYxKbm6Ng==
X-Received: by 2002:a2e:8802:0:b0:2bb:71fd:2dca with SMTP id x2-20020a2e8802000000b002bb71fd2dcamr9713270ljh.52.1692802434346;
        Wed, 23 Aug 2023 07:53:54 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id gf2-20020a170906e20200b00993a9a951fasm9934196ejb.11.2023.08.23.07.53.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 07:53:53 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id EF611D3CEC6; Wed, 23 Aug 2023 16:53:52 +0200 (CEST)
From: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>
Cc: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next v2 0/6] samples/bpf: Remove unmaintained XDP sample utilities
Date: Wed, 23 Aug 2023 16:53:36 +0200
Message-ID: <20230823145346.1462819-1-toke@redhat.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The samples/bpf directory in the kernel tree started out as a way of showcasing
different aspects of BPF functionality by writing small utility programs for
each feature. However, as the BPF subsystem has matured, the preferred way of
including userspace code with a feature has become the BPF selftests, which also
have the benefit of being consistently run as part of the BPF CI system.

As a result of this shift, the utilities in samples/bpf have seen little love,
and have slowly bitrotted. There have been sporadic cleanup patches over the
years, but it's clear that the utilities are far from maintained.

For XDP in particular, some of the utilities have been used as benchmarking aids
when implementing new kernel features, which seems to be the main reason they
have stuck around; any updates the utilities have seen have been targeted at
this use case. However, as the BPF subsystem as a whole has moved on, it has
become increasingly difficult to incorporate new features into these utilities
because they predate most of the modern BPF features (such as kfuncs and BTF).

Rather than try to update these utilities and keep maintaining them in the
kernel tree, we have ported the useful features of the utilities to the
xdp-tools package. In the porting process we also updated the utilities to take
advantage of modern BPF features, integrated them with libxdp, and polished the
user interface.

As these utilities are standalone tools, maintaining them out of tree is
simpler, and we plan to keep maintaining them in the xdp-tools repo. To direct
users of these utilities to the right place, this series removes the utilities
from samples/bpf, leaving in place only a couple of utilities whose
functionality have not yet been ported to xdp-tools.

The xdp-tools repository is located on Github at the following URL:

https://github.com/xdp-project/xdp-tools

The commits in the series removes one utility each, explaining how the
equivalent functionality can be obtained with xdp-tools.

v2:
- Add equivalent xdp-tools commands for each removed utility

Toke Høiland-Jørgensen (6):
  samples/bpf: Remove the xdp_monitor utility
  samples/bpf: Remove the xdp_redirect* utilities
  samples/bpf: Remove the xdp_rxq_info utility
  samples/bpf: Remove the xdp1 and xdp2 utilities
  samples/bpf: Remove the xdp_sample_pkts utility
  samples/bpf: Cleanup .gitignore

 samples/bpf/.gitignore                    |  12 -
 samples/bpf/Makefile                      |  48 +-
 samples/bpf/xdp1_kern.c                   | 100 ----
 samples/bpf/xdp1_user.c                   | 166 ------
 samples/bpf/xdp2_kern.c                   | 125 -----
 samples/bpf/xdp_monitor.bpf.c             |   8 -
 samples/bpf/xdp_monitor_user.c            | 118 -----
 samples/bpf/xdp_redirect.bpf.c            |  49 --
 samples/bpf/xdp_redirect_cpu.bpf.c        | 539 -------------------
 samples/bpf/xdp_redirect_cpu_user.c       | 559 --------------------
 samples/bpf/xdp_redirect_map.bpf.c        |  97 ----
 samples/bpf/xdp_redirect_map_multi.bpf.c  |  77 ---
 samples/bpf/xdp_redirect_map_multi_user.c | 232 --------
 samples/bpf/xdp_redirect_map_user.c       | 228 --------
 samples/bpf/xdp_redirect_user.c           | 172 ------
 samples/bpf/xdp_rxq_info_kern.c           | 140 -----
 samples/bpf/xdp_rxq_info_user.c           | 614 ----------------------
 samples/bpf/xdp_sample_pkts_kern.c        |  57 --
 samples/bpf/xdp_sample_pkts_user.c        | 196 -------
 19 files changed, 1 insertion(+), 3536 deletions(-)
 delete mode 100644 samples/bpf/xdp1_kern.c
 delete mode 100644 samples/bpf/xdp1_user.c
 delete mode 100644 samples/bpf/xdp2_kern.c
 delete mode 100644 samples/bpf/xdp_monitor.bpf.c
 delete mode 100644 samples/bpf/xdp_monitor_user.c
 delete mode 100644 samples/bpf/xdp_redirect.bpf.c
 delete mode 100644 samples/bpf/xdp_redirect_cpu.bpf.c
 delete mode 100644 samples/bpf/xdp_redirect_cpu_user.c
 delete mode 100644 samples/bpf/xdp_redirect_map.bpf.c
 delete mode 100644 samples/bpf/xdp_redirect_map_multi.bpf.c
 delete mode 100644 samples/bpf/xdp_redirect_map_multi_user.c
 delete mode 100644 samples/bpf/xdp_redirect_map_user.c
 delete mode 100644 samples/bpf/xdp_redirect_user.c
 delete mode 100644 samples/bpf/xdp_rxq_info_kern.c
 delete mode 100644 samples/bpf/xdp_rxq_info_user.c
 delete mode 100644 samples/bpf/xdp_sample_pkts_kern.c
 delete mode 100644 samples/bpf/xdp_sample_pkts_user.c

-- 
2.41.0


