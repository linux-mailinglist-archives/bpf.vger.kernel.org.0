Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EFD65320CF
	for <lists+bpf@lfdr.de>; Tue, 24 May 2022 04:15:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233230AbiEXCPj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 23 May 2022 22:15:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233244AbiEXCPi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 23 May 2022 22:15:38 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F23A99CF06
        for <bpf@vger.kernel.org>; Mon, 23 May 2022 19:15:36 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id m20so12561797wrb.13
        for <bpf@vger.kernel.org>; Mon, 23 May 2022 19:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hXs05ZiJX6K31VMr8pjy8iPTRqA/Y/9xrKe6XI1MlqE=;
        b=QxerUyGrhKctoODND+gwzSrimTs+MG6Rr+naxufPP+Dhu+tVWL4hzP/5+kQwX9L+uj
         iZxkx/TTmhbttwMC4SBnEsByy+ALazoAfOMdSz3Ex4g/ckql668B+0Sz0nC/2o7kCeRF
         lkYAmWnoTkE3TE74j/4t3gsGikYEOrwzInYK+ceVACROrVd7312YSYFg+eQ9SZEh4kQj
         QS884pU8AYqqs/G09MkScZry6kTHRTSA4YVtyHHG+8j1ycRqYzQIXsLxjdNe8zu4S86T
         +zdkP+AaVLdDngIbxBg2JzG4wvbJHK2Gs992AlPXogfscl3OVgsTlNEbNyV040i3w++R
         pG9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hXs05ZiJX6K31VMr8pjy8iPTRqA/Y/9xrKe6XI1MlqE=;
        b=qwl/6UgnUU1c+CV1M7DX8/NOtwbZ23Zn4MBHDj1EUk2O4WsifZ/LQsNmZYJjj4hRrI
         9MGItuN+gUcGgn10te+seUjInCUOYxyJMto672pcED3GdQOQP/dbbPunlhQqAWLzJnx+
         WCWzyYrYTFaMFBdpXdxyFiXneDXWhITrTa9Acwj1/y1UKL7+CikZk4gqm1qS5MYI9+hZ
         PiXHLQt/Qg6o7ThxlScjojeA/afWS7Ilx6b6b2I1OfcQXF/uVs6n8LEaO/PkOpV6Zmui
         bdKrxvYM08lcMVsrwULBXuft0FIAul2+9fIAhhYWndhYUiNQSvCwRimMioVFRRoeeOXg
         hH0A==
X-Gm-Message-State: AOAM533l9a6qlpMwPWgnpN2JmlWtRCyVlOuqEK29khRj1qxn9VcRZp/l
        VaIYPQM9QNoBauImCqc3US0qHDy1j45dlT8vQXbCwA==
X-Google-Smtp-Source: ABdhPJz3fkaCOL8fajAorMv0u0hdHoy1kA+j5eDIkLhhjFczLghSQsh8CFHDT+0l4QgBMxqdii+WNERwvxCcABcEWow=
X-Received: by 2002:adf:f9c7:0:b0:20d:1297:d909 with SMTP id
 w7-20020adff9c7000000b0020d1297d909mr20992937wrr.191.1653358535409; Mon, 23
 May 2022 19:15:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220518225531.558008-1-sdf@google.com> <20220518225531.558008-9-sdf@google.com>
 <CAEf4BzZEHfBbski189Qt2Lp4XOOxveRA07yjjPwVbpnQ-ggOew@mail.gmail.com>
In-Reply-To: <CAEf4BzZEHfBbski189Qt2Lp4XOOxveRA07yjjPwVbpnQ-ggOew@mail.gmail.com>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Mon, 23 May 2022 19:15:24 -0700
Message-ID: <CAKH8qBtLBicn0y9bN3WEYAEHqYqoERzX3XtQU_nCrRh2FBmTmg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v7 08/11] libbpf: add lsm_cgoup_sock type
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

On Mon, May 23, 2022 at 4:26 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Wed, May 18, 2022 at 3:55 PM Stanislav Fomichev <sdf@google.com> wrote:
> >
> > lsm_cgroup/ is the prefix for BPF_LSM_CGROUP.
> >
> > Signed-off-by: Stanislav Fomichev <sdf@google.com>
> > ---
> >  tools/lib/bpf/libbpf.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > index ef7f302e542f..854449dcd072 100644
> > --- a/tools/lib/bpf/libbpf.c
> > +++ b/tools/lib/bpf/libbpf.c
> > @@ -9027,6 +9027,7 @@ static const struct bpf_sec_def section_defs[] = {
> >         SEC_DEF("fmod_ret.s+",          TRACING, BPF_MODIFY_RETURN, SEC_ATTACH_BTF | SEC_SLEEPABLE, attach_trace),
> >         SEC_DEF("fexit.s+",             TRACING, BPF_TRACE_FEXIT, SEC_ATTACH_BTF | SEC_SLEEPABLE, attach_trace),
> >         SEC_DEF("freplace+",            EXT, 0, SEC_ATTACH_BTF, attach_trace),
> > +       SEC_DEF("lsm_cgroup+",          LSM, BPF_LSM_CGROUP, SEC_ATTACH_BTF),
>
> we don't do simplistic prefix match anymore, so this doesn't have to
> go before lsm+ (we do prefix match only for legacy SEC_SLOPPY cases).
> So total nit (but wanted to dispel preconception that we need to avoid
> subprefix matches), I'd put this after lsm+

Sure, didn't know the ordering doesn't matter, will do, thanks!
