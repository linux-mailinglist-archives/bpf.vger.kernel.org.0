Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B70F20397A
	for <lists+bpf@lfdr.de>; Mon, 22 Jun 2020 16:28:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729225AbgFVO2d (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 22 Jun 2020 10:28:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729338AbgFVO0V (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 22 Jun 2020 10:26:21 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CFF1C061573
        for <bpf@vger.kernel.org>; Mon, 22 Jun 2020 07:26:20 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id q5so4501384wru.6
        for <bpf@vger.kernel.org>; Mon, 22 Jun 2020 07:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SC9NyUPzOocB4cjC1PTU0uqZzmkhiIRhyyawK68L7Y8=;
        b=aCzWvFBVF26nTcUCWTeCZ8SOUwg9kFgobyD+ddR4ZkKK5lUv0QhLxM7SaIk4shrIGn
         qMzCEcX3pTqLgrVFhzKOPH5m8GeT+75tWO+nJ/mJMn6CxXzKrr3rRsBETh1j3+7/VWRz
         yhfMic/b1W3VGG9o0+9+L+Gg41RlR4t4MHQATiiGXepeK6OlTjDgxYHGi3/JpIy7qZKE
         loO1JQWxC87ECOnUmxhOLcBytrQyRwNVIQ7HHfN9pVQAGC6tmq7Cem9PLWxq2ujIPMSF
         G3uRFhYoZbexA+VzogKsZYzI/DWbukBaITRKy8ZCDz+SzxTGHvOR8la+aa5PMCQQnOV1
         JN/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SC9NyUPzOocB4cjC1PTU0uqZzmkhiIRhyyawK68L7Y8=;
        b=qMrN2Q9kYcgrXDekpQWdy88iOqvzrp4ZWr37qrVlNPVJHGUYzOlxavMMW7msF0EgcK
         wn0/csTWCCDRp3j3SXxUCsOtNcBtQ/zCYNz5WwmAChlhkQaQ+uPLOS265KBRHj20XmjI
         XsDwVdijDiNcEzi1I3kgM45n1AMhl013FJVnDp7fCdUzGtfW9TWMM3EWml7e75keB4Me
         49BiruGRMBQFvowZgS0GNbSIehG6SR5VjG5Z8gA7Tj82dveH0GRg/wEjq1/b0Zh99TTS
         d0Qt1k/5r7RkM30SfmsjculEFQEUiP6KjgSa2bo/ybTXBEt+NZoLiiIql5hCcWLlVJTm
         ITYw==
X-Gm-Message-State: AOAM5332NGT5NwOKqw3K6Zu4JATYgAp4j7rzauEb4NUHquuO/pl9TMsu
        OPNlo9bLmGlx+wvxrg2Bjh5+3cDCU7SaSw==
X-Google-Smtp-Source: ABdhPJx+u4OFQLIf/m2+kj3a5NW4H2jroKfMl+5cCNsBfCavxsPouKKvAdizmcsefNlDObBjeyGq+g==
X-Received: by 2002:adf:8501:: with SMTP id 1mr21141128wrh.153.1592835978794;
        Mon, 22 Jun 2020 07:26:18 -0700 (PDT)
Received: from [192.168.1.12] ([194.53.184.63])
        by smtp.gmail.com with ESMTPSA id y16sm18557108wro.71.2020.06.22.07.26.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jun 2020 07:26:18 -0700 (PDT)
Subject: Re: [PATCH bpf-next 1/2] tools, bpftool: Define prog_type_name array
 only once
To:     Tobias Klauser <tklauser@distanz.ch>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     Andrii Nakryiko <andriin@fb.com>, bpf@vger.kernel.org
References: <20200622140007.4922-1-tklauser@distanz.ch>
 <20200622140007.4922-2-tklauser@distanz.ch>
From:   Quentin Monnet <quentin@isovalent.com>
Message-ID: <c961c0ee-424a-6f3b-942e-42fdc7ee9b95@isovalent.com>
Date:   Mon, 22 Jun 2020 15:26:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200622140007.4922-2-tklauser@distanz.ch>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

2020-06-22 16:00 UTC+0200 ~ Tobias Klauser <tklauser@distanz.ch>
> Follow the same approach as for map_type_name. This leads to a slight

map_type_name looks unchanged in this series, could you please check
your commit log?

> decrease in the binary size of bpftool.
> 
> Before:
> 
>    text	   data	    bss	    dec	    hex	filename
>  401032	  11936	1573160	1986128	 1e4e50	bpftool
> 
> After:
> 
>    text	   data	    bss	    dec	    hex	filename
>  399024	  11168	1573160	1983352	 1e4378	bpftool
> 
> Signed-off-by: Tobias Klauser <tklauser@distanz.ch>

Reviewed-by: Quentin Monnet <quentin@isovalent.com>

Code looks good otherwise, thanks!
Quentin
