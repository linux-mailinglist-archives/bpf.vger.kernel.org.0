Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EA33592EE6
	for <lists+bpf@lfdr.de>; Mon, 15 Aug 2022 14:30:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233530AbiHOMau (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 15 Aug 2022 08:30:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242442AbiHOMas (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 15 Aug 2022 08:30:48 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5B1B6400;
        Mon, 15 Aug 2022 05:30:45 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id i14so13251767ejg.6;
        Mon, 15 Aug 2022 05:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=AZAXOi6uFyMoBC8VUTD1zgcVsenCR+DQMIXTIoFpT/0=;
        b=nWc09iP/xVHrJlRgxfqL+6ks4L79jBKv9Qn7z3VwR1O4lCk7VgRn9ivwliirXO3Fa7
         FeXwtoccQfvz6jxIYJH63frD9/ywBMF5T9nRMuvA37bJeqrSopOC2XRcCXzMojb4Hd0i
         vvHc/13tjp5uURE/3dGg2Uda5fEiZm9FzH/hkc+CpQ8o5b/f2xbfxillFL1w+9OpJIqo
         43Wl90OGa4t9KmyeOTLBVIOlrAGoUFhW4lgrW1LbjoNMc2rFnVyEpM9NPWPB2/sndRzz
         +IG5gETAGKnQyaz/p8vPX6MNes6nVO44Dbmfv9H254iLjrt4twudHSiXRzZyjj/r5z7o
         1G+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=AZAXOi6uFyMoBC8VUTD1zgcVsenCR+DQMIXTIoFpT/0=;
        b=2P37HX4wojNRfB2kRJzcsJLgY2h/uQe8oFXosIodtGGWKjS6VJW8X7Sd6pxVQvTJ9i
         cqZwWnPJfzSgQsDcg1PAM2C26wvevbfE6Ss+OzwIs6ZcfNiLiU6Y0E+Bd/V8281GGrD8
         6oGT+XHs2qP75cWRxeMbqLiYnwT9bSa1iLLptfWYx3Q4p+xs0aZohFxDF7KAsbcSUhrR
         sFoAHFXDbdKzQnwF7VVJauDHOjHFu6QE3ezKncCUt8GY1/eI30EbCL6wixm5hGLmNLfb
         PTKRGGSIIegYPMm6zNNkHonL8wCxcFXucAgWVf3xou2g4C72LB28xOJi5fUfqSyaaJg/
         IujA==
X-Gm-Message-State: ACgBeo1Bo8KhmVY8aSru562vBQJ1S7aUQiYaRREMUsfDyln6koZS75WW
        O4mHwkWopMUTsMlFA9NJ2dDNc/1OOf4IefykT4k=
X-Google-Smtp-Source: AA6agR7PIvFlJNfGn9D7qE7su+BcGmJ/wlAOyVqZ3+O2tLJStsK2sq0CJqxwrKqgO2fudkTXTfYUmWcIEcGD9heZAoI=
X-Received: by 2002:a17:907:272a:b0:731:4699:b375 with SMTP id
 d10-20020a170907272a00b007314699b375mr10373781ejl.633.1660566644129; Mon, 15
 Aug 2022 05:30:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220722122548.2db543ca@gandalf.local.home> <YtsRD1Po3qJy3w3t@krava>
 <20220722174120.688768a3@gandalf.local.home> <YtxqjxJVbw3RD4jt@krava>
 <YvbDlwJCTDWQ9uJj@krava> <20220813150252.5aa63650@rorschach.local.home>
 <YvkTLziHX4BINnla@krava> <77477710-c383-73b1-4f78-fe65a81c09b7@huawei.com>
 <Yvn+En35XDqKWptm@krava> <CAJ+HfNjLbsDuE4EB_1jwSOnyaUdjejMZJP6U=zcKvZd=iwhhDQ@mail.gmail.com>
 <YvouGQzlOhb88SM/@krava> <CAJ+HfNhir0HcNYi5PediR=O39nAKUCptbxLDsNsQd-nUQNt=aQ@mail.gmail.com>
In-Reply-To: <CAJ+HfNhir0HcNYi5PediR=O39nAKUCptbxLDsNsQd-nUQNt=aQ@mail.gmail.com>
From:   =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>
Date:   Mon, 15 Aug 2022 14:30:32 +0200
Message-ID: <CAJ+HfNisAHpe9YghyG3kXZAZ-b5toKjfDaN-021NPN2UY1Pn3A@mail.gmail.com>
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 15 Aug 2022 at 14:19, Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org> wrot=
e:
>
> On Mon, 15 Aug 2022 at 13:29, Jiri Olsa <olsajiri@gmail.com> wrote:
> >
> > On Mon, Aug 15, 2022 at 01:01:06PM +0200, Bj=C3=B6rn T=C3=B6pel wrote:
> > > On Mon, 15 Aug 2022 at 10:04, Jiri Olsa <olsajiri@gmail.com> wrote:
> > > [...]
> > > > > > >
> > > > > > > Today, objtool has also got involved, and added an "--mcount"=
 option
> > > > > > > that will create the section too.
> > > > > > I overlooked that objtool is involved as well,
> > > > > > will check on that
> > > > >
> > > > > objtool --mcount option only involves mcount_loc generation (see
> > > > > annotate_call_site) and other validation check call destination d=
irectly
> > > > > (see is_fentry_call).
> > > > >
> > > > > Some simply removing --mcount option dose work for this.
> > > > >
> > > > >
> > > > > Another question, it seems we can export and use DEFINE_BPF_DISPA=
TCHER out
> > > > > of kernel, does that means we should add NO_MCOUNT_FILES for thes=
e single
> > > > > uages as well?
> > > >
> > > > yes, cc-ing Bj=C3=B6rn to make sure it's valid use case for dispatc=
her
> > > >
> > >
> > > Hmm, could you expand a bit on how this would work?
> >
> > the goal here is to remove bpf_dispatcher_<FUNC>_func functions from
> > ftrace, because it's updated by dispatcher code with bpf_arch_text_poke=
,
> > but it's also visible and attachable to ftrace.. and will cause problem=
s
> > when these 2 updates will race
> >
> > question was if DEFINE_BPF_DISPATCHER can be used in kernel module,
> > which would bring another realm of problems ;-)
> >
>
> Oh, now I follow. AFAIK there is only one flavor of BPF dispatcher in
> use, and that's the XDP dispatcher, which does not reside in module
> code, but is typically *called* by module code.
>

Some history why the EXPORT is required:
https://lore.kernel.org/bpf/CAADnVQ+eD-=3DFZrg8L+YcdCyAS+E30W=3DZ-ShtEXAXVF=
jmxV4usg@mail.gmail.com/
