Return-Path: <bpf+bounces-8253-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8C517843EB
	for <lists+bpf@lfdr.de>; Tue, 22 Aug 2023 16:23:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C08011C20AEB
	for <lists+bpf@lfdr.de>; Tue, 22 Aug 2023 14:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 748571D2F0;
	Tue, 22 Aug 2023 14:23:05 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302911D2E3
	for <bpf@vger.kernel.org>; Tue, 22 Aug 2023 14:23:04 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 410D8CC1
	for <bpf@vger.kernel.org>; Tue, 22 Aug 2023 07:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1692714182;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=pMRZgqVa/wFsH3H+GdBkhjVtTLlso7Lv6aMHwb271nE=;
	b=AHOx4Ye8Ud3EKXOTWdWFuKX6i5eglo3vVzlSB44/VgJPH+/TrTbdlTEaAtwYpYWGEybWDB
	qk/xIahOlhlJu30apRUtsK/LbrfWDxU8IWjB7Vqq81EelhKeRIAvxLGsmxVF1USAXYjEml
	GFoFolfNTitpU7TFcKGfCWzLLaHpYNs=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-394-CryHrZPlMJypSF3ILtCHMg-1; Tue, 22 Aug 2023 10:23:01 -0400
X-MC-Unique: CryHrZPlMJypSF3ILtCHMg-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-99bebfada8cso320829966b.1
        for <bpf@vger.kernel.org>; Tue, 22 Aug 2023 07:23:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692714180; x=1693318980;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pMRZgqVa/wFsH3H+GdBkhjVtTLlso7Lv6aMHwb271nE=;
        b=Qfm816YduFchqFrgWFByKjHXmbFCe8ZUo0qy7+f6sNEEXvELYYYqlKtaBu3ddwcbQj
         m5B89AFcBCcxjgltYK+c+CMtd2P6SidfOkruBGdYO5Uhq02ZXDbpDoyk4jJq2b3gIFzN
         iE99TrSlJ3bbpIqewx19lJVDobKPQvkzpetGxGmRVEn8WxRjzAKnOdf6QeeyMsAKpaUi
         8HS8AHYoBDdo9yap3UtQrKtK0lYEcx6c3idxQ46p5oqLmr2QX6jJGMxW2ImHEO3FlGdH
         2O14fQe2JVyqdzEkReSKWC/+KZZh8gzc/dbu6IicejDb/cD9YvGnBYiDuWNgApwgHOo9
         pBVQ==
X-Gm-Message-State: AOJu0YyJWPTW8DMsmIAFbzTGAjgHXx7WWplbZ8rOQAX+Vv808lGmO36Y
	okefNSfqfNuKz9s/kCkCLSTOq6SNKGnsJNhdUplz/sCl3xuCxTaFQtEkCDX8De3v9SseaPAeJRy
	FJehsXMmUN39b
X-Received: by 2002:a17:906:2d1:b0:993:e9b8:90f5 with SMTP id 17-20020a17090602d100b00993e9b890f5mr6804579ejk.8.1692714179724;
        Tue, 22 Aug 2023 07:22:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGACt3tn7yicPJ8IgltAlQ48iVNLwLnbda5A8p3v19dtZFsLWwbFceeXM9C49x2AMt6G9uJHA==
X-Received: by 2002:a17:906:2d1:b0:993:e9b8:90f5 with SMTP id 17-20020a17090602d100b00993e9b890f5mr6804554ejk.8.1692714179289;
        Tue, 22 Aug 2023 07:22:59 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id i6-20020a170906698600b009928b4e3b9fsm8297386ejr.114.2023.08.22.07.22.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 07:22:59 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 6DC5FD3CC9F; Tue, 22 Aug 2023 16:22:58 +0200 (CEST)
From: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>
Cc: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH bpf-next 0/6] samples/bpf: Remove unmaintained XDP sample utilities
Date: Tue, 22 Aug 2023 16:22:38 +0200
Message-ID: <20230822142255.1340991-1-toke@redhat.com>
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
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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


