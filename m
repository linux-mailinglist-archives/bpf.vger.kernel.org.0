Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E59B55A6BF0
	for <lists+bpf@lfdr.de>; Tue, 30 Aug 2022 20:20:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231566AbiH3SUE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 30 Aug 2022 14:20:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbiH3SUB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 30 Aug 2022 14:20:01 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 124AC9FE7
        for <bpf@vger.kernel.org>; Tue, 30 Aug 2022 11:19:57 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id j6so9072845qkl.10
        for <bpf@vger.kernel.org>; Tue, 30 Aug 2022 11:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=gBDBm7FdNaYyZC0nfBYKT3XvPWRmFt+iZKEdUm+BaJ8=;
        b=PFhPRI+4X1gjbVKioKDEiw99Nakpy+OlUfsHbijf+I54GkTf02xZwzvi7tOs9Vq2Zl
         Cx2aXmse4smTp6j2UsBXqtt3JIKvAhI0hRsj2R03JuaIFym6ik/SrxiziaoxGRZN3zFa
         3KMCPt9mXQFpJmx/30QtIQmNMNrv0u+m7vIXAOC+5+snc/AKBnqvNasd3tcK56ZezDoc
         KC1QIXuCFZaDjJfF80GRduba5MWY5hQzbeglKrXqI6+mqlY2QC5+5QqVq9wFdvDaE4qS
         CZaBiAlgw0jn/rCGxXdLLnf3SvVZYhSRqZOiNFA+Qzz4LcqqggIBtq94rboXoPxYvRV6
         mXBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=gBDBm7FdNaYyZC0nfBYKT3XvPWRmFt+iZKEdUm+BaJ8=;
        b=t6f9pQ0r36Zz3E1gtJvcDfQJMISsyjM1QqKdQNjnEWszD00p/98JqigkhgEr89DYoZ
         u8xmwRggU4JQ0HXOfnGAMzs7Co+OdfGEYqLH+YFMgXZ3r33uWgH3s3Yh+SgtgmOsfsSJ
         4p8c7/DnbVXPvATK3rXnUQmVXG4dvSmrwItENe991ppkX8gqHt6AX8Dr+N5Vfw0xNJXA
         I8OGLV5+/efCJOCUKdxEFWQhCRGLjsIZshAdUZW6VQlHPJcVUJHdw1KsivZXmdzl+nJJ
         gBjna9v3mJ5CkotzeerBNgZhcyGL2cWu3BXArqrxUe2GeyASIQ2jL59PQBLH+xn5FWXP
         l+ZA==
X-Gm-Message-State: ACgBeo34detWlqzIZodKApPgccDcTyB/iuKmlTHj0XQkQS/Rofm8rJj6
        AjFwQ4azYLGb1KAETwbLTYcnNFuhgpPWFatY+BkAMw==
X-Google-Smtp-Source: AA6agR6VFRyePpblpojBiEo1DzWBwlLZ9f05sP3m0WEWWm1yg4UaAu5LxT1Zf3p5IZh0P4g+wBjImuijbwaUdNzUE4Q=
X-Received: by 2002:a05:620a:458c:b0:6bb:848a:b86b with SMTP id
 bp12-20020a05620a458c00b006bb848ab86bmr13074085qkb.267.1661883596888; Tue, 30
 Aug 2022 11:19:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220829231828.1016835-1-haoluo@google.com> <016bdefd-ff75-35ca-52a5-0e058e0a5d04@isovalent.com>
 <20220830180623.hi6ma6nql4by23sr@kafai-mbp.dhcp.thefacebook.com>
In-Reply-To: <20220830180623.hi6ma6nql4by23sr@kafai-mbp.dhcp.thefacebook.com>
From:   Hao Luo <haoluo@google.com>
Date:   Tue, 30 Aug 2022 11:19:45 -0700
Message-ID: <CA+khW7hKHvOjz6WAB7ufTDbfe+AzJo9sJiXDVMKbWS6cnxC2Qw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1] bpftool: Add support for querying cgroup_iter link
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     Quentin Monnet <quentin@isovalent.com>,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Stanislav Fomichev <sdf@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Yosry Ahmed <yosryahmed@google.com>
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

On Tue, Aug 30, 2022 at 11:06 AM Martin KaFai Lau <kafai@fb.com> wrote:
>
> On Tue, Aug 30, 2022 at 02:33:47PM +0100, Quentin Monnet wrote:
> > > +static const char *cgroup_order_string(__u32 order)
> > > +{
> > > +   switch (order) {
> > > +   case BPF_CGROUP_ITER_ORDER_UNSPEC:
> > > +           return "order_unspec";
> > > +   case BPF_CGROUP_ITER_SELF_ONLY:
> > > +           return "self_only";
> > > +   case BPF_CGROUP_ITER_DESCENDANTS_PRE:
> > > +           return "descendants_pre";
> > > +   case BPF_CGROUP_ITER_DESCENDANTS_POST:
> > > +           return "descendants_post";
> > > +   case BPF_CGROUP_ITER_ANCESTORS_UP:
> > > +           return "ancestors_up";
> > > +   default: /* won't happen */
> > > +           return "";
> >
> > I wonder if that one should be "unknown", in case another option is
> > added in the future, so we can spot it and address it?
> I added "unknown" and applied.

Thanks Martin and Quentin, "unknown" is better than an empty string.
