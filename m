Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4462C45FDCF
	for <lists+bpf@lfdr.de>; Sat, 27 Nov 2021 10:54:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353508AbhK0J5N (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 27 Nov 2021 04:57:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:29924 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1354084AbhK0JzN (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sat, 27 Nov 2021 04:55:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638006718;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p75atS3SnkNsb8S2VmpxFfNaOxa+SCCGx3bM477zQ0Y=;
        b=HoqmbhznI73eO1aZ2F1MK/kW2sGGjxCHPumzykh1PcXVXIuKfW1qyNRtUoh0nKIFtm1WYv
        hCpdUvTOgZb+E3BUobLyyd5TJ/nLPM3jbaF+Y35IiWO8qvqJDYJpgxZ8WG2ZIPfkysD4dD
        BZ9bQrFk2AhLErg12Ezv4sl+cPFJ1a0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-530-hH5rzfUyMsaQObFYxcHfnw-1; Sat, 27 Nov 2021 04:51:57 -0500
X-MC-Unique: hH5rzfUyMsaQObFYxcHfnw-1
Received: by mail-wm1-f69.google.com with SMTP id r129-20020a1c4487000000b00333629ed22dso8429824wma.6
        for <bpf@vger.kernel.org>; Sat, 27 Nov 2021 01:51:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:message-id:date:mime-version:user-agent:cc
         :subject:content-language:to:references:in-reply-to
         :content-transfer-encoding;
        bh=p75atS3SnkNsb8S2VmpxFfNaOxa+SCCGx3bM477zQ0Y=;
        b=1GYAOAyH5S8fKjx1T1/IWUaG5Xa2D+iKiNykIp8SHoHU6UwVAIWWbC3dvm+cN0P2Bv
         kODnC5hQq8hfxng2fgjNR7ZJEf4+I/sfjIJib69epoYyQ6O5eU4fB7LYjyOXO6i00MCc
         XvxiU4y3d2B21VQZ9+RWbjkkO2DDg6bNzJFhnCq4fyf6xXMvZz1k4ST1edkWc6ocTLyH
         zKHPqvTYspcXw14dGwRUCFbTCQoc607dRCj+kC6nWGI9W9dsHkFHfg7r71DC191SKtb9
         COEMHgB6WGZSV3P7CZMersN+LKdPySr6nNJ/2fplsTEHNdC5jR4VYn6fyIrIM8t9Hm40
         rYrw==
X-Gm-Message-State: AOAM532ovNfmWU+NqxtzEuQ7MkXT0RcPwGwJ0d5pmSOaqsJJyj7hvD+R
        ufo4Xm9nlUZLvz9Ri8b87M5KD2/wHHJsNZqLfUBrldoDZsj6kycXwg/GDnC7EbkEQhv+3H3328t
        3xTZcysRUSR3g
X-Received: by 2002:a1c:2047:: with SMTP id g68mr22167716wmg.181.1638006715493;
        Sat, 27 Nov 2021 01:51:55 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwrC1pkgjEewkKotBw1LkGeoMrE6rp5r7iq42oOQXf6GEEveAUFje8X+iRIbN6+ivpoegAexw==
X-Received: by 2002:a1c:2047:: with SMTP id g68mr22167699wmg.181.1638006715350;
        Sat, 27 Nov 2021 01:51:55 -0800 (PST)
Received: from [192.168.2.13] (3-14-107-185.static.kviknet.dk. [185.107.14.3])
        by smtp.gmail.com with ESMTPSA id 8sm12598430wmg.24.2021.11.27.01.51.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Nov 2021 01:51:54 -0800 (PST)
From:   Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <804e9942-8697-4703-3cde-5f74d916e325@redhat.com>
Date:   Sat, 27 Nov 2021 10:51:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Cc:     brouer@redhat.com, bjorn@kernel.org,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>
Subject: Re: [PATCH bpf-next 2/4] samples/bpf: xdpsock: add Dest and Src MAC
 setting for Tx-only operation
Content-Language: en-US
To:     Ong Boon Leong <boon.leong.ong@intel.com>, bpf@vger.kernel.org,
        netdev@vger.kernel.org
References: <20211124091821.3916046-1-boon.leong.ong@intel.com>
 <20211124091821.3916046-3-boon.leong.ong@intel.com>
In-Reply-To: <20211124091821.3916046-3-boon.leong.ong@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 24/11/2021 10.18, Ong Boon Leong wrote:
> To set Dest MAC address (-G|--tx-dmac) only:
>   $ xdpsock -i eth0 -t -N -z -G aa:bb:cc:dd:ee:ff
> 
> To set Source MAC address (-H|--tx-smac) only:
>   $ xdpsock -i eth0 -t -N -z -H 11:22:33:44:55:66
> 
> To set both Dest and Source MAC address:
>   $ xdpsock -i eth0 -t -N -z -G aa:bb:cc:dd:ee:ff \
>     -H 11:22:33:44:55:66
> 
> The default Dest and Source MAC address remain the same as before.
> 
> Signed-off-by: Ong Boon Leong<boon.leong.ong@intel.com>
> ---
>   samples/bpf/xdpsock_user.c | 36 +++++++++++++++++++++++++++++++-----
>   1 file changed, 31 insertions(+), 5 deletions(-)

Acked-by: Jesper Dangaard Brouer <brouer@redhat.com>

