Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A337642915
	for <lists+bpf@lfdr.de>; Mon,  5 Dec 2022 14:16:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232180AbiLENQm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 5 Dec 2022 08:16:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231183AbiLENQi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 5 Dec 2022 08:16:38 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5542415808
        for <bpf@vger.kernel.org>; Mon,  5 Dec 2022 05:16:31 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id w15so18507395wrl.9
        for <bpf@vger.kernel.org>; Mon, 05 Dec 2022 05:16:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xcw4qNpGYUETmCDRS2Yi1zkEGNky5mw0sbnHLHJX0ok=;
        b=hwwygiXUFyLWWua4Scjet/60CE1KaXsgza7bFJdqtO72g2denx9fctjIMIq3qE64rO
         wlo9psH9lxzOviIr0H35bsC2WSFc0vkCZAMaB5PcpeZUBSGzbFcdBTdEsHJoYhoqseAW
         bQBMZ0Y3DKSWuXEDB0+xk/XrDG3JVhV5dGNkCojC1dP8tr+1FB8MLJpRDr9hxL7kOxLA
         UdSMWeEfwggYJOoYkfgUAJun1vaT+YIZAQTmIRKnFueVWkWFpFh48pRGYw5cYcC5/b4A
         Sp1D1CmKewQkb3v9FyAZiyOEQ8jSmhx+H+2i0bDXrAQAerRUqtq7qJDZXk9PTERuqMEz
         M23w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xcw4qNpGYUETmCDRS2Yi1zkEGNky5mw0sbnHLHJX0ok=;
        b=A/VlrcoWwn0OF+k4RA5ml4VCII18qiQkEhjxXCA7ZfS7w3b+R75myLG0zEYyghebiz
         JVq5HhRmUjoPR57Xs5b0avr8+GYWIllwBPllwoOjVMwLj1vJRr7C6vXse2DDWeYmRRAS
         wm+jhJZs5mIglI6R0DqaPr04FFk4ePjWd3aBLJJgi6kO1Kb2vjts/QfKzhyEIFVrBI+A
         bRy4YYgdufXGMgabxbvprEyVy3GYKX4ZEyPADh2yKWd4LZiEnxs9DhLGBzn47qKKwPGb
         BvloXRyTwKLa9+H1Zi6Ab4HLLq1hqcq4OkdSqkq/QvKkeEuudKIvZDTULq6wL1NWaYd1
         rxQQ==
X-Gm-Message-State: ANoB5plGKLQxSq1g3koi71c8j2l4+JsPrtOGnGBlW+j/S/OS8dMOFzoZ
        8LNnpOIcHQ6la7uX+TB+UGDNRGPQJFIYO7/1
X-Google-Smtp-Source: AA0mqf4lXUiZYFyhMnYEe7t6mW9U0Dej2/rEWl5+iE/Y99Z9cQ8iTtPI97t2iGT/A4axZj5FZod9Vw==
X-Received: by 2002:adf:f1d2:0:b0:242:509a:ad49 with SMTP id z18-20020adff1d2000000b00242509aad49mr5627924wro.345.1670246189410;
        Mon, 05 Dec 2022 05:16:29 -0800 (PST)
Received: from daandemeyer-fedora-PC1EV17T.thefacebook.com ([2620:10d:c092:400::5:48e0])
        by smtp.googlemail.com with ESMTPSA id fc13-20020a05600c524d00b003d04e4ed873sm24710492wmb.22.2022.12.05.05.16.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 05:16:28 -0800 (PST)
From:   Daan De Meyer <daan.j.demeyer@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Daan De Meyer <daan.j.demeyer@gmail.com>
Subject: [PATCH bpf-next 0/3] BPF selftests fixes
Date:   Mon,  5 Dec 2022 14:16:15 +0100
Message-Id: <20221205131618.1524337-1-daan.j.demeyer@gmail.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch series fixes a few issues I've found while integrating the
bpf selftests into systemd's mkosi development environment.

Daan De Meyer (3):
  selftests/bpf: Install all required files to run selftests
  selftests/bpf: Use "is not set" instead of "=n"
  selftests/bpf: Use CONFIG_TEST_BPF=m instead of of CONFIG_TEST_BPF=y

 tools/testing/selftests/bpf/Makefile | 6 ++++--
 tools/testing/selftests/bpf/config   | 4 ++--
 2 files changed, 6 insertions(+), 4 deletions(-)

-- 
2.38.1

