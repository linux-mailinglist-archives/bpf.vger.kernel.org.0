Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8A664C2135
	for <lists+bpf@lfdr.de>; Thu, 24 Feb 2022 02:43:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbiBXBmX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 23 Feb 2022 20:42:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbiBXBmW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 23 Feb 2022 20:42:22 -0500
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FF0D369EB
        for <bpf@vger.kernel.org>; Wed, 23 Feb 2022 17:41:53 -0800 (PST)
Received: by mail-il1-x129.google.com with SMTP id 9so592010ily.11
        for <bpf@vger.kernel.org>; Wed, 23 Feb 2022 17:41:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7uCJSsDQCRQ6U7yZAFsNaZ5VC0HlZq9YRypzah8QdjY=;
        b=qQBCEwz3pKQmlHZ1k7xKw+iZiRu4Iuprwa7+9jsWR9OEsf+Te0GDk/TeXHF0hqPCCl
         g2GArs29ajCDrsZMFh/oPJc3MA5+cUOvXpp7Ss1v1R3z2U3LZKjbVb7BA72j83mJhapl
         DSWanq9s0B2lBFA+4b/4gsPD99V1YMgU7eY4io6UvHLu3NmrjhYF+yDNEz4pPNRt1ClM
         nhuQO+9ujCh+XRXiTe9yaq/j9N+xl9comKAblXBPGGeGugsk1A9rdtX/tNUr2gkrapJs
         +sDp5xGq6fDT/NfKYzjVZnouqc4l/k/zfTgraQPNq6UyZE59N0MutYXz1bNDoBjdkb92
         IPBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7uCJSsDQCRQ6U7yZAFsNaZ5VC0HlZq9YRypzah8QdjY=;
        b=8LqyV3nGXbMDP3rpnaqV5XbO8okDoAqUo/l5/RmOe46P9rTRCp8LE4sNRo+vJd9qjx
         uV/4aqpgFfPYyRplDJ44sJjWReJ/Sy6nNZR3UiDie0ADFBKAao+bPjuPgs5kMBbVFrea
         ctsh+p87ipego4DoYv5uoj9d9WSCwB/pZVJIqTIl4zOG7ilFFBYQqlsxIOvI0X4TK39P
         pImZ4Of7ekW5s4XGmS/6pZx9K0ZxBVKtVDDVozqtkaV5MZPj2s9rcTRv+aq8l4fzXEmG
         w2TqIYqmIO5PDcjK/6Tl1BF+QXKvU8hyUsKQ1fLwRP1+gmZrlRv7KSFt+cIQaxWXopXx
         mehQ==
X-Gm-Message-State: AOAM533zBkmMUDLrD8l0TDXSl9hqBKptjEaXNGCrMfoS9j47kl2CtByR
        TmGAEZvR7mlqI2uZMuMLdq0qfEo0rjjfLUCpv3mihrVbUbGpVg==
X-Google-Smtp-Source: ABdhPJzEIgh/WyFNhs/28IHnX0wjE3IihYBDPhQFxG1pvHJWnHo0PYfO4Gc39TiyGHZs4qMSnf4M6lyWQlUXpiVP5mw=
X-Received: by 2002:a92:d208:0:b0:2c1:1a3c:7b01 with SMTP id
 y8-20020a92d208000000b002c11a3c7b01mr247449ily.71.1645664972248; Wed, 23 Feb
 2022 17:09:32 -0800 (PST)
MIME-Version: 1.0
References: <20220224003729.2949667-1-mykolal@fb.com>
In-Reply-To: <20220224003729.2949667-1-mykolal@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 23 Feb 2022 17:09:21 -0800
Message-ID: <CAEf4BzaxyzTBJOp0uDmwG5LuTL-RJ08-DCuzLEa3Xw9bF5hk-w@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next] Small BPF verifier log improvements
To:     Mykola Lysenko <mykolal@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Feb 23, 2022 at 4:40 PM Mykola Lysenko <mykolal@fb.com> wrote:
>
> In particular:
> 1) remove output of inv for scalars in print_verifier_state
> 2) replace inv with scalar in verifier error messages
> 3) remove _value suffixes for umin/umax/s32_min/etc (except map_value)
> 4) remove output of id=0
> 5) remove output of ref_obj_id=0
>
> Signed-off-by: Mykola Lysenko <mykolal@fb.com>
> ---

You could have preserved my ack, but LGTM again (assuming CI run is green):

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  kernel/bpf/verifier.c                         |  63 ++---
>  .../testing/selftests/bpf/prog_tests/align.c  | 218 +++++++++---------
>  .../selftests/bpf/prog_tests/log_buf.c        |   4 +-
>  .../selftests/bpf/verifier/atomic_invalid.c   |   6 +-
>  tools/testing/selftests/bpf/verifier/bounds.c |   4 +-
>  tools/testing/selftests/bpf/verifier/calls.c  |   6 +-
>  tools/testing/selftests/bpf/verifier/ctx.c    |   4 +-
>  .../bpf/verifier/direct_packet_access.c       |   2 +-
>  .../bpf/verifier/helper_access_var_len.c      |   6 +-
>  tools/testing/selftests/bpf/verifier/jmp32.c  |  16 +-
>  .../testing/selftests/bpf/verifier/precise.c  |   4 +-
>  .../selftests/bpf/verifier/raw_stack.c        |   4 +-
>  .../selftests/bpf/verifier/ref_tracking.c     |   6 +-
>  .../selftests/bpf/verifier/search_pruning.c   |   2 +-
>  tools/testing/selftests/bpf/verifier/sock.c   |   2 +-
>  .../selftests/bpf/verifier/spill_fill.c       |  38 +--
>  tools/testing/selftests/bpf/verifier/unpriv.c |   4 +-
>  .../bpf/verifier/value_illegal_alu.c          |   4 +-
>  .../selftests/bpf/verifier/value_ptr_arith.c  |   4 +-
>  .../testing/selftests/bpf/verifier/var_off.c  |   2 +-
>  20 files changed, 202 insertions(+), 197 deletions(-)
>

[...]
