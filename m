Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90CFE6E040E
	for <lists+bpf@lfdr.de>; Thu, 13 Apr 2023 04:22:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbjDMCWA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 Apr 2023 22:22:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjDMCV7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 Apr 2023 22:21:59 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 573E5B1;
        Wed, 12 Apr 2023 19:21:58 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id he11-20020a05600c540b00b003ef6d684102so5493876wmb.3;
        Wed, 12 Apr 2023 19:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681352517; x=1683944517;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6EgaZL3nK+hwV0Rf0hH+6JI5pNq887lqcmw+N61ADmM=;
        b=T26/b64wbgrv7wf0zfy1HW8SwlLwsRXJe0QvrCrQcBhQpy1o4ngOXV65EzRO35NMXd
         r40rqTyW0a583Z15/l5egWHW7VKs/ALKbJwY8Z4Skj4vAq6MmoXYib52857OHJmkpfG0
         gDuICW3YwY5jZrSK7TpJZljngPoDbYoglH1A42UADFPu4Za6tZjmp8TND5YnWYblG2gE
         B2pg8uCcnptN6aLO1EJnRmMJ6cQ7vpGi/fDl0SBB7WVGDyhljti9MBLii2Y7vrhtFXBX
         dJSUJTaPHjKIuybxM/pFdMaQ5hXhTbuqapBvwzt8+8aVDQnAzAaGlql2eVjWKEekN0eW
         64XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681352517; x=1683944517;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6EgaZL3nK+hwV0Rf0hH+6JI5pNq887lqcmw+N61ADmM=;
        b=TXTgpvX/wrU3FHCLehjCpClYu45UHuATy9F+7nYl52U56mGdSkZc9mTRRsouZ13zQj
         pFJwJesiXXCAdw3Te0jHtUr/2oZY6RdYH/2gY6VjpQsl63wq1giWrV2612ldZfIRMxpd
         XtYVKaQabx4y/q46ne+YMdoT6qXrb3T1qpk565EUbXRRBI3/6GWcsPMBWg7IX6OJIW2j
         exlqS03yIPW5eHhlUJ/Xa50Dp9IhNM8bNh6ACO+8szqsFo9Qurkl01T79ik2qg9VHnNY
         1ji39TBjBM72OY07Kqots+Ikw0h8biXLnWvVK5tEtII/9Yx03ThPhBvEyfZnfFvBMMqL
         NfcA==
X-Gm-Message-State: AAQBX9fXv43LddRm3xFRZUj/6SPFz8HO/H70g++J3wIJq14xXBh2xta7
        mKxxd61/qLkhc4ZsNt0oEiI=
X-Google-Smtp-Source: AKy350a81+JQ4WBfadTrWiLGGkjeN045J/MW6Htr6piGqU9rbjWWtMfzhcRD0BXd3dJHhdT/aTy62Q==
X-Received: by 2002:a7b:cd8c:0:b0:3ee:4dc0:d4f2 with SMTP id y12-20020a7bcd8c000000b003ee4dc0d4f2mr458978wmj.41.1681352516646;
        Wed, 12 Apr 2023 19:21:56 -0700 (PDT)
Received: from solpc.. (67.pool90-171-92.dynamic.orange.es. [90.171.92.67])
        by smtp.gmail.com with ESMTPSA id z12-20020a1c4c0c000000b003f0824e8c92sm518988wmf.7.2023.04.12.19.21.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 19:21:56 -0700 (PDT)
From:   =?UTF-8?q?Joan=20Bruguera=20Mic=C3=B3?= <joanbrugueram@gmail.com>
To:     jpoimboe@kernel.org
Cc:     i.pear@outlook.com, acme@kernel.org, alan.maguire@oracle.com,
        alexandref75@gmail.com, bpf@vger.kernel.org, dxu@dxuuu.xyz,
        jforbes@redhat.com, linux-kernel@vger.kernel.org,
        olsajiri@gmail.com, peterz@infradead.org, ptalbert@redhat.com,
        yhs@fb.com
Subject: Re: [PATCH] vmlinux.lds.h: Force-align ELF notes section to four bytes
Date:   Thu, 13 Apr 2023 02:21:49 +0000
Message-Id: <20230413022149.94781-1-joanbrugueram@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230412163016.5p7wve3meeahdecp@treble>
References: <20230412163016.5p7wve3meeahdecp@treble>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

I have done some tests with Arch Linux which is also affected by this issue:

Base scenario: Running Arch Linux updated as of 2023-04-13.
               Building the linux-mainline 6.3rc6-1 from AUR
               (https://aur.archlinux.org/packages/linux-mainline)
               with CONFIG_X86_KERNEL_IBT changed to 'y'
Result:        Build fails with the "btf__dedup failed!" error

Test 1: Update dwarves (=pahole package on Arch Linux) from the current version
        (1:1.24+r29+g02d67c5-1) to the staging version (1:1.25-1).
Result: The build works correctly.

        However, the notes section is still not parsed correctly, as confirmed
        by `readelf -n` or adding a printf near the code on `cus__merging_cu`
        (on `dwarf_loader.c`) pointed to by Tianyi.

        A bisect shows the commit that fixes the build is
        a9498899109d3be14f17abbc322a8f55a1067bee
        "dwarf_loader: Fix for BTF id drift caused by adding unspecified types"
        I don't know why though.

Test 2: Applying Josh's patch to force-align the ELF notes section to 4 bytes
        (clarification: using the base pahole version again here)
Result: The build works correctly.
        I can read the notes correctly using `readelf -n` as well,
        and they are aligned to 4 bytes instead of 8.

Test 3: Similar to Josh's patch, but instead of force-aligning the sections,
        I added `.note.gnu.property` to the `/DISCARD/` list in the line above.
Result: The build works correctly.
        I can read the notes correctly using `readelf -n` as well
        (of course, the GNU notes which made the alignment be 8 bytes are gone;
         I don't know if this has any negative effect).

So, in summary, either upgrading dwarves/pahole from 1.24 to (not yet fully
released?) 1.25, or applying Josh's patch fixes the issue for me.
Despite the new dwarves/pahole version fixing the build, Josh's patch or
something else to fix the notes alignment is needed.
