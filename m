Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7241D1EC591
	for <lists+bpf@lfdr.de>; Wed,  3 Jun 2020 01:21:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728285AbgFBXVD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 2 Jun 2020 19:21:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727011AbgFBXVC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 2 Jun 2020 19:21:02 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FCACC08C5C2
        for <bpf@vger.kernel.org>; Tue,  2 Jun 2020 16:21:02 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id d1so590846ila.8
        for <bpf@vger.kernel.org>; Tue, 02 Jun 2020 16:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mforney-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=rKLwbDj0Nm8UB8U3LBRjaFhNE/ibgWumyiHSHHsuajI=;
        b=sc4v2U5d8vQlexafU7mTJ1c0h9lF0UrIOSIcY8kJcHY7zHVzolCwLZHC9VrLISRD9q
         ZzWDc8BjLytNhe+KpuKsZ5lYSfSsp3QhxKC58ad/B5fkfhUXWgA9r+KLPmpuA4wWzQ2j
         WM9fDoGz3tTSHNWMFgDtZeFmq7Q4C4ffMAwI4P7FYbCJTT8/B45GwlfD5ET8/FWJ17tV
         4Htg4wO90KnCmdjrl9M42ilWDCjOul5YITEsTC5dkQwTI0U7kLTOrAuuLGghF5hDNbYQ
         nDn+HKPbtEkgo0nqhpcCFJY6IpzPOKX7M/P2aiKyNiaAbozllRbxOCmA6X8Z7mNZ11PE
         iXvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=rKLwbDj0Nm8UB8U3LBRjaFhNE/ibgWumyiHSHHsuajI=;
        b=T3tVwiunfWHLTTOlvnPwIT1J/bwaPhmgYyWI9r2rdBvZkJcRAZxxeT62vbWGxiZqHd
         ckj7sW673Z6s6tSpBzkxbHT+B3vsRS0fM5cIOPHdBCE/TfMXQK2xtjUZnJsDDBOk+GCc
         /GNoY+Ar2Ah855yAD83lLaDOjXTHvQPzu4DN1a8ZKq4PpdbjS/zEwINJ9tOpq0vqd29v
         IUEC7ewXevY1zf1VThZ8Jf+iwjyGDglT+NPMQbc197gNEeUYABl0vFGAbpjrxhC+608p
         F6y5kBsDhsqJTuLeF5yCdSYi4vBMeAUqS9t7jZREgEipeMJ5cQWZYdgM2TT/Ecy+6jqT
         ozaA==
X-Gm-Message-State: AOAM530xK/2MVofRsP256xM3FxXQ9XMsTRO6huITQLazjO+Oc2IVEhyD
        idgGfjcsneFXV1Bqpctd1fUSu+2NxiU59jm+T8aHAQ==
X-Google-Smtp-Source: ABdhPJyU5GjMh5Pz9ddkKuUVlM4AEBS535l20xZroynV46Yl/4egt2hFWdCTfTTuEu9XbC3QBw28pDIYY9+vHKwnAEw=
X-Received: by 2002:a92:2a06:: with SMTP id r6mr1457141ile.121.1591140061496;
 Tue, 02 Jun 2020 16:21:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6638:150:0:0:0:0 with HTTP; Tue, 2 Jun 2020 16:21:00
 -0700 (PDT)
X-Originating-IP: [73.70.188.119]
In-Reply-To: <20200602230720.hf2ysnlssg67cpmw@ast-mbp.dhcp.thefacebook.com>
References: <20200303003233.3496043-1-andriin@fb.com> <20200303003233.3496043-2-andriin@fb.com>
 <fb80ddac-d104-d0b7-8bed-694d20b62d61@iogearbox.net> <CAEf4BzZWXRX_TrFSPb=ORcfun8B+GdGOAF6C29B-3xB=NaJO7A@mail.gmail.com>
 <87blpc4g14.fsf@toke.dk> <945cf1c4-78bb-8d3c-10e3-273d100ce41c@iogearbox.net>
 <CAGw6cBuCwmbULDq2v76SWqVYL2o8i+pBg7JnDi=F+6Wcq3SDTA@mail.gmail.com>
 <20200602191703.xbhgy75l7cb537xe@ast-mbp.dhcp.thefacebook.com>
 <CAGw6cBstsD40MMoHg2dGUe7YvR5KdHD8BqQ5xeXoYKLCUFAudg@mail.gmail.com> <20200602230720.hf2ysnlssg67cpmw@ast-mbp.dhcp.thefacebook.com>
From:   Michael Forney <mforney@mforney.org>
Date:   Tue, 2 Jun 2020 16:21:00 -0700
Message-ID: <CAGw6cBuF8Dj-22bH=ryL+17N48pwMD5hN49sH4AHYYyMm2xgtg@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 1/3] bpf: switch BPF UAPI #define constants
 used from BPF program side to enums
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Andrii Nakryiko <andriin@fb.com>, bpf <bpf@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>,
        Alexei Starovoitov <ast@fb.com>,
        Kernel Team <kernel-team@fb.com>, Yonghong Song <yhs@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 2020-06-02, Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
> the enum definition of BPF_F_CTXLEN_MASK is certainly within standard.
> I don't think kernel should adjust its headers because some compiler
> is failing to understand C standard.

This is not true. See C11 6.7.2.2p2: "The expression that defines the
value of an enumeration constant shall be an integer constant
expression that has a value representable as an int."

You can also see this with gcc if you turn on -Wpedantic and include
it in a way such that warnings are not silenced:

$ gcc -Wpedantic -x c -c -o /dev/null /usr/include/linux/bpf.h
/usr/include/linux/bpf.h:76:7: warning: ISO C forbids zero-size array
'data' [-Wpedantic]
   76 |  __u8 data[0]; /* Arbitrary size */
      |       ^~~~
/usr/include/linux/bpf.h:3220:22: warning: ISO C restricts enumerator
values to range of 'int' [-Wpedantic]
 3220 |  BPF_F_INDEX_MASK  = 0xffffffffULL,
      |                      ^~~~~~~~~~~~~
/usr/include/linux/bpf.h:3221:23: warning: ISO C restricts enumerator
values to range of 'int' [-Wpedantic]
 3221 |  BPF_F_CURRENT_CPU  = BPF_F_INDEX_MASK,
      |                       ^~~~~~~~~~~~~~~~
/usr/include/linux/bpf.h:3223:23: warning: ISO C restricts enumerator
values to range of 'int' [-Wpedantic]
 3223 |  BPF_F_CTXLEN_MASK  = (0xfffffULL << 32),
      |                       ^
/usr/include/linux/bpf.h:3797:8: warning: ISO C forbids zero-size
array 'args' [-Wpedantic]
 3797 |  __u64 args[0];
      |        ^~~~
$

-Michael
