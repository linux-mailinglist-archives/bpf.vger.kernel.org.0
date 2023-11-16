Return-Path: <bpf+bounces-15209-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13D0F7EE79E
	for <lists+bpf@lfdr.de>; Thu, 16 Nov 2023 20:43:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 440B91C20866
	for <lists+bpf@lfdr.de>; Thu, 16 Nov 2023 19:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBA3448CE4;
	Thu, 16 Nov 2023 19:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kyQOkkDE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 058D818D
	for <bpf@vger.kernel.org>; Thu, 16 Nov 2023 11:43:08 -0800 (PST)
Received: by mail-oo1-xc35.google.com with SMTP id 006d021491bc7-5872b8323faso590490eaf.1
        for <bpf@vger.kernel.org>; Thu, 16 Nov 2023 11:43:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700163786; x=1700768586; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Thy1MSfrFa3NRa5fVdCeMRBXT2LRdLnJbgIA0XaSQmo=;
        b=kyQOkkDE15VlmEskeXswe3zzkHri4AacspOzYaZgMkwJMqL5rwfbWlmE2zckxKKr/I
         BbRUzi4kuON7/UmQhQ9n7d38JipmVfJVFx1XFm1YVq2vPnvTT9IdSYaqv67XD6ggp3hK
         M4NWuA2vgTxolHbSs1Jw34N6d3yKkVadWnTTsTUW6KGmHH/Gdz1Y+2p+KO0carQj1KCO
         Aii7gKpcI0qfB0GRJEf+ksVh1ZY+YwVUz/Djv+BF7bQ3e9g9NWm67yh/GC4+Ao6AMABa
         Hg+f4uEEJkNsv3pfSzXJhOwXblj4jL6WX1G9Q1Oa0UWIr17Du687k6ALrlmR4XzlzJL0
         pENA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700163786; x=1700768586;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Thy1MSfrFa3NRa5fVdCeMRBXT2LRdLnJbgIA0XaSQmo=;
        b=EscKFMGwvMpbu4WFVQuS2fAvhF67o6GtPQvDe+/1F6/zUJsqXhMD6blMK5eWSKXqQ+
         6kI7XqzRam2mJeeVELoY/X6x1tA1jWRYD/Z3LLy39uiVBXuyyhWDDe70Mq9aZ28bOOEL
         8+LkNwHnIfr2JJLxbEYyzjKpwvNAjUmagLP90eJEsBeYJ3NVL+Sq7CNaNnR817Dd0ykn
         /XqnI547Epi+Fb6lfBsg9pkxWh01q/85f8QSL0/P7DLf+qRL9zoWb0YDZzDfHIRTut9N
         R52mvTsegAlRAYBif7QMrx/oJnC5+JFjFynKBmMWe86TBl93m6dybokBhZgY+UKpE5Uu
         k3Dg==
X-Gm-Message-State: AOJu0Yz99wLv4N/XrrscLhWbu1TiAgME7bcJ3LqU6UePGyOZDAhMGNeW
	Mr9zoHrZ5RJGBfQPBD2uJcmLqnnA+8AhHg==
X-Google-Smtp-Source: AGHT+IH59CmecdL7qg+S9iCqso20s4yyv9LrfO8KnSuQz+vuh5sPVFIi/ITWMaSt7DQAgEorNvGQww==
X-Received: by 2002:a4a:9205:0:b0:589:df75:2d83 with SMTP id f5-20020a4a9205000000b00589df752d83mr15424189ooh.1.1700163786577;
        Thu, 16 Nov 2023 11:43:06 -0800 (PST)
Received: from localhost (fwdproxy-vll-007.fbsv.net. [2a03:2880:12ff:7::face:b00c])
        by smtp.gmail.com with ESMTPSA id q2-20020a4aac42000000b0057e66fa004dsm13312oon.47.2023.11.16.11.43.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 11:43:06 -0800 (PST)
From: Manu Bretelle <chantr4@gmail.com>
To: bpf@vger.kernel.org,
	quentin@isovalent.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org
Subject: [PATCH v1 bpf-next  0/9] bpftool: Add end-to-end testing
Date: Thu, 16 Nov 2023 11:42:27 -0800
Message-Id: <20231116194236.1345035-1-chantr4@gmail.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series introduce a more ergonomic end-to-end testing for `bpftool`.

