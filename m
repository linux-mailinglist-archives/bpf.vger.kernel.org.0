Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEB7B66373B
	for <lists+bpf@lfdr.de>; Tue, 10 Jan 2023 03:22:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237206AbjAJCWE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 9 Jan 2023 21:22:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237219AbjAJCV7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 9 Jan 2023 21:21:59 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03186140B8;
        Mon,  9 Jan 2023 18:21:58 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id vm8so25012822ejc.2;
        Mon, 09 Jan 2023 18:21:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4HXjD1QcFQuEl9ZhtGe9n4ik0nnZg6brN6d15dV7QxU=;
        b=P9GLOi7aXdK7UsTmY95FXFvkxPqhVbxxnXGLXEmdKqqYQUBzLxzJMfm9MyUQz/uawu
         v2ivoVHckFAWHDH7rAs6HWPnb8EWppzdsBhreEi1zyzeh0GLAGxW8C697C7PJWlXZWmy
         4KAQwjxTUgSBuGSlQ/Vg8wYRqwlR0sUhocDZwKDtDc727llGqv+AD418yyFl6ecR9XM9
         XjePvRffjS5dlA/AbU158N34+1nafP3SWHEVaBVW2LCQ9ohHU526r1caK4GZGXMBDv5t
         3xyX9DlpphZEZgzu3mXUNdwckV/ClaKeothwPJOC7h8OVAxzk4pYWmGNC07QIe9ebyza
         /AuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4HXjD1QcFQuEl9ZhtGe9n4ik0nnZg6brN6d15dV7QxU=;
        b=PFoB73qupBnacaw4bswNG6sp/YRJqrrss+WJV2ndiy5qOlD3kOgm7e1ayJvTVmpWfE
         YqUen1ST7SP/FePLXvm3eL7WqBZrsA80129MzGwrDPKV832a0BMTQSb19XshPX0tNeoY
         WvS4TPqqdmaaQNDGWWtBhSzCWFDAVDu+bC8c1HsGZbpZhMNr3o87zoWICwtuW5W8BhRc
         aYgP5Um+cNjKM8ZZ5CJ9GYbXSNDzkj/jAGZku7Jpe9se7k0c+b5e0uqRCusTk72G7x15
         6Y6X/OZdIZmqwSyUoMANGbb+kE+tOfI7cpeT/+Q/BRLRVQFqY4cF+xy2BHA1fiTuWKnL
         8EoA==
X-Gm-Message-State: AFqh2kqdDYhC708xCVQvNJr+kgqgdsdoHj9qk117V71AD8WEEPy5BsfN
        L0zZe2nQRlb8V6VwxQHENvWqsaD8eBq54fFNMiU=
X-Google-Smtp-Source: AMrXdXuXBw6TE7jot5iXV9W9Zgo2zNHZ7R0t6mSLAfc9rW1Am24cb4NE1Qmc10Kezq1jA3f6OcKYqz6GqiQGY21p25M=
X-Received: by 2002:a17:906:dcf:b0:7c1:6781:9c97 with SMTP id
 p15-20020a1709060dcf00b007c167819c97mr4771664eji.676.1673317316427; Mon, 09
 Jan 2023 18:21:56 -0800 (PST)
MIME-Version: 1.0
References: <20230106195130.1216841-1-void@manifault.com> <20230106195130.1216841-2-void@manifault.com>
 <CAADnVQLpK7WXTjF6GS1hcfPXf=8iERJmEeVFfvmG75mJj0DdaA@mail.gmail.com>
 <Y7jUaDD9V556Px3b@maniforge.lan> <CAADnVQJJaTXa8Y-aGctrBTjasKzsMDq4nW7Na5X3i8oobpT9NQ@mail.gmail.com>
 <20230109120815.zx5mif4hnee6gyvc@apollo> <Y7xJZv6Ncw1JSoJy@maniforge.lan>
In-Reply-To: <Y7xJZv6Ncw1JSoJy@maniforge.lan>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Mon, 9 Jan 2023 18:21:45 -0800
Message-ID: <CAADnVQ+FLARg_qFyJtqe7sMouc2rgZAh8Md4OC+MguU61uJzjA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/3] bpf: Add __bpf_kfunc tag for marking kernel
 functions as kfuncs
To:     David Vernet <void@manifault.com>
Cc:     Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@meta.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@meta.com>
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

On Mon, Jan 9, 2023 at 9:05 AM David Vernet <void@manifault.com> wrote:
> > > Maybe 3 macroses then?
> > > bpf_kfunc_start to hide __diag
> > > bpf_kfunc on the proto line
> > > bpf_kfunc_end to finish __diag_pop
>
> Ah, I see. Hmm, I guess this is better than what we have now, but is
> still a lot of macros and boilerplate which IMO is a sign we're not
> going in quite the right direction. I don't really have a better
> suggestion at this point, though I do like Kumar's suggestion below.
>
> > There's also the option of doing this:
> >
> > #define BPF_KFUNC(proto) proto; __used noinline proto
> >
> > BPF_KFUNC(void kfunc(arg1, arg2)) {
> >       ...
> > }

Fine by me.
Just put { on the new line.
