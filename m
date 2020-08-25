Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F5EE251F62
	for <lists+bpf@lfdr.de>; Tue, 25 Aug 2020 20:56:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbgHYSz7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 Aug 2020 14:55:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbgHYSz5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 Aug 2020 14:55:57 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BB9CC061756
        for <bpf@vger.kernel.org>; Tue, 25 Aug 2020 11:55:56 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id q132so3152666iod.7
        for <bpf@vger.kernel.org>; Tue, 25 Aug 2020 11:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w9uk4AMLpvzRAgzq0rqHpsTXVWbRiA2GeYuDtu/sc0s=;
        b=uUs54mDsCzNMq6oM+OHwokxMNdLcMeL723VOZvI9OBiLh6Uganid+kexMgqvabfxm5
         icbGpodVRZgsqpBW8/ccZxX9Xwoq1+J+7ar/QWmxgjKhTUR96ejFDrEjy/aO15wNZglD
         XxGIV7rCwfG4Sw3IrnyC3l7AVwlITjxNZDKaXet5eogwSjqgcheDVZeunE+xopwwyOnf
         wzQLgYrJ0kZ5XZHgJwLyJUVvA/UwHztMVYDso7KZSlFUsFBYJKN7wPZXFIEOD8g6n6f6
         ClETrR+hQVjbWIdTrzvUxKcn7BG8eiVhydS1prRnL6BXJam6k1gu1SiIKXt6rc3hv5me
         VfeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w9uk4AMLpvzRAgzq0rqHpsTXVWbRiA2GeYuDtu/sc0s=;
        b=DssmGGc2NAoWkNxhYgFAnwRrWPvpZr4EbOTY4L62Zi9hRzA2SibUQhN4mnEnZGlGjA
         nAzqYlUpUj6ezAja8Le8OCXLaP5z9f1zf37GMYyjWcsMoY4AiQrePtOYUKVUUmPdrDBO
         1JD0gxlbkL6uXseLeZLKw+pt2FoRBxlUDTVhwjEnKzvGreHD9swrMVtnqsl4S5W3+pg8
         jV2ixr2HpSyNhg3UK6FtWmJ43omYnyOFdyag4UnPAvvsYCZmVMgys3Fwc4imAYjP1YqB
         Rj9NokkrE3+KL2RVs6aTZMDdsWlA0bbGNJYn+F3EAIGx7XiXdWjVBZyNfy8N80TItlRh
         38Fw==
X-Gm-Message-State: AOAM531nBFnm4Btdsac5C0F7Glwcl16RqIiTQLTJ/c/58iiDpuZ6jy0k
        b5LKTvq49Z4XsRYOBm6cle6l/JuhokD25Z+LelekaQ==
X-Google-Smtp-Source: ABdhPJx+ob/M28pOeAl3kt6mLnGqklY78HLbZa/gq1HlEJ8Yxtco7WcCkPUTffmLLFlreoxix4kFWnNHV3it3rBtNl4=
X-Received: by 2002:a6b:6204:: with SMTP id f4mr9990861iog.56.1598381755631;
 Tue, 25 Aug 2020 11:55:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200821151544.1211989-1-nicolas.rybowski@tessares.net> <20200824220100.y33yza2sbd7sgemh@ast-mbp.dhcp.thefacebook.com>
In-Reply-To: <20200824220100.y33yza2sbd7sgemh@ast-mbp.dhcp.thefacebook.com>
From:   Nicolas Rybowski <nicolas.rybowski@tessares.net>
Date:   Tue, 25 Aug 2020 20:55:43 +0200
Message-ID: <CACXrtpQCE-Yp9=7fbH9sB7-4k-OO12JD18JU=9GL_sYHcmnDtA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/3] bpf: add MPTCP subflow support
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Mat Martineau <mathew.j.martineau@linux.intel.com>,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        mptcp@lists.01.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Alexei,

Thanks for the feedback!

On Tue, Aug 25, 2020 at 12:01 AM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Aug 21, 2020 at 05:15:38PM +0200, Nicolas Rybowski wrote:
> > Previously it was not possible to make a distinction between plain TCP
> > sockets and MPTCP subflow sockets on the BPF_PROG_TYPE_SOCK_OPS hook.
> >
> > This patch series now enables a fine control of subflow sockets. In its
> > current state, it allows to put different sockopt on each subflow from a
> > same MPTCP connection (socket mark, TCP congestion algorithm, ...) using
> > BPF programs.
> >
> > It should also be the basis of exposing MPTCP-specific fields through BPF.
>
> Looks fine, but I'd like to see the full picture a bit better.
> What's the point of just 'token' ? What can be done with it?

The idea behind exposing only the token at the moment is that it is
the strict minimum required to identify all subflows linked to a
single MPTCP connection. Without that, each subflow is seen as a
"normal" TCP connection and it is not possible to find a link between
each other.
In other words, it allows the collection of all the subflows of a
MPTCP connection in a BPF map and then the application of per subflow
specific policies. More concrete examples of its usage are available
at [1].

We try to avoid exposing new fields without related use-cases, this is
why it is the only one currently. And this one is very important to
identify MPTCP connections and subflows.

> What are you thinking to add later?

The next steps would be the exposure of additional subflow context
data like the backup bit or some path manager fields to allow more
flexible / accurate BPF decisions.
We are also looking at implementing Packet Schedulers [2] and Path
Managers through BPF.
The ability of collecting all the paths available for a given MPTCP
connection - identified by its token - at the BPF level should help
for such decisions but more data will need to be exposed later to take
smart decisions or to analyse some situations.

I hope it makes the overall idea clearer.

> Also selftest for new feature is mandatory.

I will work on the selftests to add them in a v2. I was not sure a new
selftest was required when exposing a new field but now it is clear,
thanks!


[1] https://github.com/multipath-tcp/mptcp_net-next/tree/scripts/bpf/examples
[2] https://datatracker.ietf.org/doc/draft-bonaventure-iccrg-schedulers/
