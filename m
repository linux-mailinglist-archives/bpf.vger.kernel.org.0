Return-Path: <bpf+bounces-9697-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 660C579C172
	for <lists+bpf@lfdr.de>; Tue, 12 Sep 2023 03:11:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18CBE2816FD
	for <lists+bpf@lfdr.de>; Tue, 12 Sep 2023 01:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A00617C8;
	Tue, 12 Sep 2023 01:11:21 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C5517D9
	for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 01:11:20 +0000 (UTC)
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 182DBEADD6
	for <bpf@vger.kernel.org>; Mon, 11 Sep 2023 17:57:58 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2bf8b9c5ca0so28363891fa.0
        for <bpf@vger.kernel.org>; Mon, 11 Sep 2023 17:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694480210; x=1695085010; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Y2KeU1NE47LCW3P4VpCbOe+Lmrn9Jf8vvs/VSfYTWbc=;
        b=g0v85jzuL5CZFe0A8A2idWw9lNbj1d0wEA8/LiTkYrQGFQFEhP98/SD3HSZTc//EoG
         Ac7RTHc5YC6XaahvmRKWO3yxnBbsjPsurprJfMTJIzyZzmroX4Ytop0iyWgJ06dCcKvZ
         geLNYrKGVZpNbUW5w+Wh9P6SZU2ab8d+0rsfG2wahSARu0RbtEO9eCTQoI0dG0Ftv7AE
         CA6rxwRgqKhXHTTYCBzau0SAFUzYT1E6QoTPz0qjcWUmrPHC1fy44FJOrwtFmF1WamUt
         s4Pofhgud61xUdaIcQmb3EeiKlp2X2meiABCv5SqTdPuwnDZsYCVoYYIoFdtBI2sr49C
         mMTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694480210; x=1695085010;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y2KeU1NE47LCW3P4VpCbOe+Lmrn9Jf8vvs/VSfYTWbc=;
        b=CEwP8G5zHctbZW7m5NSbQmrcFpMChk5cMAyTVaBfH2DehlJNVpsZ6lX0rWRAx6+hOd
         62JNsCWBL1qQsUlZjb3O5H+F1oKPaTR2cRSKwLAR8Naoct+c9GERJPNQxMuzMRuAHx6E
         SQA7Ecw7vxNbfytZFl6/xB30T7oPZhSLZhWPHw44lwocn6fz8ToGUb3hsKhUpUzTje0Z
         xGfj+sjc8Y+JztAjyO2/hIhIfvq9eyKSMV/JnPJlapA5ef1AxaYvyoMx0yuGjfYYQTBa
         21PrmMzOHaTX8J9I1CqS2Ych1ASIi0tuxCe/m+YL36KyKKXXrTb0Gug0Rtc4lQ/KjZWz
         iHuw==
X-Gm-Message-State: AOJu0Yymz33hFhXeMjl55cTefjNcI0TeanFH9XezWOzwJYQKaepEVTCs
	xY2iKsmNbZFX/JPiL6fHDCJv2UrO/atzdQ==
X-Google-Smtp-Source: AGHT+IFMXj+wuVn15AUmlPxsrWIXKX3zAJBZ+yukR+f1w3M5pup3zyo/q3H2pKpQJfMZj36qM7ewTA==
X-Received: by 2002:a2e:9e03:0:b0:2bc:f5a0:cc25 with SMTP id e3-20020a2e9e03000000b002bcf5a0cc25mr8350234ljk.2.1694480209540;
        Mon, 11 Sep 2023 17:56:49 -0700 (PDT)
Received: from bigfoot.. (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id gt33-20020a1709072da100b009ad854daea6sm272153ejc.132.2023.09.11.17.56.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 17:56:49 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	sdf@google.com,
	kuba@kernel.org,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next 0/2] Avoid dummy bpf_offload_netdev in __bpf_prog_dev_bound_init
Date: Tue, 12 Sep 2023 03:55:36 +0300
Message-ID: <20230912005539.2248244-1-eddyz87@gmail.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

For a device bound BPF program with flag BPF_F_XDP_DEV_BOUND_ONLY,
in case if device does not support offload, __bpf_prog_dev_bound_init()
creates a dummy bpf_offload_netdev struct with .offdev field set to NULL.

This dummy struct might be reused for programs without this flag
bound to the same device. However, bpf_prog_offload_verifier_prep()
that uses bpf_offload_netdev assumes that .offdev field cannot be NULL.

This bug was reported by syzbot in [1].

[1] https://lore.kernel.org/bpf/000000000000d97f3c060479c4f8@google.com/

Eduard Zingerman (2):
  bpf: Avoid dummy bpf_offload_netdev in __bpf_prog_dev_bound_init
  selftests/bpf: Offloaded prog after non-offloaded should not cause BUG

 kernel/bpf/offload.c                          | 12 ++--
 .../bpf/prog_tests/xdp_dev_bound_only.c       | 58 +++++++++++++++++++
 2 files changed, 65 insertions(+), 5 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/xdp_dev_bound_only.c

-- 
2.41.0


