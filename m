Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A481224EF44
	for <lists+bpf@lfdr.de>; Sun, 23 Aug 2020 20:36:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725868AbgHWSgP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 23 Aug 2020 14:36:15 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24017 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725867AbgHWSgP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 23 Aug 2020 14:36:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598207773;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SkQDoUqFb2pcXsHEYlbXyVvwoHEdGkctXljyuRbwe0I=;
        b=cmCUcWZew4cJQ3A4mkM6yjpIEpUDIZCMiPnOSLJUqaXtNKU7W/AdiXcizGBQaiQhUaolnm
        Iag+FUde+EJxMU8XHzOQOY3zi63B1t1+5yfEgdEclyz6xxlmNrS4asPe0XOW01tMgP/oeC
        OANg03v6r4sNFOQUHZYy5f5Ok80Ya7Q=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-531-XdcVLc9TM5mg9q00KYpLXw-1; Sun, 23 Aug 2020 14:36:11 -0400
X-MC-Unique: XdcVLc9TM5mg9q00KYpLXw-1
Received: by mail-wr1-f69.google.com with SMTP id z1so3041080wrn.18
        for <bpf@vger.kernel.org>; Sun, 23 Aug 2020 11:36:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=SkQDoUqFb2pcXsHEYlbXyVvwoHEdGkctXljyuRbwe0I=;
        b=TXz+YIUKEuI6dNP3HBCMgHhgxcnAKiiG5yVYixjRGO8S1CQ5bnoR85NCKkE0Bz+SX4
         xTQcIWA0Yx1/rV52HkGFDqNZk38nEro2NFjrlHlKrI9FiOZrmvs8qkTVQgQX1bL/aCBX
         SG0ANT5fCdiwvzsMMWFL2a/Z99dVlfVjIi/CIBpxp1Q/jfa8s+SzEQgglh2WE4oPC5ei
         SP7sBCnf/m7JOdV2OlD3oSPSnOf7z0bQZrpl7CEXwUkXV8G5Sd+1OMO4bgc5fRsph34b
         xza5PJlLzXOldZK8E+QjmBduWyEYFkMwiVcNrC3UnZayyPz7oI7C9NI9s9lpZ5Q6dfHe
         Dj4g==
X-Gm-Message-State: AOAM531W7m6R8bVUG/98nmUN9qMhV98w54r1Uq/0+8IebUErxTeJCbHh
        MzhBBHv5V3ptI9J8ng9DElo2xIQHmGAZtQw/YrlWhsNeGLz9CPifx1Od7USGu7IwONrgPZYMV18
        MoaVlXdCcvoki
X-Received: by 2002:a5d:638c:: with SMTP id p12mr2450324wru.17.1598207770234;
        Sun, 23 Aug 2020 11:36:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx86SbvwVkJeaPtFelbSv1Hi/W9Qr/OpgUF7YVHbqpp+BusMv/LAquX8wmggGCrho9uBekX5g==
X-Received: by 2002:a5d:638c:: with SMTP id p12mr2450296wru.17.1598207769862;
        Sun, 23 Aug 2020 11:36:09 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id z6sm10771101wrt.91.2020.08.23.11.36.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2020 11:36:09 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 5F29E1825D0; Sun, 23 Aug 2020 20:36:07 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     YiFei Zhu <zhuyifei@google.com>
Cc:     Yonghong Song <yhs@fb.com>, YiFei Zhu <zhuyifei1999@gmail.com>,
        bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Stanislav Fomichev <sdf@google.com>,
        Mahesh Bandewar <maheshb@google.com>
Subject: Re: [PATCH bpf-next 4/5] bpftool: support dumping metadata
In-Reply-To: <CAA-VZP=Jo0iQRpP+QEmB359C5TS=0BnDHTAzd6yC85aOkEJrsA@mail.gmail.com>
References: <cover.1597915265.git.zhuyifei@google.com>
 <9138c60f036c68f02c41dae0605ef587a8347f4c.1597915265.git.zhuyifei@google.com>
 <e02ae4a7-938f-222e-3139-5ba84e95df15@fb.com> <877dts5qah.fsf@toke.dk>
 <CAA-VZP=Jo0iQRpP+QEmB359C5TS=0BnDHTAzd6yC85aOkEJrsA@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Sun, 23 Aug 2020 20:36:07 +0200
Message-ID: <874kot2ors.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

YiFei Zhu <zhuyifei@google.com> writes:

> On Fri, Aug 21, 2020 at 3:58 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@re=
dhat.com> wrote:
>> Yonghong Song <yhs@fb.com> writes:
>> > Not sure whether we need formal libbpf API to access metadata or not.
>> > This may help other applications too. But we can delay until it is
>> > necessary.
>>
>> Yeah, please put in a libbpf accessor as well; I would like to use this
>> from libxdp - without a skeleton :)
>>
>> -Toke
>
> I don't think I have an idea on a good API in libbpf that could be
> used to get the metadata of an existing program in kernel, that could
> be reused by bpftool without duplicating all the code. Maybe we can
> discuss this in a follow up series?

I think the most important part is getting a reference to the metadata
map. So a function that basically does what the top half of what your
show_prog_metadata() function does: given a prog fd, walk the map ids,
check if any of them looks like a metadata map, and if so return the map
fd.

Should be pretty straight-forward to reuse between bpftool/libbpf, no?

-Toke

