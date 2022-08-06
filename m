Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0116258B345
	for <lists+bpf@lfdr.de>; Sat,  6 Aug 2022 03:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237456AbiHFBqK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 5 Aug 2022 21:46:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233139AbiHFBqJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 5 Aug 2022 21:46:09 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64A4A20B
        for <bpf@vger.kernel.org>; Fri,  5 Aug 2022 18:46:08 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id q1-20020a05600c040100b003a52db97fffso10901wmb.4
        for <bpf@vger.kernel.org>; Fri, 05 Aug 2022 18:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=V/el6smBySS3/v0xF4X59kGJQd17WvBWlGiS72iXyuA=;
        b=RsYbe0HmL60CK+ra/03bHBYozCj9LuIJ9++4HxrgewJRkiZTQrtChvaLKscLDQkfmw
         CJId+0XWYpC5yd6Z4fbqKvxJLr3rZ9XLOOOwSZzrD+RzjPWWG1Kov8kT7VMwvURZxThn
         lGVSn+jIe9zX1Sx57zsHokU7vVxbnMY/wJIj6DnSIwjh1m1tY5tqQzGZfP/+FPsOtYEn
         zu2AaQN8npbvNqBb2O9Bdz1ccVpy/soIJdrFou0oozRN5I0Clp0WeOf1NMoS9U0nvY26
         /4CH/pzwON/uFQvXermDcEVMEh9nwm9oitnVbK/Kt52VhrxLI4uIlyOY+J76CHnaY0sf
         83CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=V/el6smBySS3/v0xF4X59kGJQd17WvBWlGiS72iXyuA=;
        b=UeEq9EN1TDZpSVgGFX5ANSKkJQML1dpGxc04K02B6s4r+IzrnkwUECEMqggb6yEehY
         c7BeKRv3cm5h+k0Hx+i2RUX3jSS4cez9ztTybUkQfsyq+H0ImPUAm0EOPtP0dnEmKeZv
         1dUv5ytV+Nd3jSF3O6HkJlK7B2mHluvtup05OXjdLuCjjDUi9GvO5n49/VJv/yseEwH2
         DuHpFfkC+yh7FgL0SBus2F5LQniN2sxaNJqgBP8XkFPRA80X2RlWmFysnd2KMmNDA6df
         gpxxZqn2Xdx8nBPrgHGHmq7YMoyVbiHhcg+fBZvQrA5l+gqnPknxXAzPtYjxtQGzZnNq
         NMWQ==
X-Gm-Message-State: ACgBeo1uf8mW3tOdCCAykidjPak/ZKeD/HP1E6Fha7MKKeNb9rGwBIhM
        vcjL3m3ZXyT/gxesCsurin26A2fKVm4=
X-Google-Smtp-Source: AA6agR6gFxlxfJ9V+yknT17C71mA/Ks7Hqqu31NpltTiJPDZEfKgvmoOee8QVRqV8NrwUOqQZWiZ2g==
X-Received: by 2002:a05:600c:364d:b0:3a5:17f:f6b3 with SMTP id y13-20020a05600c364d00b003a5017ff6b3mr6130204wmq.41.1659750366615;
        Fri, 05 Aug 2022 18:46:06 -0700 (PDT)
Received: from localhost (212.191.202.62.dynamic.cgnat.res.cust.swisscom.ch. [62.202.191.212])
        by smtp.gmail.com with ESMTPSA id l8-20020a05600c4f0800b003a17ab4e7c8sm12178369wmq.39.2022.08.05.18.46.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 18:46:06 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf v1 0/3] Don't reinit map value in prealloc_lru_pop
Date:   Sat,  6 Aug 2022 03:46:00 +0200
Message-Id: <20220806014603.1771-1-memxor@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=768; i=memxor@gmail.com; h=from:subject; bh=39AoQBt/pqlSTX6e9ZSf2lDthrDuom3B79b+/sDn1tY=; b=owEBbQKS/ZANAwAKAUzgyIZIvxHKAcsmYgBi7cfJ0OD/FwznonDvEN8hIXEQ4qPwhL0O9IQBy+YD uzeMK6SJAjMEAAEKAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYu3HyQAKCRBM4MiGSL8RyiGPD/ 9E8IgpTeFSx7VLL0ze3+BOeXfvBGQEAuffuI4GYgJx1KpOikdghALnmGjXFAfjCDjyvq4ZuuDxK1Tk N67IUxljPki2RGWuLuMc0kNHwJ4fZumgEqdWNGzEBAJVqd8Q+wTtrA5DXQqxs736M5sHyLBDv1e9yV 8MnCkg9RQ+ssLRZQbq3CmAkHNbuL55Oy0FV+iMjTIspvhBw4ik/K4POGVbiBCEAXWFh3BGiNA9Bkxn FA1DxF9d8Nc+4NDhjzj1dciQeqVFvPdGLtc2JMJWOtGqP42kTvbKfEIqxeYdFvSdBROD68IMeDHuO8 EU9jpN9S35A8QZcUFpEwupWXNj0Y41LZrrg85L+4J1POlQTk2SbSGsBCXM5Hxth5IEki96zKt6h/mc ORckRIrpisVxKy/c0TeSolR6i3eI6bdg6IIurW5/ahgsgmWzlM/ImuOjcZFCCUUtDvFrXbaIsQ8C5f f+ZQpPjVA7wDlPsG6M6P/ww30GgVu2nzi6QrAyytf9SUavMDhCxecKk32yUvRQ2Ty3sd7FNlGWwoDA pL3coz2gkREZkcyPBhGhZ7oAgk9CkGciDU6qhflLGQL1IuTyhElDxRy/9I3EEp5DAMv77irc9czwh1 X+AE8ieWr+6q3516pf7I66PbJlJJkPX1A2xS7FtAjCzZ+RwDqM8PqSjjZjLQ==
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

Fix for a bug in prelloc_lru_pop spotted while reading the code, then a test +
example that checks whether it is fixed.

Kumar Kartikeya Dwivedi (3):
  bpf: Allow calling bpf_prog_test kfuncs in tracing programs
  bpf: Don't reinit map value in prealloc_lru_pop
  selftests/bpf: Add test for prealloc_lru_pop bug

 kernel/bpf/hashtab.c                          |  6 +-
 net/bpf/test_run.c                            |  1 +
 .../selftests/bpf/prog_tests/lru_bug.c        | 19 ++++++
 tools/testing/selftests/bpf/progs/lru_bug.c   | 67 +++++++++++++++++++
 4 files changed, 88 insertions(+), 5 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/lru_bug.c
 create mode 100644 tools/testing/selftests/bpf/progs/lru_bug.c

-- 
2.34.1

