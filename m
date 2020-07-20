Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A66352256B5
	for <lists+bpf@lfdr.de>; Mon, 20 Jul 2020 06:35:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725287AbgGTEfb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 20 Jul 2020 00:35:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbgGTEfb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 20 Jul 2020 00:35:31 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29862C0619D2
        for <bpf@vger.kernel.org>; Sun, 19 Jul 2020 21:35:31 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id el4so6806305qvb.13
        for <bpf@vger.kernel.org>; Sun, 19 Jul 2020 21:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fX3zLlOdZ1/utWoVkR1IaYF59LHrrF1ouWRdwhulaWE=;
        b=csT7p1pMvFnBvElWWK89U+D0+3FMPhlBAGiXKf5nPruJtnQVbv4DJYppEpdgJpIr4F
         xd9Wcr889KS0n0r6chl3HD3aXi9Rot5jCq4LJEDz+rNzZpvV83P0tv884DNLhYO4OvqU
         MzJTi0j3NsJ2tFdX0+OnsGQrxrAObeH9PNaabl2MFNE6eejpN08MYhHT1v1J7i1Oluyy
         OwD6KK8gxcRq17/HkwAYw1JmC++/v+QhjoFzChDGlBULSoLx6fo6HFrRmBFYYU0dJDPH
         qWQIBYKhRl8ws8dIpKPuPZuqF7LVm7Ei4e95cuTPBHnUr46eqfg7UjQ6VYyrWiFtD/0V
         80jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fX3zLlOdZ1/utWoVkR1IaYF59LHrrF1ouWRdwhulaWE=;
        b=B/1EPyPNRRJ8fKdWDm+NvC1aThSq8jtzF7ENATf9AyRWch8yuliDDrY1cqbVUU8GYp
         RCZhNri1O0h+xn3VbUNviMCUL58K40gojP+RqCIUBTcZ7h7SLf9JZ2VDYUuxZi7iM5rt
         Ve+HM7poTwiUa21ECGcaC00kiwzMtl5/JL00YK4YCxAqRSOJheJ3dBlc/LIpInL4Ks72
         WWrFFy1NhIYXk3JAtI79ywWhrRNCQiLr2KVekBXzfJ6Va32HDHXjI4dNDBQnBe5ed9Yc
         TUenAy3lmruni08iqTk8RG7/ZCcIfBoRclRAfnW+IDTJCm7hj5ja1fg399xdHt9Pjz9Y
         XbQQ==
X-Gm-Message-State: AOAM533eGusIHfmlJkJP808L4yQJY3QAq2NVneAKtIbDzALIShjjveD4
        uJxzrT/Kk+kzuw299rmuQF8prfM0jfuU1av3gDJ1HAJXOoU=
X-Google-Smtp-Source: ABdhPJznE32TzZ4vqI9DQfyOvxuxbafJlAVT2RrAk02MPZQCWZh6jiAEn39MLYrJWuQAN9G6Az2xysbcGOVtGbV0uPw=
X-Received: by 2002:a0c:9ae2:: with SMTP id k34mr19372336qvf.247.1595219730102;
 Sun, 19 Jul 2020 21:35:30 -0700 (PDT)
MIME-Version: 1.0
References: <AM5PR83MB02104FB714E7E29DD90D8E06FB7C0@AM5PR83MB0210.EURPRD83.prod.outlook.com>
In-Reply-To: <AM5PR83MB02104FB714E7E29DD90D8E06FB7C0@AM5PR83MB0210.EURPRD83.prod.outlook.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Sun, 19 Jul 2020 21:35:19 -0700
Message-ID: <CAEf4BzbE5+V8GJJwASgJJyCdX3P41GeoK14szprZq4i_OrQFOg@mail.gmail.com>
Subject: Re: Maximum size of record over perf ring buffer?
To:     Kevin Sheldrake <Kevin.Sheldrake@microsoft.com>
Cc:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jul 17, 2020 at 7:24 AM Kevin Sheldrake
<Kevin.Sheldrake@microsoft.com> wrote:
>
> Hello
>
> I'm building a tool using EBPF/libbpf/C and I've run into an issue that I=
'd like to ask about.  I haven't managed to find documentation for the maxi=
mum size of a record that can be sent over the perf ring buffer, but experi=
mentation (on kernel 5.3 (x64) with latest libbpf from github) suggests it =
is just short of 64KB.  Please could someone confirm if that's the case or =
not?  My experiments suggest that sending a record that is greater than 64K=
B results in the size reported in the callback being correct but the record=
s overlapping, causing corruption if they are not serviced as quickly as th=
ey arrive.  Setting the record to exactly 64KB results in no records being =
received at all.
>
> For reference, I'm using perf_buffer__new() and perf_buffer__poll() on th=
e userland side; and bpf_perf_event_output(ctx, &event_map, BPF_F_CURRENT_C=
PU, event, sizeof(event_s)) on the EBPF side.
>
> Additionally, is there a better architecture for sending large volumes of=
 data (>64KB) back from the EBPF program to userland, such as a different r=
ing buffer, a map, some kind of shared mmaped segment, etc, other than simp=
ly fragmenting the data?  Please excuse my naivety as I'm relatively new to=
 the world of EBPF.
>

I'm not aware of any such limitations for perf ring buffer and I
haven't had a chance to validate this. It would be great if you can
provide a small repro so that someone can take a deeper look, it does
sound like a bug, if you really get clobbered data. It might be
actually how you set up perfbuf, AFAIK, it has a mode where it will
override the data, if it's not consumed quickly enough, but you need
to consciously enable that mode.

But apart from that, shameless plug here, you can try the new BPF ring
buffer ([0]), available in 5.8+ kernels. It will allow you to avoid
extra copy of data you get with bpf_perf_event_output(), if you use
BPF ringbuf's bpf_ringbuf_reserve() + bpf_ringbuf_commit() API. It
also has bpf_ringbuf_output() API, which is logically  equivalent to
bpf_perf_event_output(). And it has a very high limit on sample size,
up to 512MB per sample.

Keep in mind, BPF ringbuf is MPSC design and if you use just one BPF
ringbuf across all CPUs, you might run into some contention across
multiple CPU. It is acceptable in a lot of applications I was
targeting, but if you have a high frequency of events (keep in mind,
throughput doesn't matter, only contention on sample reservation
matters), you might want to use an array of BPF ringbufs to scale
throughput. You can do 1 ringbuf per each CPU for ultimate performance
at the expense of memory usage (that's perf ring buffer setup), but
BPF ringbuf is flexible enough to allow any topology that makes sense
for you use case, from 1 shared ringbuf across all CPUs, to anything
in between.


  [0] https://patchwork.ozlabs.org/project/netdev/list/?series=3D180119&sta=
te=3D*

> Thank you in anticipation
>
> Kevin Sheldrake
>