While there is already some `bpftool` tests, they are so far shallow
tests, validating features (test_bpftool.py), or validating expectations
by mean of grepping for expected output in payload
(test_bpftool_metadata.sh), which is hard to extend.

`bpftool` being an operational tool, it is important to ensure that it
operates correctly and reliably when needed, e.g when dealing with
operational issues/incidents.
By performing end-to-end validation of `bpftool` functionalities, we can
ensure that no regression is introduced.

To improve testability, and make end-to-end testing easier, this series is
leveraging `libbpf-rs` [0], allowing us to leverage an existing testing
framework [1], and the ability to load and natively interact with bpf
programs, maps, struct_ops... and finally running `bpftool` command and
checking its output, behaviour, against a set of known expectations.

Currently, the series comes with a set of tests that validate basic
operations such as listing maps, and progs, dumping them, and being able
to attribute the pid that loaded/created those. For struct_ops, it tests
that we can list, dump, and also unregister them by id or name.


    test bpftool_tests::run_bpftool ... ok
    test bpftool_tests::run_bpftool_map_dump_id ... ok
    test bpftool_tests::run_bpftool_map_list ... ok
    test bpftool_tests::run_bpftool_map_pids ... ok
    test bpftool_tests::run_bpftool_prog_list ... ok
    test bpftool_tests::run_bpftool_prog_pids ... ok
    test bpftool_tests::run_bpftool_prog_show_id ... ok
    test bpftool_tests::run_bpftool_struct_ops_can_unregister_id ... ok
    test bpftool_tests::run_bpftool_struct_ops_can_unregister_name ... ok
    test bpftool_tests::run_bpftool_struct_ops_dump_name ... ok
    test bpftool_tests::run_bpftool_struct_ops_list ... ok

[0] https://docs.rs/libbpf-rs/latest/libbpf_rs/
[1] https://doc.rust-lang.org/book/ch11-00-testing.html

Manu Bretelle (9):
  bpftool: add testing skeleton
  bpftool: add libbpf-rs dependency and minimal bpf program
  bpftool: open and load bpf object
  bpftool: Add test to verify that pids are associated to maps.
  bpftool: add test for bpftool prog
  bpftool: test that we can dump and read the content of a map
  bpftool: Add struct_ops tests
  bpftool: Add bpftool_tests README.md
  bpftool: Add Makefile to facilitate bpftool_tests usage

 .../selftests/bpf/bpftool_tests/.gitignore    |   3 +
 .../selftests/bpf/bpftool_tests/Cargo.toml    |  14 +
 .../selftests/bpf/bpftool_tests/Makefile      |  22 +
 .../selftests/bpf/bpftool_tests/README.md     |  91 ++++
 .../selftests/bpf/bpftool_tests/build.rs      |  16 +
 .../bpftool_tests/src/bpf/bpftool_tests.bpf.c |  82 ++++
 .../bpf/bpftool_tests/src/bpf/vmlinux.h       |   1 +
 .../bpf/bpftool_tests/src/bpftool_tests.rs    | 408 ++++++++++++++++++
 .../selftests/bpf/bpftool_tests/src/main.rs   |   2 +
 9 files changed, 639 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/bpftool_tests/.gitignore
 create mode 100644 tools/testing/selftests/bpf/bpftool_tests/Cargo.toml
 create mode 100644 tools/testing/selftests/bpf/bpftool_tests/Makefile
 create mode 100644 tools/testing/selftests/bpf/bpftool_tests/README.md
 create mode 100644 tools/testing/selftests/bpf/bpftool_tests/build.rs
 create mode 100644 tools/testing/selftests/bpf/bpftool_tests/src/bpf/bpftool_tests.bpf.c
 create mode 120000 tools/testing/selftests/bpf/bpftool_tests/src/bpf/vmlinux.h
 create mode 100644 tools/testing/selftests/bpf/bpftool_tests/src/bpftool_tests.rs
 create mode 100644 tools/testing/selftests/bpf/bpftool_tests/src/main.rs

-- 
2.39.3


