Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C36A758766F
	for <lists+bpf@lfdr.de>; Tue,  2 Aug 2022 06:46:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233204AbiHBEqO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 2 Aug 2022 00:46:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232111AbiHBEqN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 2 Aug 2022 00:46:13 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12AB2D114
        for <bpf@vger.kernel.org>; Mon,  1 Aug 2022 21:46:10 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id k26so8201474ejx.5
        for <bpf@vger.kernel.org>; Mon, 01 Aug 2022 21:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+UD0VXOYENOMuj6IQOZxfcrN/jrpkdmRYj6xPYo7Ut4=;
        b=a759WUJFuG3NCFAuila8voudIn8lNMmPYvAVm2Qy4zxGOyiqE02GnOtPfzTOdRMrP0
         Soljb6CjbRchRzimLbjF1SLGvR4JRg8VGLd870lY1diO+K8sCnPqeRxRuJVPkaNZFAH+
         QJvLAmBxg4nXvxiBk39Ho0DRxWT1Nm4x3NBTlf4NiJ05W6wfC9ZJtmWHtYtj6yekzinC
         SID6a4SKryRnjzkVSG416vjwSDYekE/KVHjO0/4uaXRMpJDg+vldhOCpG6CLpucszTFB
         Q0NiArT0da9FNqaA7x6txMtfbTDaDN52a/H4ZGhqp8J7SLKdCeV+D1WfqSQ/BuvbU4+1
         MPsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+UD0VXOYENOMuj6IQOZxfcrN/jrpkdmRYj6xPYo7Ut4=;
        b=7W1xGeUy7H4Lv/sg/rslKBHOOXJqkL/36pgq8JYxoWTQg0i48tJ2an59Mz8FoGK1C9
         K6RAd7y34DwbXIbGUxuNfq9qVWFYcgcyic4j55lD+4Lcuro7+X9soB0EdoB9iL9oyG0G
         6r0OotYwibtmvhSNiArWtxnAVxeRKmPofBeveTbqgAfwHhSSZHARSvlSgmNuhqDqpnk5
         AVKA3YPvJznE0xR3biukZtsNgKDSJgYpiLhwxJmsG85wA40+3zQuI/koSi9AcUWiG982
         +0mAvEE0ahFNOLhScsHM79zql6KKQtuVeTxM+KgJIzcBbLOLW8FJNI5grN1ew3LB7bTb
         ToEA==
X-Gm-Message-State: AJIora/MAFObXzXbo0cY0xUCkQGamFufgwYjIaw1ZEc7jP/1Nz0Lsz7Y
        7uzBBZ/rDiHd3RCgaXW5BiKTXTOyLhsbm3CpaQs=
X-Google-Smtp-Source: AGRyM1uFTeku6sdoaWqveE5fg5zfVPpQxtMqK4emsF+HoIBf2eD/PIGuK0RwX3YGn4LqCfB2ls9MeW4Oa4TBYeKTlkc=
X-Received: by 2002:a17:906:a089:b0:72f:826b:e084 with SMTP id
 q9-20020a170906a08900b0072f826be084mr15323634ejy.708.1659415568497; Mon, 01
 Aug 2022 21:46:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220727081559.24571-1-memxor@gmail.com> <20220727081559.24571-2-memxor@gmail.com>
 <fd75bc5ed2564f558000284c44c89632@huawei.com> <34ee6960df604501a5348eac7b1c5768@huawei.com>
 <CAP01T762iv6bok3K6fQ4aBisUcWg5zhjbKzbXFqX=Z+cvd5tew@mail.gmail.com> <CAP01T75TmR_+hOs+T8rwbNMXd6T8+WSgheC3uKoLOud3-4to5g@mail.gmail.com>
In-Reply-To: <CAP01T75TmR_+hOs+T8rwbNMXd6T8+WSgheC3uKoLOud3-4to5g@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Mon, 1 Aug 2022 21:45:57 -0700
Message-ID: <CAADnVQ+pFYY_KGegBZQKMwqxYT1J6C_wZX=06UCN9yN7ZHpn4g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 1/2] bpf: Add support for per-parameter
 trusted args
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     Roberto Sassu <roberto.sassu@huawei.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLY,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jul 28, 2022 at 2:02 AM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> On Thu, 28 Jul 2022 at 10:45, Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
> >
> > On Thu, 28 Jul 2022 at 10:18, Roberto Sassu <roberto.sassu@huawei.com> wrote:
> > >
> > > > From: Roberto Sassu [mailto:roberto.sassu@huawei.com]
> > > > Sent: Thursday, July 28, 2022 9:46 AM
> > > > > From: Kumar Kartikeya Dwivedi [mailto:memxor@gmail.com]
> > > > > Sent: Wednesday, July 27, 2022 10:16 AM
> > > > > Similar to how we detect mem, size pairs in kfunc, teach verifier to
> > > > > treat __ref suffix on argument name to imply that it must be a trusted
> > > > > arg when passed to kfunc, similar to the effect of KF_TRUSTED_ARGS flag
> > > > > but limited to the specific parameter. This is required to ensure that
> > > > > kfunc that operate on some object only work on acquired pointers and not
> > > > > normal PTR_TO_BTF_ID with same type which can be obtained by pointer
> > > > > walking. Release functions need not specify such suffix on release
> > > > > arguments as they are already expected to receive one referenced
> > > > > argument.
> > > >
> > > > Thanks, Kumar. I will try it.
> > >
> > > Uhm. I realized that I was already using another suffix,
> > > __maybe_null, to indicate that a caller can pass NULL as
> > > argument.
> > >
> > > Wouldn't probably work well with two suffixes.
> > >
> >
> > Then you can maybe extend it to parse two suffixes at most (for now atleast)?
> >
> > > Have you considered to extend BTF_ID_FLAGS to take five
> > > extra arguments, to set flags for each kfunc parameter?
> > >
> >
> > I didn't understand this. Flags parameter is an OR of the flags you
> > set, why would we want to extend it to take 5 args?
> > You can just or f1 | f2 | f3 | f4 | f5, as many as you want.
>
> Oh, so you mean having 5 more args to indicate flags on each
> parameter? It is possible, but I think the scheme for now works ok. If
> you extend it to parse two suffixes, it should be fine. Yes, the
> variable name would be ugly, but you can just make a copy into a
> properly named one. This is the best we can do without switching to
> BTF tags. We can revisit this when we start having 4 or 5 tags on a
> single parameter.
>
> To make it a bit less verbose you could probably call maybe_null just null?

Thank you for posting the patch.
It still feels that this extra flexibility gets convoluted.
I'm not sure Roberto's kfunc actually needs __ref.
All pointers should be pointers. Hacking -1 and -2 into a pointer
is something that key infra did, but it doesn't mean that
we have to carry over it into bpf kfunc.
