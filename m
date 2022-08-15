Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AEA8592ECF
	for <lists+bpf@lfdr.de>; Mon, 15 Aug 2022 14:20:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233532AbiHOMUL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 15 Aug 2022 08:20:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiHOMUK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 15 Aug 2022 08:20:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D304126571;
        Mon, 15 Aug 2022 05:20:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 848D2B80E9D;
        Mon, 15 Aug 2022 12:20:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ACCCC433B5;
        Mon, 15 Aug 2022 12:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660566006;
        bh=f2rktetsGEXE1st0YOSkZfJALIY6cfw8R10caJ6XQqg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=l1FM7H01y30MYX/EsZ92Nvhq7jNegbuX0ABjhbOBhV5oHXaapM4hpclSdxG8U3v2q
         4wr6usF68C2MA2bvaVdSKQlQkGa79XC9r0P0yXSFI47t5dCFDPE+AeoixsIW4SjJv0
         TUznUlujXKifhtcrTl/3DPXgnqt38jHo7cGp0bMPerDGz0lPPCEf7Td2wW9WCiNRlD
         ZTMm9UUqH2anOBz9mnbkoNfgqsLn7hUtIRmALtC9uK2HqFa/XbCWT8lBjvjZykj45u
         P8IwdCDA4yK/e8v+3ERTMkiv5wYvyp4GCkiPjIEnD16O1ystW9ZxLYdaVfap+6exS6
         oiaa45r4T+jkA==
Received: by mail-ed1-f48.google.com with SMTP id f22so9335262edc.7;
        Mon, 15 Aug 2022 05:20:06 -0700 (PDT)
X-Gm-Message-State: ACgBeo3rtbhl1bU/x8SS1Zt0fwTn+5FSciEHlcWP0XNGUP33lhAeG8gi
        aVo20JxCxJ/j2Ue4bxAdWfXdFiIjM/1ejbF7PNU=
X-Google-Smtp-Source: AA6agR5HAszA2+ks7eYIZGL4H7rvMH0u5Oz+mr+FkFewIpN9MD3tM73YmvCfKBiZwLch21Kk8PCSKHHzJ3OjwFCTqZ0=
X-Received: by 2002:a05:6402:270e:b0:43d:e3e1:847a with SMTP id
 y14-20020a056402270e00b0043de3e1847amr14500150edd.130.1660566004281; Mon, 15
 Aug 2022 05:20:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220722122548.2db543ca@gandalf.local.home> <YtsRD1Po3qJy3w3t@krava>
 <20220722174120.688768a3@gandalf.local.home> <YtxqjxJVbw3RD4jt@krava>
 <YvbDlwJCTDWQ9uJj@krava> <20220813150252.5aa63650@rorschach.local.home>
 <YvkTLziHX4BINnla@krava> <77477710-c383-73b1-4f78-fe65a81c09b7@huawei.com>
 <Yvn+En35XDqKWptm@krava> <CAJ+HfNjLbsDuE4EB_1jwSOnyaUdjejMZJP6U=zcKvZd=iwhhDQ@mail.gmail.com>
 <YvouGQzlOhb88SM/@krava>
In-Reply-To: <YvouGQzlOhb88SM/@krava>
From:   =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Date:   Mon, 15 Aug 2022 14:19:52 +0200
X-Gmail-Original-Message-ID: <CAJ+HfNhir0HcNYi5PediR=O39nAKUCptbxLDsNsQd-nUQNt=aQ@mail.gmail.com>
Message-ID: <CAJ+HfNhir0HcNYi5PediR=O39nAKUCptbxLDsNsQd-nUQNt=aQ@mail.gmail.com>
Subject: Re: [RFC] ftrace: Add support to keep some functions out of ftrace
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     Chen Zhongjin <chenzhongjin@huawei.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, bpf <bpf@vger.kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 15 Aug 2022 at 13:29, Jiri Olsa <olsajiri@gmail.com> wrote:
>
> On Mon, Aug 15, 2022 at 01:01:06PM +0200, Bj=C3=B6rn T=C3=B6pel wrote:
> > On Mon, 15 Aug 2022 at 10:04, Jiri Olsa <olsajiri@gmail.com> wrote:
> > [...]
> > > > > >
> > > > > > Today, objtool has also got involved, and added an "--mcount" o=
ption
> > > > > > that will create the section too.
> > > > > I overlooked that objtool is involved as well,
> > > > > will check on that
> > > >
> > > > objtool --mcount option only involves mcount_loc generation (see
> > > > annotate_call_site) and other validation check call destination dir=
ectly
> > > > (see is_fentry_call).
> > > >
> > > > Some simply removing --mcount option dose work for this.
> > > >
> > > >
> > > > Another question, it seems we can export and use DEFINE_BPF_DISPATC=
HER out
> > > > of kernel, does that means we should add NO_MCOUNT_FILES for these =
single
> > > > uages as well?
> > >
> > > yes, cc-ing Bj=C3=B6rn to make sure it's valid use case for dispatche=
r
> > >
> >
> > Hmm, could you expand a bit on how this would work?
>
> the goal here is to remove bpf_dispatcher_<FUNC>_func functions from
> ftrace, because it's updated by dispatcher code with bpf_arch_text_poke,
> but it's also visible and attachable to ftrace.. and will cause problems
> when these 2 updates will race
>
> question was if DEFINE_BPF_DISPATCHER can be used in kernel module,
> which would bring another realm of problems ;-)
>

Oh, now I follow. AFAIK there is only one flavor of BPF dispatcher in
use, and that's the XDP dispatcher, which does not reside in module
code, but is typically *called* by module code.

A module could define a BPF dispatcher, but it wouldn't be able to
update it, since bpf_arch_text_poke() does not support poking in
modules.


Bj=C3=B6rn
