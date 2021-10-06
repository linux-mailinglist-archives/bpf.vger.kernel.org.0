Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0405423B3F
	for <lists+bpf@lfdr.de>; Wed,  6 Oct 2021 12:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238030AbhJFKKM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 6 Oct 2021 06:10:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50252 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237976AbhJFKKM (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 6 Oct 2021 06:10:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633514899;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RD0kZmMRwV1oR0tBc71TpFfkf9QWoURBsG7TuBGdr7E=;
        b=OznYvoF3jSTNpdkt0RFqK6AAdYfknEBYcVaKoLuLdMTVEmJrjyodB8kxf7jNxrWRCd0Zwz
        +nvi+MLeGubA5hUtkQ8QtTbggxHUnM7hUZ+pObGufBt+5X57I0kcZS5sjsS7culQJXHc+w
        Vc0R62SlllxFSpzDDCt7saD9X5sMVAE=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-433-shWP3H2gN7SIPUQrxv40sw-1; Wed, 06 Oct 2021 06:08:18 -0400
X-MC-Unique: shWP3H2gN7SIPUQrxv40sw-1
Received: by mail-ed1-f71.google.com with SMTP id x5-20020a50f185000000b003db0f796903so2123902edl.18
        for <bpf@vger.kernel.org>; Wed, 06 Oct 2021 03:08:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RD0kZmMRwV1oR0tBc71TpFfkf9QWoURBsG7TuBGdr7E=;
        b=Ee+7DOUoG9+qLMHOURk5ge6AXDHaiaug+GBNj7FoSijmDPSopf8//chvsMBso+rrXn
         3re/x5A62JmAOJ/dA4kSTMoGoPWUNPfkFrhyxvI+M8ny528kjWrAsR8jWcwFXWL0rsOK
         Ma6g62Xkn3V/DHC+ZA/SHwIsVPIQAgKmPMD1Jjmwd2DEGKjiUDCOYsvEHkKMokEpd9eb
         B67a4QBA+VByeY5WK8hlD0fiVWKCHdQDKPlNfWlB/rdQTB/mKvSfsmsU5RYFwJjhscRS
         oOhouf4LxJOgPlZIG+4X5ratiKVB+m8VEtFnrSQCPXBscO4J+dVESq2cDBgb2OSmO0Rz
         c9EA==
X-Gm-Message-State: AOAM532yfNj0wszcPIEiuEHRRxoC+gVhF921HnstPzazetBmhykkVFC+
        ZiC16lH4BTTOpQfiC/RMKs4cDDzb3Rx/cEXAXL8ZMGWsGeyfA4QeTamcYtnm3ddQUb/Y0usiqZI
        JhJAbnGksJrGC
X-Received: by 2002:a17:906:2cd6:: with SMTP id r22mr30354638ejr.398.1633514897492;
        Wed, 06 Oct 2021 03:08:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxmoVgM2oKuMsMS3OhDrUiPb55LUAYV5+t2qx3p9ImNfbp4THX7Kd/rXZod2dhsnudaO4oZVA==
X-Received: by 2002:a17:906:2cd6:: with SMTP id r22mr30354603ejr.398.1633514897279;
        Wed, 06 Oct 2021 03:08:17 -0700 (PDT)
Received: from [10.39.193.81] (5920ab7b.static.cust.trined.nl. [89.32.171.123])
        by smtp.gmail.com with ESMTPSA id z8sm8810012ejd.94.2021.10.06.03.08.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Oct 2021 03:08:16 -0700 (PDT)
From:   Eelco Chaudron <echaudro@redhat.com>
To:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Cc:     Jakub Kicinski <kuba@kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Toke =?utf-8?b?SMO4aWxhbmQtSsO4cmdlbnNlbg==?= <toke@redhat.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Lorenz Bauer <lmb@cloudflare.com>, bpf <bpf@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, shayagr@amazon.com,
        John Fastabend <john.fastabend@gmail.com>,
        David Ahern <dsahern@kernel.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        Saeed Mahameed <saeed@kernel.org>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        "Karlsson, Magnus" <magnus.karlsson@intel.com>,
        tirthendu.sarkar@intel.com
Subject: Re: [PATCH v14 bpf-next 00/18] mvneta: introduce XDP multi-buffer support
Date:   Wed, 06 Oct 2021 12:08:16 +0200
X-Mailer: MailMate (1.14r5820)
Message-ID: <B46C005A-CCB0-442D-A2E4-19B34ABB97CE@redhat.com>
In-Reply-To: <YV1tNFy971iqq0Ay@lore-desk>
References: <cover.1631289870.git.lorenzo@kernel.org>
 <20210916095539.4696ae27@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <CACAyw9-8t8RpJgJUTd7u6bOLnJ1xQsgK7z37QrL9T1FUaJ7WNQ@mail.gmail.com>
 <87v92jinv7.fsf@toke.dk>
 <CACAyw99S9v658UyiKz3ad4kja7rDNfYv+9VOXZHCUOtam_C8Wg@mail.gmail.com>
 <CAADnVQ+XXGUxzqMdbPMYf+t_ViDkqvGDdogrmv-wH-dckzujLw@mail.gmail.com>
 <20210929122229.1d0c4960@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <87mtnvi0bc.fsf@toke.dk> <YVbO/kit/mjWTrv6@lore-desk>
 <20211001113528.79f35460@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <YV1tNFy971iqq0Ay@lore-desk>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 6 Oct 2021, at 11:32, Lorenzo Bianconi wrote:

>> On Fri, 1 Oct 2021 11:03:58 +0200 Lorenzo Bianconi wrote:
>>> Can you please check if the code above is aligned to current requirem=
ents or if
>>> it is missing something?
>>> If this code it is fine, I guess we have two option here:
>>> - integrate the commits above in xdp multi-buff series (posting v15) =
and work on
>>>   the verfier code in parallel (if xdp_mb_pointer helper is not requi=
red from day0)
>>> - integrate verfier changes in xdp multi-buff series, drop bpf_xdp_lo=
ad_bytes
>>>   helper (probably we will still need bpf_xdp_store_bytes) and introd=
uce
>>>   bpf_xdp_pointer as new ebpf helper.
>>
>> It wasn't clear to me that we wanted bpf_xdp_load_bytes() to exist.
>> But FWIW no preference here.
>>
>
> ack, same here. Any other opinion about it?

I was under the impression getting a pointer might be enough. But playing=
 with the bpf ring buffers for a bit, it still might be handy to extract =
some data to be sent to userspace. So I would not mind keeping it.

