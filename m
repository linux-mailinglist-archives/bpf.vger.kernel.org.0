Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70D401775B4
	for <lists+bpf@lfdr.de>; Tue,  3 Mar 2020 13:12:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729120AbgCCMMQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 3 Mar 2020 07:12:16 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:30463 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727879AbgCCMMP (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 3 Mar 2020 07:12:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583237534;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kYcPsyPcZMo0qKyDJhxGZKc3OI/Y2/sXGHZo2fLvyT8=;
        b=gKuJMHAgMRhr0e4ZZlYTnPBYslSDR4vJA0mVGk8xGGxQsvNE/qeD5LQChtvCTrf4D2EzUJ
        0UhVXndk7uwGKUc0p3zsozk339JZdla2NJcZOpOEHPUzq58756Nhk/65X4G2OrraN9rYvH
        sx2UBQxg34bbUfEhX/Pxk/gKfnEkqEo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-156-FH9o99OaOmusg8JjM0pYjQ-1; Tue, 03 Mar 2020 07:12:13 -0500
X-MC-Unique: FH9o99OaOmusg8JjM0pYjQ-1
Received: by mail-wr1-f69.google.com with SMTP id y28so1110915wrd.23
        for <bpf@vger.kernel.org>; Tue, 03 Mar 2020 04:12:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=kYcPsyPcZMo0qKyDJhxGZKc3OI/Y2/sXGHZo2fLvyT8=;
        b=EJWiqB8f5VyPWZq6vYbkhsb/ifhDpV7F9X4NSAI4wwZS9yOFVubWq/TaWPL2dr/edh
         87UjvONwFU8qsTfSwNXC1DlXMlAImzC/rlkxrcFZelEQxHu92n5T/WVqvItoYwnv7Sm9
         vLtxGbvyE9zctT+v9KL32Kw8Pc2FzWu8Wn4OZ3LbILukHso6Kbf0Qy1j+C8+0Ry7UGo2
         wnFqPH1VlEAE7R8GpEZ8W8XBcWrbnCNzpE1/I2qrKZOpQTi14tsXyB/ohqRv7/Kz12cg
         go0bAyPVxE/CAhoS34cNTgUjGbHju0tn4GMzRTk1jbdj80ekeKWS2ydQut9GmCl7z9lP
         IJOQ==
X-Gm-Message-State: ANhLgQ2OQPBfjTKmZCX0kRqfJLkXu7Krnunr0KNMcz0SlKdtmH36vV3A
        Xk9g8tz9USKsWViWY584tft36xSwQNaLiUlwGQ3A4fLB3Y8DvYkmz0IeHZFyR0o1NmrVS/dtvy3
        MvVLtPAV6/Bmz
X-Received: by 2002:a05:6000:104f:: with SMTP id c15mr5005558wrx.376.1583237531724;
        Tue, 03 Mar 2020 04:12:11 -0800 (PST)
X-Google-Smtp-Source: ADFU+vtpPtU/qVowg+VqUFfk2WR/wwv6QMRuEhkfSrHXArJGcJl769Kez2QBsIHXDfNM92HkZvAkrQ==
X-Received: by 2002:a05:6000:104f:: with SMTP id c15mr5005538wrx.376.1583237531531;
        Tue, 03 Mar 2020 04:12:11 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id o26sm3501111wmc.33.2020.03.03.04.12.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 04:12:10 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 8979F180331; Tue,  3 Mar 2020 13:12:09 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Jesper Dangaard Brouer <brouer@redhat.com>, bpf@vger.kernel.org
Cc:     Jesper Dangaard Brouer <brouer@redhat.com>, gamemann@gflclan.com,
        lrizzo@google.com, netdev@vger.kernel.org,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Daniel Borkmann <borkmann@iogearbox.net>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [bpf-next PATCH] xdp: accept that XDP headroom isn't always equal XDP_PACKET_HEADROOM
In-Reply-To: <158323601793.2048441.8715862429080864020.stgit@firesoul>
References: <158323601793.2048441.8715862429080864020.stgit@firesoul>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 03 Mar 2020 13:12:09 +0100
Message-ID: <874kv563ja.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Jesper Dangaard Brouer <brouer@redhat.com> writes:

> The Intel based drivers (ixgbe + i40e) have implemented XDP with
> headroom 192 bytes and not the recommended 256 bytes defined by
> XDP_PACKET_HEADROOM.  For generic-XDP, accept that this headroom
> is also a valid size.
>
> Still for generic-XDP if headroom is less, still expand headroom to
> XDP_PACKET_HEADROOM as this is the default in most XDP drivers.
>
> Tested on ixgbe with xdp_rxq_info --skb-mode and --action XDP_DROP:
> - Before: 4,816,430 pps
> - After : 7,749,678 pps
> (Note that ixgbe in native mode XDP_DROP 14,704,539 pps)
>
> Signed-off-by: Jesper Dangaard Brouer <brouer@redhat.com>
> ---
>  include/uapi/linux/bpf.h |    1 +
>  net/core/dev.c           |    4 ++--
>  2 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 906e9f2752db..14dc4f9fb3c8 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -3312,6 +3312,7 @@ struct bpf_xdp_sock {
>  };
>  
>  #define XDP_PACKET_HEADROOM 256
> +#define XDP_PACKET_HEADROOM_MIN 192

Do we need a comment here explaining why there are two values?

-Toke

