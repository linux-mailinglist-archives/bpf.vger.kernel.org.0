Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5797C5571C1
	for <lists+bpf@lfdr.de>; Thu, 23 Jun 2022 06:43:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230457AbiFWEkQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Jun 2022 00:40:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345163AbiFWEPf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Jun 2022 00:15:35 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60A2343AE1
        for <bpf@vger.kernel.org>; Wed, 22 Jun 2022 21:15:33 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id g26so17020324ejb.5
        for <bpf@vger.kernel.org>; Wed, 22 Jun 2022 21:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=78rZhP2i9bdPK9r2fiQ66uipcMHv7v9gQuH9nlkZQfs=;
        b=VDXIzg86qcVyLt22oZ+0yoKUVC+Z4f3km2+D2fqQALkkEY8jSfTkLuVHNq8UcAoPs5
         xKlHYFooBDXMQ2RTPp13uH9dYsHbs3siuXwz7S6iSfEWwuY1EdsQOUA4UYWvHJL+ysHG
         ANCTxVK4KUMXUHNXzU2OH7OFGY9mZv/lM4WcinIpzGKUSqpGmuNOnJNgZnaA5cukA0fk
         k6C1LUVJbNOGHQePZ6aV0PaVzNVx5mI1WqsxRpHEAgoWAJ7VOlseMBRxghDjKvsbhpGp
         J80IisvyptPOt7k+RlN2vVjkHXNUKiJjRsIst4ItPzcNELmVtAwU8sX1zLRn2abiIAvA
         2Mgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=78rZhP2i9bdPK9r2fiQ66uipcMHv7v9gQuH9nlkZQfs=;
        b=gbm6XCxIuKcTW5KDuW1+2YZ11dULd+YcT+Thn2bQkKF67wlqUilpyak20YD08kCpBE
         zjcdJY8H/piCTsg5IIXSTc8+wOgv4IjgPB4SSVuHyygTKG3LzLDExnMx+5P8rfcxNzlN
         zwXgpwItO+fyfaFleMsWnyfY7HbeXevTj7J44xaKo4XCBarANxmgAoQN6WRXZ6o881g3
         f+dl43G4iDCZGElnBBZBsqDalSs2RUezfgVVkOAKC3vkA+O9o1B9l1oeHNrmpfWx9vWe
         xWEJNnm/Y0vlS2IhwRXmbK0FPO9nptI5A0HuRv3SueW2BmHXUJWOzuJgRbYplJt9p2Km
         P/nQ==
X-Gm-Message-State: AJIora8R49djWuLQJ20Zrb4CKJvIEKF76gHyuMH890NLq48DXCiHAukf
        anfxdDQ223aYKcYQ2TPZAL/5pSSv32yhdVfSZS0=
X-Google-Smtp-Source: AGRyM1u1il2vGOhWAbXxsTaGJ8DVyz2kuL+dRfY7nzXa06HfF5hN8RHpVgyMjDhVhU7d6zqEAF3QdfbEVC5eN0lmub0=
X-Received: by 2002:a17:906:3f51:b0:712:3945:8c0d with SMTP id
 f17-20020a1709063f5100b0071239458c0dmr6214859ejj.302.1655957732001; Wed, 22
 Jun 2022 21:15:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220622173506.860578-1-deso@posteo.net> <20220622173506.860578-2-deso@posteo.net>
 <20220622221921.q65wjyirsaqhvg4h@muellerd-fedora-MJ0AC3F3>
In-Reply-To: <20220622221921.q65wjyirsaqhvg4h@muellerd-fedora-MJ0AC3F3>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 22 Jun 2022 21:15:20 -0700
Message-ID: <CAEf4BzZqBvvzY8qrgmddkPPXeSeEqi73jh_O-LwHyQ4LCTP-7w@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] libbpf: Move core "types_are_compat" logic
 into relo_core.c
To:     =?UTF-8?Q?Daniel_M=C3=BCller?= <deso@posteo.net>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
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

On Wed, Jun 22, 2022 at 3:19 PM Daniel M=C3=BCller <deso@posteo.net> wrote:
>
> On Wed, Jun 22, 2022 at 05:35:05PM +0000, Daniel M=C3=BCller wrote:
> > diff --git a/tools/lib/bpf/relo_core.c b/tools/lib/bpf/relo_core.c
> > index 6ad3c3..e54370 100644
> > --- a/tools/lib/bpf/relo_core.c
> > +++ b/tools/lib/bpf/relo_core.c
> > @@ -141,6 +141,84 @@ static bool core_relo_is_enumval_based(enum bpf_co=
re_relo_kind kind)
> >       }
> >  }
> >
> > +int bpf_core_types_are_compat_recur(const struct btf *local_btf, __u32=
 local_id,
> > +                                 const struct btf *targ_btf, __u32 tar=
g_id, int level)
> > +{
>
> [...]
>
> > +
> > +             /* tail recurse for return type check */
> > +             skip_mods_and_typedefs(local_btf, local_type->type, &loca=
l_id);
> > +             skip_mods_and_typedefs(targ_btf, targ_type->type, &targ_i=
d);
> > +             goto recur;
> > +     }
> > +     default:
> > +             return 0;
>
> I actually left out the pr_warn here (present in libbpf but not the kerne=
l). I
> suppose it would be best to carry it over from libbpf?

Yes, please.


>
> Thanks,
> Daniel
