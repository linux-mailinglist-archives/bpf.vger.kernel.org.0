Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B2D028909E
	for <lists+bpf@lfdr.de>; Fri,  9 Oct 2020 20:12:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388019AbgJISMl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 9 Oct 2020 14:12:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725979AbgJISMl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 9 Oct 2020 14:12:41 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7A96C0613D2
        for <bpf@vger.kernel.org>; Fri,  9 Oct 2020 11:12:40 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id qp15so14389972ejb.3
        for <bpf@vger.kernel.org>; Fri, 09 Oct 2020 11:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=uZHD7iXVcSv9l7M1jI+lp36MwtZAYRq7WKIeklPCKDo=;
        b=RI8Me4Vr1vppTmFAzdG0SAIvgF4SpxoUTDxRkpiWAtmMYU3ajQfL7smuSM/kJjxaoG
         wA9fTHLq+kcLStp6caQ+9T3UkpX5ClHeo7v/LJehKmIRZpGZsioowNg1vIfJOOw7yZ6u
         Qdm2EJ9y8fgbhDmyRoGiXl2t43E33K7wj0sFvRpwG9MXowe3bIeaxNBhlH9yPaxsJCbZ
         6QqrVCW2zRDV0CaW2xlk1nonxkGU0HV5B+3/5tS0g3iYaM0laSZz0xkdKBibNyTobkpU
         sXHSKzTVCXMcBqwO4EXu0TrG5Q4kLPx3eeV0jEgCca45NM4/CHdUd/b2rBpElbMwQERA
         ykvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=uZHD7iXVcSv9l7M1jI+lp36MwtZAYRq7WKIeklPCKDo=;
        b=YPgPRKSghbYKtZnyLyHEfgFXOr8t7OjjnKmwYtbYPExwOl8E570pWHBPtdIbn6ZfJY
         alXeEUAa++EVScuzaXw7KzTvWaJ7d8gk5iCCh/d//ArBLzMD2PdiEn84/9a1dsOUnAs8
         aWUulEobtnihAyKbwQxREtGoXsGGt8uuS0d6s675TKjQwlD3HQjoU8gihJVd6oHJ1wE2
         aGDPOm2BFX2CKD6Q4SGMTURqmSWgDZ9IcmaUVi938PLBqSAgbmIs4QnM20qJUjdbB7/e
         6+xqs2Zz+siBlOlTniQi8n9mozOIhJJTkxH1m1Q8HeRzPkFPtdRKqiRtjym1vNvI6VK/
         Qj/w==
X-Gm-Message-State: AOAM530msdLNlk4dX/WJCg9vxpwoPVyIb0QTTpuBV7J5/5IRaPQUarsR
        OCROkX2uKKkfLZ7FKt0pQs0GBwM2hn9PYpiNdU0=
X-Google-Smtp-Source: ABdhPJzXlYXRjErcvTl1fLEwyChov/puIhQcEvGGlw0poI+jR8jC25J8OnN9ERlfwqIHPd4j4QEciBvTbXr92tYq6ns=
X-Received: by 2002:a17:906:6d89:: with SMTP id h9mr15063972ejt.152.1602267159449;
 Fri, 09 Oct 2020 11:12:39 -0700 (PDT)
MIME-Version: 1.0
References: <CAMy7=ZUk08w5Gc2Z-EKi4JFtuUCaZYmE4yzhJjrExXpYKR4L8w@mail.gmail.com>
 <CAEf4BzYTja99-1LHdMK69qY3XrqgtyKVheV3YH7e89JY0C4E1A@mail.gmail.com>
In-Reply-To: <CAEf4BzYTja99-1LHdMK69qY3XrqgtyKVheV3YH7e89JY0C4E1A@mail.gmail.com>
From:   Yaniv Agman <yanivagman@gmail.com>
Date:   Fri, 9 Oct 2020 21:12:28 +0300
Message-ID: <CAMy7=ZURAvNoAtdUK5-zQVDMvbnwqnEJOTJ27WeZNMFYoLSnfg@mail.gmail.com>
Subject: Re: libbpf error: unknown register name 'r0' in asm
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

=E2=80=AB=D7=91=D7=AA=D7=90=D7=A8=D7=99=D7=9A =D7=99=D7=95=D7=9D =D7=95=D7=
=B3, 9 =D7=91=D7=90=D7=95=D7=A7=D7=B3 2020 =D7=91-21:03 =D7=9E=D7=90=D7=AA =
=E2=80=AAAndrii Nakryiko=E2=80=AC=E2=80=8F
<=E2=80=AAandrii.nakryiko@gmail.com=E2=80=AC=E2=80=8F>:=E2=80=AC
>
> On Fri, Oct 9, 2020 at 9:06 AM Yaniv Agman <yanivagman@gmail.com> wrote:
> >
> > Pulling the latest changes of libbpf and compiling my application with =
it,
> > I see the following error:
> >
> > ../libbpf/src//root/usr/include/bpf/bpf_helpers.h:99:10: error:
> > unknown register name 'r0' in asm
> >                      : "r0", "r1", "r2", "r3", "r4", "r5");
>
> are you including bpf_helpers.h from user-space code? You are using
> recent enough Clang to not run into this problem for -target bpf, so
> this seems like you are including bpf_helpers.h in the context where
> it's not supposed to be included.
>

This happens when I compile the kernel bpf code, not for user-space code

>
> >
> > The commit which introduced this change is:
> > 80c7838600d39891f274e2f7508b95a75e4227c1
> >
> > I'm not sure if I'm doing something wrong (missing include?), or this
> > is a genuine error
> >
> > Yaniv
