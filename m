Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BCAEFD3CD4
	for <lists+bpf@lfdr.de>; Fri, 11 Oct 2019 11:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727514AbfJKJ40 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Oct 2019 05:56:26 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:40473 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726585AbfJKJ4Z (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Oct 2019 05:56:25 -0400
Received: by mail-lf1-f68.google.com with SMTP id d17so6601963lfa.7
        for <bpf@vger.kernel.org>; Fri, 11 Oct 2019 02:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pWOkKXMMhlTx5AzJ2yss3zoDHNMcN+4G3JZ21wCHuz0=;
        b=KLkB1k+sZZvbTV8NTZTJ53VPzlRq+/OYW6/swdyx+bm1KkP5JJCwJt4FSMYP7nZTcN
         5cuHjBHfgws2ptAiAj5APks1aFl5032jhnf+0j7jRRRsBJAIQ9FIkdbpTNFpwoXYmEVC
         4pRgACHxmK2hiMYC2tchxAfBT1Rc3U99tB7e0V4pyvzq7G4IBD1XDloEOSrRO6Fsfmjk
         c8FPcrwk9T1bxc4+3ogtxdIDmPXdJs8mfciD53Cxypy8ifd6n+yQ+R67H8ClX14B0MBW
         0bwcfrDwPs5eZRE8ym7bT9RYZYsLmp+o3SicveJCfsFZDvdvg5Uw/qClPLwYZA+8SCUW
         TtWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=pWOkKXMMhlTx5AzJ2yss3zoDHNMcN+4G3JZ21wCHuz0=;
        b=qDZO0+MNlMvv/jBF+DJQLVHQb6xtOW1feD3x8+CRG9/aifcSftJIzltipNDZqcGIY3
         7MMbANN/qHK1PWS15UkP7ZRzyjJQtnO3dGlG0orQqTlxDFv18vkXLcECg2PcSxYbZMtq
         jkETUuKi2YqEqR5hE9jWAUt4pdAmikFotPcN03NtbgAF0ADSd9VUrt/Fg/l/wsVvMVA5
         C8LuF9OansCR/U5vAeIxRdICWsHljVrzJMPW2xhUWR1D25YNSbEO85y9SZytdaL/TFdp
         5Vtbf1PNRLG4R2FzfaG6rx6vXlEr1XKt8EOCCcGnMkEW91XEitEcWMbZgyfdjWEINoVu
         SU9w==
X-Gm-Message-State: APjAAAWraJpYYQnBgBvPvUMmhQXChx4WlHHQrzHmX+zvcNZcqsAS1UTz
        33Wkp9ecSLBAOAYlAD4gZhWoZg==
X-Google-Smtp-Source: APXvYqxoUkQ1diZUv2vTQTPwqixqbfFJac3hH+dUfd7mp6Vs56IdYApGFTMbwT8nD3apWn/BWRjj4Q==
X-Received: by 2002:a19:2287:: with SMTP id i129mr8197729lfi.43.1570787783666;
        Fri, 11 Oct 2019 02:56:23 -0700 (PDT)
Received: from khorivan (88-201-94-178.pool.ukrtel.net. [178.94.201.88])
        by smtp.gmail.com with ESMTPSA id v1sm1836900lji.89.2019.10.11.02.56.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 11 Oct 2019 02:56:23 -0700 (PDT)
Date:   Fri, 11 Oct 2019 12:56:20 +0300
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, yhs@fb.com,
        davem@davemloft.net, jakub.kicinski@netronome.com, hawk@kernel.org,
        john.fastabend@gmail.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        clang-built-linux@googlegroups.com, ilias.apalodimas@linaro.org
Subject: Re: [PATCH v5 bpf-next 05/15] samples/bpf: use __LINUX_ARM_ARCH__
 selector for arm
Message-ID: <20191011095619.GA3689@khorivan>
Mail-Followup-To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        ast@kernel.org, daniel@iogearbox.net, yhs@fb.com,
        davem@davemloft.net, jakub.kicinski@netronome.com, hawk@kernel.org,
        john.fastabend@gmail.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        clang-built-linux@googlegroups.com, ilias.apalodimas@linaro.org
References: <20191011002808.28206-1-ivan.khoronzhuk@linaro.org>
 <20191011002808.28206-6-ivan.khoronzhuk@linaro.org>
 <fa252372-b518-213c-b6f1-60520831e677@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <fa252372-b518-213c-b6f1-60520831e677@cogentembedded.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Oct 11, 2019 at 11:46:54AM +0300, Sergei Shtylyov wrote:
>Hello!
>
>   Sorry, didn't comment on v4...
>
>On 11.10.2019 3:27, Ivan Khoronzhuk wrote:
>
>>For arm, -D__LINUX_ARM_ARCH__=X is min version used as instruction
>>set selector and is absolutely required while parsing some parts of
>>headers. It's present in KBUILD_CFLAGS but not in autoconf.h, so let's
>>retrieve it from and add to programs cflags. In another case errors
>
>   From where? And it's program's, no?
from KBUIL_CFLAGS. it's programs.

>
>>like "SMP is not supported" for armv7 and bunch of other errors are
>>issued resulting to incorrect final object.
>>
>>Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
>[...]
>
>MBR, Sergei

-- 
Regards,
Ivan Khoronzhuk
