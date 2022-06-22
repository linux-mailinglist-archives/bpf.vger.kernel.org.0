Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB918556EB0
	for <lists+bpf@lfdr.de>; Thu, 23 Jun 2022 00:54:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347009AbiFVWyY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Jun 2022 18:54:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232538AbiFVWyL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Jun 2022 18:54:11 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 268FAC27
        for <bpf@vger.kernel.org>; Wed, 22 Jun 2022 15:54:10 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id 89so27472318qvc.0
        for <bpf@vger.kernel.org>; Wed, 22 Jun 2022 15:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xOI/GkrveqegLV0ZiA89XQMlzXKK1gnmlyXBoe5Frn8=;
        b=CKwerhgwYtfg0OfQjTnGN6F7BITz4u9urXefas1N1EGHv2kdE8KJoAbyDvInaTs7nF
         sT3zxw/yawuZHzqCLuezSDHOaXWqxX8kT35jqywKpWSyTZAMwxTAxDDLUh/pfeG3H+Yq
         Rxsuvj/K63F30Tm3mlmjTN4XWm2R8JznQfotEfWVIjZxhmURwvAsB5kXHvYYTMSo1mKA
         iZpDrnwmeoVvfaiFifIYXwiO7Nnmn50+j5Pf9N4CzUqpN3ZBUPkCL617mNo60uwjcE4Q
         g2vNZJ9VpKe0CurrhSQlHxCQNLx8lDPn5TbA5mywMZqDlGlRxgfLII5nPfQTMH9H0vYE
         VPjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xOI/GkrveqegLV0ZiA89XQMlzXKK1gnmlyXBoe5Frn8=;
        b=HUoGzcbVKEfYacyBwlf3qaq1fJGhY6yEMrMoLPxFsz03KXI5ylplkVIwmOXrXAwjZM
         OR2Y4+Zf10NFehZD0Q+pR3xnKiOvPglEwclfKBNlMwokb2uJ5UEteePtogUJQV7NSjMf
         vMmacQja/qdYyB/d8WXhUheHQAxv/b1dXwWisdPotps0u7v8txKo5x/hlywvTIOnridj
         Jd5l89F65hZ8tKZd2FD3KArkgmyBw8C1sRWlmfUkMeXkPSzM6H6V1UC8yBO7dg9V8QbF
         RX9stwsi5DeG2fPqqEWg17jOgeHh3nVtS3siP2d5qAqOL6jKzu0fnUuYZEe60oT5tVpe
         uFIQ==
X-Gm-Message-State: AJIora+NjnT7KmAwvf1OEfIqMDXxBXXTTW8jPVDvQ7KM9pQ3VQjZFygb
        RfcjcFwf+XRkwZvCik7Q4OpX4at3c2kubqynea8jW78yxRQD9Q==
X-Google-Smtp-Source: AGRyM1uSjSYpOgE2K/ytbyyVG+gEi/qF/kFpxCg3I8VsfWQzv604ar9L2U7WDWZGBdknA1o3FhGywNy9FJlvIpavhqI=
X-Received: by 2002:a05:6214:1851:b0:470:2a5f:d68e with SMTP id
 d17-20020a056214185100b004702a5fd68emr22802267qvy.68.1655938449301; Wed, 22
 Jun 2022 15:54:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220622181918.ykrs5rsnmx3og4sv@alap3.anarazel.de>
In-Reply-To: <20220622181918.ykrs5rsnmx3og4sv@alap3.anarazel.de>
From:   Quentin Monnet <quentin@isovalent.com>
Date:   Wed, 22 Jun 2022 23:53:58 +0100
Message-ID: <CACdoK4LeRPkACejq87VLFgP-b=y1ZoRX3196f7xEVo-UWm8jWA@mail.gmail.com>
Subject: Re: init_disassemble_info() signature changes causes compile failures
To:     Andres Freund <andres@anarazel.de>
Cc:     open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 22 Jun 2022 at 19:19, Andres Freund <andres@anarazel.de> wrote:
>
> Hi,
>
> binutils changed the signature of init_disassemble_info(), which now caus=
es
> perf and bpftool to fail to compile (e.g. on debian unstable).
>
> Relevant binutils commit: https://sourceware.org/git/?p=3Dbinutils-gdb.gi=
t;a=3Dcommitdiff;h=3D60a3da00bd5407f07d64dff82a4dae98230dfaac
>
> util/annotate.c: In function =E2=80=98symbol__disassemble_bpf=E2=80=99:
> util/annotate.c:1765:9: error: too few arguments to function =E2=80=98ini=
t_disassemble_info=E2=80=99
>  1765 |         init_disassemble_info(&info, s,
>       |         ^~~~~~~~~~~~~~~~~~~~~
> In file included from util/annotate.c:1718:
> /usr/include/dis-asm.h:472:13: note: declared here
>   472 | extern void init_disassemble_info (struct disassemble_info *dinfo=
, void *stream,
>       |             ^~~~~~~~~~~~~~~~~~~~~
>
> with equivalent failures in
>
> tools/bpf/bpf_jit_disasm.c
> tools/bpf/bpftool/jit_disasm.c

Hi Andres,

Too bad the libbfd API is changing again :/ But many thanks for
pinning down the relevant commit, and for the report!

> The fix is easy enough, add a wrapper around fprintf() that conforms to t=
he
> new signature.
>
> However I assume the necessary feature test and wrapper should only be ad=
ded
> once? I don't know the kernel stuff well enough to choose the right struc=
ture
> here.

We can probably find a common header for the wrapper under
tools/include/. One possibility could be a new header under
tools/include/tools/, like for libc_compat.h. Although personally I
don't mind too much about redefining the wrapper several times given
how short it is, and because maybe some tools could redefine it anyway
to use colour output in the future.

The feature test would better be shared, it would probably be similar
to what was done in the following commit to accommodate for a previous
change in libbfd:

    https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/?id=3Dfb982666e380c1632a74495b68b3c33a66e76430

> Attached is my local fix for perf. Obviously would need work to be a real
> solution.

Thanks a lot! Would you be willing to submit a patch for the feature
detection and wrapper?

Best regards,
Quentin
