Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D76C422B661
	for <lists+bpf@lfdr.de>; Thu, 23 Jul 2020 21:05:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726455AbgGWTFU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Jul 2020 15:05:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726349AbgGWTFT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Jul 2020 15:05:19 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F797C0619DC
        for <bpf@vger.kernel.org>; Thu, 23 Jul 2020 12:05:19 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id h7so6417037qkk.7
        for <bpf@vger.kernel.org>; Thu, 23 Jul 2020 12:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=znZdkyYvvbhRdiGon4U6rDby35vjOeXyBe67/EvHRso=;
        b=Q5oz7d7xRdBKd7cZrsriwZHpdBNc0LFaJdzbbqMRq0ZCkw0OtaxROm/i5FRj79NPtY
         jxIvIbxafOaaDWHsCkcjwZKJy8TBqI8bhSgK8DAzg82Zy+9to9g98ULhGulQkowenXRy
         mkM/Uoao/UFk/qocHn3Bk5j2VHoq1cJGPfp33bNfQ0PxPQuxNyrbRkG6YY9tqH1VfqSC
         hLVB9k7zRk7WPUxfmJPHR2/ud3cfRsHSiPWPkv7zGB4xSUTAh/ldkE5XhMZQLBNGO429
         lFkJrI+cjoOnbF7kKkU4aGDnIZXFt7Sr0TuWz9j1sBREGSPwbvpxBj14QD5rvr2qWyBT
         YHvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=znZdkyYvvbhRdiGon4U6rDby35vjOeXyBe67/EvHRso=;
        b=Zb2BmBo6GbsFlNZx5gZ/Q88N0r5JgALqrA3KymTfAx5rTm2CchJxzrP+9Tx62ZSK9G
         p8B9wkm9+rS59jCHybEEI3+99t5uUfwW+j0H1+jiygTKeAsJwLb8RV7RWROi0QtC2KIa
         v2KLtRGJ7Jh4EznbcUfOKfhEzvrQU6pMvnxEInCjYe760oGpvJVcPUD5Vxv3mP/ktRUZ
         5KqYeQ8/6A0jhrC3olIqh6R9OXZS/LYf79HsiTGDTvKJ4cYCmz14a9SsS/tJZquaz63J
         d4xT3jQYx4OURAgnX6gikhAA0sI6eb5t3mFhR067daE7QUSRdoopmUPDXcaR41MSA+nC
         CpDg==
X-Gm-Message-State: AOAM531CpGCp0Pl86bmgFo5VFzmFzk6JzzxmbsoeY9bRyDu2wKshHxHP
        zBF5sLsesqEysLmHeftg6qd/nHD+1gkFROIPOz6ZMkd3
X-Google-Smtp-Source: ABdhPJywlFSty0EgF4TPRdeWdCHXfROps2ZQkWOyG+90CS1Wo/FCZXOL078xlRcmqc1dlvSQPssb+hlkqF8Q773Lygs=
X-Received: by 2002:a37:7683:: with SMTP id r125mr6813791qkc.39.1595531118651;
 Thu, 23 Jul 2020 12:05:18 -0700 (PDT)
MIME-Version: 1.0
References: <AM5PR83MB02104FB714E7E29DD90D8E06FB7C0@AM5PR83MB0210.EURPRD83.prod.outlook.com>
 <CAEf4BzbE5+V8GJJwASgJJyCdX3P41GeoK14szprZq4i_OrQFOg@mail.gmail.com> <HE1PR83MB0220F45891B3B413F6634662FB7B0@HE1PR83MB0220.EURPRD83.prod.outlook.com>
In-Reply-To: <HE1PR83MB0220F45891B3B413F6634662FB7B0@HE1PR83MB0220.EURPRD83.prod.outlook.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 23 Jul 2020 12:05:07 -0700
Message-ID: <CAEf4BzZj8z5YWHQkYBjBuQ2LUwvodt7tz_9=GZzZ6hcW3zkj5g@mail.gmail.com>
Subject: Re: [EXTERNAL] Re: Maximum size of record over perf ring buffer?
To:     Kevin Sheldrake <Kevin.Sheldrake@microsoft.com>
Cc:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jul 20, 2020 at 4:39 AM Kevin Sheldrake
<Kevin.Sheldrake@microsoft.com> wrote:
>
> Hello
>
> Thank you for your response; I hope you don't mind me top-posting.  I've =
put together a POC that demonstrates my results.  Edit the size of the data=
 char array in event_defs.h to change the behaviour.
