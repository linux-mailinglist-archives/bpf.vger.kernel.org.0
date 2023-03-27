Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C22826CAD57
	for <lists+bpf@lfdr.de>; Mon, 27 Mar 2023 20:41:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232543AbjC0Slr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Mar 2023 14:41:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232642AbjC0Slm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Mar 2023 14:41:42 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DA253ABA
        for <bpf@vger.kernel.org>; Mon, 27 Mar 2023 11:41:21 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id x3so40033147edb.10
        for <bpf@vger.kernel.org>; Mon, 27 Mar 2023 11:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679942478;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qWSZF4EBJfDvco39Ebt39+UNRr0iRjTGiQcA1+TRSlA=;
        b=D2ttoNQl3mb7DbVO9U+CHGK1czYs0wf1QnLWkkm/AIqDiSwXUW2i2xblDYLR83TBcg
         dLJLKKUd/5stZlkqLU2ni1dHm3+pYRrljRNzzrYSbwCmC5GRPnliSIwWD2kUW+DrwjNa
         ezYtIhSAq9n5xnwXDOncKLLHP5dKQQc3pyJWkKXS+PkzUP6SVsnYdIiRoXidPk7o5uAN
         h8CZVsnkC1f7bJ5cqmxkvEvysQfcBWZfyBQiCPpCYCzbPawRUs6NheNqsCnfb2mrA/hV
         QoaLhMUP4Bti+UC+9U+gfVIVxqwVo+2/zWopJw2lFeaxyWDDSdhjX5fx5HRmNFfkummZ
         sXYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679942478;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qWSZF4EBJfDvco39Ebt39+UNRr0iRjTGiQcA1+TRSlA=;
        b=LkTbRCc07x98uE5n9KrFGB4v4s9eZnYTtLvjE2MU7BCfL+Xovl+4VhC7QVKntIm6Bc
         nJcgg7xnSvFnB6+yt5X/tXcTy0ks1Ptb/WG95Jz/5Ib/aRiTFauyEljQtDtxM/q7/oWg
         tMGsrR2ZLl5RmWe2NS7VCbqrHmN66mKHKCKk3WIaAfAExr4P09r/ViA4Gd9+MwnHARks
         z0fbUv57T97tHNva1LxRD3iJQ8HpWnwqIf4VWOSxLAl9LjVWTC/5is6fuCD1Hxtjqswi
         LHPsPGfe9KiL0UaYflB+VRJjofD9DrDuVPnjN48K1WF8Cmmknm8GEAH/ppQnln5E2WRn
         aH6w==
X-Gm-Message-State: AAQBX9eY3GN0ylowPGmnEFwA2EP+p8C9j49BODvkqATxcVfGDNc4Ffqm
        e1h8/afMO7fpVQLz+ktg9XdvXoQDbeW5u+sNQiQ=
X-Google-Smtp-Source: AKy350aA9c2pSA9ROtK/ariiSkCExYUp25I99YMHilIueScWnrrPpevjVgx0RfmSnw4C8MRW/f2TUFbZuoyrxoWoI20=
X-Received: by 2002:a50:a444:0:b0:4fc:6494:81c3 with SMTP id
 v4-20020a50a444000000b004fc649481c3mr6090227edb.1.1679942478569; Mon, 27 Mar
 2023 11:41:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230326095341.816023-1-hengqi.chen@gmail.com> <ZCHGLTMeT7089yBu@google.com>
In-Reply-To: <ZCHGLTMeT7089yBu@google.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 27 Mar 2023 11:41:06 -0700
Message-ID: <CAEf4BzasD+4c4Vsk1+T17jNSVChYtfme7c7t0URKNVPTWzj1uA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Don't assume page size is 4096
To:     Stanislav Fomichev <sdf@google.com>
Cc:     Hengqi Chen <hengqi.chen@gmail.com>, bpf@vger.kernel.org
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

On Mon, Mar 27, 2023 at 9:37=E2=80=AFAM Stanislav Fomichev <sdf@google.com>=
 wrote:
>
> On 03/26, Hengqi Chen wrote:
> > The verifier test creates BPF ringbuf maps using hard-coded
> > 4096 as max_entries. Some tests will fail if the page size
> > of the running kernel is not 4096. Use getpagesize() instead.
>
> > Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
>
> Can you share which platform that is? The fix seems ok, but
> I'm assuming that we have many more places where 4k is hardcoded :-)

We did have a bunch of fixes over time removing hard-coded page size
usage, so there should be fewer such places than you might think :)
But quick grepping for "4096" shows a bunch of matches. Not all of
them are page size, but it would indeed be good to audit.

For now, I applied this patch, as it is correct and helps. Thanks!

>
>
> > ---
> >   tools/testing/selftests/bpf/test_verifier.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
>
> > diff --git a/tools/testing/selftests/bpf/test_verifier.c
> > b/tools/testing/selftests/bpf/test_verifier.c
> > index 5b90eef09ade..e4657c5bc3f1 100644
> > --- a/tools/testing/selftests/bpf/test_verifier.c
> > +++ b/tools/testing/selftests/bpf/test_verifier.c
> > @@ -1079,7 +1079,7 @@ static void do_test_fixup(struct bpf_test *test,
> > enum bpf_prog_type prog_type,
> >       }
> >       if (*fixup_map_ringbuf) {
> >               map_fds[20] =3D create_map(BPF_MAP_TYPE_RINGBUF, 0,
> > -                                        0, 4096);
> > +                                      0, getpagesize());
> >               do {
> >                       prog[*fixup_map_ringbuf].imm =3D map_fds[20];
> >                       fixup_map_ringbuf++;
> > --
> > 2.31.1
