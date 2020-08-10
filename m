Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10D852402FE
	for <lists+bpf@lfdr.de>; Mon, 10 Aug 2020 09:52:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726259AbgHJHwV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 10 Aug 2020 03:52:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbgHJHwU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 10 Aug 2020 03:52:20 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E498C061756
        for <bpf@vger.kernel.org>; Mon, 10 Aug 2020 00:52:20 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id g19so8373475ejc.9
        for <bpf@vger.kernel.org>; Mon, 10 Aug 2020 00:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mOLNCKAgf0JJa/QRFanz6mOEwhugWQW3Cryp1lys0jk=;
        b=AMvxan9fZwFVaGfDJPLjLUdlenu1mAKb7R0Gcn8pWTtQz1wjG1paxCg+EUuUASEw56
         qJrOMi0k+GvCQIhww6jrpdotxLnPfGY6dMFyb5LwIZFYHfTJvfJn4VraCoxSs8HauTad
         BsTnCNcpNDn1xLIzeaDAxevmAhFxZki0A9sfdJhXXvkzsrbNI0f4ZD8zJv/XUQHSUjBJ
         QaM8irUiTiGQ7cSA5oUgHCO9zrT+zUlMtKbk0kWj+54on81RvQN4n9Mm0jOqZ6O7eB53
         0RomaPsC8qfy8/Bj7EnqO0g9PtHPuGETM3FK8u5JCFhMvNYSWmAIUO9cXpbv/HT/FXMM
         ew/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mOLNCKAgf0JJa/QRFanz6mOEwhugWQW3Cryp1lys0jk=;
        b=XGsLny7rbLVUFTWcMfuxGuSXmhrjn4xez2It12ZeyVMSbZJDRxL6C6zvr2PM8Yc8zJ
         sEJTrRDMyLB/nJgBdoBap1JO3y1JL7OcG16eQLAStXg9C+jtGdl7nZF0Fxun/2LyMgaQ
         sWawPCJBmQ4o3GuQm9nybjg0hveoBz4xg6esPIvf2f1gBJToQjBCGpJb0II+xArmK9NL
         OpgGBaRn19tOL/3usVZLYmNjQ975mMhx+b8IiUlNlwcCmwbPJa5PxUvpnAs+6A+Z9BTf
         eYk2an6D2IQbKjDbBbpIfc2ql2VFzMYZwXesVCdQwWhSXgI4p22HncUrYJEcbV/GlZcM
         /3Sg==
X-Gm-Message-State: AOAM530fh8O+C3i+27u4U/QUG1YM3oZpCBJgNeQVsZJSEKbssYBAUgIb
        fHwSkwgXkcDiVMByFjl8c9+nvg==
X-Google-Smtp-Source: ABdhPJxmRSbh6uIhTAgd1XYu7t4xak3WdUEo70c/t2APyOt53PJ1jad+rvPyIWDAdr8dvG4kMFYpTg==
X-Received: by 2002:a17:906:c7d4:: with SMTP id dc20mr21585460ejb.283.1597045939142;
        Mon, 10 Aug 2020 00:52:19 -0700 (PDT)
Received: from [192.168.0.28] ([188.252.226.35])
        by smtp.gmail.com with ESMTPSA id of19sm6683329ejb.3.2020.08.10.00.52.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Aug 2020 00:52:18 -0700 (PDT)
Subject: Re: eBPF CO-RE cross-compilation for 32-bit ARM platforms
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     Luka Perkov <luka.perkov@sartura.hr>,
        Juraj Vijtiuk <juraj.vijtiuk@sartura.hr>,
        Jakov Smolic <jakov.smolic@sartura.hr>, bpf@vger.kernel.org,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Andrii Nakryiko <andriin@fb.com>,
        linux-arm-kernel@lists.infradead.org
References: <f1b8e140-bc41-4e56-e73f-db11062dddbd@sartura.hr>
 <20200807172353.GA624812@myrica>
 <20200807190029.GI1551@shell.armlinux.org.uk>
From:   Jakov Petrina <jakov.petrina@sartura.hr>
Message-ID: <6872df6c-c541-5b35-a07d-77b2862c5333@sartura.hr>
Date:   Mon, 10 Aug 2020 09:52:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200807190029.GI1551@shell.armlinux.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

On 07/08/2020 21:00, Russell King - ARM Linux admin wrote:
> 
> For those of us not familiar with what CO-RE is, this doesn't help.
> I assume the [0] was a reference to something that explained it,
> but that isn't included.
> 

the reference [0] is link to a blog post which explains the eBPF CO-RE 
concept; I have added this link as a reference below.

> 
> What is "BTF information"?  Google suggests it's something to do with
> the British Thyroid Foundation.
> 
> Please don't use three letter abbreviations unless they are widely
> understood, or if you wish to, please ensure that you explain them.
> TLAs otherwise are an exclusion mechanism.
> >
> What is this "vmlinux.h" ?  It isn't something that the kernel provides
> afaics.  It doesn't seem to be present on my existing x86 Debian system.
> I've seen it on Fedora systems in the dim and distant past.
> 
> Where do you think it comes from?  Where are you finding it?
> 

The blog post [0] provides description and context for the references 
and abbreviations used, but in the future I will be sure to avoid using 
abbreviations unless they are commonly understood.

[0] 
https://facebookmicrosites.github.io/bpf/blog/2020/02/19/bpf-portability-and-co-re.html

Regards,
-- 
Jakov Petrina
