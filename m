Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 006E562448C
	for <lists+bpf@lfdr.de>; Thu, 10 Nov 2022 15:43:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbiKJOnm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Nov 2022 09:43:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230430AbiKJOnk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 10 Nov 2022 09:43:40 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82C38303D1
        for <bpf@vger.kernel.org>; Thu, 10 Nov 2022 06:43:39 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id b2so5526472eja.6
        for <bpf@vger.kernel.org>; Thu, 10 Nov 2022 06:43:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Vn+V/3k+ExUHU0PBVxTLxALE0aRVofa8KLDQKs5W/u0=;
        b=WRSV+eV3yPQakUcV2ivZ4+kf3cGhReUT5YB4Je9dYlSJ4OGT4eO1Q+pJnFZ/5BXlIg
         nyBHTHj43vFx7YRHl/ujXMIuvj1IO0LLnXGyJDY/Tch2OJnkCv9tygJ2V796ocTC5NBu
         G/5jVklrADi3GRfKFZaHTs6lOqD5oTfBkI+mGaqsfHt6wktGIQ6qXI2Sw8p2AN53ryv5
         kg/Xzt2o9o3qGwU+Dt96I+ZhlZJkGC4hbYmM/qF1FOpY99hWwS6fTf7SbHz7Ps737yOI
         nvWlIubTcn85UawHbQ0/pXhDMV3i6gjLXihx5lqbxiMOYuiOV2ihZyzbsmw5LwqR0asA
         wVeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vn+V/3k+ExUHU0PBVxTLxALE0aRVofa8KLDQKs5W/u0=;
        b=4Upe93a3omxQk/nTkk7/U4oT4FOknRR4vu/t6ySpUHFQY0hEM+btjYCwcG/ZuhVC9s
         rP7aMGdEL5gwa3ngWEUWJOuxMSjRMmAG8Z0SAUQJWpQsgLPjkmzixxBGHWqOwZnD2A0i
         CuT9QbjSFeMKudZBmWmfuJkivJuqyC/alkRa8ghgs6VOm/WWdZuCKPiexhwUv7I6Zs2e
         bKaLfEMyOge8t/ILrPAsZM/KOCMRwS5OwrztOGQuZxYv1Bb1dcsKHfc3pXqOw5boDSI/
         Hwu0+noSoWEa2D0yuqNJVE41z0FOb1YFNOPOERTRtvkOLcKAtH1u/b/pr4X9bWMuo+GK
         UgNQ==
X-Gm-Message-State: ANoB5pnHqGRKhPIMkRCM6O23az3XIEUbM6j2WXYlR4RAck6s4F1JjJJW
        PxFkCx/JrSb+csRDq8udD7pNXLnCvoT4qvDa
X-Google-Smtp-Source: AA0mqf4/VWkBWlqTH20C/CMAuDyVV1tMzusZ64Ygsy8wHVjFQQ0mMteO996Mt5IxI0OpFq2ybIugvg==
X-Received: by 2002:a17:907:c086:b0:7ae:566e:3eba with SMTP id st6-20020a170907c08600b007ae566e3ebamr21973825ejc.470.1668091417813;
        Thu, 10 Nov 2022 06:43:37 -0800 (PST)
Received: from pluto.. (boundsly.muster.volia.net. [93.72.16.93])
        by smtp.gmail.com with ESMTPSA id g22-20020a50ee16000000b004616b006871sm8609272eds.82.2022.11.10.06.43.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 06:43:37 -0800 (PST)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, kernel-team@fb.com,
        yhs@fb.com, Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v3 0/3] libbpf: btf_decl_tag attribute for btf dump in C format
Date:   Thu, 10 Nov 2022 16:43:17 +0200
Message-Id: <20221110144320.1075367-1-eddyz87@gmail.com>
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
v2 -> v3:
- rebase to fix merge issues after recent hashmap interface update;
- call to btf_dump_assign_decl_tags removed from btf_dump__new as
  redundant.

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

[v2]  https://lore.kernel.org/bpf/20221108153135.491383-1-eddyz87@gmail.com/
[v1]  https://lore.kernel.org/bpf/20221103134522.2764601-1-eddyz87@gmail.com/
[RFC] https://lore.kernel.org/bpf/20221025222802.2295103-4-eddyz87@gmail.com/

Eduard Zingerman (3):
  libbpf: __attribute__((btf_decl_tag("..."))) for btf dump in C format
  selftests/bpf: Dump data sections as part of btf_dump_test_case tests
  selftests/bpf: Tests for BTF_KIND_DECL_TAG dump in C format

 tools/lib/bpf/btf_dump.c                      | 181 +++++++++++++++-
 .../selftests/bpf/prog_tests/btf_dump.c       | 197 ++++++++++++++++--
 .../bpf/progs/btf_dump_test_case_decl_tag.c   |  65 ++++++
 3 files changed, 421 insertions(+), 22 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/btf_dump_test_case_decl_tag.c

-- 
2.34.1

