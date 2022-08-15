Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D4C2592DAA
	for <lists+bpf@lfdr.de>; Mon, 15 Aug 2022 13:01:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241850AbiHOLBv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 15 Aug 2022 07:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241757AbiHOLBX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 15 Aug 2022 07:01:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C169237ED;
        Mon, 15 Aug 2022 04:01:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EDB03B80E1B;
        Mon, 15 Aug 2022 11:01:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBFF9C43141;
        Mon, 15 Aug 2022 11:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660561279;
        bh=cJxtEjsOPdD+28GEo/pZSc8mfFhYYMFZySPDzKfTUaw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=T+/ShaanW8wZOBJ/SIcn5ow+zcCc4WSMhAAdhraztsvUEzTfBrw/wcpqxFD51Jdn+
         7bhidBpzI8hvyK5ab1oUvOtDcjuV0vC5ApPHUObPTCdgSYcUSIIpttCefWvqXCjMUQ
         OLuBid0zG2UWb2ZSDz/LA/OOtW4qsN3KEpR/uL0bFBXe2Uyd0Ry85VgXRgZ53Md2Rc
         MoOvQdy6euZsHrj+SWkH/9HuNq9rATwlDWn//nrkyVNKcSzypdgAUZ3IplfS8iyKdl
         GFmLCUdyb+LUGMOdy8fJgPf3gd5DWkP8khK82E0kB1o/4DRtg3hLSHtitVSeB9N3xS
         rpmQM0JThwRcw==
Received: by mail-ej1-f46.google.com with SMTP id kb8so12943101ejc.4;
        Mon, 15 Aug 2022 04:01:19 -0700 (PDT)
X-Gm-Message-State: ACgBeo1T69CkhNJL62Hj1G+DkO448ecLw3sO1zZntuKkpTPQ8wsPPmUR
        KhBvIb0V/AlXmJKaPWKy4Inm2UZAOHrqNi7j6HA=
X-Google-Smtp-Source: AA6agR6TXzByijRnQWrhX/xMZDPr0y7EqMxYTzHa5iTd0WrjHBxMUttMH/b1n+vQ8+rWBMd1wvlgn58BPbChUscUnR4=
X-Received: by 2002:a17:907:1c26:b0:730:960f:118 with SMTP id
 nc38-20020a1709071c2600b00730960f0118mr9975626ejc.650.1660561277990; Mon, 15
 Aug 2022 04:01:17 -0700 (PDT)
MIME-Version: 1.0
References: <CAADnVQ+hLnyztCi9aqpptjQk-P+ByAkyj2pjbdD45dsXwpZ0bw@mail.gmail.com>
 <20220722120854.3cc6ec4b@gandalf.local.home> <20220722122548.2db543ca@gandalf.local.home>
 <YtsRD1Po3qJy3w3t@krava> <20220722174120.688768a3@gandalf.local.home>
 <YtxqjxJVbw3RD4jt@krava> <YvbDlwJCTDWQ9uJj@krava> <20220813150252.5aa63650@rorschach.local.home>
 <YvkTLziHX4BINnla@krava> <77477710-c383-73b1-4f78-fe65a81c09b7@huawei.com> <Yvn+En35XDqKWptm@krava>
In-Reply-To: <Yvn+En35XDqKWptm@krava>
From:   =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Date:   Mon, 15 Aug 2022 13:01:06 +0200
X-Gmail-Original-Message-ID: <CAJ+HfNjLbsDuE4EB_1jwSOnyaUdjejMZJP6U=zcKvZd=iwhhDQ@mail.gmail.com>
Message-ID: <CAJ+HfNjLbsDuE4EB_1jwSOnyaUdjejMZJP6U=zcKvZd=iwhhDQ@mail.gmail.com>
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

On Mon, 15 Aug 2022 at 10:04, Jiri Olsa <olsajiri@gmail.com> wrote:
[...]
> > > >
> > > > Today, objtool has also got involved, and added an "--mcount" optio=
n
> > > > that will create the section too.
> > > I overlooked that objtool is involved as well,
> > > will check on that
> >
> > objtool --mcount option only involves mcount_loc generation (see
> > annotate_call_site) and other validation check call destination directl=
y
> > (see is_fentry_call).
> >
> > Some simply removing --mcount option dose work for this.
> >
> >
> > Another question, it seems we can export and use DEFINE_BPF_DISPATCHER =
out
> > of kernel, does that means we should add NO_MCOUNT_FILES for these sing=
le
> > uages as well?
>
> yes, cc-ing Bj=C3=B6rn to make sure it's valid use case for dispatcher
>

Hmm, could you expand a bit on how this would work?
