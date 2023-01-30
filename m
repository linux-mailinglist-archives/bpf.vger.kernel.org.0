Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7F0468190B
	for <lists+bpf@lfdr.de>; Mon, 30 Jan 2023 19:27:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238168AbjA3S1C (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 30 Jan 2023 13:27:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238175AbjA3S0Z (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 30 Jan 2023 13:26:25 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04F5145BC9
        for <bpf@vger.kernel.org>; Mon, 30 Jan 2023 10:24:32 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id hn2-20020a05600ca38200b003dc5cb96d46so1734673wmb.4
        for <bpf@vger.kernel.org>; Mon, 30 Jan 2023 10:24:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CrFjhsushz9KytBr1hsY5Utqd1ZmIg/BI0yuYvikMoo=;
        b=BO66Rg4o17zpgBCsTSj0bulnaHv0rB4L8Fme82R3UounksZKkyqXm3JurmnM1AOhL4
         lLaeiAeWGOOL0c+xMdVXoRGADnn64pseTKa/rpZx8D9beAsk78MPQJEP1TqYw48jAQuz
         0N7cz0IJVVjpGhH2dO+uRhzsosp/CX7Iz5FrGjbLh7Lz1ov8Lmr/Gql9PxNv85xp08pa
         nwFYgEVkI3NSHv05G/lKx8CGix6Yexqdna3jGHIGrA72YJs4Z91GTtTl8XAtLao5GqDO
         3wyu6RI2uwluv2yz+/Z2hCOVSk39eJq1FXlet+eLe39xPReXzW+GjrzR/OvQcSB5/1oI
         kAxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CrFjhsushz9KytBr1hsY5Utqd1ZmIg/BI0yuYvikMoo=;
        b=KNzonPmDMNG31vETqwwhzj8wVvFIfuyVMB56Y9P8KW1GFiNmkrp5tuJoC95KZBiaNo
         CG7LF4O8x8zyUJ7+xA4UCiwmDY0uY27Pkj2mkUs1PN79aG4ocSsrjAXzQAqx2Dg8aX3p
         oxRcLwphk++8rqF9q/Ik1F6WYAYSBXeFYFqfwKvGwb4WqqsDkOKhMKnCWE0FKMqTHEhu
         DbAaoHKhYr9psUcJmc6lya3kQ2ID2IeRdmltyIwe1dADze+/tMt2mCofy2P1yVa1O7Bi
         uTmWsyPoWxKHJFuQmfdZUv2Vvg+A7jzZazcDdpK/Ft/YcObf87KTzSd1qahMDg7RmX/B
         7BDg==
X-Gm-Message-State: AO0yUKWNWI4sQD0SRXrLJtZUG06RDGcqSItJWBQH+jFejztxuv5jzrrw
        tkGRjMNe3lin9j1UPOf4mYJzH29DZVQ=
X-Google-Smtp-Source: AK7set9i7Obykp6jkXCbFftYpbeRt09KWKTH6Xam0frF871kKM6ZdgpHki5Agh+83WmmnzOIpiTb1Q==
X-Received: by 2002:a05:600c:1c83:b0:3dd:1a8b:7374 with SMTP id k3-20020a05600c1c8300b003dd1a8b7374mr1402682wms.5.1675103067401;
        Mon, 30 Jan 2023 10:24:27 -0800 (PST)
Received: from pluto.. (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id fl22-20020a05600c0b9600b003d1e3b1624dsm17831712wmb.2.2023.01.30.10.24.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 10:24:26 -0800 (PST)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        kernel-team@fb.com, yhs@fb.com,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v2 0/1] docs/bpf: Add description of register liveness tracking algorithm
Date:   Mon, 30 Jan 2023 20:23:59 +0200
Message-Id: <20230130182400.630997-1-eddyz87@gmail.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

An overview of the register tracking liveness algorithm.
Previous version posted here: [1].
This update includes fixes suggested by Andrii Nakryiko:
- wording corrected to use term "stack slot" instead of "stack spill";
- parentage chain diagram updated to show nil links for frame #1;
- added example for non-BPF_DW writes behavior;
- explanation in "Read marks propagation for cache hits" is reworked.

[1] https://lore.kernel.org/bpf/20230124220343.2942203-1-eddyz87@gmail.com/

Eduard Zingerman (1):
  docs/bpf: Add description of register liveness tracking algorithm

 Documentation/bpf/verifier.rst | 266 +++++++++++++++++++++++++++++++++
 1 file changed, 266 insertions(+)

-- 
2.39.0

