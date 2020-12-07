Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 193B92D18E5
	for <lists+bpf@lfdr.de>; Mon,  7 Dec 2020 20:02:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725917AbgLGTAj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Dec 2020 14:00:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725915AbgLGTAj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Dec 2020 14:00:39 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35653C061793
        for <bpf@vger.kernel.org>; Mon,  7 Dec 2020 10:59:53 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id i6so7412155otr.2
        for <bpf@vger.kernel.org>; Mon, 07 Dec 2020 10:59:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sO70rTXmp2oyDatETg7DesVuEq1X6+/krRSf9vscnwQ=;
        b=Dw+/2PuOQszPMbMmj8lHMutCOxqVWaouXaTdmrJ6UoBX4pueHAhD2ARU6aK8IZ1FHV
         7UybLcFZm4KJVf+LwdKaRJXmLClkqjhqLJKN1v1yCZ7rFtf1HwKcGCu0OYAA7uFc1Na3
         LxSoAyvzSY5idzlkzH4klStFxx7JhTfQmaFjjTPHvQhaezdSvQSgKpZqFKNap6htbDg5
         Z+XIoH5q9Q6uLya/YxWe19mTmwEe8T1FDKcxiVgOOhYD4veOH14rELKlADkxap/oTJcx
         efLTXJOu7Qo9zhAzWpBct7MtBB2Cgax81W54gMWcc3ESot4aSX3oIHE2xTS0mCRE7p5R
         PGYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sO70rTXmp2oyDatETg7DesVuEq1X6+/krRSf9vscnwQ=;
        b=lQk1FZcPsUAHUBims3ET5S9ZB/AhYFZ0eUYVHebzVJf+cZzKhGbn6j/9AVAm0GKNf9
         bU8MtSjaPdRRCi5QjRsS7PhCg3fwxXZJaFqrQpr2jd790SCwQPx0JhJ0CoGbaRIpw4Qm
         DuJmAarJhqLh8QKtp0/COyzTNJlXcs5W/1w48fMFb9zXdS3Ong5iMTnUwalEOG4QoxLi
         Vngmce29Pl7XKLtnlHy0FF+ibcvFsQdZzsG0HbaqNgCEsEBmvxInGxPDyzWFxHlclnrF
         91ICvKpI+MSuUV3ELifYkGNmsrfRava1BUbRUVEUXFs+lCMSdpItyS4E/KXMkyI8A0CU
         kl9A==
X-Gm-Message-State: AOAM531UTHTeQn5vpk5jUzfeb1p7CwS1TyYYN63hd2/shXbiP2flIvtT
        dH7/Pi/FKDPoOdcitsZOvVunKdAH6Fk=
X-Google-Smtp-Source: ABdhPJyFmlzaXXi11Vksn3uAeJIXXoiYPuhsopkeg4+m5ne+bZzHUaauJ5VjlTpxbEWZ+fenahN4rQ==
X-Received: by 2002:a9d:4588:: with SMTP id x8mr14307439ote.169.1607367592380;
        Mon, 07 Dec 2020 10:59:52 -0800 (PST)
Received: from Davids-MacBook-Pro.local ([8.48.134.51])
        by smtp.googlemail.com with ESMTPSA id o21sm1500347otj.1.2020.12.07.10.59.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Dec 2020 10:59:51 -0800 (PST)
Subject: Re: Latest libbpf fails to load programs compiled with old LLVM
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Yonghong Song <yhs@fb.com>, bpf <bpf@vger.kernel.org>
References: <87lfeebwpu.fsf@toke.dk>
 <10679e62-50a2-4c01-31d2-cb79c01e4cbf@fb.com> <87r1o59aoc.fsf@toke.dk>
 <6801fcdb-932e-c185-22db-89987099b553@fb.com>
 <CAEf4BzZRu=sxEx7c8KGxSV1C6Aitrk01bSfabv5Bz+XUAMU6rg@mail.gmail.com>
 <875z5d7ufl.fsf@toke.dk>
 <CAADnVQ+qibC_8cDwaqOoAnL7CwXv85EjQ96Zcdtrm+86cgZq1g@mail.gmail.com>
 <878sa9619d.fsf@toke.dk>
 <CAADnVQKYaeF2KCC5SLBg3feUY_DBh-eq2_O=T10_+13z3wNm1Q@mail.gmail.com>
 <82dc6d2b-95b6-ab50-8bdb-6e90cfb32059@gmail.com>
 <CAADnVQKdQdxAouvFGAWr+xT73=JZGkaKdTObsDW0GAnjcDzx9g@mail.gmail.com>
From:   David Ahern <dsahern@gmail.com>
Message-ID: <9d91a663-abd3-603d-de5e-26c572eeac05@gmail.com>
Date:   Mon, 7 Dec 2020 11:59:47 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <CAADnVQKdQdxAouvFGAWr+xT73=JZGkaKdTObsDW0GAnjcDzx9g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 12/7/20 11:14 AM, Alexei Starovoitov wrote:
> On Mon, Dec 7, 2020 at 10:02 AM David Ahern <dsahern@gmail.com> wrote:
>>
>> On 12/7/20 9:20 AM, Alexei Starovoitov wrote:
>>> The user space library is not a kernel.
>>> The library will change its interface. It will remove functions, features, etc.
>>> That's what .map is for.
>>
>> So any user/package wanting to leverage libbpf can not expect stability
>> or consistency with its APIs?
> 
> If you're talking about iproute2 and your own convoluted definition of

your record player seems to be stuck. Could you give it a little bump so
it can move on to the next track? Thanks. I do work on other things
besides iproute2.

> stability and consistency then certainly not.
> 

Your statement has huge impacts on what users can expect from a library
and is inconsistent with other libraries I have used. Hence, my request
for clarification on your comment about 'changing interfaces, removing
functions and features.'
