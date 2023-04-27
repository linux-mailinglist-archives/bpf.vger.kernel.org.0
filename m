Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BAF16F0884
	for <lists+bpf@lfdr.de>; Thu, 27 Apr 2023 17:39:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244178AbjD0Pjg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Apr 2023 11:39:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243808AbjD0Pjf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Apr 2023 11:39:35 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26CA326BA;
        Thu, 27 Apr 2023 08:39:34 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2a7af0cb2e6so84718461fa.0;
        Thu, 27 Apr 2023 08:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682609972; x=1685201972;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mEPxF/PqJY0e08prvcD7fi9mWw6obNqy1gzFbUzR2po=;
        b=lRdZEz8tUvHufKvw/8Uy6P6MgnSrazF9xGwQG+eTE6NjUAkyFe82xh39kvYR5HsNk0
         CnVDf2oWFX6YAFyEC8DqrI89RFbAhSlEKV/EhMn4608IUqju5ns26IITZEJrcGipm2ol
         0EWhiiXtjfSYGOQ8MbyI4/K3nAUA3CWPoDX4RSaB1o+AZdelKIsUiIxvZR5GXxrridB8
         Yp6/hc5MPkkCNAWgueotIA45gRQyitJQX/POW7oJxcMuRo6OwJpT3ML0NH+9/55NwK0M
         IT0uiN7J8AUOZ+gf119TP2qNidB1sAnCnEF7beAORYWgPiW7VdFU4/1qocGf3BUiSPxY
         2eCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682609972; x=1685201972;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mEPxF/PqJY0e08prvcD7fi9mWw6obNqy1gzFbUzR2po=;
        b=iCl1/pygfm24nfV4yL8F5RgAH0wAmntERbF/5cDq9X2HUGZXiI+Mt1w88OMfm4v6iI
         RuVr4Onup00YieAiDKi1gHwbtu16oc/mg7lgJYo2+Mfceximvz1xHoaKkepphxf+bNd2
         /A95+MCiXYytRhofUC8WE6WboUBnZO0K7gddoJPDHS+3822iKfmtlwmulKvyG6/zNit4
         riwM8KhwTTkWs/dh60pHL20I9JbqvqJJB6bcJuFvr/NmxZlfX8ii9iCLqrlK2PGFHdBv
         krnWaLfMfQ9/q2P3x07BS7UOhK3f3+MPcIijDhS7mfslY5l4HTQ9qlmrdqm0+siNaVAv
         /VHQ==
X-Gm-Message-State: AC+VfDzOn994S6jngYDIYHoRrtB2gHDuH4ZPvdeeDQPuTyhSSULilz78
        1Fm02xwyCsezQNS8e+hg+WO5Kvff49AnEGItpdY=
X-Google-Smtp-Source: ACHHUZ4OADDpPg0FKf4M+BPdLzd4cYdkjKzL0CD+N4J6NSTjN7iwPQlTgwZkPGNP1cOiSANq58T4LQ9Giavo/OXJahk=
X-Received: by 2002:a2e:9815:0:b0:2a8:c8c5:c769 with SMTP id
 a21-20020a2e9815000000b002a8c8c5c769mr752009ljj.36.1682609972345; Thu, 27 Apr
 2023 08:39:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230417154737.12740-1-laoar.shao@gmail.com> <20230417154737.12740-6-laoar.shao@gmail.com>
 <20230427092628.21fd23e4@gandalf.local.home> <CALOAHbBX1C-eg93Hf3xPLsdsaBzoGn1pHh9jb3Z_-T-7HD60wA@mail.gmail.com>
 <20230427111842.2e40fe3c@gandalf.local.home> <CALOAHbDRSNvihv5n0jJpAsK3onezRRipO78RG3rAf3LGgkzYHg@mail.gmail.com>
 <20230427113602.0e49c0d1@gandalf.local.home>
In-Reply-To: <20230427113602.0e49c0d1@gandalf.local.home>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 27 Apr 2023 08:39:21 -0700
Message-ID: <CAADnVQLaBMtBoSY4ZMgeTU1T-rrU6vPSU+xg1HmQpWnnE84sNw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 5/6] bpf: Improve tracing recursion prevention mechanism
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Yafang Shao <laoar.shao@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        bpf <bpf@vger.kernel.org>, linux-trace-kernel@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
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

On Thu, Apr 27, 2023 at 8:36=E2=80=AFAM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> On Thu, 27 Apr 2023 23:23:31 +0800
> Yafang Shao <laoar.shao@gmail.com> wrote:
>
> > > But I thought you can run a bpf_prog from another bpf_prog. So you do=
n't
> > > want to prevent it. You need other logic to detect if it was not supp=
ose to
> > > recurs.
> > >
> >
> > If so, we have to keep the prog->active to prevent it, then I'm not
> > sure if it is worth adding test_recursion_*().
>
> I thought that the whole point of this exercise was because the
> migrate_disable() itself could be traced (or call something that can), an=
d
> that's outside of prog->active protection. Which the test_recursion_*()
> code was created for.

Not sure where did this come from.
migrate_enable/disable were added to deny list back in 2021.
