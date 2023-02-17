Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53FEB69B434
	for <lists+bpf@lfdr.de>; Fri, 17 Feb 2023 21:50:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbjBQUuR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Feb 2023 15:50:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjBQUuQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Feb 2023 15:50:16 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 018365F271
        for <bpf@vger.kernel.org>; Fri, 17 Feb 2023 12:49:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676666964;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HPpXeHE7yIpnwoVN+RSEHBL4ndqdA5mUvILcECe2pZs=;
        b=BWBLieiQN4Kh7pHwIXjtftctFp7+oD2k5XSkEizC26ecG0BB3iEldlYfJDK0AcAEwCVaH7
        M435nMyLS61BqDwzUch14iuZqC0EeoZtYwKc7wWpAuS3UR0wwCj8wFqzbAM0GaFLgYHgbS
        U/Je9PPsUamhKzuElshGcUPQSV+c3f4=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-454-RStEqY9mOsSUVEN5lG6M5w-1; Fri, 17 Feb 2023 15:49:22 -0500
X-MC-Unique: RStEqY9mOsSUVEN5lG6M5w-1
Received: by mail-ed1-f71.google.com with SMTP id z20-20020a05640235d400b004a26cc7f6cbso3190744edc.4
        for <bpf@vger.kernel.org>; Fri, 17 Feb 2023 12:49:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HPpXeHE7yIpnwoVN+RSEHBL4ndqdA5mUvILcECe2pZs=;
        b=1Sdl9RUkrl5kBcGEiOX8CRf4C0opnFUSNl/qo2kf5V87xmcbJ77MHvVpcgubTc0tL0
         BhoYN/NDlp3C5nn06ZLNZ7JH4ONjThSE1DvdQ8nLdYOeP0nBhrxw8or8p6cCydRogViZ
         VktgqezBlE/UibwnLpCUrvZcRc0Wo8zdt/q1nLjJXZpVY3qJLKQbqAlV6UrnDyn2ShoZ
         KQ+TDxkF/0rDtVrpDi9QFLjbmWgYnmNSIPHEmOt/UGBQBoHUepNGHGyZW5DVNiOAgyjm
         0T/M/gyuv68oiPmoc84pH2sy+6bIREM3qAJQNfcrthiLwJbdIHbk6Yz1Dsic9HKomxIq
         OwLA==
X-Gm-Message-State: AO0yUKXWTkjc+qQPnsBlxlayEyy+v+xMn9svw7kbeLRdiVxJ1frsxbW4
        6OBJyYHITFXGzmF3IBL4kVJpdP3j9RU/p66BkDmGkJ9sMVgV+nkFv0n0ZCcxpK1lnNSBBbOexmI
        NempnAuyDNT2o
X-Received: by 2002:a17:906:6d84:b0:87f:2d81:1d2a with SMTP id h4-20020a1709066d8400b0087f2d811d2amr1325423ejt.35.1676666961413;
        Fri, 17 Feb 2023 12:49:21 -0800 (PST)
X-Google-Smtp-Source: AK7set/Wu74Ud4NsNvjllIQkdpd0JezWa+v3sHmHVHdl+b9b154S4zTinLDgzvLbQq0rj42RB+Jqvw==
X-Received: by 2002:a17:906:6d84:b0:87f:2d81:1d2a with SMTP id h4-20020a1709066d8400b0087f2d811d2amr1325387ejt.35.1676666960966;
        Fri, 17 Feb 2023 12:49:20 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id p8-20020a170906838800b0088f8abd3214sm2551770ejx.92.2023.02.17.12.49.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 12:49:20 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 073D59748D9; Fri, 17 Feb 2023 21:49:20 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Stanislav Fomichev <sdf@google.com>,
        Martin KaFai Lau <martin.lau@linux.dev>
Cc:     Jesper Dangaard Brouer <brouer@redhat.com>, bpf@vger.kernel.org,
        netdev@vger.kernel.org, martin.lau@kernel.org, ast@kernel.org,
        daniel@iogearbox.net, alexandr.lobakin@intel.com,
        larysa.zaremba@intel.com, xdp-hints@xdp-project.net
Subject: Re: [xdp-hints] Re: [PATCH bpf-next V2] xdp: bpf_xdp_metadata use
 NODEV for no device support
In-Reply-To: <CAKH8qBvwPA_VaHfwqzPN4SNFqCTgVFWH9zMj0LXio_=8Dg3TOw@mail.gmail.com>
References: <167663589722.1933643.15760680115820248363.stgit@firesoul>
 <Y++6IvP+PloUrCxs@google.com>
 <514bb57b-cc3e-7b7e-c7d4-94cdf52565d6@linux.dev>
 <CAKH8qBujK0RnOHi3EH_KwKamEtQRYJ6izoYRBB2_2CQias0HXA@mail.gmail.com>
 <eed53c45-84c4-9978-5323-cede57d9d797@linux.dev>
 <CAKH8qBvwPA_VaHfwqzPN4SNFqCTgVFWH9zMj0LXio_=8Dg3TOw@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 17 Feb 2023 21:49:19 +0100
Message-ID: <87mt5cow4w.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Stanislav Fomichev <sdf@google.com> writes:

> On Fri, Feb 17, 2023 at 9:55 AM Martin KaFai Lau <martin.lau@linux.dev> wrote:
>>
>> On 2/17/23 9:40 AM, Stanislav Fomichev wrote:
>> > On Fri, Feb 17, 2023 at 9:39 AM Martin KaFai Lau <martin.lau@linux.dev> wrote:
>> >>
>> >> On 2/17/23 9:32 AM, Stanislav Fomichev wrote:
>> >>> On 02/17, Jesper Dangaard Brouer wrote:
>> >>>> With our XDP-hints kfunc approach, where individual drivers overload the
>> >>>> default implementation, it can be hard for API users to determine
>> >>>> whether or not the current device driver have this kfunc available.
>> >>>
>> >>>> Change the default implementations to use an errno (ENODEV), that
>> >>>> drivers shouldn't return, to make it possible for BPF runtime to
>> >>>> determine if bpf kfunc for xdp metadata isn't implemented by driver.
>> >>>
>> >>>> This is intended to ease supporting and troubleshooting setups. E.g.
>> >>>> when users on mailing list report -19 (ENODEV) as an error, then we can
>> >>>> immediately tell them their device driver is too old.
>> >>>
>> >>> I agree with the v1 comments that I'm not sure how it helps.
>> >>> Why can't we update the doc in the same fashion and say that
>> >>> the drivers shouldn't return EOPNOTSUPP?
>> >>>
>> >>> I'm fine with the change if you think it makes your/users life
>> >>> easier. Although I don't really understand how. We can, as Toke
>> >>> mentioned, ask the users to provide jited program dump if it's
>> >>> mostly about user reports.
>> >>
>> >> and there is xdp-features also.
>> >
>> > Yeah, I was going to suggest it, but then I wasn't sure how to
>> > reconcile our 'kfunc is not a uapi' with xdp-features (that probably
>> > is a uapi)?
>>
>> uapi concern is a bit in xdp-features may go away because the kfunc may go away ?
>
> Yeah, if it's another kind of bitmask we'd have to retain those bits
> (in case of a particular kfunc ever going away)..
>
>> May be a list of xdp kfunc names that it supports? A list of kfunc btf id will
>> do also and the user space will need to map it back. Not sure if it is easily
>> doable in xdp-features.
>
> Good point. A string list / btf_id list of kfuncs implemented by
> netdev might be a good alternative.

Yup, Lorenzo and I discussed something similar at one point, I think
having this as part of the feature thing would be useful!

-Toke

