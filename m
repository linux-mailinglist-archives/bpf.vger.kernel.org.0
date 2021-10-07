Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0569424C55
	for <lists+bpf@lfdr.de>; Thu,  7 Oct 2021 06:03:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbhJGEE4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 7 Oct 2021 00:04:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbhJGEE4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 7 Oct 2021 00:04:56 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 737B9C061746
        for <bpf@vger.kernel.org>; Wed,  6 Oct 2021 21:03:03 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id s75so4406867pgs.5
        for <bpf@vger.kernel.org>; Wed, 06 Oct 2021 21:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=09PLNslUR1NX/akmzuguoMVbral9aXnC3Vxn2ifk5yg=;
        b=j3jenTuG+JPeJW57ZDScIus41CqVqJtZiA1xUcZGioK5Fuk6F/7zHExkWFcKcQbV8Y
         JtAG3dS/PtR5fhEsDu5Ff+WHvIWGweZ6Yeq6xoDyvnsrAjqTnLanq8tnWyiLrsu3UUxs
         9w1TkCx2H/XqCtmqfae/tsC5BHCJUQyrIChFk6zfOrtkqh7reXShvgwSCTDXsYOtxMPT
         nZDYzq78q8MKyxguUC93QibjMn5jG350YIhMXjF1fM9xGgq/aWToR4mDRR4NOYk+d5Ot
         aOCtogAXNBuZk4/+I3q8gtsDPlVR2QjZDYSBU7QeP0BFELm4JhFFI4G9Q1dg+spcm9xd
         G3DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=09PLNslUR1NX/akmzuguoMVbral9aXnC3Vxn2ifk5yg=;
        b=oxf4tZPrUepzSv03Dhj1+L2D/rEuvEMvyX28qHX3T+QYMEwqeYorni/Es5I7UVdeG+
         Th79m/GkerZK+pDLM2vEAS5QrmKcd3d7rY3ouOLvXpZ9qlTGQgAoqX/7RtHI5NImzBqu
         h8us8XQALAJqfbxhAWo0Xkw4QA/MJyBSAGR/Y+yNn9VJ2Bbjb2YXdVqOh2pRlq8ubQNo
         Z9ngd4SMguj+DQZjLT+7R1OG55d0xUTd8/n8UGzs9F4pKuF/rFPukJZ4luNTtgP6j6EL
         ubdGNFu/1zvZf/MyXi+QsgrK7vp7IyiSwM7BSAwYp0EJ1ms0Dnkqah7OuByCitWjKdQ5
         gaxw==
X-Gm-Message-State: AOAM531peq5sR00z4KbJMc5S4KKaVsF1HvC2KJQ40UPrBKyMsvtN116B
        sVSQHwRYbpfPlJR1rAfJcaI=
X-Google-Smtp-Source: ABdhPJxFI5l0Xvj4A84ktHl5BEYQzjeZL47iWUKXocO/xMSSTzZ0g9/l7ILN4y1b6HVD4Xtz17262A==
X-Received: by 2002:a63:f242:: with SMTP id d2mr1558545pgk.384.1633579383014;
        Wed, 06 Oct 2021 21:03:03 -0700 (PDT)
Received: from [0.0.0.0] ([150.109.126.7])
        by smtp.gmail.com with ESMTPSA id k190sm22289307pgc.11.2021.10.06.21.02.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Oct 2021 21:03:02 -0700 (PDT)
Subject: Re: [PATCH bpf-next 1/2] bpf: Add bpf_skc_to_unix_sock() helper
To:     Song Liu <song@kernel.org>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>
References: <20211006040623.401527-1-hengqi.chen@gmail.com>
 <20211006040623.401527-2-hengqi.chen@gmail.com>
 <CAPhsuW5B-C3p-1yJjzWoXm-Mp=USkW4x72pw8i9YPYH=zOMP5A@mail.gmail.com>
From:   Hengqi Chen <hengqi.chen@gmail.com>
Message-ID: <733921fd-62e9-f230-3dd0-e0082ac33a39@gmail.com>
Date:   Thu, 7 Oct 2021 12:02:58 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAPhsuW5B-C3p-1yJjzWoXm-Mp=USkW4x72pw8i9YPYH=zOMP5A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 10/6/21 1:00 PM, Song Liu wrote:
> On Tue, Oct 5, 2021 at 9:08 PM Hengqi Chen <hengqi.chen@gmail.com> wrote:
>>
>> The helper is used in tracing programs to cast a socket
>> pointer to a unix_sock pointer.
>> The return value could be NULL if the casting is illegal.
>>
>> Suggested-by: Yonghong Song <yhs@fb.com>
>> Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
> 
> Acked-by: Song Liu <songliubraving@fb.com>
> 
> With one nitpick below.
> 
> [...]
>> --- a/scripts/bpf_doc.py
>> +++ b/scripts/bpf_doc.py
>> @@ -250,17 +250,17 @@ class PrinterRST(Printer):
>>          license = '''\
>>  .. Copyright (C) All BPF authors and contributors from 2014 to present.
>>  .. See git log include/uapi/linux/bpf.h in kernel tree for details.
>> -..
>> +..
> 
> nit: We usually exclude these trailing space changes from the patch.
> 

Thanks for the review, will drop these unrelated changes in v2.
