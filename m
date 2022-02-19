Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 035AA4BC834
	for <lists+bpf@lfdr.de>; Sat, 19 Feb 2022 12:37:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237742AbiBSLiH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 19 Feb 2022 06:38:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231231AbiBSLiG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 19 Feb 2022 06:38:06 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C1FD48E44
        for <bpf@vger.kernel.org>; Sat, 19 Feb 2022 03:37:48 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id y5so4507776pfe.4
        for <bpf@vger.kernel.org>; Sat, 19 Feb 2022 03:37:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yL5Q7WOjCtbA+X12hnwZdDJttlQ+Tv0xlxrlvSJltYw=;
        b=X3lHpudD2c+t0vl87/amfoV+xiCcn38M/ucIkackIiZAxMyNWhOyAzgdPPefx1t1NW
         Kz2P+uquBn2+c6xpSO/QHgRgbvUApzNr9zOHBBugyMF3Ri6FIkGwCxMdR8Pa7va2KCpy
         RgpBti6mYWMw9jujmI4IjjusQ3ojTRwO4/H6I9KDJeaJqSRWfzWTS43O7N3Sw4RynoXo
         qKPBDmTQO+TffCsezRu1UTRI7/nViqQC5bCHRwSzQK7nOzb6wzKGCAsyqrwMEpSIlNFj
         Vq9kc3CB5bPd1uEWrCFwdCR7r+f7GMa26XuRTIsR6XJNzxnH1i0PkLxeMZq+fp6gP9wN
         gACg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yL5Q7WOjCtbA+X12hnwZdDJttlQ+Tv0xlxrlvSJltYw=;
        b=Wre2RUadGWIKkjBl9sbwI4zs9MK+kSHjYW+wqem88Ef83DLF8kMs9D+ydg502wSgGB
         DdaxLdNpkKVxp3yih+EKxvq7cn4cjquuk8Pb+Np2B8Fr9gMSiVTS0FXn/Tx9hDUKyyvc
         8XbhXxLE6b9VHZUDIQ6b4EBpmMKrKIdp0DZ3AJ9JiwXjVuPfFnLf38BqVdTJfEAt4sj2
         5z2XPjxWo+Fm+zfwYYw+30/NN3O45YaoTnOaHoVn6jmPscWOJEMXYD8aOodzfrpjwz/h
         XA8aFats828AGfi8PPOgmbUrK8/cLcdX6YKvuSlR56UqqVu6/onmrTa4vYXRKfNVtSef
         HSJQ==
X-Gm-Message-State: AOAM532WPsxxp+7oy2bBdDVisj4hFqs7jB+eAyc0ggX75vphQP9uyWST
        rMlRwNA+vFtND3kAjpBd3Q6ZSd6gOW0=
X-Google-Smtp-Source: ABdhPJzGe0QKrIrl+5sqo2KERiGC0yq1mzR/Z+sQ5aamrO4GKut3RWiz2yAGdcrbh3nqZ/67bqaReQ==
X-Received: by 2002:a63:d814:0:b0:373:8748:be9a with SMTP id b20-20020a63d814000000b003738748be9amr9484425pgh.473.1645270667681;
        Sat, 19 Feb 2022 03:37:47 -0800 (PST)
Received: from localhost ([2405:201:6014:d0c0:6243:316e:a9e1:adda])
        by smtp.gmail.com with ESMTPSA id d8sm6572540pfj.179.2022.02.19.03.37.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Feb 2022 03:37:47 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH bpf v1 0/5] More fixes for crashes due to bad PTR_TO_BTF_ID reg->off
Date:   Sat, 19 Feb 2022 17:07:39 +0530
Message-Id: <20220219113744.1852259-1-memxor@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4059; h=from:subject; bh=7TrpLtrYl1o/DHNBzATbTzMEzIKnellRLFEFopEBgtg=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBiENZ5dIXKuFfGb7RPznDncE739zFcVddxHEMWXLXr RGFWc/uJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYhDWeQAKCRBM4MiGSL8RyrRbD/ 9GxqTImpj9cT39ywfAJcR2EQIrlTisE1TxAlLbfIO5AGXbzI7jZhgcre2YwkyWDAjz77rU2zDjFn9/ 8e40bi3/RBVQqnFC0kBu/62yOjHta+SOxPoB70ThxoIxBJMlByEtQAoVuSiKGzWcCDieOCT9X/ZhY9 EeeDTeaM0OvGb5LgZG0spgurIRYlU7ebzX/MDt2y0ctmAa8hauidOE47++ptBKuMeQE4USZwSgKdra FMTXy0K3r/QwTznbD1zq1JSeRsCpOQELrzeDXDZaIKRom/i539iEvYsb8fprRaVVgxk+ZhpgTMVqAj /Vhgw1ldkRVzXFWWhPgAnrEyTh0aDFojYIEiGIDBbwUYfUCZ+g4CXJdaGCrTybmeZmiIRdV74m0bB1 9bur4mNLv+3kkPTPpyOdrpz0TMiXJAOochuOr32LheXs2JTSh27CdKRO/4S4vqABDsXeEUGn/hn1gX /wFZLI3x0pR9Wq42WLNeWHgtiOyh8yy/Qv4RMOj9t+JTgjqZrA+Em4OKRn490NZOGRmM3fnnfnqxSl /malTVq4q6Ya9T/C4OIs6HuY3/PJxq1wFPx5Gt1wMR12GwqwsQSspbJjaEpTIPWpPq5o+E1QvhE6jo Z6DCAmUpbUVj+DODtxK28D2i1711mJb8owLXOqnhb+829BVvvdXaPusSlk1g==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

