Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F099602326
	for <lists+bpf@lfdr.de>; Tue, 18 Oct 2022 06:07:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230512AbiJREHJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 18 Oct 2022 00:07:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230517AbiJREGn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 18 Oct 2022 00:06:43 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D40D395E61
        for <bpf@vger.kernel.org>; Mon, 17 Oct 2022 21:06:20 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id d26so29318534ejc.8
        for <bpf@vger.kernel.org>; Mon, 17 Oct 2022 21:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=k4ze2vS9ZCqjHO/X3nwWIktiEM6Nwb7Hs5mcP2rDocg=;
        b=b2K4UxUk/1DMVRdssgUBB2EGAXOCrYeUtvQvSVlCR25cn3N6P1pON+cHvXfCza41Aj
         qPpSNshmfPZmh55t6sYoOJ2qfC3qQlSf3yJ5eXiLp3GHsHAWV08U1sEwQ7mbAupREox3
         0MVSZIn4my5a3zQ7E43zC13GaqGwHmsGSB++ez3tIgtOw3tjyCtiPM7lvioJJDc02FqK
         jcWIe5AvMs5FG1ig70OojO8/Lnx5TYaXgYDFq4L3vsc+L6GErPhFIUIy+YCFqVLzQp2n
         oJ5glBH+gHsg3QjuoyptV/trrCjRpnzr4RrUw3KavIbdsLDzeak6HAOgl8MsW4ZVmmwY
         /QQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k4ze2vS9ZCqjHO/X3nwWIktiEM6Nwb7Hs5mcP2rDocg=;
        b=ZjJcdmDviAc1IjcuTycy8EAK99sWWbr6JIYpzr18K0Bhfu4bYSNO4hxQiieTO6nAgW
         NJ5/xWIaydD2Lpfyv/E9tBboL6gmXwvsVkQoZMNfteO6qlSTTjMA0XD2c5LspoykmZDr
         9ck+MXEMfoIqhF6F6zWqbe0IPrsPuFITv92X7v2kEnE0JT3fM9oYjtJEkBqT33MrYEq7
         USPd+WwISSSb8amt7NhbWQ0sVUmnyWfEkH+hX0hBZOgQ0jfAMKX6DHAq5sNjAn1ojxiE
         784rg7++r3ULoQCQzc5gY8AYrp7I+BBZwW77ar9KK/b+HNIEXLXEuyA4E4lGgltidqAi
         I7YQ==
X-Gm-Message-State: ACrzQf3eCBD2Yb9C0W339wDzpBkRGPMt2i79siwmpFWJvdgXb/w1rXPs
        7GJnEymjVxgc879IMId7fIWyYvoUe2w6GOROGss=
X-Google-Smtp-Source: AMsMyM5tyiZGSbO2JVrEjvl36ivQ6Dg2FIDJsMzSDCJJcOlDV6eF4NuTYHMc/32Sp7C+y8QtSjl0aAqPLbE1ei57uyM=
X-Received: by 2002:a17:907:6d9b:b0:78d:f24b:e358 with SMTP id
 sb27-20020a1709076d9b00b0078df24be358mr761516ejc.714.1666065978186; Mon, 17
 Oct 2022 21:06:18 -0700 (PDT)
MIME-Version: 1.0
References: <311eb0d0-777a-4240-9fa0-59134344f051@fb.com> <CAP01T76QJOYqk4Lsc=bUjM86my=kg3p6GHxuz3yXiwFMHJtjJA@mail.gmail.com>
 <CAADnVQJ6-kEE=_kHgyth_O3rUVHzJuNhS2MWhjQQed4wHzPpnA@mail.gmail.com>
 <CAP01T74-Bc8xLihXcoer8fOoSoQQ1dddJ1FGOVdRPRa92RRPyQ@mail.gmail.com>
 <CAADnVQLJP8YyYx5+mCBuSyenAfQDyXxDP8wfuDYCoZtO6kpunQ@mail.gmail.com>
 <CAEf4BzZL9GS0oAfkY1h4C9u1_XCzj-HTnKY9KHj+PX+h66TL3g@mail.gmail.com>
 <20220909192525.aymuhiprgjwfnlfe@macbook-pro-4.dhcp.thefacebook.com>
 <CAEf4BzaoaS8QiPDXuuN1pAiJQ9X6j1WfM+eZhpbRr6ZZ=afZNA@mail.gmail.com>
 <20220909205720.4c73xecxrjrl2vkd@macbook-pro-4.dhcp.thefacebook.com>
 <CAEf4BzazaCKMu5FUB_iZ2z+SVtaw-w8VZhA7EBd9oKKB_o299Q@mail.gmail.com>
 <20220911223132.vnhyyojwjzdzo4wr@MacBook-Pro-4.local> <CAEf4BzZSzqkGSZx6BUTGDWKesn_Ws042mG3F0XA=+KFwhKjKzg@mail.gmail.com>
In-Reply-To: <CAEf4BzZSzqkGSZx6BUTGDWKesn_Ws042mG3F0XA=+KFwhKjKzg@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 17 Oct 2022 21:06:06 -0700
Message-ID: <CAEf4BzZeyCd0WM40XhPJpZjm2HHG-LnvAp08vmQmb4Q4325hmw@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next v1 21/32] bpf: Allow locking bpf_spin_lock
 global variables
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Delyan Kratunov <delyank@fb.com>
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

On Tue, Sep 20, 2022 at 1:55 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Sun, Sep 11, 2022 at 3:31 PM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Fri, Sep 09, 2022 at 05:21:52PM -0700, Andrii Nakryiko wrote:
> > > > >
> > > > > Well, I didn't propose to use suffixes. Currently user can define
> > > > > SEC(".data.my_custom_use_case").
> > > >
> > > > ... and libbpf will mmap such maps and will expose them in skeleton.
> > > > My point that it's an existing bug.
> > >
> > > hm... it's not a bug, it's a desired feature. I wanted
> > >
> > > int my_var SEC(".data.mine");
> > >
> > > to be just like .data but in a separate map. So no bug here.
> >
>
> Not to bury the actual proposal at the end of this email, I'll put it
> here upfront, as I think it's a better compromise.
>
> Given the initial problem was that libbpf creates an mmap-able array
> for data sections, how about we make libbpf smarter.
>
> The rule is simple and unambiguous: if ELF data section doesn't
> contain any global variable, libbpf will not add MMAPABLE flag? I.e.,
> if it's special compiler sections which have no variables, or if it's
> user data section that only has static variables (which explicitly are
> not to be exposed in BPF skeleton), libbpf just creates non-mmapable
> array and we don't expose such sections as skeleton structs.
>
> User can still enforce MMAPABLE flag with explicit
> bpf_map__set_map_flags(), if necessary, so if libbpf's default
> behavior isn't sufficient and user intended mmapable array, they can
> still get this working.
>
> That would cover your use case and won't require any new naming
> conventions. WDYT?
>
>

To close the loop, I went ahead and implemented this proposal in code.
See [0]. I think it should be a good first step and should unblock all
the linked list and rbtree_node work. Please give it a try.

  [0] https://patchwork.kernel.org/project/netdevbpf/list/?series=686066&state=*


[...]
