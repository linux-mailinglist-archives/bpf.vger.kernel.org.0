Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 698C11E8254
	for <lists+bpf@lfdr.de>; Fri, 29 May 2020 17:44:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727776AbgE2PoK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 29 May 2020 11:44:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726940AbgE2PoK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 29 May 2020 11:44:10 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 010A8C03E969;
        Fri, 29 May 2020 08:44:10 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id 202so1577654lfe.5;
        Fri, 29 May 2020 08:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=geCqCulS7H/YuAfHXfOQ101HM2bdw3ee5IqTWvyn0zg=;
        b=hXrzVRQwarnpCQxHcvLwAam+fo6puHGvVYkztPQDjg5YzS0ZwdfkZGJQ04okA5lYvE
         sKj78x5h9fBEumRmgLeMBHVgjMTcgS8++/S6l6sEyF90rzNgpo4IR9N9zrENEK+gD2Mi
         vF712gEdVDkKXiasn9WmCzdjuULcgS//LxVrrJ8MOiX1YlZGHyA1EC66UPKLZxqp85Mg
         /ayXVSdymEWCgyUg4P0BoZ5B1DooE5xc/NuhkK91TC3eaLlvaQVxM4xFQYJw7FU2FXOr
         wqeNHlpviCrULCuwO/Dol2QEb8h1lbkjWgxbACyLVtOponkePmpcc2e51JUNJshqyA6h
         TJVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=geCqCulS7H/YuAfHXfOQ101HM2bdw3ee5IqTWvyn0zg=;
        b=nM+WA7/LX9ZLs+ygOqX90jXDhiZFLR5RwtfMeVkRI4ZJxItShGWwoCryh0ulFwu/WS
         lYI8iT/9iNkSWHfAFvQrVDBeEDqtTdXoETMGo9Qnj6/sUIBpC15x7DLA0pPDUUqcLpbb
         RwUw4LY+fysUapg3kYwz+VIMpTGr5cvGBUZ3BgMh0wMSIpPNIVVIjFHxIRMwPiu4x4EX
         htnE9LCExU0JwCnPM/kf77MNM/z9IONfoUXmMH+y7aJ/6AhT42kP7AJqCq3Ndqevskr5
         V/5CSJb1+Ki5FriDi5FMNKlfL/Cy0j1It1fSjPFSGN9HfSmT8NnM1kHMrBkXivZTRq8m
         G5Mg==
X-Gm-Message-State: AOAM530nOM0EUjsEV9LHAMFArZSX+3pG2YPwKJ/t1TeNuAA4eyOuFGQ1
        moV+D+VoQo06yHDcMkGc1JKe6BDAe5dd6viuxD4hNhDy
X-Google-Smtp-Source: ABdhPJyN+ip7YVnKEX1CPufQSaHB8kYyQoAPLefJOJyJth+ObjZ/WhHbeMX//BHoZ2AIJAIPFLpqUFHu2n2q3PcLRhk=
X-Received: by 2002:a19:103:: with SMTP id 3mr4562062lfb.196.1590767048398;
 Fri, 29 May 2020 08:44:08 -0700 (PDT)
MIME-Version: 1.0
References: <c22a6c3cefc2412cad00ae14c1371711@huawei.com>
In-Reply-To: <c22a6c3cefc2412cad00ae14c1371711@huawei.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Fri, 29 May 2020 08:43:56 -0700
Message-ID: <CAADnVQLnFuOR+Xk1QXpLFGHx-8StPCye7j5UgKbBoLrmKtygQA@mail.gmail.com>
Subject: Re: new seccomp mode aims to improve performance
To:     "zhujianwei (C)" <zhujianwei7@huawei.com>
Cc:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        Hehuazhen <hehuazhen@huawei.com>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, May 29, 2020 at 5:50 AM zhujianwei (C) <zhujianwei7@huawei.com> wro=
te:
>
> Hi, all
>
> =E3=80=80=E3=80=80We're using seccomp to increase container security, but=
 bpf rules filter causes performance to deteriorate. So, is there a good so=
lution to improve performance, or can we add a simplified seccomp mode to i=
mprove performance?

I don't think your hunch at where cpu is spending cycles is correct.
Could you please do two experiments:
1. try trivial seccomp bpf prog that simply returns 'allow'
2. replace bpf_prog_run_pin_on_cpu() in seccomp.c with C code
  that returns 'allow' and make sure it's noinline or in a different C file=
,
  so that compiler doesn't optimize the whole seccomp_run_filters() into a =
nop.

Then measure performance of both.
I bet you'll see exactly the same numbers.
If you have retpoline on then bpf case will be slightly slower because
of retpoline cost.

Only after this experiment let's discuss the options about accelerating sec=
comp.

>
> =E3=80=80=E3=80=80// Pseudo code
> =E3=80=80=E3=80=80int __secure_computing(int this_syscall)
> =E3=80=80=E3=80=80{
> =E3=80=80=E3=80=80      ...
> =E3=80=80=E3=80=80      switch (mode) {
> =E3=80=80=E3=80=80      case SECCOMP_MODE_STRICT:
> =E3=80=80=E3=80=80              ...
> =E3=80=80=E3=80=80      case SECCOMP_MODE_FILTER:
> =E3=80=80=E3=80=80              ...
> =E3=80=80=E3=80=80      case SECCOMP_MODE_LIGHT_FILTER:
> =E3=80=80=E3=80=80              //do light syscall filter.
> =E3=80=80=E3=80=80              ...
> =E3=80=80=E3=80=80              break;
> =E3=80=80=E3=80=80      }
> =E3=80=80=E3=80=80      ...
> =E3=80=80=E3=80=80}
>
> =E3=80=80=E3=80=80int light_syscall_filter(int syscall_num) {
> =E3=80=80=E3=80=80      if(scno > SYSNUM_MAX) {
> =E3=80=80=E3=80=80              ...
> =E3=80=80=E3=80=80              return -EACCESS;
> =E3=80=80=E3=80=80      }
>
> =E3=80=80=E3=80=80=E3=80=80=E3=80=80    bool *filter_map =3D get_filter_m=
ap(current);
> =E3=80=80=E3=80=80      if(filter_map =3D=3D NULL) {
> =E3=80=80=E3=80=80              ...
> =E3=80=80=E3=80=80              return -EFAULT;
> =E3=80=80=E3=80=80      }
>
> =E3=80=80=E3=80=80=E3=80=80=E3=80=80    if(filter_map[syscall_num] =3D=3D=
 true) {
> =E3=80=80=E3=80=80              ...
> =E3=80=80=E3=80=80              return 0;
> =E3=80=80=E3=80=80      } else {
> =E3=80=80=E3=80=80              ...
> =E3=80=80=E3=80=80              return -EACCESS;
> =E3=80=80=E3=80=80      }
> =E3=80=80=E3=80=80      ...
> =E3=80=80=E3=80=80}
