Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 614156CACB3
	for <lists+bpf@lfdr.de>; Mon, 27 Mar 2023 20:06:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232578AbjC0SF7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Mar 2023 14:05:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232661AbjC0SFz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Mar 2023 14:05:55 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B17974487
        for <bpf@vger.kernel.org>; Mon, 27 Mar 2023 11:05:37 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id eh3so39632544edb.11
        for <bpf@vger.kernel.org>; Mon, 27 Mar 2023 11:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679940336;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3+5M7tID3otgQDnQ3YM6ma6+ah8gECbGCrRU3bnOn4M=;
        b=He+6vIgDntOWtKkfcbN665Miwf+kPZyQDO/X75AzpxyMp9fIEQlsNKCWpGByXqCtR3
         9++22kxQhkky1mAJyGHUiWtptny1Gt7mXyvaZ6HsCKq4AaE6Fo3U1yqGgH4q3KeZyAax
         Rr1QiknqtH4h2I4LXmMWlp6CIBCb2r0HkkG3V/clAmXe8ccirfnkatJyyuD1zSQbF9mC
         w9p1IJI6+z1EGssXguxO/Jn17cmjXlCeOORTbAtwIbGXS0BbDcSfx5g2lLxPxKrNYYtp
         fBc0TZOnEufGyepWdtUV4984EDXfGbVaH383EV9fbhwoxF6pAAARTysNzIU3ybQfnu2f
         d5lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679940336;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3+5M7tID3otgQDnQ3YM6ma6+ah8gECbGCrRU3bnOn4M=;
        b=CVDd37rABPf00UDvAbcuA1NwuSSW0XEPUdu3xK/pO2ZN7uw9TIqxVnrViHP4bh/XO5
         8oVGFOpsfV3kxBi9DexQBrOifRNcKL+q1oyfSgTK2xC51StMg4uw689kZK/qLKWQFAbT
         WspxX9GtanX/6IDXp6elNCXmv3FKtUvFfTtFhFta94lsPiON4cJET78S6ftE7+OqRhDJ
         f/5pgqD4jiuJjFYPcmORwvdUzFd43BycEh5bgd2EI1s91FGcZM92Pmp3QC221lDHycHG
         XV/sRkIPDl5JpEdJgz4/QBBZWwGIoa/dFcjvHmfJcx/BfqOxP3IU+csM6PRFEkyOzyOE
         iVvQ==
X-Gm-Message-State: AAQBX9fpT6CaqmDpJDYrXl5i6xSSdDORanChL/0hNH7l4OPuMpZMwoG9
        O1wTaLnTpC+kWj2ckBjLoPy0UvasSsMCUsQxrr8=
X-Google-Smtp-Source: AKy350bmhfyCZOJaAb7cbB/qe78QaZXHYx7S1ZUnwdLVQI2QKhVnivj6SXGBifW7XuZtvbeNbyr4OR5+piKN1evzhKc=
X-Received: by 2002:a17:907:8688:b0:931:c1a:b526 with SMTP id
 qa8-20020a170907868800b009310c1ab526mr6301692ejc.5.1679940335933; Mon, 27 Mar
 2023 11:05:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230324232745.3959567-1-andrii@kernel.org> <20230324232745.3959567-2-andrii@kernel.org>
 <ZB5j9Zcx1F6kSx6v@google.com>
In-Reply-To: <ZB5j9Zcx1F6kSx6v@google.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 27 Mar 2023 11:05:24 -0700
Message-ID: <CAEf4Bzai-E1YWfBzpCL=3m=MGM=vJb0c_7Y0n=tw_ZkN_vBrFw@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 1/3] libbpf: disassociate section handler on
 explicit bpf_program__set_type() call
To:     Stanislav Fomichev <sdf@google.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org,
        kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Mar 24, 2023 at 8:01=E2=80=AFPM Stanislav Fomichev <sdf@google.com>=
 wrote:
>
> On 03/24, Andrii Nakryiko wrote:
> > If user explicitly overrides programs's type with
> > bpf_program__set_type() API call, we need to disassociate whatever
> > SEC_DEF handler libbpf determined initially based on program's SEC()
> > definition, as it's not goind to be valid anymore and could lead to
> > crashes and/or confusing failures.
>
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> >   tools/lib/bpf/libbpf.c | 1 +
> >   1 file changed, 1 insertion(+)
>
> > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > index f6a071db5c6e..a34ebb6b8508 100644
> > --- a/tools/lib/bpf/libbpf.c
> > +++ b/tools/lib/bpf/libbpf.c
> > @@ -8465,6 +8465,7 @@ int bpf_program__set_type(struct bpf_program *pro=
g,
> > enum bpf_prog_type type)
> >               return libbpf_err(-EBUSY);
>
> >       prog->type =3D type;
> > +     prog->sec_def =3D NULL;
> >       return 0;
> >   }
>
> Surprisingly, but it breaks the following selftest:
>
> serial_test_bpf_obj_id:PASS:get-fd-by-notexist-prog-id 0 nsec
> serial_test_bpf_obj_id:PASS:get-fd-by-notexist-map-id 0 nsec
> serial_test_bpf_obj_id:PASS:get-fd-by-notexist-link-id 0 nsec
> serial_test_bpf_obj_id:FAIL:prog_attach prog #0, err -95
>    #17      bpf_obj_id:FAIL
>
> (saw in the bot, reproduced locally)
>

my bad for not testing thoroughly enough, will take a look at what's
going on, thanks!

> > --
> > 2.34.1
>
