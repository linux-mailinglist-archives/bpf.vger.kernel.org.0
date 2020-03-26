Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91E5F193C81
	for <lists+bpf@lfdr.de>; Thu, 26 Mar 2020 11:05:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727738AbgCZKFH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 26 Mar 2020 06:05:07 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:46328 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727721AbgCZKFH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 26 Mar 2020 06:05:07 -0400
Received: by mail-ot1-f65.google.com with SMTP id 111so5161831oth.13
        for <bpf@vger.kernel.org>; Thu, 26 Mar 2020 03:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UlcZWIlxhz7dkj5Sk1YefU5cEKhQZdlCQwM3NnWssoI=;
        b=xQXJfczI3QagEO0IhlRlnlbsa80cwFwCH+6bh8OZLLlFXPU+lYU7XMRBYcJFZXkEym
         g9gtLv7SBMSfTvQm2k+3mctdf0AxUMQPLiPxzB+bp0RCcKh5flxyC3KO+uuCMgPACk69
         v/TvaQRLCjdg4jh+AxFuM9CbzI72vKzYs2hCk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UlcZWIlxhz7dkj5Sk1YefU5cEKhQZdlCQwM3NnWssoI=;
        b=FsWfKWcd3T0B/dMRPr/mPGdKZmr81n27x2NPOzNFSGxX7dAgQ0ddNiQadZZmNhst1S
         SctYnVpaaKCheSnscSUpozyJlMwHtHM6WH88l0AGfGbzBgYufwBZysZfM+5HzkNPXPFe
         gDkAIpXXitscKtWgIqpA59O9trrcUfaVWc2ovAUn54NxEWZ44cfk5/iw/2ouGy9d7+Pb
         reUP4RVyIGGiIFaMAPKvLfmQdoETswjnTrn9EoGFmrvEvytSe1xQJPJhdEiddenqS59j
         4ELeQZkWXIzhxC5PRW8cB3lBxf7mbhe98vze6nvkeJOtbxCddu2nA9xH/pMymJUtekyo
         iGLQ==
X-Gm-Message-State: ANhLgQ3Y4Kk7w8JgazBl5uni+BrXqIHLd+hbpIbxZEM0anIFctLesaNd
        vaGKRVTJhoFKbiT2y+aGrToiFflqseAXVyAThwCiQQ==
X-Google-Smtp-Source: ADFU+vtx4vBn0+Hxg/CuqqXJIdJojm1skL1otcu+GaAm4Pa8iE80exXpKIONl1C1mWjtqvJf6+3XIRgnC9o8S2oB3rs=
X-Received: by 2002:a4a:aa44:: with SMTP id y4mr711862oom.74.1585217104862;
 Thu, 26 Mar 2020 03:05:04 -0700 (PDT)
MIME-Version: 1.0
References: <158462359206.164779.15902346296781033076.stgit@toke.dk>
 <158462359315.164779.13931660750493121404.stgit@toke.dk> <20200319155236.3d8537c5@kicinski-fedora-PC1C0HJN>
 <875zez76ph.fsf@toke.dk> <20200320103530.2853c573@kicinski-fedora-PC1C0HJN>
 <5e750bd4ebf8d_233f2ab4c81425c4ce@john-XPS-13-9370.notmuch>
 <CAEf4BzbWa8vdyLuzr_nxFM3BtT+hhzjCe9UQF8Y5cN+sVqa72g@mail.gmail.com>
 <87tv2f48lp.fsf@toke.dk> <CAEf4BzYutqP0yAy-KyToUNHM6Z-6C-XaEwK25pK123gejG0s9Q@mail.gmail.com>
 <87h7ye3mf3.fsf@toke.dk> <CAEf4BzY+JsmxCfjMVizLWYU05VS6DiwKE=e564Egu1jMba6fXQ@mail.gmail.com>
 <87tv2e10ly.fsf@toke.dk> <CAEf4BzY1bs5WRsvr5UbfqV9UKnwxmCUa9NQ6FWirT2uREaj7_g@mail.gmail.com>
 <87369wrcyv.fsf@toke.dk> <CAEf4BzZKvuPz8NZODYnn4DOcjPnj5caVeOHTP9_D3=wL0nVFfw@mail.gmail.com>
In-Reply-To: <CAEf4BzZKvuPz8NZODYnn4DOcjPnj5caVeOHTP9_D3=wL0nVFfw@mail.gmail.com>
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Thu, 26 Mar 2020 10:04:53 +0000
Message-ID: <CACAyw9-FrwgBGjGT1CYrKJuyRJtwn0XUsifF_uR6LpRbcucN+A@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/4] xdp: Support specifying expected existing
 program when attaching XDP
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Andrey Ignatov <rdna@fb.com>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 26 Mar 2020 at 00:16, Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
>
[...]
>
> Those same folks have similar concern with XDP. In the world where
> container management installs "root" XDP program which other user
> applications can plug into (libxdp use case, right?), it's crucial to
> ensure that this root XDP program is not accidentally overwritten by
> some well-meaning, but not overly cautious developer experimenting in
> his own container with XDP programs. This is where bpf_link ownership
> plays a huge role. Tupperware agent (FB's container management agent)
> would install root XDP program and will hold onto this bpf_link
> without sharing it with other applications. That will guarantee that
> the system will be stable and can't be compromised.

Thanks for the extensive explanation Andrii.

This is what I imagine you're referring to: Tupperware creates a new network
namespace ns1 and a veth0<>veth1 pair, moves one of the veth devices
(let's says veth1) into ns1 and runs an application in ns1. On which veth
would the XDP program go?

The way I understand it, veth1 would have XDP, and the application in ns1 would
be prevented from attaching a new program? Maybe you can elaborate on this
a little.

Lorenz

-- 
Lorenz Bauer  |  Systems Engineer
6th Floor, County Hall/The Riverside Building, SE1 7PB, UK

www.cloudflare.com
