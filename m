Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83E1F6F3422
	for <lists+bpf@lfdr.de>; Mon,  1 May 2023 18:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232938AbjEAQ5q (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 1 May 2023 12:57:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232801AbjEAQ4a (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 1 May 2023 12:56:30 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFA99212D
        for <bpf@vger.kernel.org>; Mon,  1 May 2023 09:55:35 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-63b50a02bffso1984620b3a.2
        for <bpf@vger.kernel.org>; Mon, 01 May 2023 09:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682960134; x=1685552134;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GvObmTxmA1xoDqQ63tZqURkJJh+4rn7+tSEiWXSmHyk=;
        b=18u8zdT4Kj92nt3sfNoyEOPqSXaMwvXhNV5TCPBfN2sdRkB4Al9/9N2tjcUEfyvkQE
         s+VnlQOD+J9lsKauI52uJ7jH5/0fhKuJK+5oOCE6qSQbjE6A8cZ/54xZp3wm6vDpPtcI
         UelqoLbNed6w/OINepVyLUkImZoOugWwo59ks+P/4sM2E8/oh4cBo6TlXpp3szPTjGo+
         IqqIHTavAz6URtiEUm/KYUQV9OghaxgbeUh1vrkn6T15CJC57LO5gCiHPkNvN4LO71hb
         FW0NDcxS24yMNIfSogPULEPeYH8KJURW2X7tb4ON6NCL6BkgzyFxPQFEqWGRKLY7hiBp
         NZsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682960134; x=1685552134;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GvObmTxmA1xoDqQ63tZqURkJJh+4rn7+tSEiWXSmHyk=;
        b=V1T2e9DpQ6/GtWFLa5Z8tUh5RTq2KEnSIK9qrhTCAFOS+gAGmU12GtiObIzHg2MDUA
         G1P/yLq6GsK6XfPeNXhZ/DkHLgv7M9ffgTnWA+iILs4cL9rSIN4lAYtfOtZD0zxaFkpk
         nYFm60C+qYvFWW59Y1ZldVEkGzaXxzLAIqyCTTuvbT1eLhxgT9102CMHF4+fxmPrbdFA
         7rBjE8nGIhlyI9BXltsiJGy/zxMyvj1SuNNZEvz3RWrAiPdbrS+VHfv+Zh7may+3oS4Y
         fPXOwhAzKd4bny/CGOOveuNzSxsPZd/pBhRCFzK4sLmDoXF+2juyRdEs7cw/QWzhtozI
         dDsw==
X-Gm-Message-State: AC+VfDzcgK2SOpasnwMOgzSQ85Gm2I1Xb9uLPuBhPJ+A+zzcuJzZDH52
        fici0ilooel1D3DnRPTH+XSEcaKmyav6zqPdJ3/Jog==
X-Google-Smtp-Source: ACHHUZ5AVyZtM0Y95H8zKNQlDf2mVhVLZ3gw5o9Zgs2Y96ogO7mLOXehOIQo00SeF3epng8jz+6P6V7Krw95xqGuCPI=
X-Received: by 2002:a17:903:182:b0:1a6:87e3:db50 with SMTP id
 z2-20020a170903018200b001a687e3db50mr18555338plg.1.1682960133786; Mon, 01 May
 2023 09:55:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230427200409.1785263-1-sdf@google.com> <20230427200409.1785263-2-sdf@google.com>
 <5ebd6775-2be4-76b3-d364-a4462663e32d@linux.dev>
In-Reply-To: <5ebd6775-2be4-76b3-d364-a4462663e32d@linux.dev>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Mon, 1 May 2023 09:55:22 -0700
Message-ID: <CAKH8qBv_CdoKy07_y5Umcxq_-K7_hcLj4jxaMmezhVnLviDgCg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/4] bpf: Don't EFAULT for {g,s}setsockopt
 with wrong optlen
To:     Martin KaFai Lau <martin.lau@linux.dev>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, haoluo@google.com, jolsa@kernel.org,
        Martin KaFai Lau <martin.lau@kernel.org>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Sun, Apr 30, 2023 at 10:52=E2=80=AFPM Martin KaFai Lau <martin.lau@linux=
.dev> wrote:
>
> On 4/27/23 1:04 PM, Stanislav Fomichev wrote:
> > @@ -1881,8 +1886,10 @@ int __cgroup_bpf_run_filter_getsockopt(struct so=
ck *sk, int level,
> >               .optname =3D optname,
> >               .current_task =3D current,
> >       };
> > +     int orig_optlen;
> >       int ret;
> >
> > +     orig_optlen =3D max_optlen;
>
> For getsockopt, when the kernel's getsockopt finished successfully (the
> following 'if (!retval)' case), how about also setting orig_optlen to the=
 kernel
> returned 'optlen'. For example, the user's orig_optlen is 8096 and the ke=
rnel
> returned optlen is 1024. If the bpf prog still sets the ctx.optlen to som=
ething
>  > PAGE_SIZE, -EFAULT will be returned.

Wouldn't it defeat the purpose? Or am I missing something?

ctx.optlen would still be 8096, not 1024, right (regardless of what
the kernel returns)?
So it would trigger EFAULT case which we try to avoid.
