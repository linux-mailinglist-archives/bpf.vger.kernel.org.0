Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74E686BF4DD
	for <lists+bpf@lfdr.de>; Fri, 17 Mar 2023 23:05:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbjCQWFc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Mar 2023 18:05:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbjCQWFb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Mar 2023 18:05:31 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33FFB31BDA
        for <bpf@vger.kernel.org>; Fri, 17 Mar 2023 15:05:30 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id o12so25627587edb.9
        for <bpf@vger.kernel.org>; Fri, 17 Mar 2023 15:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679090728;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZW+BDaqKrXSo8O25Z6OdFmBxN3S9BBwwureDRFEJqjw=;
        b=J4NLUB/QzGFEk/gM08Qjrkw2ca0CtpDUUq6YcSeV6H+msZ8z6E73Y2DKzYW901ZaU9
         4CpJCmfBOo7Zt76kqUt/+XfnFGrrmj8R6qO6N9QuVuYhrOtG82BakgvTcejOvnokqdlO
         Qfa95vZ3RxbFjhBBtokyW2ZGLRKsBX++kOP4Qr7eS1ny0FCrhy70MRn9UFhUv/JSLpM3
         oG3YK2VylMck/NwIwkiUQyck8nepO5XzxC1ZfCvhhyDdSX3fOWjueBmQCCuEkUtwVOvq
         l8fvJ0f6xx+mCoIFKyQ5mKrtY0duiOg7RbfU5dabMr9x+YG2wbmhMbCUP/85nRdhcird
         0q8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679090728;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZW+BDaqKrXSo8O25Z6OdFmBxN3S9BBwwureDRFEJqjw=;
        b=ADve8ZGdn77q/Gy1msY7TVlpBARUCr5jeBo6SA0YCu/hYjsYTzok2CITbb2qwGTmEg
         gEraFI4JqrMElhGxLF1hqg4uOuk+jnwhosJG4k5RwSiTbXGe/tE9LZU8DUhIK4gsqiek
         nKGd8KPjv8AtEOiOM5HEbNQsm/Bj9JZTiwbegJ9khdHX1yMkB8RE17HJnVrArDWrV9ZG
         Sm2lDZe4B25w0RxDdVCLlxA6f1efVDm/QKtYPX68AA+O/gnGyDF5X/D6Rc0VuhnxHnPS
         kDTYUHLmP4k9SGFLwV2072U+uAaS0apcFK6i7cQ8me0rmqSelXcD94akD3LMqZpZg4q2
         Btgw==
X-Gm-Message-State: AO0yUKVYrFXN2custLlw4w/1ZZrcRKi3IMdERjM7+6ZEGm9TEYdA/1ZP
        T49VdERDSCrFdCKG8H8VQ4o4R/9nnIAhl/f4I8JFTDmgcTE=
X-Google-Smtp-Source: AK7set/MRaUZXIe3yv+vCNeqyPKrooIOoYMRUWwQYDJy5A1NPx2qByrnx2LyXgPHvhtEXGRYA5FbviEQShJAXHgQ0yk=
X-Received: by 2002:a50:d687:0:b0:4fc:6494:81c3 with SMTP id
 r7-20020a50d687000000b004fc649481c3mr2462495edi.1.1679090728515; Fri, 17 Mar
 2023 15:05:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230317220351.2970665-1-andrii@kernel.org> <20230317220351.2970665-4-andrii@kernel.org>
In-Reply-To: <20230317220351.2970665-4-andrii@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 17 Mar 2023 15:05:16 -0700
Message-ID: <CAEf4BzYcF4uuxE1E36RViHqXs_RqyjY_Qg3mCmPb-u6HgR5RQg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/6] bpf: switch BPF verifier log to be a
 rotating log by default
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Mar 17, 2023 at 3:04=E2=80=AFPM Andrii Nakryiko <andrii@kernel.org>=
 wrote:
>
> Currently, if user-supplied log buffer to collect BPF verifier log turns
> out to be too small to contain full log, bpf() syscall return -ENOSPC,
> fails BPF program verification/load, but preserves first N-1 bytes of
> verifier log (where N is the size of user-supplied buffer).
>
> This is problematic in a bunch of common scenarios, especially when
> working with real-world BPF programs that tend to be pretty complex as
> far as verification goes and require big log buffers. Typically, it's
> when debugging tricky cases at log level 2 (verbose). Also, when BPF prog=
ram
> is successfully validated, log level 2 is the only way to actually see
> verifier state progression and all the important details.
>
> Even with log level 1, it's possible to get -ENOSPC even if the final
> verifier log fits in log buffer, if there is a code path that's deep
> enough to fill up entire log, even if normally it would be reset later
> on (there is a logic to chop off successfully validated portions of BPF
> verifier log).
>
> In short, it's not always possible to pre-size log buffer. Also, in
> practice, the end of the log most often is way more important than the
> beginning.
>
> This patch switches BPF verifier log behavior to effectively behave as
> rotating log. That is, if user-supplied log buffer turns out to be too
> short, instead of failing with -ENOSPC, verifier will keep overwriting
> previously written log, effectively treating user's log buffer as a ring
> buffer.
>
> Importantly, though, to preserve good user experience and not require
> every user-space application to adopt to this new behavior, before
> exiting to user-space verifier will rotate log (in place) to make it
> start at the very beginning of user buffer as a continuous
> zero-terminated string. The contents will be a chopped off N-1 last
> bytes of full verifier log, of course.
>
> Given beginning of log is sometimes important as well, we add
> BPF_LOG_FIXED (which equals 8) flag to force old behavior, which allows
> tools like veristat to request first part of verifier log, if necessary.
>
> On the implementation side, conceptually, it's all simple. We maintain
> 64-bit logical start and end positions. If we need to truncate the log,
> start position will be adjusted accordingly to lag end position by
> N bytes. We then use those logical positions to calculate their matching
> actual positions in user buffer and handle wrap around the end of the
> buffer properly. Finally, right before returning from bpf_check(), we
> rotate user log buffer contents in-place as necessary, to make log
> contents contiguous. See comments in relevant functions for details.
>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---

forgot to carry over Eduard's Tested-by:

Tested-by: Eduard Zingerman <eddyz87@gmail.com>

>  include/linux/bpf_verifier.h                  |  32 ++-
>  kernel/bpf/log.c                              | 187 +++++++++++++++++-
>  kernel/bpf/verifier.c                         |  17 +-
>  .../selftests/bpf/prog_tests/log_fixup.c      |   1 +
>  4 files changed, 213 insertions(+), 24 deletions(-)
>

[...]
