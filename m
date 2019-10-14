Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01C0FD68A3
	for <lists+bpf@lfdr.de>; Mon, 14 Oct 2019 19:39:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388571AbfJNRjS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 14 Oct 2019 13:39:18 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:42251 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730466AbfJNRjS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 14 Oct 2019 13:39:18 -0400
Received: by mail-vs1-f68.google.com with SMTP id m22so11315083vsl.9
        for <bpf@vger.kernel.org>; Mon, 14 Oct 2019 10:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=posk.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VoI9PYiBRc2yFBeGZP+9iAWIgLPpQStt5BRdIAs4Iwc=;
        b=LOGjB5VXo3K65wKJyF8xGk0utXSe6PctPDTy1imQpoNczyzCVwIUKJIdfQ5ummqL/N
         d24+K5y1+TJbQ5oPH5lAqfB3xSw7+8G/M/nlZm6Y5psvQ5YiIJIoozwjN7zZ8HTkUZE3
         IJL4+BCk4PcV/zracg933bx8evkNh9A72R193ZZ1g6/tjlaevqyDxf1KzYMceulE0e6q
         jHZIfkK/H+iG9KPKFltQBk5m0BH4lUAlq4LolrqAMVA7jL5UDaNuRl9+E3fjJ/8Vqh/i
         Fb3BlKMHr4ZJCrFRDk9knAd1DH4sjC4gUJNY7RcJ0YvgaCKtV02lqrz37MiHBo1BG9GV
         3bLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VoI9PYiBRc2yFBeGZP+9iAWIgLPpQStt5BRdIAs4Iwc=;
        b=FuDkCvu2h+mn3t79IMe94r+bQAZkXTeK/TpK6sAsJAO6ncaDtRKEHFvbI1S41V9Tdx
         LDpXjsk3IUds2fkHnJ7kBMjAgOhfjj6cfnqs6nWtVMdrNJPQX9Ib6cG7huU3oQjl7/Qa
         VfS+Vo1huW0sFWQ8mnXK0EvWJZu8ip1pl8UNcKLQFCWmfIaShcb7DUbRHuuux1fnUE2z
         sP0beCn3XGM5vwu6zO8FAjUdgidZMXfVcExcrgGgQDMGK69EXxfCqylyD5UFNq5bXg1n
         9fIKP/xh1oMme3fc9dp6flRl9IJYghX56UsEGdUdKTASrSWXPG79gmDB6ee2QDoGKpg4
         eQfg==
X-Gm-Message-State: APjAAAUR8NK/fLMM+IikcCX19YYoPdTj+6ib+rRnTRZXjX2ND7EUNV48
        eqFexnThDeqEzO8a1ZhkEfZ3UO5SsrSiz4zYk1+zgA==
X-Google-Smtp-Source: APXvYqxR4c2e6CtVileO9JfPm9wtZCUMOfQPW71Qva6YMgX83vcteA/M78BLQ0lpjvUSz1wMDHe82YIdxfMVs5dmE5I=
X-Received: by 2002:a05:6102:1252:: with SMTP id p18mr6056039vsg.32.1571074757566;
 Mon, 14 Oct 2019 10:39:17 -0700 (PDT)
MIME-Version: 1.0
References: <111664d58fe4e9dd9c8014bb3d0b2dab93086a9e.1570609794.git.jbenc@redhat.com>
 <CAADnVQKgXnmbEhBd1FvM16RP_i8s7+risvgM9yftwuP2DejFmA@mail.gmail.com>
In-Reply-To: <CAADnVQKgXnmbEhBd1FvM16RP_i8s7+risvgM9yftwuP2DejFmA@mail.gmail.com>
From:   Peter Oskolkov <posk@posk.io>
Date:   Mon, 14 Oct 2019 10:39:06 -0700
Message-ID: <CAFTs51WM7yC3Z2HDGy9APSgqy1LCczQtFVG_y+X0WdxY9WSd9Q@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: lwtunnel: fix reroute supplying invalid dst
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Jiri Benc <jbenc@redhat.com>, bpf <bpf@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        Peter Oskolkov <posk@google.com>,
        Stanislav Fomichev <sdf@google.com>,
        Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Oct 12, 2019 at 9:59 AM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Oct 9, 2019 at 1:31 AM Jiri Benc <jbenc@redhat.com> wrote:
> >
> > The dst in bpf_input() has lwtstate field set. As it is of the
> > LWTUNNEL_ENCAP_BPF type, lwtstate->data is struct bpf_lwt. When the bpf
> > program returns BPF_LWT_REROUTE, ip_route_input_noref is directly called on
> > this skb. This causes invalid memory access, as ip_route_input_slow calls
> > skb_tunnel_info(skb) that expects the dst->lwstate->data to be
> > struct ip_tunnel_info. This results to struct bpf_lwt being accessed as
> > struct ip_tunnel_info.
> >
> > Drop the dst before calling the IP route input functions (both for IPv4 and
> > IPv6).
> >
> > Reported by KASAN.
> >
> > Fixes: 3bd0b15281af ("bpf: add handling of BPF_LWT_REROUTE to lwt_bpf.c")
> > Cc: Peter Oskolkov <posk@google.com>
> > Signed-off-by: Jiri Benc <jbenc@redhat.com>
>
> Peter and other google folks,
> please review.

selftests/bpf/test_lwt_ip_encap.sh passes. Seems OK.

Acked-by: Peter Oskolkov <posk@google.com>
