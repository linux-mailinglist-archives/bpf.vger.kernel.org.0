Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 726E327C29B
	for <lists+bpf@lfdr.de>; Tue, 29 Sep 2020 12:47:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725355AbgI2KrV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 29 Sep 2020 06:47:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48333 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725306AbgI2KrU (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 29 Sep 2020 06:47:20 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601376438;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bHRjqq9aD7nbdcwIh20eQ0OrgZ63URxR53hLcrRv4o8=;
        b=PlmHZCXuIFf/g/98baYairXLJsL295e7KpnnvnGz0b29MBR5oWO5NfBogX3fVfWeC4KVN2
        3vLyoSPGOE/IyrDAHvq3bl83q+ZuHfHFQaRtsMhNTYGFCro3yrKRyLk95dVH9iT4YfmNN9
        elm2prvXq+urwiuXt7iBvbVHj2hmKbA=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-551-GWhCS3naPQa-THnUOlR_Kw-1; Tue, 29 Sep 2020 06:47:17 -0400
X-MC-Unique: GWhCS3naPQa-THnUOlR_Kw-1
Received: by mail-oo1-f72.google.com with SMTP id t3so1870440ood.7
        for <bpf@vger.kernel.org>; Tue, 29 Sep 2020 03:47:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=bHRjqq9aD7nbdcwIh20eQ0OrgZ63URxR53hLcrRv4o8=;
        b=Y5uAGbO6nNKKtBPIEbCyiUzgbqcKTCoMPE4LbHrYd7Gcah4/u90PIdsaCzcO9V5il8
         uQ9ys0WDyL/rvgORZFqi9wskBGi8TI4Y8xYFov99gkWaO3tyLWmdKljbz8/+nv/FWdyR
         Fj1tsA/5w/9anWxH/MYxam2ggGywOZP1yERiGZYtjCTiyic6ZSjA16dhgTkiHLqkqmIp
         SeLgKpwW07fDcNrBFOmjmkkAUZ3ZZZyLRAI/iD+AoCLNFEWwfDBD54/pCkGKUYnSAugd
         iMcgXzW7793DTZEDjiWvaCdkA32i/1nkzjFM3CpvDPtwyxKYq19JqJydbc2UiaKOHkbP
         5v0Q==
X-Gm-Message-State: AOAM530YAtf65n0EgjmZ56anClE7YFmIML5mHS4N3hUOyTShYX33VXfo
        gaBwiXyCUkmEYUyXUmPBin1QsQ7x9UlyCMZaEe+JtNaeFjcXFxFNYNbtvlq9MHUFPzq70pHk+37
        zUNQ1n/iddnUN
X-Received: by 2002:a9d:5a8:: with SMTP id 37mr2183160otd.362.1601376436287;
        Tue, 29 Sep 2020 03:47:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzO6weu8pvdunFcfhDqE6c/s9RmtG9spsVbUPb8XJD/zzFkDW0VVJx/OboVmQA0ciwQxiCi1g==
X-Received: by 2002:a9d:5a8:: with SMTP id 37mr2183144otd.362.1601376435976;
        Tue, 29 Sep 2020 03:47:15 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id g21sm3015843oos.36.2020.09.29.03.47.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2020 03:47:15 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 9B687183C5B; Tue, 29 Sep 2020 12:47:13 +0200 (CEST)
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
Subject: Re: [PATCH bpf-next v9 04/11] bpf: move prog->aux->linked_prog and
 trampoline into bpf_link on attach
In-Reply-To: <20200929000522.n5g2hcahqjxwseye@ast-mbp.dhcp.thefacebook.com>
References: <160106909952.27725.8383447127582216829.stgit@toke.dk>
 <160106910382.27725.8204173893583455016.stgit@toke.dk>
 <20200929000522.n5g2hcahqjxwseye@ast-mbp.dhcp.thefacebook.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 29 Sep 2020 12:47:13 +0200
Message-ID: <87o8lo3ln2.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:

> On Fri, Sep 25, 2020 at 11:25:03PM +0200, Toke H=C3=83=C6=92=C3=82=C2=B8i=
land-J=C3=83=C6=92=C3=82=C2=B8rgensen wrote:
>>=20=20
>>  int bpf_check_attach_target(struct bpf_verifier_log *log,
>>  			    const struct bpf_prog *prog,
>> -			    const struct bpf_prog *tgt_prog,
>> +			    const struct bpf_prog *dst_prog,
>
> so you really did blind search and replace?
> That's not at all what I was asking.
> The function is called check_attach_target and the argument name
> 'tgt_prog' fits perfectly.

Initially I did, and then I realised basically what you were saying, and
started to undo some of the conversions. Guess I landed somewhere
in-between... Will fix, and resend patches 4-10. Thanks!

-Toke

