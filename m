Return-Path: <bpf+bounces-1141-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1F0870EA6B
	for <lists+bpf@lfdr.de>; Wed, 24 May 2023 02:45:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D0101C20901
	for <lists+bpf@lfdr.de>; Wed, 24 May 2023 00:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B66CE1363;
	Wed, 24 May 2023 00:45:49 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D5FED8
	for <bpf@vger.kernel.org>; Wed, 24 May 2023 00:45:49 +0000 (UTC)
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 147A7C2
	for <bpf@vger.kernel.org>; Tue, 23 May 2023 17:45:48 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-64d5f65a2f7so131646b3a.1
        for <bpf@vger.kernel.org>; Tue, 23 May 2023 17:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684889147; x=1687481147;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=U5Z5TeaJU93XHJ6xe6i4wvrNfi1dcH/yZx90Tdl1QF0=;
        b=fXWnCCk7Yv7i6iqPEhLz9BC6cJPlfp3F9nZzxTWG6SxkLuxf34E9Yk9qXjVVREKW8u
         cYVyOu1iSL9jmjQp56P6udpfJmnbRAF0pHbbVlfaN2kYbmORZwSHQdv+4xx1CSgkzYrk
         wBKYuteA5acT7FkdHnlF5jek7yxY5S5HlPnv5rJ5MIHU2dgRV07V2mcb3747jhw06wU1
         gHBm2j/duhvb1LWoiCZAv202gtriEZxRmm9hWzaEM2Y4xHjjmCq0LGC0YIuXu3ZdhIvP
         Tm0plqWYTWgZDYlDKx73/XOnfQXR9Zsw9wgiYe8p0uW4D0aOiEHkW/D1p+aIzRJuHf13
         cC/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684889147; x=1687481147;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U5Z5TeaJU93XHJ6xe6i4wvrNfi1dcH/yZx90Tdl1QF0=;
        b=HtdPbBCj7deuBrpEkxMx+yMPlWYBfJwSZaYcc+2CZ5CELl5mpcNYxFLkMD2cY6W9YQ
         ndnf5vKilm63pbtaaZ6P0zxxO1Sea/mwWXeyD77NP61mucmbvcF8gEWORI9H4cUC//Yt
         xi3kdBiGLb9glvGXuMYS5ChP0pPKO4cSvp21ufGEIvqCSNrU0GtLQ48530Db1EpuW7GE
         +HzL2qL8nEn3YcAOADLXaxkDCtkJsuPwtOIv8d31sl55Z/8SprJ758haYNWS6Veu5M7I
         z24h5J5Q0iYjyEVmXRZ6dLjgGuF3Mz210IcgDLU1KexGrehA+4JPyvfwYXLoNzGWw/+/
         8YfA==
X-Gm-Message-State: AC+VfDxhedZcJYWIOBU79CsoyNAmCtdIyUoTTTyZlvjWnUy5+9/zNPTz
	uFBm4jgjM9+ptQVRC0uI9ukR+iCjqrHk+Q==
X-Google-Smtp-Source: ACHHUZ5h6k9A+gkZyKYlIfx9qaTOUTYNKV4ovdDC/m+tSJVmgYmUbryDFlQnSlUTxw3d64Hob39msg==
X-Received: by 2002:a17:902:d2ca:b0:1ac:5717:fd2 with SMTP id n10-20020a170902d2ca00b001ac57170fd2mr18223784plc.47.1684889147460;
        Tue, 23 May 2023 17:45:47 -0700 (PDT)
Received: from toolbox.. ([98.42.24.125])
        by smtp.gmail.com with ESMTPSA id l15-20020a170902f68f00b001a673210cf4sm7399292plg.74.2023.05.23.17.45.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 17:45:46 -0700 (PDT)
From: JP Kobryn <inwardvessel@gmail.com>
To: bpf@vger.kernel.org,
	andrii@kernel.org
Cc: kernel-team@meta.com,
	inwardvessel@gmail.com
Subject: [PATCH v3 bpf-next 0/2] libbpf: capability for resizing datasec maps
Date: Tue, 23 May 2023 17:45:35 -0700
Message-Id: <20230524004537.18614-1-inwardvessel@gmail.com>
X-Mailer: git-send-email 2.40.0
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

Due to the way the datasec maps like bss, data, rodata are memory
mapped, they cannot be resized with bpf_map__set_value_size() like
non-datasec maps can. This series offers a way to allow the resizing of
datasec maps, by having the mapped regions resized as needed and also
adjusting associated BTF info if possible.

The thought behind this is to allow for use cases where a given datasec
needs to scale to for example the number of CPU's present. A bpf program
can have a global array in a data section with an initial length and
before loading the bpf program, the array length could be extended to
match the CPU count. The selftests included in this series perform this
scaling to an arbitrary value to demonstrate how it can work.

JP Kobryn (2):
  add capability for resizing datasec maps
  selftests for resizing datasec maps

 tools/lib/bpf/libbpf.c                        | 130 ++++++++++
 tools/lib/bpf/libbpf.h                        |  17 +-
 .../bpf/prog_tests/global_map_resize.c        | 236 ++++++++++++++++++
 .../bpf/progs/test_global_map_resize.c        |  58 +++++
 4 files changed, 440 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/global_map_resize.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_global_map_resize.c

-- 
2.40.0


