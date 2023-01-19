Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8B5C674668
	for <lists+bpf@lfdr.de>; Thu, 19 Jan 2023 23:54:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbjASWy0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 19 Jan 2023 17:54:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbjASWxx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 19 Jan 2023 17:53:53 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA332868E
        for <bpf@vger.kernel.org>; Thu, 19 Jan 2023 14:36:31 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id ss4so9516248ejb.11
        for <bpf@vger.kernel.org>; Thu, 19 Jan 2023 14:36:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nx6nkNmP3KgwoG5DjvP3D5jTDKwyscC4E4d85hMO5Yk=;
        b=a5mhoAtA4GzVuCcMRxk0GlRmScq27FzqBIi7Rvlti8duEt3o++0HgVEKCRSwWjdjqw
         MVvAlT0h6rrsm7cYSCfHqQlU+5F8G1x2F2Sno31ijdbU25KQDIUZtk8OSjvBLGiONKZN
         RR8Dy0E7rApffhjNdqqOhra/MbXWjPLZZRI8BKu2Hm8oHFz+BLc2GpF6Rae8y5mZL/1a
         3Ab97jXTGxaSRWyW4UuWpT8HRhaCSiKhoCGuaiVXAyAYBx/gGLaeFer5oQqC7/Hbs5sD
         MZ4Q++Z/K9k/kZFlOIrISUkCeeCrKbBN3AdRpTG9MQqdH+Hw9YrbExSIOpQ01/Y7laZW
         +LeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nx6nkNmP3KgwoG5DjvP3D5jTDKwyscC4E4d85hMO5Yk=;
        b=f2zmo4Uv7QevK415rU3nUgpt1cIj/ZnWBrJhCFu3pAxKMDMGt+FPvO5Pu7wS9+vyag
         o1qKonZtM8/pBBak+pFTrsLyVcNIW+1Fw2AQAR8eHov9wvsNbzf1mz3L9u4I8WLJd3VA
         MWjew7WTx7mNRjH3SXEPcyydwDgQ/6gB184WaRZwUG8VS4ab/ZT5TDXCrltx5J06/+pd
         1N+P6E7yBfvhRAylQPR02JwN9d2DVRhO5CdNAf9J2aSFqPN+zVLuKn9V45KQAHL4SXG+
         4ILIZCn9iKso9/anqOnSNxAnTBqb0pRR00+a7vpxjkQoiZywkcqzf2ayXZO2znMO74mT
         Dqrg==
X-Gm-Message-State: AFqh2krROkzspAftCgrpHQ13xbHq4tjdlLmsYxlUdOYvXh+nl+3U9DP8
        d8TzRhnqzrMOT0ApOcxqoFyb4ogz5A1HLRqy3ro=
X-Google-Smtp-Source: AMrXdXv5V489ku9PUtSpLyjZjjMjQPkXultE24e+CptgfJ63rXiUZ2Ktch6WraJE0qXdqT2bxTiKZtjeWY0Ox4vK3o0=
X-Received: by 2002:a17:906:4a8f:b0:86c:e07a:3ce2 with SMTP id
 x15-20020a1709064a8f00b0086ce07a3ce2mr885847eju.58.1674167789970; Thu, 19 Jan
 2023 14:36:29 -0800 (PST)
MIME-Version: 1.0
References: <20230119141331.962281-1-jolsa@kernel.org> <CAP01T74jnDPaam-wDrk3+PiiV8fbqA0MzFuTom=yaRgR+Aq-Fw@mail.gmail.com>
In-Reply-To: <CAP01T74jnDPaam-wDrk3+PiiV8fbqA0MzFuTom=yaRgR+Aq-Fw@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 19 Jan 2023 14:36:18 -0800
Message-ID: <CAADnVQKS0X6sP2N6zQEyu+5ez0M8QqFeDND5ZefRrSWOt8VM3g@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: Add missing btf_put to register_btf_id_dtor_kfuncs
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jan 19, 2023 at 9:02 AM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> On Thu, 19 Jan 2023 at 19:43, Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > We take the BTF reference before we register dtors and we need
> > to put it back when it's done.
> >
> > We probably won't se a problem with kernel BTF, but module BTF
> > would stay loaded (because of the extra ref) even when its module
> > is removed.
> >
> > Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > Fixes: 5ce937d613a4 ("bpf: Populate pairs of btf_id and destructor kfunc in btf")
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
>
> Thanks for the fix.
> Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

Jiri,

lore and patchwork didn't receive this patch.
Only Kumar's reply is in lore.
Please resend.
