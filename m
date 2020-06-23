Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49041204DB0
	for <lists+bpf@lfdr.de>; Tue, 23 Jun 2020 11:18:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732142AbgFWJSO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Jun 2020 05:18:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732011AbgFWJSN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 23 Jun 2020 05:18:13 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90063C061573
        for <bpf@vger.kernel.org>; Tue, 23 Jun 2020 02:18:13 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id b6so19703027wrs.11
        for <bpf@vger.kernel.org>; Tue, 23 Jun 2020 02:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=UnehdSmJu3VpfmqqB8u47UeykU8okvY4+bNOQYSwr8Y=;
        b=LXQXzQKo3KNPMdDvcV5HlHUhcRzbFF1Da7B4mx8PwhpDuenzllpj0h+FBFzyMx/d7w
         s/2HTzu8Ad/lg0r93LYpCvJUeX7mrcUWVpHq5vT2V5Zv5+HTHl3GoaTakL7cVEqi6OzB
         GQpuNHb521sj235p/EVttwpdZr9p5/99r/7sYbns8TUbPvK4h1lDlm0udpsOYsZbyg0o
         YwvhN8lNAJE4PIfbk92qBCShEnPBkmuEuHRYuRbBSTJbTK+0a0UDkKM3IdDRbzYb8jbg
         dk1LCYKAKm3QMXoo6jhya3IYMQaK/gdewY5c7F1+yY7FNrHQiFo3LSyaCjHli0oRvgum
         10qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UnehdSmJu3VpfmqqB8u47UeykU8okvY4+bNOQYSwr8Y=;
        b=Abh0japI9e5YEFFsMbHws/G3OnRgNq6KybcQBL9MGD5ajuY1J09xbkYP7yePV+nT6Y
         ej2SvUvkwai4GagKRyyqQ3B1F2TZCVexVn9nsNtKDyYiQSMb4vBW1PDWOoUtemygIxwq
         6Waz1h2oRqCBm/E1TQ3mgHpunJ/garep4as4isJJP+0enK+DZYpyHRIQafYyPZLZOEtX
         nDmPHScj+b8mK+DzKh6Mhp3viAJ2FInSLv4n/vbeLhJV2JGmO+LR835Gi+ZwDax9OX8w
         zTi2ocwbcn4ptTF/HIAI4tlk3/wLpmBzn2vIZ3/zB0UUcrH0IAdiET7pOSmhhw8QdZB8
         nHTQ==
X-Gm-Message-State: AOAM531h7M9A8PoFWgodkFydHeLZhiA9O7UDhZGiAo/2iV8BQZ2Dxx/S
        eNPdkOR5Mvekw7K/5B5wyDo9mUY1eu5NgNy/Oec=
X-Google-Smtp-Source: ABdhPJyrFZVl5DUJzi6r5oHyshLOkeuxgNYAvc4OUslJGSZLmfKskSVrCIXS/U7VciPd3y0DguyDU0iFzo6HHqmQK3Q=
X-Received: by 2002:a5d:504b:: with SMTP id h11mr16878244wrt.160.1592903892270;
 Tue, 23 Jun 2020 02:18:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200622090824.41cff8a3@hermes.lan> <CAJ+HfNhhpZoeoZC5gS93Lbc5GvDUO9m0RrKNFU=kU0v+AXe=ig@mail.gmail.com>
 <CAJ+HfNgG4dBTf7Ei2CmuedQLnv-nOqpf4Nuep+FB9Oxob+zhdA@mail.gmail.com> <CAPydje_AdWjOoS4AJ5BMyFYLEsNciyNv_8YwkEMbO2B+Co0DfA@mail.gmail.com>
In-Reply-To: <CAPydje_AdWjOoS4AJ5BMyFYLEsNciyNv_8YwkEMbO2B+Co0DfA@mail.gmail.com>
From:   =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>
Date:   Tue, 23 Jun 2020 11:18:00 +0200
Message-ID: <CAJ+HfNjOUsJAOMmz6wq3zoxRQ5HtBjFzkJ64eCWiPWxkFWDGnQ@mail.gmail.com>
Subject: Re: Fw: [Bug 208275] New: kernel hang occasionally while running the
 sample of xdpsock
To:     Yahui Chen <goodluckwillcomesoon@gmail.com>
Cc:     Stephen Hemminger <stephen@networkplumber.org>,
        "Karlsson, Magnus" <magnus.karlsson@intel.com>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>,
        intel-wired-lan <intel-wired-lan@lists.osuosl.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 23 Jun 2020 at 05:45, Yahui Chen <goodluckwillcomesoon@gmail.com> w=
rote:
>
> Hi, Bjorn, Thank your response.
> Could you describe it more clearly? I can not get it exactly.
> Thx.
>

When XDP is enabled, the ixgbe NIC does a (somewhat heavy)
reconfiguration. During the reconfiguration, for some reason, the
rx_buffer->page is NULL in the following call chain:
  ixgbe_down()->ixgbe_clean_all_rx_rings()->ixgbe_clean_rx_ring()->__page_f=
rag_cache_drain()

This results in that when __page_frag_cache_drain() want to touch the
reference counter, you get a NULL pointer dereference.

[277994.329145] BUG: kernel NULL pointer dereference, address: 000000000000=
0034
...
[277994.329428] RIP: 0010:__page_frag_cache_drain+0x5/0x40
[277994.329463] Code: d2 ff ff 31 f6 84 c0 74 04 0f b6 73 51 48 89 df
e8 70 ff ff ff eb dc 48 83 eb 01 eb d0 0f 1f 84 00 00 00 00 00 0f 1f
44 00 00 <f0> 29 77 34 74 01 c3 48 8b 07 55 48 89 e5 a9 00 00 01 00 74
0f 0f

2a:*    f0 29 77 34              lock sub %esi,0x34(%rdi)        <--
trapping instruction

I tried to reproduce the issue, but without success so far. I'll keep
looking for the bug. Hopefully someone from Intel with better insight
into ixgbe can help!


Bj=C3=B6rn
