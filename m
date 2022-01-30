Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DD154A3615
	for <lists+bpf@lfdr.de>; Sun, 30 Jan 2022 12:58:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236399AbiA3L6R (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 30 Jan 2022 06:58:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347001AbiA3L6R (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 30 Jan 2022 06:58:17 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C886CC061714
        for <bpf@vger.kernel.org>; Sun, 30 Jan 2022 03:58:16 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id e2so20090913wra.2
        for <bpf@vger.kernel.org>; Sun, 30 Jan 2022 03:58:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=CwGvYUvvwY+1O4rU4KEaLaTm1ToMNJe5IjL6iva8kjo=;
        b=eCoROuCgBOOirJZOOq8/Xpq+dxaxJgweubsJMhdUTEcK4IRNCfl1zsRRAmzfcIi4N1
         XbLwjyHJp72oVz+/VQMIQRqkxxtFIILvh2uEImGKEHIb1oGJpQDv8TvrUyjzRC5OccKz
         tw8kRkfdg68LqVF0hg3CZVZ4w888qw37OYWS0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=CwGvYUvvwY+1O4rU4KEaLaTm1ToMNJe5IjL6iva8kjo=;
        b=GbI6vCgraxYUrmKMSlviZeu8582HDP39A3bqhyReYta9RGR+ukdXxHQNAqYjTPTgi/
         V0Uq8OQq0Vf4O34ZIVMAcqMW3j5O+tTPZPI33v67X2gkWh4tCO1BeVxJToErv8qi7dyb
         Ro1NTrWNg6RJhzBRQTuTJWLbTlF1+Ur4M7XhqVAdw7CyECji1MhRyvS+7BkIig6/dhzx
         zkrXu+ji3K1unaZrOwrceXo/aSzZIeTb4ni0GKMygrSZ/oLXgTVJDdNfhfaBmFyzaJz9
         qoOjRnWuq6vktWUh8iaoewO5qdG17M6WfoGPnekov5/6D0wkDSnmiyuFJD3lpieTkG6V
         1Vew==
X-Gm-Message-State: AOAM5316gWA9VSQeW8w35csQinr5tFp/qmvsXDCvk43t9FlIQYLu26iA
        hKzzC2Wa/ng1y0IJNeUtY4hxdg==
X-Google-Smtp-Source: ABdhPJyx1TNa/rchQWCDsQ2cFQRCcqNdJmglEsfw/6LQ5EYQh29hDlSr/+LwIdbGC31H2nDa5L7iYQ==
X-Received: by 2002:a05:6000:1a8c:: with SMTP id f12mr3047334wry.153.1643543895356;
        Sun, 30 Jan 2022 03:58:15 -0800 (PST)
Received: from cloudflare.com (2a01-110f-4809-d800-0000-0000-0000-0e00.aa.ipv6.supernova.orange.pl. [2a01:110f:4809:d800::e00])
        by smtp.gmail.com with ESMTPSA id s9sm8950701wrr.84.2022.01.30.03.58.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jan 2022 03:58:14 -0800 (PST)
References: <20220127172448.155686-1-jakub@cloudflare.com>
 <20220127172448.155686-2-jakub@cloudflare.com>
 <CAADnVQ+96ORKkbUA-Y7xiYV=TxSTh=p78f+t8TR4SN=YBMoEPA@mail.gmail.com>
User-agent: mu4e 1.1.0; emacs 27.2
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Menglong Dong <imagedong@tencent.com>,
        Martin KaFai Lau <kafai@fb.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Make dst_port field in struct
 bpf_sock 16-bit wide
In-reply-to: <CAADnVQ+96ORKkbUA-Y7xiYV=TxSTh=p78f+t8TR4SN=YBMoEPA@mail.gmail.com>
Date:   Sun, 30 Jan 2022 12:58:13 +0100
Message-ID: <871r0psaei.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jan 28, 2022 at 07:17 PM CET, Alexei Starovoitov wrote:
> On Thu, Jan 27, 2022 at 9:24 AM Jakub Sitnicki <jakub@cloudflare.com> wrote:
>>
>> Menglong Dong reports that the documentation for the dst_port field in
>> struct bpf_sock is inaccurate and confusing. From the BPF program PoV, the
>> field is a zero-padded 16-bit integer in network byte order. The value
>> appears to the BPF user as if laid out in memory as so:
>>
>>   offsetof(struct bpf_sock, dst_port) + 0  <port MSB>
>>                                       + 8  <port LSB>
>>                                       +16  0x00
>>                                       +24  0x00
>>
>> 32-, 16-, and 8-bit wide loads from the field are all allowed, but only if
>> the offset into the field is 0.
>>
>> 32-bit wide loads from dst_port are especially confusing. The loaded value,
>> after converting to host byte order with bpf_ntohl(dst_port), contains the
>> port number in the upper 16-bits.
>>
>> Remove the confusion by splitting the field into two 16-bit fields. For
>> backward compatibility, allow 32-bit wide loads from offsetof(struct
>> bpf_sock, dst_port).
>>
>> While at it, allow loads 8-bit loads at offset [0] and [1] from dst_port.
>>
>> Reported-by: Menglong Dong <imagedong@tencent.com>
>> Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
>> ---
>>  include/uapi/linux/bpf.h | 3 ++-
>>  net/core/filter.c        | 9 ++++++++-
>>  2 files changed, 10 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
>> index 4a2f7041ebae..027e84b18b51 100644
>> --- a/include/uapi/linux/bpf.h
>> +++ b/include/uapi/linux/bpf.h
>> @@ -5574,7 +5574,8 @@ struct bpf_sock {
>>         __u32 src_ip4;
>>         __u32 src_ip6[4];
>>         __u32 src_port;         /* host byte order */
>> -       __u32 dst_port;         /* network byte order */
>> +       __be16 dst_port;        /* network byte order */
>> +       __u16 zero_padding;
>
> I was wondering can we do '__u16 :16' here ?

Great idea. Now done in v2:

https://lore.kernel.org/bpf/20220130115518.213259-1-jakub@cloudflare.com/

> Should we do the same for bpf_sk_lookup->remote_port as well
> for consistency?

I can tend to that this upcoming week.