A few more fixes for bad PTR_TO_BTF_ID reg->off being accepted in places, that
can lead to the kernel crashing. Noticed while making sure my own series for BTF
ID pointer in map won't allow stores for pointers with incorrect offsets.

I include one example where d_path can crash even if you NULL check
PTR_TO_BTF_ID, and one example of how missing NULL check in helper taking
PTR_TO_BTF_ID (like bpf_sock_from_file) is a real problem, see the selftest
patch.

The &f->f_path becomes NULL + offset in case f is NULL, circumventing NULL
checks in existing helpers. The only thing needed to trigger this finding an
object that embeds the object of interest, and then somehow obtaining a NULL
PTR_TO_BTF_ID to it (not hard, esp. due to exception handler for PROBE_MEM loads
writing 0 to destination register).

However, for the case of patch 2, it is allowed in my series since the next load
of the bad pointer stored using:
  struct file *f = ...; // some pointer walking returning NULL pointer
  map_val->ptr = &f->f_path; // ptr being struct path *
... would be marked as PTR_UNTRUSTED, so it won't be allowed to be passed into
the kernel, and hence can be permitted. In referenced case, the PTR_TO_BTF_ID
should not be NULL anyway. kptr_get style helper takes PTR_TO_MAP_VALUE in
referenced ptr case only, so the load either yields NULL or RCU protected
pointer.

Tests for patch 1 depend on fixup_kfunc_btf_id in test_verifier, hence will be
sent after merge window opens, some other changes after bpf tree merges into
bpf-next, but all pending ones can be seen here [0]. Tests for patch 2 are
included, and try to trigger crash without the fix, but it's not 100% reliable.
We may need special testing helpers or kfuncs to make it thorough, but wanted to
wait before getting feedback.

Issue fixed by patch 2 is a bit more broader in scope, and would require proper
discussion (before being applied) on the correct way forward, as it is
technically backwards incompatible change, but hopefully never breaks real
programs, only malicious or already incorrect ones.

Also, please suggest the right "Fixes" tag for patch 2.

As for patch 3 (selftest), please suggest a better way to get a certain type of
PTR_TO_BTF_ID which can be NULL or NULL+offset. Can we add kfuncs for testing
that return such pointers and make them available to e.g. TC progs, if the fix
in patch 2 is acceptable?

  [0]: https://github.com/kkdwivedi/linux/commits/fixes-bpf-next

Kumar Kartikeya Dwivedi (5):
  bpf: Fix kfunc register offset check for PTR_TO_BTF_ID
  bpf: Restrict PTR_TO_BTF_ID offset to PAGE_SIZE when calling helpers
  bpf: Use bpf_ptr_is_invalid for all helpers taking PTR_TO_BTF_ID
  selftests/bpf: Add selftest for PTR_TO_BTF_ID NULL + off case
  selftests/bpf: Adjust verifier selftest for updated message

 include/linux/bpf.h                           | 19 ++++
 include/linux/bpf_verifier.h                  |  3 +
 kernel/bpf/bpf_inode_storage.c                |  4 +-
 kernel/bpf/bpf_lsm.c                          |  4 +-
 kernel/bpf/bpf_task_storage.c                 |  4 +-
 kernel/bpf/btf.c                              | 24 ++++-
 kernel/bpf/stackmap.c                         |  3 +
 kernel/bpf/task_iter.c                        |  2 +-
 kernel/bpf/verifier.c                         | 99 +++++++++++++------
 kernel/trace/bpf_trace.c                      | 12 +++
 net/core/bpf_sk_storage.c                     |  9 +-
 net/core/filter.c                             | 52 ++++++----
 net/ipv4/bpf_tcp_ca.c                         |  4 +-
 .../selftests/bpf/prog_tests/d_path_crash.c   | 19 ++++
 .../selftests/bpf/progs/d_path_crash.c        | 26 +++++
 .../selftests/bpf/verifier/bounds_deduction.c |  2 +-
 tools/testing/selftests/bpf/verifier/ctx.c    |  8 +-
 17 files changed, 226 insertions(+), 68 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/d_path_crash.c
 create mode 100644 tools/testing/selftests/bpf/progs/d_path_crash.c

-- 
2.35.1

