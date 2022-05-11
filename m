Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4476E522B11
	for <lists+bpf@lfdr.de>; Wed, 11 May 2022 06:37:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231860AbiEKEhu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 11 May 2022 00:37:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230389AbiEKEht (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 11 May 2022 00:37:49 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FC3EBA9BD
        for <bpf@vger.kernel.org>; Tue, 10 May 2022 21:37:47 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id kl21so1301879qvb.9
        for <bpf@vger.kernel.org>; Tue, 10 May 2022 21:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qxi31b7PnvWpL84i/T42YI6oiwEo735TNpwiJE9uQvU=;
        b=Xe1ZnRRBKlUJk4lstXAzrhV3mpDcEaCTXhUK0NEy3oF1TqrMdl2rs3ijGu2tJAYVBO
         BhJXfsMys90kybkkQ3tJNP664xg89+3x+GgzWAie8vLWAA0AUMbuw05ETWDbMXuY2hem
         HoxVFrmsDEaapQowGS4TVy/wg415hA1TwennkIOosF/4VZ4ZQuKTSuwre7M+NWt2WYQI
         R0sn6QU5BV2cFGHwf0mWJqNTyT26lJpthnK+Qr9P0Oi+L6VLuNgcKidKTH6jkFFcwSl1
         m7NHEO/t7R7WsoEPlD1bb0tq0vFD1hrWzvxJAzEqVB/COdIyc5Fg6OKUjQWd5z+dv7xw
         Yh0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qxi31b7PnvWpL84i/T42YI6oiwEo735TNpwiJE9uQvU=;
        b=Nq4nz34LQ/ebW2QsiIw9lxtrvVNTfUy2VefDIEA1eS2JNXyXU9cs/danVR2glp2lov
         6PmckJILaDdZfkNHW2A2OGVx/Sy2yrMDrRZlwPKa1TkTmqYd/QeteLOt9XS9DGJJkSE4
         8VfdAAX0jWhUbkv4elMcyyqpGGylsvL+cvWZwiT29tdXVgFbLR2QKbO00tX9aBdQ2zTn
         P3uNJufiXwwd/3JJale9HIVKnw/wZISgvcrkJVpuCicbFmgcaynihZGgxSQJEhwjX9q6
         x4Sj8Svyl8blR2g/lQzQIvf60rMadV7RXFJEb3Q/ejebAlCH0X6cGifWeBBtcFFpBEZD
         plLQ==
X-Gm-Message-State: AOAM5334lQGRdG8NSiKDxIJqvs9xHgzGv/CWYiY08+25xk0d+VV6TJHb
        w4HY671rKvf0FDM0DH/v6V+Yz2TYI063Ls420Tg=
X-Google-Smtp-Source: ABdhPJwRw4s2KH1BUP3Gb9vqzGUX8iGzCvOUHw7A18G/lvw+RGIX8X49U2GbhQtdgjZsAf0Z1yKz77n0Z6sgHxu0io0=
X-Received: by 2002:ad4:5bea:0:b0:45b:1f7:eee7 with SMTP id
 k10-20020ad45bea000000b0045b01f7eee7mr14383104qvc.11.1652243866656; Tue, 10
 May 2022 21:37:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220510211727.575686-1-memxor@gmail.com> <20220510211727.575686-3-memxor@gmail.com>
In-Reply-To: <20220510211727.575686-3-memxor@gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 10 May 2022 21:37:35 -0700
Message-ID: <CAADnVQ+WFGc4yEAGVuxzbWkXsj2G+U2nN4YmEzMh7SHbHdknjA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 2/4] bpf: Prepare prog_test_struct kfuncs for
 runtime tests
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
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

On Tue, May 10, 2022 at 2:17 PM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> In an effort to actually test the refcounting logic at runtime, add a
> refcount_t member to prog_test_ref_kfunc and use it in selftests to
> verify and test the whole logic more exhaustively.
>
> To ensure reading the count to verify it remains stable, make
> prog_test_ref_kfunc a per-CPU variable, so that inside a BPF program the
> count can be read reliably based on number of acquisitions made. Then,
> pairing them with releases and reading from the global per-CPU variable
> will allow verifying whether release operations put the refcount.

The patches look good, but the per-cpu part is a puzzle.
The test is not parallel. Everything looks sequential
and there are no races.
It seems to me if it was
static struct prog_test_ref_kfunc prog_test_struct = {..};
and none of [bpf_]this_cpu_ptr()
the test would work the same way.
What am I missing?
