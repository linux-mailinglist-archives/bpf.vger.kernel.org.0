Return-Path: <bpf+bounces-514-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 657A5702D9A
	for <lists+bpf@lfdr.de>; Mon, 15 May 2023 15:09:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18FCF1C20A3D
	for <lists+bpf@lfdr.de>; Mon, 15 May 2023 13:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1EF4C8EA;
	Mon, 15 May 2023 13:09:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9195B79D4
	for <bpf@vger.kernel.org>; Mon, 15 May 2023 13:09:23 +0000 (UTC)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5C702D60
	for <bpf@vger.kernel.org>; Mon, 15 May 2023 06:09:02 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1addac3de73so29144515ad.1
        for <bpf@vger.kernel.org>; Mon, 15 May 2023 06:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684156139; x=1686748139;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sb72djRxUVLreFcMC0IPWwh0eEe6IWnt64V/dstWQOg=;
        b=ifmh6FqBPOPePRThUvfEyj/oB9gfzfk/ReSI17ZVqAA7ewAJUqd64tLEIhfpHFImyS
         gUpa3TmCpsUtHxEjUMbKwudR9WzHvsx5LglB4NuBZ5jXj58sViSXCxgoeO4Fp1cqJnUs
         kIYnQA2DWcT2OU7LpCZfxo4xHRZ5EXPnEANTbyJBwWQcIQFjSTkDdE0aNzIE0Y5fP/k5
         wrkNbPQDo4er7C8sTPhk0Nsku4LbUuzQrXefMaUK/zY5e0k6tCIuTO3J45TDlsZEUt65
         eGhiNaMdOBXp+Bxoqs/LTtHAhZt0RVH2biG2tdr6HSQQqAHtDbsQk+lDuWJrNuAwgSxA
         RR3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684156139; x=1686748139;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sb72djRxUVLreFcMC0IPWwh0eEe6IWnt64V/dstWQOg=;
        b=GYim+AMtlTieQorSLhPGeBZG0p+JQQIECQvpSDIhKXqHnj++qk3KqFM1+IG+tMhaZO
         +PG0N3o+LsbJFKvBkGTkMBDjmdHrHSDbZRbLXv/dlp5eU+xy9ZxYa5EnluOvaK2bgC8V
         Jhixz4YR+KfQGVn46Pep3WpRcI22v/qGY/MD62m5OsGrN+nKelhLBXo9PQ5N2gjKHjQu
         Ae5mfBcVAqm8kQDvYu4Dr0lwOvWy+mvc7ZXON31x3rFaRABG0CA5CD62D9IFAF2osP0e
         Xk2Dn9lGhkBnQeyIuIQnUeXq33/2pniC54f5zUBsBlKkmnYxzZXBBro7GbjhNb3tERew
         P+BA==
X-Gm-Message-State: AC+VfDxVTJPQgOSCUIdIK3RgrcyHeO8FxOwIm6HgzzJIpVhG9r9wwYCh
	MqiQ/S5o0EjYb/ua/uKI0uE=
X-Google-Smtp-Source: ACHHUZ6Zmu8g1v8XX1vcRiyLrm748RqctyrzbUsxbpZD8z4vgE9jQdoaPsUvNR5g0kB+FI03uOys4w==
X-Received: by 2002:a17:902:e810:b0:1a6:7ed0:147e with SMTP id u16-20020a170902e81000b001a67ed0147emr46633924plg.33.1684156138613;
        Mon, 15 May 2023 06:08:58 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:ac01:991:5400:4ff:fe70:1e06])
        by smtp.gmail.com with ESMTPSA id h5-20020a170902748500b001ac2a73dbf2sm13458723pll.291.2023.05.15.06.08.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 06:08:57 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	kafai@fb.com,
	songliubraving@fb.com,
	yhs@fb.com,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org
Cc: bpf@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH bpf-next v2 0/3] bpf: bpf trampoline improvements 
Date: Mon, 15 May 2023 13:08:46 +0000
Message-Id: <20230515130849.57502-1-laoar.shao@gmail.com>
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

When we run fexit bpf programs (e.g. attaching tcp_recvmsg) on our servers
which were running old kernels, some of these servers crashed. Finally we
figured out that it was caused by the same issue resolved by
commit e21aa341785c ("bpf: Fix fexit trampoline."). After we backported
that commit, the crash disappears. However new issues are introduced by
that commit. This patchset fixes them.

PATCH #1: Fix a memory leak found on our server
PATCH #2: Remove bpf trampoline selector and also fix the issue in perf
          caused by the name change in bpf trampoline
PATCH #3: Show target_{obj,btf}_id when link to a bpf trampoline

v1->v2:
- Reuse the common code between __bpf_tramp_image_put_deferred and
  bpf_tramp_image_free (Song)
- Add fixes tag in patch #1 (Song)
- Restore the old bpf trampoline name format (Song)
- Jiri pointed out a issue in perf
- Show btf information in the tracing link info

Yafang Shao (3):
  bpf: Fix memleak due to fentry attach failure
  bpf: Remove bpf trampoline selector
  bpf: Show target_{obj,btf}_id in tracing link info

 include/linux/bpf.h      |  1 -
 kernel/bpf/syscall.c     | 12 ++++++++++--
 kernel/bpf/trampoline.c  | 32 +++++++++++++++++++-------------
 tools/bpf/bpftool/link.c |  4 ++++
 4 files changed, 33 insertions(+), 16 deletions(-)

-- 
1.8.3.1


