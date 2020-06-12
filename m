Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 113881F7EE3
	for <lists+bpf@lfdr.de>; Sat, 13 Jun 2020 00:26:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726304AbgFLW0l (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 12 Jun 2020 18:26:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbgFLW0l (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 12 Jun 2020 18:26:41 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ADC8C03E96F
        for <bpf@vger.kernel.org>; Fri, 12 Jun 2020 15:26:41 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id 9so12827304ljc.8
        for <bpf@vger.kernel.org>; Fri, 12 Jun 2020 15:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GfWJSngy8HDjFdSZASf13wE0p9t43THwA9uZvUmPKzk=;
        b=arzRshuGZiA3vr3L1aBP1DxPnQGJG7tLAp26RCNl75t3Yktqid7hfizB5uh/GH4dYm
         36wdDJq+npWIf7amQy7A0f0v49xnoZwwFMCXld7e0sF2esm531oeMjjN4C3GIA5dap4H
         jZcnh0fpY8qD8EyFibOw+23mB4KzXRHmL6Dpehmf9K3HILdF+i76cwI1qpcKP8fa7fWf
         hstaWos1pR25wPmMZ7SAY+uAxSp9LUfZtM8Ain0Ds3mXQsmpup71YsgKx59PdIJooJ+f
         fX+hD2ViraBsjIViuXkiBxyyzNaR/UZKOv/WJQ0Zxjgwp9h7ecO5GJQ+Rb2jiwLbFYw8
         t4QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GfWJSngy8HDjFdSZASf13wE0p9t43THwA9uZvUmPKzk=;
        b=UuwdMzg54kN2MZ1C78k12b/AQ2rY3QA67T74MzytJuDffh8zeCqyrIN5iecEEgeOKy
         27NK7f2af/nVEf8WH5qhHEH3OZ876FwP5u3Xn0UZ9tfmsRUZDlEYjK/qXI+2eD4dLiJE
         pmeB+FB8CSuGGh9hx1yHvTMzqegr3wz82lBF/6Ye4D/hBYQ/SHieBguViG5WOp+quHuc
         qGSuk7LnJaY9OL6zobrIq9RumM5iONK9cGfgHU+LEFFHu3JG+RhN5kwBOyHV2lsNEJfm
         APK8sgHFRwzzBpRBGdzPCXzb7K+HDE858AXA82Upaw5yyhz0wxF5q8Ypw1nZ9hxU89Nm
         0oSA==
X-Gm-Message-State: AOAM5311KpHIM0eFNbn3mzN2aKRxYacYjl/SUVC4Rq5+R4gt8BQi+pCu
        xo0uo2gLAx5/Y6akWH7B24DogyTur0V8DWHPwVIk+A==
X-Google-Smtp-Source: ABdhPJztqjRFx848yddQ0i/upBj0dY/loJlriYUEf6GzCuV84QKL45Im/ILMWABaImB8ULhpgx6mkt/VBFoweLtbQxc=
X-Received: by 2002:a2e:974a:: with SMTP id f10mr8128753ljj.283.1592000799572;
 Fri, 12 Jun 2020 15:26:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200612000857.2881453-1-rdna@fb.com>
In-Reply-To: <20200612000857.2881453-1-rdna@fb.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Fri, 12 Jun 2020 15:26:28 -0700
Message-ID: <CAADnVQLmBvtNXXuF0H0kPWUcPYj4cLAo1o8VYyVj0mmddN+JDA@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: Fix memlock accounting for sock_hash
To:     Andrey Ignatov <rdna@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jun 11, 2020 at 5:09 PM Andrey Ignatov <rdna@fb.com> wrote:
>
> Add missed bpf_map_charge_init() in sock_hash_alloc() and
> correspondingly bpf_map_charge_finish() on ENOMEM.
>
> It was found accidentally while working on unrelated selftest that
> checks "map->memory.pages > 0" is true for all map types.
>
> Before:
>         # bpftool m l
>         ...
>         3692: sockhash  name m_sockhash  flags 0x0
>                 key 4B  value 4B  max_entries 8  memlock 0B
>
> After:
>         # bpftool m l
>         ...
>         84: sockmap  name m_sockmap  flags 0x0
>                 key 4B  value 4B  max_entries 8  memlock 4096B
>
> Fixes: 604326b41a6f ("bpf, sockmap: convert to generic sk_msg interface")
> Signed-off-by: Andrey Ignatov <rdna@fb.com>

That's a nasty one. Good catch.
Applied.
