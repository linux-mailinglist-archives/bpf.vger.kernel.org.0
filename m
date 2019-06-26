Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72F755731C
	for <lists+bpf@lfdr.de>; Wed, 26 Jun 2019 22:50:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726320AbfFZUuy convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Wed, 26 Jun 2019 16:50:54 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:33761 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbfFZUuy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 26 Jun 2019 16:50:54 -0400
Received: by mail-ed1-f65.google.com with SMTP id i11so5004767edq.0
        for <bpf@vger.kernel.org>; Wed, 26 Jun 2019 13:50:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=vCtVnSV5pbkc8wL7gAqXKnkYIeFXOX3zA79zM4jv0jg=;
        b=CkpOu8nYCNc+FVztwyC4s7Q5HhjFomv5KK60k32Dhu8ObHVsGKkYwmQtj9pxsJdIhd
         nYN73CMg32Q1kFuRr/OypB6Hvbj14lBcLVX8UukW/OW0poQ3yGqUmncV1lhMFHBdFC+7
         oPO0oXoznUI8t4KDkK2xiNGrpnNTcLMQRiVvkifPoQ08Vw9b4GOvvclmWY/poQB1C68h
         iLmDkthL+t2S7LxcJ/cNjTICtbjdFqMsKvhsIbxfpeqbUcI/Aa0aF73woDYh7IfEkt7B
         qUgGB4C5NkB3+H9wdqQanYg2vSrBwQSXF5lMavsUQKe8Wgi7fgWJf2Joj+e2igL+qqGt
         WSAw==
X-Gm-Message-State: APjAAAWGlnyd3zoYwufG1yI0qonhV3l9vsfQTZUMTImQUfUin/qaFj2n
        Iv3p9/gT9suDfC+qDr8nur1AFg==
X-Google-Smtp-Source: APXvYqyyKqdtin+Nln4gPV8lLezS5X6dqf5KO0n4x66+oWHoQbw9BSqU2Nb8lE4XYRyHnO0LkdF/DQ==
X-Received: by 2002:aa7:cdc6:: with SMTP id h6mr7869713edw.5.1561582252311;
        Wed, 26 Jun 2019 13:50:52 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (borgediget.toke.dk. [85.204.121.218])
        by smtp.gmail.com with ESMTPSA id s27sm9223eda.36.2019.06.26.13.50.51
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 26 Jun 2019 13:50:51 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id CA272181CA7; Wed, 26 Jun 2019 22:50:50 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Andrii Nakryiko <andriin@fb.com>, Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>, Networking <netdev@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH v2 bpf-next 0/3] libbpf: add perf buffer abstraction and API
In-Reply-To: <CAEf4BzZozWBanXnjJguYT46v8huAS7Wz44MHFHJkAPBZbT-i6A@mail.gmail.com>
References: <20190626061235.602633-1-andriin@fb.com> <877e98d0hp.fsf@toke.dk> <CAEf4BzZozWBanXnjJguYT46v8huAS7Wz44MHFHJkAPBZbT-i6A@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 26 Jun 2019 22:50:50 +0200
Message-ID: <878stoax5h.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:

> On Wed, Jun 26, 2019 at 4:55 AM Toke Høiland-Jørgensen <toke@redhat.com> wrote:
>>
>> Andrii Nakryiko <andriin@fb.com> writes:
>>
>> > This patchset adds a high-level API for setting up and polling perf buffers
>> > associated with BPF_MAP_TYPE_PERF_EVENT_ARRAY map. Details of APIs are
>> > described in corresponding commit.
>> >
>> > Patch #1 adds a set of APIs to set up and work with perf buffer.
>> > Patch #2 enhances libbpf to supprot auto-setting PERF_EVENT_ARRAY map size.
>> > Patch #3 adds test.
>>
>> Having this in libbpf is great! Do you have a usage example of how a
>> program is supposed to read events from the buffer? This is something we
>> would probably want to add to the XDP tutorial
>
> Did you check patch #3 with selftest? It's essentially an end-to-end
> example of how to set everything up and process data (in my case it's
> just simple int being sent as a sample, but it's exactly the same with
> more complicated structs). I didn't bother to handle lost samples
> notification, but it's just another optional callback with a single
> counter denoting how many samples were dropped.
>
> Let me know if it's still unclear.

I did read the example, but I obviously did not grok how it was supposed
to work; re-reading it now it's quite clear, thanks! :)

-Toke
