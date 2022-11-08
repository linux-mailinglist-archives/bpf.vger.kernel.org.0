Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E346662184D
	for <lists+bpf@lfdr.de>; Tue,  8 Nov 2022 16:32:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233372AbiKHPcD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Nov 2022 10:32:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231740AbiKHPcB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Nov 2022 10:32:01 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDB2019C2B
        for <bpf@vger.kernel.org>; Tue,  8 Nov 2022 07:32:00 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id g12so21503156wrs.10
        for <bpf@vger.kernel.org>; Tue, 08 Nov 2022 07:32:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0GUFwgOkGsyC03S6zyJRhPhN7+6xq2GRvF3sgARU6GE=;
        b=SgIGyqIdNCXS0TzyiQfcGaJnWPekdZLhTz1dqpQTiaeqRiTQGFin4S8L9FyhFe9DNt
         HTaprIutua2zzxHegO9wk8JsdyBy/DuCkm4Odnc3I5wlCSXT/52T1jRD9vKanZtsG705
         YhUyD9gddmI45qX5vPAXF4/qo38Kb6TaQKOyOC6/BQ00+zT8EG3Gcx50XrYtewHWWp+Q
         eLkOwEuSpFTw9cQNIFSaNX3iv6IcpLBMZBrrae/kgVBCbSDYhkUrz4i/N5M0iE4mj6cZ
         uJGVHQS1eETK8qZWOmFcf2ZaBIgwgcY5cDFQhoMkD8hhDtMuXf9xOjgiW1I9TS/xEDrQ
         +zZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0GUFwgOkGsyC03S6zyJRhPhN7+6xq2GRvF3sgARU6GE=;
        b=wy29vMIdEe4VFawp+F7rgWlLYEfXoZhCAD0lBrnT1oqCPjq+aZv7enBKYlQk4iyGt+
         /zpjSo3n2PERDWdSUXPp6u9S4l426B5z13+7+5IpeNhmRWQR3B2Wo64hDX2KuyRDVugi
         OIGUx8M5a6TjRyj1ruiadbYVZzT4ITU2hIlJBElP7D05PcaFvYD4fHQ0Lg1p/BUjmBdZ
         5fiFdyA1GJPGGSXtMeaihwgqWO0EiSUQ4nbRQ9PyCiFs6cE46mAUbZ+D/K8/8NYO1kYs
         JYtU5MOgt3IABT4IsiMIIuI3oU9SG4VXCouElRtS5VRrJRup4Zsbol7gdmJ6/c2HgcV9
         mdWw==
X-Gm-Message-State: ACrzQf0o+1hq8/quwhUby0ZvpgsLms8RXCTk1kp+917TDxDXqIO6EcIZ
        L88v1sYnjiAhhUfohLnLoXTJWlbrz1NBZxSi
X-Google-Smtp-Source: AMsMyM7+jWZrKN14L0F6Eeh+iJG8mOrfr4iLwvg95e7OxEOzc+3t1xBHmHLKcYoxEre7ytraQsdPhQ==
X-Received: by 2002:a5d:58d9:0:b0:236:5b81:2c99 with SMTP id o25-20020a5d58d9000000b002365b812c99mr36294373wrf.494.1667921518903;
        Tue, 08 Nov 2022 07:31:58 -0800 (PST)
Received: from pluto.. (boundsly.muster.volia.net. [93.72.16.93])
        by smtp.gmail.com with ESMTPSA id e5-20020adfef05000000b00225307f43fbsm10666822wro.44.2022.11.08.07.31.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 07:31:57 -0800 (PST)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, kernel-team@fb.com,
        yhs@fb.com, Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v2 0/3] libbpf: btf_decl_tag attribute for btf dump in C format
Date:   Tue,  8 Nov 2022 17:31:32 +0200
Message-Id: <20221108153135.491383-1-eddyz87@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Support for clang's __attribute__((btf_decl_tag("..."))) by
btf_dump__dump_type and btf_dump__dump_type_data functions.
Decl tag attributes are restored for:
- structs and unions
- struct and union fields
- typedefs
- global variables
- function prototype parameters

The attribute is restored using __btf_decl_tag macro that is printed
upon first call to btf_dump__dump_type function:

 #if __has_attribute(btf_decl_tag)
 #define __btf_decl_tag(x) __attribute__((btf_decl_tag(x)))
 #else
 #define __btf_decl_tag(x)
 #endif

To simplify testing of the btf_dump__dump_type_data the
prog_tests/btf_dump.c:test_btf_dump_case is extended to invoke
btf_dump__dump_type_data for each DATASEC object in the test case
binary file.

Changelog:
v1 -> v2:
- prog_tests/btf_dump.c:test_btf_dump_case modified to print DATASECs
  using btf_dump__dump_type_data;
- support for decl tags applied to global variables and function
  prototype parameters;
- update to support interleaved calls to btf_dump__dump_type and
  btf__add_decl_tag (incremental dump);
- fix for potential double free error in btf_dump_assign_decl_tags;
- styling fixes suggested by Andrii.

RFC -> v1:
- support for decl tags applied to struct / union fields and typedefs;
- __btf_decl_tag macro;
- btf_dump->decl_tags hash and equal functions updated to use integer
  key instead of a pointer;
- realloc_decl_tags function removed;
- update for allocation logic in btf_dump_assign_decl_tags.

[v1]  https://lore.kernel.org/bpf/20221103134522.2764601-1-eddyz87@gmail.com/
[RFC] https://lore.kernel.org/bpf/20221025222802.2295103-4-eddyz87@gmail.com/

Eduard Zingerman (3):
  libbpf: __attribute__((btf_decl_tag("..."))) for btf dump in C format
  selftests/bpf: Dump data sections as part of btf_dump_test_case tests
  selftests/bpf: Tests for BTF_KIND_DECL_TAG dump in C format

 tools/lib/bpf/btf_dump.c                      | 186 +++++++++++++++-
 .../selftests/bpf/prog_tests/btf_dump.c       | 198 ++++++++++++++++--
 .../bpf/progs/btf_dump_test_case_decl_tag.c   |  65 ++++++
 3 files changed, 427 insertions(+), 22 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/btf_dump_test_case_decl_tag.c

-- 
2.34.1

