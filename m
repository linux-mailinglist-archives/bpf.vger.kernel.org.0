Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A083277C3B
	for <lists+bpf@lfdr.de>; Fri, 25 Sep 2020 01:14:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbgIXXOE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 24 Sep 2020 19:14:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:50636 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726205AbgIXXOD (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 24 Sep 2020 19:14:03 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600989242;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kNz47kMuHB/f0bjf1dI2WxhSa4rym2TxHMpu7tr6TsE=;
        b=Z0DnrRdbyzuxnGR/uNH44lSWwlkvinticK5xWNhi/9735sGfX9FvV84UR3ZR5iBUOMa06k
        rhsYFZS2rw6f0RhTv/ymOCzns+qby0UY9IgZkUbWL2otfKby4ZYuqBQaWuntGmshuaXJcf
        aahhT/84F5WNaELdOs53Ta2aCYbDaq8=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-562-TmE0fgBpMu2inbeRqxXg6A-1; Thu, 24 Sep 2020 19:14:00 -0400
X-MC-Unique: TmE0fgBpMu2inbeRqxXg6A-1
Received: by mail-pf1-f197.google.com with SMTP id f76so445237pfa.5
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2020 16:14:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=kNz47kMuHB/f0bjf1dI2WxhSa4rym2TxHMpu7tr6TsE=;
        b=eJHQvSvG3A/Y3LREZMqgmSaw6YSaUvMozKmmhqYvtF62uum3fHtAJn7KUhrIt16j71
         LHN1rt8ai8NOBpvbPUFhC+PJk2POJBek3uHp3SfR9k32qm/W3F+nka0HvfpqzUzy8PJA
         FCvXlFrHbGNgoRU+IQnfOBBnpWBKrU9dcp+mzAjgA5QQ4kmpNbqEBB0wY4GBaO1+SATl
         tNoLMSPJzFiWkxDU9CsVpYvpJyk5LiT3B/nNDci72Vee2HR0SadBRtiVIjru8aAJ+BS5
         /TH+8RtS3vyNGM0lipN7tPnTpnrUxhMqfT9xhI3nq9QYJqAdhguWjJkGGTzmP2S6SySy
         qqpQ==
X-Gm-Message-State: AOAM532bumjjdqi4LsAqfHBbvjF9VKBwiVMtmIpwqZ1+PWAqYPNLUfAA
        M6dCzc4sJwqOBo2ZdCFPH0v8vJAzND3YwbYB/IXAAnwaE91jub9H9a5gTuJyC0CMRod5xH8PZGv
        VFZG2fFkFc33c
X-Received: by 2002:aa7:9518:0:b029:142:2501:35e3 with SMTP id b24-20020aa795180000b0290142250135e3mr1268762pfp.67.1600989239484;
        Thu, 24 Sep 2020 16:13:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwME2/K/IbUTfmnrx9/16A3flZygkg6nD1UFOjlNqLTKnT2jwbq9mPHga9jDWqvftMUzrfhSA==
X-Received: by 2002:aa7:9518:0:b029:142:2501:35e3 with SMTP id b24-20020aa795180000b0290142250135e3mr1268733pfp.67.1600989239212;
        Thu, 24 Sep 2020 16:13:59 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id x20sm492190pfr.190.2020.09.24.16.13.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 16:13:58 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 842F4183A90; Fri, 25 Sep 2020 01:13:53 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Jakub Sitnicki <jakub@cloudflare.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Eelco Chaudron <echaudro@redhat.com>,
        KP Singh <kpsingh@chromium.org>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next v8 04/11] bpf: move prog->aux->linked_prog and
 trampoline into bpf_link on attach
In-Reply-To: <CAEf4Bza38tR1GvyLzzzzv6zT8B-_gM_jhTqK_c7+e1ciU3ZA1w@mail.gmail.com>
References: <160079991372.8301.10648588027560707258.stgit@toke.dk>
 <160079991808.8301.6462172487971110332.stgit@toke.dk>
 <20200924001439.qitbu5tmzz55ck4z@ast-mbp.dhcp.thefacebook.com>
 <874knn1bw4.fsf@toke.dk>
 <CAEf4BzaBvvZdgekg13T3e4uj5Q9Rf1RTFP__ZPsU-NMp2fVXxw@mail.gmail.com>
 <87zh5ec1gs.fsf@toke.dk>
 <CAEf4BzZxfzQabDCdmby1XMQV7qQ_C=rATWOb=cN-Q1rfxR+nVA@mail.gmail.com>
 <87r1qqbywe.fsf@toke.dk>
 <CAEf4Bza38tR1GvyLzzzzv6zT8B-_gM_jhTqK_c7+e1ciU3ZA1w@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 25 Sep 2020 01:13:53 +0200
Message-ID: <87mu1ebwem.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:

>> [root@(none) bpf]# ./test_progs -t map_in_map
>> test_lookup_update:PASS:skel_open 0 nsec
>> test_lookup_update:PASS:skel_attach 0 nsec
>> test_lookup_update:PASS:inner1 0 nsec
>> test_lookup_update:PASS:inner2 0 nsec
>> test_lookup_update:PASS:inner1 0 nsec
>> test_lookup_update:PASS:inner2 0 nsec
>> test_lookup_update:PASS:map1_id 0 nsec
>> test_lookup_update:PASS:map2_id 0 nsec
>> kern_sync_rcu:PASS:inner_map_create 0 nsec
>> kern_sync_rcu:PASS:outer_map_create 0 nsec
>> kern_sync_rcu:PASS:outer_map_update 0 nsec
>> test_lookup_update:PASS:sync_rcu 0 nsec
>> kern_sync_rcu:PASS:inner_map_create 0 nsec
>> kern_sync_rcu:PASS:outer_map_create 0 nsec
>> kern_sync_rcu:PASS:outer_map_update 0 nsec
>> test_lookup_update:PASS:sync_rcu 0 nsec
>
> try adding sleep(few seconds, enough for RCU grace period to pass)
> here and see if that helps
>
> if not, please printk() around to see why the inner_map1 wasn't freed

Aha, found it! It happened because my kernel was built with
PREEMPT_VOLUNTARY. Changing that to PREEMPT fixed the test, and got me
to:

Summary: 116/853 PASSED, 14 SKIPPED, 0 FAILED

So yay! Thanks for your help with debugging :)

-Toke

