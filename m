Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0EED1C6B60
	for <lists+bpf@lfdr.de>; Wed,  6 May 2020 10:20:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728884AbgEFIT5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 6 May 2020 04:19:57 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57542 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728875AbgEFIT4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 6 May 2020 04:19:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588753195;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RCAnXwZiAEiMj7R4ogMQj0woVBKNACtfrYeqTg9CBXo=;
        b=WA6smniH//ewHF7w6tGyq/otml4+NZxZm9X05CmC2sR2aOYjV9fhVRiq5VVV1iKQRnI3SQ
        xpLKcgZPCWbbrzMKnJkHuCeemln3lNppGgeTORYOVddIBW1Ka3k5qUukPxvgg7XHYKCF2w
        l2n8fjFV0+vM7fNomp/caoaufL2HUV0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-132-9_qVx4ajOxaJgzLRs0P4VQ-1; Wed, 06 May 2020 04:19:51 -0400
X-MC-Unique: 9_qVx4ajOxaJgzLRs0P4VQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8787818FE860;
        Wed,  6 May 2020 08:19:50 +0000 (UTC)
Received: from [10.72.13.165] (ovpn-13-165.pek2.redhat.com [10.72.13.165])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 22F8E1FBCD;
        Wed,  6 May 2020 08:19:41 +0000 (UTC)
Subject: Re: [PATCH net-next 1/2] virtio-net: don't reserve space for vnet
 header for XDP
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        Jesper Dangaard Brouer <brouer@redhat.com>
References: <20200506061633.16327-1-jasowang@redhat.com>
 <20200506033834-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <7a169b06-b6b9-eac1-f03a-39dd1cfcce57@redhat.com>
Date:   Wed, 6 May 2020 16:19:40 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200506033834-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


On 2020/5/6 =E4=B8=8B=E5=8D=883:53, Michael S. Tsirkin wrote:
> On Wed, May 06, 2020 at 02:16:32PM +0800, Jason Wang wrote:
>> We tried to reserve space for vnet header before
>> xdp.data_hard_start. But this is useless since the packet could be
>> modified by XDP which may invalidate the information stored in the
>> header and there's no way for XDP to know the existence of the vnet
>> header currently.
> What do you mean? Doesn't XDP_PASS use the header in the buffer?


We don't, see 436c9453a1ac0 ("virtio-net: keep vnet header zeroed after=20
processing XDP")

If there's other place, it should be a bug.


>
>> So let's just not reserve space for vnet header in this case.
> In any case, we can find out XDP does head adjustments
> if we need to.


But XDP program can modify the packets without adjusting headers.

Thanks


>
>
>> Cc: Jesper Dangaard Brouer <brouer@redhat.com>
>> Signed-off-by: Jason Wang <jasowang@redhat.com>
>> ---
>>   drivers/net/virtio_net.c | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>> index 11f722460513..98dd75b665a5 100644
>> --- a/drivers/net/virtio_net.c
>> +++ b/drivers/net/virtio_net.c
>> @@ -684,8 +684,8 @@ static struct sk_buff *receive_small(struct net_de=
vice *dev,
>>   			page =3D xdp_page;
>>   		}
>>  =20
>> -		xdp.data_hard_start =3D buf + VIRTNET_RX_PAD + vi->hdr_len;
>> -		xdp.data =3D xdp.data_hard_start + xdp_headroom;
>> +		xdp.data_hard_start =3D buf + VIRTNET_RX_PAD;
>> +		xdp.data =3D xdp.data_hard_start + xdp_headroom + vi->hdr_len;
>>   		xdp.data_end =3D xdp.data + len;
>>   		xdp.data_meta =3D xdp.data;
>>   		xdp.rxq =3D &rq->xdp_rxq;
>> @@ -845,7 +845,7 @@ static struct sk_buff *receive_mergeable(struct ne=
t_device *dev,
>>   		 * the descriptor on if we get an XDP_TX return code.
>>   		 */
>>   		data =3D page_address(xdp_page) + offset;
>> -		xdp.data_hard_start =3D data - VIRTIO_XDP_HEADROOM + vi->hdr_len;
>> +		xdp.data_hard_start =3D data - VIRTIO_XDP_HEADROOM;
>>   		xdp.data =3D data + vi->hdr_len;
>>   		xdp.data_end =3D xdp.data + (len - vi->hdr_len);
>>   		xdp.data_meta =3D xdp.data;
>> --=20
>> 2.20.1

