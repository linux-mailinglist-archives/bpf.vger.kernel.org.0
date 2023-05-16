Return-Path: <bpf+bounces-637-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51BF2704DF0
	for <lists+bpf@lfdr.de>; Tue, 16 May 2023 14:39:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BBD428130B
	for <lists+bpf@lfdr.de>; Tue, 16 May 2023 12:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 004C71EA8A;
	Tue, 16 May 2023 12:39:36 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B4E34CD9
	for <bpf@vger.kernel.org>; Tue, 16 May 2023 12:39:36 +0000 (UTC)
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3532170E
	for <bpf@vger.kernel.org>; Tue, 16 May 2023 05:39:35 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-643995a47f7so14581305b3a.1
        for <bpf@vger.kernel.org>; Tue, 16 May 2023 05:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684240775; x=1686832775;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gbBgyDjCHiOlElHrx1/Owz/pc+UIwRwUmQEL4FGXBGE=;
        b=lGbEP8/YpDseI8p0TW94jaHheLZANZDNEpSVFtRNd5k8cTsJVaVnhwE7f7MYZScaA8
         +RHmWspJAt8aVk6xac8uvvNjHmReDYtbAjViyuW5osCxoVebb4S/bJXOK5csAWUT1f1Q
         802bIHhB/SwHFLig8yMBt6AQymJ/GlmhHlpNDdaaogDDWIHQhnpuH21G8VJfhcb8C+zt
         FSZNh6p0dF2WDHt+EVaSbmpwPhYHqHePb+yV/k4TCg/6yNxbe69SfPYFCfIdBcemVIph
         EIHvOHmriPB1A2mzNFR7u9VtF83OyebCZ99RGtQP1nPdCYSX5ASNyN35Mu0wC3z4djCF
         Lrlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684240775; x=1686832775;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gbBgyDjCHiOlElHrx1/Owz/pc+UIwRwUmQEL4FGXBGE=;
        b=F3wwaqbKMkq7xU1qirRnX0gMsNh84B1ddcsWu4PytzP7/8qHVbhH76hU6zU6etZ+/V
         PD2fbQ76qLNfPAJkAJCXDDlS5+u3AdQjvVtjdQ5uz4nS0fuehvIt9AhbJZRU+390yml6
         F/KgtSMy/LZwirSWyaCvd73j9Z75OVvpKVHRzwLDVcO6spX/bGy5ZiwQtKvBm9BlRoz5
         ek+wo8mlgrJmjtVs/TyfxVV4MJc8HHIivcJw9bmvS0Q2/pit4E3yTGisxoRlXcFdIJI+
         ucFIw3NmnYtJYxcT0a1+Pl3XYdanz1iwYcN8H/MrlMOdKg773ILeMX8VmX6slDTs5AOb
         GvaQ==
X-Gm-Message-State: AC+VfDxHezc9/9/QIYJym99w3IBiUIfjF2ABiBwjYWeCZ1mgPGZY9qrZ
	O7q9r14s4i9p+xP+GGNb1v8OzuT7nMFlI5fi
X-Google-Smtp-Source: ACHHUZ6+WQzwJHjPraaiFLpL52jq4mL1G964wzZomcei3VYET1OeZQTW3bAfb7Yv4n2IHs3p++wG4A==
X-Received: by 2002:a05:6a00:1749:b0:64a:f730:154b with SMTP id j9-20020a056a00174900b0064af730154bmr16368785pfc.5.1684240775008;
        Tue, 16 May 2023 05:39:35 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:8001:1799:5400:4ff:fe70:6970])
        by smtp.gmail.com with ESMTPSA id c20-20020a62e814000000b0063b8ddf77f7sm13156984pfi.211.2023.05.16.05.39.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 05:39:34 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: song@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	kafai@fb.com,
	yhs@fb.com,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org
Cc: bpf@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH bpf-next 0/2] bpf: Show target_{obj,btf}_id for tracing link 
Date: Tue, 16 May 2023 12:39:24 +0000
Message-Id: <20230516123926.57623-1-laoar.shao@gmail.com>
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

Yafang Shao (2):
  bpf: Show target_{obj,btf}_id in tracing link fdinfo
  bpftool: Show target_{obj,btf}_id in tracing link info

 kernel/bpf/syscall.c     | 12 ++++++++++--
 tools/bpf/bpftool/link.c |  4 ++++
 2 files changed, 14 insertions(+), 2 deletions(-)

-- 
1.8.3.1


