Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBAFE2D15CF
	for <lists+bpf@lfdr.de>; Mon,  7 Dec 2020 17:19:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbgLGQQ7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Dec 2020 11:16:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:53502 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726141AbgLGQQ7 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 7 Dec 2020 11:16:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607357732;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XGOBTSRTM9+tAuCjeJvzx4ZaxY4e+O+c9GUP2xJoJgw=;
        b=D4mLbskKF8OHYdIYDjrFl+uaFrAUMYnWCZksa6UOXRFuWDzrns8oDobzQaBY1VqgQ9QF4O
        lM06qimDspc18q5n3JGjmAV5bvb8fgbzywFNRwAUECNIFiffJYsL+OuNhu++j1Zv6o7U1y
        vXEUojKZJDMuny+H0dzyAZQdHPwHp0s=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-6-2HPbCSXjM-69ITbhC6OBSQ-1; Mon, 07 Dec 2020 11:15:30 -0500
X-MC-Unique: 2HPbCSXjM-69ITbhC6OBSQ-1
Received: by mail-wm1-f71.google.com with SMTP id u123so4295741wmu.5
        for <bpf@vger.kernel.org>; Mon, 07 Dec 2020 08:15:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=XGOBTSRTM9+tAuCjeJvzx4ZaxY4e+O+c9GUP2xJoJgw=;
        b=X/ssEhnmmdf7ZIXOhJNqHV8Wob4D+WGSQdYxz9DRjCF0XchVETvZi4aCaXmc3B4EeD
         o3iokkRLOpVh+QwbNnm9MlKxsiGr5s58TdDMiAw9hAeWDYeuXPVnhVq4+r6tOEf7j+vA
         QleL+K795g2dPTKm6hrXRwoJOToYgQFCNj46JRly+lrmvQwyARVaZPHffyq5ABxwWM2A
         W+kqThKYyx0T7eg2iv+/ep8bHZAWYK4/EfQUNE6+Nmiy5LofFGR97/aZ17WhrgEgn43R
         0AbH6imgvybMYHhDiNzPNhvgC75Kej9CZf1kehDZq9UJw5L6fUVWtWqvlGapaDPcbya+
         kQpQ==
X-Gm-Message-State: AOAM531KmAvHhe4dNM3nTSmeCJ9wD/9f9FyTUX5l8Dv3or99HyXo7B6s
        HO7L3+T1MHMynXDtJn+Mp0f7SUAQWcMXwu9FJmU21cn01pmq6+q6YDY6oZXM9YS1aTIzeswwB+L
        n7m7G/iURWWPv
X-Received: by 2002:a5d:4586:: with SMTP id p6mr21186841wrq.308.1607357729066;
        Mon, 07 Dec 2020 08:15:29 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzfI4RZGHd6D/kw6tCcjmBDVCB5z3aDm5GYfb8Phhn8jgCzvJ4L7SXeLWXK5w2RDEsKyglQOQ==
X-Received: by 2002:a5d:4586:: with SMTP id p6mr21186820wrq.308.1607357728860;
        Mon, 07 Dec 2020 08:15:28 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id j13sm14774907wmi.36.2020.12.07.08.15.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 08:15:28 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id F38951843F5; Mon,  7 Dec 2020 17:15:26 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Yonghong Song <yhs@fb.com>, bpf <bpf@vger.kernel.org>
Subject: Re: Latest libbpf fails to load programs compiled with old LLVM
In-Reply-To: <CAADnVQ+qibC_8cDwaqOoAnL7CwXv85EjQ96Zcdtrm+86cgZq1g@mail.gmail.com>
References: <87lfeebwpu.fsf@toke.dk>
 <10679e62-50a2-4c01-31d2-cb79c01e4cbf@fb.com> <87r1o59aoc.fsf@toke.dk>
 <6801fcdb-932e-c185-22db-89987099b553@fb.com>
 <CAEf4BzZRu=sxEx7c8KGxSV1C6Aitrk01bSfabv5Bz+XUAMU6rg@mail.gmail.com>
 <875z5d7ufl.fsf@toke.dk>
 <CAADnVQ+qibC_8cDwaqOoAnL7CwXv85EjQ96Zcdtrm+86cgZq1g@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Mon, 07 Dec 2020 17:15:26 +0100
Message-ID: <878sa9619d.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:

> On Mon, Dec 7, 2020 at 3:03 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@red=
hat.com> wrote:
>>
>> Wait, what? This is a regression that *breaks people's programs* on
>> compiler versions that are still very much in the wild! I mean, fine if
>> you don't want to support new features on such files, but then surely we
>> can at least revert back to the old behaviour?
>
> Those folks that care about compiling with old llvm would have to stick
> to whatever loader they have instead of using libbpf.
> It's not a backward compatibility breakage.

What? It's a change in libbpf that breaks loading of existing BPF object
files that were working (with libbpf) before. If that's not a backward
compatibility break then that term has lost all meaning.

>> I used "prog" because that's what iproute2 looks for if you don't supply
>
> Please don't use iproute2 as a reason to do anything in libbpf. It won't =
fly.

Eh? Did you even read the email you're replying to? This issue has
nothing to do with iproute2, that was an unrelated thing Andrii asked me
to change when he was looking at my example...

-Toke

