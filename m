Return-Path: <bpf+bounces-11250-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 818787B648C
	for <lists+bpf@lfdr.de>; Tue,  3 Oct 2023 10:44:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 7F0B9281681
	for <lists+bpf@lfdr.de>; Tue,  3 Oct 2023 08:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C7F9DDB1;
	Tue,  3 Oct 2023 08:44:10 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3B13FC2
	for <bpf@vger.kernel.org>; Tue,  3 Oct 2023 08:44:08 +0000 (UTC)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEDE9A7;
	Tue,  3 Oct 2023 01:44:06 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1c61acd1285so4676975ad.2;
        Tue, 03 Oct 2023 01:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696322646; x=1696927446; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hquSg/aXE1/u0q+geoga44KI7IqOR8LfjmqgUyTNI18=;
        b=jorcgsJsHndmaBwaDIp3k3yTSYDqoe1fQhaSXblOGBuK4bxXqTvrFLqK1CRQB6Occ/
         PLuGiApFSpP2Zgofo9eO7q5H2k2oprrWaGKJuisCQKY4D3VXtXxy4iqXSWbmoA210b1a
         OSO3QifmObtABRGPK+gYtwk2JoEQgBPnRTRJxsxSxgEkeQ5m8CGgjXzplyBdHI8ZYEPB
         mS17nsGlaPKPSyoXXi3CAOX9PYSOHpEKhC2++T1emqgv0kkBo6FVPmXvYPCeSY4JSBb+
         AJy2TIPra3ZCWEorT376zGQEXdIXpanwFjYWTPmWpGDUApxYL5FPlPUVRfzF847AwhSh
         0gsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696322646; x=1696927446;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hquSg/aXE1/u0q+geoga44KI7IqOR8LfjmqgUyTNI18=;
        b=JTrpBFV6Gx5KGSk0vZ6MyRjoGPrzqXfB5nytxNv3f6eiGNWsH9+cfPa0b1kLDFeoI2
         q0DRsb6pZ8U/1GT/xmze5/P9wHVYRvVklxzovXyfJ+yogJKYd0xfpiR5Z2iNRyhgJXxW
         MofKqkuIStx04C/c+jO/8osUObJ6hd0ke6EC55xMmcHqKr1YDQURB289aliWoo3ZHdUU
         nK85miuWbibNrHZt3ObtUhdoaOuf9lxTUlWb3kJWXZyJYHyiDtgFNrKhs6Tx+hczE/rH
         UefSMNIJj8KD+yphTxXkJcBCyRvhUrDFDozDiB1cGGueiY0vTml7FiEy2XwMr6Z2O9X0
         YD4g==
X-Gm-Message-State: AOJu0YyrLB0w09oatI8HUR3eb/Ixt+lKwJ2vR0VdKdUGoonteN/Liny+
	Gqnbdo6Vik7J8U+bIHSdH0jXkxVB1/LJzsbr
X-Google-Smtp-Source: AGHT+IFahaYX8CalAWykz4EmSxSLX/A1YkzBiU22esy/Jzm208wCFO9H+cs8MAxy97khUrV3LOhsmg==
X-Received: by 2002:a17:902:d490:b0:1c0:c640:3f3e with SMTP id c16-20020a170902d49000b001c0c6403f3emr14443148plg.42.1696322645982;
        Tue, 03 Oct 2023 01:44:05 -0700 (PDT)
Received: from ubuntu.. ([113.64.184.44])
        by smtp.googlemail.com with ESMTPSA id y16-20020a17090322d000b001bc445e249asm902876plg.124.2023.10.03.01.44.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 01:44:05 -0700 (PDT)
From: Hengqi Chen <hengqi.chen@gmail.com>
To: linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Cc: keescook@chromium.org,
	luto@amacapital.net,
	wad@chromium.org,
	alexyonghe@tencent.com,
	hengqi.chen@gmail.com
Subject: [RFC PATCH 0/2] seccomp: Split set filter into two steps
Date: Tue,  3 Oct 2023 08:38:34 +0000
Message-Id: <20231003083836.100706-1-hengqi.chen@gmail.com>
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
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This patchset introduces two new operations which essentially
splits the SECCOMP_SET_MODE_FILTER process into two steps:
SECCOMP_LOAD_FILTER and SECCOMP_ATTACH_FILTER.

The SECCOMP_LOAD_FILTER loads the filter and returns a fd
which can be pinned to bpffs. This extends the lifetime of the
filter and thus can be reused by different processes.
With this new operation, we can eliminate a hot path of JITing
BPF program (the filter) where we apply the same seccomp filter
to thousands of micro VMs on a bare metal instance.

The SECCOMP_ATTACH_FILTER is used to attach a loaded filter.
The filter is represented by a fd which is either returned
from SECCOMP_LOAD_FILTER or obtained from bpffs using bpf syscall.

Hengqi Chen (2):
  seccomp: Introduce SECCOMP_LOAD_FILTER operation
  seccomp: Introduce SECCOMP_ATTACH_FILTER operation

 include/uapi/linux/seccomp.h |   2 +
 kernel/seccomp.c             | 138 ++++++++++++++++++++++++++++++++++-
 2 files changed, 136 insertions(+), 4 deletions(-)

-- 
2.34.1


