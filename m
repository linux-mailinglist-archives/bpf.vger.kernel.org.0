Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAFB754FCF7
	for <lists+bpf@lfdr.de>; Fri, 17 Jun 2022 20:35:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233818AbiFQS2p (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Jun 2022 14:28:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234115AbiFQS2j (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Jun 2022 14:28:39 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF4E72F67E
        for <bpf@vger.kernel.org>; Fri, 17 Jun 2022 11:28:38 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id u18so4555348plb.3
        for <bpf@vger.kernel.org>; Fri, 17 Jun 2022 11:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K2qoc4Odtlo0pzxuXYwcpJs8feqCJf+qnztanca7zvw=;
        b=PPZr/kbAtXXn2L8x8ajCEN3F/3G4O+G8RdupWkNBoyCXp9a86GLMusT0G20g6mkYCD
         1f02nzbngJd/8bKibQBoBskxzbrjxUah+kHZ3w7k/HwAJBqUwba+Nkz5y4kCzrxcC3my
         k5dOOE3iJJVR4hnqZbU6rx6BaBSqGkqkjuMYjGr6oF3awceQnLY8MrlWzw+B2+3LeyQO
         hXdqeL2646ZH6P1rydiSHHwGchwlX+y8Iq4/3tbo5uVofYSnOWLf8vg3yRvQ6aw/FElJ
         caymR/RSEu6ugFVjmbKqgRT/cdPIVwxhy07TvvXcDIC/NA6oY7dyZrBbYFVqMCS3+vC2
         h4/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K2qoc4Odtlo0pzxuXYwcpJs8feqCJf+qnztanca7zvw=;
        b=C9vQXqlMdBolw/4xkQ9WvZVzC3QZILUlb6DNrNmvHfjfwRsVmOw/+4ZnPTPgpvGez4
         yTqsR6jyhgErkA1QJh+tf8y3QCgk191Uwlu/cMNUZ/9cXMtHkkl+xnys1+UlOJQWKviQ
         otYNKCOwl2EN32WfmBMDQYfx4GhTpGeS0QPfr/6LASHI+gpNhT/lynnzX7wpfN3VAhOp
         eCuLOgXANZ4+8uCkT7t4b9SB8Iu1WDJg1m/uo5/KtsHLKrDDm8TfbwVXiAT3iNsT7Idp
         RZ4iO/lOp7fRB6XtS6DQQvQfc7BfkxUFkiJWFitZfIVeQqRVqTSNJs/ik54iMiy/FRR2
         RfsQ==
X-Gm-Message-State: AJIora+lbYtiylUWvcLayv3SEf/CpTG2oVz76c6PwLhEG6V9VSzq985k
        tQkVjjpLDrxl1YEvEvS0Or8dYRLpLqdtF/U/iQ59YA==
X-Google-Smtp-Source: AGRyM1sFMrp4Qa5f3NH0HrfpBaFF/6Ojcj2xySv8m44nLGW2E3FzIqeFQxD4vKihWYjKQ79hig/iu1Z7/pVA5gc+fIo=
X-Received: by 2002:a17:903:1105:b0:168:fa61:147f with SMTP id
 n5-20020a170903110500b00168fa61147fmr10555216plh.72.1655490518125; Fri, 17
 Jun 2022 11:28:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220610165803.2860154-1-sdf@google.com> <20220610165803.2860154-10-sdf@google.com>
 <20220617055806.q2a74mmllxbrhknc@kafai-mbp>
In-Reply-To: <20220617055806.q2a74mmllxbrhknc@kafai-mbp>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Fri, 17 Jun 2022 11:28:27 -0700
Message-ID: <CAKH8qBuOTCews4c9Z7WLBM18EBa5Dgv9AgbvY4F-gzG6b6WXdA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v9 09/10] bpftool: implement cgroup tree for BPF_LSM_CGROUP
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jun 16, 2022 at 10:58 PM Martin KaFai Lau <kafai@fb.com> wrote:
>
> On Fri, Jun 10, 2022 at 09:58:02AM -0700, Stanislav Fomichev wrote:
> > @@ -84,6 +87,19 @@ static int show_bpf_prog(int id, enum bpf_attach_type attach_type,
> >       }
> >
> >       attach_type_str = libbpf_bpf_attach_type_str(attach_type);
> > +
> > +     if (btf_vmlinux &&
> > +         info.attach_btf_id < btf__type_cnt(btf_vmlinux)) {
> > +             /* Note, we ignore info.attach_btf_obj_id for now. There
> > +              * is no good way to resolve btf_id to vmlinux
> > +              * or module btf.
> > +              */
> On usage could be using it to get the btf_info by bpf_obj_get_info_by_fd.
> Check for the kernel_btf == true and name is "vmlinux".
> To be future proof, it can print <unknown> func for anything
> other than "vmlinux" btf.

Thanks for the suggestion! I'll try to do it and cache btf_vmlinux_id
if it's "vmlinux". What we really need is a way to obtain vmlinux
btf_id and compare it against info.attach_btf_obj_id.
