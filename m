Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41CFB277B67
	for <lists+bpf@lfdr.de>; Fri, 25 Sep 2020 00:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726316AbgIXWAC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 24 Sep 2020 18:00:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29010 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726280AbgIXWAC (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 24 Sep 2020 18:00:02 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600984800;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=36zI2byukpSXMDYkFOd0oKqSvwDoA1ZB+u3FjofG804=;
        b=Qm8q/gLF7T8THz2cxwLkiFtdKMBMDmdMsiTdO/PbZh26eZD9x9Q3J7BviLnxBDJ7Tl5sQ+
        TyUM5WTmb9/8H9V+zlCRg5Oao+F4SMMgGcDB4PqWUqJswauy7SCE+rBAYKETRlIEJxqO3j
        ACe5vJuVNEKvypVnoJO/dErx9o/T70I=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-65-uQ2iomM0NIOK8ttc8XaGjQ-1; Thu, 24 Sep 2020 17:59:59 -0400
X-MC-Unique: uQ2iomM0NIOK8ttc8XaGjQ-1
Received: by mail-wr1-f72.google.com with SMTP id a10so226978wrw.22
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2020 14:59:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=36zI2byukpSXMDYkFOd0oKqSvwDoA1ZB+u3FjofG804=;
        b=N/f3PVzY2cba9NtZSwUDE/zWKNOlqxBMe/jq8k0HZ8N3JqaW6KUHRLBXy50vLUav8K
         eUM0BgR0aox3cFyg/YVp9txmSXEFALNhtyGiHfZ9OqouIF4qKzLAFw6hF3d21wa9QhjT
         U4I0r5A9MZ9bMi3U8fXGyqJPg8/T8CeU60qXkDPbGvc4lYLycngU+Vwez4B8c/LzXH8Z
         41nAoL8bXavhfygeCNIT7fB3HHaTRWJ+QfY6cdfFO+T6B+ju6dQ+91WxGzukNuGWh3JM
         W525GBhsNNapWGyVqPHYB6RBU03rt99FxFmgOOBdqd4nrqcuTMkZl5Kcp5DIsmh3ZxkP
         57jg==
X-Gm-Message-State: AOAM530ZHDvaHda8dPn0FKOo4Xd7dyol8+I95iVGxNI6tf1CKsdnBowD
        JptoSDNuDClcEVsCguPAa2GXdCpAVKCR6AdNHYtAB5gDt9T9aC2ON+mOJib5gg8fErt7t+cyqTR
        HNanot05Xzbb4
X-Received: by 2002:a5d:4151:: with SMTP id c17mr1095541wrq.302.1600984797807;
        Thu, 24 Sep 2020 14:59:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzRxHBT/T1ldQFZCYI9k6mrIBdKcHO68fkQLx+ycqy/MViuJPziFQCQhOVgQoi23t8JTNzzCw==
X-Received: by 2002:a5d:4151:: with SMTP id c17mr1095524wrq.302.1600984797623;
        Thu, 24 Sep 2020 14:59:57 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id n4sm568785wmc.48.2020.09.24.14.59.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 14:59:57 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id A2306183A90; Thu, 24 Sep 2020 23:59:55 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Eelco Chaudron <echaudro@redhat.com>,
        KP Singh <kpsingh@chromium.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next v8 04/11] bpf: move prog->aux->linked_prog and
 trampoline into bpf_link on attach
In-Reply-To: <20200924001439.qitbu5tmzz55ck4z@ast-mbp.dhcp.thefacebook.com>
References: <160079991372.8301.10648588027560707258.stgit@toke.dk>
 <160079991808.8301.6462172487971110332.stgit@toke.dk>
 <20200924001439.qitbu5tmzz55ck4z@ast-mbp.dhcp.thefacebook.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 24 Sep 2020 23:59:55 +0200
Message-ID: <87tuvmbztw.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:

>> +	struct mutex tgt_mutex; /* protects tgt_* pointers below, *after* prog becomes visible */
>> +	struct bpf_prog *tgt_prog;
>> +	struct bpf_trampoline *tgt_trampoline;
>>  	bool verifier_zext; /* Zero extensions has been inserted by verifier. */
>>  	bool offload_requested;
>>  	bool attach_btf_trace; /* true if attaching to BTF-enabled raw tp */
> ...
>>  struct bpf_tracing_link {
>>  	struct bpf_link link;
>>  	enum bpf_attach_type attach_type;
>> +	struct bpf_trampoline *trampoline;
>> +	struct bpf_prog *tgt_prog;
>
> imo it's confusing to have 'tgt_prog' to mean two different things.
> In prog->aux->tgt_prog it means target prog to attach to in the future.
> Whereas here it means the existing prog that was used to attached to.
> They kinda both 'target progs' but would be good to disambiguate.
> May be keep it as 'tgt_prog' here and
> rename to 'dest_prog' and 'dest_trampoline' in prog->aux ?

I started changing this as you suggested, but I think it actually makes
the code weirder. We'll end up with a lot of 'tgt_prog =
prog->aux->dest_prog' assignments in the verifier, unless we also rename
all of the local variables, which I think is just code churn for very
little gain (the existing 'target' meaning is quite clear, I think).

I also think it's quite natural that the target moves; I mean, it's
literally the same pointer being re-assigned from prog->aux to the link.
We could rename the link member to 'attached_tgt_prog' or something like
that, but I'm not sure it helps (and I don't see much of a problem in
the first place).

WDYT?

-Toke

