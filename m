Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B5824AC21A
	for <lists+bpf@lfdr.de>; Mon,  7 Feb 2022 15:58:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358623AbiBGO5E (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Feb 2022 09:57:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442509AbiBGOwS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Feb 2022 09:52:18 -0500
Received: from mail-vk1-xa2e.google.com (mail-vk1-xa2e.google.com [IPv6:2607:f8b0:4864:20::a2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECDCAC0401C1
        for <bpf@vger.kernel.org>; Mon,  7 Feb 2022 06:52:16 -0800 (PST)
Received: by mail-vk1-xa2e.google.com with SMTP id y192so7940232vkc.8
        for <bpf@vger.kernel.org>; Mon, 07 Feb 2022 06:52:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kinvolk.io; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xjCnOU0sLvWX+vekLxUSA4g/zhKs1G47jm1FsaM9SkY=;
        b=avISx7AaE3dddYOA5hk9MWO/39e1yUX4nZZIuwMN/T+U2M6SC+lHp5EPEbzsvVdlsX
         uX/w9sHAauQduMNXqxpSIPTEIrDaqcx1/pJ/AUapN1wVuwWdW4ZeulQLamNUZbqvACtN
         td3rUUqWcai8mQ1ODsY/T23oHO6djLAsQqg0w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xjCnOU0sLvWX+vekLxUSA4g/zhKs1G47jm1FsaM9SkY=;
        b=xO0OggYOD/IB9WYfvZKWKHYjd2K6Am8tBxgDfN7lE2oWi1hcfjJ/WCVrvaku1xLKrr
         fs6uPLcqo19akSnzV7LnfAxxb4Uu8gqw6FF7zpzXk5rEY+YTvcXvfbNxxGmy2NpoAtE3
         UXugQ/rJoVlsNs4sUNCx0Mfgi2RXDTC5wsMAMzPMjMqrQDzGIsInnCXFRMK4ZcB/AfbN
         Tqsm+3bHawuMtPSyV3v86hDsh+AwSY+BSEKqPmg+ev2ipTnHfJi3cMdYeraTT6BW0WC7
         MoKtrr+qwEPLLrUYJB2MG6OuWLbTvh8e1vEMPcIVPwEeeZCNgf5apFE/ojT39XtWFweo
         w77A==
X-Gm-Message-State: AOAM533RESRmr34Kda59KkzXqY4Jwed+dd6ptxdIr8L284/cQ8xTm+Jn
        Ev8S/8XUZVijHXLiVjn0x864Iw==
X-Google-Smtp-Source: ABdhPJy8fboLlgBsr7NTyQTdbL6k86RpEJ9ALKHfTiQ8ly9f0OpXci9S+ZlTSMzOkryZUrHCngj/2w==
X-Received: by 2002:ac5:c94f:: with SMTP id s15mr5005605vkm.35.1644245535145;
        Mon, 07 Feb 2022 06:52:15 -0800 (PST)
Received: from localhost.localdomain ([181.136.110.101])
        by smtp.gmail.com with ESMTPSA id r14sm581347vke.20.2022.02.07.06.52.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 06:52:14 -0800 (PST)
From:   =?UTF-8?q?Mauricio=20V=C3=A1squez?= <mauricio@kinvolk.io>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Quentin Monnet <quentin@isovalent.com>
Subject: [PATCH bpf-next v2 0/3] bpf: Fix strict mode calculation
Date:   Mon,  7 Feb 2022 09:50:49 -0500
Message-Id: <20220207145052.124421-1-mauricio@kinvolk.io>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This series fixes a bad calculation of strict mode in two places. It
also updates libbpf to make it easier for the users to disable a
specific LIBBPF_STRICT_* flag.

v1 -> v2:
- remove check in libbpf_set_strict_mode()
- split in different commits

v1: https://lore.kernel.org/bpf/20220204220435.301896-1-mauricio@kinvolk.io/

Mauricio Vásquez (3):
  libbpf: Remove mode check in libbpf_set_strict_mode()
  bpftool: Fix strict mode calculation
  selftests/bpf: Fix strict mode calculation

 tools/bpf/bpftool/main.c                     | 5 +----
 tools/lib/bpf/libbpf.c                       | 8 --------
 tools/testing/selftests/bpf/prog_tests/btf.c | 2 +-
 3 files changed, 2 insertions(+), 13 deletions(-)

-- 
2.25.1

