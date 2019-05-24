Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E541429791
	for <lists+bpf@lfdr.de>; Fri, 24 May 2019 13:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391283AbfEXLvR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 May 2019 07:51:17 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39127 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391094AbfEXLvR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 May 2019 07:51:17 -0400
Received: by mail-wr1-f68.google.com with SMTP id e2so944047wrv.6
        for <bpf@vger.kernel.org>; Fri, 24 May 2019 04:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Z55WK/oPwd9mPimbdcgpghgALzM9VWN0sugdmx7rL68=;
        b=XJNx03ZzqbtONGJ1HTrjpK73dQuYjMqqx/A1svMfOd1mH4KkJ3K32+lswozQ0nzu5C
         85yCENGdDNatTpYzntcyyB1shsHr9x0SbUAZfF09nK3FTdUeGyf887+gNwtQ7/iHiMWE
         h8mm1wsKMXoio+TBNv6anz0T5D2/GfY+5kPlmkNXN415SfCWrSzWtGWs6ayACsSwYs1Q
         hHrYP42mpWNHFTF+5MAb3cm+YQqLg4Xlt3jLdr7TvrzYYj/Ws13uWe5v7rzaNBTmCMqm
         tmc/jfJayRy+NRncUNVd2DMGa75gfAc3CZca55C6zMnCZMdT012+XyiCIAsJRlNuEl3w
         aN9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Z55WK/oPwd9mPimbdcgpghgALzM9VWN0sugdmx7rL68=;
        b=Rp5ervJ43iSzdfUXSycJ8EAcT9G+NoVjeSayt39lInrMQ8OHuTjxMt+7JoGVrkI/LX
         RsUNwY1vLO/B1GXVubaWAF4bPVPvRHicWpFN+2oK4h/KCvVsYklrJ/eBvfzdYJXr3Bze
         +Q4f9G7t9yamXX+gI1c2+OlJD0nqWPGXfMLxoUs7HSNWEMwAAphxdvjezzV7/WG/PYbV
         o2QQVs9XGoqr7TB/3q/cH4nJMZ7/Qu3JG28HPmPC9AuZeTyBYxUSTkvJ6ftUil4uhsbg
         NvfRlvdb5/8K9/5obwg9ZVCExYoCRa+sxgRA/68NaWOYCpUZ1dpCQRGcCmptbeV8WB3d
         YefQ==
X-Gm-Message-State: APjAAAXtsPH4MPd8pgqczHwMM7WulOcb5iZaJgwjsjfmM0m40sTXHFW2
        QRLjKrXigipKH3Okkx0EYTyO5g==
X-Google-Smtp-Source: APXvYqw1DaPUskh7T3+Kx7b22gma+SZ7Oe+u4o5JZDevtLKEzxEsyw09zAxKnVGF4HCcYqVm+GvomA==
X-Received: by 2002:a5d:688f:: with SMTP id h15mr4164436wru.44.1558698675248;
        Fri, 24 May 2019 04:51:15 -0700 (PDT)
Received: from [192.168.1.2] ([194.53.186.20])
        by smtp.gmail.com with ESMTPSA id n15sm1896539wru.67.2019.05.24.04.51.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 04:51:14 -0700 (PDT)
Subject: Re: [PATCH bpf-next v3 2/3] libbpf: add bpf_object__load_xattr() API
 function to pass log_level
To:     Jesper Dangaard Brouer <brouer@redhat.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org,
        netdev@vger.kernel.org, oss-drivers@netronome.com,
        Yonghong Song <yhs@fb.com>, Andrii Nakryiko <andriin@fb.com>
References: <20190524103648.15669-1-quentin.monnet@netronome.com>
 <20190524103648.15669-3-quentin.monnet@netronome.com>
 <20190524132215.4113ff08@carbon>
From:   Quentin Monnet <quentin.monnet@netronome.com>
Message-ID: <5895821e-0d79-2169-d631-0fa7560135ec@netronome.com>
Date:   Fri, 24 May 2019 12:51:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190524132215.4113ff08@carbon>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

2019-05-24 13:22 UTC+0200 ~ Jesper Dangaard Brouer <brouer@redhat.com>
> On Fri, 24 May 2019 11:36:47 +0100
> Quentin Monnet <quentin.monnet@netronome.com> wrote:
> 
>> libbpf was recently made aware of the log_level attribute for programs,
>> used to specify the level of information expected to be dumped by the
>> verifier. Function bpf_prog_load_xattr() got support for this log_level
>> parameter.
>>
>> But some applications using libbpf rely on another function to load
>> programs, bpf_object__load(), which does accept any parameter for log
>> level. Create an API function based on bpf_object__load(), but accepting
>> an "attr" object as a parameter. Then add a log_level field to that
>> object, so that applications calling the new bpf_object__load_xattr()
>> can pick the desired log level.
> 
> Does this allow us to extend struct bpf_object_load_attr later?

I see no reason why it could not. Having the _xattr() version of the
function is precisely a way to have something extensible in the future,
without having to create additional API functions each time we want to
pass a new parameter. And e.g. struct bpf_prog_load_attr (used with
bpf_prog_load_xattr()) has already been extended in the past. So, yeah,
we can add to it in the future. Do you have something in mind?

Quentin
