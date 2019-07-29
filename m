Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 541AB79CFA
	for <lists+bpf@lfdr.de>; Tue, 30 Jul 2019 01:46:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727903AbfG2XqG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 29 Jul 2019 19:46:06 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:36815 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727320AbfG2XqG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 29 Jul 2019 19:46:06 -0400
Received: by mail-qt1-f195.google.com with SMTP id z4so61324617qtc.3
        for <bpf@vger.kernel.org>; Mon, 29 Jul 2019 16:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rxfO89GAqnWpNa+gHYinqKFlIkSyjQFFjUEDHpm4UDs=;
        b=Xg9rYTWjN7i1NFMI9MKtIbmbtRAG17R8tXDSq2lLNjG8w/D2QdTSTiVj7oWgNrBbTC
         ih7bjZP0X614qJ5f60gz4h82EwHRwkzsQ7ORIJ32MgUM+glQaHmEPoUZz67+zeJFq9a6
         zQWl6JvrbCBLMmn4ou6k12BQOOWJKAHz7MNUjooOLRfI+RO6GqWZg1eccx45zUQXOXPW
         1ihzFZUzhn0R8IQ+ldqsAMb+DiwyxBiAdp1vO0ZJGf0WOY/HuytrJDxeya0SMgnJi5qH
         +IhoptgrEnHm3oKpWnzufoRLv8S+8HaPto9dNzPlq657Q1KCbL7Xx5sfi0ZAgSFVrKM7
         GDEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rxfO89GAqnWpNa+gHYinqKFlIkSyjQFFjUEDHpm4UDs=;
        b=BKvcGf2UR2Gne+mDuya3+k7SdIBdPMddt2HkvSmXhs7TAboCuwJ66lyuW3S6yFEGGZ
         D/atlrSNu3I41vJaSap0yhLO3w1l+J+WBvi643rEyCWoputQnsVldfaq/zt6K0MER/0w
         oyZHOMKvzV9tfNLNp18A3uiJ15JFFkeSzvfuL5VrqZruGcwTOc3yR9tgK4p5Rpd+wcXo
         ucim2vw3t6dhpqctZBAMZylsaVGxp0QVLlHhbYFmVnlFznfZ9WHumlYIZgtn4VnvA1bB
         Pn2uykBMSPcSNvYPBtwMGyBgtcZXYWsqPZQA3gTQI4MqlhThoc6avLtsTDQ80Vlp3aIY
         HtIA==
X-Gm-Message-State: APjAAAUeh/ahE5OIQd83jBXXbBHj1tU/KwhZjbPEaqB9Myy2dYeC1cWW
        Gc0qqKKbu1/gix+uhY5dZfsTOnTvU8NRmAH6ZOYLLg==
X-Google-Smtp-Source: APXvYqywMOcexq9azID7HyD8gsfiEFE4pksUJ01A/EV9kPhUX3L2Otobd/ZEt09MYnldesg8HgaS+FPNmiEl0qIUWXM=
X-Received: by 2002:a0c:ae24:: with SMTP id y33mr81349689qvc.106.1564443965025;
 Mon, 29 Jul 2019 16:46:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190729165918.92933-1-ppenkov.kernel@gmail.com> <20190729204755.iu5wp3xisu42vkky@ast-mbp>
In-Reply-To: <20190729204755.iu5wp3xisu42vkky@ast-mbp>
From:   Petar Penkov <ppenkov@google.com>
Date:   Mon, 29 Jul 2019 16:45:53 -0700
Message-ID: <CAG4SDVV9oBYkXqof=FoD0DeRY=+tSwZo3E1jhqMnF8F8+bVTbg@mail.gmail.com>
Subject: Re: [bpf-next,v2 0/6] Introduce a BPF helper to generate SYN cookies
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Petar Penkov <ppenkov.kernel@gmail.com>,
        Networking <netdev@vger.kernel.org>, bpf@vger.kernel.org,
        "David S . Miller" <davem@davemloft.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Eric Dumazet <edumazet@google.com>, lmb@cloudflare.com,
        Stanislav Fomichev <sdf@google.com>,
        =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jul 29, 2019 at 1:48 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Jul 29, 2019 at 09:59:12AM -0700, Petar Penkov wrote:
> > From: Petar Penkov <ppenkov@google.com>
> >
> > This patch series introduces a BPF helper function that allows generating SYN
> > cookies from BPF. Currently, this helper is enabled at both the TC hook and the
> > XDP hook.
> >
> > The first two patches in the series add/modify several TCP helper functions to
> > allow for SKB-less operation, as is the case at the XDP hook.
> >
> > The third patch introduces the bpf_tcp_gen_syncookie helper function which
> > generates a SYN cookie for either XDP or TC programs. The return value of
> > this function contains both the MSS value, encoded in the cookie, and the
> > cookie itself.
> >
> > The last three patches sync tools/ and add a test.
> >
> > Performance evaluation:
> > I sent 10Mpps to a fixed port on a host with 2 10G bonded Mellanox 4 NICs from
> > random IPv6 source addresses. Without XDP I observed 7.2Mpps (syn-acks) being
> > sent out if the IPv6 packets carry 20 bytes of TCP options or 7.6Mpps if they
> > carry no options. If I attached a simple program that checks if a packet is
> > IPv6/TCP/SYN, looks up the socket, issues a cookie, and sends it back out after
> > swapping src/dest, recomputing the checksum, and setting the ACK flag, I
> > observed 10Mpps being sent back out.
>

Thank you for reviewing this so quickly!
> Is it 10m because trafic gen is 10m?
Yes, I believe so.

> What is cpu utilization at this rate?
> Is it cpu or nic limited if you crank up the syn flood?
> Original 7M with all cores or single core?
My receiver was configured with 16rx queues and 16 cores. 7M all cores
are at 100% so I believe this case is CPU limited. At XDP, all cores
are at roughly 40%. I couldn't reliably generate higher SYN flood rate
than that, and the highest numbers I could see for XDP did not go past
10.65Mpps with ~42% utilization on each core. I think I am hitting a
NIC limit here since the CPUs are free.


>
> The patch set looks good to me.
> I'd like Eric to review it one more time before applying.
>
