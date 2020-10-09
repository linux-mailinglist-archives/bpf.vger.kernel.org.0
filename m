Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CF39288180
	for <lists+bpf@lfdr.de>; Fri,  9 Oct 2020 06:48:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728293AbgJIEr3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 9 Oct 2020 00:47:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726629AbgJIEr2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 9 Oct 2020 00:47:28 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9834C0613D2;
        Thu,  8 Oct 2020 21:47:28 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id h6so6196408pgk.4;
        Thu, 08 Oct 2020 21:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ewguY3pcuJUASJZKtryI+WUb/DfgApGMQzDJ1fqU0+s=;
        b=n8ueQNqTvGIUJVNHoxh4SFdLgsw++GL5jkvpig+fbUhC5PMJAd3TgvHkQBsWvunzCI
         XQ9ny8J1lCPOVHZE7Usf28ExAzdi3OFL/TJAC2cgftvQmcpXMo7qaLPx/Nh5PuRiBxMg
         mMga0NGw/RaUsQioWXkOGCMI0f1tyW2oVhEJePeCD+7MAPTzUUMnFmhZJZROVIFS/Wud
         h86/8Q8F7Bfp8z5gxwYb4Yn8W7MzBs3T15PQEuXpq8+tGA5mKy0IR0PDk5ENL86Gd6nY
         qri/KRW0OEBYnxdR2jMf70KgL5wy+D7/HKIs0NbfQDSkfJhSIR8eXpTl07XitTz707ed
         DwAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ewguY3pcuJUASJZKtryI+WUb/DfgApGMQzDJ1fqU0+s=;
        b=Yqsuye8fVFoNf8bvAOovjqOjsfLi8nf+rWy5ROmo1bw8ZCvD8mSdABJwWM1EOz0d93
         RknVILOZFZUsP/Kp69y1dmm19a4jzHRt0+4zkEA1ulfNT/LeKgLlSBGO+lJhEeiQ5+pd
         ogN6NMtp/KwpGRvu/3HpsG8ZDrjONgDCYsnMSKSJVzikkesTtaehBzljHc0VTamoUX3j
         emJnK5Fb8bpgsMacLQbSDRPzBaSgCSiJ3Qt8uOYbLll7yVK4sqQXxFJNljtDbkVBBo2q
         S0TUP3hKP5hp7Se0kCTFfXFEo6d8H+GUPXkUsBZUsvwRxb9aV5+4A+kyRdrRi8AjDe/K
         IhHg==
X-Gm-Message-State: AOAM533F74J37z/M/li32AdBUYgVuJQ7ScCt2kCY+XLq3i2wASUqAZRz
        TaSf2cB7WWR9gC1Z2/Ur7Vydpi4J2GOWQG1AtSI=
X-Google-Smtp-Source: ABdhPJwqvDp2jodGpXwCgBFAUggX4v5IU8dK3stZ6mSV5NnDUKTZ/xg2YWnS0x4Vgqv+kJ/xYRxiRWfDf+l1pqRItGI=
X-Received: by 2002:a62:750a:0:b029:152:4d07:aec6 with SMTP id
 q10-20020a62750a0000b02901524d07aec6mr10505669pfc.48.1602218848174; Thu, 08
 Oct 2020 21:47:28 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1601478774.git.yifeifz2@illinois.edu> <b16456e8dbc378c41b73c00c56854a3c30580833.1601478774.git.yifeifz2@illinois.edu>
In-Reply-To: <b16456e8dbc378c41b73c00c56854a3c30580833.1601478774.git.yifeifz2@illinois.edu>
From:   YiFei Zhu <zhuyifei1999@gmail.com>
Date:   Thu, 8 Oct 2020 23:47:17 -0500
Message-ID: <CABqSeAQELsMP4116LwOY+WMcs9Zjr9fYUZ-pK+yNTGYETLf46w@mail.gmail.com>
Subject: Re: [PATCH v3 seccomp 2/5] seccomp/cache: Add "emulator" to check if
 filter is constant allow
