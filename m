Return-Path: <bpf+bounces-749-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50A7D706548
	for <lists+bpf@lfdr.de>; Wed, 17 May 2023 12:31:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48E061C20ECD
	for <lists+bpf@lfdr.de>; Wed, 17 May 2023 10:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C227AD37;
	Wed, 17 May 2023 10:31:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26DC81118D
	for <bpf@vger.kernel.org>; Wed, 17 May 2023 10:31:40 +0000 (UTC)
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5A4855AE
	for <bpf@vger.kernel.org>; Wed, 17 May 2023 03:31:31 -0700 (PDT)
Received: by mail-vs1-xe2a.google.com with SMTP id ada2fe7eead31-43627012261so142136137.2
        for <bpf@vger.kernel.org>; Wed, 17 May 2023 03:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684319491; x=1686911491;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=v4mudFputIH7/UTPxnDAxfUAYXNGC4YOgU6FgHKdbnI=;
        b=r2A+aGxCDQp9BARB9bApU2ycoRHbxtjwbyiQVzEtvIdwUwDtW60SXytgnoRfP7W+kO
         diMmuPxB/49LkQWSokhcpmxRCjU9+mGusR+eLx2LxHCChCcKKhwKLfMDcTtubmcN7wvp
         bvQ2D7ClqNVefkFQ8A1HD1jHyXn2rnf3omwYcM/ffv491LqK91R0dceG+U88AV+ArA7R
         KRqerbCtg3PQHv0dSjYqak5hlXNs6Gp4fQYtpEChsjIxI/TOnzaLBF+A3guVa1Erc3JZ
         BcqgAaksDis3dJn0b5CNL18fQljoWaJz+9/VrQMCAxEZnZlQE7v01XYINcoaYzDKME97
         YTVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684319491; x=1686911491;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v4mudFputIH7/UTPxnDAxfUAYXNGC4YOgU6FgHKdbnI=;
        b=kHzhJLrLR0HcviCCVfgxAvVhDc87puxG7XcoPp5ZMbY6h8M11LZDjeu3tz97Th8vga
         1UNuwBcTF8NJSA2h84skHhf56WixQdX6rySAJZF33DC1LGxGnbeN1EDvDDwJFR/lUBlm
         p2hY/pQ9jTfe2SoeIv/QKxgCZUDkyicp/pwdNc5hB/2M0+6B73t0YJdIiTJ5FQYGg4ZU
         W/tAgjLCamD2I26gxh0CYbBnhJmorjBY3D7BVDaB/jC8GBIs8SbV97aOT8lC+5jToMmq
         pwVqzk9ZfjswyxNsiqzncNRcirnMLTm6H1NGUAg4MlBQ5ggp0ppirZFYWqbvOyqeJywI
         okAQ==
X-Gm-Message-State: AC+VfDxHPrGjXHTJs9KYq5Zrk80kQeYVH3GUWjdGO1NwrQj6GUQzlsGo
	miXFOI9TNuJUHyXVA1Ozpo8=
X-Google-Smtp-Source: ACHHUZ5Obp+OXzrIVltihhBEjhMmghO9vOoBHh2+e5T1fDIjM1JfbJXbuCHi6Vz2ZxfgyxrsG2BDTw==
X-Received: by 2002:a67:f353:0:b0:434:8479:1812 with SMTP id p19-20020a67f353000000b0043484791812mr16576343vsm.18.1684319490841;
        Wed, 17 May 2023 03:31:30 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:9002:140f:5400:4ff:fe70:c0fd])
        by smtp.gmail.com with ESMTPSA id t25-20020a9f3899000000b0076d52359f2asm5343651uaf.31.2023.05.17.03.31.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 03:31:30 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: quentin@isovalent.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yhs@fb.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org
Cc: bpf@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH bpf-next v2 0/2] bpf: Show target_{obj,btf}_id for tracing link 
Date: Wed, 17 May 2023 10:31:24 +0000
Message-Id: <20230517103126.68372-1-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.1
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

The target_btf_id can help us understand which kernel function is
linked by a tracing prog. The target_btf_id and target_obj_id have
already been exposed to userspace, so we just need to show them.

For some other link types like perf_event and kprobe_multi, it is not
easy to find which functions are attached either. We may support
->fill_link_info for them in the future.

v1->v2:
- Skip showing them in the plain output for the old kernels. (Quentin)
- Coding improvement. (Andrii)

Yafang Shao (2):
  bpf: Show target_{obj,btf}_id in tracing link fdinfo
  bpftool: Show target_{obj,btf}_id in tracing link info

 kernel/bpf/syscall.c     | 11 +++++++++--
 tools/bpf/bpftool/link.c |  6 ++++++
 2 files changed, 15 insertions(+), 2 deletions(-)

-- 
1.8.3.1


