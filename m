Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1BAF4ADFAF
	for <lists+bpf@lfdr.de>; Tue,  8 Feb 2022 18:32:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234891AbiBHRcd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Feb 2022 12:32:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242831AbiBHRcb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Feb 2022 12:32:31 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98DD0C061579
        for <bpf@vger.kernel.org>; Tue,  8 Feb 2022 09:32:30 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id z13so2443307pfa.3
        for <bpf@vger.kernel.org>; Tue, 08 Feb 2022 09:32:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=adKCeFoWSrodintnQZGQAyTD72OK2UJOqUUhG8Uf8qA=;
        b=H+rCDbBD3lAJ3FO65vFJnQphQcPJhvfRA1/xADNs/hMqZxK6V5ZqFLUzs4WqLuTZ7l
         quWiV1kXD3+96ivlmUqI3Y2mKjHagb3aCMe0O+I/rra5Mq76LBshc4bLYrhEw/N0jeCy
         VDFnVGf8OInmSL2UKv9jIoiuAjfw0aqCGQZqML6aoJy1b241hV1SMnNSYso+QqG/FuIz
         9h/ihA5MLHE9pRXs4G6MaespyJ/gDURytTSQnIhPpQlumW1bAgs9a7txpWa4qaqVdtJ9
         pCuGd5D5JwaF5AqkrDFY8HN6U5SDmKrzDvtC7hikV4H/YsMf8MVzMPHRJlmMmO0MVPUU
         t1XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=adKCeFoWSrodintnQZGQAyTD72OK2UJOqUUhG8Uf8qA=;
        b=pS2ynBdFIdYHghbOixGW80gdBn50ZOg2sYh2tibnDNVz47vG+sPQ2z0P73p6SdN05n
         +uckOcbNER/OU1kEYKcoEowz0OOQpxULx8N39740yZDF4u0lCHPKb8T05a8i6x1KirwK
         N/nGfLvIRhL3lbW5uJZFSYVbgopUbCKSZo4k3dgxWZwnWdFFDje5go1nFwYEzqx29Ti0
         0Non5gNwYzU0G+9iZsGgcdkEBvDsbnQ0eTSGT8Ze1ejY7fqzeouBIDPrtF0SyW4r9978
         oybPo8oGbDCUeuKo7l0U8lW2MaPgVzXnEARERVx86UJfzzglGIPNy0QuH0LkRYSgI5Du
         76rA==
X-Gm-Message-State: AOAM530ObbkacHESv2PknNvPoBXQfSkANWDUBHP61T527S0UWs6GkMYF
        az5pWwDIqPldjozMWY34WSRSpsnE2gfaeiBxZUrReJOQ
X-Google-Smtp-Source: ABdhPJxLJt3Pz0L8m4jdtyjQqitfYfDjlXpO5NhNs5Ug/xeKQTLkHC42rYatQ5yYDAkFqz1uHFoBBvlWa1ARqkf1DGg=
X-Received: by 2002:a65:6e04:: with SMTP id bd4mr4268587pgb.375.1644341549996;
 Tue, 08 Feb 2022 09:32:29 -0800 (PST)
MIME-Version: 1.0
References: <20220204181146.8429-1-9erthalion6@gmail.com> <CAEf4BzYiT-HRn9bLy=qoyOhOQ1ESCB3mB97xt98JWapgB_nbBw@mail.gmail.com>
 <c81ddb7b-1eff-b5e8-a80b-ef0e8c3bc513@fb.com>
In-Reply-To: <c81ddb7b-1eff-b5e8-a80b-ef0e8c3bc513@fb.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 8 Feb 2022 09:32:18 -0800
Message-ID: <CAADnVQ+DuTs+tMKcy-ZjwAhPDHDRqrjuO2nASgw7KS8QXewLLQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2] bpftool: Add bpf_cookie to link output
To:     Yonghong Song <yhs@fb.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Dmitrii Dolgov <9erthalion6@gmail.com>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Quentin Monnet <quentin@isovalent.com>
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

On Mon, Feb 7, 2022 at 9:46 PM Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 2/7/22 2:11 PM, Andrii Nakryiko wrote:
> > On Fri, Feb 4, 2022 at 10:12 AM Dmitrii Dolgov <9erthalion6@gmail.com> wrote:
> >>
> >> Commit 82e6b1eee6a8 ("bpf: Allow to specify user-provided bpf_cookie for
> >> BPF perf links") introduced the concept of user specified bpf_cookie,
> >> which could be accessed by BPF programs using bpf_get_attach_cookie().
> >> For troubleshooting purposes it is convenient to expose bpf_cookie via
> >> bpftool as well, so there is no need to meddle with the target BPF
> >> program itself.
> >>
> >>      $ bpftool link
> >>      1: type 7  prog 5  bpf_cookie 123
> >>          pids bootstrap(87)
> >>
> >> Signed-off-by: Dmitrii Dolgov <9erthalion6@gmail.com>
> >> ---
> >> Changes in v2:
> >>      - Display bpf_cookie in bpftool link command instead perf
> >>
> >>      Previous discussion: https://lore.kernel.org/bpf/20220127082649.12134-1-9erthalion6@gmail.com
> >
> >
> > So I think this change is pretty straightforward and I don't mind it,
> > but I'm not clear how this approach will scale to multi-attach kprobe
> > and fentry programs. For those, users will be specifying many bpf
> > cookies, one per each target attach function. At that point we'll have
> > a bunch of cookies sorted by the attach function IP (not necessarily
> > in the original order). I don't think it will be all that useful and
> > interesting to the end user. We won't be storing original function
> > names (too much memory for storing something that most probably won't
> > be ever queried), so restoring original order and original function
> > names will be hard. If we don't think this through, we'll end up with
> > kernel API that works for just one simple use case.
>
> The cookie for multi-attachment is indeed a problem. Some of original
> cookies may not be available any more.
>
> >
> > Can you please describe your use case which motivated this feature in
> > the first place to better understand the importance of this?
> >
> > BTW, bpftool can technically implement this today without kernel
> > changes by fetching such bpf_cookies from the kernel using its pid
> > iterator BPF program. See skeleton/pid_iter.bpf.c for pointers. I
> > wonder if it would make more sense to start with doing this purely on
> > the bpftool side first.
> >
> > As an aside (and probably something more generally useful), it seems
> > like we have a bpf_iter__bpf_map iterator, but we don't have prog and
> > link iterators implemented. Would it be a good idea to add that to the
> > kernel? Yonghong, Alexei, any thoughts?
>
> We already have program iterator. We have discussed link iterators
> for sometime. As more and more usages for links, a link iterator
> should be good to improve performance compared to generic 'task/file'
> iterator.

Agree. We have iters for progs and maps. The iter for links is missing.
