Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 375302B0EE2
	for <lists+bpf@lfdr.de>; Thu, 12 Nov 2020 21:13:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbgKLUNK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 Nov 2020 15:13:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:29193 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727087AbgKLUNJ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 12 Nov 2020 15:13:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605211988;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UcIMxlPA0Ij3wo3HO+1X+MRzqmBG91sW8UXbWK56NoM=;
        b=fcCgaudoUm0/jOVCR8UZ+k3Tx7Ush0hKGvU6LpFcis9xqflXpKJkDn3Cb7yYMiCi9eM8KR
        h3W5A1PGOj0kZPwlMb8fnX6IMcSBFQTNjrXQ2G/NbQXnbn7TK+/KC2yArv9gxSCU8zUNht
        kXFtjXCQEJ5S5zkeH0fjYvdIdJpGh0Y=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-166-9YAlpA_2P4OvS4h_6Esh9g-1; Thu, 12 Nov 2020 15:13:05 -0500
X-MC-Unique: 9YAlpA_2P4OvS4h_6Esh9g-1
Received: by mail-io1-f72.google.com with SMTP id a2so4753937iod.13
        for <bpf@vger.kernel.org>; Thu, 12 Nov 2020 12:13:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=UcIMxlPA0Ij3wo3HO+1X+MRzqmBG91sW8UXbWK56NoM=;
        b=glng1iGQ7yA4qakzWa4TrcOUAxKibd/7cV7fu0MKnl+aK2kFM3+qjrJoY2+W5ptocg
         FwF+yLEGjsyDonjEe4GARaSVtVyrCaj+YVr7/oNTEc2+RH602l+DFuBH1bdnLoTBZRXe
         JlYzBedF+eSoXznFIhAZj1Qv/c0ozlWAbDI5HrY8rtchB4Csncb1OmGGfnYaZ3P7AWrz
         hGdODGCGluPqyWy4f+uenGZngbA4B2wbNro6FrAHa6SUOy/X6p8Xiz+z617HLK64PwE5
         8ClpaysEfCMfsMfjMX6d27+79xsR6/hljZbHoeOrtPBTd4IfF46gwBV3Eno81tVc9j77
         qj3g==
X-Gm-Message-State: AOAM532hyo3vQTz7X0KWbRXnKYH994uQEk4EAAr69D8FmnwdhpuU07LZ
        hQBpp2rERK6DyxwIxEm1IQY0v4X0es/ZaQItqEq9CuC4cM1sb4/tM6aLvYRQilkOZc0C6Q3KSCc
        xMjdyCO8e2qi7
X-Received: by 2002:a92:ca8f:: with SMTP id t15mr1068449ilo.19.1605211983952;
        Thu, 12 Nov 2020 12:13:03 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzmFZEJYIs8c9FS5nyeyPzl8LXmXSjj6Obb0ZeFnlGDMRAunYnqNkvQnu+MeTxI6g3LgylZlw==
X-Received: by 2002:a92:ca8f:: with SMTP id t15mr1068434ilo.19.1605211983725;
        Thu, 12 Nov 2020 12:13:03 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id z6sm3627612ilm.69.2020.11.12.12.13.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 12:13:03 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 5794F1833E9; Thu, 12 Nov 2020 21:13:01 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        davem@davemloft.net
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH bpf] MAINTAINERS/bpf: Update Andrii's entry.
In-Reply-To: <8d6d521d-9ed7-df03-0a9b-d31a0103938c@iogearbox.net>
References: <20201112180340.45265-1-alexei.starovoitov@gmail.com>
 <8d6d521d-9ed7-df03-0a9b-d31a0103938c@iogearbox.net>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 12 Nov 2020 21:13:01 +0100
Message-ID: <87lff68hbm.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Daniel Borkmann <daniel@iogearbox.net> writes:

> On 11/12/20 7:03 PM, Alexei Starovoitov wrote:
>> From: Alexei Starovoitov <ast@kernel.org>
>> 
>> Andrii has been a de-facto maintainer for libbpf and other components.
>> Update maintainers entry to acknowledge his work de-jure.
>> 
>> The folks with git write permissions will continue to follow the rule
>> of not applying their own patches unless absolutely trivial.
>> 
>> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
>
> Full ack, thanks for all the hard work, Andrii!

+1 :)

-Toke

