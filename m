Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29F2B1ECC3B
	for <lists+bpf@lfdr.de>; Wed,  3 Jun 2020 11:12:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726482AbgFCJMF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 Jun 2020 05:12:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726236AbgFCJMF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 Jun 2020 05:12:05 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8930C05BD43
        for <bpf@vger.kernel.org>; Wed,  3 Jun 2020 02:12:04 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id x1so1353233ejd.8
        for <bpf@vger.kernel.org>; Wed, 03 Jun 2020 02:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nTJKg7NFlS/kS/+rvsgLEsS0PyK1+J6045eIfGo40yo=;
        b=D4oYPOKO9hTNajgIR15Wn+4k++eP7IRGRfB9Mdcs4CqYquTmsDLhyZwWHShZO4LQlO
         ARASZr0P7WffkVXLMcy5tTs4hD8C1iBppLHnIISE1f7f5T1Co90qv0WXIyWbP1QSP0FW
         vvWk3EIt4TlqN5RZpd1AiIFnPFWqDY/hEyoLaDx+oj7ZD9JWMiFAHxkpNbjg6kBfrG0H
         ZWyf04x7R1Zr57A9Vb6i6St4/5YwC0jV7UKpJOidW5MMOPKCmKdFg5rYiJJrLGVIIwWw
         TtDwZVO06ZBNE/CSmzHfB/+bAID/X+W7iGHJKeIJBmNq18Uy0m7vwAa2OcxBJlqOktCx
         X28g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nTJKg7NFlS/kS/+rvsgLEsS0PyK1+J6045eIfGo40yo=;
        b=DAg4Z1YH75wizzZJFMtn8paaN0U8APb51t2QzRZGO1mhifgd/dWqjlaSqz890beG/I
         mkb0MW28TGYzCLgwVpWnl+10NzaNr24SpSjWoKL7dYgUIi9agJ1VnZ+XcMZBu2zx9jPz
         8j9TihJE+q+u6Ew5mV5XasIq6MXWljAu0g02T7Puav99SCxD+H0lQhmZjaOudVHYXt9b
         kThhgzKzYFNlz0TNFQYGe39nexk6kQeEBVE2V1i/yPJVl4Z3+ACArqoZSZzoW0BM2d8H
         bAuhddHX/7xNKkVt+5jW4IIwaPhko/cis8BKRxr1UbAPk5VZDj6rXsmnEHX60NSOcYtH
         w8Aw==
X-Gm-Message-State: AOAM532b17cH+KtJwOn9HL55Dy7kxF6UNCxT+eBU11kBMXUuzZSPQbO4
        hdg2V76OkHz1VQnFagoM48nlIN/xM6QlzA==
X-Google-Smtp-Source: ABdhPJyfTBPk1JryAQQvMhD39g9OljlrjBk4NcoU/yS6cmG3yen98ftBcC9QYnjCKhKv/hikEK41bQ==
X-Received: by 2002:a17:906:f8f:: with SMTP id q15mr28143238ejj.389.1591175523317;
        Wed, 03 Jun 2020 02:12:03 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([79.132.248.22])
        by smtp.gmail.com with ESMTPSA id dj26sm857510edb.4.2020.06.03.02.12.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jun 2020 02:12:02 -0700 (PDT)
Subject: Re: [PATCH bpf] bpf: fix unused-var without NETDEVICES
To:     Ferenc Fejes <fejes@inf.elte.hu>
Cc:     netdev@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200603081124.1627600-1-matthieu.baerts@tessares.net>
 <CAAej5NZZNg+0EbZsa-SrP0S_sOPMqdzgQ9hS8z6DYpQp9G+yhw@mail.gmail.com>
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
Message-ID: <1cb3266c-7c8c-ebe6-0b6e-6d970e0adbd1@tessares.net>
Date:   Wed, 3 Jun 2020 11:12:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <CAAej5NZZNg+0EbZsa-SrP0S_sOPMqdzgQ9hS8z6DYpQp9G+yhw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Ferenc,

On 03/06/2020 10:56, Ferenc Fejes wrote:
> Matthieu Baerts <matthieu.baerts@tessares.net> ezt írta (időpont:
> 2020. jún. 3., Sze, 10:11):
>>
>> A recent commit added new variables only used if CONFIG_NETDEVICES is
>> set.
> 
> Thank you for noticing and fixed this!
> 
>> A simple fix is to only declare these variables if the same
>> condition is valid.
>>
>> Other solutions could be to move the code related to SO_BINDTODEVICE
>> option from _bpf_setsockopt() function to a dedicated one or only
>> declare these variables in the related "case" section.
> 
> Yes thats indeed a cleaner way to approach this. I will prepare a fix for that.

I should have maybe added that I didn't take this approach because in 
the rest of the code, I don't see that variables are declared only in a 
"case" section (no "{" ... "}" after "case") and code is generally not 
moved into a dedicated function in these big switch/cases. But maybe it 
makes sense here because of the #ifdef!
At the end, I took the simple approach because it is for -net.

In other words, I don't know what maintainers would prefer here but I am 
happy to see any another solutions implemented to remove these compiler 
warnings :)

Cheers,
Matt
-- 
Matthieu Baerts | R&D Engineer
matthieu.baerts@tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
