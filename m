Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75E812DF03D
	for <lists+bpf@lfdr.de>; Sat, 19 Dec 2020 16:31:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbgLSPbl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 19 Dec 2020 10:31:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726578AbgLSPbk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 19 Dec 2020 10:31:40 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A406DC0617B0
        for <bpf@vger.kernel.org>; Sat, 19 Dec 2020 07:31:00 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id 143so4986941qke.10
        for <bpf@vger.kernel.org>; Sat, 19 Dec 2020 07:31:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Mnxj/ATKB1MlnwmVSmmqoIzxnVWNw1Scl7Hlo4abUiM=;
        b=D7dkAyOOc5bVta3x8wWCYTWw1buGNRmbtzcYzjYdJWXPolSNZDWMiMVKUfWmfBANIS
         oXrUNye9INjyClpMBL3xQA02Wja2ixQA8BIcdtAcOr/aNFAEnUPl/il9sWaHtk+v17d9
         /oUO3Q0ki25SC6vP8lNzrPtcpT0CzQX/kUEq+FxjDhZnR2HeGocKAXsdHILkjxlCJFZw
         VjfbfhOIuJgCe3ac6fwX4hyh9iMUnAS6nePg3vqvV/iCFlIE7KL6fy49P+nVYQoxsKhs
         Q/DPMRfy0lIaoulhUwr+n2fKpJD6m8utYFo4GmppIOT1a+nuLuvL6wlsmLVdGlfw9CXl
         9FxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Mnxj/ATKB1MlnwmVSmmqoIzxnVWNw1Scl7Hlo4abUiM=;
        b=mnUZ9276gWgOFMaT9G0huFmGc9vewmLm5jFT9w/jEWgWEcPhfoioY+uQa0C86s0XSp
         CuVkQ7E1UYvnGnAKgcgBAn/rHDsj5tOZC0eQdRgfqLI9bfABL3Ab36uOaB6kGoClPHxe
         6ptW5LKf5BoKJ0usqQZ8bKLt8N1RB890IK4AhhlKAi5G6SWfEAYgmJZjTkOePcP8PgLm
         z/fr8MJ3XGK1jNb+Lst6qmGAU6fn/YY+0vtNk7hZEFUwGtRJlAMFLOjYypPApFBTgXW/
         pl00XbaE9V+hweLdwWYyTbuq4N1z4AWe/sToad2TQ5WEStIy55FDWMNUMmofwHhpQEUV
         BWcw==
X-Gm-Message-State: AOAM533zefbrXvLpbcTQirN/YZXAmLr/SlHMUGenqco9lfml08sZShMv
        L3QFw8qOSyUKrspyM8OPXXzpgQ==
X-Google-Smtp-Source: ABdhPJwhOkMU+H59rE17l5pxJhljj5GBsKjG6MoQ59lAlOlhF0nAFXHlWYWPQeeaOFRFDK2I2Et4Bg==
X-Received: by 2002:a37:a110:: with SMTP id k16mr10395520qke.320.1608391859778;
        Sat, 19 Dec 2020 07:30:59 -0800 (PST)
Received: from [192.168.2.48] (bras-base-kntaon1617w-grc-10-184-147-165-106.dsl.bell.ca. [184.147.165.106])
        by smtp.googlemail.com with ESMTPSA id m8sm418094qkh.21.2020.12.19.07.30.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Dec 2020 07:30:58 -0800 (PST)
Subject: Re: [PATCH v5 bpf-next 03/14] xdp: add xdp_shared_info data structure
To:     Shay Agroskin <shayagr@amazon.com>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Cc:     Saeed Mahameed <saeed@kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>, bpf@vger.kernel.org,
        netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
        ast@kernel.org, daniel@iogearbox.net, sameehj@amazon.com,
        john.fastabend@gmail.com, dsahern@kernel.org, brouer@redhat.com,
        echaudro@redhat.com, jasowang@redhat.com
References: <cover.1607349924.git.lorenzo@kernel.org>
 <21d27f233e37b66c9ad4073dd09df5c2904112a4.1607349924.git.lorenzo@kernel.org>
 <5465830698257f18ae474877648f4a9fe2e1eefe.camel@kernel.org>
 <20201208110125.GC36228@lore-desk>
 <pj41zlk0tdq22i.fsf@u68c7b5b1d2d758.ant.amazon.com>
From:   Jamal Hadi Salim <jhs@mojatatu.com>
Message-ID: <1b0a5b59-f7e6-78b3-93bd-2ea35274e783@mojatatu.com>
Date:   Sat, 19 Dec 2020 10:30:57 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <pj41zlk0tdq22i.fsf@u68c7b5b1d2d758.ant.amazon.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 2020-12-19 9:53 a.m., Shay Agroskin wrote:
> 
> Lorenzo Bianconi <lorenzo.bianconi@redhat.com> writes:
> 

>> for the moment I do not know if this area is used for other purposes.
>> Do you think there are other use-cases for it?

Sorry to interject:
Does it make sense to use it to store arbitrary metadata or a scratchpad
in this space? Something equivalent to skb->cb which is lacking in
XDP.

cheers,
jamal
