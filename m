Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D33A536EC8
	for <lists+bpf@lfdr.de>; Thu,  6 Jun 2019 10:35:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727138AbfFFIfH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Jun 2019 04:35:07 -0400
Received: from mail-wr1-f47.google.com ([209.85.221.47]:34978 "EHLO
        mail-wr1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727082AbfFFIfG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 6 Jun 2019 04:35:06 -0400
Received: by mail-wr1-f47.google.com with SMTP id m3so1461453wrv.2
        for <bpf@vger.kernel.org>; Thu, 06 Jun 2019 01:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UajfkvM7OMJhBvn/3zITvVVwFNbh5QyO0KD2fL7HAfA=;
        b=UbM+6nRG7Q9a6hI2VA/6WzMgfRI7Nn9xKWc9A95Qws3o3ixBOObYuWvBMr3Bpuj0WG
         hRT4h9n1S0g+tLMSOIxisZgD0aUTjd2vWSP6Ko72PWqiiG0dO91cM+flvt6O7JSakFvT
         zQdIipZToAPYy6A+638GxJzEB11qId921AV4V/woyiyA3N+AwNmKDJsoAlCKnyn9Exlw
         3eyKx2rAmo7Rg3z8Llr7xK0Zw2//lV7tfOgPSPdVDmGI/DBK8Vlv1n17XklMq9emhYz/
         sfihH313La+yqb7YpPrwnDubl2keaLvIiZEKL0i4ZyWM2J3e9NBEfXI4t/wYi7/fRQ0k
         7pYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UajfkvM7OMJhBvn/3zITvVVwFNbh5QyO0KD2fL7HAfA=;
        b=ASwLdHFyM7Wkwqv/yQCB7ZKz59k6Qa5uTH/2iIUghVqzQ0FmEj0Pa04McT7wTccY7v
         NYrnm03132C+TVrMxV5bVRAUCTM+JLKdYaCevW9k7kvAFX7IpIT2E76RTUs91m2pJjfq
         wbXLRiBQrFBcMORbZHniY4N6pMLL+VimUUpJ+0lePkbvHtmf6cIDrrLwdfV3T/bMPZPX
         8JD3mOYDBrMawxcjmYh7aKSbkt3KoOgMgyByhlJ9LopRG7qJI3QjivvSmZKX8A6n3WOp
         t2O9J2GeYcoVBdmmWTrGieTdEsvcTpfpDwrMOKZaqgcjaglfd0kmqeaMuwESHdowuNkZ
         UYKA==
X-Gm-Message-State: APjAAAVBfOl9Sqqo/nABWX2D2/YjIDv0jOrjNZlpLvyY2P3blIDYsFhq
        asyyDOf57fVDH8l5JGuA+hEt3w==
X-Google-Smtp-Source: APXvYqyOFzSFIK9iH9gmLtZmWmFphGmHhd6PnyF4U1Wb4+QmU7OZiVqpqvzrhC1x39/y09fQL2kSUg==
X-Received: by 2002:a5d:6a05:: with SMTP id m5mr20463872wru.161.1559810105316;
        Thu, 06 Jun 2019 01:35:05 -0700 (PDT)
Received: from [192.168.1.2] ([194.53.187.113])
        by smtp.gmail.com with ESMTPSA id p2sm1405646wrx.90.2019.06.06.01.35.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Jun 2019 01:35:04 -0700 (PDT)
Subject: Re: [BPF v1] tools: bpftool: Fix JSON output when lookup fails
To:     Krzesimir Nowak <krzesimir@kinvolk.io>, bpf@vger.kernel.org
Cc:     Alban Crequy <alban@kinvolk.io>,
        =?UTF-8?Q?Iago_L=c3=b3pez_Galeiras?= <iago@kinvolk.io>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Stanislav Fomichev <sdf@google.com>,
        Prashant Bhole <bhole_prashant_q7@lab.ntt.co.jp>,
        Okash Khawaja <osk@fb.com>,
        David Calavera <david.calavera@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190605191707.24429-1-krzesimir@kinvolk.io>
From:   Quentin Monnet <quentin.monnet@netronome.com>
Message-ID: <3b26789b-3b51-8c47-b710-8df09b63ce73@netronome.com>
Date:   Thu, 6 Jun 2019 09:35:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190605191707.24429-1-krzesimir@kinvolk.io>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

2019-06-05 21:17 UTC+0200 ~ Krzesimir Nowak <krzesimir@kinvolk.io>
> In commit 9a5ab8bf1d6d ("tools: bpftool: turn err() and info() macros
> into functions") one case of error reporting was special cased, so it
> could report a lookup error for a specific key when dumping the map
> element. What the code forgot to do is to wrap the key and value keys
> into a JSON object, so an example output of pretty JSON dump of a
> sockhash map (which does not support looking up its values) is:
> 
> [
>     "key": ["0x0a","0x41","0x00","0x02","0x1f","0x78","0x00","0x00"
>     ],
>     "value": {
>         "error": "Operation not supported"
>     },
>     "key": ["0x0a","0x41","0x00","0x02","0x1f","0x78","0x00","0x01"
>     ],
>     "value": {
>         "error": "Operation not supported"
>     }
> ]
> 
> Note the key-value pairs inside the toplevel array. They should be
> wrapped inside a JSON object, otherwise it is an invalid JSON. This
> commit fixes this, so the output now is:
> 
> [{
>         "key": ["0x0a","0x41","0x00","0x02","0x1f","0x78","0x00","0x00"
>         ],
>         "value": {
>             "error": "Operation not supported"
>         }
>     },{
>         "key": ["0x0a","0x41","0x00","0x02","0x1f","0x78","0x00","0x01"
>         ],
>         "value": {
>             "error": "Operation not supported"
>         }
>     }
> ]
> 
> Fixes: 9a5ab8bf1d6d ("tools: bpftool: turn err() and info() macros into functions")
> Cc: Quentin Monnet <quentin.monnet@netronome.com>
> Signed-off-by: Krzesimir Nowak <krzesimir@kinvolk.io>

Thanks for the fix!

Quentin

