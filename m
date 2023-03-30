Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC4536D1081
	for <lists+bpf@lfdr.de>; Thu, 30 Mar 2023 23:07:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbjC3VHq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 30 Mar 2023 17:07:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjC3VHp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 30 Mar 2023 17:07:45 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35C7DD51E
        for <bpf@vger.kernel.org>; Thu, 30 Mar 2023 14:07:43 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id er13so40771761edb.9
        for <bpf@vger.kernel.org>; Thu, 30 Mar 2023 14:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680210461;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zSx9PvMhmvzLcQqJ7QOmAjp5Bx1EivO/8KKgVUMZJN8=;
        b=fZtYUEvVbaRH3fbLkxFMUAJYHdbP2hjYa1ZMFsnxu+HPL48vus5fyIKY6KYmonz1RS
         p+6m45PYfNmgK+HxKfNRe9BaHN39SagCuojUeM9cwSZT7TEGLs6OhzpdrNsn2iHcBVdD
         WNmnBPPQDeUpQ8tyYC4/NJVwAJ0qsVgxcMaO1gtE4rgFPuRA+gMRKkfYLE+o7RUvRi88
         lxBbVaPBhxChxkQO8qzhRgA6GaKgz40AQwXguhusajdqkun56tFI/GmuAfWf+pM/X/rM
         BuL2GQpQAPzVWeMizC1tDCxtRPW6CxqwSuf0u7rigsT0E4u/nCnhG9QDtGtDTCVeKdil
         Vrxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680210461;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zSx9PvMhmvzLcQqJ7QOmAjp5Bx1EivO/8KKgVUMZJN8=;
        b=r56mQaRJIbyZRyNPDZCV8SulFOCYnzauCRpATYujZ7Drx1FZjR272eNmRyIFZm/+TM
         x11FcZHusIJorGChOgpTLARNhayrxfHG8aHBhUYASLmO+/SXyPvj/PrSxiAauvy+qsGO
         LthxqaDG0P9/ZIV+GBxlhS/ifC4C+wEHWvtjYR2IzPln1dBsOXjfaHX/IQcWXfKbkaQU
         n05pKZyi6qZU5cd0ey3qGH+gPCYBaJq4lqd5RXrb/2LQdLhA7G7gY/v0AewP2u83MMnE
         FKFukwyO1h6n8A6kvVEYIw2IGTJVv+X+VDsthhYlGAou2EYy5qKMOugXzIt1+mjETF28
         HoYg==
X-Gm-Message-State: AAQBX9dACuALwB6ru/6iwYe+Ual2H6Zq101N4T2vVmAyRHRKwlu/CSbM
        UaGkXjh1CX5dijeXmwTnPjBooeqQsBYBc29kURZEE8wT
X-Google-Smtp-Source: AKy350bkGwUnoiyan1lTfW4HmSwMCdSNV+j//NG3s+m4rGLE2qEU/Wad1FEuz8NyeZFiRGnVJuHn90qPl8t3mPmZRHc=
X-Received: by 2002:a17:907:8688:b0:931:c1a:b526 with SMTP id
 qa8-20020a170907868800b009310c1ab526mr12634283ejc.5.1680210461562; Thu, 30
 Mar 2023 14:07:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230328235610.3159943-1-andrii@kernel.org> <20230328235610.3159943-8-andrii@kernel.org>
 <CAN+4W8ju8Bdqe59QXbX+eQWARfiy2-zqgkD5N0rMpmRn9-W4Vg@mail.gmail.com>
In-Reply-To: <CAN+4W8ju8Bdqe59QXbX+eQWARfiy2-zqgkD5N0rMpmRn9-W4Vg@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 30 Mar 2023 14:07:29 -0700
Message-ID: <CAEf4BzYwW1eswz_H0NDm9s=TxLTgkPsgTMp28XOrmsrbnXWkVg@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 6/6] selftests/bpf: add fixed vs rotating
 verifier log tests
To:     Lorenz Bauer <lmb@isovalent.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org,
        timo@incline.eu, robin.goegge@isovalent.com, kernel-team@meta.com
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

On Thu, Mar 30, 2023 at 10:13=E2=80=AFAM Lorenz Bauer <lmb@isovalent.com> w=
rote:
>
> On Wed, Mar 29, 2023 at 12:56=E2=80=AFAM Andrii Nakryiko <andrii@kernel.o=
rg> wrote:
> >
> > Add selftests validating BPF_LOG_FIXED behavior, which used to be the
> > only behavior, and now default rotating BPF verifier log, which returns
> > just up to last N bytes of full verifier log, instead of returning
> > -ENOSPC.
> >
> > To stress test correctness of in-kernel verifier log logic, we force it
> > to truncate program's verifier log to all lengths from 1 all the way to
> > its full size (about 450 bytes today). This was a useful stress test
> > while developing the feature.
> >
> > For both fixed and rotating log modes we expect -ENOSPC if log contents
> > doesn't fit in user-supplied log buffer.
> >
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
>
> Acked-by: Lorenz Bauer <lmb@isovalent.com>
>
> > +       /* validate BPF_LOG_FIXED works as verifier log used to work, t=
hat is:
> > +        * we get -ENOSPC and beginning of the full verifier log. This =
only
> > +        * works for log_level 2 and log_level 1 + failed program. For =
log
> > +        * level 2 we don't reset log at all. For log_level 1 + failed =
program
> > +        * we don't get to verification stats output. With log level 1
> > +        * for successful program  final result will be just verifier s=
tats.
> > +        * But if provided too short log buf, kernel will NULL-out log-=
>ubuf
>
> Out of curiousity: why is ubuf NULLed? Is that something we could change?

This is internal kernel implementation detail. That's how the verifier
signals that there was an error during copy_to_user(). This is
behavior not observable from user space at all. Why would you like to
change that? bpf_attr's log_buf field will never be NULLed out, if
that's what you are worried about.
