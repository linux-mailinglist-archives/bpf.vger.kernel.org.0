Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD7B3DB146
	for <lists+bpf@lfdr.de>; Thu, 17 Oct 2019 17:40:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406356AbfJQPka (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Oct 2019 11:40:30 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:21491 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2406343AbfJQPka (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Oct 2019 11:40:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571326828;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=y81vwVgJ+eRHAtuY6MiRJc8ja9iwlcSIUlI5btSObPU=;
        b=HgjGL57Emq3aXzskLZJgTg4al3ckKUsIM5z2fy4b6k5N8oKYWbSUqRczbZFHdar/CFSKox
        Blyy89MPQB8JSvgmdTQrdDbkdk98SE30UiWFUTunhhSS2DDEULOZz1MK/XV1z1iaIVLN/l
        REA5Lo6Vd0yRX8q9Nkr220KkLn3BnCM=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-188-Wm-lZ7T3PjqFhWMHMsmAtQ-1; Thu, 17 Oct 2019 11:40:26 -0400
Received: by mail-lj1-f200.google.com with SMTP id y12so533220ljc.8
        for <bpf@vger.kernel.org>; Thu, 17 Oct 2019 08:40:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=CDfArZaupSldDs/yWRvr98sk9YZWiH/wuIdCLr/xmLQ=;
        b=Z3UyoSxiP2Qd2lFRCizRGgWaAbeDq5FFPEc3KixC9vYoXfLX6MUbMaEdh+S16MMMTg
         XGAII8omT+YJ9utDClmLDMTj1soskzi2VVIwLiojk+qIvCyaysMqE9CaKlddBcshGjTc
         mCy+WIHnA/+wUN8EU9xAE5yV5hWa26LbU5LaM1kZ71wp2bgm8wqtzBHyW42ImEJ5cx3W
         4gYs9YqGi4UUSP3jYc4pEH/ufv7Yirm5hIk1SFoa69XXRLmGqhi/Dha01e+Wa4iSJB33
         GDZ1BIaxfXAs+D/B40s1wIdMYnk+o3GmsW6JDGEZUPYQ9rljVCMoIoaH0qAy0HDQ52P9
         grfw==
X-Gm-Message-State: APjAAAWwogZBz3zqJE08/McDgdtISpIjdXAbiB98tL33oXQzT1gs++dT
        xeZiDKSlXNH1zh8gGAWHnLPRgyrk4UiWXbSDrSt2R/mR0nZzgR3W1KJXA6StuY1k9lxUAvU9PE+
        vQ+fR+gOVF+UH
X-Received: by 2002:a2e:545:: with SMTP id 66mr2991039ljf.133.1571326824510;
        Thu, 17 Oct 2019 08:40:24 -0700 (PDT)
X-Google-Smtp-Source: APXvYqySAk57we6gVMVVmicO7ZH1Ez2tDoulcrn4P4WXYhxN+nHnKebEognZtBF3FDdC+s3gBYP8ew==
X-Received: by 2002:a2e:545:: with SMTP id 66mr2991032ljf.133.1571326824307;
        Thu, 17 Oct 2019 08:40:24 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (borgediget.toke.dk. [85.204.121.218])
        by smtp.gmail.com with ESMTPSA id 81sm1299667lje.70.2019.10.17.08.40.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2019 08:40:23 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id E06FD1804C9; Thu, 17 Oct 2019 17:40:22 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Alexei Starovoitov <ast@fb.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     "daniel\@iogearbox.net" <daniel@iogearbox.net>,
        "bpf\@vger.kernel.org" <bpf@vger.kernel.org>,
        "netdev\@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH bpf] xdp: Handle device unregister for devmap_hash map type
In-Reply-To: <d77bd569-eee2-b436-c575-9ff78bab4f1a@fb.com>
References: <20191016132802.2760149-1-toke@redhat.com> <2d516208-8c46-707c-4484-4547e66fc128@i-love.sakura.ne.jp> <87ftjrfyyy.fsf@toke.dk> <d77bd569-eee2-b436-c575-9ff78bab4f1a@fb.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 17 Oct 2019 17:40:22 +0200
Message-ID: <871rvbfkih.fsf@toke.dk>
MIME-Version: 1.0
X-MC-Unique: Wm-lZ7T3PjqFhWMHMsmAtQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Alexei Starovoitov <ast@fb.com> writes:

> On 10/17/19 3:28 AM, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp> writes:
>>=20
>>> On 2019/10/16 22:28, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>>>> It seems I forgot to add handling of devmap_hash type maps to the devi=
ce
>>>> unregister hook for devmaps. This omission causes devices to not be
>>>> properly released, which causes hangs.
>>>>
>>>> Fix this by adding the missing handler.
>>>>
>>>> Fixes: 6f9d451ab1a3 ("xdp: Add devmap_hash map type for looking up dev=
ices by hashed index")
>>>> Reported-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
>>>> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>>>
>>> Well, regarding 6f9d451ab1a3, I think that we want explicit "(u64)" cas=
t
>>>
>>> @@ -97,6 +123,14 @@ static int dev_map_init_map(struct bpf_dtab *dtab, =
union bpf_attr *attr)
>>>          cost =3D (u64) dtab->map.max_entries * sizeof(struct bpf_dtab_=
netdev *);
>>>          cost +=3D sizeof(struct list_head) * num_possible_cpus();
>>>
>>> +       if (attr->map_type =3D=3D BPF_MAP_TYPE_DEVMAP_HASH) {
>>> +               dtab->n_buckets =3D roundup_pow_of_two(dtab->map.max_en=
tries);
>>> +
>>> +               if (!dtab->n_buckets) /* Overflow check */
>>> +                       return -EINVAL;
>>> +               cost +=3D sizeof(struct hlist_head) * dtab->n_buckets;
>>>
>>>                                                      ^here
>>>
>>> +       }
>>> +
>>>          /* if map size is larger than memlock limit, reject it */
>>>          err =3D bpf_map_charge_init(&dtab->map.memory, cost);
>>>          if (err)
>>>
>>> like "(u64) dtab->map.max_entries * sizeof(struct bpf_dtab_netdev *)" d=
oes.
>>> Otherwise, on 32bits build, "sizeof(struct hlist_head) * dtab->n_bucket=
s" can become 0.
>>=20
>> Oh, right. I kinda assumed the compiler would be smart enough to figure
>> that out based on the type of the LHS; will send a separate fix for this=
.
>
> compiler smart enough?! you must be kidding.
> It's a C standard. Compiler has to do 32 bit multiply because n_buckets
> is u32 and sizeof is 32 bit in 32bit arches as Tetsuo explained.

Sure, I can see that now that Tetsuo pointed it out (thanks for that,
BTW!).

I'm just saying that since it's being assigned to a u64, the fact that
the calculation is not automatically promoted to 64-bit is somewhat
unintuitive (to me), regardless of whether it's in the standard or not.

-Toke

