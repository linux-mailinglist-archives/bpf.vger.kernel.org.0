Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAD151EA7E4
	for <lists+bpf@lfdr.de>; Mon,  1 Jun 2020 18:38:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726124AbgFAQi4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 1 Jun 2020 12:38:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbgFAQiz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 1 Jun 2020 12:38:55 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46E62C05BD43
        for <bpf@vger.kernel.org>; Mon,  1 Jun 2020 09:38:55 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id e125so4319458lfd.1
        for <bpf@vger.kernel.org>; Mon, 01 Jun 2020 09:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kO0G+H5f/QkgY5NLuf6gKb3xR7z37mkHN8eHNBn9vXY=;
        b=dx7TVpyT24AbG+4VhHGgFuCqSjXkrgeZJh4b96uzc4zKkCQdlyLeTOG8I+5q6nVRO6
         sZAjk0dCP1mbTC4xXi9U1+WSw2E2N2CaXR7KZQRjNCOonjflCCIUTguXy+v/2el4SbS4
         ZE+WLY2U9uZkhKoG7ZtX4HpdvUl96zgIUUSf9KYNugGw6vGmv/fc0wvCy+7d9ZYpdz2s
         rGkXdTzHYvFJGdyi5D7knzXZphNf+yHQF9KfwtKohzj2jnhoVCxw+bK1BBN11PEjD+/F
         yR0NEM9jzW+pgO4fu0tI7xmfqD8DLUMZs/sopaCwPHjvYsa682kLi8GtxKRPZRA3mWAe
         /u5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kO0G+H5f/QkgY5NLuf6gKb3xR7z37mkHN8eHNBn9vXY=;
        b=V1rUOlsNdPOrrHUaEndGOiW1uac8vWYDj1oS+nkDX+4Xpw37/gwYA6eXN8wdec/FoB
         yBtm+GFKTafylk/5vqGCmqMYEhHK50DvxJ2pj7OPUsqugyZS8+syw6dOJVpyPfWMnBhE
         +qxStG7OOM82eNKJpPi1T6hW6O41Z8DBdi3S50nQp6HJH91HejgIOqJaUKBq7p/ZMV/9
         90MIcTOejM4XExWDPKuI9SsyKErgpBm3wFqG8Z1st6TtFRbozncMD8UIsN96a4zuLH/3
         XCsOSAffXEgX6HJLkIXcr03yhx9wH9UEigyD1h4NNiWOPjCHHXaMEID39FTVxR7bzHmv
         bL2Q==
X-Gm-Message-State: AOAM533Ur7tF/IRJMxk06U+Bg0dVFMWo+pq7DL6J7iunirygmafRo/10
        DptueEUgBXlz5+8FtUfHYJm84WYjPB8RmR7zDts=
X-Google-Smtp-Source: ABdhPJzjFPz8PRVLXGILjGJCi+LM3ugHzLh0t/V1wmzGsd/kf0K6bSI3ehPqRs0KLfFkPXabFN2xEsc61qFefw1uHIA=
X-Received: by 2002:a19:84:: with SMTP id 126mr11585846lfa.174.1591029533693;
 Mon, 01 Jun 2020 09:38:53 -0700 (PDT)
MIME-Version: 1.0
References: <8f6b8979fb64bedf5cb406ba29146c5fa2539267.1576575253.git.ethercflow@gmail.com>
 <cover.1576629200.git.ethercflow@gmail.com> <7464919bd9c15f2496ca29dceb6a4048b3199774.1576629200.git.ethercflow@gmail.com>
 <51564b9e-35f0-3c73-1701-8e351f2482d7@iogearbox.net> <CABtjQmbh080cFr9e_V_vutb1fErRcCvw-bNNYeJHOcah-adFCA@mail.gmail.com>
 <20200116085943.GA270346@krava> <CAJN39ogSo=bEEydp7s34AjtDVwXxw7_hQFrARWE4NXQwRZxSxw@mail.gmail.com>
 <c27d3cc2-f846-8aa9-10fd-c2940e7605d1@iogearbox.net> <20200212152149.GA195172@krava>
 <CABtjQmaDg_kzuDrANQi8rWhZWGarP8OkiZtzi+XWvC-T9Jmz+Q@mail.gmail.com>
In-Reply-To: <CABtjQmaDg_kzuDrANQi8rWhZWGarP8OkiZtzi+XWvC-T9Jmz+Q@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Mon, 1 Jun 2020 09:38:41 -0700
Message-ID: <CAADnVQ+GGjNK+QvT+qc6j0AZ8s4bvY5TDjKtJ4ZEnBEH4c8Uvg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v14 1/2] bpf: add new helper get_fd_path for
 mapping a file descriptor to a pathname
To:     Wenbo Zhang <ethercflow@gmail.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Jiri Olsa <jolsa@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Brendan Gregg <bgregg@netflix.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jun 1, 2020 at 7:17 AM Wenbo Zhang <ethercflow@gmail.com> wrote:
>
> Hi Daniel,
>
> I find https://patchwork.ozlabs.org/project/netdev/patch/7464919bd9c15f2496ca29dceb6a4048b3199774.1576629200.git.ethercflow@gmail.com/
> this PR's current state is Awaiting Upstream. I don't know much about
> this state. I want to ask if this PR will be merged.

This one won't be merged.
Jiri had sent patches based on whitelist approach.
That's a proper direction to address locking concerns.
