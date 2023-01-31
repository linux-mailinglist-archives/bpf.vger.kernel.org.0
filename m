Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC38A6822A9
	for <lists+bpf@lfdr.de>; Tue, 31 Jan 2023 04:14:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbjAaDOY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 30 Jan 2023 22:14:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbjAaDON (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 30 Jan 2023 22:14:13 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51DCB37B5A
        for <bpf@vger.kernel.org>; Mon, 30 Jan 2023 19:13:39 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id ud5so37850639ejc.4
        for <bpf@vger.kernel.org>; Mon, 30 Jan 2023 19:13:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cRszjgR7Gvq8HchX0JkJbdxjWYy4gbl0N0FXBwYq9b4=;
        b=p+iK3jjQG+GQKcLDgLEBM25new4Lf2u+PMs29OC39TQoE1KJZrHkkLvTNmLme2rzk4
         89qNK9QnDDG2+dJ6tLh8r8XjLCY2Tl6maC/xM30z1IAGlOoYza2iIIctM9JPM2F5YbOT
         h1Jzacpz3bfvDm24gckvU74WI6TAD/74A6rCUKWK+4uG/Rrh8Y+xIbcwK5giF2PPtMQV
         Z2ImgY/W5FSnMNHYbjFWbKfUmFuI5g/GaMBKwo5hUDZlN7Y+TfRibpSjZZ6Ye18yNPcj
         WvZDPs8f8pnqeSLnU3gQHxa4T3KD2NmGluGIPjJh7tlE7aRSS69U8SZXDS6nTMpfmLn0
         FMHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cRszjgR7Gvq8HchX0JkJbdxjWYy4gbl0N0FXBwYq9b4=;
        b=sUfHjsEJ77WoyMj2+V+8uZfZzUdBZu7RG8/wC6q97YXa4luv3sR+ToU0NTDk6UbWZS
         zJEQKg/1GPKL/txmyNwBffDScCUk8eEmVTzcu++3D/nS8oGiGdIaA8Ro9eQpRQuliNzc
         czUTzlcHYfRO614y9xVjIHTMB8r8uay2p7vwGXhWeTzrh2v3hwmGjhjLjfrUSo7XC3Tp
         2fweKSSBZvWRHvpa2sozIrsOv+fctkBXexSdJ5aSHe7xmJAxCzQVrhiJi6Go1FDOzEMw
         kyc3BoQ6mNtB0g6c/peSu9GSfMS6bHQjufQ2TVwSQ1am6wV/ADV/r8BkxjVy589/oPax
         LG8w==
X-Gm-Message-State: AO0yUKV47XznDzEY9r0GAXl4yJZa3/+tlqxxxWRcd1J96dMmgSokA9p2
        NFW036c4jRgAJhkJ7gFcXInC2OwBC7ySlpSPsxY=
X-Google-Smtp-Source: AK7set+yi2rnbb5+oFf+EMXxDe56yVrdQ0vJPBpCC8mSrjlE4t3iRXP03mYgCSGzRpzEsynOe+hQrGURfYJ9DdH9jaE=
X-Received: by 2002:a17:906:8514:b0:878:786e:8c39 with SMTP id
 i20-20020a170906851400b00878786e8c39mr4660833ejx.105.1675134817095; Mon, 30
 Jan 2023 19:13:37 -0800 (PST)
MIME-Version: 1.0
References: <20230129190501.1624747-1-iii@linux.ibm.com> <CAADnVQL4Kmk-Hz5XB_AiVC+xVBhVvBqBZTTtedAJC5op2xGD6g@mail.gmail.com>
 <32bf5c1fc3dcfcf735f34f83e89cbb821878b931.camel@linux.ibm.com>
In-Reply-To: <32bf5c1fc3dcfcf735f34f83e89cbb821878b931.camel@linux.ibm.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Mon, 30 Jan 2023 19:13:25 -0800
Message-ID: <CAADnVQ+f3_AdYjvOCHystXe1vEmXzpABbLzU4tLZD7Wuu1CCgA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 0/8] Support bpf trampoline for s390x - CI issue
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Manu Bretelle <chantr4@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jan 30, 2023 at 10:56 AM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
>
> On Sun, 2023-01-29 at 19:28 -0800, Alexei Starovoitov wrote:
> > On Sun, Jan 29, 2023 at 11:05 AM Ilya Leoshkevich <iii@linux.ibm.com>
> > wrote:
> > >
> > > v2:
> > > https://lore.kernel.org/bpf/20230128000650.1516334-1-iii@linux.ibm.com/#t
> > > v2 -> v3:
> > > - Make __arch_prepare_bpf_trampoline static.
> > >   (Reported-by: kernel test robot <lkp@intel.com>)
> > > - Support both old- and new- style map definitions in sk_assign.
> > > (Alexei)
> > > - Trim DENYLIST.s390x. (Alexei)
> > > - Adjust s390x vmlinux path in vmtest.sh.
> > > - Drop merged fixes.
> >
> > It looks great. Applied.
> >
> > Sadly clang repo is unreliable today. I've kicked BPF CI multiple
> > times,
> > but it didn't manage to fetch the clang. Pushed anyway.
> > Pls watch for BPF CI failures in future runs.
>
> I think this is because llvm-toolchain-focal contains llvm 17 now.
> So we need to either use llvm-toolchain-focal-16, or set
> llvm_default_version=16 in libbpf/ci.

Yep. That was fixed.
Looks like only one test is failing on s390:
test_synproxy:PASS:./xdp_synproxy --iface tmp1 --single 0 nsec
expect_str:FAIL:SYNACKs after connection unexpected SYNACKs after
connection: actual '' != expected 'Total SYNACKs generated: 1\x0A'

#284/1 xdp_synproxy/xdp:FAIL
#284 xdp_synproxy:FAIL
Summary: 260/1530 PASSED, 31 SKIPPED, 1 FAILED
