Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D66F52098C
	for <lists+bpf@lfdr.de>; Tue, 10 May 2022 01:43:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233340AbiEIXrn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 9 May 2022 19:47:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235053AbiEIXrP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 9 May 2022 19:47:15 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66C7E2CDEE8
        for <bpf@vger.kernel.org>; Mon,  9 May 2022 16:38:36 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id q20so9202971wmq.1
        for <bpf@vger.kernel.org>; Mon, 09 May 2022 16:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=spcdF8uyBSDoApyhUhvHOvGJF+mSne/adtJmWUIeWd0=;
        b=b166idcM+quZhwhX1zBamRMRavb0wPU3+lTWNqpZ6Kqpn6rv5QuVU5FGjUb4oDGrTE
         37+XOBe5vLW6lczyIYi82hWbOM1EEp3O5BOph7tfKVI3mLthbIiiXmDuIJfX65j7NZNw
         R02ltoPziVM0WLR+GTDvBDwzeBLJXAP+OgDPoG/7yDbByeQSPjE9tco6L52kSWqZpAq3
         qW4I4CywfL2WKxxJv1xu24s6HPUcwtjszVAEngdgspIKxA7sOslAE2GMpvYlwURy+ou8
         WeRvSK0/ZTuzHVAFWLQzKqc92LgKnTUrteBDXNlChXkCDmSVdY460NamAU2VMtycdbfw
         Yl9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=spcdF8uyBSDoApyhUhvHOvGJF+mSne/adtJmWUIeWd0=;
        b=zacPHBII1PFnGSNB84tvWrQa4rrX3BIwuLwO9A2QxWX8Au29rtyj1icwzU1HZqrkKT
         IwPz5vk3UTJJoGp/70reXpKTpsQMv95CzMVE4oJxua7ahDSVV3SD0bCRAT3jETN3gVx7
         VmcCBSTa8VNCVMbMMXmD/4IV3116b66v7tTT3ZcvHn1i4+QIek+rUrlxMRSO1F7uuEa4
         09BSwCCFSrNjm85KNIegb9toRzLV+C/e0CCJBr3dKlgSATHNXh4KQpAb9VbvA61Dd+KB
         UPduLgj9HAv76247sPMrrVFb+qOUkYBx4Uz21g5tQ9w2iBQN/tRCp8XmmelEGaM65gAo
         7Qdg==
X-Gm-Message-State: AOAM532ibxa5v+2Dgd4E0DHN7SKLOBh5xgxdVxwZebtVJ85JUNgxcQ1t
        eaQPYIcbkYgUPPanc7OXZEJNJPZIOH9kywulDdT6Uw==
X-Google-Smtp-Source: ABdhPJwjPI/oeGbdnitaMa3s3w9e1mRw7dVxdeCzO8AmA5l5BAXZ8cL2+WTMiWwWU2seq90Y4LnU4lRaLf0RYDjBdqY=
X-Received: by 2002:a05:600c:9:b0:393:ea67:1c68 with SMTP id
 g9-20020a05600c000900b00393ea671c68mr25576186wmc.92.1652139514823; Mon, 09
 May 2022 16:38:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220429211540.715151-1-sdf@google.com> <20220429211540.715151-6-sdf@google.com>
 <CAEf4BzbSW3Wgpt_RYaFSHiPEmiGVkqa0ZsA45hD6pOnBqCFfuQ@mail.gmail.com>
In-Reply-To: <CAEf4BzbSW3Wgpt_RYaFSHiPEmiGVkqa0ZsA45hD6pOnBqCFfuQ@mail.gmail.com>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Mon, 9 May 2022 16:38:23 -0700
Message-ID: <CAKH8qBtCe-sb==_PHeJoPgo=8uEUwqFwTXSEwS=tTGSizaoJnA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 05/10] bpf: implement BPF_PROG_QUERY for BPF_LSM_CGROUP
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, May 9, 2022 at 2:49 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Fri, Apr 29, 2022 at 2:15 PM Stanislav Fomichev <sdf@google.com> wrote:
> >
> > We have two options:
> > 1. Treat all BPF_LSM_CGROUP as the same, regardless of attach_btf_id
> > 2. Treat BPF_LSM_CGROUP+attach_btf_id as a separate hook point
> >
> > I'm doing (2) here and adding attach_btf_id as a new BPF_PROG_QUERY
> > argument. The downside is that it requires iterating over all possible
> > bpf_lsm_ hook points in the userspace which might take some time.
> >
> > Signed-off-by: Stanislav Fomichev <sdf@google.com>
> > ---
> >  include/uapi/linux/bpf.h       |  1 +
> >  kernel/bpf/cgroup.c            | 43 ++++++++++++++++++++++++----------
> >  kernel/bpf/syscall.c           |  3 ++-
> >  tools/include/uapi/linux/bpf.h |  1 +
> >  tools/lib/bpf/bpf.c            | 42 ++++++++++++++++++++++++++-------
> >  tools/lib/bpf/bpf.h            | 15 ++++++++++++
> >  tools/lib/bpf/libbpf.map       |  1 +
>
> please split kernel and libbpf changes into separate patches and mark
> libbpf's with "libbpf: " prefix

Ack, thanks, will do this and will address the rest.


> >  7 files changed, 85 insertions(+), 21 deletions(-)
> >
>
> [...]
>
> > diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
> > index a9d292c106c2..f62823451b99 100644
> > --- a/tools/lib/bpf/bpf.c
> > +++ b/tools/lib/bpf/bpf.c
> > @@ -946,28 +946,54 @@ int bpf_iter_create(int link_fd)
> >         return libbpf_err_errno(fd);
> >  }
> >
> > -int bpf_prog_query(int target_fd, enum bpf_attach_type type, __u32 query_flags,
> > -                  __u32 *attach_flags, __u32 *prog_ids, __u32 *prog_cnt)
> > +int bpf_prog_query2(int target_fd,
>
> this would have to be named bpf_prog_query_opts()
>
> > +                   enum bpf_attach_type type,
> > +                   struct bpf_prog_query_opts *opts)
> >  {
> >         union bpf_attr attr;
> >         int ret;
> >
> >         memset(&attr, 0, sizeof(attr));
> > +
>
> [...]
>
> > diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> > index b5bc84039407..5e5bb3e437cc 100644
> > --- a/tools/lib/bpf/libbpf.map
> > +++ b/tools/lib/bpf/libbpf.map
> > @@ -450,4 +450,5 @@ LIBBPF_0.8.0 {
> >                 bpf_program__attach_usdt;
> >                 libbpf_register_prog_handler;
> >                 libbpf_unregister_prog_handler;
> > +               bpf_prog_query2;
>
> this list is alphabetically ordered
>
> >  } LIBBPF_0.7.0;
> > --
> > 2.36.0.464.gb9c8b46e94-goog
> >
