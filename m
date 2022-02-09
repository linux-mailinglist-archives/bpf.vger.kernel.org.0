Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D16704AE8F4
	for <lists+bpf@lfdr.de>; Wed,  9 Feb 2022 06:16:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230498AbiBIFOg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Feb 2022 00:14:36 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:36242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347478AbiBIFLM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Feb 2022 00:11:12 -0500
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B569BC03C1B2
        for <bpf@vger.kernel.org>; Tue,  8 Feb 2022 21:11:16 -0800 (PST)
Received: by mail-pl1-x644.google.com with SMTP id k17so1292318plk.0
        for <bpf@vger.kernel.org>; Tue, 08 Feb 2022 21:11:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZBNenbcQ6QFQwZZCP+H/7yYT9UD9JvkHeurZvDD3wpI=;
        b=hadt2gXnM8DLHSt9MrCDwqi7AUpeAaro2+Y5MOx+OozqUNnW9oEgctdNL6L4rC8vyF
         aNAba6qOvNX4sQLYO/2pu0mdwfy/xNFNmJVR2QfrKRfdMGT3LZG1HSq/Mt2qRQmnSFrM
         h84KN4Px2cJ4FAYuy4GpYBuZWMUdKEAxoxvPwC/539djfQSAf3AMu9LcjArMOasTw4IY
         X6huqq5ONE4muhSX+9046yZNWzGCZEfLCLk6ZHTlK9lHgDVGiBH+TSugsfEAGz12YBZ/
         Rdo2Yfn8kIAWnMRn5HyLY6+Me/MaT99tf0nyWj1P2ZPx28BwUXGU6Km2SGMwwaG54nhq
         Wrow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZBNenbcQ6QFQwZZCP+H/7yYT9UD9JvkHeurZvDD3wpI=;
        b=UL0Jyhtzr3yNZwKxtz4sKetKs07vUVE9LqMwgqaYRI37/pvmJA/8/m0lTWr9c7TVAH
         Lgnr9EMYTbdcF+d6wXCADPyQTPrFUM3+LNPiCQ7Ugwyurdj3YzV8Ub0oQYFS9wArk1tt
         CFp0XMbK5hc26v9JICwRLob+4OGUhdcrzEq4vtORsEW8KgUzEBgmzz7TwPbB2KvIFgb5
         DYjlbTESvHzFE9BGWN4uI4E76baZtpBvZXUZhqlqpODoqR+kde5xPiepxrNiJz1Z3RWV
         HlozSrwZAZ4t3GCg/KgO7WIbXzV6XxnsJRNeaGL4YqixytlLDHw6LE3o7x1HDFpCWa6A
         QKiQ==
X-Gm-Message-State: AOAM5326vaZmSKqIw6jWphLlUnhAvzfppai3ZKb3zZH9ZLaCgHboa/Jh
        jKRmUn9HVZEH+hXD4hOZrzqqgBKncO0=
X-Google-Smtp-Source: ABdhPJx+8jNKrljPi0eL8AlYFMBUSwZB9AjrkwENTCtstl/67W16OazD8QBghTqMoaRatBEEtudJow==
X-Received: by 2002:a17:903:1212:: with SMTP id l18mr769983plh.7.1644383475946;
        Tue, 08 Feb 2022 21:11:15 -0800 (PST)
Received: from localhost ([2405:201:6014:d064:3d4e:6265:800c:dc84])
        by smtp.gmail.com with ESMTPSA id lb3sm4665840pjb.47.2022.02.08.21.11.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 21:11:15 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH bpf v1 0/2] Fix for crash due to overwrite in copy_map_value
Date:   Wed,  9 Feb 2022 10:41:11 +0530
Message-Id: <20220209051113.870717-1-memxor@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=936; h=from:subject; bh=mjOopcm0MmCeyol9UkU7UYJ7uzAJSdP+Z038KzbdT2A=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBiA0yOsxZFVoNTIkUyYuo394EotMrvreUeJJK/LoBU E/R+su6JAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYgNMjgAKCRBM4MiGSL8Ryru4EA Cwh4d2US5w1rBglhxXOIBo8ZC3C0OzDru3B7BrtJhFLvBfL2eyxr5xbyTYZ0PlX+upNkziwbRfylaM hc0O3Qni6jaxdaGpyXYrFnF8skixaRXJdRekIynpr2xi1nT/qrRpI25Cnse1OombGDyxW4lgCdcpRU DeCLMaUiA6qc2kq5kC62gwek4MKsqQ8CH4I2AfKBcbPgdfMPbn4uQUgBCRcJnn18y+ovGMxHGTvIPY uKqgyuLFYj5WqarY+o/vNryEJiBaz6LY6AcVEXsXo8Ygn6fnuIY6SNQ/dBfq09UhomUG1A2OQjNheO WEbETgq1We5pnLBwjMuCxoABR/j9vKhr4yQjFi8CRmpHKUoRXmNJYNCyMbGp2UF+YaLAUwErgXo4MV 090VFjxBJJyJNYYTQg5b5KZPqLJfFr2QSIjvcsba4hajgpFkDXBDLMAmEIJdJWR8s12/cLnTL027Ls 1cxuZm1DJC16UmVNvUkimA2obOCRV3R+hjy6/Yeq33CVV6g4C0KXB71ievMJxy5pFoxFI1UNpH1uQ3 xjuolVNhJhJLf1bpcOVxQcLJISfFmj+n5GDzPnJceEnqtCmmkIEIdKX5zcRVQ/dI7p4Z/Ceu5MY3vY pTAqVHSYfNcrFijDA1CTZh871VlbYVMZi7sYp/pkSAh1NqrJBP/yKF/+bEzQ==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

A fix for an oversight in copy_map_value that leads to kernel crash.

Also, a question for BPF developers:
It seems in arraymap.c, we always do check_and_free_timer_in_array after we do
copy_map_value in map_update_elem callback, but the same is not done for
hashtab.c. Is there a specific reason for this difference in behavior, or did I
miss that it happens for hashtab.c as well?

Kumar Kartikeya Dwivedi (2):
  bpf: Fix crash due to incorrect copy_map_value
  selftests/bpf: Add test for bpf_timer overwriting crash

 include/linux/bpf.h                           |  3 +-
 .../selftests/bpf/prog_tests/timer_crash.c    | 32 +++++++++++
 .../testing/selftests/bpf/progs/timer_crash.c | 55 +++++++++++++++++++
 3 files changed, 89 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/timer_crash.c
 create mode 100644 tools/testing/selftests/bpf/progs/timer_crash.c

--
2.35.1

