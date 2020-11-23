Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 484BD2C0354
	for <lists+bpf@lfdr.de>; Mon, 23 Nov 2020 11:34:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728266AbgKWKbf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 23 Nov 2020 05:31:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:31409 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726819AbgKWKbf (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 23 Nov 2020 05:31:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606127494;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UMgCW61zqAkB3c+w/CYSUdpW3LDqmoWBeyI4srFJ58c=;
        b=S6bW3ry0mdtCohErut4KUwVMRP7UVJ9hM41muCmKdtUERNF017UtIpNYULeg33DiWSylDS
        PPOnWI2quJgWsnBGuXK0xiQXmaO+PfSY/RP4LEtLfRfZunkMIC3iBf0Tfky6n9wN1MtFvh
        J2NMB2Cm8TkeQFYIzf+rthNyOh+FQzg=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-368-xkTrbPtrOuK0f5yP6-eWpg-1; Mon, 23 Nov 2020 05:31:32 -0500
X-MC-Unique: xkTrbPtrOuK0f5yP6-eWpg-1
Received: by mail-ed1-f72.google.com with SMTP id l24so6387213edt.16
        for <bpf@vger.kernel.org>; Mon, 23 Nov 2020 02:31:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=UMgCW61zqAkB3c+w/CYSUdpW3LDqmoWBeyI4srFJ58c=;
        b=PCr5TbE6rKmKqLAM8vOjpS2TzBhWVYxXF29q+1MdUOXcQwcS2+h8lbjMaeiRt7Czc4
         PPRfRz1GyjuY1NVrJ40v4d5OBcrVs+wYaqsQCyTbE2H49vdywhkru/W68LukwJt53WcK
         Vc/al1UNj5crE1SGUN2loYRONwLhkRaTo7lid/Xm3J2qN2sE4xtJLeemTl1avrNNxtmd
         wQ6hXeK4E+6sgOBOVmIF1VRNTe60lR9Tj6hURf9+vmrQU1Jxltj33ltL0vz6V+BZwZ65
         jDWGBxA8LMHs+lvfVbZjwV45XDBAhHCZIN2Q3z9KzMIYKpi59Dho+p9gdU7ytylKdxQi
         L1TA==
X-Gm-Message-State: AOAM531ehi8Un7QOGlH3kF/FK5957afcjBK5KrVYRli59ymj8EOb56e3
        5wcJuDObeMHO6MLkhjVIzYGFBZo/V4pi2Zu2n3YIJeBMZJ46VemLYq94hyiqDOEA+0beqZNglU1
        x5r1Ttz8Jl5cT
X-Received: by 2002:a17:906:512:: with SMTP id j18mr44485838eja.370.1606127490547;
        Mon, 23 Nov 2020 02:31:30 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxQix3XASnb2R1wIlk0/OYWTa6sCSb/kGnCLCYE7l2XDHjsmpgtxsb/YepQiJp3/qHaW7kGYQ==
X-Received: by 2002:a17:906:512:: with SMTP id j18mr44485808eja.370.1606127490005;
        Mon, 23 Nov 2020 02:31:30 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id k2sm4683215ejp.6.2020.11.23.02.31.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2020 02:31:29 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 1B51D183064; Mon, 23 Nov 2020 11:31:27 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Jiri Pirko <jiri@mellanox.com>, bpf@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: Is test_offload.py supposed to work?
In-Reply-To: <20201120084846.710549e8@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
References: <87y2iwqbdg.fsf@toke.dk>
 <20201120084846.710549e8@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Mon, 23 Nov 2020 11:31:27 +0100
Message-ID: <873610nz40.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Jakub Kicinski <kuba@kernel.org> writes:

> On Fri, 20 Nov 2020 16:46:51 +0100 Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> Hi Jakub and Jiri
>>=20
>> I am investigating an error with XDP offload mode, and figured I'd run
>> 'test_offload.py' from selftests. However, I'm unable to get it to run
>> successfully; am I missing some config options, or has it simply
>> bit-rotted to the point where it no longer works?
>
> Yeah it must have bit rotted, there are no config options to get
> wrong there AFAIK.
>
> It shouldn't be too hard to fix tho, it's just a python script...

Right, I'll take a stab at fixing it, just wanted to make sure I wasn't
missing something obvious; thanks!

-Toke

