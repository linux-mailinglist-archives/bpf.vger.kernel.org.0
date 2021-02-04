Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 970D430F176
	for <lists+bpf@lfdr.de>; Thu,  4 Feb 2021 12:04:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235332AbhBDLCF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 4 Feb 2021 06:02:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:35321 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235559AbhBDLCB (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 4 Feb 2021 06:02:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612436434;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=H9y6jMxzRKWetuvR+vU0kaaq6ZCpRReGAB6FdQSljfk=;
        b=VLcKRTbXhlCXq1ImKeltK63lzuByrdehCcCN88hpPof2tNim1F5Vm/UVa8TblNiJbucnFi
        +4enz0h0ZSvhaGuqG/z/rFV2RjRhAcJe98i9fVgvzpLgHCKyN6Iba+WEQmb2PtAcPu2FEY
        sf169FHr5YpgeT8Pp4lucrZhyogJzoY=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-492-69KZuNqyNrWraSy3tT53XQ-1; Thu, 04 Feb 2021 06:00:32 -0500
X-MC-Unique: 69KZuNqyNrWraSy3tT53XQ-1
Received: by mail-ej1-f70.google.com with SMTP id bx12so2404930ejc.15
        for <bpf@vger.kernel.org>; Thu, 04 Feb 2021 03:00:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=H9y6jMxzRKWetuvR+vU0kaaq6ZCpRReGAB6FdQSljfk=;
        b=tdTstkuN8i6r9s2mV2QhPu/kdlSe2Ulat5IJDPtEeqE6chlV6V3x8lTW0DcYLoBxb4
         fSLabvgP7xOzoGfL44J8Xmarniy30qUGFTeDudFKT/XPiM/6naR7BFm88n1f022kb4jr
         ANMgHwKEHaSYDdSX0Kwv2touLHWo6YXAgzj0G2WxAxutrTNm4E+O3SroDBZSb+nBaX2M
         DwpUS0BSkPl8rHwkHw53SIwg4X2GeaxaFLQMG2viApGg73ooFXghmqOMDTpvUMjHXMTv
         bqDEK8rhFKS+yTxECDnwj5eciYhU0cIfBjkvnb9wwglx4ApBGrQPtB34AlBcUeAM9Z4f
         X5/g==
X-Gm-Message-State: AOAM530TYe9egwMPsEkMVzBAUAWC4d7dWfGMMAydqFI5pp5+JxaXbkb/
        JbN9O4I1kpkfMbd/8Ms1AGapvgCYnQosd9mZRBYcYkycBZTl2AAe1mef+lzGc8GoW6TW5EHWe1d
        v2VkpNPotZV8x
X-Received: by 2002:a17:906:14d5:: with SMTP id y21mr7489909ejc.410.1612436431214;
        Thu, 04 Feb 2021 03:00:31 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx9AFLaiKBN4L4JtBuc2eIgCZUJQCDgCeD2bK3ZmOiNs9F+s8O93VbS3roM5Td6lbqmSbq8Zw==
X-Received: by 2002:a17:906:14d5:: with SMTP id y21mr7489889ejc.410.1612436431039;
        Thu, 04 Feb 2021 03:00:31 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id r9sm2280579eju.74.2021.02.04.03.00.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 03:00:30 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id DEE9918034E; Thu,  4 Feb 2021 12:00:29 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Hangbin Liu <liuhangbin@gmail.com>,
        John Fastabend <john.fastabend@gmail.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        netdev@vger.kernel.org, Jiri Benc <jbenc@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Eelco Chaudron <echaudro@redhat.com>, ast@kernel.org,
        bpf@vger.kernel.org,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        David Ahern <dsahern@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: Re: [PATCHv17 bpf-next 0/6] xdp: add a new helper for dev map
 multicast support
In-Reply-To: <20210204031236.GC2900@Leo-laptop-t470s>
References: <20210122074652.2981711-1-liuhangbin@gmail.com>
 <20210125124516.3098129-1-liuhangbin@gmail.com>
 <20210204001458.GB2900@Leo-laptop-t470s>
 <601b61a0e4868_194420834@john-XPS-13-9370.notmuch>
 <20210204031236.GC2900@Leo-laptop-t470s>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 04 Feb 2021 12:00:29 +0100
Message-ID: <87zh0k85de.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hangbin Liu <liuhangbin@gmail.com> writes:

> On Wed, Feb 03, 2021 at 06:53:20PM -0800, John Fastabend wrote:
>> Hangbin Liu wrote:
>> > Hi Daniel, Alexei,
>> > 
>> > It has been one week after Maciej, Toke, John's review/ack. What should
>> > I do to make a progress for this patch set?
>> > 
>> 
>> Patchwork is usually the first place to check:
>
> Thanks John for the link.
>> 
>>  https://patchwork.kernel.org/project/netdevbpf/list/?series=421095&state=*
>
> Before I sent the email I only checked link
> https://patchwork.kernel.org/project/netdevbpf/list/ but can't find my patch.
>
> How do you get the series number?

If you click the "show patches with" link at the top you can twiddle the
filtering; state = any + your own name as submitter usually finds
things, I've found.

>> Looks like it was marked changed requested. After this its unlikely
>> anyone will follow up on it, rightly so given the assumption another
>> revision is coming.
>> 
>> In this case my guess is it was moved into changes requested because
>> I asked for a change, but then after some discussion you convinced me
>> the change was not in fact needed.
>> 
>> Alexei, Daniel can probably tell you if its easier to just send a v18
>> or pull in the v17 assuming any final reviews don't kick anything
>> else up.
>
> OK, I will wait for Alexei, Daniel and see if I need to do a rebase.

I think I would just resubmit with a rebase + a note in the changelog
that we concluded no further change was needed :)

-Toke

