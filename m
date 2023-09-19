Return-Path: <bpf+bounces-10385-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C5FD7A611A
	for <lists+bpf@lfdr.de>; Tue, 19 Sep 2023 13:24:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88D48281DC4
	for <lists+bpf@lfdr.de>; Tue, 19 Sep 2023 11:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65C043D3B8;
	Tue, 19 Sep 2023 11:24:10 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD838498;
	Tue, 19 Sep 2023 11:24:08 +0000 (UTC)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90184B8;
	Tue, 19 Sep 2023 04:24:07 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id 5614622812f47-3ab2436b57dso3834347b6e.0;
        Tue, 19 Sep 2023 04:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695122647; x=1695727447; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LbBSpFYa87LH2WEvWsqmrDWgJ1dZQx9jPdrdvGfJfNE=;
        b=LwBNLXH1uRwLFgOesBvaJ43VKmVxXI7nah8mK/weS5sev2Ji+SgVG921QfOvXjMimi
         nO1tOcIJ99DZYqANztw3yu7JB3RkhN/WAbhXzbuZAG7WQ/rKGIe/XnneAeZDV+Qo+Tx7
         IuT3KhipcPkD/oj3gwcrBtngHRSkYL6Qxmjhs/KKXdxI5VC+yXFoy//m9BQkh9MA3A1p
         F0389e0YyLUsqb9vVeTjFhHNq7wEhiqej8UyUtqvD6E04Hhr05QMiF4AfUUaT798xEFK
         E8bBrjlw7ToLAywAMbtJGCXIG/7m0KTpEr9YJHZMNQT8dRbjRzavqlQsXsgxIsf05JGm
         i52g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695122647; x=1695727447;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LbBSpFYa87LH2WEvWsqmrDWgJ1dZQx9jPdrdvGfJfNE=;
        b=HoNkkvgKBue9tkPYgL9PMCUyOiKZJSDMeOC6vasS+nxncJGE6La4Kqzc8cr7GQWr2k
         a3/+BurO6bpa0E5a5yBqFwsQ/WQzE4i6nlcTh/0KIZzajHCpwQSPdtTEMyiI2nFakCFK
         9fF+MEPAT+QDp9B9ZzobX9f83GpFTTnEk68z6DWMGDeX+Ft6YowutEcX8gkdyQoLQ7uU
         vdF9sPQAWIIbLvhUN1Ky338q6gPVi0k4Iumkjwsly+5CcDxTMysGDtIzvoSTwxJFLk3X
         0h/uR8N9vRdjPiodpFRskriHz/2Np6fZXgF8VwJPY0Jys7z59ajKOS3uzZrGOUNZ4LVe
         3YuA==
X-Gm-Message-State: AOJu0Yw5qBwHWLYKpL1+hyXgEig6kP7oZ5flm7IGgmTLT2Di9cmgPk6c
	ZWRAdvkj9npra/Xn80w0/mhfepMDsbkSCw==
X-Google-Smtp-Source: AGHT+IG2pidvlMrWny7/3VdYRZ0lqmFTtIDZAmYQ57Bg61yHmETysWcx6GTIFtvUtgMD0/v+qVXcDw==
X-Received: by 2002:a05:6808:9b0:b0:3a7:2efb:cb71 with SMTP id e16-20020a05680809b000b003a72efbcb71mr12788885oig.25.1695122646758;
        Tue, 19 Sep 2023 04:24:06 -0700 (PDT)
Received: from localhost.localdomain ([2620:10d:c091:400::5:ffd1])
        by smtp.gmail.com with ESMTPSA id h23-20020ac85697000000b0040fd47985e6sm3697895qta.97.2023.09.19.04.24.04
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 19 Sep 2023 04:24:06 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: davem@davemloft.net
Cc: kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	daniel@iogearbox.net,
	andrii@kernel.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	kernel-team@fb.com
Subject: pull-request: bpf-next 2023-09-19
Date: Tue, 19 Sep 2023 04:24:01 -0700
Message-Id: <20230919112401.21699-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
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

Hi David, hi Jakub, hi Paolo, hi Eric,

The following pull-request contains BPF updates for your *net-next* tree.

We've added 4 non-merge commits during the last 1 day(s) which contain
a total of 4 files changed, 9 insertions(+), 13 deletions(-).

The main changes are:

1) A set of fixes for bpf exceptions, from Kumar and Alexei.

Please consider pulling these changes from:

  git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git 

Thanks a lot!

Also thanks to reporters, reviewers and testers of commits in this pull-request:

Alexei Starovoitov, Eric Dumazet, kernel test robot, Matthieu Baerts

----------------------------------------------------------------

The following changes since commit a5ea26536e89d04485aa9e1c8f60ba11dfc5469e:

  Merge branch 'stmmac-devvm_stmmac_probe_config_dt-conversion' (2023-09-18 12:44:36 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git 

for you to fetch changes up to aec42f36237b09e42eac39f6c74305aec02b4694:

  bpf: Remove unused variables. (2023-09-19 02:26:47 -0700)

----------------------------------------------------------------
Alexei Starovoitov (1):
      bpf: Remove unused variables.

Kumar Kartikeya Dwivedi (3):
      selftests/bpf: Print log buffer for exceptions test only on failure
      bpf: Fix bpf_throw warning on 32-bit arch
      bpf: Disable exceptions when CONFIG_UNWINDER_FRAME_POINTER=y

 arch/x86/net/bpf_jit_comp.c                         | 9 ++++-----
 kernel/bpf/helpers.c                                | 2 +-
 kernel/bpf/verifier.c                               | 6 +-----
 tools/testing/selftests/bpf/prog_tests/exceptions.c | 5 +++--
 4 files changed, 9 insertions(+), 13 deletions(-)

