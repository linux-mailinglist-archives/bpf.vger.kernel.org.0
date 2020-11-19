Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 872DB2B8DED
	for <lists+bpf@lfdr.de>; Thu, 19 Nov 2020 09:51:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726611AbgKSIuf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 19 Nov 2020 03:50:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726569AbgKSIue (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 19 Nov 2020 03:50:34 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AAD5C0613CF
        for <bpf@vger.kernel.org>; Thu, 19 Nov 2020 00:50:32 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id v12so6304238ybi.6
        for <bpf@vger.kernel.org>; Thu, 19 Nov 2020 00:50:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=Lsk7hPQQOXXPeOPRHLqGluFNcrQrklmQ2zZLxLBVLEs=;
        b=rogoZdLHkK0xlRT93V3sjOf2k/+zziO5yCc17GRsdtdcl/vROKPuKcx8Qib+EkHwWo
         OcrzbmZrVHVINxU4jaVXAbkWA683YhcZ6rUAaCICZ6x1GTGGF93hntH1nDTFbJJX0rdT
         zmdHZ2mcVRX5OFxLcmLICbLlBdPNVYhonLyP7gkRlh1VLeOI4pwGXrZvnBC3RTgrowyT
         c3oq0OLEpdLKYdno0rAG1qMP27Vv7tXyRRnHgvDVA+ox/iNOih3mUMhK/6mFpkEDVY75
         mgGa7yYQLwMdWpvU1MgIcT3JdzWwmbquZoJPsgbrjY+yv6KRvLocplkna3m6ORKzGVij
         c2GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=Lsk7hPQQOXXPeOPRHLqGluFNcrQrklmQ2zZLxLBVLEs=;
        b=PUdpNosePSrWWjT8ruJE5jh3ROMB3f3fyBJZxx8mp2/WZZf+7ECG3X4ca0HESq3uaK
         Aaau0PqVKAUOWNbhd+7LKkxqCphAFPLh4PHPk9/SbqKPdLVpCdcw/ebLssIW9Dm2qwRi
         176eMF0mFtLUg3pb47FOgj/UW+47jiQGdya31XK3Pf3MWK3ABEF13sqCnmfSKl7z9uHz
         gO/ACWv5eKrSI/+uXayJSSv0FL190U7Z0fl/Q/FsQyCTDRU/iizyNJlU5mb58A0pvF8F
         lzFqEA+A49FtFkL4rfYPBjIEaPmLhYKXB9k+eP2krcN5OlZWRVorUT1I9j6U6F7O85G4
         ZhHA==
X-Gm-Message-State: AOAM532W2ufviRO+0SMXKz9nOLhElWLl4N8v3wtcTYwp7Z8UdU2zxBAn
        974akiNfMnN57hhej4ewp3LsTrWvIIlb6w==
X-Google-Smtp-Source: ABdhPJyrroyyQkrwDV1SmRHiPKxqKP9nfODkyTYXKi1U9UQl1FrOg4j1o6b5L4mSSOwEKmcT9CA5t/3WuvrtbA==
Sender: "davidgow via sendgmr" <davidgow@spirogrip.svl.corp.google.com>
X-Received: from spirogrip.svl.corp.google.com ([2620:15c:2cb:201:42a8:f0ff:fe4d:3548])
 (user=davidgow job=sendgmr) by 2002:a05:6902:72e:: with SMTP id
 l14mr12601049ybt.175.1605775831888; Thu, 19 Nov 2020 00:50:31 -0800 (PST)
Date:   Thu, 19 Nov 2020 00:50:23 -0800
Message-Id: <20201119085022.3606135-1-davidgow@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [RFC PATCH] bpf: preload: Fix build error when O= is set
From:   David Gow <davidgow@google.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?=" <toke@redhat.com>
Cc:     David Gow <davidgow@google.com>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

If BPF_PRELOAD is enabled, and an out-of-tree build is requested with
make O=<path>, compilation seems to fail with:

tools/scripts/Makefile.include:4: *** O=.kunit does not exist.  Stop.
make[4]: *** [../kernel/bpf/preload/Makefile:8: kernel/bpf/preload/libbpf.a] Error 2
make[3]: *** [../scripts/Makefile.build:500: kernel/bpf/preload] Error 2
make[2]: *** [../scripts/Makefile.build:500: kernel/bpf] Error 2
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [.../Makefile:1799: kernel] Error 2
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:185: __sub-make] Error 2

By the looks of things, this is because the (relative path) O= passed on
the command line is being passed to the libbpf Makefile, which then
can't find the directory. Given OUTPUT= is being passed anyway, we can
work around this by explicitly setting an empty O=, which will be
ignored in favour of OUTPUT= in tools/scripts/Makefile.include.

Signed-off-by: David Gow <davidgow@google.com>
---

Hi all,

I'm not 100% sure this is the correct fix here -- it seems to work for
me, and makes some sense, but let me know if there's a better way.

One other thing worth noting is that I've been hitting this with
make allyesconfig on ARCH=um, but there's a comment in the Kconfig
suggesting that, because BPF_PRELOAD depends on !COMPILE_TEST, that
maybe it shouldn't be being built at all. I figured that it was worth
trying to fix this anyway.

Cheers,
-- David


 kernel/bpf/preload/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/preload/Makefile b/kernel/bpf/preload/Makefile
index 23ee310b6eb4..39848d296097 100644
--- a/kernel/bpf/preload/Makefile
+++ b/kernel/bpf/preload/Makefile
@@ -5,7 +5,7 @@ LIBBPF_A = $(obj)/libbpf.a
 LIBBPF_OUT = $(abspath $(obj))
 
 $(LIBBPF_A):
-	$(Q)$(MAKE) -C $(LIBBPF_SRCS) OUTPUT=$(LIBBPF_OUT)/ $(LIBBPF_OUT)/libbpf.a
+	$(Q)$(MAKE) -C $(LIBBPF_SRCS) O= OUTPUT=$(LIBBPF_OUT)/ $(LIBBPF_OUT)/libbpf.a
 
 userccflags += -I $(srctree)/tools/include/ -I $(srctree)/tools/include/uapi \
 	-I $(srctree)/tools/lib/ -Wno-unused-result
-- 
2.29.2.454.gaff20da3a2-goog

