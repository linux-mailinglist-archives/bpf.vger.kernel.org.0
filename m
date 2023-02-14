Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C803696ED6
	for <lists+bpf@lfdr.de>; Tue, 14 Feb 2023 22:06:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbjBNVGQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Feb 2023 16:06:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjBNVGP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Feb 2023 16:06:15 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 029AB2D5B
        for <bpf@vger.kernel.org>; Tue, 14 Feb 2023 13:05:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676408733;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AELL4BbeEqV25hegmyOJQqKGiK6ReUAWwnkV+eA1m2c=;
        b=JEeCKe4D+NtAUCpRx8omayQ5dAuarKdgbTVRedHc2vW6UhA/pPRayb2B9bCj/DCDNY8EPj
        FHFsRMnHEzAehJoMYP5ynikFX050O9vZsWOEFmWiqNmxsfBkFtcQ5kqEKTgYfQdsycb6nL
        eycr4FxWdE3IXxU+jPhVinPbr4PDhFA=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-371-KbDS9EuyNlyMu_5oaoYk4Q-1; Tue, 14 Feb 2023 16:05:32 -0500
X-MC-Unique: KbDS9EuyNlyMu_5oaoYk4Q-1
Received: by mail-ed1-f69.google.com with SMTP id fi21-20020a056402551500b004acb5c6e52bso6826482edb.1
        for <bpf@vger.kernel.org>; Tue, 14 Feb 2023 13:05:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AELL4BbeEqV25hegmyOJQqKGiK6ReUAWwnkV+eA1m2c=;
        b=c7SXEDWXPu2st1tPF+kCa+p/tpML5QOrHlPucWDC/KXghCwR0cj5wFRrQ31ZhNPtEC
         C3Xu5KrN2JQZU/KZYcpFI3TSAyNyTw9adQa9DhSjMF7MThVKuKcqG//MWn696BAU64ae
         KhYQe1UiYT7W5xFyBLM9kcIdXuBOdirWUOux4Hecf6k92JE0sQpZd8p7gHdtgfda2rwO
         6dw/rmA+R2kRbk5+NZuqbG2l/C5fUix/mF3AVF+xC7iqqVArjf3UrAtblxCdO+k2rIGq
         VD8gS6JHyCRx5cX8TVxAKb37Zea0wbjCTBzceyWsNTXgUzZH7SnHut2Wby57KSRV/Oyr
         PnDQ==
X-Gm-Message-State: AO0yUKV+x+K5APpbjkIF+9ByKzk/mkAcAVf7Lfi9U75B0NecPvIqTqaK
        hI+PZJReAD4mG59Pex9dOY+mahEZ7B7+AMHBXXm1Zo+jPTQwSip7pMrqdE+DAsR+LvccxRisJ7E
        d3HgXTphHHprz
X-Received: by 2002:a50:ccd8:0:b0:4aa:c4bb:2372 with SMTP id b24-20020a50ccd8000000b004aac4bb2372mr4573575edj.32.1676408729047;
        Tue, 14 Feb 2023 13:05:29 -0800 (PST)
X-Google-Smtp-Source: AK7set9Uyxlpig9y1kVJXIASZeYdrU28RpASpxg7IAE3jGK5UaDxpDu0wUPlx5YFtVygWXSji4bLgw==
X-Received: by 2002:a50:ccd8:0:b0:4aa:c4bb:2372 with SMTP id b24-20020a50ccd8000000b004aac4bb2372mr4573491edj.32.1676408727264;
        Tue, 14 Feb 2023 13:05:27 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id c61-20020a509fc3000000b004acbe0b36d2sm4859653edf.6.2023.02.14.13.05.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 13:05:26 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 53473974284; Tue, 14 Feb 2023 22:05:26 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Alexander Lobakin <alexandr.lobakin@intel.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>, bpf@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 bpf] bpf, test_run: fix &xdp_frame misplacement for
 LIVE_FRAMES
