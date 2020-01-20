Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5EE84142BA2
	for <lists+bpf@lfdr.de>; Mon, 20 Jan 2020 14:07:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729225AbgATNHZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 20 Jan 2020 08:07:25 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25621 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729052AbgATNG4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 20 Jan 2020 08:06:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579525615;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KsPh+K2sGLcZZLAcEa0kQAsvwcVmMWDpkU86Oyeqz+o=;
        b=CGafp+6AcscDmOKb7TOukKRU/pAENkXcEorcv9QzCspgqK4AAMjZl6jxrW/DK3PVUDjdQb
        wtGph+d4ueshXXNVTrmpKWvYG9S4cFIlTT99kYG7SL2EncsMFyWPwvh++jnG9/pjJZLVzl
        pg7QomFc2x9Y+OOsgKJ7090M927wFc0=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-394-ozE55QxXOkSdQj95smOGmQ-1; Mon, 20 Jan 2020 08:06:54 -0500
X-MC-Unique: ozE55QxXOkSdQj95smOGmQ-1
Received: by mail-lj1-f198.google.com with SMTP id 126so7538184ljj.10
        for <bpf@vger.kernel.org>; Mon, 20 Jan 2020 05:06:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=KsPh+K2sGLcZZLAcEa0kQAsvwcVmMWDpkU86Oyeqz+o=;
        b=U31cvjVZHDDzrPJpI0mTQcFhKRdFWeY3/Nlfer9x/9jU3xs+nuxTlhPlfooY+U7VJd
         jEh5EO7FweS/zT4PSNSbl6SRmv2UD1HRxip/uii2n8eAltqhgQTJ+vLJ3HfWJgrsn3+G
         7K4QnxmIsEUR0YADgT1uFmGKOl9UMp80Y7Td8u1/zHbJoQ08++A+MeMHktw3gAEc3zqR
         2XMfiuoImrJM2JHBfC6czZQJAM0s7myrAGsQwtjUucfg5ojIFzXnDdJIznm90H63in90
         mzbW+EeyWa1lSNG2B0WeJ4YJyFTTWP7FEEQUWf6JMacWa+OB3uEVwAnJemvllgx/FhCl
         wKuw==
X-Gm-Message-State: APjAAAVecnkHjl/Rh5vx9iy6k7vAXJjofnuKgmt00p5Qp8D6O/OdgfDf
        mi+rK1O47TNM7IgbxNlPAoiKzaRlRpXfbSwrAimmu0BAPaUw2/9MDVR8FiSmETxc/e41dg7B9jd
        O4j8folADdrVz
X-Received: by 2002:a2e:7a13:: with SMTP id v19mr13537734ljc.43.1579525612599;
        Mon, 20 Jan 2020 05:06:52 -0800 (PST)
X-Google-Smtp-Source: APXvYqxq7D+NOw8boRnGBWgzLuvcBMZuEgfqik8rj3u7ynVqVlOwh9aSescMWf6m9o80N+P1u7Do7g==
X-Received: by 2002:a2e:7a13:: with SMTP id v19mr13537712ljc.43.1579525612235;
        Mon, 20 Jan 2020 05:06:52 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([85.204.121.218])
        by smtp.gmail.com with ESMTPSA id u9sm16734044lji.49.2020.01.20.05.06.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2020 05:06:51 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 567801804D8; Mon, 20 Jan 2020 14:06:50 +0100 (CET)
Subject: [PATCH bpf-next v5 09/11] tools/runqslower: Remove tools/lib/bpf from
 include path
From:   =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Alexei Starovoitov <ast@kernel.org>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-kselftest@vger.kernel.org,
        clang-built-linux@googlegroups.com
Date:   Mon, 20 Jan 2020 14:06:50 +0100
Message-ID: <157952561027.1683545.1976265477926794138.stgit@toke.dk>
In-Reply-To: <157952560001.1683545.16757917515390545122.stgit@toke.dk>
References: <157952560001.1683545.16757917515390545122.stgit@toke.dk>
User-Agent: StGit/0.21
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Toke Høiland-Jørgensen <toke@redhat.com>

Since we are now consistently using the bpf/ prefix on #include directives,
we don't need to include tools/lib/bpf in the include path. Remove it to
make sure we don't inadvertently introduce new includes without the prefix.

Acked-by: Andrii Nakryiko <andriin@fb.com>
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 tools/bpf/runqslower/Makefile |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/bpf/runqslower/Makefile b/tools/bpf/runqslower/Makefile
index b7b2230f807b..b90044caf270 100644
--- a/tools/bpf/runqslower/Makefile
+++ b/tools/bpf/runqslower/Makefile
@@ -6,7 +6,7 @@ LLVM_STRIP := llvm-strip
 DEFAULT_BPFTOOL := $(OUTPUT)/sbin/bpftool
 BPFTOOL ?= $(DEFAULT_BPFTOOL)
 LIBBPF_SRC := $(abspath ../../lib/bpf)
-INCLUDES := -I$(OUTPUT) -I$(abspath ../../lib) -I$(abspath ../../lib/bpf)
+INCLUDES := -I$(OUTPUT) -I$(abspath ../../lib)
 CFLAGS := -g -Wall
 
 # Try to detect best kernel BTF source

