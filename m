Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4EDADDBA21
	for <lists+bpf@lfdr.de>; Fri, 18 Oct 2019 01:27:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438347AbfJQX11 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Oct 2019 19:27:27 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:33992 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389107AbfJQX11 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Oct 2019 19:27:27 -0400
Received: by mail-lj1-f195.google.com with SMTP id j19so4301692lja.1
        for <bpf@vger.kernel.org>; Thu, 17 Oct 2019 16:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W8MmnqB7rA2tYKZt6v3emS9THBaZ4bGPLOYrTpeqzQE=;
        b=fhviGpJeeD+4swsSILb+OyZgaCj4avPY7JORVMHkeLmAYiyk3zhqR5zNa4mRIZQqSF
         rSl38mNZbWPlH9X5B0PowHHDpZckgeSx16RHyOJKUer93fnpLH7BDECysLG26WpOn+J0
         nwNsRrhq7GDnYTkR4pWBZHIQ95HskDNxwIYZRTiDo51NZFy8Miv9alWTtVoIrvrpbMuB
         up9XeAwblnrEoU0LdLvWbB6nHsUr2hl+ZQGaFPuLBC5TWsjZQOKJlDoHfkdHZC+oBPfM
         TOF1eoagXQDVOLLmNoSwNxQAmgroKCKWgv7OOBZABUPObMOqhkeVErkcZDdg+5KgSQeG
         Hw6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W8MmnqB7rA2tYKZt6v3emS9THBaZ4bGPLOYrTpeqzQE=;
        b=OTE/mayg8qvJTjSBGHqY5jEFEju13a3FSgfJpURV40TVkcKFCzSid7DKVKzTPoLXOs
         apemjIfjRby+Tjtu2bwuCor1zqFk+koopxG4XQlVVci9na4btGT2IOD5NvFQgmNT0Ylq
         DiJwaxB2dO3xHvr94+oWrN3/V3QaUpISGF+TwhcjC5+mQep7QWZjGx1zpYV+UzsWWXP6
         mS7NZySys/nojznPIWNrZzCh1mP13uf8wFRqpOF1x6c55cqv59zlhS8qFkrCCBfGhoVE
         wCaKWfhuAv549rcjFH1nJsdmGdva3bly2csSMmIJ6/iDtZCYTphSslglTme6Xj/UEXrD
         17kw==
X-Gm-Message-State: APjAAAUTFOlDLeMfoMQM7o4pIfJXJg/5GWuQeP9WNNsdV1pYG5/l/ldA
        vQowGAGwyj3hext4dXl1pZD6jyZDs3cjHYj4sJI=
X-Google-Smtp-Source: APXvYqwmKc6gjuNK6GIfE5aJFDTuLJz8ltISFF/UPFkkSZvfPMZ/PoPU2t/2e0y5jSeG3xlaW8KpczYkwlLQRhR5qXo=
X-Received: by 2002:a2e:b17b:: with SMTP id a27mr4081923ljm.243.1571354843759;
 Thu, 17 Oct 2019 16:27:23 -0700 (PDT)
MIME-Version: 1.0
References: <20191017090500.ienqyium2phkxpdo@linutronix.de>
 <20191017145358.GA26267@pc-63.home> <20191017154021.ndza4la3hntk4d4o@linutronix.de>
 <20191017.132548.2120028117307856274.davem@davemloft.net> <alpine.DEB.2.21.1910172342090.1869@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1910172342090.1869@nanos.tec.linutronix.de>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 17 Oct 2019 16:27:11 -0700
Message-ID: <CAADnVQJPJubTx0TxcXnbCfavcQDZeu8VTnYYpa8JYpWw9Ze4qg@mail.gmail.com>
Subject: Re: [PATCH] BPF: Disable on PREEMPT_RT
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     David Miller <davem@davemloft.net>,
        Sebastian Sewior <bigeasy@linutronix.de>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Clark Williams <williams@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Oct 17, 2019 at 2:54 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> I'm all ears for an alternative solution. Here are the pain points:

Let's talk about them one by one.

>   #1) BPF disables preemption unconditionally with no way to do a proper RT
>       substitution like most other infrastructure in the kernel provides
>       via spinlocks or other locking primitives.

Kernel has a ton of code that disables preemption.
Why BPF is somehow special?
Are you saying RT kernel doesn't disable preemption at all?
I'm complete noob in RT.
