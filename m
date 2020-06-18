Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8449A1FEBDC
	for <lists+bpf@lfdr.de>; Thu, 18 Jun 2020 09:02:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727970AbgFRHB7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 18 Jun 2020 03:01:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727809AbgFRHB7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 18 Jun 2020 03:01:59 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8713C06174E
        for <bpf@vger.kernel.org>; Thu, 18 Jun 2020 00:01:58 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id s1so5949368ljo.0
        for <bpf@vger.kernel.org>; Thu, 18 Jun 2020 00:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=cFs+CIHjpphEdSI7fsUyYxQHP5MokJMxQ1UJQuL0uAE=;
        b=pDAapMvIzvMzUtRKqgImjJw7fYSMtjml2A2ycrJSGtc/3drEeASRwE8sjH5Py5L0ZX
         MkJsnG+DY95IRK9JimspGmibVWKBEG1dV9uZIbSkWLgo1EIVCZRk19GVEKi0OEHGuu/S
         rrsaSZ9KMIda3NDUxXAHG1dgMYpqtC9L1s34aNxJliOGmtaWUmuZ9ESngF6znaThrNa0
         YorkyrgN99VidEGh/bWp2fjV76ZJwYaUSMzyBvm5UkMokbyI8SzFwIgevQu84FODX85c
         9VLINlJ7EQCvbrcR10KgXj41iAXILFvTL4vxZQ/Z7Xd3PWkClsF4GNcz0z+CUnjgyse2
         xqKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=cFs+CIHjpphEdSI7fsUyYxQHP5MokJMxQ1UJQuL0uAE=;
        b=Z7zOiuqxeKrcIfGB+fSMFEAxOXzF32nQCAgjw3FmJMsPEF/R2wAI9uX/TWpxeRkbzV
         Z6FHR3NbYIak7akilNvZxeL7hxZ9Mop67bZWXdzxg/ymrDLZIzfQnmbsnVkLUxYMGsro
         B0e2xcgPLagO6vBZwzI1ZcZ0kglEYbnUhj1TR7Xsvd7kuR/8xlny9CtmpS1jUvhnwFBL
         yXuOx01I1vnzPoiAo1H1qyN5u2xtEgYmOkm6iVgkSpAgVESHl64ZM0Ih142roPOCv12W
         ysBs8Imp3ZQ+gxUTrsoVZ52CUGFE9jpikkJ7TErPxsM9uiXYA/Eo+IXCeCwN6RZMuPC7
         ZxWg==
X-Gm-Message-State: AOAM531D4Ks6oSI7K3Pr2Xzrwq7bOXfO7FroR9Wefb8A/rhkFFA78nJE
        okAWd0KNjDHU1NICQ2RRr7XOIAQgkpXz7U9I1ik=
X-Google-Smtp-Source: ABdhPJz9QfKmspxgStCr0X80Y+Mguw/fyU1UO9Hwuvpaqc1M9x7fAFHmkP/btjVydZS3viA9ung1bXndrCTRhyYFnQo=
X-Received: by 2002:a05:651c:1193:: with SMTP id w19mr1611593ljo.121.1592463717145;
 Thu, 18 Jun 2020 00:01:57 -0700 (PDT)
MIME-Version: 1.0
References: <CAHo-OoxJ6XBrBDXUxhCr0J58eOGq3FZu5+Rg6GLeeCjThrA8rg@mail.gmail.com>
In-Reply-To: <CAHo-OoxJ6XBrBDXUxhCr0J58eOGq3FZu5+Rg6GLeeCjThrA8rg@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 18 Jun 2020 00:01:45 -0700
Message-ID: <CAADnVQKXbd986SrW2u4nxY-0nNuC7VoVM29=3LeD9potOJTdZQ@mail.gmail.com>
Subject: Re: capable_bpf_net_admin()
To:     =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <zenczykowski@gmail.com>
Cc:     BPF Mailing List <bpf@vger.kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jun 17, 2020 at 11:43 PM Maciej =C5=BBenczykowski
<zenczykowski@gmail.com> wrote:
>
> is
> (SYS_ADMIN || BPF) && NET_ADMIN
>
> should this not be
> SYS_ADMIN || (BPF && NET_ADMIN)
>
> ?

capable_bpf_net_admin doesn't exist.

> Won't this cause a just SYS_ADMIN process to fail to load network bpf pro=
gs?

if the process has cap_sys_admin it has all privs.

> (I haven't debugged this at all, but John is reporting 5.8-rc1 fails
> to load bpf progs from Android's bpfloader with EPERM error)
>
> Or are we okay with this user space visible behavioural change?

What kind of change? Could you please be more specific?
