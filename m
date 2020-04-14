Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FC831A782B
	for <lists+bpf@lfdr.de>; Tue, 14 Apr 2020 12:11:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438181AbgDNKLo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Apr 2020 06:11:44 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:45708 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2438173AbgDNKLl (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 14 Apr 2020 06:11:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586859100;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=D19atvj1EDDaX34zHqvHJsCmVyR2GBDOTXVYJehpBEo=;
        b=alqpfRmNAFWpAmK8PY/vr3kOsoSPZkj0CysNsnOxhFkBQi2k9xjuDjJtiBXDaR+Vbvjilc
        EKzFElUahAnd7LF1D+0AtbyORNYvAQ7r0RrSGC89Sc+w+6+sXnrjTmHwLhcormH5nVP5Qq
        zGLRkqFRlwnIUnp5Q7GRcqY7iWdDi6Q=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-167-vWD9UY1EP2eDYVzf43EnKw-1; Tue, 14 Apr 2020 06:11:38 -0400
X-MC-Unique: vWD9UY1EP2eDYVzf43EnKw-1
Received: by mail-lj1-f199.google.com with SMTP id x12so2108268ljj.16
        for <bpf@vger.kernel.org>; Tue, 14 Apr 2020 03:11:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=D19atvj1EDDaX34zHqvHJsCmVyR2GBDOTXVYJehpBEo=;
        b=BNCdj/xNV/tuRocYCZK7tWXU2mGnxXbTrUa+4GO6NbtviqCkNgfRcOfya/II04dyye
         hz57MpMcFbTt6fUq9pIPviLozkPIspqjZU1iKAsl5m2hBHrFPrM632u80yv4BLc6fK3b
         a464mCYcypmc+tguQtt7cCYro+WyWl3qQ5sR7Q1yQpfQe0gtY/sYzwbCTI5ZRELeW18L
         WNqqxVs9tXMJgw/zPftE1z5hRH8BwBKvQfhC47jW7+5ePFN34CtVzetO1tHSWQoLeJ4Q
         TDwRKURouG83HyPtbuIFukSSGPAbHyjalu+ww/XpA4Evz+LU4Mw/QKsAebVn0mS5aWOo
         ioRw==
X-Gm-Message-State: AGi0PuZp+ZPdmUEn+SG/is1Y1Kh0U0Re0Eoi7EcyNqj4ygKP7yUYkzjo
        NV4HaE6bvf5X7UcCIVt3zTNWVaZmv0kEo7rgRSj0rAu5+qh5Ay4oa0qAU0ZTSXcZqIn9EoZ+xuT
        tIOmXCKK0ewhz
X-Received: by 2002:ac2:528f:: with SMTP id q15mr4889340lfm.132.1586859096637;
        Tue, 14 Apr 2020 03:11:36 -0700 (PDT)
X-Google-Smtp-Source: APiQypISwM5fXffbYEAXsfiMzCS5vQv7dNXolVgJwryaOwSZ+r86BacwyJKvMR5hfnTSGx/FFYKt8A==
X-Received: by 2002:ac2:528f:: with SMTP id q15mr4889309lfm.132.1586859096344;
        Tue, 14 Apr 2020 03:11:36 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id p23sm9931615lfc.95.2020.04.14.03.11.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 03:11:35 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id CBD0A181586; Tue, 14 Apr 2020 12:11:33 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Jesper Dangaard Brouer <brouer@redhat.com>, sameehj@amazon.com
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org, zorik@amazon.com,
        akiyano@amazon.com, gtzalik@amazon.com,
        Daniel Borkmann <borkmann@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        David Ahern <dsahern@gmail.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Saeed Mahameed <saeedm@mellanox.com>, brouer@redhat.com
Subject: Re: [PATCH RFC v2 29/33] xdp: allow bpf_xdp_adjust_tail() to grow packet size
In-Reply-To: <20200414115656.2f0e6ac0@carbon>
References: <158634658714.707275.7903484085370879864.stgit@firesoul> <158634678170.707275.10720666808605360076.stgit@firesoul> <20200414115656.2f0e6ac0@carbon>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 14 Apr 2020 12:11:33 +0200
Message-ID: <87v9m2nzqi.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Jesper Dangaard Brouer <brouer@redhat.com> writes:

> On Wed, 08 Apr 2020 13:53:01 +0200 Jesper Dangaard Brouer <brouer@redhat.com> wrote:
>
>> diff --git a/net/core/filter.c b/net/core/filter.c
>> index 7628b947dbc3..4d58a147eed0 100644
>> --- a/net/core/filter.c
>> +++ b/net/core/filter.c
>> @@ -3422,12 +3422,26 @@ static const struct bpf_func_proto bpf_xdp_adjust_head_proto = {
>>  
>>  BPF_CALL_2(bpf_xdp_adjust_tail, struct xdp_buff *, xdp, int, offset)
>>  {
>> +	void *data_hard_end = xdp_data_hard_end(xdp);
>>  	void *data_end = xdp->data_end + offset;
>>  
> [...]
>> +	/* DANGER: ALL drivers MUST be converted to init xdp->frame_sz
>> +	 * - Adding some chicken checks below
>> +	 * - Will (likely) not be for upstream
>> +	 */
>> +	if (unlikely(xdp->frame_sz < (xdp->data_end - xdp->data_hard_start))) {
>> +		WARN(1, "Too small xdp->frame_sz = %d\n", xdp->frame_sz);
>> +		return -EINVAL;
>> +	}
>> +	if (unlikely(xdp->frame_sz > PAGE_SIZE)) {
>> +		WARN(1, "Too BIG xdp->frame_sz = %d\n", xdp->frame_sz);
>> +		return -EINVAL;
>> +	}
>
> Any opinions on above checks?
> Should they be removed or kept?
>
> The idea is to catch drivers that forgot to update xdp_buff->frame_sz,
> by doing some sanity checks on this uninit value.  If I correctly
> updated all XDP drivers in this patchset, then these checks should be
> unnecessary, but will this be valuable for driver developers converting
> new drivers to XDP to have these WARN checks?

Hmm, I wonder if there's a way we could have these kinds of checks
available, but disabled by default? A new macro (e.g.,
XDP_CHECK(condition)) that is only enabled when some debug option is
enabled in the kernel build, perhaps? Or just straight ifdef'ing them
out, but maybe a macro would be generally useful?

-Toke

