Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34958483821
	for <lists+bpf@lfdr.de>; Mon,  3 Jan 2022 21:59:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbiACU7H (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 3 Jan 2022 15:59:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:43683 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229492AbiACU7H (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 3 Jan 2022 15:59:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641243545;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IoV+MoGm8eJqU5c6p8KMUsKzlrjsSrE11cNQDWg57+4=;
        b=g4dnxf4sGVwtdvdYf7+YskPkJSxW9/orYtT5Rf4nHGleLzLa/DeBtEwsl670yXb2z7rSUH
        g3QDsa1reY6H348sFLAR9HaPXISslEi8JTZZz+i1HD1J0pAt1l9jbKo3nXeQPbIKTnOkyj
        5A3pvO7XfoAHSfpu2vNXFdEXkIeh5LU=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-456-_uhxQ-n-PjqwCnCFh_N52g-1; Mon, 03 Jan 2022 15:59:04 -0500
X-MC-Unique: _uhxQ-n-PjqwCnCFh_N52g-1
Received: by mail-ed1-f69.google.com with SMTP id l14-20020aa7cace000000b003f7f8e1cbbdso23667831edt.20
        for <bpf@vger.kernel.org>; Mon, 03 Jan 2022 12:59:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=IoV+MoGm8eJqU5c6p8KMUsKzlrjsSrE11cNQDWg57+4=;
        b=owIcl2NjHsDcC5DWMEtipDjT7GXpJYjsYpjlU1wuxVsdeEo7Zr0J4dSfRAKT0CdqVG
         6GrQXpvjk3FubsTiJ8Kw2yuatTgKLHtTokyuPt7FRV5e1Z90kbeNGB6DtGQLqudGr46y
         zM2Te2/dYLS2/TTkf+6z1paw16TSTETFgkE3/0L8sIpz7aFsOyzYvRbBt1j9DZU6799G
         rLFJ9VIIa/48iGaJg9Pt71HDdQstF0st11NAK54za/VdEu1y69n7OE2T0EC6rOAaDtH0
         eZMJH/CGglPjClIAzaSixl8tjm+JDk4S3hxhvf+/oEmsDStO5RUv10xJir6r3lZZ0klF
         DqTQ==
X-Gm-Message-State: AOAM530XvgOR5jdxKewxTT/QjgqyZQJTKDWTSXH4ZcbeMuyeiMyuaAc5
        wZHlzhNcBnqDMmIFV9ptp+SN5J5BMYJkoNENB86iBSa7COaVuu2GTlNyd+eQuGV085BbUpPfPSB
        9eHaW6GLeaK0s
X-Received: by 2002:a05:6402:40d1:: with SMTP id z17mr45130395edb.203.1641243542559;
        Mon, 03 Jan 2022 12:59:02 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzcnFRuqu7KsDy9wu4YJ9kmnqk+TrclTeu3tWYfzLOW5prWeTPsbGIFru8jiMgP4WZKcJxY8Q==
X-Received: by 2002:a05:6402:40d1:: with SMTP id z17mr45130369edb.203.1641243541860;
        Mon, 03 Jan 2022 12:59:01 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id i8sm11812976edc.91.2022.01.03.12.59.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jan 2022 12:59:01 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id C2199180300; Mon,  3 Jan 2022 21:59:00 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Tyler Wear <twear@quicinc.com>, Martin KaFai Lau <kafai@fb.com>,
        Maciej =?utf-8?Q?=C5=BBenczykowski?= <maze@google.com>
Cc:     "Tyler Wear (QUIC)" <quic_twear@quicinc.com>,
        Yonghong Song <yhs@fb.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: RE: [PATCH] Bpf Helper Function BPF_FUNC_skb_change_dsfield
In-Reply-To: <BYAPR02MB52382D9342669D4D578C85D8AA7C9@BYAPR02MB5238.namprd02.prod.outlook.com>
References: <20211220204034.24443-1-quic_twear@quicinc.com>
 <41e6f9da-a375-3e72-aed3-f3b76b134d9b@fb.com>
 <20211221061652.n4f47xh67uxqq5p4@kafai-mbp.dhcp.thefacebook.com>
 <BYAPR02MB5238740A681CD4E64D1EE0F0AA7C9@BYAPR02MB5238.namprd02.prod.outlook.com>
 <CANP3RGeNVSwSfb9T_6Xp8GyggbwnY7YQjv1Fw5L2wTtqiFJbpw@mail.gmail.com>
 <20211221215227.4kpw65oeusfskenx@kafai-mbp.dhcp.thefacebook.com>
 <CANP3RGdbYsue7xiYgVavnq2ysg6N6bWpFKnHxg4YkpQF9gv4oA@mail.gmail.com>
 <20211221230725.mm5ycvkof3sgihh6@kafai-mbp.dhcp.thefacebook.com>
 <BYAPR02MB52382D9342669D4D578C85D8AA7C9@BYAPR02MB5238.namprd02.prod.outlook.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Mon, 03 Jan 2022 21:59:00 +0100
Message-ID: <87a6gccz8r.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Tyler Wear <twear@quicinc.com> writes:

>> On Tue, Dec 21, 2021 at 02:13:04PM -0800, Maciej =C5=BBenczykowski wrote:
>> > > > As for what is driving this?  Upcoming wifi standard to allow
>> > > > access points to inform client devices how to dscp mark individual=
 flows.
>> > > Interesting.
>> > >
>> > > How does the sending host get this dscp value from wifi and then
>> > > affect the dscp of a particular flow?  Is the dscp going to be
>> > > stored in a bpf map for the bpf prog to use?
>> >
>> > It gets it out of band via some wifi signaling mechanism.
>> > Tyler probably knows the details.
>> >
>> > Storing flow match information to dscp mapping in a bpf map is indeed =
the plan.
>> >
>
> This is for an upcoming QoS Wifi Alliance spec.

Got a link, or some other information about the specifics of this? :)

-Toke

