Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC8166E012A
	for <lists+bpf@lfdr.de>; Wed, 12 Apr 2023 23:49:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbjDLVtN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 Apr 2023 17:49:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbjDLVtL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 Apr 2023 17:49:11 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E15CA527A
        for <bpf@vger.kernel.org>; Wed, 12 Apr 2023 14:49:06 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id sg7so43841887ejc.9
        for <bpf@vger.kernel.org>; Wed, 12 Apr 2023 14:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681336145;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I0iKN8/eQ0VcRaW9W6mhEf3g3P8klO6SdAKZiSsUESQ=;
        b=IIre1LH0IyDVcA5ZYavPVyw7tC1Voj10+dvl2B2SDxb/zNcj86XAt+Jq3xiSVoHwnv
         JlkUO+/YL9RHH5dzbgFohj+ZgNtMSStcPtZGAuMuk1lWth1kIHM6+i9yT7qFS1+0U9BI
         phInxpwr9eLDIIUIvs87W0EloBxXMSrDOSTKZDVomcW3LeKPcNFZVAWWx+E3nJDcapQw
         WrQKCELa+2modqUnZSHbQWWNKZ4KMe/nraVJ4SlX8xV/WDYmBpHqFO41B7OdbyPZCgMw
         G2lJzvfAL8i+CdukjLr4B8oTFR7aCyYcWN38NdrQXKCj6LGpozNj/7ryQL/fOgFCCb2Y
         2IVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681336145;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I0iKN8/eQ0VcRaW9W6mhEf3g3P8klO6SdAKZiSsUESQ=;
        b=gHj2iixzsxWsfHnKkOlebhW+TcTvtmBJqfRmvRiqsblP3+woMZpcoBTTwCnkt+210K
         VsXSZkLDFRWQHUoO7MO6fVydnC86egrmR0ciYoFTyhZ5XgzzcVG0am7+e+cGZVM2naaf
         u1lweufSTCWgGR+MWu1NeOZsXEFPCitkjfj5ySR+DMGmpNdjoLHJPtocqW33rt5l+8kh
         Emjo+mMC+gVnzyevKIuQ+pZlWMHh/WnSBjgSB2FskjldtYSuDMD+kYp4itfJlHP7DiUh
         CTX959IGVcs9SgjRYtEKPJaatnrdr1kFXQ8fsJVJOCCXesxonZEkJfXsfh1Ic4jSRaWS
         raPQ==
X-Gm-Message-State: AAQBX9ex4I0vlE7KVHAl3pd4VFjzKgREreOtBmeym4DH+nYMvuOYKbXB
        Fp0+XBksVS8phHG+l7kaCMHnCJ8K9eNVDxEP3aoB90v0
X-Google-Smtp-Source: AKy350YPD9sYgCS5+9hKEIXs2pjmCej4x/6zTNRKuUOQVwCu22yVkOk/MxkPsffqXXuXLyYtM9cMksBvCrzwQG8Lq+M=
X-Received: by 2002:a17:906:fd88:b0:94e:5f2a:23fe with SMTP id
 xa8-20020a170906fd8800b0094e5f2a23femr2056158ejb.5.1681336145276; Wed, 12 Apr
 2023 14:49:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230409033431.3992432-1-joannelkoong@gmail.com>
In-Reply-To: <20230409033431.3992432-1-joannelkoong@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 12 Apr 2023 14:48:53 -0700
Message-ID: <CAEf4BzY35Smeft0Z8mDAv+ynp1-cNnU9F6uWtk2NoCQua2LKiA@mail.gmail.com>
Subject: Re: [PATCH v1 bpf-next 0/5] Dynptr convenience helpers
To:     Joanne Koong <joannelkoong@gmail.com>
Cc:     bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org,
        daniel@iogearbox.net
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

On Sat, Apr 8, 2023 at 8:34=E2=80=AFPM Joanne Koong <joannelkoong@gmail.com=
> wrote:
>
> This patchset is the 3rd in the dynptr series. The 1st (dynptr
> fundamentals) can be found here [0] and the second (skb + xdp dynptrs)
> can be found here [1].
>
> This patchset adds the following convenience helpers for interacting
> with dynptrs:

"convenience helpers" doesn't do these APIs justice. They are
necessary APIs to make dynptrs a generic interface for working with
memory ranges. So it's dynptr cloning and adjustment helpers, but not
just a convenience APIs.

>
> int bpf_dynptr_trim(struct bpf_dynptr *ptr, __u32 len) __ksym;
> int bpf_dynptr_advance(struct bpf_dynptr *ptr, __u32 len) __ksym;
> int bpf_dynptr_is_null(const struct bpf_dynptr *ptr) __ksym;
> int bpf_dynptr_is_rdonly(const struct bpf_dynptr *ptr) __ksym;
> __u32 bpf_dynptr_get_size(const struct bpf_dynptr *ptr) __ksym;
> __u32 bpf_dynptr_get_offset(const struct bpf_dynptr *ptr) __ksym;
> int bpf_dynptr_clone(const struct bpf_dynptr *ptr, struct bpf_dynptr *clo=
ne__init) __ksym;
>
> [0] https://lore.kernel.org/bpf/20220523210712.3641569-1-joannelkoong@gma=
il.com/
> [1] https://lore.kernel.org/bpf/20230301154953.641654-1-joannelkoong@gmai=
l.com/
>
> Joanne Koong (5):
>   bpf: Add bpf_dynptr_trim and bpf_dynptr_advance
>   bpf: Add bpf_dynptr_is_null and bpf_dynptr_is_rdonly
>   bpf: Add bpf_dynptr_get_size and bpf_dynptr_get_offset
>   bpf: Add bpf_dynptr_clone
>   selftests/bpf: add tests for dynptr convenience helpers
>
>  include/linux/bpf.h                           |   2 +-
>  kernel/bpf/helpers.c                          | 108 +++++-
>  kernel/bpf/verifier.c                         | 125 ++++++-
>  kernel/trace/bpf_trace.c                      |   4 +-
>  tools/testing/selftests/bpf/bpf_kfuncs.h      |   8 +
>  .../testing/selftests/bpf/prog_tests/dynptr.c |   6 +
>  .../testing/selftests/bpf/progs/dynptr_fail.c | 313 +++++++++++++++++
>  .../selftests/bpf/progs/dynptr_success.c      | 320 ++++++++++++++++++
>  8 files changed, 864 insertions(+), 22 deletions(-)
>
> --
> 2.34.1
>
