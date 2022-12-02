Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5956763FFA0
	for <lists+bpf@lfdr.de>; Fri,  2 Dec 2022 05:58:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232168AbiLBE6C (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 1 Dec 2022 23:58:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231575AbiLBE6B (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 1 Dec 2022 23:58:01 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FDA92B258
        for <bpf@vger.kernel.org>; Thu,  1 Dec 2022 20:57:59 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-352e29ff8c2so38528247b3.21
        for <bpf@vger.kernel.org>; Thu, 01 Dec 2022 20:57:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0BZrtu6a4uY0PQiXNtiOGBfNeRj9TpPw09DbPuRe0Eg=;
        b=X4m7nIQ+QvDHeTb0ha5tBcYbrBQDFWJW2lsYSWb+uqOeXSfgqk77lGCxeuIMXLwMlT
         q/4vMEZeFJSlLF2ADUr2StBpjojZUi+QvA/YbVuEUxKO21f72Ck/EqwOMQv3YELK2UWX
         T+Z4sgXOrcSVxRTgD0iZSbG0sPIExiR3lVyDNrzH3qaj2+amwE662AQONkaie/Ww8qob
         8sqcdhZyAJj3vDbUax8l28/BdoqMKcSpSpp/aQlmUR0Lf+Uq7kP45MgqtlwvQqzdS4Je
         ++SZ5gIIaCcyDn0SiNgUSUyXoQKqNZhNWvVFoiCzjONvbiVV5lk4UTwNm+y/zuz1qLXt
         /YZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0BZrtu6a4uY0PQiXNtiOGBfNeRj9TpPw09DbPuRe0Eg=;
        b=aLt2JYaLHilwrLX11NxcX+2upxfCphb5ymsudyqbP5BEcXwQfQirdkMRdi7TBp/mTP
         yexuPZPAXxzQRzXNngIlGZ5vhA6HX5l0MHdwk2akTaLL8wIhUMwe+gs9jCkwJHiUtem5
         LlKxOHx7GB2oQW7djhhFDRVV95jCIQnAs4F8OmzvAdPytlYIV9soxeJT7K98ztUFwfrt
         c04vQ/HTUl9dGwdYFIwERpBf0X6iZpxYJkWh/Hj7SGjzP6p18U1F9BEKJvQtXCDlyETL
         VPG7d45HWp8jEHIO8SIC0TvmLTpq+ruM+K2CMMFTdPv51pJM9yRDTixL9rEgn646GM5i
         ejLg==
X-Gm-Message-State: ANoB5plY8AAABrlFRZsUHWzfCZ3oSXuX383HTUIXvV7Ix1l89Mo14O13
        ZqvXIwvsDxjICDhMWgJNDDfUiAjI3RSY
X-Google-Smtp-Source: AA0mqf5o0BmDUnUrinpRrQas0w4b7hDEpgBGbb2aeFzVqUVBfV1v1tX10UCBeoqIbKr4DRhNsSULBK0wW7Gd
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:e3b0:e3d1:6040:add2])
 (user=irogers job=sendgmr) by 2002:a25:ba8a:0:b0:6cc:6a92:7a17 with SMTP id
 s10-20020a25ba8a000000b006cc6a927a17mr48131719ybg.282.1669957078446; Thu, 01
 Dec 2022 20:57:58 -0800 (PST)
Date:   Thu,  1 Dec 2022 20:57:38 -0800
Message-Id: <20221202045743.2639466-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.0.rc0.267.gcb52ba06e7-goog
Subject: [PATCH 0/5] Improvements to incremental builds
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        bpf@vger.kernel.org, llvm@lists.linux.dev
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Switching to using install_headers caused incremental builds to always
rebuild most targets. This was caused by the headers always being
reinstalled and then getting new timestamps causing dependencies to be
rebuilt. Follow the convention in libbpf where the install targets are
separated and trigger when the target isn't present or is out-of-date.

Further, fix an issue in the perf build with libpython where
python/perf.so was also regenerated as the target name was incorrect.

Ian Rogers (5):
  tools lib api: Add dependency test to install_headers
  tools lib perf: Add dependency test to install_headers
  tools lib subcmd: Add dependency test to install_headers
  tools lib symbol: Add dependency test to install_headers
  perf build: Fix python/perf.so library's name

 tools/lib/api/Makefile     | 38 ++++++++++++++++++++++-----------
 tools/lib/perf/Makefile    | 43 +++++++++++++++++++-------------------
 tools/lib/subcmd/Makefile  | 23 +++++++++++---------
 tools/lib/symbol/Makefile  | 21 ++++++++++++-------
 tools/perf/Makefile.config |  4 +++-
 tools/perf/Makefile.perf   |  2 +-
 6 files changed, 79 insertions(+), 52 deletions(-)

-- 
2.39.0.rc0.267.gcb52ba06e7-goog

