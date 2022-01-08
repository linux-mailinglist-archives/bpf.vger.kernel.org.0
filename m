Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 922484885EE
	for <lists+bpf@lfdr.de>; Sat,  8 Jan 2022 21:44:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232679AbiAHUow (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 8 Jan 2022 15:44:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:57156 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229822AbiAHUow (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sat, 8 Jan 2022 15:44:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641674691;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Qj7dsc3TbQTpQjFsevsSiqeeT/F1CxGoWIT53pOVqj8=;
        b=TfmVdjTiq/fpdVoEgR13/AVvQADSTj3jjX01OkGA7fB/ejqdD9bXB99LTQPkeI6sr2aWIL
        MuVP0Qpw7WfrXfFVsJV8iYEFdZkZLvtpxX8/1n3gnQtjZPV597aEZ3U7dA829vpzciNAvV
        NWbSs2rUNsSY9+Zrw7iCPN39PaqsG58=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-465-BVfNyDcCM02V8_n3eP628g-1; Sat, 08 Jan 2022 15:44:50 -0500
X-MC-Unique: BVfNyDcCM02V8_n3eP628g-1
Received: by mail-ed1-f71.google.com with SMTP id b8-20020a056402350800b003f8f42a883dso7219020edd.16
        for <bpf@vger.kernel.org>; Sat, 08 Jan 2022 12:44:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=Qj7dsc3TbQTpQjFsevsSiqeeT/F1CxGoWIT53pOVqj8=;
        b=Z9uo6nNHoAE39qjKQXjWuUnXqhZiqTLVS57vk+l+lK+ohYto6QTkMKDYTqWiOAzBZA
         ZUu/GL8mUtHNf0OgAV3YsKbGUfkJ2pLHJotCz954UQ0EoAmEOHatrkY/0N4aXHWq+THz
         YNxr2YccM62hEIyE3HrY54doWoEQbyJ/Fq7ajWGWF1hgZkwQ7MWAH9tb16iLQuewnZJz
         7GTrCe853haRdbDIH7bfT+5awbVErcQk96T+xIaS4alw6wAsYDTiR23xtUdg8Y8EW7ln
         GfayyXGOfJopMQPBTlAWgOS3VHBBIRyqIIY+AlihF6uiIq9h6QY0nck9uwh6hJXcaiSP
         vS3Q==
X-Gm-Message-State: AOAM5333Ye4McYQmdpjiPiC9x/oc8lnFIVi+qV7RdPYl0bum+Fo5cES1
        Q6Pw8bfpk6BL/jieltixEqnQQbBrPgf6V+4xnjQ9pql6qb2o05AO83HPxIQSSTlrTN1iuPFnN7R
        9nWh0sSRqTBq7
X-Received: by 2002:a05:6402:7c6:: with SMTP id u6mr9518198edy.160.1641673266922;
        Sat, 08 Jan 2022 12:21:06 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw637OB9UwwEZvCt/PZbRYxN23lqHu9QY6hm8Rbg8fQVT2Rz1bdSsr04k6EiSOvtdrGBjTbLQ==
X-Received: by 2002:a05:6402:7c6:: with SMTP id u6mr9518156edy.160.1641673266013;
        Sat, 08 Jan 2022 12:21:06 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 26sm767910ejk.138.2022.01.08.12.21.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Jan 2022 12:21:05 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 05A7F181F2A; Sat,  8 Jan 2022 21:21:05 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        syzbot <syzbot+983941aa85af6ded1fd9@syzkaller.appspotmail.com>,
        Network Development <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf v2 1/3] xdp: check prog type before updating BPF link
In-Reply-To: <CAADnVQLBDwUEcf63Jd2ohe0k5xKAcFaUmPL6tC-h937pSTzcCg@mail.gmail.com>
References: <20220107221115.326171-1-toke@redhat.com>
 <CAADnVQLBDwUEcf63Jd2ohe0k5xKAcFaUmPL6tC-h937pSTzcCg@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Sat, 08 Jan 2022 21:21:04 +0100
Message-ID: <87k0fa7zdb.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:

> On Fri, Jan 7, 2022 at 2:11 PM Toke H=C3=B8iland-J=C3=B8rgensen <toke@red=
hat.com> wrote:
>>
>> The bpf_xdp_link_update() function didn't check the program type before
>> updating the program, which made it possible to install any program type=
 as
>> an XDP program, which is obviously not good. Syzbot managed to trigger t=
his
>> by swapping in an LWT program on the XDP hook which would crash in a hel=
per
>> call.
>>
>> Fix this by adding a check and bailing out if the types don't match.
>>
>> Fixes: 026a4c28e1db ("bpf, xdp: Implement LINK_UPDATE for BPF XDP link")
>> Reported-by: syzbot+983941aa85af6ded1fd9@syzkaller.appspotmail.com
>> Acked-by: Andrii Nakryiko <andrii@kernel.org>
>> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>
> Thanks a lot for the quick fix!
> The merge window is about to begin.
> We will land it as soon as possible when bpf tree will be ready
> to accept fixes.

You're welcome! That's fine; FWIW, I believe the patch applies cleanly
to bpf-next as well, if that makes things easier on your end :)

-Toke

