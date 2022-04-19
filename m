Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4EF8507A35
	for <lists+bpf@lfdr.de>; Tue, 19 Apr 2022 21:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241944AbiDST3H (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 19 Apr 2022 15:29:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234737AbiDST3H (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 19 Apr 2022 15:29:07 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9133220BFA
        for <bpf@vger.kernel.org>; Tue, 19 Apr 2022 12:26:23 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id t25so31159392lfg.7
        for <bpf@vger.kernel.org>; Tue, 19 Apr 2022 12:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cQ2XodLDn72F9VLOveLun46ikGLt3CPocwdsyYU7erQ=;
        b=qZCVJ4aK0FM5nlekvWAcMOeJdQt1b4leNFxyKWB4okhVMUU7ZTPeeRo4xgK0KsioNf
         HENQhAtNz9+fJZiJ7qtGx0QLvpAnOY2HJGUfPnd0wdWfLbL0BvoYw9hmDfFMJHNvSdGg
         VtVJZMHfmRs4wVVqZkjWhj2JlxVVAwIfZMLGu9ctkzJ0tVrGHexeMpvRSr0V7b8t8D8R
         8R0I12Xz9MMpxa35Rkd310h2IVKTVGtZbv6XNrNHJCsnHrsqaSOEuQv3fikldbm5mw8L
         0gJz0sJSorjeZpYn2hkyquGUaHPmt1EiQF7YwvYijOvCYbKq3ciotUy6mzhvpVaYBug3
         bUWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cQ2XodLDn72F9VLOveLun46ikGLt3CPocwdsyYU7erQ=;
        b=srIqFqFehrq41QK0B/o7SUY3dX5PVqbotNmUg0FMcruCEy0V7XfXDkgzPyRYbHKOLY
         eTqrXg3ZQ6egMyGFqjHOdAlJKZByD0PtzeAXIQh+SRZuFsYrMEgCDvA/gzSJlKgQcgAE
         4nrrT+HIowcXxUcrHPQVTNPfsCQ7mQhl+2HZtl9/KaBuRTQlTBH0eteje2y0on/EE8OO
         lr3eebjCKVSM2HrIS/Y3kOhX+PNaHeHmjxxnOscFLZauLykJx3pwZ5djxo/CfxqUD8AH
         ZnzWA9TOc6TXMSp65AaTdhYztu5nvS3c2waZ3cw9HMEFo7VqP+ffw30FkvxJpjpYgQcH
         QC7g==
X-Gm-Message-State: AOAM530AXeD4dewZVRGsAPyisFVTLHPvYVvYyrQZj3enoy5p+WyY3FM9
        3VuYUF0E5z0VtE8FBlfVTAmo2D2ncFfsMsIdaQs1gNdy
X-Google-Smtp-Source: ABdhPJz8Qv1DexVsWFlqsIBZjHEFcSN+8dtzMcofDSGK0TbT8efb7VriPg3AB8BkcuNF17SVZRvqMqMXiPXlaNRRjbk=
X-Received: by 2002:a05:6512:10c5:b0:471:924f:1eed with SMTP id
 k5-20020a05651210c500b00471924f1eedmr7760202lfg.641.1650396381900; Tue, 19
 Apr 2022 12:26:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220416063429.3314021-1-joannelkoong@gmail.com>
 <20220416063429.3314021-2-joannelkoong@gmail.com> <20220419045928.nlr6dvrlmrjdf6qq@MBP-98dd607d3435.dhcp.thefacebook.com>
In-Reply-To: <20220419045928.nlr6dvrlmrjdf6qq@MBP-98dd607d3435.dhcp.thefacebook.com>
From:   Joanne Koong <joannelkoong@gmail.com>
Date:   Tue, 19 Apr 2022 12:26:11 -0700
Message-ID: <CAJnrk1aQ_2a9Qr3t-G7re8E3gvfhp3RTV00CX8Uw9=4cj63VcQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/7] bpf: Add MEM_UNINIT as a bpf_type_flag
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
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

On Mon, Apr 18, 2022 at 9:59 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Apr 15, 2022 at 11:34:23PM -0700, Joanne Koong wrote:
> > -     ARG_PTR_TO_UNINIT_MEM,  /* pointer to memory does not need to be initialized,
> > +     /* pointer to memory does not need to be initialized, helper function must fill
> > +      * all bytes or clear them in error case.
> > +      */
> > +     ARG_PTR_TO_MEM_UNINIT           = MEM_UNINIT | ARG_PTR_TO_MEM,
>
> Could you keep the name as ARG_PTR_TO_UNINIT_MEM ?
> This will avoid churn in all the lines below.
>
> > -     .arg2_type      = ARG_PTR_TO_UNINIT_MEM,
> > +     .arg2_type      = ARG_PTR_TO_MEM_UNINIT,
> ...
> > -     .arg2_type      = ARG_PTR_TO_UNINIT_MEM,
> > +     .arg2_type      = ARG_PTR_TO_MEM_UNINIT,
> ...
> > -     if (fn->arg1_type == ARG_PTR_TO_UNINIT_MEM)
> > +     if (fn->arg1_type == ARG_PTR_TO_MEM_UNINIT)
> >               count++;
> > -     if (fn->arg2_type == ARG_PTR_TO_UNINIT_MEM)
> > +     if (fn->arg2_type == ARG_PTR_TO_MEM_UNINIT)
> >               count++;
> > -     if (fn->arg3_type == ARG_PTR_TO_UNINIT_MEM)
> > +     if (fn->arg3_type == ARG_PTR_TO_MEM_UNINIT)
> >               count++;
> > -     if (fn->arg4_type == ARG_PTR_TO_UNINIT_MEM)
> > +     if (fn->arg4_type == ARG_PTR_TO_MEM_UNINIT)
> >               count++;
> > -     if (fn->arg5_type == ARG_PTR_TO_UNINIT_MEM)
> > +     if (fn->arg5_type == ARG_PTR_TO_MEM_UNINIT)
> >               count++;
> etc.
Will do - I'll make this edit for v3.
