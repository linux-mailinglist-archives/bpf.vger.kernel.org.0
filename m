Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84DAB636928
	for <lists+bpf@lfdr.de>; Wed, 23 Nov 2022 19:44:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239413AbiKWSna (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 23 Nov 2022 13:43:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235978AbiKWSn3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 23 Nov 2022 13:43:29 -0500
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B4B22F643
        for <bpf@vger.kernel.org>; Wed, 23 Nov 2022 10:43:27 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id n186so19935885oih.7
        for <bpf@vger.kernel.org>; Wed, 23 Nov 2022 10:43:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Irgo3YjKXzoeD31Az+GVGwZOn12NdR2LQJ0FUiLokw=;
        b=ZSB9LJVj4rfiHsPpPOayipyYq29mmRQDF5rr0RqYa2oq3KzQxLsBdtzlpVaGZ1hmaa
         i9kKbgFg/RdbDib3k6NQst5uRRoHDJPZeZRV1n7y8pGe1YLIKDRKjXSJV8jKUpvKCq7b
         yv4NH2mBtfrDvknBMa1rbcMF6qx3U1RDuJKpc+pzydUCqYHzbRp6qmPC1G1In1kj8eme
         X9ObmmkI75VjD8aFFhur0ArCwGfsKmYcf5HK0YUE8N5acqdrf59lwY5j35ZTor0/3/ao
         wQ7+e28doqOyH3f8cZgRD9FaZRFUpkGjDmTj5X254kD2Cz5otlA/9S990V+Snl2KyvJR
         8BeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Irgo3YjKXzoeD31Az+GVGwZOn12NdR2LQJ0FUiLokw=;
        b=SCf2Hnq1FIalO1tyqy/MJ0XVgehfrWrMwyfh4SzwsLvRkHwSp9fwpzkuLRfUlir/Mt
         A8SMP0OH0mw1QfgWAv899P4LgVuqXBUTqG7BG07pGESTHq6BGNwdZZONcpSCzpdAhOOK
         nTJ26925C8dSOOyevhloqV6lx+ygyJh+6xkrPcaRgKZWpyoXOYsEuje/NPR5zVFoR0zw
         GcK/JslHuu0ZH83/mI0xN0tsrw/SBr+ukqRizgfXsKDK9qdve2dbPCZok84rcBVp5Z/Q
         KRAhI6WGQhPBzkPRppygoBLCUIFOUXO3rFFzlgNm2PtlcrQtWSGZp64NEvQDXhLYUCuS
         AnFQ==
X-Gm-Message-State: ANoB5pkgE9vl5MHG5MNDVsHkM+E2NbRy0HR/yaPHFlVeDiqHU5zFbUVr
        BWYURDA8FiGWrNFH+ozmhFLZbQGYX9EJYdQJL+xzzQ==
X-Google-Smtp-Source: AA0mqf5ItMcroMxXTwrst2RomLCDDcyBnhT32jbFeF4Um49IzchyNfvbVdUyw3x+FIEEGVjePAqgvYqbQJc/QXE3ztk=
X-Received: by 2002:a05:6808:f09:b0:354:8922:4a1a with SMTP id
 m9-20020a0568080f0900b0035489224a1amr4538359oiw.181.1669229006872; Wed, 23
 Nov 2022 10:43:26 -0800 (PST)
MIME-Version: 1.0
References: <20221121182552.2152891-1-sdf@google.com> <20221121182552.2152891-3-sdf@google.com>
 <87a64hvje0.fsf@toke.dk>
In-Reply-To: <87a64hvje0.fsf@toke.dk>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Wed, 23 Nov 2022 10:43:16 -0800
Message-ID: <CAKH8qBv=E9dY+pOtrsN+UK1C=rQm=8Awgyr8G8mHMM9tGC_pEg@mail.gmail.com>
Subject: Re: [xdp-hints] [PATCH bpf-next v2 2/8] bpf: XDP metadata RX kfuncs
To:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        haoluo@google.com, jolsa@kernel.org,
        David Ahern <dsahern@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Willem de Bruijn <willemb@google.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Anatoly Burakov <anatoly.burakov@intel.com>,
        Alexander Lobakin <alexandr.lobakin@intel.com>,
        Magnus Karlsson <magnus.karlsson@gmail.com>,
        Maryam Tahhan <mtahhan@redhat.com>, xdp-hints@xdp-project.net,
        netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Nov 23, 2022 at 6:24 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@redh=
at.com> wrote:
>
> >  static int fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_i=
nsn *insn,
> >                           struct bpf_insn *insn_buf, int insn_idx, int =
*cnt)
> >  {
> > @@ -15181,6 +15200,15 @@ static int fixup_kfunc_call(struct bpf_verifie=
r_env *env, struct bpf_insn *insn,
> >               return -EINVAL;
> >       }
> >
> > +     if (resolve_prog_type(env->prog) =3D=3D BPF_PROG_TYPE_XDP) {
> > +             int imm =3D fixup_xdp_kfunc_call(env, insn->imm);
> > +
> > +             if (imm) {
> > +                     insn->imm =3D imm;
> > +                     return 0;
>
> This needs to also set *cnt =3D 0 before returning; otherwise the verifie=
r
> can do some really weird instruction rewriting that leads to the JIT
> barfing on invalid instructions (as I just found out while trying to
> test this).

Oops, that was me not paying too much attention during the merge..
Yonghong actually did some kfunc unrolling, yay :-)
