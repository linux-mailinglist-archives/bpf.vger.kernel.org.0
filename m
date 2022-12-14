Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C97464CFA4
	for <lists+bpf@lfdr.de>; Wed, 14 Dec 2022 19:43:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238799AbiLNSn2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 14 Dec 2022 13:43:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238906AbiLNSnZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 14 Dec 2022 13:43:25 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EE9A2A722
        for <bpf@vger.kernel.org>; Wed, 14 Dec 2022 10:43:24 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id d3so4254407plr.10
        for <bpf@vger.kernel.org>; Wed, 14 Dec 2022 10:43:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tx/7Mp216A8Qn4MkEs5zUckwv8OVRFxV4QjTqd0INQg=;
        b=CbiNyqGXokWCN2cL1BOpasVzCtFhN251ShygUXi1pjW60rmJV0xCo+ACkgks+YLi8l
         VBXh+yBRWyyqu/+n/cj8CozSOPhPvAcJO6KkMfn+gpp+Pxd9jWhG2jTrqgqIkAr+htSn
         WK924z9B506T1W61fcdCtkZKlddt9Y/U5D8VCQ9prr39kGGHTHrzKMGkf/ZbVT0f3h1t
         bUbo9UFRAHmMkQzYSqHIR8bgTga86TPX7Rz9J/4IK6uq6l7jdn8zy9FNcsb5nC3lhgyq
         8yjG17F12/RvNseOk8HpMHECJBjDtyfY50XnoLEPSjto0patR9nDJaN5h97ooovo7PiD
         OHoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tx/7Mp216A8Qn4MkEs5zUckwv8OVRFxV4QjTqd0INQg=;
        b=7M7LHVtKd+PTnmqB8nRQVPuJSy6g4GGay4QzcO/zZ8korP3eg6Yn8DegCA8PsdmKLo
         kcFhA4BijoG7MbtDvrDNBIKKywzFw0R5kCi41g/cQUqBz3Nxa5yWOMMMyUjOiwuPbBFW
         IwK+mk3m0j/OkZXlS9qgFTYCLI44zelHqpMuDBwxbVW4iHuHTNp8wLoAm534/BunDPgR
         7pUV0M5GKuj+TeEYhmDtc38ZHO/lx31dhH3C5jTgld4t3StSvklTnuhZY2aMaBDzQNfn
         l3DuI70WKLAxp5U71a1ZFt4XMBGvG9a3dhYzZS49Z9JRFUJUIcmEBTRBbnnuMfx4HSxd
         pjWA==
X-Gm-Message-State: AFqh2kr3jhGc+Pmj5p2NexJt4PLLKu/2YH44xMWG/xKM4l7qF7hbGIEa
        4Ffm/2EsHYkRX3uT0d1XamkJ/c+F+NKaWiKtJN3Vdw==
X-Google-Smtp-Source: AMrXdXvV8RpCmYV9v26ONL+pUVX8We2euBkV5+QFga91DzGAQW2UtthS9Px0f7kaA/qqn9tRNMowjHwWmevy1HbYgNQ=
X-Received: by 2002:a17:90a:b386:b0:219:fbc:a088 with SMTP id
 e6-20020a17090ab38600b002190fbca088mr498018pjr.162.1671043403879; Wed, 14 Dec
 2022 10:43:23 -0800 (PST)
MIME-Version: 1.0
References: <20221213023605.737383-1-sdf@google.com> <20221213023605.737383-6-sdf@google.com>
 <877cyugsrb.fsf@toke.dk>
In-Reply-To: <877cyugsrb.fsf@toke.dk>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Wed, 14 Dec 2022 10:43:12 -0800
Message-ID: <CAKH8qBtcmELXh9pHedkmEDTkPJRVNNs3ES218+npC3oYcNpN=Q@mail.gmail.com>
Subject: Re: [xdp-hints] [PATCH bpf-next v4 05/15] bpf: XDP metadata RX kfuncs
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

On Wed, Dec 14, 2022 at 2:54 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@redh=
at.com> wrote:
>
> Stanislav Fomichev <sdf@google.com> writes:
>
> [..]
>
> > diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> > index d434a994ee04..c3e501e3e39c 100644
> > --- a/kernel/bpf/core.c
> > +++ b/kernel/bpf/core.c
> > @@ -2097,6 +2097,13 @@ bool bpf_prog_map_compatible(struct bpf_map *map=
,
> >       if (fp->kprobe_override)
> >               return false;
> >
> > +     /* When tail-calling from a non-dev-bound program to a dev-bound =
one,
> > +      * XDP metadata helpers should be disabled. Until it's implemente=
d,
> > +      * prohibit adding dev-bound programs to tail-call maps.
> > +      */
> > +     if (bpf_prog_is_dev_bound(fp->aux))
> > +             return false;
> > +
>
> nit: the comment is slightly inaccurate as the program running in a
> devmap/cpumap has nothing to do with tail calls. maybe replace it with:
>
> "XDP programs inserted into maps are not guaranteed to run on a
> particular netdev (and can run outside driver context entirely in the
> case of devmap and cpumap). Until device checks are implemented,
> prohibit adding dev-bound programs to program maps."

SG.

> Also, there needs to be a check in bpf_prog_test_run_xdp() to reject
> dev-bound programs there as well...

Ah, totally forgot about this part, thanks for reminding!

> -Toke
>
