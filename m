Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B8B245AC24
	for <lists+bpf@lfdr.de>; Tue, 23 Nov 2021 20:19:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231732AbhKWTWt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Nov 2021 14:22:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:40410 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230013AbhKWTWt (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 23 Nov 2021 14:22:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637695180;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fRWw95yT9E8RGRz40/eIKroZXQE8VY8xUKSwwZaJPd8=;
        b=F0942FC0XNNRGOdCZ8JwLfnv/z1Ie5WmYbMk0PXk2IFopVNVBYDC2mwmiYpvjc+9FeE5Wj
        /W4BKDKD36fvMIFuOqLLOdxowcMIHLj980dAG4VxelZUsD1ezaQB5jDeiH6QmXfr4N6vK6
        TcgZH9AS/JNfDE8iw7BOZumWU7il44c=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-433-RnjB4LS_OIaetcNW-sJ7FA-1; Tue, 23 Nov 2021 14:19:38 -0500
X-MC-Unique: RnjB4LS_OIaetcNW-sJ7FA-1
Received: by mail-ed1-f71.google.com with SMTP id d13-20020a056402516d00b003e7e67a8f93so18738738ede.0
        for <bpf@vger.kernel.org>; Tue, 23 Nov 2021 11:19:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=fRWw95yT9E8RGRz40/eIKroZXQE8VY8xUKSwwZaJPd8=;
        b=29iJbsFeCHNcA/OBUfoohoJBC50vkXceBSwKK6zVoWJ2QT7UESOs298XEC4U3PARsH
         F8W9QQvQJkMHhewrb8yhU6YxCLlg7qaFP+IMLjYoPE33k+arytG1UI8D1a7NwjUaIUJy
         jh3e++fU71ARg1eMh962Xiwh0HhIou1IHTAzAx8nbpu6aonWw9Mp9IEsrsgtLzP7LnqW
         1J6KkVOpgrQA1jFcTtjLLk1Tqr6PAQHa4wkJQ2ACPy/IaN53HT1xXd8wmlkRJYuGKSkT
         fKovRK4tp3C1M+B6lw15gMHg3GCNJh0ngZbyPSFntmZNCDugAypQ0Cso3kkQ+bSUqPPk
         2JFg==
X-Gm-Message-State: AOAM532xMiwbAbzA5NbQJ5sOD6hkXnkpdi8EjKIx9HT5LF3/+Rxv/XFF
        3lIHwbcbn4LZunhHnkm9DPl0ZUDd8VqNw9ibh+ilFNKmleJ1HwVtrjJ6Tpj9rT7B5oddt0cGIB7
        x9HtqQBJKYCYQ
X-Received: by 2002:a05:6402:440f:: with SMTP id y15mr13480610eda.22.1637695177428;
        Tue, 23 Nov 2021 11:19:37 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwq2WjQiNoQYLltHJnqrKHBiKbqJxKQpj4d302LJE/lfP3J+9q/D3WyTt/g+XnF4mZvoRwlYg==
X-Received: by 2002:a05:6402:440f:: with SMTP id y15mr13480545eda.22.1637695177097;
        Tue, 23 Nov 2021 11:19:37 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id s12sm6229413edc.48.2021.11.23.11.19.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Nov 2021 11:19:36 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id C5C8D18029C; Tue, 23 Nov 2021 20:19:34 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Joanne Koong <joannekoong@fb.com>, bpf@vger.kernel.org
Cc:     andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        Kernel-team@fb.com, Joanne Koong <joannekoong@fb.com>
Subject: Re: [PATCH v2 bpf-next 4/4] selftest/bpf/benchs: add bpf_loop
 benchmark
In-Reply-To: <20211123183409.3599979-5-joannekoong@fb.com>
References: <20211123183409.3599979-1-joannekoong@fb.com>
 <20211123183409.3599979-5-joannekoong@fb.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 23 Nov 2021 20:19:34 +0100
Message-ID: <87y25ebry1.fsf@toke.dk>
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
> Testing this on qemu on my dev machine on 1 thread, the data is
> as follows:
>
>         nr_loops: 1
> bpf_loop - throughput: 43.350 =C2=B1 0.864 M ops/s, latency: 23.068 ns/op
>
>         nr_loops: 10
> bpf_loop - throughput: 69.586 =C2=B1 1.722 M ops/s, latency: 14.371 ns/op
>
>         nr_loops: 100
> bpf_loop - throughput: 72.046 =C2=B1 1.352 M ops/s, latency: 13.880 ns/op
>
>         nr_loops: 500
> bpf_loop - throughput: 71.677 =C2=B1 1.316 M ops/s, latency: 13.951 ns/op
>
>         nr_loops: 1000
> bpf_loop - throughput: 69.435 =C2=B1 1.219 M ops/s, latency: 14.402 ns/op
>
>         nr_loops: 5000
> bpf_loop - throughput: 72.624 =C2=B1 1.162 M ops/s, latency: 13.770 ns/op
>
>         nr_loops: 10000
> bpf_loop - throughput: 75.417 =C2=B1 1.446 M ops/s, latency: 13.260 ns/op
>
>         nr_loops: 50000
> bpf_loop - throughput: 77.400 =C2=B1 2.214 M ops/s, latency: 12.920 ns/op
>
>         nr_loops: 100000
> bpf_loop - throughput: 78.636 =C2=B1 2.107 M ops/s, latency: 12.717 ns/op
>
>         nr_loops: 500000
> bpf_loop - throughput: 76.909 =C2=B1 2.035 M ops/s, latency: 13.002 ns/op
>
>         nr_loops: 1000000
> bpf_loop - throughput: 77.636 =C2=B1 1.748 M ops/s, latency: 12.881 ns/op
>
> From this data, we can see that the latency per loop decreases as the
> number of loops increases. On this particular machine, each loop had an
> overhead of about ~13 ns, and we were able to run ~70 million loops
> per second.

The latency figures are great, thanks! I assume these numbers are with
retpolines enabled? Otherwise 12ns seems a bit much... Or is this
because of qemu?

-Toke

