Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90DBC42BC9E
	for <lists+bpf@lfdr.de>; Wed, 13 Oct 2021 12:19:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239266AbhJMKV3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 13 Oct 2021 06:21:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:38358 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239300AbhJMKV1 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 13 Oct 2021 06:21:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634120363;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9G5qR3anJ6Kag1yEY1aEeELtU6/wshD18YZk5bDrIE8=;
        b=OZMTRXmTXYS5UclhhZWcj5ZcDENqnYruZ/zI4oXBys1Fegut7gaWxilUjJvDAILgIoWXvn
        uou9eyEhoDARlxIlAS5mg+jqyo/GXgsmUsMfTloBVu03gp5Gy2xGE1Vg2tO0A7cAF4xkxN
        j3emx7XNxlYgctsqA1fMXy6o9m7xc/U=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-200-h0xJo-0cNyGusPWuyxDxLA-1; Wed, 13 Oct 2021 06:19:22 -0400
X-MC-Unique: h0xJo-0cNyGusPWuyxDxLA-1
Received: by mail-ed1-f70.google.com with SMTP id d11-20020a50cd4b000000b003da63711a8aso1755162edj.20
        for <bpf@vger.kernel.org>; Wed, 13 Oct 2021 03:19:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=9G5qR3anJ6Kag1yEY1aEeELtU6/wshD18YZk5bDrIE8=;
        b=NFtOcUl9nXmJsG4sneiEgE5IiozqT5nNSNAhvfaOOzdZLN8CWIyjJjP8GfAzmGJOwV
         5rywLN3bDlt8V5CCX5vLpe/2DrUp0IDCCV/wLfIGr5IixiQATOwEWzfzmeI6P8tTymvE
         0FHiTV82H+GrLumiOIc4Ck1TfzeofXbMilY7qXThaMA/W9yp1CHcqly1Gf0fzm/UutIu
         uNTq/+wzwXTohPXZzyJCNONtuN9/2v6ujIg0Saf3a/2efpHRAFClzB+BSziUQRmdhts5
         yPFqSlev6E7uJTU0Nj9lleBgl1csUeOC2wp24ZLulc2QsGnGUJUJMbaOx3HO8h3ecXoL
         0eEQ==
X-Gm-Message-State: AOAM530SRUOocLhj8Wpt+jZrprdCotQbixsxHnWhPD0U4KoK+Y4uw0qa
        tqJ1r9WdFYuAG7kL1hUPMRW6ehi3VYirMH84GoMbDA/Z7oW5fzyP7WJbd+P+bJuxPvvASc6080w
        PDpMeLZBbgTdh
X-Received: by 2002:a17:907:338b:: with SMTP id zj11mr25132221ejb.284.1634120360012;
        Wed, 13 Oct 2021 03:19:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzAa/PiNmFBQvsqP2MS0ydtQWk7OVYy5taIHE+/b3P7xXu2tif/hRmudLJ/h8TX+5z09XSmRQ==
X-Received: by 2002:a17:907:338b:: with SMTP id zj11mr25132121ejb.284.1634120359062;
        Wed, 13 Oct 2021 03:19:19 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id nb29sm3083211ejc.54.2021.10.13.03.19.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 03:19:18 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id A8444180151; Wed, 13 Oct 2021 12:19:17 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Joanne Koong <joannekoong@fb.com>, Martin KaFai Lau <kafai@fb.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org,
        netdev@vger.kernel.org, Kernel-team@fb.com
Subject: Re: [PATCH bpf-next v2 0/3] Add XDP support for bpf_load_hdr_opt
In-Reply-To: <531ae597-f749-fcea-68c5-d3e2fa80d083@fb.com>
References: <20211006230543.3928580-1-joannekoong@fb.com>
 <87h7dsnbh5.fsf@toke.dk> <9f8c195c-9c03-b398-2803-386c7af99748@fb.com>
 <43bfb0fe-5476-c62c-51f2-a83da9fef659@iogearbox.net>
 <20211007235203.uksujks57djohg3p@kafai-mbp> <87lf33jh04.fsf@toke.dk>
 <20211011184333.sb7zjdsty7gmtlvl@kafai-mbp> <87v922gwnw.fsf@toke.dk>
 <531ae597-f749-fcea-68c5-d3e2fa80d083@fb.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 13 Oct 2021 12:19:17 +0200
Message-ID: <874k9lgrbu.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Joanne Koong <joannekoong@fb.com> writes:

> On 10/12/21 7:11 AM, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>
>> Martin KaFai Lau <kafai@fb.com> writes:
>>> On Sat, Oct 09, 2021 at 12:20:27AM +0200, Toke H=C3=B8iland-J=C3=B8rgen=
sen wrote:
>>> [...]=20
>>> I don't mind to go with the for_each helper.  However, with another
>>> thought, if it needs to call a function in the loop anyway, I think
>>> it could also be done in bpf by putting a global function in a loop.
>>> Need to try and double check.
>> Hmm, that would be interesting if possible!
>>
>> -Toke
>>
> Martin and I tried this out. When we moved out the logic for parsing the
> options into a global non-inlined function, the verifier approved the
> program.

Excellent!

> As such, I will abandon this patchset and submit a new separate patch
> that will add a test to ensure we're always able to parse header options
> through a global function.
>
> Thanks for the conversation on this, Toke, Martin, and Daniel!

Sounds good - you're welcome :)

-Toke

