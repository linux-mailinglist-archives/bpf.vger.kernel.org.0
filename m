Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEA813BEC65
	for <lists+bpf@lfdr.de>; Wed,  7 Jul 2021 18:38:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229475AbhGGQk7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Jul 2021 12:40:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:59890 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229519AbhGGQk6 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 7 Jul 2021 12:40:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625675898;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DBW1CRiM/N3so8fZaqeN8+dxCKVMvKUaeu+cUDDm810=;
        b=dD0laxGsyPC5X0U9DM/06ajgdZNzOuLZQIh6MMMCLtwi5GbmCwJ6/eLzjMAt1KO9wQXNXI
        +8ZX48JivFi0Z6Eu+RPcGeXVxHgZNUHY4ByDiY8HF+j3lq4RckeO7P8i3wTBwVXx736+Rw
        Xx78go7KglfJTdKAIapCm3WC3rG9OiY=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-52-L85zix-yPrSTy4HgdgyIwQ-1; Wed, 07 Jul 2021 12:38:16 -0400
X-MC-Unique: L85zix-yPrSTy4HgdgyIwQ-1
Received: by mail-ed1-f69.google.com with SMTP id p19-20020aa7c4d30000b0290394bdda6d9cso1674416edr.21
        for <bpf@vger.kernel.org>; Wed, 07 Jul 2021 09:38:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:cc:subject:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=DBW1CRiM/N3so8fZaqeN8+dxCKVMvKUaeu+cUDDm810=;
        b=pDlrmeo+XJBnrxSEFf7/aOWhRVULG/UERuPjvoZJ3j+3wnB+jLDhy0sowF+rPTxuGq
         PWSOU3myn9dQDEgAo/VKk+xbRatZnciR1MeUR05mxw+JHeWNzVduFI0i4oOiGTOsJQxk
         plJ5/RABtakRZtU9R6iUo6gEVxKu1OLEJja0oRwMSff99EQqfvijpj6H+gjiiRpJ1Q4C
         sh88NzFzPwz75JcKgmYU8vuMiWhQ5sE7B1Y9T8/RwPqvYT1500lBzX1UkoTeqoC16rzr
         rLkrTo4lq6bhWg6YAs9cGKK+IKsCGeHJbNCkBqrbkjq5I3N1WNJXT0DiTo4tR7zcvYI+
         jn3Q==
X-Gm-Message-State: AOAM530kREoDNPCFtql6KiEk+ME0CvZ5FONgP3f3kuZhi4fDA9ZcXtwF
        LP4Nx57sLwHVAQDxb3PsKgsaJ9X+f5+Tx6zMxTdWkhAYXup3CM5nlZJXD7OCUWanKFdDW20Tm3G
        e8Yyy+E0vrRWX
X-Received: by 2002:a17:906:2b0c:: with SMTP id a12mr17557660ejg.429.1625675895787;
        Wed, 07 Jul 2021 09:38:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyge9/mUDkZz73CJs0xxkPc0yDh08pMoNf3q9j71TnM8YePtaeEEZtGPsb8hnThkB/gOtKWHw==
X-Received: by 2002:a17:906:2b0c:: with SMTP id a12mr17557634ejg.429.1625675895601;
        Wed, 07 Jul 2021 09:38:15 -0700 (PDT)
Received: from [192.168.42.238] (3-14-107-185.static.kviknet.dk. [185.107.14.3])
        by smtp.gmail.com with ESMTPSA id t27sm7136628eje.86.2021.07.07.09.38.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jul 2021 09:38:14 -0700 (PDT)
From:   Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Cc:     brouer@redhat.com,
        "Swiatkowski, Michal" <michal.swiatkowski@intel.com>,
        "xdp-hints@xdp-project.net" <xdp-hints@xdp-project.net>,
        "Lobakin, Alexandr" <alexandr.lobakin@intel.com>,
        "Karlsson, Magnus" <magnus.karlsson@intel.com>,
        "saeed@kernel.org" <saeed@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "andrii.nakryiko@gmail.com" <andrii.nakryiko@gmail.com>
Subject: Re: A look into XDP hints for AF_XDP
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        "Desouza, Ederson" <ederson.desouza@intel.com>
References: <be4583429b45d618e592585c35eed5f1c113ed68.camel@intel.com>
 <20210624215411.79324c9d@carbon>
 <adfc8f598e5de10fa40a4e791a1e8722edae1136.camel@intel.com>
 <22999687621ecba7281a905a3dbbc148fee12581.camel@intel.com>
 <CAADnVQ+7mJhWzFR45n8RsFmo9M7UmumVRTQ7k+jH=fTr-5A4gA@mail.gmail.com>
Message-ID: <e05c1241-fdd7-19ae-26b4-cd4088057963@redhat.com>
Date:   Wed, 7 Jul 2021 18:38:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAADnVQ+7mJhWzFR45n8RsFmo9M7UmumVRTQ7k+jH=fTr-5A4gA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


On 25/06/2021 00.39, Alexei Starovoitov wrote:
> On Thu, Jun 24, 2021 at 3:18 PM Desouza, Ederson
> <ederson.desouza@intel.com> wrote:
>> Wait - it may be done in user space by libbpf, but it needs the
>> instrumented object code. It won't work for pure user space
>> applications, like those which use AF_XDP. Unless we're going to build
>> them in a special way, like we do for the kernel side of BPF
>> applications.
> It can be made to work. See my reply to Magnus.
> It's not a lot of code to make that happen.

I agree with Alexei, it will not be a lot of code to interpret the BTF 
info in userspace.

In userspace AF_XDP code, we could simply decode the offset of e.g. 
member named "rxhash32" and validate that the expected size is 32 bit (4 
bytes). Then we store the offset associated with rxhash32 for a given 
BTF-ID. When AF_XDP program see BTF-ID it can lookup the offset of 
rxhash32 and move those 4-bytes into a variable for rxhash32.


Implementation details (sorry to complicate this slightly): Because 
metadata area grows with a negative offset seen from ctx->data, and 
AF_XDP descriptor don't know the size of metadata area (like XDP does). 
Then the offset we store (e.g. associated with rxhash32) need to be 
converted to a negative offset from packet ctx->data start.


--Jesper


