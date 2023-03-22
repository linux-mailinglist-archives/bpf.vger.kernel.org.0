Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 046386C5962
	for <lists+bpf@lfdr.de>; Wed, 22 Mar 2023 23:21:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229436AbjCVWVy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Mar 2023 18:21:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbjCVWVx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Mar 2023 18:21:53 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 499852201C
        for <bpf@vger.kernel.org>; Wed, 22 Mar 2023 15:21:52 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id w9so79096725edc.3
        for <bpf@vger.kernel.org>; Wed, 22 Mar 2023 15:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679523711;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+LG6MFSIFjL6qEDLicvDvhMOxvlECjuW9OqxbH766Lc=;
        b=kDX01DBvW9Sln+U6eX3aPbsfXaCJ2qqK+PPX6nuSSI2Zmrv1Vb0ZacyoSqZ1gAfJjk
         PWUrP7urijZpexEM9yqS1P4PGDsNI43Ml4JkUZ7ILLiQAnweboM9jw5rpgDiyD0ZcPul
         7w6CV62HXpm1blXpTICV3a5QMm2ENUYnpSdC9/9kPPog5yeZwjFhi9nltKWn+7X8iWoh
         +rh7IpQsbcEViIeK8ANnAVOwyQwqs5sSwvYMHbJuOqkfMz/sm3QhUJL6meZ6KAz9KkOn
         ycpIrz20794/K5viSi9kagvYc7B16Ad5zx/Gj8g35K2+QYoEVUaHFsg4ys78ibBjTCNZ
         a8Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679523711;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+LG6MFSIFjL6qEDLicvDvhMOxvlECjuW9OqxbH766Lc=;
        b=vWOD3hVKa6nYy4IoEi+fRfG7hSFGmsJeRBENZOacdx07qKEG+x7dqX3Rxtow/3hoAE
         0vjUCmoLh/OqpoOI00PeLyv73J6tjMF0VPWP/YfpiBApwyYe139eMuKaFLr1HQPBrgwE
         QsDpS0YtFjEUHy7djEvIGOaZioU7d8lDnQSSl2HDPzLDSqqgNyQKqMFARYgEA0pcgj3B
         yDqkRYkfXsmDF5VpFqovHsxsjIDT3ulAPZyOMRI2gCOlh2i/RjG985aaU/YDDtW8Ok2g
         nkcEFxL1NqPkR/y67zu+HoCwBqSCgSVALkD08pKkUFxvWc0W+gqUUb0pu1VXOU8vdN4R
         FBIg==
X-Gm-Message-State: AO0yUKUeUwpvJzzZGK8EqSGqbpJUVfmPEKFHjyajChVZ2ezr5ikH21jt
        HmVKln68dA/2hOlnaga5BmIkHikr9ouwBJX3fdhAoOLxdWw=
X-Google-Smtp-Source: AK7set+fdi0DgU1V7MzSCLyD9S4dCWW3pLAw8Q6gqeZwKv59WHzryeNmgUg4hyS938ameF7lrzvNeKzJ2AF8z1vYpXE=
X-Received: by 2002:a50:cd1d:0:b0:4fc:8749:cd77 with SMTP id
 z29-20020a50cd1d000000b004fc8749cd77mr4388624edi.3.1679523710529; Wed, 22 Mar
 2023 15:21:50 -0700 (PDT)
MIME-Version: 1.0
References: <CAMAi7A7+b6crWHyn9AQ+itsSh8vZ8D5=WEKatAaHj-V_4mjw-g@mail.gmail.com>
 <ZBo164Lc2eL3HUvN@krava> <CAMAi7A7Y=m=i-yEOuh-sO-5R5zEGQuo1VwOLKsgvFcv4RRhbhQ@mail.gmail.com>
 <ZBr7Jt9+yr0PHk6K@krava> <CAADnVQLCSMBhHzOgB1iYMpWVTYsKerMUJ_8MX1W+7BNveF+0tQ@mail.gmail.com>
 <CAMAi7A4asgEE7MKOJC7ak4Q-wWXtfnHTtv8+x0GZ88ZUWZLMKQ@mail.gmail.com>
In-Reply-To: <CAMAi7A4asgEE7MKOJC7ak4Q-wWXtfnHTtv8+x0GZ88ZUWZLMKQ@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 22 Mar 2023 15:21:39 -0700
Message-ID: <CAADnVQKxbzULYHhWUr=OQWke-QJt6QkVsO7pVBNpgurQMZPWkQ@mail.gmail.com>
Subject: Re: bpf: missed fentry/fexit invocations due to implicit recursion
To:     Davide Miola <davide.miola99@gmail.com>
Cc:     Jiri Olsa <olsajiri@gmail.com>, bpf <bpf@vger.kernel.org>
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

On Wed, Mar 22, 2023 at 2:39=E2=80=AFPM Davide Miola <davide.miola99@gmail.=
com> wrote:
>
> On Wed, 22 Mar 2023 at 17:06, Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> > On Wed, Mar 22, 2023 at 6:10=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> =
wrote:
> > >
> > > there was discussion about this some time ago:
> > >   https://lore.kernel.org/bpf/CAEf4BzZ-xe-zSjbBpKLHfQKPnTRTBMA2Eg382+=
_4kQoTLnj4eQ@mail.gmail.com/
> > >
> > > seems the 'active' problem andrii described fits to your case as well
> >
> > I suspect per-cpu recursion counter will miss more events in this case,
> > since _any_ kprobe on that cpu will be blocked.
> > If missing events is not an issue you probably want a per-cpu counter
> > that is specific to your single ip_queue_xmit attach point.
>
> The difference between the scenario described in the linked thread
> and mine is also the reason why I think in-bpf solutions like a
> per-cpu guard can't work here: my programs are recursing due to irqs
> interrupting them and invoking ip_queue_xmit, not because some helper
> I'm using ends up calling ip_queue_xmit. Recursion can happen
> anywhere in my programs, even before they get the chance to set a
> flag or increment a counter in a per-cpu map, since there is no
> atomic "bpf_map_lookup_and_increment" (or is there?)

__sync_fetch_and_add() is supported. A bunch of selftests are using it.
Or you can use bpf_spin_lock.
