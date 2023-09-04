Return-Path: <bpf+bounces-9168-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E016791016
	for <lists+bpf@lfdr.de>; Mon,  4 Sep 2023 04:25:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CA071C203B3
	for <lists+bpf@lfdr.de>; Mon,  4 Sep 2023 02:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E665339F;
	Mon,  4 Sep 2023 02:25:09 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC906381
	for <bpf@vger.kernel.org>; Mon,  4 Sep 2023 02:25:09 +0000 (UTC)
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49604BB
	for <bpf@vger.kernel.org>; Sun,  3 Sep 2023 19:25:06 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-565439b6b3fso131056a12.2
        for <bpf@vger.kernel.org>; Sun, 03 Sep 2023 19:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693794305; x=1694399105; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3ykjcJrodrLYn8afdY7M89TBb/PynT4NzbOi82WeJAA=;
        b=CG8OdXeodm4BT8v1HXlPV1cAtjLLaoDqY8ZnS99mS5/wxxPC1nA48eHMkvm2apCrEK
         AdhC8Q3YDmdGjdujT70M5zLW+Z2dji+6TGMzBE4bnn6gcZflTPDAxco2lgkO+BSoGDpe
         xulv4n2mUBx6PEi+rB1X7/htdj66OkQa3C13jJtTYPQG5fj4DCcXC7rqJ7mnNzBKMrY5
         t+xZBkoRFGjoejmr2bptwTgJL/bbam3I5gZKeIKJvGFk0ugSTG1QilY0WXqxw+fk6chd
         ISA7lqQqtyutKfSbEriMViTkhFxsiqCLzWDvXPyOrtNLd6s5sM2zm0F2bOE86RXC3n60
         3A9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693794305; x=1694399105;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3ykjcJrodrLYn8afdY7M89TBb/PynT4NzbOi82WeJAA=;
        b=IFk3slw/YMdnxeZ/rC0blqFKpFuI9i2peLETJqlqO7hDvXWI/awv4T9mzhTMYnBqZo
         EkO4UcYt6+GW3CpzPMr2xAB+CJhrd8B9IbqyNJEqg5aWyP6OJaJAqSSrZXZHszpz3u/L
         wvlw2yI7daX3S+DeTbn9q8q91u+UyN7k7BljQZV4msLPSE4/UVO2R987eyJv7Etst8+3
         isIwxai2s9v8ZpoRJWCDLPw0BsmGMYOYoCaPDMh7kuT2pHb2bxCmAPmnDt9WoaWta+Ds
         95zH5MAuK589IOqrNM91LsIwV56XAEGFabBRrXQUuhxXohA33QG7xf1UCgS+dalL8oyK
         2Kqg==
X-Gm-Message-State: AOJu0Yz+BBwVwJPKX55QEvEoiWLFdv0dNQVEgGMQ6rbXXgetI211pMMK
	JaEVDKZWS4gHD0m3LIRXisXqMl03wowK2HYZ
X-Google-Smtp-Source: AGHT+IF1QW7SwnOCpcKg58LgqFf8SZTBwL+GQ3Q1em9/tQyXx7uBM8mpL5nEsXGBKvWHYznA6BeXLQ==
X-Received: by 2002:a17:902:ea11:b0:1c0:a5c9:e072 with SMTP id s17-20020a170902ea1100b001c0a5c9e072mr8143055plg.11.1693794305483;
        Sun, 03 Sep 2023 19:25:05 -0700 (PDT)
Received: from localhost.localdomain ([14.116.239.34])
        by smtp.gmail.com with ESMTPSA id h9-20020a170902748900b001c3267ae314sm3041636pll.156.2023.09.03.19.25.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Sep 2023 19:25:05 -0700 (PDT)
From: Hengqi Chen <hengqi.chen@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	hengqi.chen@gmail.com
Subject: [PATCH bpf-next 0/2] libbpf: Support symbol versioning for uprobe
Date: Mon,  4 Sep 2023 02:24:42 +0000
Message-Id: <20230904022444.1695820-1-hengqi.chen@gmail.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Dynamic symbols in shared library may have the same name, for example:

    $ nm -D /lib/x86_64-linux-gnu/libc.so.6 | grep rwlock_wrlock
    000000000009b1a0 T __pthread_rwlock_wrlock@GLIBC_2.2.5
    000000000009b1a0 T pthread_rwlock_wrlock@@GLIBC_2.34
    000000000009b1a0 T pthread_rwlock_wrlock@GLIBC_2.2.5

    $ readelf -W --dyn-syms /lib/x86_64-linux-gnu/libc.so.6 | grep rwlock_wrlock
      706: 000000000009b1a0   878 FUNC    GLOBAL DEFAULT   15 __pthread_rwlock_wrlock@GLIBC_2.2.5
      2568: 000000000009b1a0   878 FUNC    GLOBAL DEFAULT   15 pthread_rwlock_wrlock@@GLIBC_2.34
      2571: 000000000009b1a0   878 FUNC    GLOBAL DEFAULT   15 pthread_rwlock_wrlock@GLIBC_2.2.5

There are two pthread_rwlock_wrlock symbols in .dynsym section of libc.
The one with @@ is the default version, the other is hidden.
Note that the version info is actually stored in .gnu.version and .gnu.version_d
sections of libc and the two symbols are at the same offset.

Currently, specify `pthread_rwlock_wrlock`, `pthread_rwlock_wrlock@@GLIBC_2.34`
or `pthread_rwlock_wrlock@GLIBC_2.2.5` in bpf_uprobe_opts::func_name won't work.
Because there are two `pthread_rwlock_wrlock` in .dynsym sections without the
version suffix and both are global bind.

This patchset adds symbol versioning ([0]) support for dynsym for uprobe,
so that we can handle the above case.

  [0]: https://refspecs.linuxfoundation.org/LSB_3.0.0/LSB-PDA/LSB-PDA.junk/symversion.html

Hengqi Chen (2):
  libbpf: Resolve ambiguous matches at the same offset for uprobe
  libbpf: Support symbol versioning for uprobe

 tools/lib/bpf/elf.c | 103 ++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 94 insertions(+), 9 deletions(-)

--
2.39.3

