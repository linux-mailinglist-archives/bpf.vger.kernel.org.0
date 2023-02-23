Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 521686A128D
	for <lists+bpf@lfdr.de>; Thu, 23 Feb 2023 23:05:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbjBWWFd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Feb 2023 17:05:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjBWWFd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Feb 2023 17:05:33 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 094DD5328C
        for <bpf@vger.kernel.org>; Thu, 23 Feb 2023 14:05:32 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id y2so10249520pjg.3
        for <bpf@vger.kernel.org>; Thu, 23 Feb 2023 14:05:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Iki0SxqHDYy81C4hw0qtOagUo72DgS7GnsvaPctUPo=;
        b=je+YfW804qTb8uxTZ8rREIZGVmMvmcvzIquuy4D7/DB/9/lq4AtrgUt6spDQ6Sthwh
         Yxqfo00DL9Q9n0XNwhzJJVqrRcnJztqzviFtVWXjifH4wS7nu1xmXOY34bepnv+Bc+/l
         WLDqzvC5PCPqjoT6Al2ZL6uCkUA6CW0vepgwNEba0PS0HW5+v+R8Ae15K8bPwX20fnKi
         OJirSvvy5upv4zH1LZazQbwrhT60qLBWU2HjDMmpRUdLZR8dob6LXkZ2+78UzlrpA5AN
         r2pXEyi1Ou9Vh3eGEDbpAjIFdSiYt4vCJMd2+P1JTllA/f01FEBokSLLlVJa9qCq97EK
         mSXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Iki0SxqHDYy81C4hw0qtOagUo72DgS7GnsvaPctUPo=;
        b=x5X9KpX/ckPdGd+OaBKU5xaG7sSeQq4Mdv6n1rvT4est2MP4io6Zy8ivCnzzS8CuEp
         MlM18G5glLnpHzQMVkEBXM+k0AYPSE0z3hecirBkOv2G99Ym3CNejwXPdMm7Tv/GQrKA
         1FlT8IvBXjs4yaSrSJmCbNOO7Y5sNLb/QPCVONrBs06eQc2VleSlQTJI9tjIWC2gxrn6
         T6XhGEdlGUbObl3Pp2CioFRbnUj8Yv4ZMziIGmY+iz0d0Y0Wb4OlqurriC8Nox/IOxfu
         3EzxpgV2sDzWnNDeW00ETuPDYbBOavTlVIcHvo8YGwMWH4Dtds5sD5o1u0cBt8h3mJMv
         +IpQ==
X-Gm-Message-State: AO0yUKU+YOsXrDTRxvADFdhRUZHRr+swqn1YfMlo6yOE/uXJcxfx5+Ao
        oGJP8IkPYcZAOov4KTpQvuIbEw==
X-Google-Smtp-Source: AK7set9Y+eycRY2qceAAV7usCfBIb8UtNFtJ1jE2+Yt/qBJYpTyeXmaHiKHKdbFIHZn1ISidYrT6Vg==
X-Received: by 2002:a17:902:d50d:b0:19a:93fc:c4d0 with SMTP id b13-20020a170902d50d00b0019a93fcc4d0mr14761266plg.12.1677189931372;
        Thu, 23 Feb 2023 14:05:31 -0800 (PST)
Received: from ?IPv6:2601:647:4900:b6:28ee:5de8:8f1:37ad? ([2601:647:4900:b6:28ee:5de8:8f1:37ad])
        by smtp.gmail.com with ESMTPSA id e16-20020a17090301d000b0019aa8149cc9sm8311180plh.35.2023.02.23.14.05.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Feb 2023 14:05:31 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.7\))
Subject: Re: [PATCH 1/2] bpf: Add socket destroy capability
From:   Aditi Ghag <aditi.ghag@isovalent.com>
In-Reply-To: <3d8066d4-b293-ec13-2437-1ee9b1ed4cc4@linux.dev>
Date:   Thu, 23 Feb 2023 14:05:29 -0800
Cc:     bpf@vger.kernel.org, Martin KaFai Lau <martin.lau@kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <BFF2A4D4-1401-48F5-ACFB-9FE64238E609@isovalent.com>
References: <cover.1671242108.git.aditi.ghag@isovalent.com>
 <c3b935a5a72b1371f9262348616a7fa84061b85f.1671242108.git.aditi.ghag@isovalent.com>
 <3d8066d4-b293-ec13-2437-1ee9b1ed4cc4@linux.dev>
