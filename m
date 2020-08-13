Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA52B243F7E
	for <lists+bpf@lfdr.de>; Thu, 13 Aug 2020 21:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbgHMTw2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 13 Aug 2020 15:52:28 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:57046 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726546AbgHMTw2 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 13 Aug 2020 15:52:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597348346;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+0ZAv3XuYoyluR+uscshG57rONyU2cJTmbD4q6O/Rek=;
        b=EME2oeCx5higCEF2qjavBTPjmVnn8QwN44gFSqvDE81ZTfCBTpFUrdimRGpWQg3bsM8Is4
        X7ss9Fk30+e8K842sxxIRuoWEXR2Pdj2UPvRtZ6D1Zb2gnqeooKpaSqhooJVCrFZnRtELn
        DZA9QTyT3nNpsCqxALQdyhBfhydg9/o=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-535-EYTVvd7LNY6s8W-K-Ff80Q-1; Thu, 13 Aug 2020 15:52:23 -0400
X-MC-Unique: EYTVvd7LNY6s8W-K-Ff80Q-1
Received: by mail-wm1-f70.google.com with SMTP id d22so2543829wmd.2
        for <bpf@vger.kernel.org>; Thu, 13 Aug 2020 12:52:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=+0ZAv3XuYoyluR+uscshG57rONyU2cJTmbD4q6O/Rek=;
        b=r9Z/Opob5FkuF3Cf1U+5CQkeRsHEQi3t1hCQvULFedPuo79/yeIdiKxasnOBeIKtBF
         ZJB7CKbc9/etVQBKNHIfWar+XE0oBhjThn5sJlBxg/2p4y9U6a4fOypdB/RPGjqjBe5a
         TjOgpY80uKuR32DLTPUrkVBssdhB/5I60Pm5te5/TcD7sPGAfA5LN0cvaQ5Ch0KiVI69
         gWn7zIGrLTg+m1ioVIHJcR2OdpzHDoCLRZ4mIqcANsoFlefSXjbcUYgbWc4x+5Jne8WQ
         UUfCo6pqYnRe579cdbEiMANPr2202xfMU0AgTal2ChgLC5SaNe1jeHeYp30g/AaGx/z3
         fSoA==
X-Gm-Message-State: AOAM530GyM2GZoygo0opeU0AXOGlxWt/CVRBIjZDg69qAO+P6IouicpU
        QhlNv30pYK64HyzLiKKHuYeTNc6kSGBp3QaNzQ6ECT7Cu0krhZheTHmpL4lf6+9hsRm1is8Bg+Q
        XAqCOdVX+p+Db
X-Received: by 2002:adf:f511:: with SMTP id q17mr5373244wro.414.1597348342255;
        Thu, 13 Aug 2020 12:52:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzxN5HajSKsOOOzKlujHCQaa2QDxD3w6BBkcSbO3LjEsYYdrN+6zMV+etDXeCTPHkzYEyNJlg==
X-Received: by 2002:adf:f511:: with SMTP id q17mr5373226wro.414.1597348341992;
        Thu, 13 Aug 2020 12:52:21 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id m14sm11211191wrx.76.2020.08.13.12.52.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2020 12:52:21 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id BF658180493; Thu, 13 Aug 2020 21:52:20 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf] libbpf: Prevent overriding errno when logging errors
In-Reply-To: <CAEf4BzZ6yM_QWu0x4b51NAVzN6-EAoQN4ff4BNiof5CJ5ukhpg@mail.gmail.com>
References: <20200813142905.160381-1-toke@redhat.com>
 <CAEf4BzZ6yM_QWu0x4b51NAVzN6-EAoQN4ff4BNiof5CJ5ukhpg@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 13 Aug 2020 21:52:20 +0200
Message-ID: <87d03u1fyj.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:

> On Thu, Aug 13, 2020 at 7:29 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@re=
dhat.com> wrote:
>>
>> Turns out there were a few more instances where libbpf didn't save the
>> errno before writing an error message, causing errno to be overridden by
>> the printf() return and the error disappearing if logging is enabled.
>>
>> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>> ---
>
> Acked-by: Andrii Nakryiko <andriin@fb.com>
>
>>  tools/lib/bpf/libbpf.c | 12 +++++++-----
>>  1 file changed, 7 insertions(+), 5 deletions(-)
>>
>> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
>> index 0a06124f7999..fd256440e233 100644
>> --- a/tools/lib/bpf/libbpf.c
>> +++ b/tools/lib/bpf/libbpf.c
>> @@ -3478,10 +3478,11 @@ bpf_object__probe_global_data(struct bpf_object =
*obj)
>>
>>         map =3D bpf_create_map_xattr(&map_attr);
>>         if (map < 0) {
>> -               cp =3D libbpf_strerror_r(errno, errmsg, sizeof(errmsg));
>> +               ret =3D -errno;
>> +               cp =3D libbpf_strerror_r(-ret, errmsg, sizeof(errmsg));
>
> fyi, libbpf_strerror_r() is smart enough to work with both negative
> and positive error numbers (it basically takes abs(err)), so no need
> to ensure it's positive here and below.

Noted. Although that also means it doesn't hurt either, I suppose; so
not going to bother respinning this unless someone insists :)

-Toke

