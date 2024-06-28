Return-Path: <bpf+bounces-33312-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9249791B401
	for <lists+bpf@lfdr.de>; Fri, 28 Jun 2024 02:36:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04812B21BB9
	for <lists+bpf@lfdr.de>; Fri, 28 Jun 2024 00:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6CC26F2F8;
	Fri, 28 Jun 2024 00:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UdXcbO7V"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E4C17BDC
	for <bpf@vger.kernel.org>; Fri, 28 Jun 2024 00:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719534808; cv=none; b=LC4LtZS5xfdyiZE5Gs6i3kUlMjPumkG03zeMxqLIxCI1p6oAdxDUdiAtsWcHr/jDyC5acZ9FK+Wt9db/SbS6KyDKxugdsLF6NgsavFc2rmbOvZgq9rqExROfSKtBsuBANR438ojnTMzY4pYriAjJ014WiKEahyAVwsV1y7M3S+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719534808; c=relaxed/simple;
	bh=VIdQ960Dcv8A+OPQudKrpMY7gCZvwJ1R4w3Ia/nWdpI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=X1t/1x8Nil8qkZ7MVCiHyKJIUDykgHj2+ZjQIK3CMUnRAEBD6t5mKllcXZSipe3gLCGo/ewn4fEl0u7lxB1v+ErxhYJT5RzIN+w+ui3ZdFGV6LRs7vRJSWRT7g80fobgJlHVtO9jTeTOZa5psA4mshrNVETdtjxqJlaTEHo21Z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UdXcbO7V; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2c79f32200aso129219a91.1
        for <bpf@vger.kernel.org>; Thu, 27 Jun 2024 17:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719534801; x=1720139601; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HtAkC7dc7eD7owfI6upy3bTZg9Fqg9IfLoFV+/ACewo=;
        b=UdXcbO7VlGQSKwAt2o2TpwzjpeDF4TApPC5qkpp6zGB9vZIYx74kW1Nk9gIZyQJw2W
         2Ks9yTf2WhdpImsmyllxWUYrD8hBkvnjlZ2rF23bPoaNWb805NPTvEXLc1CG+FLe38t3
         w81xLUUZLaFOThVpTwKIWCnVcoJgCf6ZSVwzv4FcOijg69iAy8EoKMCBZa+gzViF0jaX
         aPlAyCe1YNsfFk0rA/QovXjSKUMfnRql72KR54Fl5+SSp10QvRnyjg/SmSurqXal86F5
         NK6GrT2siy8vtXf2YgRMl7VGI3gA/YetgXSrIwZqE5RCI2518qqA/0blm6E8zZHsQSQd
         Zemg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719534801; x=1720139601;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HtAkC7dc7eD7owfI6upy3bTZg9Fqg9IfLoFV+/ACewo=;
        b=H6AVzuRAUfoY648XGq0UtDYCDtVxsTjb3xMMzDi4thblRLG8mtN/VqI0bvFhB72AFr
         e8f1vZlScyaoai21CRSlDcA9iBpJUqEYEYHxrFK6M8bxjX+kuaDGY1hye/bTm8rUIGxy
         uMA0Yo9AzmyAwOjmiAT0JdDPnROjKlSPeec/JiU+F3EnTr8KDKAiW0HLO0qzXtvjyhL4
         aIgUVeoAqZXLC1rOvR46Gq5wo6PXvgihsqSE0tCcKwZxlhc+IDwenDStl8eKSY+zjWof
         XEZMuPuyO+WNnwTlR8MzbydyHKkj2iBL0xynfKMDE/nMDcD81CtyhJMZPvUOiDkLGTYQ
         UlAg==
X-Forwarded-Encrypted: i=1; AJvYcCVOjq3g50Vh3JSGy7GlOxol+uduZJ1qf82h6r550/kA/FKoedw9ACicls6gQoXjCPOLo1yYptDFFTv7dPfqrz4BTbHf
X-Gm-Message-State: AOJu0YyjGsBl2CVt6esIOMzZvAQuG2EGquC9pMNHsBCttEkuNpzX0uMX
	R3KSgITvdazEt7SJa2eZ8xcMwksMeC4FoG3LcOnbv/G1DCuWi/3Xk9rHePq5ZdEwMCkaKqs2Y4g
	92KrZ2KR7xV38Vh2VhisPrA==
X-Google-Smtp-Source: AGHT+IGLRaLTSytcMUc42cO5VbPk30udJR/OWLWuA3cZvbicGZ/TcfoTV4BSYF/3gyDoC1Kg15GgKgYZNfdRX/OyyQ==
X-Received: from almasrymina.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:4bc5])
 (user=almasrymina job=sendgmr) by 2002:a17:90a:6fa4:b0:2c4:bb9e:fcdc with
 SMTP id 98e67ed59e1d1-2c86144e0femr168873a91.9.1719534800464; Thu, 27 Jun
 2024 17:33:20 -0700 (PDT)
