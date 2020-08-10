Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FEDE2402E3
	for <lists+bpf@lfdr.de>; Mon, 10 Aug 2020 09:39:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726052AbgHJHjr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 10 Aug 2020 03:39:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725857AbgHJHjq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 10 Aug 2020 03:39:46 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 074C9C061756
        for <bpf@vger.kernel.org>; Mon, 10 Aug 2020 00:39:46 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id qc22so8368147ejb.4
        for <bpf@vger.kernel.org>; Mon, 10 Aug 2020 00:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7JHvh560snglUl+Ikc2N3nn+JCLGXQhIDT3QWYlxG1Y=;
        b=i9L8zKpOrcQHhTWC2MfF/5BYJENRFIizVbUMAiBse4zxH9d8FFA9SamIxaTG5dV0eo
         qIBFHLfiR5UpTVcHnd9heXqctbpKo2mPwti6g8TMTu47gR9MipaZ4kLWF8oYREMa0ecn
         1zXqibzz5dQNxC2t1ovQNloNQAZCq3vPcXmuC+iiHhPeIV7JrpeVYlqMZFawmlRLFLM3
         gPM4oAVj2ozQ8CM34qt67CTJLWccnLg3MdYq+jsEr0XIis2JmYsBnOrgJnqbIGAw1H0m
         I3PZioJvwa26DbsP3u3wcWE6b7v/ZO7VSyG7+7lQD9SSb6yE5AgW9HPGdnESPBYdfmR2
         qlwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7JHvh560snglUl+Ikc2N3nn+JCLGXQhIDT3QWYlxG1Y=;
        b=kze3edf6n1qFtrD8KXSB2uhbwDNvHi8NBud/MFthN9QpEEYPvEcitRC1IYzOaARax+
         Jj98Knm/BqiHwEFJSt19bAez+sgjSz/31ebHFhk1NKrHMhgZbwfMr/mwHZR+pqnfX0D1
         Gzp0hwPdNF+dfPYsG7XYMplH2oFa+/ZCgMnLCM2MMi9J1UIlaRcsSMH3oejIN0LgpZid
         Ci7+BCy5A3XQKJDX0I64L4TAepH74dh8X2nDNvjg2IqQs9Oh8YUTLDCsTe1UEH+MMjVR
         8DT3BNXvA1Yxm6TANGErDWdFmynS1GqbEe9GdQqN1P9o4b5qxt7McCZPo2zfl7svfMw4
         2Fqg==
X-Gm-Message-State: AOAM532kYv81KDCv5eIofEUoFc1U242vzZLcMygj+YWfbaOtI0kELUEm
        +DAN/XVocRycblSBlcNjZOe579eHwkA=
X-Google-Smtp-Source: ABdhPJzKZWG2ZnCCOeUKWFhqdZHLu9lOl8kBAG7Jv37LGbzsbqYp/a+XcDw9vrzC4P2MJecH0x88oA==
X-Received: by 2002:a17:906:403:: with SMTP id d3mr20045601eja.522.1597045184787;
        Mon, 10 Aug 2020 00:39:44 -0700 (PDT)
Received: from [192.168.0.28] ([188.252.226.35])
        by smtp.gmail.com with ESMTPSA id f21sm11749461edv.66.2020.08.10.00.39.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Aug 2020 00:39:44 -0700 (PDT)
Subject: Re: eBPF CO-RE cross-compilation for 32-bit ARM platforms
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     bpf@vger.kernel.org, Andrii Nakryiko <andriin@fb.com>,
        Juraj Vijtiuk <juraj.vijtiuk@sartura.hr>,
        Jakov Smolic <jakov.smolic@sartura.hr>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Luka Perkov <luka.perkov@sartura.hr>,
        linux-arm-kernel@lists.infradead.org
References: <f1b8e140-bc41-4e56-e73f-db11062dddbd@sartura.hr>
 <20200807172353.GA624812@myrica>
From:   Jakov Petrina <jakov.petrina@sartura.hr>
Message-ID: <baf4e73d-e2ab-0e95-4e69-ac7b1a8180c1@sartura.hr>
Date:   Mon, 10 Aug 2020 09:39:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200807172353.GA624812@myrica>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

On 07/08/2020 19:23, Jean-Philippe Brucker wrote:
> Hi,
> 
> [Adding the linux-arm-kernel list on Cc]
> 
> 
> It looks like this "__Poly8_t" type is internal to GCC (provided in
> arm_neon.h) and clang has its own internals. I managed to reproduce this
> with an arm64 allyesconfig kernel (+BTF), but don't know how to fix it at
> the moment. Maybe libbpf should generate defines to translate these
> intrinsics between clang and gcc? Not very elegant. I'll take another
> look next week.
> 

indeed, this has only been present in our arm64 kernel builds but I 
suppose it may surface for different configurations as well. Per 
Andrii's suggestion, I think blacklisting such types during the dump 
would be a safe bet for now.

> 
> I don't know if there is a room for improvement regarding your a) and b)
> points, as I think the added complexity is inherent to cross-building. But
> kernel crashes definitely need to be fixed, as well as the above problem.
> 

If that is the case, I suppose an additional step would be to configure 
the kernel in such a way so that the generated header files result in 
the smallest possible file size, while retaining all structures that we 
require in our eBPF programs.

The kernel crash seems to elude our attempts to reproduce it; it occurs 
only on a target 32-bit platform device, but a reproducible program does 
not crash the kernel in a QEMU ARM environment. When we investigate this 
further we will definitely share our results.

> Thanks,
> Jean
> 

Thanks,
-- 
Jakov Petrina
