Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18650D3CE0
	for <lists+bpf@lfdr.de>; Fri, 11 Oct 2019 11:57:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727641AbfJKJ5W (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Oct 2019 05:57:22 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35996 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727352AbfJKJ5W (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Oct 2019 05:57:22 -0400
Received: by mail-lj1-f194.google.com with SMTP id v24so9216645ljj.3
        for <bpf@vger.kernel.org>; Fri, 11 Oct 2019 02:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hp51ftF0fMacTdMbbRNDwAHtYKpjRZUEYNDQ5ofyyAk=;
        b=UAFeseSzu034KHnL5iKmG61KtCqRuzg7Hd56VJAIxJ1CI96wrcWVEJ7JKKKS2hLbdm
         N+KWkvUlhRW7lsOVGESl7+nBmGQ3CmSvM0sIMR0nr6Jc7oSuPHjAE10DG2RJlqCPQgGY
         c9Sv5GnzYsVLbQnePHapb9ck+2IDjD/HD7b3zVpUZZf2wMqYBVStjUh/A8xyk+rx4SeU
         E8/X1zyU3UIgjiOVuw7HfaKs66VxcSuF4UZ7dyU2d5WH2YdMpOKzj94ImY+DGk7XFl02
         0NNqakT+4pD1QvhBoIgYlWEjOYSRBbXHaA5EvcD4p86jI9vmT6LBKD5tlKW+YnnB/uJr
         l31g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=hp51ftF0fMacTdMbbRNDwAHtYKpjRZUEYNDQ5ofyyAk=;
        b=il73zjpLNvZ2ah0nHe+v/KUx1YBnxdI35eZBx1hbMoEnnM2PW0I8tCs3Y5EMDVWePE
         VJZO8V1TbnZlo0yj1VWtv1YsfGGn5KceaoTTTYqgUiG/5XNvbIvMFDu3ByK3loP+CcvM
         M+X0X4i45bXycL0UvzXguNZuQJ9xLbPMjqqx7lIhiFXkqSsioJ4M3NqVTpqy6+aW+Xe5
         xry2Eeyg/D3TqO4/Ai8BD3KSxKYAuk8kuQuEBn9Z86/Y8b7T6PwtFCYn2CU8nl8uDPmy
         eUj7pwkuJIm+9kaqIIVo5zMUcmPM5uVrAnijxZv0ALhCRtSfQbLew+0KUNqEbgluc//1
         tXwg==
X-Gm-Message-State: APjAAAX6fZJnq95lsk3FdKC+XHJiUErFTw00F799XNPzHmKO5arlJGvE
        Y/2m/UWNmkV10VePijVRzKCbaw==
X-Google-Smtp-Source: APXvYqy1TBg1gVB8cIRIr7goBTo+5pg79WWTsnlzh7n433Dq6RXlNFoeA9ldACb5LDRrkUv0+sWAZg==
X-Received: by 2002:a2e:3919:: with SMTP id g25mr8650919lja.162.1570787839244;
        Fri, 11 Oct 2019 02:57:19 -0700 (PDT)
Received: from khorivan (88-201-94-178.pool.ukrtel.net. [178.94.201.88])
        by smtp.gmail.com with ESMTPSA id m17sm2384718lje.0.2019.10.11.02.57.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 11 Oct 2019 02:57:18 -0700 (PDT)
Date:   Fri, 11 Oct 2019 12:57:16 +0300
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, yhs@fb.com,
        davem@davemloft.net, jakub.kicinski@netronome.com, hawk@kernel.org,
        john.fastabend@gmail.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        clang-built-linux@googlegroups.com, ilias.apalodimas@linaro.org
Subject: Re: [PATCH v5 bpf-next 09/15] samples/bpf: use own flags but not
 HOSTCFLAGS
Message-ID: <20191011095715.GB3689@khorivan>
Mail-Followup-To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        ast@kernel.org, daniel@iogearbox.net, yhs@fb.com,
        davem@davemloft.net, jakub.kicinski@netronome.com, hawk@kernel.org,
        john.fastabend@gmail.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        clang-built-linux@googlegroups.com, ilias.apalodimas@linaro.org
References: <20191011002808.28206-1-ivan.khoronzhuk@linaro.org>
 <20191011002808.28206-10-ivan.khoronzhuk@linaro.org>
 <99f76e2f-ed76-77e0-a470-36ae07567111@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <99f76e2f-ed76-77e0-a470-36ae07567111@cogentembedded.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Oct 11, 2019 at 11:49:38AM +0300, Sergei Shtylyov wrote:
>   More grammar nitpicking...
>
>On 11.10.2019 3:28, Ivan Khoronzhuk wrote:
>
>>While compiling natively, the host's cflags and ldflags are equal to
>>ones used from HOSTCFLAGS and HOSTLDFLAGS. When cross compiling it
>>should have own, used for target arch. While verification, for arm,
>
>   While verifying.
While verification stage.

>
>>arm64 and x86_64 the following flags were used always:
>>
>>-Wall -O2
>>-fomit-frame-pointer
>>-Wmissing-prototypes
>>-Wstrict-prototypes
>>
>>So, add them as they were verified and used before adding
>>Makefile.target and lets omit "-fomit-frame-pointer" as were proposed
>>while review, as no sense in such optimization for samples.
>>
>>Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
>[...]
>
>MBR, Sergei

-- 
Regards,
Ivan Khoronzhuk
