Return-Path: <bpf+bounces-9561-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1147979922E
	for <lists+bpf@lfdr.de>; Sat,  9 Sep 2023 00:23:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B2B91C20CAF
	for <lists+bpf@lfdr.de>; Fri,  8 Sep 2023 22:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AACEB65E;
	Fri,  8 Sep 2023 22:22:48 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3757B64F
	for <bpf@vger.kernel.org>; Fri,  8 Sep 2023 22:22:47 +0000 (UTC)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC8991FE0
	for <bpf@vger.kernel.org>; Fri,  8 Sep 2023 15:22:45 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d7e857a3fd5so2639820276.3
        for <bpf@vger.kernel.org>; Fri, 08 Sep 2023 15:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1694211765; x=1694816565; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=v5Cp90T0HlHlM0qC1hGQ5/U223gFFo3yll8YGs+M5Ps=;
        b=wTH73xfC5sR0hHLUTvDc2/m2mxqoHxkQey+iy4hqKadwoQ8TxF+KO054e3OWfypwky
         ruG2ueEh4Kg654e5MUSHGtaeaYZbKmW2rT20+yF8tUjSI+9zIZd9l7j7yIP47T9AlI/W
         lCWikjAu1OI3jkedQTfyNrEvRXN+pvHxAg1JLPhswppt5maG8gOjDyo31Nh2RZ8u3KED
         KpWtKXPcDuNBZAJVH5F9FTQo3KriqTwndFBHkOsAbxKjhX9yrvLCr7s37r7CYKPEL0Pz
         mgEDxyeD9vdFltGdIUN5qwBy5WJmXmF05ya6K4Xtc0LUOIcPkBE7zRLKLolOyIPJSk0n
         7Ixg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694211765; x=1694816565;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v5Cp90T0HlHlM0qC1hGQ5/U223gFFo3yll8YGs+M5Ps=;
        b=Z/fj9l5kJTREpXXGXdXs39L2oX5Yyrkmw4OBP18ANfP2oU0GDAGLDIArRM7yTPrBLP
         Dz0fdDJ88KkFWLi0Ws8lTXStGtfBcYCV6f58nTOI4db4FHPXNpX0MytNw9Zw2mXj+0zV
         q3FzBua1JYkq85uE0lHR9ZXr3NRcv/xjFYMv7PqdE5NsXovm770lgsxLr+5/ZMPCD6Jt
         7PYdlzaSEoxTWp/hW5idCafsJIyqTFzf3kLz4+u5YZvuRHPHcO+KzWrhzj+GO2Y3MFFm
         NMoCoCrg9K6D6VviN6HDWcg9MKxYHwATNOzfcSQUHKBeG6W+6MQuTV/8k9jiY4+/CeZA
         MuCA==
X-Gm-Message-State: AOJu0YwAdOzaVUBDO5YZ3L28P1XEhI+e+ig0Kz4HrJIDU0O28DCdqvcr
	CR80CPdA8cG7MDWng8C8mpUYgOboVhn55UyDFQ==
X-Google-Smtp-Source: AGHT+IFPFnTyGsFoc2ZSx47UoKkXlKTd1lUGjg7l0A9M/UItmxbV7iwmacXunuMpKmXV7s1YWdzHQiesT5QQCTmmtQ==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a25:b29a:0:b0:d7e:91ce:4619 with SMTP
 id k26-20020a25b29a000000b00d7e91ce4619mr72493ybj.2.1694211764994; Fri, 08
 Sep 2023 15:22:44 -0700 (PDT)
Date: Fri, 08 Sep 2023 22:22:40 +0000
In-Reply-To: <20230908-kselftest-09-08-v2-0-0def978a4c1b@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230908-kselftest-09-08-v2-0-0def978a4c1b@google.com>
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694211760; l=819;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=Fpue+BQes/IsmvChTzta8giCoFG0nhFAwjMFha0XbBk=; b=FPcBxS7/Tinifrs92XiVf0HUjlKN++LkVXDHzYy0yvRwYAtxE2iVOoZp9QZgBtlGeGYK7eftL
 gV450GrArSzCjcFyglvip5hagZgozWtKZAOu4zZvAOoQH8odEMQi2tg
X-Mailer: b4 0.12.3
Message-ID: <20230908-kselftest-09-08-v2-3-0def978a4c1b@google.com>
Subject: [PATCH v2 3/3] selftests/hid: force using our compiled libbpf headers
From: Justin Stitt <justinstitt@google.com>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, 
	Shuah Khan <shuah@kernel.org>
Cc: Eduard Zingerman <eddyz87@gmail.com>, linux-input@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Benjamin Tissoires <bentiss@kernel.org>

Turns out that we were relying on the globally installed headers, not
the ones we freshly compiled.
Add a manual include in CFLAGS to sort this out.

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---
 tools/testing/selftests/hid/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/hid/Makefile b/tools/testing/selftests/hid/Makefile
index c5522088ece4..b01c14077c5d 100644
--- a/tools/testing/selftests/hid/Makefile
+++ b/tools/testing/selftests/hid/Makefile
@@ -22,6 +22,8 @@ CXX ?= $(CROSS_COMPILE)g++
 HOSTPKG_CONFIG := pkg-config
 
 CFLAGS += -g -O0 -rdynamic -Wall -Werror -I$(OUTPUT)
+CFLAGS += -I$(OUTPUT)/tools/include
+
 LDLIBS += -lelf -lz -lrt -lpthread
 
 # Silence some warnings when compiled with clang

-- 
2.42.0.283.g2d96d420d3-goog


