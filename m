Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48A0538C57A
	for <lists+bpf@lfdr.de>; Fri, 21 May 2021 13:12:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234157AbhEULNy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 May 2021 07:13:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233569AbhEULNy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 May 2021 07:13:54 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35C66C061574;
        Fri, 21 May 2021 04:12:30 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id f75-20020a1c1f4e0000b0290171001e7329so6934084wmf.1;
        Fri, 21 May 2021 04:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=n8fWTjwngjiSk3H/kdYOG+eQP4cKieGjb3pqjd4aMnE=;
        b=E4wn+gV8v4Ko1F8GmJsyTwtr9xh66WZDX+5D97cv7T+0Bk0FyKNuk/JswU24XlIN7K
         0cE/fqPFFoeHfylUkHqBz12yvUzU6rbFzEE1zk73/+rEiY0y5xtNlGM2vduWe9eqIcJH
         oXK6zaPNT4HZ4PhzhqUm9WBLtgOFq6ocgeMrr8ObNhiXekdtfmRLfl/dmOPNlIr3fidT
         WVsqEdxSZvVAx/Wa7clHCP4peXhw+0jD09l8D8tN4hnbhEL8ECq2V0iyMfFNfXKxWt1c
         HN1ImVpkSZmO9LqTPZUb+DgeXTelzCFiRpQl9A9PCyHEOcklN7Wf4pDnN/IgnuUIR70A
         MEfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=n8fWTjwngjiSk3H/kdYOG+eQP4cKieGjb3pqjd4aMnE=;
        b=OO2w8H3FxzIvAvEam/YhwuwkPZojbKz4vVz4t/Y+CT/zpjhafAXQV/G8GSja+TPzPJ
         4skfW4EjqGDKBM2WsSZZuYc2DqdwcRZ7Equ6NToml/v83FYWsEpU++eeOuu8EwQSSJEu
         hQ2x/OTwJsaLD6JkFC5yyrVb7V5vqtd+pZKGEizLOfZWSYVO2rwGJln7N3AzAOzx2G/K
         4ZK84vY6r7p276UERVOUZxT6jp9IIJc4/t7vMA9eZ6RgobkosC4zC/r76mohA6d2N7Tw
         rneGbL3QUTXljIQKKA3ziDoB1ikDqV+NhW5sujWsONICpdoJXalqw8BOV6YLFDRqNa2/
         bktQ==
X-Gm-Message-State: AOAM532Nw4L6AUdxxPWv2XwoZ/mbrbbdXBvAEkuUipDc2SkyxL2hVuoK
        BVm2QL8BxDTJu/cgmnq9IWE=
X-Google-Smtp-Source: ABdhPJybP6O5484MyiP/NQzPPYoJgE+bRR5MtrjEoKprcszbr9E8WsD+qysLidQPe9jm/L2M0r4jew==
X-Received: by 2002:a7b:c93a:: with SMTP id h26mr8593158wml.141.1621595548880;
        Fri, 21 May 2021 04:12:28 -0700 (PDT)
Received: from [192.168.43.70] ([46.222.120.224])
        by smtp.gmail.com with ESMTPSA id i5sm1804932wrw.29.2021.05.21.04.12.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 May 2021 04:12:28 -0700 (PDT)
Subject: Re: [PATCH v3] bpf.2: Use standard types and attributes
To:     Daniel Borkmann <daniel@iogearbox.net>,
        "Alejandro Colomar (man-pages)" <alx.manpages@gmail.com>,
        mtk.manpages@gmail.com
Cc:     linux-man@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Zack Weinberg <zackw@panix.com>,
        LKML <linux-kernel@vger.kernel.org>,
        glibc <libc-alpha@sourceware.org>, GCC <gcc-patches@gcc.gnu.org>,
        bpf <bpf@vger.kernel.org>,
        David Laight <David.Laight@ACULAB.COM>,
        Joseph Myers <joseph@codesourcery.com>,
        Florian Weimer <fweimer@redhat.com>
References: <6740a229-842e-b368-86eb-defc786b3658@gmail.com>
 <20210515190116.188362-1-alx.manpages@gmail.com>
 <9df36138-f622-49a6-8310-85ff0470ccd6@gmail.com>
 <521cd198-fea2-c2a8-ed96-5848ae39b6f2@iogearbox.net>
From:   Alejandro Colomar <alx.mailinglists@gmail.com>
Message-ID: <c2d0c73e-20d8-f624-8d72-8b00e9309463@gmail.com>
Date:   Fri, 21 May 2021 13:12:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <521cd198-fea2-c2a8-ed96-5848ae39b6f2@iogearbox.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello Daniel,

On 5/17/21 8:56 PM, Daniel Borkmann wrote:
> On 5/16/21 11:16 AM, Alejandro Colomar (man-pages) wrote:
>>>
>>> Signed-off-by: Alejandro Colomar <alx.manpages@gmail.com>
>> Discussion: 
>> <https://lore.kernel.org/linux-man/6740a229-842e-b368-86eb-defc786b3658@gmail.com/T/> 
>>
>>> Nacked-by: Alexei Starovoitov <ast@kernel.org>
>>> Nacked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> You forgot to retain my ...
> 
> Nacked-by: Daniel Borkmann <daniel@iogearbox.net>

Yup! Sorry, I forgot :)

Thanks,

Alex

> 
>>> Acked-by: Zack Weinberg <zackw@panix.com>
>>> Cc: LKML <linux-kernel@vger.kernel.org>
>>> Cc: glibc <libc-alpha@sourceware.org>
>>> Cc: GCC <gcc-patches@gcc.gnu.org>
>>> Cc: bpf <bpf@vger.kernel.org>
>>> Cc: David Laight <David.Laight@ACULAB.COM>
>>> Cc: Joseph Myers <joseph@codesourcery.com>
>>> Cc: Florian Weimer <fweimer@redhat.com>
>>> Cc: Daniel Borkmann <daniel@iogearbox.net>
>>> ---
>>>   man2/bpf.2 | 49 ++++++++++++++++++++++++-------------------------
>>>   1 file changed, 24 insertions(+), 25 deletions(-)
>>>

