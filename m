Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11E585E7033
	for <lists+bpf@lfdr.de>; Fri, 23 Sep 2022 01:22:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230517AbiIVXV5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 22 Sep 2022 19:21:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbiIVXVz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 22 Sep 2022 19:21:55 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 968F0112645
        for <bpf@vger.kernel.org>; Thu, 22 Sep 2022 16:21:54 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-345528ceb87so114896837b3.11
        for <bpf@vger.kernel.org>; Thu, 22 Sep 2022 16:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=ofBDEYmSYov6vH0rDkVnw+E8Q1N0c0wBly7sWjorjJM=;
        b=VLTXbjcWhiHHg4AQgaByKDR1ZPtiUdAGKSb/5Yl2tioUxOjS37Y+p871C3RXYU9aps
         h2uz4GGq8QnEokqOpapLPEj7fCm5amjgMZhCMxp0H6JWFWaHTtOZkcskOcB3VI2b1sst
         AZ4CwlhuDdE11BiuW3gbXTQR622CEboNX5tKOksVdIGhtnivVj5GMYr2Mkpu4X10CDmH
         FW1w2QMxqjMYTdzF6H5+pE2Pj//ej7EPkyOhbeTC/vwL4mQYLcaSJjAHnQMKBpnfgjFY
         UAPPwzjKwvGVCl3QBN3ENnelfOagO3yOJr/pRlVkocrJenn2/hL0J23gQRoh1kbeWdJW
         ac1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=ofBDEYmSYov6vH0rDkVnw+E8Q1N0c0wBly7sWjorjJM=;
        b=v3GmkhzUEZddG7s7UE75EGXyZ2foJYeaj6tfXEZYgfFxSr+8/jUoy+y4kBjgC/Pbe0
         RHXgUWlHSccol0jeLeydQ/ME0d8WZ+1k4h1VbyxEpwEVlIanGIGFilIXaef6YX5hsJOi
         7cbOp0eXg/Ehvs9gZrTSKn5EsVPDT4g0dx3C9YAbRD2SLurDerugMKrGKoEW56I00+iq
         7Ca3TDbRKZWUtdtB1zdeDbCULGG47sGOX3hYOPSBwbFqquBtwIOlkSMecry9SGLJOQcF
         72vatUN9e0SevPvZ+4As3FEOiqWiJbKnRKlO0o7KGVl6Fjr4I1OaGh8lcK18roY7T9bL
         T1qA==
X-Gm-Message-State: ACrzQf1nK5VaRn0Mj8+DZD1hk4RXwrdNqLIYEJ/9qPBZlW8WfdvG5zr4
        +0VPRwvdp9wunUTsBY8t0NSbqcj1K2nv5ON8VIX05BGJ4IvrfA==
X-Google-Smtp-Source: AMsMyM7fPclPHVCSb/GcdLgDt/fcbkP7VimYLTGxZyelzwYt2uNDJXwQQGEXD0qVwcvK/zKxgeSwL/YcWjWx0m6GmCo=
X-Received: by 2002:a0d:d7cf:0:b0:345:3528:1e9a with SMTP id
 z198-20020a0dd7cf000000b0034535281e9amr5675056ywd.173.1663888913689; Thu, 22
 Sep 2022 16:21:53 -0700 (PDT)
MIME-Version: 1.0
References: <a6c0bb85-6eeb-407e-a515-06f67e70db57@www.fastmail.com> <4e66ca38-e99d-4fe5-b224-e36fb946878f@www.fastmail.com>
In-Reply-To: <4e66ca38-e99d-4fe5-b224-e36fb946878f@www.fastmail.com>
From:   Hao Luo <haoluo@google.com>
Date:   Thu, 22 Sep 2022 16:21:42 -0700
Message-ID: <CA+khW7ittjLYfdHLpcVDGtpnXv1q-WPwRz-CqUTvFOSeywhBQA@mail.gmail.com>
Subject: Re: Closing the BPF map permission loophole
To:     Lorenz Bauer <oss@lmb.io>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>, bpf@vger.kernel.org
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

Hi Lorenz,

Thanks for your nice summary.

On Thu, Sep 22, 2022 at 9:29 AM Lorenz Bauer <oss@lmb.io> wrote:
>
> On Thu, 15 Sep 2022, at 11:30, Lorenz Bauer wrote:
> > Hi list,
> >
> > Here is a summary of the talk I gave at LPC '22 titled "Closing the BPF
> > map permission loophole", with slides at [0].
[...]
> > Problem #1: Read-only fds can be modified via a BPF program
>
> Up until 591fe9888d78 BPF_F_RDONLY_PROG we'd probably be OK with just ref=
using !rw fds. The only kernel.org version that this applies to is 4.19. 5.=
4, 5.10, 5.15 need the fix Roberto suggested.

For this problem, I'm thinking of a fix purely in the verifier:
passing along the file permission up to the site where the map is
used.

For maps that are not passed from outside, this permission is rw by default=
.

For maps that are obtained from fdget(), we can do the following:

- associate the env->used_maps with an array of permissions.
- then extend bpf_reg_state and bpf_call_arg_meta to include the
permission information.
- then in record_func_map(), we can reject the program if the
permission doesn't allow the map operation.

Not the simplest solution, but this is the first solution that comes
up in my head.

> > Problem #2: Read-only fds can be "transmuted" into read-write fds via m=
ap in map
>
> This is not as big a problem as I initially thought. First, lookup in a n=
ested map from userspace returns an ID, not a fd. Going from ID to fd requi=
res CAP_SYS_ADMIN. On the program side, it's possible to retrieve the inner=
 map and modify it.
>
> I think it's possible to fix this by refusing to insert !rw inner maps, b=
y patching bpf_map_fd_get_ptr(). That function hasn't changed in a long tim=
e either. 4.19, 5.4, 5.10, 5.15.

With the permission info associated with map_ptr in verifier that is
established for program #1, a fix seems relatively easy.

> > Problem #3: Read-only fds can be transmuted into read-write fds via
> > object pinning
> >
> > 1. BPF_OBJ_PIN(read-only fd, /sys/fs/bpf/foo)
> > 2. BPF_OBJ_GET(/sys/fs/bpf/foo) =3D read-write fd
>
> bpf_map doesn't have a concept of an owning user, so the only solution I =
can come up with is to refuse OBJ_PIN if !rw and !capable(CAP_DAC_OVERRIDE)=
. Replace CAP_DAC_OVERRIDE with another capability of your choice, the idea=
 being that this allows programs that run as root (probably a lot?) to cont=
inue functioning.

For an idea mentioned in the summary,

> In OBJ_GET, refuse a read-write fd if the fd passed to OBJ_PIN wasn't rea=
d-write.

This sounds reasonable to me. Can we extend the object type referenced
by inode to include the permission?

> Again 4.19, 5.4, 5.10, 5.15.
>
> Daniel, Alexei, Andrii: any thoughts? This is a pretty deep rabbit hole, =
and I don't want to waste my time on the wrong approach.
>
> 0: https://github.com/willfindlay/bpfcontain-rs/blob/eb2cd826b609e165d63d=
784c0f562b7a278171d2/src/bpf/include/allocator.h#L16