To:     Martin KaFai Lau <martin.lau@linux.dev>
X-Mailer: Apple Mail (2.3608.120.23.2.7)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


> On Dec 21, 2022, at 9:08 PM, Martin KaFai Lau <martin.lau@linux.dev> =
wrote:
>=20
> On 12/16/22 5:57 PM, Aditi Ghag wrote:
>> The socket destroy helper is used to
>> forcefully terminate sockets from certain
>> BPF contexts. We plan to use the capability
>> in Cilium to force client sockets to reconnect
>> when their remote load-balancing backends are
>> deleted. The other use case is on-the-fly
>> policy enforcement where existing socket
>> connections prevented by policies need to
>> be terminated.
>> The helper is currently exposed to iterator
>> type BPF programs where users can filter,
>> and terminate a set of sockets.
>> Sockets are destroyed asynchronously using
>> the work queue infrastructure. This allows
>> for current the locking semantics within
>> socket destroy handlers, as BPF iterators
>> invoking the helper acquire *sock* locks.
>> This also allows the helper to be invoked
>> from non-sleepable contexts.
>> The other approach to skip acquiring locks
>> by passing an argument to the `diag_destroy`
>> handler didn't work out well for UDP, as
>> the UDP abort function internally invokes
>> another function that ends up acquiring
>> *sock* lock.
>> While there are sleepable BPF iterators,
>> these are limited to only certain map types.
>=20
> bpf-iter program can be sleepable and non sleepable. Both sleepable =
and non sleepable tcp/unix bpf-iter programs have been able to call =
bpf_setsockopt() synchronously. bpf_setsockopt() also requires the sock =
lock to be held first. The situation on calling '.diag_destroy' from =
bpf-iter should not be much different from calling bpf_setsockopt(). =
=46rom a quick look at tcp_abort and udp_abort, I don't see they might =
sleep also and you may want to double check. Even '.diag_destroy' was =
only usable in sleepable 'bpf-iter' because it might sleep, the common =
bpf map types are already available to the sleepable programs.
>=20
> At the kernel side, the tcp and unix iter acquire the lock_sock() =
first (eg. in bpf_iter_tcp_seq_show()) before calling the bpf-iter prog =
. At the kernel setsockopt code (eg. do_ip_setsockopt()), it uses =
sockopt_lock_sock() and avoids doing the lock if it has already been =
guaranteed by the bpf running context.
>=20
> For udp, I don't see how the udp_abort acquires the sock lock =
differently from tcp_abort.  I assume the actual problem seen in =
udp_abort is related to the '->unhash()' part which acquires the =
udp_table's bucket lock.  This is a problem for udp bpf-iter only =
because the udp bpf-iter did not release the udp_table's bucket lock =
before calling the bpf prog.  The tcp (and unix) bpf-iter releases the =
bucket lock first before calling the bpf prog. This was done explicitly =
to allow acquiring the sock lock before calling the bpf prog because =
otherwise it will have a lock ordering issue. Hence, for this reason, =
bpf_setsockopt() is only available to tcp and unix bpf-iter but not udp =
bpf-iter. The udp-iter needs to do similar change like the tcp and unix =
iter =
(https://lore.kernel.org/bpf/20210701200535.1033513-1-kafai@fb.com/): =
batch, release the bucket's lock, lock the sock, and then call bpf prog. =
 This will allow udp-iter to call bpf_setsockopt() like its tcp and unix =
counterpart.  That will also allow udp bpf-iter prog to directly do =
'.diag_destroy'.

Pushed v2 patch series that implements the missing batching support for =
UDP iterators. Sorry for the delay.=20
Thanks for the well-documented batching code in TCP!