In-Reply-To: <e62296a6-7016-c98a-8419-69428f65d9cc@intel.com>
References: <20230213142747.3225479-1-alexandr.lobakin@intel.com>
 <8fffeae7-06a7-158e-e494-c17f4fdc689f@iogearbox.net>
 <6823f918-7b6c-7349-abb7-7bfb5c7600c2@intel.com>
 <e62296a6-7016-c98a-8419-69428f65d9cc@intel.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 14 Feb 2023 22:05:26 +0100
Message-ID: <87bklwt0tl.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Alexander Lobakin <alexandr.lobakin@intel.com> writes:

> From: Alexander Lobakin <alexandr.lobakin@intel.com>
> Date: Tue, 14 Feb 2023 16:39:25 +0100
>
>> From: Daniel Borkmann <daniel@iogearbox.net>
>> Date: Tue, 14 Feb 2023 16:24:10 +0100
>>=20
>>> On 2/13/23 3:27 PM, Alexander Lobakin wrote:
>
> [...]
>
>>>> Fixes: b530e9e1063e ("bpf: Add "live packet" mode for XDP in
>>>> BPF_PROG_RUN")
>>>> Signed-off-by: Alexander Lobakin <alexandr.lobakin@intel.com>
>>>
>>> Could you double check BPF CI? Looks like a number of XDP related tests
>>> are failing on your patch which I'm not seeing on other patches where r=
uns
>>> are green, for example test_progs on several archs report the below:
>>>
>>> https://github.com/kernel-patches/bpf/actions/runs/4164593416/jobs/7207=
290499
>>>
>>> =C2=A0 [...]
>>> =C2=A0 test_xdp_do_redirect:PASS:prog_run 0 nsec
>>> =C2=A0 test_xdp_do_redirect:PASS:pkt_count_xdp 0 nsec
>>> =C2=A0 test_xdp_do_redirect:PASS:pkt_count_zero 0 nsec
>>> =C2=A0 test_xdp_do_redirect:PASS:pkt_count_tc 0 nsec
>>> =C2=A0 test_max_pkt_size:PASS:prog_run_max_size 0 nsec
>>> =C2=A0 test_max_pkt_size:FAIL:prog_run_too_big unexpected prog_run_too_=
big:
>>> actual -28 !=3D expected -22
>>> =C2=A0 close_netns:PASS:setns 0 nsec
>>> =C2=A0 #275=C2=A0=C2=A0=C2=A0=C2=A0 xdp_do_redirect:FAIL
>>> =C2=A0 Summary: 273/1581 PASSED, 21 SKIPPED, 2 FAILED
>> Ah I see. xdp_do_redirect.c test defines:
>>=20
>> /* The maximum permissible size is: PAGE_SIZE -
>>  * sizeof(struct xdp_page_head) - sizeof(struct skb_shared_info) -
>>  * XDP_PACKET_HEADROOM =3D 3368 bytes
>>  */
>> #define MAX_PKT_SIZE 3368
>>=20
>> This needs to be updated as it now became bigger. The test checks that
>> this size passes and size + 1 fails, but now it doesn't.
>> Will send v3 in a couple minutes.
>
> Problem :s
>
> This 3368/3408 assumes %L1_CACHE_BYTES is 64 and we're running on a
> 64-bit arch. For 32 bits the value will be bigger, also for cachelines
> bigger than 64 it will be smaller (skb_shared_info has to be aligned).
> Given that selftests are generic / arch-independent, how to approach
> this? I added a static_assert() to test_run.c to make sure this value
> is in sync to not run into the same problem in future, but then realized
> it will fail on a number of architectures.
>
> My first thought was to hardcode the worst-case value (64 bit, cacheline
> is 128) in test_run.c for every architecture, but there might be more
> elegant ways.

The 32/64 bit split should be straight-forward to handle for the head;
an xdp_buff is 6*sizeof(void)+8 bytes long, and xdp_page_head is just
two of those after this patch. The skb_shared_info size is a bit harder;
do we have the alignment / size macros available to userspace somewhere?

Hmm, the selftests generate a vmlinux.h file which would have the
structure definitions; maybe something could be generated from that? Not
straight-forward to include it in a userspace application, though.

Otherwise, does anyone run the selftests on architectures that don't
have a 64-byte cache-line size? Or even on 32-bit arches? We don't
handle larger page sizes either...

-Toke

