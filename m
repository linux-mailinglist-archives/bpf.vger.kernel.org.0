Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AE5C1DEC2C
	for <lists+bpf@lfdr.de>; Fri, 22 May 2020 17:38:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730608AbgEVPiy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 22 May 2020 11:38:54 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:32125 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727807AbgEVPix (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 22 May 2020 11:38:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590161932;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=76FoYd4vHwWJfp5NSdgXYMXT/svq3UBSXuFpWv4febA=;
        b=XfZQF5qpLSTUwCOg9UYT5ZmfocuWJggNtr+rJxSnlaff6qJgylYWhptxFg+kvF3LZWJfNB
        iKyZOMk04xVQunGkO5ZM86CSeVovWrqSgC1Zr2HuvSzgIJLbsxnhahDIPUIrmVoxPCIwRV
        fUiUTtQWc1ZKEWU0ZhuurIBnU8gUuI8=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-82-6SK6snm4OsC98t2fjFyjzg-1; Fri, 22 May 2020 11:38:49 -0400
X-MC-Unique: 6SK6snm4OsC98t2fjFyjzg-1
Received: by mail-ot1-f71.google.com with SMTP id k23so4974906otl.13
        for <bpf@vger.kernel.org>; Fri, 22 May 2020 08:38:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=76FoYd4vHwWJfp5NSdgXYMXT/svq3UBSXuFpWv4febA=;
        b=RvMFlaZpMfO6prbXp6sGoruFY/zq0nQ/i5UalzpL3Lh7SrDPFy6wmXsdHNITx35CkU
         EjTCO4UwipPLcuA3SrFA2ALpg6YHcpE6AfITL42xnPNVBz+CWib49UupiKaEQ5mMhTSj
         ssXHqWSbCFMqZucyPPSc6P7ofvW09ePuMVN4W6p+zHacQKinDUpXXKl3qnVsVVbifmKz
         eCo7ySb7obOmI2cqK13NrP7mbCP5FV4B+g9X0uNjNxmD3wkf9OeS9MkWGZPpjcVkMPI1
         jDY69+6mXv2H2nxvK43+R1n9fBn1wJSg4wuxQiFypho5xVHgcmC2s3+XbLJodTBXpB/z
         +7Eg==
X-Gm-Message-State: AOAM532BeWEzMWcFIhpWbMKeo94IMEer4r7cEyHvOGF/50w7DTI+zeP3
        fdrOMznNLA8Ef1tCqfuG7XgMdIvU5SdC3vJYzUBlBNpgeN02JWXexezlXXxZYWvuxmvkP0DSLl1
        vcIuTZl6Q42iUSy/HSbrOJp3HPHY3
X-Received: by 2002:aca:fc0e:: with SMTP id a14mr2819905oii.12.1590161928744;
        Fri, 22 May 2020 08:38:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwplnAypNt3q8AxSu1Z6dOXu0aYfLGnk8C7KF6d7Ab9BGArnW5SHUQ0dGfe6u0HgeKQPB8Pha5nmIPoPHuEOe4=
X-Received: by 2002:aca:fc0e:: with SMTP id a14mr2819896oii.12.1590161928553;
 Fri, 22 May 2020 08:38:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200515120026.113278-1-yauheni.kaliuta@redhat.com>
 <689fe06a-c781-e6ed-0544-8023c86fc21a@kernel.org> <xunyblmknfmy.fsf@redhat.com>
 <4e0d1e4e-9ed2-025c-1164-fd52a88c1ed2@kernel.org>
In-Reply-To: <4e0d1e4e-9ed2-025c-1164-fd52a88c1ed2@kernel.org>
From:   Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Date:   Fri, 22 May 2020 18:38:32 +0300
Message-ID: <CANoWswmZmHo=ha65u=D8XWD7u9decs6FqubPjVu2YOvm6bz-nA@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] selftests: lib.mk improvements
To:     shuah <shuah@kernel.org>
Cc:     bpf@vger.kernel.org, Jiri Benc <jbenc@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi, Shuah!

On Fri, May 22, 2020 at 6:09 PM shuah <shuah@kernel.org> wrote:
>
> On 5/19/20 8:49 AM, Yauheni Kaliuta wrote:
> > Hi, shuah!
> >
> >>>>>> On Tue, 19 May 2020 07:59:16 -0600, shuah   wrote:
> >
> >   > On 5/15/20 6:00 AM, Yauheni Kaliuta wrote:
> >   >>
> >   >> Yauheni Kaliuta (3):
> >   >> selftests: do not use .ONESHELL
> >   >> selftests: fix condition in run_tests
> >   >> selftests: simplify run_tests
> >   >>
> >   >> tools/testing/selftests/lib.mk | 19 ++++++-------------
> >   >> 1 file changed, 6 insertions(+), 13 deletions(-)
> >   >>
> >
> >   > Quick note that, I will pull these in for 5.8-rc1.
>
> Patches look okay to me, however, just noticed, this series hasn't
> been cc'ed to linux-kselftest. Hence it didn't go through the
> necessary reviews.
>
> Please run get_maintainers and resend the series to everybody the
> script suggests.
>

Sorry for that. Should I resend to the ML?


-- 
WBR, Yauheni

