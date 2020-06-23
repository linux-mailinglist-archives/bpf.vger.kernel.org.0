Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8B05204F7D
	for <lists+bpf@lfdr.de>; Tue, 23 Jun 2020 12:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732189AbgFWKsW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Jun 2020 06:48:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732185AbgFWKsW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 23 Jun 2020 06:48:22 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA044C061573
        for <bpf@vger.kernel.org>; Tue, 23 Jun 2020 03:48:20 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id q15so886775wmj.2
        for <bpf@vger.kernel.org>; Tue, 23 Jun 2020 03:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mhdtHcgDA+JZDHwk11Zqtg5eR9lu4TkLkN0rkJ/Dbv8=;
        b=gWpN6ker49Wrd1bLmEIYzyPJqro14CaJ2iGM6/UtromS/uUEW2O56A1IUb3h3PRuwL
         0qyx8/pHeVLdEspJ61ylr1J556DF7cxSHmA/u8zEXf+mkadPPm87ckezYydPApaT+ABN
         8lGzaiuHrFmp19aE8MkCv38G+D3088ZHYYmpWHcIOt/DiFyNCfPwkMW3M1t84QHRGf4d
         fyIQhC+FTpMSrCBFkU9MAbLB87GrXoNv/wmIts2FdD0T5R4zYXQBMUkK45sKA2jl65Gq
         aXY6IJUGaI2Q9zNGWKoiBQwDGDvAcNAgq7OIRZGAHcBqtuecIn0AZqYs9rJ2jqT+ve3t
         BM/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mhdtHcgDA+JZDHwk11Zqtg5eR9lu4TkLkN0rkJ/Dbv8=;
        b=AiufIy4IL8vu/lU1MaLI0P3mS0llw9aLsMPRpH+IdQscsMnot/H6KkIPYOstKGclCz
         5yuiK0oHrP7hPJdYnbL6kY6E7maQkfQjet7fWxWluHiwuHMzkJ/HDx+IcOeAyDOy2KtX
         bkH4olwIKjomD4eYUciCL/iFhLQSE1WRVbSU9eKmCsbyBeiH/LHbESK9kH3jLVNdIwM/
         bs4MqatQd7iJzbgFfvp5PRn1SN4rEOzmsJC1CVzmMY38fxQAUsoUMP6ZyMClN6cVG3OV
         nh9r6ZLvkL3yII71Ndy/NRNYjvYiHqvVD+q0QYU+60pIlrJeB9IIgunT1/F7a++QkNPR
         2zUA==
X-Gm-Message-State: AOAM533T5zayFstlRoHokBIgJx8wJ4ewgC54g/+xjutqIxNkulfnWaj5
        WYY8cXcGFxOQORNtRTJhWCY2l70dIauPzA==
X-Google-Smtp-Source: ABdhPJxYa2kxw1X5dsVBDZLXJwOJJ6luuTethH9KO6266RpUDkLEfw9+Fi/n29/3Q6krmYHWpOGQsg==
X-Received: by 2002:a1c:24c6:: with SMTP id k189mr24557959wmk.9.1592909299169;
        Tue, 23 Jun 2020 03:48:19 -0700 (PDT)
Received: from [192.168.1.12] ([194.53.184.63])
        by smtp.gmail.com with ESMTPSA id v4sm6953871wro.26.2020.06.23.03.48.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jun 2020 03:48:18 -0700 (PDT)
Subject: Re: [PATCH bpf-next v2 2/2] tools, bpftool: Define attach_type_name
 array only once
To:     Tobias Klauser <tklauser@distanz.ch>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     Andrii Nakryiko <andriin@fb.com>, bpf@vger.kernel.org
References: <20200623104227.11435-1-tklauser@distanz.ch>
 <20200623104227.11435-3-tklauser@distanz.ch>
From:   Quentin Monnet <quentin@isovalent.com>
Message-ID: <edecefe8-7881-fac6-79f0-bc9c3b37163b@isovalent.com>
Date:   Tue, 23 Jun 2020 11:48:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200623104227.11435-3-tklauser@distanz.ch>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

2020-06-23 12:42 UTC+0200 ~ Tobias Klauser <tklauser@distanz.ch>
> Define attach_type_name in common.c instead of main.h so it is only
> defined once. This leads to a slight decrease in the binary size of
> bpftool.
> 
> Before:
> 
>    text	   data	    bss	    dec	    hex	filename
>  399024	  11168	1573160	1983352	 1e4378	bpftool
> 
> After:
> 
>    text	   data	    bss	    dec	    hex	filename
>  398256	  10880	1573160	1982296	 1e3f58	bpftool
> 
> Signed-off-by: Tobias Klauser <tklauser@distanz.ch>

Reviewed-by: Quentin Monnet <quentin@isovalent.com>
