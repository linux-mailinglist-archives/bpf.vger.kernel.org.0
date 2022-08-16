Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 535F0596299
	for <lists+bpf@lfdr.de>; Tue, 16 Aug 2022 20:43:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbiHPSnh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 16 Aug 2022 14:43:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbiHPSnf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 16 Aug 2022 14:43:35 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7951C3E740;
        Tue, 16 Aug 2022 11:43:33 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id w19so20554507ejc.7;
        Tue, 16 Aug 2022 11:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=yQWG7sKT2Uen8rzdA1mC2Uo2cud8idBiqHtSktdA1VE=;
        b=H9ytmLLC2Z/VjUGyknflBQCcmCyIPHBwPgVWog76UI54CbOEppag3XLg3PODkOVm0R
         9RJIFPYHDsl2FPK3o/yhQOEI7cT3bkkRMkX1QN0szUYj6pTE9apauvWeSsm2dPEKHhNn
         yySsEkn5dbswu2SaAgjqN7h3b4AFzm9lCJ4M0MbjRk7vPL0ALVV3EUWPvHZASVYmM4oy
         e909uTv96BEoJSxQQWec0q8O/eDid6VO8gUS9bqH3YzlRX3sgdFQ1d26zIWwhLHMI6jZ
         6A7sqb6Fvyy9ZgIKlcG3VFBYCkoIsvgENQ9WT9R+mNKKd1pbYLH5aSIaQZDoDZw0z0dF
         g4EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=yQWG7sKT2Uen8rzdA1mC2Uo2cud8idBiqHtSktdA1VE=;
        b=QEmDSCF23/rkhvYAF+TpwwpH0T+DOG+ABImpEtK7+LiwPgSpf2i700orqvyEPkpopp
         w1UaWaL8YXRlHfyiQdzp+9/F9fM73ro7UGlu+7TLvyWJuBkbwU4I5uVh9NGdbfQGwQd1
         th9Fm4QdpA46+u501h8GV4eMCaxGB0WbeLXdRD1UBGNDQX6NBcJe+uuRntxR2TYSmRP2
         qJl6y3sjOzp+03JnM0gIg1vLYuECD1+vXIN09uWqstJGC1GCxgZm+3vY6rK/GLIPGcuU
         OBPFqNdvHjsq9LF3PZ9j4oiVUGivV3+VELFUDH6UgBfHCm09A98WltPk81B+AsfQBcP3
         ga8Q==
X-Gm-Message-State: ACgBeo36JGElfQyjpL1Tq0X/6g9duhYXZkhR6Wya+OflAHE3r7yoAwmT
        94TZa+rW+0GhCyD5XyJN0U/IqL01sM1WB6YbXys=
X-Google-Smtp-Source: AA6agR7VC/496F2luzhC4SqPTB+9nbxrFXQIyVJEDaQasOM6gbZq3tgYrg+fX+RRCEzQkwZHVMrcvQkOry60vRkpQwo=
X-Received: by 2002:a17:907:1611:b0:733:636:5686 with SMTP id
 hb17-20020a170907161100b0073306365686mr14527545ejc.226.1660675411880; Tue, 16
 Aug 2022 11:43:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220808155341.2479054-1-void@manifault.com> <20220808155341.2479054-2-void@manifault.com>
 <CAEf4BzZdOQwym4Q2QXtWF9uKhtKEb8cya-eQvLU3h3+7wES8UA@mail.gmail.com> <YvZ+fHcKUnUk8jhc@maniforge.dhcp.thefacebook.com>
In-Reply-To: <YvZ+fHcKUnUk8jhc@maniforge.dhcp.thefacebook.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 16 Aug 2022 11:43:20 -0700
Message-ID: <CAEf4Bzb5Mjw9xhn+qkTmyKqyAKp9g217UCXdAZhupwnxJoOzxQ@mail.gmail.com>
Subject: Re: [PATCH 2/5] bpf: Define new BPF_MAP_TYPE_USER_RINGBUF map type
To:     David Vernet <void@manifault.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, john.fastabend@gmail.com, martin.lau@linux.dev,
        song@kernel.org, yhs@fb.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, tj@kernel.org,
        joannelkoong@gmail.com, linux-kernel@vger.kernel.org,
        Kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Aug 12, 2022 at 9:23 AM David Vernet <void@manifault.com> wrote:
>
> On Thu, Aug 11, 2022 at 04:29:02PM -0700, Andrii Nakryiko wrote:
>
> [...]
>
> > > -       /* Consumer and producer counters are put into separate pages to allow
> > > -        * mapping consumer page as r/w, but restrict producer page to r/o.
> > > -        * This protects producer position from being modified by user-space
> > > -        * application and ruining in-kernel position tracking.
> > > +       /* Consumer and producer counters are put into separate pages to
> > > +        * allow each position to be mapped with different permissions.
> > > +        * This prevents a user-space application from modifying the
> > > +        * position and ruining in-kernel tracking. The permissions of the
> > > +        * pages depend on who is producing samples: user-space or the
> > > +        * kernel.
> > > +        *
> > > +        * Kernel-producer
> > > +        * ---------------
> > > +        * The producer position and data pages are mapped as r/o in
> > > +        * userspace. For this approach, bits in the header of samples are
> > > +        * used to signal to user-space, and to other producers, whether a
> > > +        * sample is currently being written.
> > > +        *
> > > +        * User-space producer
> > > +        * -------------------
> > > +        * Only the page containing the consumer position, and whether the
> > > +        * ringbuffer is currently being consumed via a 'busy' bit, are
> > > +        * mapped r/o in user-space. Sample headers may not be used to
> > > +        * communicate any information between kernel consumers, as a
> > > +        * user-space application could modify its contents at any time.
> > >          */
> > > -       unsigned long consumer_pos __aligned(PAGE_SIZE);
> > > +       struct {
> > > +               unsigned long consumer_pos;
> > > +               atomic_t busy;
> >
> > one more thing, why does busy have to be exposed into user-space
> > mapped memory at all? Can't it be just a private variable in
> > bpf_ringbuf?
>
> It could be moved elsewhere in the struct. I put it here to avoid
> increasing the size of struct bpf_ringbuf unnecessarily, as we had all of
> this extra space on the consumer_pos page. Specifically, I was trying to
> avoid taxing kernel-producer ringbuffers. If you'd prefer, I can just put
> it elsewhere in the struct.

Yes, let's move. 8 byte increase is not a problem, while exposing
internals into user-visible memory page is at the very least is
unclean.
