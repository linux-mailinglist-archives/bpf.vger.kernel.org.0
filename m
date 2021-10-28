Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8806343DD90
	for <lists+bpf@lfdr.de>; Thu, 28 Oct 2021 11:17:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbhJ1JUK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 28 Oct 2021 05:20:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28440 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229950AbhJ1JUJ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 28 Oct 2021 05:20:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635412662;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XYb49CUJnsqbEGH495iJBbfqlJAQ8lsg5dpvdMeVuOo=;
        b=Yi7sMCEGh3LoE1ffMDBNEO9kOGXrukBRwpOWTddQn1s3J1i5dm0idaVSy9qlkvB16/jk74
        0BYbRCwxxUun+FRA6W3T7fMBULQ25fco8UgcGK+M59OB1A/4Vo5ts5XAjqAphCZ6yWnEVq
        5rSBF3Kig6uxTZ+PwDn7ynbEUpZX/7A=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-539-Zg7ElvvMMaOyuWdebzkeMw-1; Thu, 28 Oct 2021 05:17:41 -0400
X-MC-Unique: Zg7ElvvMMaOyuWdebzkeMw-1
Received: by mail-ed1-f72.google.com with SMTP id d11-20020a50cd4b000000b003da63711a8aso4932012edj.20
        for <bpf@vger.kernel.org>; Thu, 28 Oct 2021 02:17:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=XYb49CUJnsqbEGH495iJBbfqlJAQ8lsg5dpvdMeVuOo=;
        b=RdcknRuWn+ybjTQloSzHhYaq/vrDO+/IVrH+5nZldMSDAAlwvJ4BNhJo9BvFKUr6JR
         mo6Gx4llYmGVmBrtTmlkV12koZVyOY7JAjvgDbYNhZy1BXQzmvVRYq6sQMX6fRZ+LUaz
         mmqTlGjNKotYbtVW2qZ4hsd49Pwx+rgmQs54i4OSDEsPSXxuxLLl4Hf7p3g4NsC827fO
         YXUi8Scaf2jMYUYbJykbFkrAJrNBZJEvGrRBWxyzOmFJE7pzJactTtG3tYLFEyDfOVL0
         8yd5wSODk2rtIemMBLZG9aN9NlfH+AndZmHa2cQC5zrq0YyriQ4mZ+9tx3R5hQHAA3EY
         Egmw==
X-Gm-Message-State: AOAM5334JXNjRFIb00798UhEjv878b16goWQTRQhO52LSFHbQQXKwx0/
        79zFYyRZLTQdIOJO/GfvRfUGvjT8FBQ1cFTQE0I+mBhgyMh7JB2HfTqxB6mECxMjAB0UHHyX1LM
        hYnVk4WQu+Nk1
X-Received: by 2002:aa7:dbca:: with SMTP id v10mr4514440edt.280.1635412659883;
        Thu, 28 Oct 2021 02:17:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyyErkSvFKeRyepEgpLv8FRrpQIaiOwQw6qPzorfehEgRmVuwdbrpK46uIWESSl+EZchFOB9Q==
X-Received: by 2002:aa7:dbca:: with SMTP id v10mr4514396edt.280.1635412659539;
        Thu, 28 Oct 2021 02:17:39 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id mp5sm1112484ejc.68.2021.10.28.02.17.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 02:17:39 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 7B83B180262; Thu, 28 Oct 2021 11:17:38 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Daniel Borkmann <daniel@iogearbox.net>, davem@davemloft.net
Cc:     kuba@kernel.org, ast@kernel.org, andrii.nakryiko@gmail.com,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Subject: Re: pull-request: bpf 2021-10-26
In-Reply-To: <07334aca-9b58-fdae-0de9-43d44e087d76@iogearbox.net>
References: <20211026201920.11296-1-daniel@iogearbox.net>
 <87bl3a9lc5.fsf@toke.dk>
 <07334aca-9b58-fdae-0de9-43d44e087d76@iogearbox.net>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 28 Oct 2021 11:17:38 +0200
Message-ID: <878ryda4p9.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Daniel Borkmann <daniel@iogearbox.net> writes:

> On 10/28/21 12:03 AM, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> Daniel Borkmann <daniel@iogearbox.net> writes:
>>=20
>>> The following pull-request contains BPF updates for your *net* tree.
>>>
>>> We've added 12 non-merge commits during the last 7 day(s) which contain
>>> a total of 23 files changed, 118 insertions(+), 98 deletions(-).
>>=20
>> Hi Daniel
>>=20
>> Any chance we could also get bpf merged into bpf-next? We'd like to use
>> this fix:
>>=20
>>> 1) Fix potential race window in BPF tail call compatibility check,
>>> from Toke H=C3=B8iland-J=C3=B8rgensen.
>
> Makes sense! I presume final net tree PR before merge win might go out to=
day
> or tomorrow (Jakub/David?) and would get fast-fwd'ed into net-next after =
that
> as well, which means we get the current batch for bpf-next out by then. By
> that we'd have mentioned commit in bpf-next after re-sync.

Alright, sounds good - thanks! :)

-Toke

