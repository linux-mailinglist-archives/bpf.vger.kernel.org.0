Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97AC55F4BD5
	for <lists+bpf@lfdr.de>; Wed,  5 Oct 2022 00:27:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230255AbiJDW13 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 4 Oct 2022 18:27:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbiJDW12 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 4 Oct 2022 18:27:28 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BF6D6CF7E
        for <bpf@vger.kernel.org>; Tue,  4 Oct 2022 15:27:28 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id x185-20020a6386c2000000b004574f1d1456so843515pgd.5
        for <bpf@vger.kernel.org>; Tue, 04 Oct 2022 15:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date;
        bh=6OQUQx0K53eeJALgpVT6lv3YYXQLUU2j57sEhIsHVkc=;
        b=pIZnIjI3P4KCHCikQ3XDXb1gPX2bccD7trNOgQziL5WgsOpD87zAdq26wuEfE9dUan
         hsT5apiTQBvUcfCgf5BJ9S4pqbqfFIlA2nvExYnSqO1s7t/tHy/t8W1tNnAl4Y8GQVEm
         Jb1jqWi+ks/dbK9mXBFaeyqz6D662xf8jdn1O2aa16t2m57uT8MpmQjQwEvmu4eAAJBM
         kCfVxU3GXBfLVGDWn4KC7ri9N2h/gmct9vgb6h9Gde7xUERYXy18mOWpQf2Z+I/+T0Gi
         Ne6536HMtNTKKxH3zzRCayV1OBNIJX3hh8/w63ZNGQNJw1uFBm9XtNmhxY5liTW63aJj
         uv8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date;
        bh=6OQUQx0K53eeJALgpVT6lv3YYXQLUU2j57sEhIsHVkc=;
        b=ra07hEmqiQz9elRf0qvyQbC+xDsY2XzJToCj9YlIjqeLRXX51VhY0vZ2rZu5TeArNg
         OyaTw6UcbNAoUw/opQZnrofhp6tNWqMPRIqHpZK3ji61/UU98E1BzeBd29ejkjzOW7Ga
         uuWLIT0arD0z9sXeRJsEUy9U0BELut+M6XKep8v1x/FEblZzt4ZBC7+9FHOWU0n82NjM
         Xjyeglj9yXSDsbiQAUpkYDxat4m3UN0Ac7LC9u6GCPBMNygQ/WTYr4Ej4EHj11n47nqG
         gi6BwLUxt623wmXycINU9y0EGCtC1kZqzamxkSCXw6PaC2oPRPoOEX7SsMuOB2hc+EJB
         BSUw==
X-Gm-Message-State: ACrzQf2lz8y7F7wp20AtnWL0bkw8M904CCaxZDeEc1h1jJNsjz9Pqog/
        t2M7QLNx24EFDhkyplz5L63eSjnuT4pZWE57Yp20/ExMK/uug6sL/0R9GRa8ZiUEa4qXaEUQC/j
        OUzLnD/RKDynLQPuwounuRwT3doVYSXYNvI29feX5jAWttljWdA==
X-Google-Smtp-Source: AMsMyM4w0i2esC8D6YTJg8ThnfYPyrruVw7qm8QTsPMInJlbNRSjXz2CURcpwbEKgV63vSAO0wScn7I=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a62:84c6:0:b0:538:3c39:5819 with SMTP id
 k189-20020a6284c6000000b005383c395819mr29856232pfd.4.1664922447414; Tue, 04
 Oct 2022 15:27:27 -0700 (PDT)
Date:   Tue,  4 Oct 2022 15:27:25 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
Message-ID: <20221004222725.2813510-1-sdf@google.com>
Subject: [PATCH bpf] bpf: make DEBUG_INFO_BTF_MODULES selectable independently
From:   Stanislav Fomichev <sdf@google.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

We're having an issue where we have a recent clang that seems
to generate kind_flag for enums (aka, adding signed/unsigned).
Trying to install a module on a kernel that doesn't have commit
6089fb325cf7 ("bpf: Add btf enum64 support") returns the following:

[    3.176954] BPF:Invalid btf_info kind_flag

The enum that it complains about doesn't seem to have anything special
except having a sign:

[1721] ENUM 'perf_event_state' encoding=SIGNED size=4 vlen=6
        'PERF_EVENT_STATE_DEAD' val=-4
        'PERF_EVENT_STATE_EXIT' val=-3
        'PERF_EVENT_STATE_ERROR' val=-2
        'PERF_EVENT_STATE_OFF' val=-1
        'PERF_EVENT_STATE_INACTIVE' val=0
        'PERF_EVENT_STATE_ACTIVE' val=1

We are not currently using CONFIG_DEBUG_INFO_BTF_MODULES and
don't plan to use module BTF, so it's preferable to be able
to explicits disable it in the kernel config. Unfortunately,
because that kconfig option doesn't have a name, it's not
possible to flip it independently from CONFIG_DEBUG_INFO_BTF.
Let's add a name to make sure module BTF is user-controllable.

(Not sure, but maybe the right fix is to also have a stable patch
 to relax that "Invalid btf_info kind_flag" check?)

Fixes: 5f9ae91f7c0d ("kbuild: Build kernel module BTFs if BTF is enabled and pahole supports it")
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 lib/Kconfig.debug | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index c77fe36bb3d8..6336a697c9f5 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -326,6 +326,7 @@ config PAHOLE_HAS_SPLIT_BTF
 	def_bool $(success, test `$(PAHOLE) --version | sed -E 's/v([0-9]+)\.([0-9]+)/\1\2/'` -ge "119")
 
 config DEBUG_INFO_BTF_MODULES
+	bool "Generate BTF module typeinfo"
 	def_bool y
 	depends on DEBUG_INFO_BTF && MODULES && PAHOLE_HAS_SPLIT_BTF
 	help
-- 
2.38.0.rc1.362.ged0d419d3c-goog

