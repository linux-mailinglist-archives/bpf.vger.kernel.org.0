Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 957B22941E8
	for <lists+bpf@lfdr.de>; Tue, 20 Oct 2020 20:08:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387975AbgJTSI0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 20 Oct 2020 14:08:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28715 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387945AbgJTSI0 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 20 Oct 2020 14:08:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603217304;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ylwd13Ov01mxhZUrqRrb1cyJib4LmTp4McUSypk4XCc=;
        b=VJ0TQS+IH4xMgdQveaVRs0YOxzgqQApnTxWoOfq+5YzJFZM8NBwD+TM0zmpIuV0HBaUuml
        qNi1i8oAPhI5SNPFJck4aqWPf9C8f/iidG17AxFOi6QeG94T9BAZ3++V8nYvBZvoHdoJsM
        PFzD2ojhT8qAonbxEieakAFwB/ObZVE=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-105-0kxHZCbFM_qHWIZtQPsc0Q-1; Tue, 20 Oct 2020 14:08:22 -0400
X-MC-Unique: 0kxHZCbFM_qHWIZtQPsc0Q-1
Received: by mail-ed1-f70.google.com with SMTP id a73so916682edf.16
        for <bpf@vger.kernel.org>; Tue, 20 Oct 2020 11:08:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=Ylwd13Ov01mxhZUrqRrb1cyJib4LmTp4McUSypk4XCc=;
        b=UJmJL3JH6J0SyomHFWUr/I8sC4V0Rh1iF1/zbvbp9Re9qmYa0IUIqRIPFqX6fJwzhm
         aEkq+hEjVvYZdpqkPG+7nlesee7FHDgmtwI37kiYXjZhtkhD4Ym9cORwgqZQ0yN3tTMm
         Zf7Isith/Iot8td65EXSiwweyguK3KjKa2QXYwc68+5oTr0PXlsLTyGN3IlRzdCC4pWC
         Za+W+4LRKMbQR+ldntGaciKmVUcwy3F8JbzC27KmQ9QOXz2mj6klVLONf9L28gUy61CC
         lKqRkxBjhAwVtRCrGtUMQ+GmE2PUjEBs3gMdmQjTd8s4WNvFFU3+agHmxDjtYfL8ymf1
         4eWQ==
X-Gm-Message-State: AOAM533IDH++eeOmx0dDNxuQmHYEjaUUzKthpNLj6M0vp1QFIRIaEaRh
        dpnnjkV/XEBXKD97KEkSh+vPNL3C6DLjOkLygT1TzCQUTEPFz3E3jVgSN7jYX+ajusWwiKumraJ
        6aAGhtG5+5nsX
X-Received: by 2002:a05:6402:b0c:: with SMTP id bm12mr4090725edb.108.1603217300393;
        Tue, 20 Oct 2020 11:08:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwxt/YV0A5l1MfBGBIMlKh2H6ZQjvtnow2vOtzhLpMKD/Qh0Ky9srrl/ZHNYsU1pLH6RBLApA==
X-Received: by 2002:a05:6402:b0c:: with SMTP id bm12mr4090675edb.108.1603217299800;
        Tue, 20 Oct 2020 11:08:19 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id f23sm3487656ejd.5.2020.10.20.11.08.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2020 11:08:19 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id D6F5D1838FA; Tue, 20 Oct 2020 20:08:18 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: [PATCH bpf v2 1/3] bpf_redirect_neigh: Support supplying the
 nexthop as a helper parameter
In-Reply-To: <20201020093003.6e1c7fdb@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
References: <160319106111.15822.18417665895694986295.stgit@toke.dk>
 <160319106221.15822.2629789706666194966.stgit@toke.dk>
 <20201020093003.6e1c7fdb@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 20 Oct 2020 20:08:18 +0200
Message-ID: <87v9f422jx.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Jakub Kicinski <kuba@kernel.org> writes:

> On Tue, 20 Oct 2020 12:51:02 +0200 Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> diff --git a/include/linux/filter.h b/include/linux/filter.h
>> index 20fc24c9779a..ba9de7188cd0 100644
>> --- a/include/linux/filter.h
>> +++ b/include/linux/filter.h
>> @@ -607,12 +607,21 @@ struct bpf_skb_data_end {
>>  	void *data_end;
>>  };
>>=20=20
>> +struct bpf_nh_params {
>> +	u8 nh_family;
>> +	union {
>> +		__u32 ipv4_nh;
>> +		struct in6_addr ipv6_nh;
>> +	};
>> +};
>
>> @@ -4906,6 +4910,18 @@ struct bpf_fib_lookup {
>>  	__u8	dmac[6];     /* ETH_ALEN */
>>  };
>>=20=20
>> +struct bpf_redir_neigh {
>> +	/* network family for lookup (AF_INET, AF_INET6) */
>> +	__u8 nh_family;
>> +	 /* avoid hole in struct - must be set to 0 */
>> +	__u8 unused[3];
>> +	/* network address of nexthop; skips fib lookup to find gateway */
>> +	union {
>> +		__be32		ipv4_nh;
>> +		__u32		ipv6_nh[4];  /* in6_addr; network order */
>> +	};
>> +};
>
> Isn't this backward? The hole could be named in the internal structure.
> This is a bit of a gray area, but if you name this hole in uAPI and
> programs start referring to it you will never be able to reuse it.
> So you may as well not require it to be zeroed..

Hmm, yeah, suppose you're right. Doesn't the verifier prevent any part
of the memory from being unitialised anyway? I seem to recall having run
into verifier complaints when I didn't initialise struct on the stack...

-Toke

