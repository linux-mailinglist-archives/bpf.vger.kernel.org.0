Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89C235913D3
	for <lists+bpf@lfdr.de>; Fri, 12 Aug 2022 18:23:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239304AbiHLQXd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 12 Aug 2022 12:23:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239305AbiHLQXa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 12 Aug 2022 12:23:30 -0400
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B28EBAE9DF;
        Fri, 12 Aug 2022 09:23:28 -0700 (PDT)
Received: by mail-qk1-f181.google.com with SMTP id m5so1147207qkk.1;
        Fri, 12 Aug 2022 09:23:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=bWlB4yJzlVgm2Y+PItz5RfsQXB1Bc3Sb4QZFJeft64o=;
        b=s3kU7QrB1rtf/4ky2DlubagE5QCGssZNoZidiVN7TclER0QFU2u8l9008f5dNfJclL
         d/9X7Tlvtsxhhc69Jck4ZH/SKq/aVnQz2s8aEyOLSQMpF2cBH85LJ76m3JS75dhA5qtM
         VS1CBxZaiiOd+lRmnhbTE6NIO4kuGGX4/PoLaDOrO1ZYa8ELqWQAoauZVN9EY6yu8sb2
         9+/sytaL31+HkoSsMGhHo/BW/ws5hjLAz8H2aL/3WDLmiKJc5mw3CJS0FuijBeMgUMiz
         nk7vVV888Lz36M/1d/k5FXJ1C2lYRccyS+D8H348pqML7e54yIhXRfo2Mr1a1aF49Rn+
         VLKQ==
X-Gm-Message-State: ACgBeo2n2l0fLnRCXYMAWyXjFCgpQVR/7ziBD/lvGOiaWcTpHUL/ZMhu
        QjxsH1tOu8dx27aQAyAgaPw=
X-Google-Smtp-Source: AA6agR5i1SbkC10FHr5uJ0FlZ+c7om/PSdKiG0ZOs47VEP+UM4S3MqgWCohzgdQrpALQVi3CuVpF2g==
X-Received: by 2002:a05:620a:d8c:b0:6a7:91a2:c827 with SMTP id q12-20020a05620a0d8c00b006a791a2c827mr3318533qkl.407.1660321407739;
        Fri, 12 Aug 2022 09:23:27 -0700 (PDT)
Received: from maniforge.dhcp.thefacebook.com ([2620:10d:c091:480::9c4])
        by smtp.gmail.com with ESMTPSA id l23-20020a37f917000000b006b97151d2b3sm2217123qkj.67.2022.08.12.09.23.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Aug 2022 09:23:27 -0700 (PDT)
Date:   Fri, 12 Aug 2022 11:23:24 -0500
From:   David Vernet <void@manifault.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, john.fastabend@gmail.com, martin.lau@linux.dev,
        song@kernel.org, yhs@fb.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, tj@kernel.org,
        joannelkoong@gmail.com, linux-kernel@vger.kernel.org,
        Kernel-team@fb.com
Subject: Re: [PATCH 2/5] bpf: Define new BPF_MAP_TYPE_USER_RINGBUF map type
Message-ID: <YvZ+fHcKUnUk8jhc@maniforge.dhcp.thefacebook.com>
References: <20220808155341.2479054-1-void@manifault.com>
 <20220808155341.2479054-2-void@manifault.com>
 <CAEf4BzZdOQwym4Q2QXtWF9uKhtKEb8cya-eQvLU3h3+7wES8UA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzZdOQwym4Q2QXtWF9uKhtKEb8cya-eQvLU3h3+7wES8UA@mail.gmail.com>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Aug 11, 2022 at 04:29:02PM -0700, Andrii Nakryiko wrote:

[...]

> > -       /* Consumer and producer counters are put into separate pages to allow
> > -        * mapping consumer page as r/w, but restrict producer page to r/o.
> > -        * This protects producer position from being modified by user-space
> > -        * application and ruining in-kernel position tracking.
> > +       /* Consumer and producer counters are put into separate pages to
> > +        * allow each position to be mapped with different permissions.
> > +        * This prevents a user-space application from modifying the
> > +        * position and ruining in-kernel tracking. The permissions of the
> > +        * pages depend on who is producing samples: user-space or the
> > +        * kernel.
> > +        *
> > +        * Kernel-producer
> > +        * ---------------
> > +        * The producer position and data pages are mapped as r/o in
> > +        * userspace. For this approach, bits in the header of samples are
> > +        * used to signal to user-space, and to other producers, whether a
> > +        * sample is currently being written.
> > +        *
> > +        * User-space producer
> > +        * -------------------
> > +        * Only the page containing the consumer position, and whether the
> > +        * ringbuffer is currently being consumed via a 'busy' bit, are
> > +        * mapped r/o in user-space. Sample headers may not be used to
> > +        * communicate any information between kernel consumers, as a
> > +        * user-space application could modify its contents at any time.
> >          */
> > -       unsigned long consumer_pos __aligned(PAGE_SIZE);
> > +       struct {
> > +               unsigned long consumer_pos;
> > +               atomic_t busy;
> 
> one more thing, why does busy have to be exposed into user-space
> mapped memory at all? Can't it be just a private variable in
> bpf_ringbuf?

It could be moved elsewhere in the struct. I put it here to avoid
increasing the size of struct bpf_ringbuf unnecessarily, as we had all of
this extra space on the consumer_pos page. Specifically, I was trying to
avoid taxing kernel-producer ringbuffers. If you'd prefer, I can just put
it elsewhere in the struct.
