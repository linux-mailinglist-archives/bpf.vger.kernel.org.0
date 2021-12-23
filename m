Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF70F47DC0E
	for <lists+bpf@lfdr.de>; Thu, 23 Dec 2021 01:34:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233361AbhLWAer (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Dec 2021 19:34:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230416AbhLWAer (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Dec 2021 19:34:47 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63371C061574
        for <bpf@vger.kernel.org>; Wed, 22 Dec 2021 16:34:47 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id x6so4945480iol.13
        for <bpf@vger.kernel.org>; Wed, 22 Dec 2021 16:34:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8bmWk68Ww8LMN+2sa0TWqwIB9nNQV7SnCmOQk3Py0io=;
        b=crO+/wN7V1cp0sNeVoPAxoK8B2BwJu/PDlbHD1FRv6HtjtEjAtQFyZ0yYR3unBAwb6
         5Mf2pVyJqtWEDlYI6M3wRqqywvZ60oX3bLFf2ZyHwJuHYM0vb6hN1q+atPMZZsQhanyq
         B3V5JfsbUMVRebV8j+0/EjRpqV7/Q3RWtIrpGAtlpksbctMLZgy5qTv1hg/pqJPpYXbo
         klbVVJUjMJbeKy7zqCb/vtv19cWqNazzLILnTHfFho8lurr38RT30kfkPW6++xc1eo7V
         RIJ6o/J/l2zfTf3ShQ2tgYK4Dd2BBXH4mK4ejwV5p85cX96VkMA+gmD8+8wpTjwGtkOc
         KcJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8bmWk68Ww8LMN+2sa0TWqwIB9nNQV7SnCmOQk3Py0io=;
        b=Z4eB7DesNiqodYCMDaQLJqdFCDNJKlPr4w0OFUN+/II+3gYewlm/zk6BIfUYav2DPU
         KJ3UY/uW9jmDjS8sjpudd6GXuerlC8ln5RvHKzZ4nS7g0ws8woNyWWFaX+mdC7b8Aj1/
         m0DJU4XHCegYzpQpGZ6M84sQmvSazYprElNi1xlqVbX3ieiISjIzB/YO8x7O4ThiGO8D
         lwhH9MB2pOkVQ48KwFI8ix6SPCXDk1p1Yup0F88AbNcganV6H3DQ4dji11DgT+cutSan
         XTfFRRWO5TCqa3hNYtjB8EDgAZGx/CSXO5YDnbciaABboNJbx7Sqz6tk66xkLErov17p
         RuCg==
X-Gm-Message-State: AOAM533lxqqIxH+ajQwOwio/5A71Qr4WxSLhhGVVomE9npSdebGjcg7c
        jNNKUiR/6EwB2Pf+8cHukWt4VVONgWEf9osrVtM=
X-Google-Smtp-Source: ABdhPJw5zG1BbhZsYKknfh8qd5hAsvEyF1IiPuCIrDptGuJjRtVlMbLnZfg86vFr12bOxr2PQ0Rg6W4G4hGZ1OeBa80=
X-Received: by 2002:a5d:87d8:: with SMTP id q24mr81613ios.154.1640219686858;
 Wed, 22 Dec 2021 16:34:46 -0800 (PST)
MIME-Version: 1.0
References: <20211222213924.1869758-1-andrii@kernel.org> <7527e408-80da-9e6f-46bf-931efc0582e2@fb.com>
In-Reply-To: <7527e408-80da-9e6f-46bf-931efc0582e2@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 22 Dec 2021 16:34:35 -0800
Message-ID: <CAEf4BzbHs_0fi-kiOKFwk0WFeR7YCcYzSu=yxcSvtWn8VLXc0A@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] libbpf: normalize PT_REGS_xxx() macro definitions
To:     Yonghong Song <yhs@fb.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        Kenta Tada <Kenta.Tada@sony.com>,
        Hengqi Chen <hengqi.chen@gmail.com>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Dec 22, 2021 at 4:27 PM Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 12/22/21 1:39 PM, Andrii Nakryiko wrote:
> > Refactor PT_REGS macros definitions in  bpf_tracing.h to avoid excessiv=
e
> > duplication. We currently have classic PT_REGS_xxx() and CO-RE-enabled
> > PT_REGS_xxx_CORE(). We are about to add also _SYSCALL variants, which
> > would require excessive copying of all the per-architecture definitions=
.
> >
> > Instead, separate architecture-specific field/register names from the
> > final macro that utilize them. That way for upcoming _SYSCALL variants
> > we'll be able to just define x86_64 exception and otherwise have one
> > common set of _SYSCALL macro definitions common for all architectures.
> >
> > Cc: Kenta Tada <Kenta.Tada@sony.com>
> > Cc: Hengqi Chen <hengqi.chen@gmail.com>
> > Cc: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>
> > Cc: Ilya Leoshkevich <iii@linux.ibm.com>
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
>
> I tried my best to compare old and new sources. Except "const volatile
> struct user_pt_regs *" becomes "const struct user_pt_regs *", I didn't
> spot any other semantic differences. Agree that "volatile" is not really
> needed here. So

Right. I also started out with adding volatile for x86-64 case, but
that immediately triggered compilation warning in selftests, so I
suspect that other arches would be triggering warnings in some cases
due to volatile. So I dropped it everywhere because the load should
still happen due to the pointer dereference.

>
> Acked-by: Yonghong Song <yhs@fb.com>
