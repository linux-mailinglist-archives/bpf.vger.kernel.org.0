Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 330375A1BE3
	for <lists+bpf@lfdr.de>; Fri, 26 Aug 2022 00:06:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244275AbiHYWGb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 25 Aug 2022 18:06:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244284AbiHYWG3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 25 Aug 2022 18:06:29 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB5EEAE9C9
        for <bpf@vger.kernel.org>; Thu, 25 Aug 2022 15:06:23 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id cu2so4194215ejb.0
        for <bpf@vger.kernel.org>; Thu, 25 Aug 2022 15:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=9oiA8MpjOaIW1Fvw/8XRjS43dQVaZ1er3tLt3a2yWHg=;
        b=F/qRam/Dec0c6A+pukDBJrqMh9QIThRO90gg2vU96TgvvGHvAWluGSixqu6pLPmQ8v
         n61GNGepe0Rp0mjzdtUuVkHUMDx9XO7LwInl2sT5EPu5RQ7JNVoa63V3uircrjGZh2HE
         gNnVtRgdd/jKM3I6VzUJIg4NDLUMQGX+Qn2SPZ94j8hhF8bSbujEjNzRVDcdRxZ0bZEu
         Dl3LTFpsjs6ot+6kNyrlcSWIsQz+TcnU/o+wcYIAviaiqQRBdAnm8GZIfNkoBOlofnvm
         fwVfi8TR55hw531ytqbuuPgHwz712POD55vuuKd0AtT52a1KWz8dAV0owpN8ds/FBSQ/
         38LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=9oiA8MpjOaIW1Fvw/8XRjS43dQVaZ1er3tLt3a2yWHg=;
        b=locYTKUXwjdGcydlPx0AVZw/4keMeJsnIZQlI6IuAwFviF/RkeaT+8ICJwNUVMy1+C
         oSxheMnME7CgyeAMo4SQdoNZqeAraRaZ9UvL6LcHQHpfPrJ9V5WaX3qbdyYBtsdS6SoW
         t+RQIC2j1zw9wUijBKG+muqwTWJUPOGPiLDNFUv74J19z2+cKrS8wDven0DW5wZGNQ1g
         SxWgA6xh/DvsSKyTd0DruYChrRERZ7o2dbad5pvzc9sE0NSz2t/ejkhNHhG+gq+sU5Aq
         /F0aYOS1kPLxHfYA/hCAoHNLdjkqb6HCeBdlKQ6hOjI3f63VXKTfxptUHsitAVlSmd3g
         HJkA==
X-Gm-Message-State: ACgBeo0AXTHRQN6F8RbEvftws97rbJHVzaUNr4vWxMeM5WGGK4pw0eVH
        KtFs80a/VNOE27oO75nRjdgapKKKgYZ7ox3szJ4=
X-Google-Smtp-Source: AA6agR4EtF1qB47h9ZEVVpo/v2aZhRA9+FVa29nWFoEbe7RREQgYsd+Ar52hL4zQ3ZDFKIWSpzThKEtvxTj7CxVcFvs=
X-Received: by 2002:a17:907:6e8b:b0:73d:c094:e218 with SMTP id
 sh11-20020a1709076e8b00b0073dc094e218mr3783039ejc.226.1661465181964; Thu, 25
 Aug 2022 15:06:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220722171836.2852247-1-roberto.sassu@huawei.com>
 <20220722171836.2852247-3-roberto.sassu@huawei.com> <20220722175528.26ve4ahnir6su5tu@macbook-pro-3.dhcp.thefacebook.com>
 <5c5cdf397a6e4523845d0a16117e3b81@huawei.com> <CAEf4BzYmomMAEEQYH+fGQeH-_+4oxsFYc+qbZyf1DgF1E_CuSw@mail.gmail.com>
 <d3b9f2e1cb4a4fb5b5e47ea45df4be5c@huawei.com> <d85a241583a325be9f6a6860df7bebea5e55e032.camel@huaweicloud.com>
