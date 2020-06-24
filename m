Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 997432075EA
	for <lists+bpf@lfdr.de>; Wed, 24 Jun 2020 16:42:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390423AbgFXOmj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Jun 2020 10:42:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389836AbgFXOmj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Jun 2020 10:42:39 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B0B4C061573
        for <bpf@vger.kernel.org>; Wed, 24 Jun 2020 07:42:39 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id l2so1299906wmf.0
        for <bpf@vger.kernel.org>; Wed, 24 Jun 2020 07:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=iAEHHwMrscIWMwLBQnaOeXe50PWMSaYe8y+aPo1L5UE=;
        b=alq3xU+aBZE+m295YkBSs9z1pYc6MBLCTyeam5hy92qrG/uF43yj2xx3e4kI3ggTNn
         /BFzNGAWqb3qmmUkSEFOSe8xyH+7pdIVkoZbSsewl2ynSdLLr8z5AB6BVwN6FYYAVPfR
         vEaoXWkJaoTtFSlGcFglJrNVuVuri63CpYGFr7nymxx9yLJCx2qqL4eEjaQ+5Gw6rq3B
         KiophX/mMQYJrVi9lZYUjytXANoRlsPalhxgNwS09k4Wcr20vgLuFejVrCkymAYVnieY
         zZixlyGdUMlDtv6ujsNHPxoc7oL2kDcDpge9oV6+vS5AdkXQypcuQ8M9GJ7+qrI6U5Vy
         6gfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iAEHHwMrscIWMwLBQnaOeXe50PWMSaYe8y+aPo1L5UE=;
        b=mXBbFZqntKA1PxwkqstaDHPqbQwu7E1HmUb4M40rDdRcjcE5ZEl0pIcX7b1F/Br6e2
         uAUQuX5JA43up9dYhdTuLb7xcaUAbWWhsgE69zO1O0ZxIoSKriFHp3a5m9zBat1Eryde
         lQpirfV7R6pzuvcGMgKBOzLKlUG7WDrz0D9WepJudDwEWE8YFDEkQcUwpXqYInGse9+Y
         sk+7tmiwVztPz2FDwdwdm9hS+jVgYc2Qtp3P+5qzv+BzI557AoDuR4J41RUWoiAnMuCL
         ABAbej15oV4Auc/oSAZlO1/0tN99GphgzVr3ynqXXc59oTXjcH/sFGrUkzo7cwVkSDsw
         bfDg==
X-Gm-Message-State: AOAM5317H3kvUj5uDpkhx1OKwboX/w+DJb4OGH/H2JP6eutVshb3BmTM
        TLFbEYhXPl6pPMU7ClxbVHNNNR9r10+xig==
X-Google-Smtp-Source: ABdhPJzDlpofBeKJOsFqbPeR91C9T0+rmM//9JTWSonvS7OUoymAPqof1qszBAnPPihxZwSL04MVgg==
X-Received: by 2002:a1c:3c82:: with SMTP id j124mr7513415wma.155.1593009757444;
        Wed, 24 Jun 2020 07:42:37 -0700 (PDT)
Received: from [192.168.1.12] ([194.53.184.63])
        by smtp.gmail.com with ESMTPSA id m1sm2440393wrv.37.2020.06.24.07.42.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jun 2020 07:42:37 -0700 (PDT)
Subject: Re: [PATCH bpf-next v3 2/2] tools, bpftool: Define attach_type_name
 array only once
To:     Tobias Klauser <tklauser@distanz.ch>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     Andrii Nakryiko <andriin@fb.com>, bpf@vger.kernel.org
References: <20200623104227.11435-3-tklauser@distanz.ch>
 <20200624143154.13145-1-tklauser@distanz.ch>
From:   Quentin Monnet <quentin@isovalent.com>
Message-ID: <fa41804a-faf1-8347-ea8b-89d92b87efbb@isovalent.com>
Date:   Wed, 24 Jun 2020 15:42:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200624143154.13145-1-tklauser@distanz.ch>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

2020-06-24 16:31 UTC+0200 ~ Tobias Klauser <tklauser@distanz.ch>
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

(You can keep the tag for minor changes.)