>
> https://github.com/microsoft/OMS-Auditd-Plugin/tree/MSTIC-Research/ebpf_p=
erf_output_poc

I haven't run your program, but I can certainly reproduce this using
bench_perfbuf in selftests. It does seem like something is silently
corrupted, because the size reported by perf is correct (plus/minus
few bytes, probably rounding up to 8 bytes), but the contents is not
correct. I have no idea why that's happening, maybe someone more
familiar with the perf subsystem can take a look.

>
> Unfortunately, our project aims to run on older kernels than 5.8 so the b=
pf ring buffer won't work for us.
>
> Thanks again
>
> Kevin Sheldrake
>
>
> -----Original Message-----
> From: bpf-owner@vger.kernel.org <bpf-owner@vger.kernel.org> On Behalf Of =
Andrii Nakryiko
> Sent: 20 July 2020 05:35
> To: Kevin Sheldrake <Kevin.Sheldrake@microsoft.com>
> Cc: bpf@vger.kernel.org
> Subject: [EXTERNAL] Re: Maximum size of record over perf ring buffer?
>
> On Fri, Jul 17, 2020 at 7:24 AM Kevin Sheldrake <Kevin.Sheldrake@microsof=
t.com> wrote:
> >
> > Hello
> >
> > I'm building a tool using EBPF/libbpf/C and I've run into an issue that=
 I'd like to ask about.  I haven't managed to find documentation for the ma=
ximum size of a record that can be sent over the perf ring buffer, but expe=
rimentation (on kernel 5.3 (x64) with latest libbpf from github) suggests i=
t is just short of 64KB.  Please could someone confirm if that's the case o=
r not?  My experiments suggest that sending a record that is greater than 6=
4KB results in the size reported in the callback being correct but the reco=
rds overlapping, causing corruption if they are not serviced as quickly as =
they arrive.  Setting the record to exactly 64KB results in no records bein=
g received at all.
> >
> > For reference, I'm using perf_buffer__new() and perf_buffer__poll() on =
the userland side; and bpf_perf_event_output(ctx, &event_map, BPF_F_CURRENT=
_CPU, event, sizeof(event_s)) on the EBPF side.
> >
> > Additionally, is there a better architecture for sending large volumes =
of data (>64KB) back from the EBPF program to userland, such as a different=
 ring buffer, a map, some kind of shared mmaped segment, etc, other than si=
mply fragmenting the data?  Please excuse my naivety as I'm relatively new =
to the world of EBPF.
> >
>
> I'm not aware of any such limitations for perf ring buffer and I haven't =
had a chance to validate this. It would be great if you can provide a small=
 repro so that someone can take a deeper look, it does sound like a bug, if=
 you really get clobbered data. It might be actually how you set up perfbuf=
, AFAIK, it has a mode where it will override the data, if it's not consume=
d quickly enough, but you need to consciously enable that mode.
>
> But apart from that, shameless plug here, you can try the new BPF ring bu=
ffer ([0]), available in 5.8+ kernels. It will allow you to avoid extra cop=
y of data you get with bpf_perf_event_output(), if you use BPF ringbuf's bp=
f_ringbuf_reserve() + bpf_ringbuf_commit() API. It also has bpf_ringbuf_out=
put() API, which is logically  equivalent to bpf_perf_event_output(). And i=
t has a very high limit on sample size, up to 512MB per sample.
>
> Keep in mind, BPF ringbuf is MPSC design and if you use just one BPF ring=
buf across all CPUs, you might run into some contention across multiple CPU=
. It is acceptable in a lot of applications I was targeting, but if you hav=
e a high frequency of events (keep in mind, throughput doesn't matter, only=
 contention on sample reservation matters), you might want to use an array =
of BPF ringbufs to scale throughput. You can do 1 ringbuf per each CPU for =
ultimate performance at the expense of memory usage (that's perf ring buffe=
r setup), but BPF ringbuf is flexible enough to allow any topology that mak=
es sense for you use case, from 1 shared ringbuf across all CPUs, to anythi=
ng in between.
>
>
