Return-Path: <bpf+bounces-12429-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A026A7CC5B7
	for <lists+bpf@lfdr.de>; Tue, 17 Oct 2023 16:16:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D19D61C20B1E
	for <lists+bpf@lfdr.de>; Tue, 17 Oct 2023 14:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3025F43AA3;
	Tue, 17 Oct 2023 14:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="PlK5Sr5T"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12AE841234
	for <bpf@vger.kernel.org>; Tue, 17 Oct 2023 14:16:17 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51ED8FC;
	Tue, 17 Oct 2023 07:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=Q+r0YJdNDr2EzgW36tfo5n3UbihfP1ZD+Us+ZNdmkg4=; b=PlK5Sr5TIgr3qnZKUOY1DjXGhp
	GXeakFKWobePvv+gL61glnyqmJFQRRXulIzU+8zPHN3Udf9ne5lYTJVj67JEuAE54kYCYVfZZyNPP
	ZKEh1fMUr5aM0A3XKMLkTtgiwvLMQlOyjowrV/mBMyNw8/kM2IKpdRjhfgfIBxs4lmpWvg+3mdRen
	eE/jLDe86gPN6gfCE6ceMMlWWLbGuh79vNtqo6TWIkl1NyCpnNzXxWkXcZFvwh5+CwF0iwB/3bx8S
	EOYYwKIbX8YzWXebc9aOR0JJdSrWFTrZDJHh6CHWkD8HYg2ZSgZ1Ta/wYmopHLHzJxYSPDyNasQYH
	GoU3cB8w==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qskrX-000AkD-D9; Tue, 17 Oct 2023 16:15:59 +0200
Received: from [85.1.206.226] (helo=linux.home)
	by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1qskrW-000MP3-OH; Tue, 17 Oct 2023 16:15:58 +0200
Subject: Re: [PATCH bpf-next v4] selftests/bpf: Use pkg-config to determine ld
 flags
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
 Alexei Starovoitov <ast@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Nick Terrell <terrelln@fb.com>, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 bjorn@kernel.org
References: <20231016130307.35104-1-akihiko.odaki@daynix.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <4037a83a-c6b6-6eab-1cb1-93339686c4e5@iogearbox.net>
Date: Tue, 17 Oct 2023 16:15:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20231016130307.35104-1-akihiko.odaki@daynix.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27064/Tue Oct 17 10:11:10 2023)
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 10/16/23 3:03 PM, Akihiko Odaki wrote:
> When linking statically, libraries may require other dependencies to be
> included to ld flags. In particular, libelf may require libzstd. Use
> pkg-config to determine such dependencies.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
> V3 -> V4: Added "2> /dev/null".
> V2 -> V3: Added missing "echo".
> V1 -> V2: Implemented fallback, referring to HOSTPKG_CONFIG.
> 
>   tools/testing/selftests/bpf/Makefile   | 4 +++-
>   tools/testing/selftests/bpf/README.rst | 2 +-
>   2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> index caede9b574cb..009e907a8abe 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -4,6 +4,7 @@ include ../../../scripts/Makefile.arch
>   include ../../../scripts/Makefile.include
>   
>   CXX ?= $(CROSS_COMPILE)g++
> +PKG_CONFIG ?= $(CROSS_COMPILE)pkg-config
>   
>   CURDIR := $(abspath .)
>   TOOLSDIR := $(abspath ../../..)
> @@ -31,7 +32,8 @@ CFLAGS += -g -O0 -rdynamic -Wall -Werror $(GENFLAGS) $(SAN_CFLAGS)	\
>   	  -I$(CURDIR) -I$(INCLUDE_DIR) -I$(GENDIR) -I$(LIBDIR)		\
>   	  -I$(TOOLSINCDIR) -I$(APIDIR) -I$(OUTPUT)
>   LDFLAGS += $(SAN_LDFLAGS)
> -LDLIBS += -lelf -lz -lrt -lpthread
> +LDLIBS += $(shell $(PKG_CONFIG) --libs libelf zlib 2> /dev/null || echo -lelf -lz)	\
> +	  -lrt -lpthread
>   
>   ifneq ($(LLVM),)
>   # Silence some warnings when compiled with clang

Staring at tools/bpf/resolve_btfids/Makefile, I'm trying to understand why we
cannot replicate something similar for BPF selftests?

For example, with your patch, why is it necessary to now have PKG_CONFIG and
another HOSTPKG_CONFIG var?

What about the below?

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 4225f975fce3..62166d2f937d 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -29,13 +29,17 @@ SAN_CFLAGS  ?=
  SAN_LDFLAGS    ?= $(SAN_CFLAGS)
  RELEASE                ?=
  OPT_FLAGS      ?= $(if $(RELEASE),-O2,-O0)
+
+LIBELF_FLAGS   := $(shell $(HOSTPKG_CONFIG) libelf --cflags 2>/dev/null)
+LIBELF_LIBS    := $(shell $(HOSTPKG_CONFIG) libelf --libs 2>/dev/null || echo -lelf)
+
  CFLAGS += -g $(OPT_FLAGS) -rdynamic                                    \
           -Wall -Werror                                                 \
-         $(GENFLAGS) $(SAN_CFLAGS)                                     \
+         $(GENFLAGS) $(SAN_CFLAGS) $(LIBELF_FLAGS)                     \
           -I$(CURDIR) -I$(INCLUDE_DIR) -I$(GENDIR) -I$(LIBDIR)          \
           -I$(TOOLSINCDIR) -I$(APIDIR) -I$(OUTPUT)
  LDFLAGS += $(SAN_LDFLAGS)
-LDLIBS += -lelf -lz -lrt -lpthread
+LDLIBS += $(LIBELF_LIBS) -lz -lrt -lpthread

  ifneq ($(LLVM),)
  # Silence some warnings when compiled with clang

