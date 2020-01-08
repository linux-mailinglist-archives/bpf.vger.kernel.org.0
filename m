Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 512AC134703
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2020 17:02:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728121AbgAHQBO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Jan 2020 11:01:14 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:20926 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727154AbgAHQBO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 Jan 2020 11:01:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578499273;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4xKVuM9nzEaeHEeZtkNiiZBSz9T76Ah6WfmYf30vCkQ=;
        b=Urt8yBP8e5dFrtLw8YcPFoCNOC8zCqzfY9AObho/dUBynOTRzxcUnmN2U75vx765j47RM0
        BiaAha7klh+XzONVDWwLxt1sSX1W6gFrWPrxD7BG3cFzMKM9eKUhN8F243D2RXY68L0wMc
        7fQKDAqjpqHbBXAXtiNe2OdqELZdHRU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-85-JtY4Us-cOJKXd3NTGOFzgw-1; Wed, 08 Jan 2020 11:01:11 -0500
X-MC-Unique: JtY4Us-cOJKXd3NTGOFzgw-1
Received: by mail-wm1-f71.google.com with SMTP id t16so1005098wmt.4
        for <bpf@vger.kernel.org>; Wed, 08 Jan 2020 08:01:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=4xKVuM9nzEaeHEeZtkNiiZBSz9T76Ah6WfmYf30vCkQ=;
        b=Nf/BFgF8D5q5bd0itlrmPl51+P7/nO8ohmy4S0tcj9M8hzFui7umcbrcgJEMS6DVoZ
         KZ+Gq55lcWPBXlwp4WFmhlYdPPDY3I2M2bqGPLctY5mPYIDN4jSqsnZarkKkjD49uLaG
         bL5XSFpnWd+eUt1EqIKEACXXbyeV6EHpyqT5qNsBIX4tpdQ5r8ywi0NVc+z5wVCwPUF1
         tZ4UnyDrCzuNmspJ3xH3HMwPDSw7bUWLY3wWuxlntvJvPPsg5fE83jzyv58m7AA1U7dO
         O9xcq0m/DlCjY6bcPJg6hY87yvC3dx7SkMSl1jrsMRN0gB+XK4C6jmhhFSTIBmRg5F1B
         rKfg==
X-Gm-Message-State: APjAAAVPW/Y4er1EMsV88cpaMQw6GVQi4Ci1SbRL5sRS7HRDQh6erVn/
        sMoximH1jyUQ4UUFU5Jawkf6iVztdl0FXKgdJlzgbT5zgUBVx6SG+Km38sGsTajz5aLfCN6trXN
        wx2BKPa49bQZ2
X-Received: by 2002:a1c:ddc5:: with SMTP id u188mr4471330wmg.83.1578499270571;
        Wed, 08 Jan 2020 08:01:10 -0800 (PST)
X-Google-Smtp-Source: APXvYqz7XenpCkrRousPs3FwhO87GodymB5dcnjWrb2g5RKaBO6MSxTljmljmjgY3DBhlAnAkhIWLA==
X-Received: by 2002:a1c:ddc5:: with SMTP id u188mr4471306wmg.83.1578499270397;
        Wed, 08 Jan 2020 08:01:10 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id t12sm4664010wrs.96.2020.01.08.08.01.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2020 08:01:08 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 69D17180ADD; Wed,  8 Jan 2020 17:01:08 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     John Fastabend <john.fastabend@gmail.com>,
        =?utf-8?B?QmrDtnJuIFTDtnBl?= =?utf-8?B?bA==?= 
        <bjorn.topel@gmail.com>, John Fastabend <john.fastabend@gmail.com>
Cc:     Netdev <netdev@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>,
        bpf <bpf@vger.kernel.org>, David Miller <davem@davemloft.net>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        "Karlsson\, Magnus" <magnus.karlsson@intel.com>,
        Jonathan Lemon <jonathan.lemon@gmail.com>
Subject: Re: [PATCH bpf-next v2 4/8] xsk: make xskmap flush_list common for all map instances
In-Reply-To: <5e15faaac42e7_67ea2afd262665bc44@john-XPS-13-9370.notmuch>
References: <20191219061006.21980-1-bjorn.topel@gmail.com> <20191219061006.21980-5-bjorn.topel@gmail.com> <5e14c5d4c4959_67962afd051fc5c062@john-XPS-13-9370.notmuch> <CAJ+HfNiQOpAbHHT9V-gcp9u=vVDoP6uSoz2f-diEFrfX_88pMg@mail.gmail.com> <5e15faaac42e7_67ea2afd262665bc44@john-XPS-13-9370.notmuch>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 08 Jan 2020 17:01:08 +0100
Message-ID: <87lfqigcor.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

John Fastabend <john.fastabend@gmail.com> writes:

> Bj=C3=B6rn T=C3=B6pel wrote:
>> On Tue, 7 Jan 2020 at 18:54, John Fastabend <john.fastabend@gmail.com> w=
rote:
>> >
>> > Bj=C3=B6rn T=C3=B6pel wrote:
>> > > From: Bj=C3=B6rn T=C3=B6pel <bjorn.topel@intel.com>
>> > >
>> > > The xskmap flush list is used to track entries that need to flushed
>> > > from via the xdp_do_flush_map() function. This list used to be
>> > > per-map, but there is really no reason for that. Instead make the
>> > > flush list global for all xskmaps, which simplifies __xsk_map_flush()
>> > > and xsk_map_alloc().
>> > >
>> > > Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>> > > Signed-off-by: Bj=C3=B6rn T=C3=B6pel <bjorn.topel@intel.com>
>> > > ---
>> >
>> > Just to check. The reason this is OK is because xdp_do_flush_map()
>> > is called from NAPI context and is per CPU so the only entries on
>> > the list will be from the current cpu napi context?
>>=20
>> Correct!
>>=20
>> > Even in the case
>> > where multiple xskmaps exist we can't have entries from more than
>> > a single map on any list at the same time by my reading.
>> >
>>=20
>> No, there can be entries from different (XSK) maps. Instead of
>> focusing on maps to flush, focus on *entries* to flush. At the end of
>> the poll function, all entries (regardless of map origin) will be
>> flushed. Makes sense?
>
> Ah OK. This would mean that a single program used multiple maps
> though correct? Because we can only run a single BPF program per
> NAPI context.

Yeah, there's nothing limiting each program to a single map (of any
type)...

-Toke

