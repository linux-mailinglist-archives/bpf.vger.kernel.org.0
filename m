Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7413B6F088F
	for <lists+bpf@lfdr.de>; Thu, 27 Apr 2023 17:44:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243577AbjD0PoS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Apr 2023 11:44:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244053AbjD0PoP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Apr 2023 11:44:15 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 195562D79;
        Thu, 27 Apr 2023 08:44:14 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id af79cd13be357-74e4f839ae4so278062485a.0;
        Thu, 27 Apr 2023 08:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682610252; x=1685202252;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kHbAq1O9z0Wcn8EPpd+xHP4DyQMv3MaGeXxm3nCZwNY=;
        b=ITpfC+kb5HXI/KphoMSBMMYdDdKWv0mTqPLKVbQppwV1CacAEHP3eU3bsv86IigRku
         Y81tDPNoQaonec5bSWbN2Rlc9KBlhZ8ovOL5ptwG+Mcfh7JZcAmFTdDXLEpNztIDSpv6
         8QBm6UKb1sYV1PynVLyxpd9B34aO7PyID3888bRR/+hFFgximY+MmvF2trWC9fRcq5pN
         EGbfhqAZ37TNbaWG97C9QJXlKO9ihDH7a2TBmXTeNybbW1LZBrMM5eWuI092evcTT7nh
         DviiAATtFLwcvjbafZfK68FjjfLs3JEPw8/1rG28fnIR064L/VjWYtB9Unp97euzCghw
         nGCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682610252; x=1685202252;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kHbAq1O9z0Wcn8EPpd+xHP4DyQMv3MaGeXxm3nCZwNY=;
        b=dUXJdchO28/1Hm3m+ZU3RrCsumUBe4o6OBP4acXeP+1RXlJDNngKT5gSAW3WbAtpdE
         E26wGiB91A7QwbWWbyLLuq+bP/JZu1oyfqLx4RWdo6DU0QJoJSIZbL5Bt+4QmD8GMYJx
         2p3GTuddzXKrD+mMGjbcNQRIg6ilvwArnsWDMdE0dbLeYZL6Np/FFR+r6FepKafSB2QK
         oYjADbVxT1vUdqPJK+8VynraZ1HpNg4PB0XrUnXoj5VEfLGERHALIn37vCYVTt0FVTNC
         YCkaLuaHT9Kj8xwh1DB8yX5fZnmxX/OlaSF988q41o45mF/CtSgTqPXcEUO0CdDoTJNX
         2PHw==
X-Gm-Message-State: AC+VfDyzVjaiJLI/7AhS+qRvUznyTHQSaK4572GmmWRnR7SsPsFnvPnr
        Hgjyaqkq/eeqyZZyGOLJHYfh9eRd+32iD4n1+MOIpmGZx2E4Lw==
X-Google-Smtp-Source: ACHHUZ7VGygoieYEkehgwxL7Nf/soDd68XTcv+ZYPCEL6TiPEIuOu//8N0BojGP+QyyPanU3toYTPloQ3bUlWGO9Ukw=
X-Received: by 2002:ad4:5b85:0:b0:56e:a96b:a3a1 with SMTP id
 5-20020ad45b85000000b0056ea96ba3a1mr2702601qvp.7.1682610252270; Thu, 27 Apr
 2023 08:44:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230417154737.12740-1-laoar.shao@gmail.com> <20230417154737.12740-6-laoar.shao@gmail.com>
 <20230427092628.21fd23e4@gandalf.local.home> <CALOAHbBX1C-eg93Hf3xPLsdsaBzoGn1pHh9jb3Z_-T-7HD60wA@mail.gmail.com>
 <20230427111842.2e40fe3c@gandalf.local.home> <CALOAHbDRSNvihv5n0jJpAsK3onezRRipO78RG3rAf3LGgkzYHg@mail.gmail.com>
 <20230427113602.0e49c0d1@gandalf.local.home> <CAADnVQLaBMtBoSY4ZMgeTU1T-rrU6vPSU+xg1HmQpWnnE84sNw@mail.gmail.com>
In-Reply-To: <CAADnVQLaBMtBoSY4ZMgeTU1T-rrU6vPSU+xg1HmQpWnnE84sNw@mail.gmail.com>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Thu, 27 Apr 2023 23:43:35 +0800
Message-ID: <CALOAHbCvZP1-x7Uc39zUFgLdxxvZUVPY9Eh6bL2vjDx_BZSyug@mail.gmail.com>
Subject: Re: [PATCH bpf-next 5/6] bpf: Improve tracing recursion prevention mechanism
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
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

On Thu, Apr 27, 2023 at 11:39=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Apr 27, 2023 at 8:36=E2=80=AFAM Steven Rostedt <rostedt@goodmis.o=
rg> wrote:
> >
> > On Thu, 27 Apr 2023 23:23:31 +0800
> > Yafang Shao <laoar.shao@gmail.com> wrote:
> >
> > > > But I thought you can run a bpf_prog from another bpf_prog. So you =
don't
> > > > want to prevent it. You need other logic to detect if it was not su=
ppose to
> > > > recurs.
> > > >
> > >
> > > If so, we have to keep the prog->active to prevent it, then I'm not
> > > sure if it is worth adding test_recursion_*().
> >
> > I thought that the whole point of this exercise was because the
> > migrate_disable() itself could be traced (or call something that can), =
and
> > that's outside of prog->active protection. Which the test_recursion_*()
> > code was created for.
>
> Not sure where did this come from.
> migrate_enable/disable were added to deny list back in 2021.

Hi Alexei,

Don't be uneasy.  It is not good to play word games.
What Steven really meant is the preempt_count_{sub, add}.
Anyway thanks Steven for the help with this exercise.

--=20
Regards
Yafang
