Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B76AE463C50
	for <lists+bpf@lfdr.de>; Tue, 30 Nov 2021 17:54:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242515AbhK3Q5Y (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 30 Nov 2021 11:57:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:37481 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238952AbhK3Q5X (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 30 Nov 2021 11:57:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638291243;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ocy2sJNUXeifLL+bp5ixV8nOfxIcyJ07BwCL7C1Ip3I=;
        b=JRGQS9nslNWAUyRO38u4VFFsfDsm8PAwwuXKlhd4b9SM4QW399MtEUVw89P7GZBKaadwSp
        H5k7XDtogzMp5RjNqdteqVONPQ/yDrz+8A3ZaUmGRLlMROp0SQNR1qQAGClpp2P/Y6zuop
        e0AYJTMr2x2WmJkCqWWr65a+Zgke/2c=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-148-itKLq9NHNuKCsfSvie4aug-1; Tue, 30 Nov 2021 11:54:02 -0500
X-MC-Unique: itKLq9NHNuKCsfSvie4aug-1
Received: by mail-ed1-f70.google.com with SMTP id m12-20020a056402430c00b003e9f10bbb7dso17473727edc.18
        for <bpf@vger.kernel.org>; Tue, 30 Nov 2021 08:54:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=ocy2sJNUXeifLL+bp5ixV8nOfxIcyJ07BwCL7C1Ip3I=;
        b=fK1LSm9Ceb+oCQac4QggCHG9FyToKjgHn7k1ynuowJLX/k56DCLRzSWRiehWI3B7l/
         +ACUkH4wHof3T4F0cHRUVA8EURSQOw/C+dZKpyj3+dsTHguTGLmtWTVT58oHQQsjC36/
         /lwU9U0phBfV89c7GtWJ19nYBzC8f2y/5umOdIs5Zr1MT1b64vL5pMjMhRv0SgElBJ1w
         wIA08OdXsuPcu58GdkLzHn8sNBqCXzoDHv+5lN/Ssc9WWrMXhx4KOU6uRulmsJEUt0iL
         PAjSRztokPj5j351WqXzfnaRQeBU7xZFBj9UxcUj9w2rWAUqWs7ty33hTknVksy8ru85
         32ew==
X-Gm-Message-State: AOAM532wLh4Gdb2Lm5ZM7Z1/wd3ULgHrOGT0wIgCM61SCf22SruLhW50
        Sw2NgD4NkLKvGwUwdElG3nqFT5iM5uAsTH+LxZhEtmCPw+W5V2agyq0LylMZk5/r39UqVhAvWhT
        awXiY8mWRyPH1
X-Received: by 2002:a17:907:629b:: with SMTP id nd27mr356517ejc.24.1638291240282;
        Tue, 30 Nov 2021 08:54:00 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx6F06O02wh6RN0hZFoTu8vnXqv50HabcEGhmSrMosZXOdJItecz/270Yq8DUdV0QOe52UkfA==
X-Received: by 2002:a17:907:629b:: with SMTP id nd27mr356435ejc.24.1638291239486;
        Tue, 30 Nov 2021 08:53:59 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id oz31sm9364349ejc.35.2021.11.30.08.53.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 08:53:58 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 09D1D1802A0; Tue, 30 Nov 2021 17:53:58 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Joanne Koong <joannekoong@fb.com>, bpf@vger.kernel.org
Cc:     andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        Kernel-team@fb.com, Joanne Koong <joannekoong@fb.com>
Subject: Re: [PATCH v3 bpf-next 4/4] selftest/bpf/benchs: add bpf_loop
 benchmark
In-Reply-To: <20211129223725.2770730-5-joannekoong@fb.com>
References: <20211129223725.2770730-1-joannekoong@fb.com>
 <20211129223725.2770730-5-joannekoong@fb.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 30 Nov 2021 17:53:58 +0100
Message-ID: <87wnkp7ffd.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Joanne Koong <joannekoong@fb.com> writes:

> Add benchmark to measure the throughput and latency of the bpf_loop
> call.
>
> Testing this on my dev machine on 1 thread, the data is as follows:
>
>         nr_loops: 10
> bpf_loop - throughput: 198.519 =C2=B1 0.155 M ops/s, latency: 5.037 ns/op
>
>         nr_loops: 100
> bpf_loop - throughput: 247.448 =C2=B1 0.305 M ops/s, latency: 4.041 ns/op
>
>         nr_loops: 500
> bpf_loop - throughput: 260.839 =C2=B1 0.380 M ops/s, latency: 3.834 ns/op
>
>         nr_loops: 1000
> bpf_loop - throughput: 262.806 =C2=B1 0.629 M ops/s, latency: 3.805 ns/op
>
>         nr_loops: 5000
> bpf_loop - throughput: 264.211 =C2=B1 1.508 M ops/s, latency: 3.785 ns/op
>
>         nr_loops: 10000
> bpf_loop - throughput: 265.366 =C2=B1 3.054 M ops/s, latency: 3.768 ns/op
>
>         nr_loops: 50000
> bpf_loop - throughput: 235.986 =C2=B1 20.205 M ops/s, latency: 4.238 ns/op
>
>         nr_loops: 100000
> bpf_loop - throughput: 264.482 =C2=B1 0.279 M ops/s, latency: 3.781 ns/op
>
>         nr_loops: 500000
> bpf_loop - throughput: 309.773 =C2=B1 87.713 M ops/s, latency: 3.228 ns/op
>
>         nr_loops: 1000000
> bpf_loop - throughput: 262.818 =C2=B1 4.143 M ops/s, latency: 3.805 ns/op
>
> From this data, we can see that the latency per loop decreases as the
> number of loops increases. On this particular machine, each loop had an
> overhead of about ~4 ns, and we were able to run ~250 million loops
> per second.
>
> Signed-off-by: Joanne Koong <joannekoong@fb.com>

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

