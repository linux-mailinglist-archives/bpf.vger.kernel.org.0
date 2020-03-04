Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6F7E179B86
	for <lists+bpf@lfdr.de>; Wed,  4 Mar 2020 23:14:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388338AbgCDWOF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 4 Mar 2020 17:14:05 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:40978 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387931AbgCDWOE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 4 Mar 2020 17:14:04 -0500
Received: by mail-io1-f66.google.com with SMTP id m25so4196454ioo.8
        for <bpf@vger.kernel.org>; Wed, 04 Mar 2020 14:14:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5RZnySPr2P+YN4LWk4hB1TPPuvNEvChvRV3l/kgeEwU=;
        b=PD9GxB+apE6cVObJRfsp5PWD0Cc8EUWjgheljvrVaHsQrwpzXyquxRPPow9txiSNwW
         sKESrBfxYVCgiMdliBnJdX7ycHA7Bs4M1W0hgJpzP+3N2FYRTi2nw2trTR8PSflwYOiG
         Oa7Fa3aBsGMCYqI9o2PM7ISkI5DyqA3CEme2c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5RZnySPr2P+YN4LWk4hB1TPPuvNEvChvRV3l/kgeEwU=;
        b=JZqgI+6dOBQvbicEAjAwbZ6JsokI2hmakliNygNvkt6VINyciXAlDktk8TCtwyJQUG
         7ySKXIEk+xESH716s5X6AbUTceXGA/UivPVVoysRCSAo5O3NJd8+MRx9s2W1G1fRdWvH
         ohgKNLuPy7c+Mmsn8E5AOYKLpmBviOOOxGV1zqqm4BIHqRMhYSUzzY8VxSt/VyFe/xFs
         NXaFpTDYe5JDF4Z6RiUypR7FKxbVFRgs0AJSZIbSq/iS7Hb2wWyU6+KHKGFdvtjvystT
         trKexJLcQTmNGIu5M+ih+vVTBs397pBYYR5mj6jFPEbU+IwiC9FjYzq28fnN2Ju0cz6O
         VbWw==
X-Gm-Message-State: ANhLgQ2BUf8dZh8z5u1dS7Hh1ECWh1W6lLuonctdPeFL2eRZuSVA0nQa
        NRo4WeSSMEcsCA7y4sbKbBM6nw==
X-Google-Smtp-Source: ADFU+vvbVUBntaUuM+BR9AtlDvcRMDW37o/tSJ1CxI9aA+ZUljxG1XOijk2DoUbaKr8ANC+GyheLRQ==
X-Received: by 2002:a6b:6007:: with SMTP id r7mr4147160iog.223.1583360042621;
        Wed, 04 Mar 2020 14:14:02 -0800 (PST)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id g12sm6850409iom.5.2020.03.04.14.14.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 14:14:01 -0800 (PST)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     shuah@kernel.org, keescook@chromium.org, luto@amacapital.net,
        wad@chromium.org, daniel@iogearbox.net, kafai@fb.com, yhs@fb.com,
        andriin@fb.com, gregkh@linuxfoundation.org, tglx@linutronix.de
Cc:     Shuah Khan <skhan@linuxfoundation.org>, khilman@baylibre.com,
        mpe@ellerman.id.au, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: [PATCH 0/4] Kselftest integration into Kernel CI - Part 1
Date:   Wed,  4 Mar 2020 15:13:31 -0700
Message-Id: <cover.1583358715.git.skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch series consists of first round of fixes to integrate
Kselftest into Kernel CI.

You can find full list of problems in my announcement I sent out
last week:

https://lkml.org/lkml/2020/2/27/2221

These fixes to android and seccomp tests address relocatable support.
However, they will still leave the source directory dirty.

android test does headers_install in source directory. This is an easier
problem to fix. seccomp on the other hand builds fixdep scripts under
scripts/basic and installs headers in the source directory. It is linked
to solving bpf relocatable build issue which I haven't given it a lot of
thought for now.

There is no dependency on source directory for run-time which is what
we want.

I will apply these kernelci topic branch for testing 
git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git

Shuah Khan (4):
  selftests: Fix kselftest O=objdir build from cluttering top level
    objdir
  selftests: Fix seccomp to support relocatable build (O=objdir)
  selftests: android: ion: Fix ionmap_test compile error
  selftests: android: Fix custom install from skipping test progs

 tools/testing/selftests/Makefile             |  4 ++--
 tools/testing/selftests/android/Makefile     |  2 +-
 tools/testing/selftests/android/ion/Makefile |  2 +-
 tools/testing/selftests/seccomp/Makefile     | 16 +++-------------
 4 files changed, 7 insertions(+), 17 deletions(-)

-- 
2.20.1

