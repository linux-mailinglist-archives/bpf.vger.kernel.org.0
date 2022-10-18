Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94242602EBA
	for <lists+bpf@lfdr.de>; Tue, 18 Oct 2022 16:46:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbiJROqa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 18 Oct 2022 10:46:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230152AbiJROq3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 18 Oct 2022 10:46:29 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BD56D73DD;
        Tue, 18 Oct 2022 07:46:27 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id r13so23839793wrj.11;
        Tue, 18 Oct 2022 07:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zoXCniAMsfloF5Adrb7dptYXmfUJcR1MEzuNGWKn9dY=;
        b=jdOB1y6VTfbcMviKgQjKLZBefTvuG83CiujSpa2qAVF/X20dUMgQHCiBiD7cXPfqYz
         148g4FIf6eIgCzpb8ba7Es2JreTSJyfEPJ+2MiYqNV2F/mEvz+opY4eSLX57PtLyuB4L
         ZI3y6oQ3kdfJfFR1wwlGDyIN7hw3SC0oXOU48ZRrNHC8Rfue/E/2Gt0919rpA7td2FLe
         f3d7cv3fRC0h7FNhjeZlxuPFlNoYr6u0FrYRcMnCsX9LHLQFuvNoHXYkt4RqeCf1sqeD
         6NrdKjynSriiJBblqOTs0eM7Pmz0gjDIUGUPS1RS1+yg1zkjf2swPMcPLLru5gODRHd1
         AcyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zoXCniAMsfloF5Adrb7dptYXmfUJcR1MEzuNGWKn9dY=;
        b=7eEIuBblxPS3DbHda3QW0y7gd7lBtR7Bm/hZZYQ4gJ1jFQtOfDdRoBPCj9tCe8acV1
         9Q97CKXZV9jZkg0vayB6R/QZbLZ5+gTQ2gFcEylAaFlmJzc0WoCGmF+m4sXyVDrnoyi0
         PSkHq/D54Nr8Jr+Dw6RsSHE25Fpeb73u9i4TR3iXAc1y/0HWCvhhnErh6W4iqZoMhZWh
         e20IeJb85TTfYIV1QOsFwbb8vsIo7jjI4/Rw9RcmpHQnl9MxctkUjBZ08K7KfcoSXdO/
         hEiFZahyIi62oYv0XvbxKrkG8bVMjl4Mr2fqX8WjWT63wuvrRpLCgOxCPLut/ivgrD1q
         tMCg==
X-Gm-Message-State: ACrzQf3b9swQ08oi+2tuM+OGmViNoEQvk9Eou8ePRIfQY6h1tVbmoWrI
        4hLZCDAXM/yKFp+W+76PGdsTLkt7H4c=
X-Google-Smtp-Source: AMsMyM4Ri2wPP0g8IUZMLsopJBcLquznv0egRyJIec4RMYW/CP/vRXGeOWzNXFvV54hLBI90Ge2Cog==
X-Received: by 2002:a5d:6d07:0:b0:22f:81f9:9c73 with SMTP id e7-20020a5d6d07000000b0022f81f99c73mr2402211wrq.76.1666104384880;
        Tue, 18 Oct 2022 07:46:24 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:8008:3928:dd39:56c])
        by smtp.gmail.com with ESMTPSA id q65-20020a1c4344000000b003a8434530bbsm18840191wma.13.2022.10.18.07.46.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 07:46:23 -0700 (PDT)
From:   Donald Hunter <donald.hunter@gmail.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     bpf@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH bpf-next v1] bpf, docs: Reformat BPF maps page to be
 more readable
In-Reply-To: <Y0eQcOsbrmBXqdUP@debian.me> (Bagas Sanjaya's message of "Thu, 13
        Oct 2022 11:13:36 +0700")
Date:   Tue, 18 Oct 2022 15:45:52 +0100
Message-ID: <m2sfjlur4v.fsf@gmail.com>
References: <20221012152715.25073-1-donald.hunter@gmail.com>
        <Y0eQcOsbrmBXqdUP@debian.me>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (darwin)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Bagas Sanjaya <bagasdotme@gmail.com> writes:

> On Wed, Oct 12, 2022 at 04:27:15PM +0100, Donald Hunter wrote:
>> Add a more complete introduction, with links to man pages.
>> Move toctree of map types above usage notes.
>> Format usage notes to improve readability.
>> 
>> Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
>> ---
>>  Documentation/bpf/maps.rst | 101 ++++++++++++++++++++++++-------------
>>  1 file changed, 65 insertions(+), 36 deletions(-)
>> 
>> diff --git a/Documentation/bpf/maps.rst b/Documentation/bpf/maps.rst
>> index f41619e312ac..4906ff0f8382 100644
>> --- a/Documentation/bpf/maps.rst
>> +++ b/Documentation/bpf/maps.rst
>> @@ -1,52 +1,81 @@
>>  
>> -=========
>> -eBPF maps
>> +========
>> +BPF maps
>> +========
>> +
>> +BPF 'maps' provide generic storage of different types for sharing data between
>> +kernel and user space. There are several storage types available, including
>> +hash, array, bloom filter and radix-tree. Several of the map types exist to
>> +support specific BPF helpers that perform actions based on the map contents. The
>> +maps are accessed from BPF programs via BPF helpers which are documented in the
>> +`man-pages`_ for `bpf-helpers(7)`_.
>> +
>> +BPF maps are accessed from user space via the ``bpf`` syscall, which provides
>> +commands to create maps, lookup elements, update elements and delete
>> +elements. More details of the BPF syscall are available in
>> +:doc:`/userspace-api/ebpf/syscall` and in the `man-pages`_ for `bpf(2)`_.
>> <snipped>...
>> +.. Links:
>> +.. _man-pages: https://www.kernel.org/doc/man-pages/
>> +.. _bpf(2): https://man7.org/linux/man-pages/man2/bpf.2.html
>> +.. _bpf-helpers(7): https://man7.org/linux/man-pages/man7/bpf-helpers.7.html
>
> I think you can just write "see :manpage:`bpf(2)`" without linking to
> external site.

I tried your suggestion but it just renders italicized text. I think it
is more helpful to provide a clickable link to the relevant man
page. Other documentation pages already provide clickable manpage links
and I followed existing practise from Documentation/bpf/syscall_api.rst

I would prefer to keep the clickable links.

> Otherwise LGTM.
