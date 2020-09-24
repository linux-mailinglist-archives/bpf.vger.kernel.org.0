Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4E76277B0E
	for <lists+bpf@lfdr.de>; Thu, 24 Sep 2020 23:30:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbgIXVa5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 24 Sep 2020 17:30:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54101 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726448AbgIXVa5 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 24 Sep 2020 17:30:57 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600983056;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=a/CNkCm/J3e9sBEmwQB+KysOFEHFB+QG8VNmP7PW7xY=;
        b=Kl7wN8/6t7pg54yu5/lQh81+2nC2GshPo9Sjl3EarMJKE/JTGcDs8E4d3quwTduVkBcpCz
        pFfrzkgP+TEjZcJCIxeUNqD2dCkDXqPIAXzw2KDAfvBTP0Q8CWnlFim4MMKZlw1SdGUblG
        CtyYmzo1AW0smm9RFUsUHtBQs2sBtzY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-369-pnmy8_QJMKCUUBudcqah_w-1; Thu, 24 Sep 2020 17:30:54 -0400
X-MC-Unique: pnmy8_QJMKCUUBudcqah_w-1
Received: by mail-wr1-f69.google.com with SMTP id g6so218805wrv.3
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2020 14:30:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=a/CNkCm/J3e9sBEmwQB+KysOFEHFB+QG8VNmP7PW7xY=;
        b=lMZnCeFVQDhXHmiwMuNuuoVMAXk5fHD3jRfG57qe9/p0sIiHIUid2qnwa5CsaVj5N1
         C9rVcj6EbzrbtaHyb5af0X1GE6BCNXjPLUFsR722P0Xo4xq14c8ysjI+nx7aYh5YelFL
         TAO5ZVKDa684Tc+eYvcGzAKihF+y883vfuTmfhnb8ONk3O0zE9f/BTu1ajtzjoBAjcRi
         1RF31eSa4bBGDwD7FsmlF9W5SrUbdjhrCcr3OUo0Nl0q4leGJ1DvlxP9Me0UUYGVj2oc
         F5yRDXZKaH8lwK2kbOvSGCJgiQttqIgKzrP4AkEg43klqKmIK1xUTGrAR/LSZqO2Iv2v
         eLgg==
X-Gm-Message-State: AOAM531vkqZF2C31qbZKH7FiuUBdesqTYSQU2C3Sa7N3l3OI41/Cn9Ou
        WMLJqzOspF4RrqKtEg29g4fQ9zNKc6bTHrPrLwsFMp7Bp8ctvGFrDVUXTBESKIbgKs0OAYYs0QU
        0XGjirkrgQDin
X-Received: by 2002:a7b:c215:: with SMTP id x21mr598603wmi.138.1600983053154;
        Thu, 24 Sep 2020 14:30:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJykfxFFNdkSeVaHz4ok4MKyOnP4ilcXybnSRv4A07qyRtSxjz2uWyTS3KKQ6mvIMpaotl5DRA==
X-Received: by 2002:a7b:c215:: with SMTP id x21mr598565wmi.138.1600983052605;
        Thu, 24 Sep 2020 14:30:52 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id b187sm578621wmb.8.2020.09.24.14.30.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 14:30:51 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 1B0B7183A90; Thu, 24 Sep 2020 23:30:51 +0200 (CEST)
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
        KP Singh <kpsingh@chromium.org>,
        Network Development <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next v8 04/11] bpf: move prog->aux->linked_prog and
 trampoline into bpf_link on attach
In-Reply-To: <CAADnVQJmYosGXCnAY4UmhLE+xdQHb1DVOSC5yaZJh7OHzJcUvw@mail.gmail.com>
References: <160079991372.8301.10648588027560707258.stgit@toke.dk>
 <160079991808.8301.6462172487971110332.stgit@toke.dk>
 <20200924001439.qitbu5tmzz55ck4z@ast-mbp.dhcp.thefacebook.com>
 <874knn1bw4.fsf@toke.dk>
 <CAADnVQJmYosGXCnAY4UmhLE+xdQHb1DVOSC5yaZJh7OHzJcUvw@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 24 Sep 2020 23:30:51 +0200
Message-ID: <87wo0ic16c.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


>> > I think I will just start marking patches as changes-requested when I see that
>> > they break tests without replying and without reviewing.
>> > Please respect reviewer's time.
>>
>> That is completely fine if the tests are working in the first place. And
>> even when they're not (like in this case), pointing it out is fine, and
>> I'll obviously go investigate. But please at least reply to the email,
>> not all of us watch patchwork regularly.
>
> Please see Documentation/bpf/bpf_devel_QA.rst.
> patchwork status is the way we communicate the intent.
> If the patch is not in the queue it won't be acted upon.

I do realise that you guys use patchwork as the status tracker, but from
a submitter PoV, in practice a change there is coupled with an email
either requesting something change, or notifying of merge. Which is
fine, and I'm not asking you to do anything differently. I'm just
suggesting that if you start silently marking patches as 'changes
requested' without emailing the submitter explaining why, that will just
going to end up creating confusion, and you'll get questions and/or
identical resubmissions. So it won't actually solve anything...

(And to be clear, I'm not saying this because I plan to deliberately
submit patches with broken selftests in the future!)

-Toke

