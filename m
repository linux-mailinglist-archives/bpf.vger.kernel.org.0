Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9999EC4867
	for <lists+bpf@lfdr.de>; Wed,  2 Oct 2019 09:21:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbfJBHVr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Oct 2019 03:21:47 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:31768 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725852AbfJBHVr (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 2 Oct 2019 03:21:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1570000906;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZXKoJ1jbuJ+ks0dSg3TRhQiKe5OUNHwJKm984nzXgMI=;
        b=fwksWvmFcZTjME0yEhzP3d+tI52WLxnvUIh8AHfuA7jSxuwmR/ajy0Q8wxKF2S0/3QmOBW
        yFUPbGQ0J8g0Dem7sWnkzcYI7o+7KzuTWKMK2rQOko7whX9H884QcL2RLvEyt7aaM/qZqU
        XpzptSO/SNBohl0dTuneuf2qBXyfYZA=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-109-J_pWYpFlMGu4w85b0wIa-Q-1; Wed, 02 Oct 2019 03:21:45 -0400
Received: by mail-lj1-f197.google.com with SMTP id g88so1951589lje.10
        for <bpf@vger.kernel.org>; Wed, 02 Oct 2019 00:21:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=ZXKoJ1jbuJ+ks0dSg3TRhQiKe5OUNHwJKm984nzXgMI=;
        b=O4xCL8ZV29BEu4aEXh6HgLl9SQUNbtsAYNeNg1JSPYgVre8KHqTmKEWL0BICZx9lGQ
         VhoMK3HMo0XeIITEyR85voMhLc6EIqQ/PMEECuhCUQWlRjg29QaogJlK+INXsQ32cjLU
         25Sfqqrq6jmC+EynR5MMjwAoSSVGdE5LYOYadT2IfzjBnCwWMHRUue9vYQwkhIWbIfjj
         3HvICVITN6dfchPW0W0HXbD0ljZnvl/hHJnYVoGADCpzquvzqcnxpIoHwT78yKt62/V5
         RFZuUBRy5bQqDXZwHBr4LBaCe39HSJ6OQ3BcOVq2ee4BehEE1TLMfPpW0EejKDoKn3v5
         Xkmg==
X-Gm-Message-State: APjAAAUsOKHQorXKVWaTGPp4RXO96G/uo/O9zG5+m0PB4hmSUKsMbxZ+
        xJ7IfFasJMWXusF2v4vKo59cj8lIOzg96v9njh3zdP1LFppSe3Di67zkYMW5E1VJgf7AAu6Ez8V
        DkVyfUs7/h4RX
X-Received: by 2002:ac2:5464:: with SMTP id e4mr1278056lfn.102.1570000903668;
        Wed, 02 Oct 2019 00:21:43 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzQPU+F+tlnzzzTShi4AS+eN2MOMLc/gx+x3gRIKe2v0XtfmW5KzhrpkSLC+StZ5+LIeSra0g==
X-Received: by 2002:ac2:5464:: with SMTP id e4mr1278044lfn.102.1570000903515;
        Wed, 02 Oct 2019 00:21:43 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (borgediget.toke.dk. [85.204.121.218])
        by smtp.gmail.com with ESMTPSA id 3sm4464958ljs.20.2019.10.02.00.21.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2019 00:21:42 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id DE8FC18063D; Wed,  2 Oct 2019 09:21:41 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Andrii Nakryiko <andriin@fb.com>, bpf <bpf@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>,
        Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH bpf-next 2/6] libbpf: move bpf_helpers.h, bpf_endian.h into libbpf
In-Reply-To: <CAEf4Bza789NPSx0FksudY7J0D9Q-+EsTDvvAJXJyrcTNka=sag@mail.gmail.com>
References: <20190930185855.4115372-1-andriin@fb.com> <20190930185855.4115372-3-andriin@fb.com> <87d0fhvt4e.fsf@toke.dk> <CAEf4Bza789NPSx0FksudY7J0D9Q-+EsTDvvAJXJyrcTNka=sag@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 02 Oct 2019 09:21:41 +0200
Message-ID: <87a7ajtxx6.fsf@toke.dk>
MIME-Version: 1.0
X-MC-Unique: J_pWYpFlMGu4w85b0wIa-Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:

> On Tue, Oct 1, 2019 at 12:10 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@re=
dhat.com> wrote:
>>
>>
>> > +struct bpf_map_def {
>> > +     unsigned int type;
>> > +     unsigned int key_size;
>> > +     unsigned int value_size;
>> > +     unsigned int max_entries;
>> > +     unsigned int map_flags;
>> > +     unsigned int inner_map_idx;
>> > +     unsigned int numa_node;
>> > +};
>>
>> Didn't we agree on no new bpf_map_def ABI in libbpf, and that all
>> additions should be BTF-based?
>
> Oh yes, we did, sorry, this is an oversight. I really appreciate you
> pointing this out ;)
> I'll go over bpf_helpers.h carefully and will double-check if we don't
> have any other custom selftests-only stuff left there.

Great, thanks!

-Toke

