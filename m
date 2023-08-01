Return-Path: <bpf+bounces-6542-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2112D76AB31
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 10:38:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5231B1C208EB
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 08:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 179591ED49;
	Tue,  1 Aug 2023 08:38:18 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5911C33
	for <bpf@vger.kernel.org>; Tue,  1 Aug 2023 08:38:17 +0000 (UTC)
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5285410E
	for <bpf@vger.kernel.org>; Tue,  1 Aug 2023 01:38:16 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-403e7db1e96so12847261cf.0
        for <bpf@vger.kernel.org>; Tue, 01 Aug 2023 01:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690879095; x=1691483895;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QQCvV66K7ZGYi8bk1PQm2H/VbE/w6nlTV84/lWtg8O0=;
        b=PwncTurLyDPCjrmqnQQVu0yYIGMv0f0tw1mGU0BjElwkRWXcE+iugx9xp74jNZO9/9
         Fia4HKImw8HAyQTvyMoVovEGKpCfu2dVWUTY5wWutZPoT4k16vFKztwo0vkUOqh1qUef
         POr9foDZc2cSUbIaWUhOCeuNsR+xz77hpzVQcVhuIn0Cxn31JKi139RCIhA/iyKXuUy5
         0qFWhJQKg8aGDVBvrE2Ss2cWHxOOuI7pK84t8frZD/QLWEquNyd1vLFCZDVcppdwbrGM
         /HmyP5GvfzdACKrGwVNgzgD9+ICbAEuk2OrcsBXC2U54L6peAwBWdk8nwB5IxNWyEKwx
         HYdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690879095; x=1691483895;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QQCvV66K7ZGYi8bk1PQm2H/VbE/w6nlTV84/lWtg8O0=;
        b=GeUgIcrs8AjbstK+N08P78AxxnLqrkx3RefpwfGcYIqFj7b/7UPlNrf6GnCa9uofVg
         6gobwEicPcPFXQLS/JNRJyXQigwOgGo3gPMi5uV3Z9Ol5LnH3C3QlN67bSDCQ5KT5+5e
         H3Tm+3uy+ehhtj34jJYsFAoZnBGRYpEvu3RHhyBvwhAVDP/vyKppwjhf2b5y8+l7AteM
         pivPrN/ARJrVS6ZXGI60zF3XsEGy5AIQs6O2J0M8fVzONXFg7buJgKLgeA/WRn3TCDkE
         /JPXgAGxHaH+Tw7/MCeTqYsEdinNWmI74kxvk5tVk5Oc7FLVuqd+/9E3aJlMAIZqCF4x
         lCaQ==
X-Gm-Message-State: ABy/qLYQdQMFqP7o03FbCoV7skOXHOC7q0nywmL++SOOzDRtTAHVx082
	Y9y8iwKNa/QjPiXiTj/x3GrspLQ+4XMnKusNveBNbCM/S4M=
X-Google-Smtp-Source: APBJJlGcJegEr8OtWEK++1tZeMFJ/X2+6Lo+mM+SR0zxAdJDpj8ymXW/OZaWHqdt9lEJF7VOI2NAOkAPms1RxmZZKC4=
X-Received: by 2002:a05:622a:c1:b0:400:8036:6f05 with SMTP id
 p1-20020a05622a00c100b0040080366f05mr13112225qtw.2.1690879095280; Tue, 01 Aug
 2023 01:38:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Sergey Kacheev <s.kacheev@gmail.com>
Date: Tue, 1 Aug 2023 11:38:04 +0300
Message-ID: <CAJVhQqXomJeO_23DqNWO9KUU-+pwVFoae0Xj=8uH2V=N0mOUSg@mail.gmail.com>
Subject: [PATCH bpf-next] libbpf: Use local includes inside the library
To: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi!
I found that there is no way to include library headers without doing
PREFIX=3D<some tmp dir> make install with some prefix to try a new
version of the library, this patch fixes this. Allows importing
headers directly from src/ =D0=B0nd it seems to me that this does not
violate the current behavior.

Use local includes inside the library

Signed-off-by: Sergey Kacheev <s.kacheev@gmail.com>
---
 src/bpf_tracing.h | 2 +-
 src/usdt.bpf.h    | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/bpf_tracing.h b/src/bpf_tracing.h
index be076a4..3803479 100644
--- a/src/bpf_tracing.h
+++ b/src/bpf_tracing.h
@@ -2,7 +2,7 @@
 #ifndef __BPF_TRACING_H__
 #define __BPF_TRACING_H__

-#include <bpf/bpf_helpers.h>
+#include "bpf_helpers.h"

 /* Scan the ARCH passed in from ARCH env variable (see Makefile) */
 #if defined(__TARGET_ARCH_x86)
diff --git a/src/usdt.bpf.h b/src/usdt.bpf.h
index 0bd4c13..f676330 100644
--- a/src/usdt.bpf.h
+++ b/src/usdt.bpf.h
@@ -4,8 +4,8 @@
 #define __USDT_BPF_H__

 #include <linux/errno.h>
-#include <bpf/bpf_helpers.h>
-#include <bpf/bpf_tracing.h>
+#include "bpf_helpers.h"
+#include "bpf_tracing.h"

 /* Below types and maps are internal implementation details of libbpf's US=
DT
  * support and are subjects to change. Also, bpf_usdt_xxx() API helpers sh=
ould
--
2.39.2

