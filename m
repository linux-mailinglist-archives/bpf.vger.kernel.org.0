Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF4CA26DC48
	for <lists+bpf@lfdr.de>; Thu, 17 Sep 2020 15:00:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbgIQNAB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Sep 2020 09:00:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727127AbgIQMzJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Sep 2020 08:55:09 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2C7FC06174A
        for <bpf@vger.kernel.org>; Thu, 17 Sep 2020 05:55:03 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id r9so2059497ioa.2
        for <bpf@vger.kernel.org>; Thu, 17 Sep 2020 05:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zU1hG5tz1ucML96oj+7bEtqktjHV+/zxCb6i+SkaiGw=;
        b=te7dc7xblHPDaP1pxrcBg78Q4qmJ0F2BQULVivczWzaSSUA6T1CVRNe5NyFDxdbfmg
         N2WLdE425ld5SxaN0ZmBHBpMS5+cFBM3uoNk+fH0iCHeYn9WvhWuELF+YXbeBQ8lbvq+
         YS1pCvRfM/RmLu+C9+CToww92ajd9/v2lj2YC6wcN/k6NlcsQraynJfykS0x+SR9eqYx
         bgEg4BOTzqZ76ynKwUxaE24N1vWJYWu6ZbbatcTvgMExFKTjeKeDp844xvDr0ZEZ+EGq
         5j2yAC5RFXttIPs+Ce8MBlhqjcwRhfZm0auSDGItTysz8NuQvlwKOrjoryucXmgFb1+W
         w/5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zU1hG5tz1ucML96oj+7bEtqktjHV+/zxCb6i+SkaiGw=;
        b=juZGSwHv999gUw1NE//lfEoVucdJFy2yfnSg6aDMS3NxJfSa7nPPJKUu7oQz6ULRR3
         Kdy1qJmG5Nap5EFUYCxMPt0eARV8D7zjSejpTS71VyVKXaAhY8z6kpynBkXycT2/KflB
         FqguKePikcdnvAqHImUe8QfivNlaCojI9oWOvI9A4sGGBCqZSVkOj7yzTH4GJd4LQl5Z
         GU6pr8Fh0A4Wr1koMj7dHcsR8LqZoNrLGB0JvpWuFwWeKf0O8z/eXm1cSb2o6+bJkvte
         KGY1gTOzRTwMmJNDV/c8U0GM5rXcDSNyCNjeC5W1okgUufUzWVgiuB6e65ppjHLSJJ4g
         sN5w==
X-Gm-Message-State: AOAM532r41kJ/lY2WFX19UT+XoMPfTDnnowOK2zmFUxyekXe5vjnVrk4
        t6WRWSTy1eeu+fXnrdxoyndCe+QIUZjzO+rZAw6WDQ==
X-Google-Smtp-Source: ABdhPJzsHcaDG0KP61yES0GHXoCWmYl8WUU4P/LvEYxDXd1QNesbXIJ1VDldNg9545XpwWkgaZkstgnba4QpB5/rM4c=
X-Received: by 2002:a6b:b787:: with SMTP id h129mr23168970iof.202.1600347301893;
 Thu, 17 Sep 2020 05:55:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200917143846.37ce43a0@carbon>
In-Reply-To: <20200917143846.37ce43a0@carbon>
From:   =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>
Date:   Thu, 17 Sep 2020 05:54:48 -0700
Message-ID: <CANP3RGcxM-Cno=Qw5Lut9DgmV=1suXqetnybA9RgxmW3KmwivQ@mail.gmail.com>
Subject: Re: BPF redirect API design issue for BPF-prog MTU feedback?
To:     Jesper Dangaard Brouer <brouer@redhat.com>
Cc:     Daniel Borkmann <borkmann@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        BPF-dev-list <bpf@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Lorenz Bauer <lmb@cloudflare.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Shaun Crampton <shaun@tigera.io>,
        David Miller <davem@davemloft.net>,
        Marek Majkowski <marek@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Sep 17, 2020 at 5:39 AM Jesper Dangaard Brouer
<brouer@redhat.com> wrote:
>
>
> As you likely know[1] I'm looking into moving the MTU check (for TC-BPF)
> in __bpf_skb_max_len() when e.g. called by bpf_skb_adjust_room(),
> because when redirecting packets to another netdev it is not correct to
> limit the MTU based on the incoming netdev.
>
> I was looking at doing the MTU check in bpf_redirect() helper, because
> at this point we know the redirect to netdev, and returning an
> indication/error that MTU was exceed, would allow the BPF-prog logic to
> react, e.g. sending ICMP (instead of packet getting silently dropped).
> BUT this is not possible because bpf_redirect(index, flags) helper
> don't provide the packet context-object (so I cannot lookup the packet
> length).
>
> Seeking input:
>
> Should/can we change the bpf_redirect API or create a new helper with
> packet-context?
>
>  Note: We have the same need for the packet context for XDP when
>  redirecting the new multi-buffer packets, as not all destination netdev
>  will support these new multi-buffer packets.
>
> I can of-cause do the MTU checks on kernel-side in skb_do_redirect, but
> then how do people debug this? as packet will basically be silently dropp=
ed.
>
>
>
> (Looking at how does BPF-prog logic handle MTU today)
>
> How do bpf_skb_adjust_room() report that the MTU was exceeded?
> Unfortunately it uses a common return code -ENOTSUPP which used for
> multiple cases (include MTU exceeded). Thus, the BPF-prog logic cannot
> use this reliably to know if this is a MTU exceeded event. (Looked
> BPF-prog code and they all simply exit with TC_ACT_SHOT for all error
> codes, cloudflare have the most advanced handling with
> metrics->errors_total_encap_adjust_failed++).
>
>
> [1] https://lore.kernel.org/bpf/159921182827.1260200.9699352760916903781.=
stgit@firesoul/
> --
> Best regards,
>   Jesper Dangaard Brouer
>   MSc.CS, Principal Kernel Engineer at Red Hat
>   LinkedIn: http://www.linkedin.com/in/brouer
>

(a) the current state of the world seems very hard to use correctly,
so adding new apis,
or even changing existing ones seems ok to me.
especially if this just means changing what error code they return

(b) another complexity with bpf_redirect() is you can call it, it can succe=
ed,
but then you can not return TC_ACT_REDIRECT from the bpf program,
which effectively makes the earlier *successful* bpf_redirect() call
an utter no-op.

(bpf_redirect() just determines what a future return TC_ACT_REDIRECT will d=
o)

so if you bpf_redirect to interface with larger mtu, then increase packet s=
ize,
then return TC_ACT_OK, then you potentially end up with excessively large
packet egressing through original interface (with small mtu).

My vote would be to return a new distinct error from bpf_redirect()
based on then current
packet size and interface being redirected to, save this interface mtu
somewhere,
then in operations that increase packet size check against this saved mtu,
for correctness you still have to check mtu after the bpf program is done,
but this is then just to deal with braindead bpf code (that calls
bpf_redirect and returns TC_ACT_OK, or calls bpf_redirect() multiple
times, or something...).

Maciej =C5=BBenczykowski, Kernel Networking Developer @ Google
