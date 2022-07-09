Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9CDE56C617
	for <lists+bpf@lfdr.de>; Sat,  9 Jul 2022 04:54:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229463AbiGICyC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 8 Jul 2022 22:54:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiGICyB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 8 Jul 2022 22:54:01 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C6EC32ED4
        for <bpf@vger.kernel.org>; Fri,  8 Jul 2022 19:54:00 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id f2so559544wrr.6
        for <bpf@vger.kernel.org>; Fri, 08 Jul 2022 19:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hujto5ScMt8YhYM1cS91LOWyVA5XyaoKUzfA9Wu+gn8=;
        b=Bzb6GEcAhjjBCwtynF49BnuH4WAvVPkhNOwLAmySjwwr2LehK3UAgVVZs+jpV/ERVP
         IRirk+MhHnfJR9rcQgXKVyPiWMiYyacMzhuWFSBi4Vb2UVwnRDGS0QLYeuE6BRj5afoF
         dZxeWY2o4J7siWdGaTh0/EcxgkpaakTry2evT9B+Ztn08HRuNRPWuwV2miHflFA+P1Ot
         MOAT+XmAzCOwUV1/ux7Qsb3oG132jW+6LsGcYmHp6GmdooYLY2PuNWfm8Smvo8nwgvRp
         h2nFkfL5vTmzGL1tvvtTH6x03UMibD0YGASfipzRV4roR+wSOIFfw/CLOo6oaT5fOqZO
         ZjhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hujto5ScMt8YhYM1cS91LOWyVA5XyaoKUzfA9Wu+gn8=;
        b=29YBWlYmRqKgQp2yeDJo/OCrMfWt7sNdkVcChlJSvVUlqZAzO1mW7aT59zIuk1//Ot
         ZstTWKLRqquM0Sjn60ati8lweY+LWZ+61VstjFiBZ/WcZ23JJN/HiCFojhDiYVnhW2/9
         Bp/5dQPKghI3CO3AQWc8QmiONsOBq0EsQjTpcjPbifaoEv344HWoBkTWm9d3rVMNDXhE
         NP4+9fR1VRbRtgsvMS2X9/AHduTsfx9y5DsCKVzrX4DalOnBdP5ia0xx2aioT0Sxc0ft
         Uxv0xUap3GC28rRtN38n3c/mQiokdteHEDldfrc8sNF1jyZMPr2QMvFrK41MbrcYUPze
         rzAg==
X-Gm-Message-State: AJIora+rGHRxNWoF07eHDnjXo7nY0xUYqWtC93eBZVbV5kFZj6QfGW0m
        OBib45YBIu1PojRVTXOrTKk=
X-Google-Smtp-Source: AGRyM1tcFagfEeAvugAY72QQpKfpGDh19lUu14iWh5ZbqXSGNsrux47OjLHRFHEKR8K6gD2dPfKPMg==
X-Received: by 2002:adf:f348:0:b0:21d:76f0:975b with SMTP id e8-20020adff348000000b0021d76f0975bmr6093236wrp.676.1657335238599;
        Fri, 08 Jul 2022 19:53:58 -0700 (PDT)
Received: from jondnuc ([2a0d:6fc2:4af0:cc00:f99d:5d19:6e17:dc3a])
        by smtp.gmail.com with ESMTPSA id g15-20020a5d488f000000b0020fe35aec4bsm383022wrq.70.2022.07.08.19.53.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 19:53:57 -0700 (PDT)
Date:   Sat, 9 Jul 2022 05:53:56 +0300
From:   Jon Doron <arilou@gmail.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, Jon Doron <jond@wiz.io>
Subject: Re: [PATCH bpf-next v2 1/1] libbpf: perfbuf: allow raw access to
 buffers
Message-ID: <YsjtxLuTvn8DWEA6@jondnuc>
References: <20220708060416.1788789-1-arilou@gmail.com>
 <20220708060416.1788789-2-arilou@gmail.com>
 <CAEf4BzZkfWTQppe97E1CTLKEqgtxP9gUQqbXB1EKRm5pK_ZmDA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAEf4BzZkfWTQppe97E1CTLKEqgtxP9gUQqbXB1EKRm5pK_ZmDA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 08/07/2022, Andrii Nakryiko wrote:
>On Thu, Jul 7, 2022 at 11:04 PM Jon Doron <arilou@gmail.com> wrote:
>>
>> From: Jon Doron <jond@wiz.io>
>>
>> Add support for writing a custom event reader, by exposing the ring
>> buffer state, and allowing to set it's tail.
>>
>> Few simple examples where this type of needed:
>> 1. perf_event_read_simple is allocating using malloc, perhaps you want
>>    to handle the wrap-around in some other way.
>> 2. Since perf buf is per-cpu then the order of the events is not
>>    guarnteed, for example:
>>    Given 3 events where each event has a timestamp t0 < t1 < t2,
>>    and the events are spread on more than 1 CPU, then we can end
>>    up with the following state in the ring buf:
>>    CPU[0] => [t0, t2]
>>    CPU[1] => [t1]
>>    When you consume the events from CPU[0], you could know there is
>>    a t1 missing, (assuming there are no drops, and your event data
>>    contains a sequential index).
>>    So now one can simply do the following, for CPU[0], you can store
>>    the address of t0 and t2 in an array (without moving the tail, so
>>    there data is not perished) then move on the CPU[1] and set the
>>    address of t1 in the same array.
>>    So you end up with something like:
>>    void **arr[] = [&t0, &t1, &t2], now you can consume it orderely
>>    and move the tails as you process in order.
>> 3. Assuming there are multiple CPUs and we want to start draining the
>>    messages from them, then we can "pick" with which one to start with
>>    according to the remaining free space in the ring buffer.
>>
>
>All the above use cases are sufficiently advanced that you as such an
>advanced user should be able to write your own perfbuf consumer code.
>There isn't a lot of code to set everything up, but then you get full
>control over all the details.
>
>I don't see this API as a generally useful, it feels way too low-level
>and special for inclusion in libbpf.
>

Hi Andrii,

I understand, but I was still hoping you will be willing to expose this 
API.
libbpf has very simple and nice binding to Rust and other languages, 
implementing one of those use cases in the bindings can make things much 
simpler than using some libc or syscall APIs, instead of enjoying all
the simplicity that you get for free in libbpf.

Hope you will be willing to reconsider :)

Have a nice weekend,
-- Jon.

>> Signed-off-by: Jon Doron <jond@wiz.io>
>> ---
>>  tools/lib/bpf/libbpf.c   | 40 ++++++++++++++++++++++++++++++++++++++++
>>  tools/lib/bpf/libbpf.h   | 25 +++++++++++++++++++++++++
>>  tools/lib/bpf/libbpf.map |  2 ++
>>  3 files changed, 67 insertions(+)
>>
>
>[...]
