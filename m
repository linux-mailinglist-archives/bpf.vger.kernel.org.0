Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAEF4640ED5
	for <lists+bpf@lfdr.de>; Fri,  2 Dec 2022 21:01:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234215AbiLBUBZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 2 Dec 2022 15:01:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234244AbiLBUBY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 2 Dec 2022 15:01:24 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AB88E02E3;
        Fri,  2 Dec 2022 12:01:22 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id n21so13918005ejb.9;
        Fri, 02 Dec 2022 12:01:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2Hdy2SKVatV6cGoEua8Dh6C/3VQ5blvlDTlWYGj5dik=;
        b=IKVQlXpZ+6iCx8MmydsjvvopBuqVg2L4Gcb2PEX1e/Dp3K8kQHc3ZmP0Cfg7tshPs1
         zmAPP2zYKSsrV8vb78SGdJqrRfneD6wfZNVBStLJSBoZ6NLtvogeTmTQkbX3zgrr6p5S
         XyFjhOe7ck8RvLQZHtPPD1acHn0yBTjpX7hoBE/cgjt6ikY/IrFPGRIY+O0ZmAqelTIo
         x4HNpJsZJv7pejJrft1W1zZfI7MphCb6lrvLO7p1q2HoxbNSPPZIaKwuk92Pe5fUO1U4
         VD9qV8lXt1UNBpbJbS2BP44idOxgA87TeVuJweEuHZPiQsmyB1Lwq8NDkvWI1pVari82
         Zn8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2Hdy2SKVatV6cGoEua8Dh6C/3VQ5blvlDTlWYGj5dik=;
        b=XE23P3FmRs13RPp6LBg1sqqoTUN5wW9MgaZj4LSW/VthwCw36R1RA/VFL4ecYvC9tT
         CG59VR/A7EwavQzVbbLxHDF0UchVPs1zPgay9tQX4lkDbY5MB5qTGbPq4xCe7NMNTisN
         ZSxttze0pd+lPNDUoSeEVm4M8m09MFbQhjBambe6ZtrcDzMC8EzXzXyeANkmXCmfnM9S
         lb103ckcDc5T+H4UK4iwoaAR58lQOBR1QeLJoxB36mNuRe/moDtKt8Mc55Ep47tilG8B
         Dxz+eemXzwSMyvqw6nAQ7nvajP7mooakV0XaqoVLAaAZDw6YfTibz947TvPBL1JTtkzR
         qw6g==
X-Gm-Message-State: ANoB5pmxSUZsIEdTBuXl4dzNTfDq9ub0DyGHixqZ8AW+hZRbLYl588cP
        59E4iYvAJseii/s+UZiG0kdnj0LiZLGsCblutcc=
X-Google-Smtp-Source: AA0mqf42APO7H6IEn/OWro2FoqChL8q+2NgeQjUbJuIaEWUpL9wOzryAjE5adsnYbTB3NSENx2knbaGlrEELQN5ATm8=
X-Received: by 2002:a17:907:76e6:b0:7c0:543a:5229 with SMTP id
 kg6-20020a17090776e600b007c0543a5229mr11349473ejc.58.1670011281210; Fri, 02
 Dec 2022 12:01:21 -0800 (PST)
MIME-Version: 1.0
References: <20221202174039.3360904-1-ssreevani@meta.com>
In-Reply-To: <20221202174039.3360904-1-ssreevani@meta.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Fri, 2 Dec 2022 12:01:09 -0800
Message-ID: <CAADnVQLYpvhbKqv_8EriF29dHFdDYi8dt3Yxh4QUiUfRoFaLJw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf, docs: BPF Iterator Document
To:     Sreevani Sreejith <ssreevani@meta.com>
Cc:     bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, psreep@gmail.com,
        David Vernet <void@manifault.com>,
        Yonghong Song <yhs@meta.com>, mykolal@meta.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Dec 2, 2022 at 9:42 AM Sreevani Sreejith <ssreevani@meta.com> wrote:
>
> From: Sreevani Sreejith <psreep@gmail.com>
>
> Document that describes how BPF iterators work, how to use iterators,
> and how to pass parameters in BPF iterators.
>
> Acked-by: David Vernet <void@manifault.com>
> Signed-off-by: Sreevani Sreejith <psreep@gmail.com>
> ---
>  Documentation/bpf/bpf_iterators.rst           |  487 +
>  .../bpf/images/bpf_iterator_flow.svg          | 9589 +++++++++++++++++

The graph looks nice, but it's huge.
Almost 1Mbyte.
The largest .svg file in the kernel tree is 200k.

Also it doesn't seem to add too much additional info
vs what's described in the text.
I suggest to drop .svg and stick to text only.
Or draw a text only diagram, but it doesn't look necessary in this case.
