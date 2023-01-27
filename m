Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 263AE67EC4C
	for <lists+bpf@lfdr.de>; Fri, 27 Jan 2023 18:19:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235127AbjA0RTi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 27 Jan 2023 12:19:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235125AbjA0RTh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 27 Jan 2023 12:19:37 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96A0E38013
        for <bpf@vger.kernel.org>; Fri, 27 Jan 2023 09:19:36 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id z31so3736756pfw.4
        for <bpf@vger.kernel.org>; Fri, 27 Jan 2023 09:19:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TFmwldwFD9p2HKdCL9aGdEwOzy1vivsnPuQwz9Fy/bc=;
        b=gP/PV4v1hci7Q0WNiMnCCXb6e13qZNYLsm4wLK7mWXYW9w7Saca2QiQ+ajk8rJhNxr
         uxb/apw/jZz/N/cl1v99+3Dc//9DC/nxpBY+WsRAPa8vQ1eVEqo6rhNxoP3w8AOEN7CI
         THceKOtoumEQ13rk7O2r2A8rTeFkm9JWu6/4/kYPaIso85M+xczVaE6B6ADsL4gKJ+fR
         lLdhHe1z7pSvN7/h2wMiAV7AUEtfU2wTzx7LBBFki+iqFiT587W8CimtzlQbM7wL8Rtl
         SuP614KmF1g40fX1ZSnz0oN/qefkrAmEHo5HgrrG5iR++P8r6W2UrXzsCKKfU5FB+AxT
         MqjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TFmwldwFD9p2HKdCL9aGdEwOzy1vivsnPuQwz9Fy/bc=;
        b=FZAgck+NC8qJ7SNBY7DchJuTzA5AeICkclQsoqGF2ZflUk3ArEAV2+zPRloCVhbwRz
         XjrBUxeiyG+G8Ehor+EYCcxQqvQmaWynyhAiw8FTL1mo7P4q1gGTa6vLhmchKNGWoZgp
         z/t+d32fFt83WSDTOoiFchw9PXdmSUHlpmXrDUTmnTnU5yTC5uIhRu/88ic7omeo1IUu
         nx3KlDrseEicGj0D2z4TBNOPZuxuGyqs6BTfRDENthSwoHQmgHRSjDsKZa5tPdViu13C
         avTKV+Wk81NToqAEhlSB1SbLRiTiG2NVtwCrLpARrL67i6MTPylG5Et4JLX4dOr9IifQ
         ximw==
X-Gm-Message-State: AFqh2kp7l0MweOH1/g6Ms8LL61nmwQZ+NESzkIGxee/M2eFVhbtxS9Vf
        B5w6nL0BSnAPGQA0kqImo5jOx32vvuYcIZGjKmCnuQ==
X-Google-Smtp-Source: AMrXdXsj1Rj8Nf9TRa/LEy05fdsNVR0AzSOcEZTJbqOeAVQGcaAb4yd8CPANwrb6yDfI+9D6Pu3NRSLKEEtmQ6MxwzM=
X-Received: by 2002:a05:6a00:1f05:b0:58d:c610:43cf with SMTP id
 be5-20020a056a001f0500b0058dc61043cfmr4692150pfb.13.1674839975849; Fri, 27
 Jan 2023 09:19:35 -0800 (PST)
MIME-Version: 1.0
References: <20230119221536.3349901-1-sdf@google.com> <20230119221536.3349901-12-sdf@google.com>
 <b7d15874-f6cd-2a5b-0e36-e1ba5ef181e2@linux.dev>
In-Reply-To: <b7d15874-f6cd-2a5b-0e36-e1ba5ef181e2@linux.dev>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Fri, 27 Jan 2023 09:19:24 -0800
Message-ID: <CAKH8qBtRWOMnbG-PipYUs-8EjLOeLnqZi3wktqA1NibkXs-FxQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v8 11/17] selftests/bpf: Verify xdp_metadata
 xdp->af_xdp path
To:     Martin KaFai Lau <martin.lau@linux.dev>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jan 26, 2023 at 10:28 PM Martin KaFai Lau <martin.lau@linux.dev> wrote:
>
> On 1/19/23 2:15 PM, Stanislav Fomichev wrote:
> > - create new netns
> > - create veth pair (veTX+veRX)
> > - setup AF_XDP socket for both interfaces
> > - attach bpf to veRX
> > - send packet via veTX
> > - verify the packet has expected metadata at veRX
>
> I have seen this in CI for a couple of times. Could you help to take a look?

Interesting, sure, will try to take a look, thanks!

> https://github.com/kernel-patches/bpf/actions/runs/4019879316/jobs/6907358876
>
>    #281     xdp_metadata:FAIL
>    Caught signal #11!
>    Stack trace:
>    ./test_progs-no_alu32(crash_handler+0x38)[0x563debb469b2]
>    /lib/x86_64-linux-gnu/libpthread.so.0(+0x13140)[0x7faaf98a2140]
>    ./test_progs-no_alu32(bpf_object__destroy_skeleton+0[  122.480620]
> new_name[134]: segfault at 563df12a8970 ip 0000563debb71a23 sp 00007ffffb5ad3d0
> error 4 in test_progs-no_alu32[563deb94b000+254000] likely on CPU 4 (core 0,
> socket 4)
>    x1b)[0x563debb71[  122.481715] Code: 8b 45 e8 8b 40 38 39 45 f4 7c b0 90 90
> c9 c3 f3 0f 1e fa 55 48 89 e5 48 83 ec 10 48 89 7d f8 48 83 7d f8 00 74 67 48 8b
> 45 f8 <48> 8b 40 40 48 85 c0 74 0c 48 8b 45 f8 48 89 c7 e8 63 ff ff ff 48
>    a23]
>    ./test_progs-no_alu32(+0x3c192)[0x563deb966192]
>    ./test_progs-no_alu32(test_xdp_metadata+0x1a32)[0x563deb969bc8]
>    ./test_progs-no_alu32(+0x21ce50)[0x563debb46e50]
>    ./test_progs-no_alu32(main+0x54b)[0x563debb4892d]
>    /lib/x86_64-linux-gnu/libc.so.6(__libc_start_main+0xea)[0x7faaf96ddd0a]
>    ./test_progs-no_alu32(_start+0x2e)[0x563deb94cdce]
>