In-Reply-To: <d85a241583a325be9f6a6860df7bebea5e55e032.camel@huaweicloud.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 25 Aug 2022 15:06:10 -0700
Message-ID: <CAEf4BzZctz0b=P9CmE-eBVsZEtZEjZwNGKrFLbOz4Gp5oXOchg@mail.gmail.com>
Subject: Re: [RFC][PATCH v3 02/15] bpf: Set open_flags as last bpf_attr field
 for bpf_*_get_fd_by_id() funcs
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        "quentin@isovalent.com" <quentin@isovalent.com>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "martin.lau@linux.dev" <martin.lau@linux.dev>,
        "song@kernel.org" <song@kernel.org>,
        "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
        "kpsingh@kernel.org" <kpsingh@kernel.org>,
        "sdf@google.com" <sdf@google.com>,
        "jevburton.kernel@gmail.com" <jevburton.kernel@gmail.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLY,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Aug 25, 2022 at 5:21 AM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
>
> On Mon, 2022-08-01 at 10:33 +0000, Roberto Sassu wrote:
> > > From: Andrii Nakryiko [mailto:andrii.nakryiko@gmail.com]
> > > Sent: Friday, July 29, 2022 8:49 PM
> > > On Mon, Jul 25, 2022 at 12:10 AM Roberto Sassu <
> > > roberto.sassu@huawei.com>
> > > wrote:
> > > > > From: Alexei Starovoitov [mailto:alexei.starovoitov@gmail.com]
> > > > > Sent: Friday, July 22, 2022 7:55 PM
> > > > > On Fri, Jul 22, 2022 at 07:18:23PM +0200, Roberto Sassu wrote:
> > > > > > The bpf() system call validates the bpf_attr structure
> > > > > > received as
> > > > > > argument, and considers data until the last field, defined
> > > > > > for each
> > > > > > operation. The remaing space must be filled with zeros.
> > > > > >
> > > > > > Currently, for bpf_*_get_fd_by_id() functions except
> > > bpf_map_get_fd_by_id()
> > > > > > the last field is *_id. Setting open_flags to BPF_F_RDONLY
> > > > > > from user space
> > > > > > will result in bpf() rejecting the argument.
> > > > >
> > > > > The kernel is doing the right thing. It should not ignore
> > > > > fields.
> > > >
> > > > Exactly. As Andrii requested to add opts to all
> > > > bpf_*_get_fd_by_id()
> > > > functions, the last field in the kernel needs to be updated
> > > > accordingly.
> > > >
> > >
> > > It's been a while ago so details are hazy. But the idea was that if
> > > we
> > > add _opts variant for bpf_map_get_fd_by_id() for interface
> > > consistency
> > > all the other bpf_*_get_fd_by_id() probably should get _opts
> > > variant
> > > and use the same opts struct. Right now kernel doesn't support
> > > specifying flags for non-maps and that's fine. I agree with Alexei
> > > that kernel shouldn't just ignore unrecognized field silently.
> > >
> > > I think we still can add _opts() for all APIs, but user will need
> > > to
> > > know that non-map variants expect 0 as flags. For now. If we
> > > eventually add ability to specify flags for, say, links, then
> > > existing
> > > API will just work. One can see how this get_fd_by_id() can use
> > > read-only flags to return FDs that only support read-only
> > > operations
> > > on objects (e.g., fetching link info for links, dumping prog
> > > instructions for programs), but not modification operations (e.g.,
> > > updating prog for links, or whatever write operation could be for
> > > programs).
> > >
> > > So I don't think there is contradiction here. We might choose to
> > > add
> > > bpf_map_get_fd_by_id_opts() only, but we probably still should use
> > > common struct name as if all bpf_*_get_fd_by_id_opts() exist.
> >
> > Ok, understood.
>
> Hi Andrii
>
> I'm about to send v4 with the suggestions you made.
>
> Since now libbpf v1 has been released, how it works for new patches? It
> seems there is not a new section in libbpf.map (kernel) new API
> functions should be added to.

yes, we need to add LIBBPF_1.1.0 now. I might send a small patch today
to do that, if not, feel free to add it in your patch set. Whoever
lands first wins (unfortunately even if I add an empty section, first
feature adding a new function to libbpf API would need to add
"global:" and thus conflict with any other patch set adding new API).

>
> Also, I'm using a custom step in the CI:
>
> https://github.com/robertosassu/libbpf-ci/commit/7743eb92f81f95355571c07e5b7082a9a2b0bfe0
>
> Do you want me to create a new PR before sending the patch set?
>
> Thanks
>
> Roberto
>
