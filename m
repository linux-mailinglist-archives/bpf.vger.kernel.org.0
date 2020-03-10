Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ADF1118054F
	for <lists+bpf@lfdr.de>; Tue, 10 Mar 2020 18:47:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbgCJRra (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 10 Mar 2020 13:47:30 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:38138 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726703AbgCJRr3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 10 Mar 2020 13:47:29 -0400
Received: by mail-lj1-f194.google.com with SMTP id w1so15181992ljh.5;
        Tue, 10 Mar 2020 10:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QOo8QOtiq46Mv3iqusJE/rAX/jSTXhFYzSSPT1tZ1sw=;
        b=JUHQbBY+Cv10kHOGFsDvf4lPZskoGS/yPWqEztEH2N4i836T/sf/6mzHyVZs+RQ7wl
         agx+oXqwk1aYgczJtmFX/p9eMgBo38i32+CSa+t/nx8/8qjJ25LikrGtts6zX1uhZDzO
         k8Qxq8VdMnFU5UuVr/CYcDWpE132yZFeTzKR+CHy3ryj681GyNdFLnVRyF6cecLrVp57
         dCQA8+gknJtWxkymcX3fxX5al0cjJSSj9Ydkvjb8uvjRETobAVPdmpND2cn0IziUuGHf
         KHYv0Sgd1anwHIsEcuZlNVJLstfRH0hQ4tF5R57GDO+IqJ/OrtnEDKeBOOAUi3itwjx7
         /Qwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QOo8QOtiq46Mv3iqusJE/rAX/jSTXhFYzSSPT1tZ1sw=;
        b=N6MhjrtxK9LtLXigz7+Wfxsa0xfAechBbSnB1UaE09kYCjOgPr6konu7ODQSlkdd7i
         tl5j0s2tjDhlvtS2PKsDrFg7WxSG1CSo7PH0qwpS4CH/slPAlu0KTCXz+w3ewwGvlCRl
         ogAcV4Nqg+HJCqGUZsUhKXRYa9eQbNtKhOSB6OwXCJs7htxRYTUPb6dMT2R7q3Oo0VPR
         oKSRDUXmpsjteN2C2z/Pu8m0+5nrqZxWzwqRugiCZPu0rdS8gvI2PQTQ5GXZBIwRk/Vt
         uQuD9bTgCyIU0QEgtFbgCjUvvbcSKrKJQ8gENYdhNRLXodCTy1N0eQttgMozX1ul3SOG
         9AHA==
X-Gm-Message-State: ANhLgQ0kf8Qd3fy+kTvju9TPJ29pFKWHG9FL1EH+f8tK5bD4y/Olny0G
        QV12YPJD/bBaQcDHdEP3/dClj20ReLR8J/oQqqM=
X-Google-Smtp-Source: ADFU+vtO6XDBUly2q5RwFmPsNbaMJeEdaZyVLi0rlyVA0BqaPbI8w0ky1P21EnZcM+VsFjs13RNYMXvePJEzes2APEY=
X-Received: by 2002:a2e:8145:: with SMTP id t5mr13789511ljg.144.1583862446770;
 Tue, 10 Mar 2020 10:47:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200309180350.21075-1-steve@sk2.org>
In-Reply-To: <20200309180350.21075-1-steve@sk2.org>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 10 Mar 2020 10:47:15 -0700
Message-ID: <CAADnVQJ0EephJiY8F5KJFbYPBg2=hTHOi3WOUtVFE=qgoVbSuA@mail.gmail.com>
Subject: Re: [PATCH v2] docs: sysctl/kernel: document BPF entries
To:     Stephen Kitt <steve@sk2.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>, bpf <bpf@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Mar 9, 2020 at 11:05 AM Stephen Kitt <steve@sk2.org> wrote:
>
> Based on the implementation in kernel/bpf/syscall.c,
> kernel/bpf/trampoline.c, include/linux/filter.h, and the documentation
> in bpftool-prog.rst.
>
> The section style doesn't match the surrounding sections; it matches
> the style of the reworked kernel.rst queued up in docs-next.
>
> Signed-off-by: Stephen Kitt <steve@sk2.org>
> ---
>
> Notes:
>     Changes since v1:
>     - rebased on bpf-next instead of docs-next.
>
>  Documentation/admin-guide/sysctl/kernel.rst | 24 +++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>
> diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
> index def074807cee..eea7afd509ac 100644
> --- a/Documentation/admin-guide/sysctl/kernel.rst
> +++ b/Documentation/admin-guide/sysctl/kernel.rst
> @@ -174,6 +174,20 @@ See the type_of_loader and ext_loader_ver fields in
>  Documentation/x86/boot.rst for additional information.
>
>
> +bpf_stats_enabled
> +=================
> +
> +Controls whether the kernel should collect statistics on BPF programs
> +(total time spent running, number of times run...). Enabling
> +statistics causes a slight reduction in performance on each program
> +run. The statistics can be seen using ``bpftool``.
> +
> += ===================================
> +0 Don't collect statistics (default).
> +1 Collect statistics.
> += ===================================
> +
> +
>  cap_last_cap:
>  =============
>
> @@ -1123,6 +1137,16 @@ NMI switch that most IA32 servers have fires unknown NMI up, for
>  example.  If a system hangs up, try pressing the NMI switch.
>
>
> +unprivileged_bpf_disabled
> +=========================
> +
> +Writing 1 to this entry will disabled unprivileged calls to ``bpf()``;

same typo as was pointed out earlier.
