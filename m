Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 526763A5A89
	for <lists+bpf@lfdr.de>; Sun, 13 Jun 2021 23:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232080AbhFMVMb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 13 Jun 2021 17:12:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232038AbhFMVMb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 13 Jun 2021 17:12:31 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A6D3C061574
        for <bpf@vger.kernel.org>; Sun, 13 Jun 2021 14:10:17 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id d9so4920503qtp.11
        for <bpf@vger.kernel.org>; Sun, 13 Jun 2021 14:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=09DmQmr0DsdT1vvZq2xVOCEjlhlm7eufkM/LgOhx6kI=;
        b=MdMdr4lq7mEPPmQGwvBfKbSZ8FPKLZYhHbgrUK1ezGvZG9lV1ON38bxWxZH5QkwljZ
         yInVwPFAuiytmSCXEBvJi9X91qh5964YMfTQ6fcM8ZOsdBYnfOBbgHoOo0Xj93n32brj
         8tsxoZEU2IOOSjMc+e74a64KGZev5VX4QWXVgzt0m1sFdueqjSOsHV8/ZQ+aoW/iVFLv
         dXfmONWcUkUU2cXgmhGQG0i4e8dZfAWLJ01nNmQMfOwJpTHVFVTHcay112b1tgbXm8tw
         0uwGkrMnOiHAnjjkTGAl3TFGWjHzmCuP8vIdBX8V5O1OY+J6UFjhgfbhIjcj+hRwiSlZ
         GQ6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=09DmQmr0DsdT1vvZq2xVOCEjlhlm7eufkM/LgOhx6kI=;
        b=YLf+HrZKHJTRVDklR1etZiFvjBb1z7of60+CgOBTiZioOIO30+LP34dO5ULZs+G4N4
         qfgF4i86dJ6HRYvzovgnhR57Io9skA68cx0hM9H0c70Q/zYEl5WjFG15AqlMs88zltou
         5SmF9xsxH4/raeRiXdxVyWJipU5JmXrTzpLY0SGinUzen21Xn+YeYM+fRKikCw7mlRd8
         vL2MR3N5+vmhSJ0fYpXTP0unICCxlH4Nv9wwc0cEAph5/b/y/TBwAgIIDp1Msp6EWDsH
         8JwmffPeYW1gXZuDQtGPZ7Ke/oHuPX1Wv13bH1Xc7oD9PW7F6RiBb9c8sv/Dy5M3RbYe
         8ZlA==
X-Gm-Message-State: AOAM533eIsEW8U701n5UuJSIg/OK8pDriPplpwiT07nz22GEOobl6/x/
        lrUAkt8lvUxiBUTHSTsNXWtIzg==
X-Google-Smtp-Source: ABdhPJwyo5+3f6deaGBPqI07aRrGyEfbZ0hwjHZ6GgjL0M74bGTF+q9eIX5GYcXlATRdHYjSC3whzg==
X-Received: by 2002:a05:622a:5d2:: with SMTP id d18mr13758395qtb.198.1623618616259;
        Sun, 13 Jun 2021 14:10:16 -0700 (PDT)
Received: from [192.168.1.171] (bras-base-kntaon1617w-grc-28-184-148-47-211.dsl.bell.ca. [184.148.47.211])
        by smtp.googlemail.com with ESMTPSA id l6sm9007363qkk.117.2021.06.13.14.10.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Jun 2021 14:10:15 -0700 (PDT)
Subject: Re: [PATCH RFC bpf-next 0/7] Add bpf_link based TC-BPF API
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     Cong Wang <xiyou.wangcong@gmail.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Vlad Buslov <vladbu@nvidia.com>,
        Jiri Pirko <jiri@resnulli.us>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, Joe Stringer <joe@cilium.io>,
        Quentin Monnet <quentin@isovalent.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>,
        Linux Kernel Network Developers <netdev@vger.kernel.org>,
        Marcelo Ricardo Leitner <mleitner@redhat.com>
References: <20210528195946.2375109-1-memxor@gmail.com>
 <CAM_iQpVqVKhK+09Sj_At226mdWpVXfVbhy89As2dai7ip8Nmtw@mail.gmail.com>
 <20210607033724.wn6qn4v42dlm4j4o@apollo>
 <CAM_iQpVCnG8pSci2sMbJ1B5YE-y=reAUp82itgrguecyNBCUVQ@mail.gmail.com>
 <20210607060724.4nidap5eywb23l3d@apollo>
 <CAM_iQpWA=SXNR3Ya8_L2aoVJGP_uaRP8EYCpDrnq3y8Uf6qu=g@mail.gmail.com>
 <20210608071908.sos275adj3gunewo@apollo>
 <CAM_iQpXFmsWhMA-RO2j5Ph5Ak8yJgUVBppGj2_5NS3BuyjkvzQ@mail.gmail.com>
 <20210613025308.75uia7rnt4ue2k7q@apollo>
 <30ab29b9-c8b0-3b0f-af5f-78421b27b49c@mojatatu.com>
 <20210613203438.d376porvf5zycatn@apollo>
From:   Jamal Hadi Salim <jhs@mojatatu.com>
Message-ID: <4b1046ef-ba16-f8d8-c02e-d69648ab510b@mojatatu.com>
Date:   Sun, 13 Jun 2021 17:10:14 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210613203438.d376porvf5zycatn@apollo>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 2021-06-13 4:34 p.m., Kumar Kartikeya Dwivedi wrote:
> On Mon, Jun 14, 2021 at 01:57:16AM IST, Jamal Hadi Salim wrote:

> 
> Right, also I'm just posting so that the use cases I care about are clear, and
> why they are not being fulifilled in some other way. How to do it is ofcourse up
> to TC and BPF maintainers, which is why I'm still waiting on feedback from you,
> Cong and others before posting the next version.
> 

I look at it from the perspective that if i can run something with
existing tc loading mechanism then i should be able to do the same
with the new (libbpf) scheme.

>> We do have this monthly tc meetup every second monday of the month.
>> Unfortunately it is short notice since the next one is monday 12pm
>> eastern time. Maybe you can show up and a high bandwidth discussion
>> (aka voice) would help?
>>
> 
> That would be best, please let me know how to join tomorrow. There are a few
> other things I was working on that I also want to discuss with this.
> 

That would be great - thanks for your understanding.
+Cc Marcelo (who is the keeper of the meetup)
in case the link may change..

cheers,
jamal
