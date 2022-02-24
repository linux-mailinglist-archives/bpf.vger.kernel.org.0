Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AE174C3465
	for <lists+bpf@lfdr.de>; Thu, 24 Feb 2022 19:14:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231826AbiBXSNu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 24 Feb 2022 13:13:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbiBXSNt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 24 Feb 2022 13:13:49 -0500
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D79A2223108;
        Thu, 24 Feb 2022 10:13:18 -0800 (PST)
Received: by mail-lf1-f41.google.com with SMTP id d23so5250046lfv.13;
        Thu, 24 Feb 2022 10:13:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jeGCsvgLf6lDIaUf9nSWr2xBU0ddXBX+76rMpizQ4kk=;
        b=ZKLa4bhzoK0aYAb1rCwPdNTMAlrjQ+ciN6pMoz90knLrCWRTkQSSGBL6plkkDH8Ckd
         sCBAE8OdOERBn/AN89CsQmGtt1cO95KkPxILz14d+LEW2Los4ufrFP0/OjRt/OknXts8
         B14IWeD09kWTOqxEYqhmpUpVTj7dyezWy8yMdsr3VW69xIOsnyvLBhoNSCSdl4dbMwgM
         o57xoNSD2x9XE4+MksNDFMLGSfXlFywxGmF9hRWRvrOFj+Kv2XVUyZ36U5rj6UzfssVA
         GbU+b6TItkmFT1VwTuYmRnqcABu9QmYXSBK5ekkLvrKxlLhIksB8Oe68cpWLhQTa19m9
         4a/g==
X-Gm-Message-State: AOAM532+uZLKhnyofrM068Rjc5n83kamvHxJQda1kE7FF+bjMW1neSoF
        +QP6sLQUzXBgkgcoLArH+4CmXSb+L95HI5l95bEnDs+I
X-Google-Smtp-Source: ABdhPJxekjZAOq28/vw9kIHAlAdiwhXyXAhBOqWsyiLgH7Ks9EUYfmOgidFOaFQKOXVyjJuNg6YoPhLKOCBisL0Iie8=
X-Received: by 2002:ac2:5f90:0:b0:42f:b094:d72f with SMTP id
 r16-20020ac25f90000000b0042fb094d72fmr2436044lfe.586.1645726396659; Thu, 24
 Feb 2022 10:13:16 -0800 (PST)
MIME-Version: 1.0
References: <20220224000531.1265030-1-haoluo@google.com> <CAPhsuW6BqEn8azap_zcWq0Zkvv8mRFg6g0UX2fPQXwzT+F6V=A@mail.gmail.com>
In-Reply-To: <CAPhsuW6BqEn8azap_zcWq0Zkvv8mRFg6g0UX2fPQXwzT+F6V=A@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 24 Feb 2022 10:13:05 -0800
Message-ID: <CAM9d7cjv1FnJ6ggq70uecWLAP4eQzzsaaEtMT68C9Nva5eMH+g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] bpf: Cache the last valid build_id.
To:     Song Liu <song@kernel.org>
Cc:     Hao Luo <haoluo@google.com>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Blake Jones <blakejones@google.com>, bpf <bpf@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Greg Thelen <gthelen@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello,

On Wed, Feb 23, 2022 at 6:31 PM Song Liu <song@kernel.org> wrote:
>
> On Wed, Feb 23, 2022 at 4:05 PM Hao Luo <haoluo@google.com> wrote:
> >
> > For binaries that are statically linked, consecutive stack frames are
> > likely to be in the same VMA and therefore have the same build id.
> > As an optimization for this case, we can cache the previous frame's
> > VMA, if the new frame has the same VMA as the previous one, reuse the
> > previous one's build id. We are holding the MM locks as reader across
> > the entire loop, so we don't need to worry about VMA going away.
> >
> > Tested through "stacktrace_build_id" and "stacktrace_build_id_nmi" in
> > test_progs.
> >
> > Suggested-by: Greg Thelen <gthelen@google.com>
> > Signed-off-by: Hao Luo <haoluo@google.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung
