Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2983A487B69
	for <lists+bpf@lfdr.de>; Fri,  7 Jan 2022 18:29:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348569AbiAGR3c (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 7 Jan 2022 12:29:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:26962 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1348576AbiAGR3b (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 7 Jan 2022 12:29:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641576571;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=w2KxBeQrAHXVA9SVJNoEJTZJLIEcRuBQ110rV6r0h9c=;
        b=EtzPgzGMFayqkMrb51VR7+YgYtHD6NbYBNhUCqlZRIQ2cVTOepRCn3Zoxz/vHsZOcNBWm6
        auyOGoZTstYOwvHK/+kIo61wtXrO7mJtVBQKl1IVBzPwgta6ITYYTNUju0hj2TVwHuVnLR
        bPW6VEgzG/8ka8vZgNFQXMcWb8yl7sk=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-513-or0hIQIMOZC-8PQffNQYag-1; Fri, 07 Jan 2022 12:29:30 -0500
X-MC-Unique: or0hIQIMOZC-8PQffNQYag-1
Received: by mail-ed1-f72.google.com with SMTP id g2-20020a056402424200b003f8ee03207eso5226039edb.7
        for <bpf@vger.kernel.org>; Fri, 07 Jan 2022 09:29:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=w2KxBeQrAHXVA9SVJNoEJTZJLIEcRuBQ110rV6r0h9c=;
        b=mDWf9qEUJPOemMG82jvSUjf1v24NHA+CCJaDLqIcFOVEwL0umlWUGSsA5dz0yWz1j5
         PZ3aFbkdlgYnt+6zLO3cxSI9OcqTvvmmZ79J3iHOS72E8AIQg8hsVN1h2lUWM8ivdDPE
         FARl72ozRJ27FFbakrCG17npRkEW7zPWRf2NVE0NSOFF9icRGSjcDKucs1SFGjsHMQ84
         sXpvf3ibg3YBgpfD520KUJkH64CNZ/UFznO0l2U6K3IAUD6Mp3YHx0T4fsGSebvgTtmB
         vuh6Sfqt7dECo6Tfp3rNsrbYCklMeZhor/+Aw0Dgiuk1yJmMw433TdZFNcu08CXYFaOR
         3GWQ==
X-Gm-Message-State: AOAM530psIERZzIiKfS8Rvp8bmHd0XJCWQLIHfaVBSoMuqsRdMENVm0l
        B3FAekYlMqG5CHDaNnxT6E4vhpcrIVimKxls1zhNTmRUl/PfSHASBzUbIVImeiR9XITQ8vUaaUV
        AI33AK27ULvzY
X-Received: by 2002:a17:907:6d9b:: with SMTP id sb27mr51336320ejc.1.1641576568815;
        Fri, 07 Jan 2022 09:29:28 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzzZgAyvHy6/3n4mdP5+CHjQ6k0K3cLQ0RLXe8ADTAkR0sdYwTJWo+R+P5+Omx9hBM/6p+3nw==
X-Received: by 2002:a17:907:6d9b:: with SMTP id sb27mr51336290ejc.1.1641576568381;
        Fri, 07 Jan 2022 09:29:28 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id qw4sm1574095ejc.55.2022.01.07.09.29.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jan 2022 09:29:27 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 162B0181F2A; Fri,  7 Jan 2022 18:29:27 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        syzbot <syzbot+983941aa85af6ded1fd9@syzkaller.appspotmail.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Martin KaFai Lau <kafai@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        Song Liu <songliubraving@fb.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Yonghong Song <yhs@fb.com>
Subject: Re: [syzbot] general protection fault in dev_get_by_index_rcu (2)
In-Reply-To: <CAADnVQLH5r-OLfGwduMqvTuz952Y+D7X29bW-f8QGpE9G6dF6g@mail.gmail.com>
References: <000000000000ab9b3e05d4feacd6@google.com>
 <CAADnVQLH5r-OLfGwduMqvTuz952Y+D7X29bW-f8QGpE9G6dF6g@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 07 Jan 2022 18:29:27 +0100
Message-ID: <874k6fa1zc.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:

> Toke, Jesper,
>
> please take a look.
> Seems to be in your area of expertise.

Yikes, I think I see the problem. Let me just confirm and I'll send a fix :)

-Toke

