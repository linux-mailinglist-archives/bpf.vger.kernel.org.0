Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D66E54B2995
	for <lists+bpf@lfdr.de>; Fri, 11 Feb 2022 17:04:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350006AbiBKQDS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Feb 2022 11:03:18 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349953AbiBKQDR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Feb 2022 11:03:17 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A0B8512C
        for <bpf@vger.kernel.org>; Fri, 11 Feb 2022 08:03:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644595394;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5SUmE6QHUf23szu6zr/IYA5uaUImDnL5V0qML7K/U8Y=;
        b=eOfbdTwMLKdF/MYJBy/eAd/k1B0lk/bEzVBtphrDk0vOyWdG0W+ffgiHWts2LRyZDiq9Iw
        simPKWZYRTlUiA79gKYdqCZ0MOv3TlNBY4Yq7YFGYzAVSsOL1zZEm4qm87i5lQBlKu4FNr
        sRb0fdlRdZJEfnnOQWoSe20lguwsBTQ=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-266-zeOJwmdBMHqoFNGYSkmVMA-1; Fri, 11 Feb 2022 11:03:13 -0500
X-MC-Unique: zeOJwmdBMHqoFNGYSkmVMA-1
Received: by mail-ej1-f71.google.com with SMTP id v2-20020a170906292200b006a94a27f903so4315041ejd.8
        for <bpf@vger.kernel.org>; Fri, 11 Feb 2022 08:03:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=5SUmE6QHUf23szu6zr/IYA5uaUImDnL5V0qML7K/U8Y=;
        b=xsTXa0K4wS4lSoqZ6NEr4pVShuk44/o6ACnbFgt3Fn1QGWqRJM76ki9OAvQb5VsWS7
         waXLjQxgwLnJyt0U1mBBMISWo6Bb/bFPHq+PYuK1quPyNr5qAnXuzMpaqFYNNkQAy5T1
         QcmnYlu3cG2RWmGo15lCMuqzk5teXVdqhtLlRajlLtHCRRY8O8Hx1czfjkRmPaor/esc
         FlK/o/A2Cg07q9IoVXjvkkvA0HBG2HUszadPOteU2kmg6taRcP3dUkKFqc9mnM2PLSP3
         aEoOPD0YCjmJMYg7m0t/e5NAB4Sd86/3DCIXGJnTDf33vN4fVvBIdRRKH82IgzbrNW4u
         OkyA==
X-Gm-Message-State: AOAM531pT/ZI8JhdkykpPaBCdGU0yiPArEEhGhDaIYDiyQgrw54ev3NP
        TnTlvfX//k09bR60xe/hv/jpWqeX3TCMsRVRv0u7rk/4P1JCkw0dbjGOonZf1Ro3fJNqFwZcqPk
        ovH3zDQYrdmkp
X-Received: by 2002:a05:6402:2689:: with SMTP id w9mr2633489edd.68.1644595391145;
        Fri, 11 Feb 2022 08:03:11 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyvlPI4HeGgTB8NPo1F1+3GqMmRJDR/JlN4rymRpms8At4iTCudgKFtJWA+B6bqZnQ1cgHh2Q==
X-Received: by 2002:a05:6402:2689:: with SMTP id w9mr2633358edd.68.1644595389929;
        Fri, 11 Feb 2022 08:03:09 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id en9sm6443160edb.71.2022.02.11.08.03.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 08:03:08 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id AA92F102D4A; Fri, 11 Feb 2022 17:03:07 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next v7 1/3] bpf: Add "live packet" mode for XDP in
 bpf_prog_run()
In-Reply-To: <20220211071952.t7e6shipuc5shblv@kafai-mbp.dhcp.thefacebook.com>
References: <20220107215438.321922-1-toke@redhat.com>
 <20220107215438.321922-2-toke@redhat.com>
 <CAADnVQ+uftgnRQa5nvG4FTJga_=_FMAGxuiPB3O=AFKfEdOg=A@mail.gmail.com>
 <87pmp28iwe.fsf@toke.dk>
 <CAADnVQLWjbm03-3NHYyEx98tWRN68LSaOd3R9fjJoHY5cYoEJg@mail.gmail.com>
 <87mtk67zfm.fsf@toke.dk>
 <20220109022448.bxgatdsx3obvipbu@ast-mbp.dhcp.thefacebook.com>
 <87ee5h852v.fsf@toke.dk>
 <CAADnVQLk6TLdA7EG8TKGHM_R93GgQf76J60PEJohjup8JaP+Xw@mail.gmail.com>
 <20220211071952.t7e6shipuc5shblv@kafai-mbp.dhcp.thefacebook.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 11 Feb 2022 17:03:07 +0100
Message-ID: <87czjt8k78.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Martin KaFai Lau <kafai@fb.com> writes:

> On Wed, Jan 12, 2022 at 05:37:54PM -0800, Alexei Starovoitov wrote:
>> On Sun, Jan 9, 2022 at 4:30 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@re=
dhat.com> wrote:
>> >
>> > I left that out on purpose: I feel it's exposing an internal
>> > implementation detail as UAPI (as you said). And I'm not convinced it
>> > really needed (or helpful) - see below.
>>=20
>> It's irrelevant whether it's documented or not.
>> Once this implementation detail is being relied upon
>> by user space it becomes an undocumented uapi that we cannot change.
>>=20
>> > I'll try implementing a TCP stream mode in xdp_trafficgen just to make
>> > sure I'm not missing something. But I believe that sending out a stream
>> > of packets that looks like a coherent TCP stream should be simple
>> > enough, at least. Dealing with the full handshake + CWND control loop
>> > will be harder, though, and right now I think it'll require multiple
>> > trips back to userspace.
>>=20
>> The patch set looks very close to being able to do such TCP streaming.
>> Let's make sure nothing is missing from API before we land it.
> Hi Toke,  I am also looking at ways to blast tcp packets by using
> bpf to overcome the pktgen udp-only limitation.
> Are you planning to respin with a TCP stream mode in xdp_trafficgen ?
> Thanks !

Yes, working on it! Got sidetracked a bit, but hoping to have something
to show for my efforts sometime next week :)

-Toke

