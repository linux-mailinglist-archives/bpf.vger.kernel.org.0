Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CBAD2053BB
	for <lists+bpf@lfdr.de>; Tue, 23 Jun 2020 15:44:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732658AbgFWNor (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Jun 2020 09:44:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729504AbgFWNor (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 23 Jun 2020 09:44:47 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2701EC061573
        for <bpf@vger.kernel.org>; Tue, 23 Jun 2020 06:44:47 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id n123so10895735ybf.11
        for <bpf@vger.kernel.org>; Tue, 23 Jun 2020 06:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=CoJGFVma3x58KlvJ7kmP7Y3F+vMlVbG6Is36lPddlZY=;
        b=EVsSVDYnj9csneMo0OHHWbVOw+wbvPo0t+DaZHuR53juLmeXsVKkIjhiE57jTFijj/
         5WpKxnW1CszPSZWBYaC8oyf/VFR0PKCG8uV+jZnlLFnEYVN8pzCnp9AFd0ke8WwuNCAN
         zt2VeVTUQaSGcYnC12SZhvMbe8W0EQBnEOjGXnpTiAmyGrWcONeKOBraxMkY4Pd9LNpk
         cKYKqEHIus9rnChd9Ns89KPtEbilbSnjWhnfmpt+GjRz4tgeVZ6Gezb1qwyKPLbrQgPQ
         TJPvAAH2cQ1LCBAfXUHHyMjwDd/LgkTfR/WigSyRtjUHSzhNgoE4f412C61d5rO3w0fy
         FNkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=CoJGFVma3x58KlvJ7kmP7Y3F+vMlVbG6Is36lPddlZY=;
        b=ci1GrfdZv6Lsv+S8wMJq/vkElV2WTKuQzi6jG5bragI6LUdQv0TN1VfjB/2FI8u8J0
         odLuzkSjoaaayD7K1veegIb0678BNrs2SNA8A95gFGY2AnjG5u50DkAZ4+BJDjGRZhKm
         p0/SV7YRU1c/HkbsGshWKN+Jl85iHmJNJsCgYBsUm8r/OrUud9o/qvRK1CF/voZYKtBb
         ZUxwyx7ukaiGCctj0qf9T0EmXFhlGyjBAvJytwOS5smsXlxz2Qhs98APlCNvYZPvclY0
         4n3eM3OWeoB8at/eABk0eLvpeuoqtBrpdwaPxb/7Wc+61mgmlRyLLjaXH53TaszdyIly
         47gg==
X-Gm-Message-State: AOAM533iAw40cM02G1aXSJYJTFy8YPtXZ+QwEE61ENpMJ+ceGy1ALz/K
        29Ue2QqG2O7F97h9Vx1RX3RZahlKa3QJ1ExYfgo=
X-Google-Smtp-Source: ABdhPJzy430G5CK7lOYqRIc3J6Ssox9cn8ygxeT5/o14AaaJptPz0NHL4u87KOn0roejP6HahrIEFadRYEhHQcmq6u8=
X-Received: by 2002:a25:c052:: with SMTP id c79mr36522837ybf.23.1592919885528;
 Tue, 23 Jun 2020 06:44:45 -0700 (PDT)
MIME-Version: 1.0
References: <CAHhV9ES1aUO-Zfpz6uCnFhY3Rgi3ZS1pn4ztz2iXYFO-KX75BQ@mail.gmail.com>
 <CAHhV9EShCxg=W2Yhsehx6KQGYPQ9KjF7jmteoxiNO-8ma-WmLw@mail.gmail.com> <CAGn_itxdtnNTukVGdb94Qg==RU7_F=8jabgSDd8kzH-73Gg28Q@mail.gmail.com>
In-Reply-To: <CAGn_itxdtnNTukVGdb94Qg==RU7_F=8jabgSDd8kzH-73Gg28Q@mail.gmail.com>
From:   Abhishek Vijeev <abhishek.vijeev@gmail.com>
Date:   Tue, 23 Jun 2020 19:14:34 +0530
Message-ID: <CAHhV9EQLNjzV3cExpbVUsOi57q7t-S8bT_rAeBMx9OBi6J66MA@mail.gmail.com>
Subject: Re: Checkpoint/Restore of BPF Map Data
To:     Anton Protopopov <aspsk2@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, criu@openvz.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This is great, thank you Anton. Will check it out!

On Mon, Jun 22, 2020 at 10:45 PM Anton Protopopov <aspsk2@gmail.com> wrote:
>
> =D0=BF=D0=BD, 22 =D0=B8=D1=8E=D0=BD. 2020 =D0=B3. =D0=B2 13:01, Abhishek =
Vijeev <abhishek.vijeev@gmail.com>:
> >
> > + CRIU Mailing List
> >
> >
> > On Mon, Jun 22, 2020 at 10:29 PM Abhishek Vijeev
> > <abhishek.vijeev@gmail.com> wrote:
> > >
> > > Hi,
> > >
> > > I've been working with the CRIU project to enable CRIU to checkpoint
> > > and restore BPF map files.
> > > (https://github.com/checkpoint-restore/criu/issues/777).
> > >
> > > A key component of the solution involves dumping the data contained i=
n
> > > BPF maps. However, I have
> > > been unable to do this due to the following reason - as far as I'm
> > > aware, Linux does not provide an
> > > interface to directly retrieve the key-value pairs stored in a BPF ma=
p
> > > without prior knowledge about
> > > the nature of data stored in it.
>
> Try BPF_MAP_LOOKUP_BATCH, here is an example:
> https://github.com/iovisor/bcc/blob/master/libbpf-tools/syscount.c#L193
> (the bpf_map_lookup_and_delete_batch is used there, but
> bpf_map_lookup_batch case should be the same).
