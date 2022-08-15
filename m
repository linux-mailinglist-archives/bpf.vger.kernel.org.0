Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4463592E34
	for <lists+bpf@lfdr.de>; Mon, 15 Aug 2022 13:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231912AbiHOL3g (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 15 Aug 2022 07:29:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231948AbiHOL3f (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 15 Aug 2022 07:29:35 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63C90248E1;
        Mon, 15 Aug 2022 04:29:34 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id i14so13008857ejg.6;
        Mon, 15 Aug 2022 04:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc;
        bh=+Pb5wHqI3BoyvWxLFjcEgnClCiBrlJxxqraQstC6Z0k=;
        b=XoNdHHGoAD4+HWEpevq78Saxk2XsOr+Wfbvej4qET7BY/aASs2TMASlSV2NsXTlEbt
         m3YVd9V2Zj+L2OQXnd89EzeV7HnXTR2ELtgc/w3fBUuKVIhPwWJFzXG2nbTgBYZn85hV
         6nP7s54DXWeUfH0vJofj7voS8EqwAlmn7hK2C326243zK3upK0Z4umPXw0ybUVxrRNZj
         dFANjg+JKeyW/Fdle4gefvPC/qBhjT8eEIGOCuQx6+bSVC+3DOc280JFb23cOmxCsfaF
         XAEt6hoJa14gY1AOl1SAmKsilGaipDjJXC8t0ZLuOc+0dkoBwaWQ4P9yjrwM/0q06Ie8
         gFIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc;
        bh=+Pb5wHqI3BoyvWxLFjcEgnClCiBrlJxxqraQstC6Z0k=;
        b=BsxQTTmtlD6XRB72iuZXKq2PynMU584KNgyvLps6wz/Xta1M0VaiQa3cDLmzhGHdqM
         SxJAfyieRSWrJ1qYfziO2myCxb4LgnE0GpPnQCmj0yZZ8OQ1FJA+7nt1dSRj4OjTBEB1
         UySCIRQFZFOTxhyYDUOql7ttdbPgzKQPvTbvXMA0vWY0kxQkTRSz3ywxLTPlqqblZdwl
         +22Bo+jx7ktW+7rk8kyX9EdIS/XFnkmwaPkvYqcEa120Mvc5hJNHF3a14vXvxfnLMTjZ
         46mNJ/nmx+umY3H4OXMo2VRndKwASqBNx7lu+/DgY46yT6CBFfpgzCXshhtltg0oddoa
         ln7A==
X-Gm-Message-State: ACgBeo1Zs0k/rop4sGNP2RwaWkhpTEyBUmELbPjw098kZ7UxvIbrsYqp
        SG4rQ8YR/gWWKvbcidfQhI4=
X-Google-Smtp-Source: AA6agR7yWicVLiiOHD0xWoGBkzBdDYhthP5E2wWUmVlGxc56mc6T8HZ35PN5NAAn+N2XxH8bTT1reA==
X-Received: by 2002:a17:906:cc56:b0:730:a2f0:7466 with SMTP id mm22-20020a170906cc5600b00730a2f07466mr10157034ejb.211.1660562973006;
        Mon, 15 Aug 2022 04:29:33 -0700 (PDT)
Received: from krava ([193.85.244.190])
        by smtp.gmail.com with ESMTPSA id o8-20020a170906358800b0073306218484sm3941940ejb.26.2022.08.15.04.29.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 04:29:32 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Mon, 15 Aug 2022 13:29:29 +0200
To:     =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>
Cc:     Jiri Olsa <olsajiri@gmail.com>,
        Chen Zhongjin <chenzhongjin@huawei.com>,
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
Subject: Re: [RFC] ftrace: Add support to keep some functions out of ftrace
Message-ID: <YvouGQzlOhb88SM/@krava>
References: <20220722122548.2db543ca@gandalf.local.home>
 <YtsRD1Po3qJy3w3t@krava>
 <20220722174120.688768a3@gandalf.local.home>
 <YtxqjxJVbw3RD4jt@krava>
 <YvbDlwJCTDWQ9uJj@krava>
 <20220813150252.5aa63650@rorschach.local.home>
 <YvkTLziHX4BINnla@krava>
 <77477710-c383-73b1-4f78-fe65a81c09b7@huawei.com>
 <Yvn+En35XDqKWptm@krava>
 <CAJ+HfNjLbsDuE4EB_1jwSOnyaUdjejMZJP6U=zcKvZd=iwhhDQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ+HfNjLbsDuE4EB_1jwSOnyaUdjejMZJP6U=zcKvZd=iwhhDQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Aug 15, 2022 at 01:01:06PM +0200, Björn Töpel wrote:
> On Mon, 15 Aug 2022 at 10:04, Jiri Olsa <olsajiri@gmail.com> wrote:
> [...]
> > > > >
> > > > > Today, objtool has also got involved, and added an "--mcount" option
> > > > > that will create the section too.
> > > > I overlooked that objtool is involved as well,
> > > > will check on that
> > >
> > > objtool --mcount option only involves mcount_loc generation (see
> > > annotate_call_site) and other validation check call destination directly
> > > (see is_fentry_call).
> > >
> > > Some simply removing --mcount option dose work for this.
> > >
> > >
> > > Another question, it seems we can export and use DEFINE_BPF_DISPATCHER out
> > > of kernel, does that means we should add NO_MCOUNT_FILES for these single
> > > uages as well?
> >
> > yes, cc-ing Björn to make sure it's valid use case for dispatcher
> >
> 
> Hmm, could you expand a bit on how this would work?

the goal here is to remove bpf_dispatcher_<FUNC>_func functions from
ftrace, because it's updated by dispatcher code with bpf_arch_text_poke,
but it's also visible and attachable to ftrace.. and will cause problems
when these 2 updates will race

question was if DEFINE_BPF_DISPATCHER can be used in kernel module,
which would bring another realm of problems ;-)

jirka