Date: Fri, 28 Jun 2024 00:32:50 +0000
In-Reply-To: <20240628003253.1694510-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240628003253.1694510-1-almasrymina@google.com>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Message-ID: <20240628003253.1694510-14-almasrymina@google.com>
Subject: [PATCH net-next v15 13/14] tools: net: package libynl for use in selftests
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-alpha@vger.kernel.org, 
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org
Cc: Mina Almasry <almasrymina@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Donald Hunter <donald.hunter@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
	Richard Henderson <richard.henderson@linaro.org>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, 
	Matt Turner <mattst88@gmail.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, Helge Deller <deller@gmx.de>, 
	Andreas Larsson <andreas@gaisler.com>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Arnd Bergmann <arnd@arndb.de>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Steffen Klassert <steffen.klassert@secunet.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, David Ahern <dsahern@kernel.org>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, 
	"=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>, Bagas Sanjaya <bagasdotme@gmail.com>, 
	Christoph Hellwig <hch@infradead.org>, Nikolay Aleksandrov <razor@blackwall.org>, 
	Pavel Begunkov <asml.silence@gmail.com>, David Wei <dw@davidwei.uk>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Yunsheng Lin <linyunsheng@huawei.com>, Shailend Chand <shailend@google.com>, 
	Harshitha Ramamurthy <hramamurthy@google.com>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Jeroen de Borst <jeroendb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Jakub Kicinski <kuba@kernel.org>

Support building the C YNL userspace library into one big static file.
We can then link selftests against it for easy to use C netlink
interface.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Mina Almasry <almasrymina@google.com>

---

v15:
- Added this patch from Jakub to fix linking against ynl.
- Squashed fix from Jakub to support O=xyz builds.
---
 tools/net/ynl/Makefile             |  6 +++++-
 tools/net/ynl/lib/Makefile         |  4 +++-
 tools/testing/selftests/net/ynl.mk | 21 +++++++++++++++++++++
 3 files changed, 29 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/net/ynl.mk

diff --git a/tools/net/ynl/Makefile b/tools/net/ynl/Makefile
index 8e9e09d84e269..d1cdf2a8f8266 100644
--- a/tools/net/ynl/Makefile
+++ b/tools/net/ynl/Makefile
@@ -2,9 +2,12 @@
 
 SUBDIRS = lib generated samples
 
-all: $(SUBDIRS)
+all: $(SUBDIRS) libynl.a
 
 samples: | lib generated
+libynl.a: | lib generated
+	@echo -e "\tAR $@"
+	@ar rcs $@ lib/ynl.o generated/*-user.o
 
 $(SUBDIRS):
 	@if [ -f "$@/Makefile" ] ; then \
@@ -17,5 +20,6 @@ clean distclean:
 			$(MAKE) -C $$dir $@; \
 		fi \
 	done
+	rm -f libynl.a
 
 .PHONY: all clean distclean $(SUBDIRS)
diff --git a/tools/net/ynl/lib/Makefile b/tools/net/ynl/lib/Makefile
index dfff3ecd1cbab..2887cc5de530f 100644
--- a/tools/net/ynl/lib/Makefile
+++ b/tools/net/ynl/lib/Makefile
@@ -14,7 +14,9 @@ include $(wildcard *.d)
 all: ynl.a
 
 ynl.a: $(OBJS)
-	ar rcs $@ $(OBJS)
+	@echo -e "\tAR $@"
+	@ar rcs $@ $(OBJS)
+
 clean:
 	rm -f *.o *.d *~
 	rm -rf __pycache__
diff --git a/tools/testing/selftests/net/ynl.mk b/tools/testing/selftests/net/ynl.mk
new file mode 100644
index 0000000000000..59cb26cf3f738
--- /dev/null
+++ b/tools/testing/selftests/net/ynl.mk
@@ -0,0 +1,21 @@
+# SPDX-License-Identifier: GPL-2.0
+
+# YNL selftest build snippet
+
+# Inputs:
+#
+# YNL_GENS:      families we need in the selftests
+# YNL_PROGS:     TEST_PROGS which need YNL (TODO, none exist, yet)
+# YNL_GEN_FILES: TEST_GEN_FILES which need YNL
+
+YNL_OUTPUTS := $(patsubst %,$(OUTPUT)/%,$(YNL_GEN_FILES))
+
+$(YNL_OUTPUTS): $(OUTPUT)/libynl.a
+$(YNL_OUTPUTS): CFLAGS += \
+	-I$(top_srcdir)/usr/include/ $(KHDR_INCLUDES) \
+	-I$(top_srcdir)/tools/net/ynl/lib/ \
+	-I$(top_srcdir)/tools/net/ynl/generated/
+
+$(OUTPUT)/libynl.a:
+	$(Q)$(MAKE) -C $(top_srcdir)/tools/net/ynl GENS="$(YNL_GENS)" libynl.a
+	$(Q)cp $(top_srcdir)/tools/net/ynl/libynl.a $(OUTPUT)/libynl.a
-- 
2.45.2.803.g4e1b14247a-goog


