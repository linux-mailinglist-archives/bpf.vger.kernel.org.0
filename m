Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D6FA65B6F5
	for <lists+bpf@lfdr.de>; Mon,  2 Jan 2023 20:30:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232151AbjABTar (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 2 Jan 2023 14:30:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbjABTar (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 2 Jan 2023 14:30:47 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCA805F96
        for <bpf@vger.kernel.org>; Mon,  2 Jan 2023 11:30:45 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id a30so3576412pfr.6
        for <bpf@vger.kernel.org>; Mon, 02 Jan 2023 11:30:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p5D07SiA4q0lj3YwJsYyxcDGZ677WMo1Z4WwsRtU35c=;
        b=3yWwCOaB0+EvsLp00wFB0A2kxLyTSRMIekW/UKwQiHXke0Tz0yhLNGUkoFKSp5cSEh
         3X40WPUx3HmUeLGB/nbRJLbyvRkgLMQGfr+Iiw0l6kzN6Cse8acwJo7vRJDwsyolAqbu
         0Ry2ADSue8EQyWM5Kdc1La6XevSgyQikEyx2mN2GhNs7eQuzcyfHwVACD9VLJD/ZPwK/
         vEt5rW9sbfT2psVls1Mh2XL4HahOfDCxdrEgDgh+qvmUvo5MVwSUM9M/Gk00EjY9WGB3
         UMfWquWrVe8/BqkeR2uXUhzu4fqtLjVdYK/zWvN8t80u+SZc9La0JG1cotjchKvYzqG1
         hHfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p5D07SiA4q0lj3YwJsYyxcDGZ677WMo1Z4WwsRtU35c=;
        b=OMzS2XYS4pJgEbyaGFRoaT+Aho3ix0SrFQ52/RddQnZ9W+9FCiI201fYom9G0+RZZu
         jlHS2jVKh0ZlxTeYHks2O4w+PIBFmlbuuPFCSrYPhNZ/r16HnY/ecN77K6K/wQftmIVJ
         /wNKkrMWuFs1bkfFCqcNBA58xkNpU8qtdWIHWq66AJ1DexhLXA7hPZBbhEB0D3/pnHGS
         /FPvkX7BtbOm+vi/9RbRlQdAUI6K0vwbQMwdVPjA5c+yIwdzjWK6Mxb4DymckgwNzOp5
         GhT/DfOrFP9Ms9wj8B/xRItHtF/+I8oLiW6wHPiQmqGlWV1s/5h2x8VNwiBHjNXmFOkG
         rXLw==
X-Gm-Message-State: AFqh2krbH5b0oKluNgQ9Tcrz6+tXN6I8BeSHviSFvTX28pOT+Vlqy5Wu
        6RsTC4/eU2uiqVR4vVSGIFQkOlzE1rL5lAbaA2c=
X-Google-Smtp-Source: AMrXdXvzScjK9g26NheEGxpyqkbHaRDaQAIV03o+U3zL+OGv8B1y9eGSWntdzcFkRyCqH0EFlJM3FA==
X-Received: by 2002:a62:1482:0:b0:581:bae0:d5d5 with SMTP id 124-20020a621482000000b00581bae0d5d5mr15704191pfu.9.1672687845236;
        Mon, 02 Jan 2023 11:30:45 -0800 (PST)
Received: from ?IPv6:2601:647:4900:b6:d519:79b8:8948:6c97? ([2601:647:4900:b6:d519:79b8:8948:6c97])
        by smtp.gmail.com with ESMTPSA id y29-20020aa793dd000000b00575fbe1cf2esm9653758pff.109.2023.01.02.11.30.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Jan 2023 11:30:44 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.7\))
Subject: Re: [PATCH 1/2] bpf: Add socket destroy capability
From:   Aditi Ghag <aditi.ghag@isovalent.com>
In-Reply-To: <3d8066d4-b293-ec13-2437-1ee9b1ed4cc4@linux.dev>
Date:   Mon, 2 Jan 2023 11:30:43 -0800
Cc:     sdf@google.com, edumazet@google.com, bpf@vger.kernel.org,
        Martin KaFai Lau <martin.lau@kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <78E434B0-06A9-466F-A061-B9A05DC6DE6D@isovalent.com>
References: <cover.1671242108.git.aditi.ghag@isovalent.com>
 <c3b935a5a72b1371f9262348616a7fa84061b85f.1671242108.git.aditi.ghag@isovalent.com>
 <3d8066d4-b293-ec13-2437-1ee9b1ed4cc4@linux.dev>
To:     Martin KaFai Lau <martin.lau@linux.dev>
X-Mailer: Apple Mail (2.3608.120.23.2.7)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Thanks for the reviews.

@martin: Thanks, I'll look into the missing batching related logic for =
UDP. Appreciate the pointers.
OT: While we can use the has_current_bpf_ctx macro to skip taking sock =
locks in the BPF context, how is the assumption around locking enforced =
in the code (e.g., setsockopt helper assumes that BPF iter prog acquires =
the relevant locks)? We could potentially use lockdep_sock_is_held for =
the sock lock. It's a debug configuration, but I suppose it's enabled in =
selftests.

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

