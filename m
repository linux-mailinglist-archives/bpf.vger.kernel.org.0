Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B0AC36020A
	for <lists+bpf@lfdr.de>; Thu, 15 Apr 2021 07:54:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbhDOFyt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 15 Apr 2021 01:54:49 -0400
Received: from forward5-smtp.messagingengine.com ([66.111.4.239]:51163 "EHLO
        forward5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231167AbhDOFxv (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 15 Apr 2021 01:53:51 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailforward.nyi.internal (Postfix) with ESMTP id 5D8CC19408AD;
        Thu, 15 Apr 2021 01:53:27 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 15 Apr 2021 01:53:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :resent-cc:resent-date:resent-from:resent-message-id:resent-to
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=HvWSRkUEoTmhL8Ze11D6Nr54JSw6fmQK7oJH3XoW2
        Fw=; b=HlbfKVN9Csnc4gHlH+Oxdi5XPx4Kwo9V+8uaJPf3imPNXTAfMEBL+J6N2
        6su3j4vwx1B5h0haF3SvytWX1gibS8STbFkeRB7axOkDl6ouxxyYR4kYciEG5lOM
        07wHwUtF1szp1Kglamqs+hGiaX1usOspHGzvtkAtPyVUlllbnXrNJhbqQ/Obugye
        DQQfRETx/inZNulQq/YhcNABzLlq08da7/Yt99dN3s5x9HKn6HmZJFvCr+Ol78XN
        GPuTkPBz/yRuAB7IPqSLWGQMJKnZsZZuEh5Y0hk3yfmhortYnBNA3ZX72m7QCE/V
        GNzBVZ0tnL4wAflmv4OrwYSg5jc5Q==
X-ME-Sender: <xms:19R3YKJmHn7l5Xh5wJpNLqX1vFbv-jJijCQGeEXlyoQ_IdFj2Xjahg>
    <xme:19R3YCJbdWQvbJ6zu72KOJAtUqaYdUOHCVj-EVlmhE12mGG5MdgCUmj3iPUHgnQVu
    ZFJNgmvaFHJ2gefVMM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudelvddgleeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepufggtgfhjgffgffkfhfvofesthhqmhdthhdtjeenucfhrhhomheptfgrfhgr
    vghlucffrghvihguucfvihhnohgtohcuoehrrghfrggvlhguthhinhhotghosehusghunh
    htuhdrtghomheqnecuggftrfgrthhtvghrnhephfejvdevgffhueelheevuefhveetuedv
    keeuleeuueekhffgffdvgedvffdtteeunecuffhomhgrihhnpehgihhthhhusgdrtghomh
    dpuhgsuhhnthhurdgtohhmnecukfhppedutdejrdduheekrdduheehrdduudenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehrrghfrggvlhguth
    hinhhotghosehusghunhhtuhdrtghomh
X-ME-Proxy: <xmx:19R3YKuxkKyKba_k_KnxpNpDkiEb8awgx9W5l9FeeYwcRxBUFEg3lw>
    <xmx:19R3YPazwtHfb2cNrpP6Vii1q1cl2YeF5TwSujGs_fLn6SuvBXuuuA>
    <xmx:19R3YBZoobRhWGEDeWnXBx6YAVjPCcoJGn4s5C72ERS7CulZ14diIA>
    <xmx:19R3YKlDZCMHzYhprz5YcvJqSL3QyYfkgOceZ2LGqjUo__pTBUPm2A>
Received: from [10.6.2.60] (unknown [107.158.155.11])
        by mail.messagingengine.com (Postfix) with ESMTPA id 97B6A108005F;
        Thu, 15 Apr 2021 01:53:26 -0400 (EDT)
Subject: Re: [PATCH v2 bpf-next][RFC] libbpf: introduce legacy kprobe events
 support
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.21\))
Content-Type: text/plain;
        charset=utf-8
From:   Rafael David Tinoco <rafaeldtinoco@ubuntu.com>
In-Reply-To: <CAEf4BzYQcD8vrTkXSgwBVGhRKvSWM6KyNc07QthK+=60+vUf8w@mail.gmail.com>
Date:   Thu, 15 Apr 2021 02:53:24 -0300
X-Mao-Original-Outgoing-Id: 640158804.7646641-ef317c76875f308633db203a8a67b13d
Content-Transfer-Encoding: quoted-printable
Message-Id: <9B5EDB10-0235-451C-BC12-A3123DC0D496@ubuntu.com>
References: <CAEf4Bzap6qS9_HQZTHJsM-X2VZso+N5xMwa3HNG9ycMW4WXtQg@mail.gmail.com>
 <20210322180441.1364511-1-rafaeldtinoco@ubuntu.com>
 <4BB60234-7970-405C-9447-D19CA6564BC2@ubuntu.com>
 <CAEf4BzaimrGXFrfFVHvV53ta7NwDWsN0YHcDiVJELEnbdjmKdg@mail.gmail.com>
 <045DF0ED-10A2-4D9F-AA01-5CE7E3E95193@ubuntu.com>
 <CAEf4BzbPdH+pV9NpCW+piROOfCme=erGQOHs8XcA_e=pYcV2=g@mail.gmail.com>
 <4F445042-0ECC-4654-B334-E2364B5B9B8D@ubuntu.com>
 <CAEf4BzYQcD8vrTkXSgwBVGhRKvSWM6KyNc07QthK+=60+vUf8w@mail.gmail.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
X-Mailer: Apple Mail (2.3654.60.0.2.21)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


>> Yes, with a small reservation I just found out: function names might
>> change because of GCC optimisations.. In my case I found out that:
>>=20
>> # cat /proc/kallsyms | grep udp_send_skb
>> ffffffff8f9e0090 t udp_send_skb.isra.48
>>=20
>> udp_send_skb probe was not always working because the function name
>> was changed. Then I saw BCC had this issue back in 2018 and is
>> fixing it now:
>>=20
>> https://github.com/iovisor/bcc/issues/1754
>> https://github.com/iovisor/bcc/pull/2930
>>=20
>> So I thought I could do the same: check if function name is the same
>> in /proc/kallsyms or if it has changed and use the changed name if
>> needed (to add to kprobe_events).
>>=20
>> Will include that logic and remove the =E2=80=98enables=E2=80=99.
>=20
> No, please stop adding arbitrary additions. Function renames, .isra
> optimizations, etc - that's all concerns of higher level, this API
> should not try to be smart. It should try to attach to exactly the
> kprobe specified.

:\ how can this be done in a higher level if it needs to be done
runtime at the time the event is being enabled ? skel will contain
hardcoded kprobe names and won=E2=80=99t be able to get runtime =
optimised
symbol names, correct ? (unless bpftool gen generates an intermediate
code to check kallsyms and solve those symbols before calling the lib).

I see BCC has some options for regexing symbol names for the probes=E2=80=A6=
=20
obviously in BCC=E2=80=99s case is simpler.=20

I made it work by checking kallsyms for the exact symbol and,
if not found, for the variants (only for the legacy kprobe event
probe, but it would work for the current one, passing discovered
symbol name for the ioctl attrs. My WIP version (to clarify what I=E2=80=99=
m
saying):

https://paste.ubuntu.com/p/DpqDsGdVff/=
