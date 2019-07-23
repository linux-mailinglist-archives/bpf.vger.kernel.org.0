Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A054671677
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2019 12:45:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730888AbfGWKp5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Jul 2019 06:45:57 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:39238 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728807AbfGWKp5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 23 Jul 2019 06:45:57 -0400
Received: by mail-ot1-f67.google.com with SMTP id r21so37499107otq.6
        for <bpf@vger.kernel.org>; Tue, 23 Jul 2019 03:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ifAD5o3qC0LZV0jAWB/3GFzhZCIz1BYd08PtJdgAdx8=;
        b=plT5+LfTWIAyl1BLAY07aLvlbnitnwqFPCZSoEKnOa8mUKbGO3ZWEjEBPSQYLe6VvQ
         t/q8Pvz7lgl6b/auYIQLqlRUqoorBD4LaeEKUg1bJwhnNUyBpyjFS/PABWvc/sG9jSQh
         RZuQVPh5d2kcDVg3NOPkiDWaMLp1dElI6mavg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ifAD5o3qC0LZV0jAWB/3GFzhZCIz1BYd08PtJdgAdx8=;
        b=sfJQuHPcbZBd86n9YQjpbSLWZ2giiWLFu/3Czdt5lJpFQMLTy16mbPUmoKXpCKcklj
         FmNOyCGs2Q/TGOD5Q1U/5zHMX95GKqTtrHXXERvo/95SZcVO7ctbGeM3Fdpl8ZelJuM0
         5Ti5Fk08zM6GkVh467uScWgrikPiZ3oFCtNn3mbWsBqXKuX4QqTq5JNlmECBivv5xTF9
         FuBDAQQd83grJ0SlPchQyTbRHwaTo3HgwUsCVibI6dhV/RBIxYJZ5zEdIptzAiUrj/+r
         8D80vzQA2VvhZu7f/iEZ2XZN7O27lOG9pcuGWNwyg064ROBUMvG9KBdOZfLjFdJpMuwc
         TYLA==
X-Gm-Message-State: APjAAAXhaaxY1EoTNHuYB5G46hNDzhzhffhhJEGLXX2045xh6rYHJJkN
        yC1q8QPGPsgtEjse8AFYzNi2wt48lnOrcP8CyeNTSA==
X-Google-Smtp-Source: APXvYqxDWD4Oz++4AvfSh24LvjhQx2ERmvlZYFc/l8I5PvD+pZinSRjfcSsUuBWZxY6TlKeZDdZWcIQb5zjshPCsiZ0=
X-Received: by 2002:a9d:1b21:: with SMTP id l30mr25934501otl.5.1563878756320;
 Tue, 23 Jul 2019 03:45:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190627201923.2589391-1-songliubraving@fb.com>
 <20190627201923.2589391-2-songliubraving@fb.com> <21894f45-70d8-dfca-8c02-044f776c5e05@kernel.org>
 <3C595328-3ABE-4421-9772-8D41094A4F57@fb.com> <CALCETrWBnH4Q43POU8cQ7YMjb9LioK28FDEQf7aHZbdf1eBZWg@mail.gmail.com>
 <0DE7F23E-9CD2-4F03-82B5-835506B59056@fb.com> <CALCETrWBWbNFJvsTCeUchu3BZJ3SH3dvtXLUB2EhnPrzFfsLNA@mail.gmail.com>
 <201907021115.DCD56BBABB@keescook> <CALCETrXTta26CTtEDnzvtd03-WOGdXcnsAogP8JjLkcj4-mHvg@mail.gmail.com>
 <4A7A225A-6C23-4C0F-9A95-7C6C56B281ED@fb.com>
In-Reply-To: <4A7A225A-6C23-4C0F-9A95-7C6C56B281ED@fb.com>
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Tue, 23 Jul 2019 11:45:45 +0100
Message-ID: <CACAyw9-YdqBYP7_vzDVH_AQ6Ko71XrDb5-+ZxkASMw-eHJa05A@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 1/4] bpf: unprivileged BPF access via /dev/bpf
To:     Song Liu <songliubraving@fb.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "linux-security@vger.kernel.org" <linux-security@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>, Jann Horn <jannh@google.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 22 Jul 2019 at 21:54, Song Liu <songliubraving@fb.com> wrote:
>
> Hi Andy, Lorenz, and all,
>
> With 5.3-rc1 out, I am back on this. :)
>
> How about we modify the set as:
>   1. Introduce sys_bpf_with_cap() that takes fd of /dev/bpf.
>   2. Better handling of capable() calls through bpf code. I guess the
>      biggest problem here is is_priv in verifier.c:bpf_check().
>
> With this approach, we will be able to pass the fd around, so it should
> also solve problem for Go.

Thanks for picking this up again. I need to figure out what the API
for this would
look like on the Go side, but I think it's a nice solution!

Lorenz

-- 
Lorenz Bauer  |  Systems Engineer
6th Floor, County Hall/The Riverside Building, SE1 7PB, UK

www.cloudflare.com
