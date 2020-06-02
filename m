Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73BC91EB396
	for <lists+bpf@lfdr.de>; Tue,  2 Jun 2020 05:04:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725872AbgFBDEO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 1 Jun 2020 23:04:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725841AbgFBDEO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 1 Jun 2020 23:04:14 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D418BC061A0E
        for <bpf@vger.kernel.org>; Mon,  1 Jun 2020 20:04:13 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id z13so1170580vsn.10
        for <bpf@vger.kernel.org>; Mon, 01 Jun 2020 20:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Nj1/Zfe6CLCmcB4vC96tKGMKK1kTnO1emVRZTg8BWQU=;
        b=PtcpGCi6jt0/xF5cyIUdPZnM/WFYmw/q6TPowLoG8W3BXI6wkTO2+lgTI/tPEAeyT3
         az8n9NMq0OpkUdU4BTd46iRVSvK7CkW2/KjY6AZDOLTBq6ANZUhU3gwdIWmQQSzVnT/J
         cLaTWbc7A42ioxU2Py+vJIdRiPoCXzX1K2M20sCBERhitQc2J15uTOUUA7rcTiccCJIj
         z6CpN0SLxXOVFScKGrsRID4KVv5aLOCSi9qjOnbIBwZ3kMmZTKZZRgwTrbCPs+gIvNE7
         8r0t4YhIfYA19t26eEIrB3eT1iw4DfFqx4VLpdS/8PrBJBWai4DHzQdFhNYGaKwc7JGp
         sC2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Nj1/Zfe6CLCmcB4vC96tKGMKK1kTnO1emVRZTg8BWQU=;
        b=jx5lvtB1YSPYvDQpxJrYbyenpl6kZG7lpfIwETcL6O45OQDL+3MaAvM2ne4RAVTL1K
         knkNz0bBoXBbRqO2b9Sgj5mt7wFCIEn7v4pL4d3PjhP8C/X+pHV7ICKtG8C6OZMgBjUU
         45adp4lj7xrW3wu2mV3TzdpgxEg6GUvvCyNV1Fa7CQW864OohQT7MunO/Mao0P+j1luH
         +oDh5af3xfc4GRWDE77r9JFsmKTlyGhQxvWe1qJ9ia/4ZMMsGCpRfn5NxQN1xAJ8suS2
         n6XDH9eDVzqso6Zslb33ThFRrOl1zwyqqUJ7OR5BVg91X8ZwDrnQMDEYUWgpvrYSpHey
         6hsg==
X-Gm-Message-State: AOAM533l0ysURGVFxXyRzUbnMvYewr3ck/EXsmPyUJX+udSXg7uDHyGL
        jVOaW3pOxa6dR2fEzLNvGMLAvoMVJOjLliDxjws=
X-Google-Smtp-Source: ABdhPJxAfROmtO8EaFemNB2sq5AgLJwUEzSwAhitVwuzlW94H3JroHE9Wjsa2P1hWSXVH/K17FBoiaR2PZUJxo66Uzk=
X-Received: by 2002:a67:6441:: with SMTP id y62mr15981681vsb.145.1591067053116;
 Mon, 01 Jun 2020 20:04:13 -0700 (PDT)
MIME-Version: 1.0
References: <8f6b8979fb64bedf5cb406ba29146c5fa2539267.1576575253.git.ethercflow@gmail.com>
 <cover.1576629200.git.ethercflow@gmail.com> <7464919bd9c15f2496ca29dceb6a4048b3199774.1576629200.git.ethercflow@gmail.com>
 <51564b9e-35f0-3c73-1701-8e351f2482d7@iogearbox.net> <CABtjQmbh080cFr9e_V_vutb1fErRcCvw-bNNYeJHOcah-adFCA@mail.gmail.com>
 <20200116085943.GA270346@krava> <CAJN39ogSo=bEEydp7s34AjtDVwXxw7_hQFrARWE4NXQwRZxSxw@mail.gmail.com>
 <c27d3cc2-f846-8aa9-10fd-c2940e7605d1@iogearbox.net> <20200212152149.GA195172@krava>
 <CABtjQmaDg_kzuDrANQi8rWhZWGarP8OkiZtzi+XWvC-T9Jmz+Q@mail.gmail.com> <CAADnVQ+GGjNK+QvT+qc6j0AZ8s4bvY5TDjKtJ4ZEnBEH4c8Uvg@mail.gmail.com>
In-Reply-To: <CAADnVQ+GGjNK+QvT+qc6j0AZ8s4bvY5TDjKtJ4ZEnBEH4c8Uvg@mail.gmail.com>
From:   Wenbo Zhang <ethercflow@gmail.com>
Date:   Tue, 2 Jun 2020 11:04:02 +0800
Message-ID: <CABtjQmYQKf=Kcyk+dVqSkgvsemtcpV_xtcGY-XnQh+9LGt60bw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v14 1/2] bpf: add new helper get_fd_path for
 mapping a file descriptor to a pathname
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Jiri Olsa <jolsa@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Brendan Gregg <bgregg@netflix.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Get it, I'll search Jiri's patches to see how to use that. Thanks.

Alexei Starovoitov <alexei.starovoitov@gmail.com> =E4=BA=8E2020=E5=B9=B46=
=E6=9C=882=E6=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8A=E5=8D=8812:38=E5=86=99=E9=
=81=93=EF=BC=9A
>
> On Mon, Jun 1, 2020 at 7:17 AM Wenbo Zhang <ethercflow@gmail.com> wrote:
> >
> > Hi Daniel,
> >
> > I find https://patchwork.ozlabs.org/project/netdev/patch/7464919bd9c15f=
2496ca29dceb6a4048b3199774.1576629200.git.ethercflow@gmail.com/
> > this PR's current state is Awaiting Upstream. I don't know much about
> > this state. I want to ask if this PR will be merged.
>
> This one won't be merged.
> Jiri had sent patches based on whitelist approach.
> That's a proper direction to address locking concerns.
