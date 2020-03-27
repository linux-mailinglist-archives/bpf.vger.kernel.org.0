Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E837195DC4
	for <lists+bpf@lfdr.de>; Fri, 27 Mar 2020 19:39:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727242AbgC0Sj4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 27 Mar 2020 14:39:56 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:27137 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726515AbgC0Sjz (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 27 Mar 2020 14:39:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585334394;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HFEM/Ur1BY9SGW8JH4b5ko6dsHwkpfgs391rte+SmAA=;
        b=KrrKFkI/nRTlg3f3ChQd2yaLpa8XLJZa7x13YfaQrtWha5KXZczIR5Bni2rUljkMDuRs6w
        ONCFl80Jy4Gy01lnaMryWfJ0FGjdAN1fqb8G2R/k52gmba2OQHN4y8DPA2Gdn5TxWUb54H
        tF802vWvUVYQRi1KgZQCYH1WsK9v8o4=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-25-JUgYbVqrOVugNIqV8jLbYA-1; Fri, 27 Mar 2020 14:39:50 -0400
X-MC-Unique: JUgYbVqrOVugNIqV8jLbYA-1
Received: by mail-lf1-f71.google.com with SMTP id c20so4100154lfh.6
        for <bpf@vger.kernel.org>; Fri, 27 Mar 2020 11:39:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=HFEM/Ur1BY9SGW8JH4b5ko6dsHwkpfgs391rte+SmAA=;
        b=t+PTTKruLFJBFEfOHJbsmjrqD/Whh6SdURqEYG8B3VfRxLv96wuA0UAdCwjgBjUSrV
         A4AxrUSCaKwWIdqJoqdAT3dsJCg/L5lCraa94hcjNoqWHqJAuy+ZcSbZ8sUORVAv4MJE
         mNQXv3Te66W/2u87KzERxijke7bxvLAApqqOFypowwWv+Nce+Tm1TvK24v4sy+EmrwOG
         7tHKM59VJwcTvTunXsVeN3j+tSQBatUBx6vquvqq38YmCE5Qx+2A2p7YA+vr5QgBLu+R
         /0VRFs1sUDhqgafM8nHs13tn+Oy7CdhdfAAu29EFT2nurdI63Jx6TpzdK+u+csyfSTS+
         bBTA==
X-Gm-Message-State: AGi0PubRN77JRvvRXQuj5DE3Ng0P28AlLOxOAFt5PkMvY28Xi3R4t7BD
        YDzO+urao8qZFYKZeNjPgExlga+3O93wsvFvxoRT80XH65Vj2sPf6p4dcikyzZtxtPouSBcBvdn
        vsR84t+SsiM10
X-Received: by 2002:a2e:6809:: with SMTP id c9mr168333lja.251.1585334389035;
        Fri, 27 Mar 2020 11:39:49 -0700 (PDT)
X-Google-Smtp-Source: APiQypIGN4t1K2af+flvIdNNSoGetcHpo2Y3VoXH4b6orMnOAIw1EbziJ9MeAiWGIlvDpbyB23n7Gg==
X-Received: by 2002:a2e:6809:: with SMTP id c9mr168324lja.251.1585334388815;
        Fri, 27 Mar 2020 11:39:48 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id v12sm3056895ljh.6.2020.03.27.11.39.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2020 11:39:47 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id D2FC418158B; Fri, 27 Mar 2020 19:39:44 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@fb.com>, bpf <bpf@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>
Subject: Re: [PATCH bpf-next] libbpf: Add bpf_object__rodata getter function
In-Reply-To: <CAEf4BzbRpJsoXb3Bvx0_jKGj4gLk-dhXRqryfO23qMreG2B+Kg@mail.gmail.com>
References: <20200326151741.125427-1-toke@redhat.com> <CAEf4BzYxJjJygu_ZqJJB03n=ZetxhuUE7eLD9dsbkbvzQ5M08w@mail.gmail.com> <87eetem1dm.fsf@toke.dk> <CAEf4BzbRpJsoXb3Bvx0_jKGj4gLk-dhXRqryfO23qMreG2B+Kg@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 27 Mar 2020 19:39:44 +0100
Message-ID: <875zepmykv.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:

>> > But basically, why can't you use BPF skeleton?
>>
>> Couple of reasons:
>>
>> - I don't need any of the other features of the skeleton
>> - I don't want to depend on bpftool in the build process
>> - I don't want to embed the BPF bytecode into the C object
>
> Just curious, how are you intending to use global variables. Are you
> restricting to a single global var (a struct probably), so it's easier
> to work with it? Or are you resolving all the variables' offsets
> manually? It's really inconvenient to work with global variables
> without skeleton, which is why I'm curious.

Yeah, there's a single:

static volatile const struct xdp_dispatcher_config conf = {};

in the BPF file. Which is defined as:

struct xdp_dispatcher_config {
	__u8 num_progs_enabled;
	__u32 chain_call_actions[MAX_DISPATCHER_ACTIONS];
};

>> > Also, application can already find that map by looking at name.
>>
>> Yes, it can find the map, but it can't access the data. But I guess I
>> could just add a getter for that. Just figured this was easier to
>> consume; but I can see why it might impose restrictions on future
>> changes, so I'll send a v2 with such a map-level getter instead.
>
> Sounds good, I'll go review v2 now.

Great, thanks!

-Toke