To:     Linux Containers <containers@lists.linux-foundation.org>
Cc:     YiFei Zhu <yifeifz2@illinois.edu>, bpf <bpf@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        David Laight <David.Laight@aculab.com>,
        Dimitrios Skarlatos <dskarlat@cs.cmu.edu>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Hubertus Franke <frankeh@us.ibm.com>,
        Jack Chen <jianyan2@illinois.edu>,
        Jann Horn <jannh@google.com>,
        Josep Torrellas <torrella@illinois.edu>,
        Kees Cook <keescook@chromium.org>,
        Tianyin Xu <tyxu@illinois.edu>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Tycho Andersen <tycho@tycho.pizza>,
        Valentin Rothberg <vrothber@redhat.com>,
        Will Drewry <wad@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Sep 30, 2020 at 10:20 AM YiFei Zhu <zhuyifei1999@gmail.com> wrote:
> @@ -544,7 +577,8 @@ static struct seccomp_filter *seccomp_prepare_filter(=
struct sock_fprog *fprog)
>  {
>         struct seccomp_filter *sfilter;
>         int ret;
> -       const bool save_orig =3D IS_ENABLED(CONFIG_CHECKPOINT_RESTORE);
> +       const bool save_orig =3D IS_ENABLED(CONFIG_CHECKPOINT_RESTORE) ||
> +                              IS_ENABLED(CONFIG_SECCOMP_CACHE_NR_ONLY);
>
>         if (fprog->len =3D=3D 0 || fprog->len > BPF_MAXINSNS)
>                 return ERR_PTR(-EINVAL);

I'm trying to use __is_defined(SECCOMP_ARCH_NATIVE) here, and got this mess=
age:

kernel/seccomp.c: In function =E2=80=98seccomp_prepare_filter=E2=80=99:
././include/linux/kconfig.h:44:44: error: pasting "__ARG_PLACEHOLDER_"
and "(" does not give a valid preprocessing token
   44 | #define ___is_defined(val)  ____is_defined(__ARG_PLACEHOLDER_##val)
      |                                            ^~~~~~~~~~~~~~~~~~
././include/linux/kconfig.h:43:27: note: in expansion of macro =E2=80=98___=
is_defined=E2=80=99
   43 | #define __is_defined(x)   ___is_defined(x)
      |                           ^~~~~~~~~~~~~
kernel/seccomp.c:629:11: note: in expansion of macro =E2=80=98__is_defined=
=E2=80=99
  629 |           __is_defined(SECCOMP_ARCH_NATIVE);
      |           ^~~~~~~~~~~~

Looking at the implementation of __is_defined, it is:

#define __ARG_PLACEHOLDER_1 0,
#define __take_second_arg(__ignored, val, ...) val
#define __is_defined(x) ___is_defined(x)
#define ___is_defined(val) ____is_defined(__ARG_PLACEHOLDER_##val)
#define ____is_defined(arg1_or_junk) __take_second_arg(arg1_or_junk 1, 0)

Hence, when FOO is defined to be 1, then the expansion would be
__is_defined(FOO) -> ___is_defined(1) ->
____is_defined(__ARG_PLACEHOLDER_1) -> __take_second_arg(0, 1, 0) ->
1,
and when FOO is not defined, the expansion would be __is_defined(FOO)
-> ___is_defined(FOO) -> ____is_defined(__ARG_PLACEHOLDER_FOO) ->
__take_second_arg(__ARG_PLACEHOLDER_FOO 1, 0) -> 0

However, here SECCOMP_ARCH_NATIVE is an expression from an OR of some
bits, and __is_defined(SECCOMP_ARCH_NATIVE) would not expand to
__ARG_PLACEHOLDER_1 during any stage in the preprocessing.

Is there any better way to do this? I'm thinking of just doing #if
defined(CONFIG_CHECKPOINT_RESTORE) || defined(SECCOMP_ARCH_NATIVE)
like in Kee's patch.

YiFei Zhu
