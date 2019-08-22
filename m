Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6163399131
	for <lists+bpf@lfdr.de>; Thu, 22 Aug 2019 12:46:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387757AbfHVKoC convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Thu, 22 Aug 2019 06:44:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56062 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387710AbfHVKoC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 22 Aug 2019 06:44:02 -0400
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7C39681DE1
        for <bpf@vger.kernel.org>; Thu, 22 Aug 2019 10:44:01 +0000 (UTC)
Received: by mail-ed1-f70.google.com with SMTP id l15so3130412edw.15
        for <bpf@vger.kernel.org>; Thu, 22 Aug 2019 03:44:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=0JLhxmTFC0T1JpcoAWZpSF/J/8Lj2ncl3gvrc6r31y8=;
        b=AlvL0vWuREM0mu1LRWSFc3zfCcfKfOyqE+JuwpNSMjrCHHtxvr4hCHJi0uRToEFBQ2
         sqdr2QfMfK5co2+oQt4LOeG3Gy5ICACpYvNDm02IYw7dyVHibPbVOSfvmLaMP1Q6lDJt
         lTKbco2cijafDrDVMAa1AYyXQAOfpbofS9EJDfkeFHHrxFQGaJtnoWqVKlTsY+k8SM6i
         McuMCbp3iBwOkAWKj/CiIDkfT8DhVHqH96AuRytjUMcFWnllKR+MTz8Iw817NGz0pbkn
         LjiOtpSbbbxw0stxS59gMLrEZHtCAMLMMSRwV64LaX9XaX6vxPySxhIqFOIoYRgkw1zl
         S9Iw==
X-Gm-Message-State: APjAAAXZFwG18TxoOdY0Yp6Ux/vID6l7Hbvn4xFjrvjY1wNhDEdzB5sh
        I2z5J/5SmxEd5CsIA+OEIBEEeUKG/uH1JpqiQWefUh66ydArXWOzKwIySPLPlABlzpj6vfp7Sfm
        rmBaIQqGYIvh5
X-Received: by 2002:aa7:c1da:: with SMTP id d26mr33293425edp.208.1566470638300;
        Thu, 22 Aug 2019 03:43:58 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxOjMDvOoZysLMKijezQgJaN4SLJPc0vvw5kDtOhrb+8j1+sGoOgyxVqC8kx6rmFoerYpNKrg==
X-Received: by 2002:aa7:c1da:: with SMTP id d26mr33293414edp.208.1566470638147;
        Thu, 22 Aug 2019 03:43:58 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a00:7660:6da:443::2])
        by smtp.gmail.com with ESMTPSA id o88sm3928028edb.28.2019.08.22.03.43.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2019 03:43:57 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id BCFEB181CEF; Thu, 22 Aug 2019 12:43:56 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Alexei Starovoitov <ast@kernel.org>
Cc:     Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
        Yonghong Song <yhs@fb.com>, David Miller <davem@davemloft.net>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        andrii.nakryiko@gmail.com
Subject: Re: [RFC bpf-next 4/5] iproute2: Allow compiling against libbpf
In-Reply-To: <9de36bbf-b70d-9320-c686-3033d0408276@iogearbox.net>
References: <20190820114706.18546-1-toke@redhat.com> <20190820114706.18546-5-toke@redhat.com> <9de36bbf-b70d-9320-c686-3033d0408276@iogearbox.net>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 22 Aug 2019 12:43:56 +0200
Message-ID: <87imqppjir.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Daniel Borkmann <daniel@iogearbox.net> writes:

> On 8/20/19 1:47 PM, Toke Høiland-Jørgensen wrote:
>> This adds a configure check for libbpf and renames functions to allow
>> lib/bpf.c to be compiled with it present. This makes it possible to
>> port functionality piecemeal to use libbpf.
>> 
>> Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
>> ---
>>   configure          | 16 ++++++++++++++++
>>   include/bpf_util.h |  6 +++---
>>   ip/ipvrf.c         |  4 ++--
>>   lib/bpf.c          | 33 +++++++++++++++++++--------------
>>   4 files changed, 40 insertions(+), 19 deletions(-)
>> 
>> diff --git a/configure b/configure
>> index 45fcffb6..5a89ee9f 100755
>> --- a/configure
>> +++ b/configure
>> @@ -238,6 +238,19 @@ check_elf()
>>       fi
>>   }
>>   
>> +check_libbpf()
>> +{
>> +    if ${PKG_CONFIG} libbpf --exists; then
>> +	echo "HAVE_LIBBPF:=y" >>$CONFIG
>> +	echo "yes"
>> +
>> +	echo 'CFLAGS += -DHAVE_LIBBPF' `${PKG_CONFIG} libbpf --cflags` >> $CONFIG
>> +	echo 'LDLIBS += ' `${PKG_CONFIG} libbpf --libs` >>$CONFIG
>> +    else
>> +	echo "no"
>> +    fi
>> +}
>> +
>>   check_selinux()
>
> More of an implementation detail at this point in time, but want to
> make sure this doesn't get missed along the way: as discussed at
> bpfconf [0] best for iproute2 to handle libbpf support would be the
> same way of integration as pahole does, that is, to integrate it via
> submodule [1] to allow kernel and libbpf features to be in sync with
> iproute2 releases and therefore easily consume extensions we're adding
> to libbpf to aide iproute2 integration.

I can sorta see the point wrt keeping in sync with kernel features. But
how will this work with distros that package libbpf as a regular
library? Have you guys given up on regular library symbol versioning for
libbpf?

>    [0] http://vger.kernel.org/bpfconf2019.html#session-4

Thanks for that link! Didn't manage to find any of the previous
discussions on iproute2 compatibility.

-Toke
