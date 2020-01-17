Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79EE5140B40
	for <lists+bpf@lfdr.de>; Fri, 17 Jan 2020 14:45:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727766AbgAQNnC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Jan 2020 08:43:02 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48085 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726973AbgAQNnB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Jan 2020 08:43:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579268580;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xMnL4G6jmU2OaNfU4L/KK5+b9+BSnKw6V4a/Ssf8Fhg=;
        b=GyKF/JCKqQ/n1m+wTTamrfY6pkFwl5w1dI3bH2tduNJRHHHvU82T0yL31iR6JChHTOgEgW
        ujZurFUNOxcMmGtFRoEJYXu9qKgFStw2jcMDrTo5g+Ua9ZTYKcUoArs6ensvlaCTA75Lde
        FeSlxz3bgK/bdko37zN6gYUOvusdhf8=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-354-NjmhKUphMHu2zdk9pP7cBw-1; Fri, 17 Jan 2020 08:42:59 -0500
X-MC-Unique: NjmhKUphMHu2zdk9pP7cBw-1
Received: by mail-lf1-f70.google.com with SMTP id t74so4377310lff.8
        for <bpf@vger.kernel.org>; Fri, 17 Jan 2020 05:42:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=xMnL4G6jmU2OaNfU4L/KK5+b9+BSnKw6V4a/Ssf8Fhg=;
        b=OW6vXldOoWMhXAaz5qM606hMhak76B38nOL/lIxWZ+NMfftThlAU/xheAz4LrDbw+A
         +jKynq3JeO5qdx5Ce7RRdFSUoVcu1/m9rfEuJguMtXwISnaf7eQSGQ6j/jpT6EqeExPS
         NHF0aD4ol9QFITroCg3lDYL9ZgT+Be6dnJ2GkVgQPoi7wPIgdHl7H6gt+zG5JuRm+clW
         qBMBPNzTePln+YGrEWa/INJHGNhFJ2Def2XXqE6NJU4lUnkEQg2O0YVTClUJ+VacwPvW
         W5Fk6mJNkWqDGnG9WLupmcc9gGzSP2gtyF7dSLEMrr89EcE/Gt7ahccsh8vL+5e1OO12
         53/A==
X-Gm-Message-State: APjAAAXvcpQebDSQHmg6Npfp96IjXe7xxp21jwBowZNzzrqm4yubvXIk
        bbOURt1uLnxYIvOy8PP2pH4Gd1Efm7rvOELK1CCVSRSoc8H0OeyfRbeumdCcOu7XEYxyJ9DhGGp
        rVQC2k2CTSste
X-Received: by 2002:a2e:b4f6:: with SMTP id s22mr5597196ljm.218.1579268577933;
        Fri, 17 Jan 2020 05:42:57 -0800 (PST)
X-Google-Smtp-Source: APXvYqzt3wfXgxOpp/EjUy4KtlwNoojyX+ef3VB3MZN9TMR6dcXGwDFGyY6GF7+SfD2lUiI01/Gy9w==
X-Received: by 2002:a2e:b4f6:: with SMTP id s22mr5597161ljm.218.1579268577656;
        Fri, 17 Jan 2020 05:42:57 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id i13sm12376914ljg.89.2020.01.17.05.42.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 05:42:56 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id F09801804D8; Fri, 17 Jan 2020 14:36:47 +0100 (CET)
Subject: [PATCH bpf-next v4 10/10] tools/runqslower: Remove tools/lib/bpf from
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
Date:   Fri, 17 Jan 2020 14:36:47 +0100
Message-ID: <157926820790.1555735.1100844709479532083.stgit@toke.dk>
In-Reply-To: <157926819690.1555735.10756593211671752826.stgit@toke.dk>
References: <157926819690.1555735.10756593211671752826.stgit@toke.dk>
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
index 9f022f7f2593..0cac6f0ddccf 100644
--- a/tools/bpf/runqslower/Makefile
+++ b/tools/bpf/runqslower/Makefile
@@ -5,7 +5,7 @@ LLC := llc
 LLVM_STRIP := llvm-strip
 DEFAULT_BPFTOOL := $(OUTPUT)/sbin/bpftool
 BPFTOOL ?= $(DEFAULT_BPFTOOL)
-INCLUDES := -I$(OUTPUT) -I$(abspath ../../lib) -I$(abspath ../../lib/bpf)
+INCLUDES := -I$(OUTPUT) -I$(abspath ../../lib)
 LIBBPF_SRC := $(abspath ../../lib/bpf)
 CFLAGS := -g -Wall
 

