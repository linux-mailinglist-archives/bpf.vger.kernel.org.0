Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEF9162FD7E
	for <lists+bpf@lfdr.de>; Fri, 18 Nov 2022 20:00:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235577AbiKRTAs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 18 Nov 2022 14:00:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242861AbiKRTA2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 18 Nov 2022 14:00:28 -0500
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48CDC29CB2
        for <bpf@vger.kernel.org>; Fri, 18 Nov 2022 11:00:02 -0800 (PST)
Received: by mail-pl1-x644.google.com with SMTP id j12so5353471plj.5
        for <bpf@vger.kernel.org>; Fri, 18 Nov 2022 11:00:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=P89gm69nw6wwqdVHJE6uisz/d4U4qYsA0ojsJOsNWQs=;
        b=ik3a8jQ1qy+IjvqUGieI9JqK3y5hpwMDSFVbFtmrCRyjOkyRyRQqXEG81syacC+KHs
         2aOfcuF283ur2CSP8CuF5bmUfV5LpgnwahnpfYx3VWQKNqZzEaKiP22+No38nTuLysmB
         xdgfB3IP3+mELlNPXULPWKxiLPLUOAqot8Aq8OVY201Q7Ob8Gindcgzaa7Ztdfhc9Mt4
         jRFYLZuiyLlJPd+LIhPYH1h21cbESw4yloWrHHXlM6hFf7pzhnZBTKuPVvGm5Ug6vFqa
         /uI5Gc9FSI2AmqqmPw7o4hieFVvNcfcOYF4Amz1iRKFjkl6jppTRsaX4MtoRQVcRQLUo
         3Q3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P89gm69nw6wwqdVHJE6uisz/d4U4qYsA0ojsJOsNWQs=;
        b=AFDDzcqhn4HnkmkLoCmNDzULsFpNVELS0/ctSqMWOa6GD+HNhWDSQGtk9iaoQCGDjh
         LSbFAlKtuqF5weWyhaSAkNY73G8I1Do4rJmDdCFXC6ZA55wx5a5XxyqwKXJPxhWN1DRR
         eoohpAm2+idZasee3O+9WlY8qCixFL7AXhk+4dN86Sxq/fOijGEkkBF2g6jjjzPFfkME
         O/1pnNLiUYEj4wMllmEUk0jzeBfzpxTxXieFx3FD8IFR0QXmdkJ7oQJ6OujK9wbLtnXT
         Qt5vtYTJODvHJMcPQffDbVw+6vs2zJvJ7JoOflaHA+BgVQBCiF4Vv4txc1wu5foppegj
         VpxQ==
X-Gm-Message-State: ANoB5plIh7cS5mi1Db61x7bJeEmJ9ESt76os89XBFbFqSMrFCP+86Tlk
        FaK4Q1hJkDpegS5491TDtjv5dB2tHaU=
X-Google-Smtp-Source: AA0mqf664EOFfgNCWSbUvNsi3C9P/8KTiBSZLQsZ8tBpiR7OP+4g/VaFFlnk0BfZH/7q8kt0w05K2A==
X-Received: by 2002:a17:90a:4049:b0:210:5de0:f3e3 with SMTP id k9-20020a17090a404900b002105de0f3e3mr9003056pjg.61.1668798001397;
        Fri, 18 Nov 2022 11:00:01 -0800 (PST)
Received: from localhost ([14.96.13.220])
        by smtp.gmail.com with ESMTPSA id x12-20020a17090a46cc00b0021877447313sm3401941pjg.24.2022.11.18.11.00.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 11:00:01 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v1 0/2] Follow ups for bpf-list set
Date:   Sat, 19 Nov 2022 00:29:36 +0530
Message-Id: <20221118185938.2139616-1-memxor@gmail.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=674; i=memxor@gmail.com; h=from:subject; bh=zRUKWYRYvUG6VgW42zgrRASkYPUuMNy6WdK5/jll+r4=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjd9Wi/uWR8s3i5dXGubNyDr5VRrv/dFPv1MdOX0qb hWEFXX6JAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY3fVogAKCRBM4MiGSL8RypjvEA CAw7siJyTjtlVvVPSydSuw15S0jxFhQyeF5QVzr3C+g9CBMyZq++8IFW9efKb6jvkT+eworgAQZHCV m3jkSA8OeMY3jcjJenqXc/s8ypChwf0rfSsUyf3ZaxZeNYUSn3ZQ7p15oWL15fH5ZPZFroVbi0F/4+ 9x4NGdfwC5+7GcmCK07LteVz2h+G5W0gTOeYhuDTXEEmlmdDMBMDQwzPPYwBcEc7udKRIMzcoXvPpF cRvLEBSCpJ1yGzF15RxoFFwNvLNaqgVooWIjjwqhw2SKPJAbLGBBJDKXV/jux3TJVd8yd4OuxU6U41 An+L3h8XVA2RU/1rvD3BkGqlYDzSoG3SfU9t4AkL5VSJ0eXTLPn/S0vfQj0lekA+Vk2ehg0PZZu2uC q+gappZeTYz0oswnmucEGWoPQe8D76EOeS73oY++o2pzxeWWjSR7FBp9X1g7+53GymwGKG39xM+sw2 ED3ssYnBFUfSs3rk+bD2ag04EmnPko5LOG6v1Cyjc6ipcyH/EH+3fQKLKzExvRRFDavISyQiDbHdlY Dcm562GUzcNRXEpHqXYsKArvmBRi+zK0wwSQ1z7jjgHbdO824n2oO8yumRBtMewaFoxlyIaTuak5fa f6jrrZ1dPo6VXrQ3URi8IIukFy25fuM/ATjYrq6JWEX7/Y/5AFAyR+S5fFbw==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
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

Make a few changes
 - Remove bpf_global_ma_set check at runtime, disallow calling bpf_obj_new during verification
 - Disable spin lock failure test when JIT does not support kfunc (s390x)

Kumar Kartikeya Dwivedi (2):
  bpf: Disallow calling bpf_obj_new_impl on bpf_mem_alloc_init failure
  selftests/bpf: Skip spin lock failure test on s390x

 kernel/bpf/helpers.c                               |  2 --
 kernel/bpf/verifier.c                              | 13 ++++++++++++-
 tools/testing/selftests/bpf/prog_tests/spin_lock.c |  6 ++++++
 3 files changed, 18 insertions(+), 3 deletions(-)


base-commit: db6bf999544c8c8dcae093e91eba4570647874b1
-- 
2.38.1

