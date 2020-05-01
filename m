Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1B111C1CA1
	for <lists+bpf@lfdr.de>; Fri,  1 May 2020 20:10:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729264AbgEASKo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 1 May 2020 14:10:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729138AbgEASKo (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 1 May 2020 14:10:44 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42070C061A0C
        for <bpf@vger.kernel.org>; Fri,  1 May 2020 11:10:44 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id f83so2668732qke.13
        for <bpf@vger.kernel.org>; Fri, 01 May 2020 11:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5ahmBOT4EqiBBR5HrB0bZZa4FOJPe98DpaAjCK1XFR4=;
        b=WAulc1sihqL55cfIFckuKK2gymjXAf+bHGK6/jQinWha4ODcOROJV7Qk9trOkXiSae
         p6UT5xXG+NL4E6TMoVlZZ/s98c5Wpaxr7ZH/K72+8d5W8nsJ5IFOXAz7WqroavGRJRNd
         FoStgIUX9HQBoy0X5BxCDaJ6iIpjsHVNGy10QU3SEbQ8sQkYxMT93r9y0O6xdYGt5Lnf
         +hXSehUofp3tfXH27A2MwHhp2+E9zTPAWaAW+A/GWz4bEcBaPPjRkL/1MYiexlOp9B2c
         zT6UaAdbTshN4oSe8fqq5amNDceThxb5jkT85BI3sBQnncFtlmOOtFMuGrklXdodKdux
         r5Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5ahmBOT4EqiBBR5HrB0bZZa4FOJPe98DpaAjCK1XFR4=;
        b=pfVf3G/uvbaZkVji9nHFa8Kb94HjyY0CtfMrUS15vGtoSDV2bBe8P2lYkCxLCCkNIQ
         EWvtlr+M2KeN/p+AAqNGflnPnCbf1zfd2/A8A93KGIwbI6z3vG80FKEpiMQ0dPY/rFnH
         4Nrhka/b6xF0pb1kZVRghxmdxgXGWrFvjayW5XWOC8wa8AMQhTG9LxnybP5klUX35AiO
         8Z5BAuo8fBXSzCyLCc04kWpqFdRo18X7seh4Yb9V7VzOoHu0/Op8JuDdtJrwgRbWFgkv
         uGnxR+CxhbnD4ydQuzYEzVGQP2g/fCVBHXzpIMifAhpa27QAgHjo1nnWN9TKtFE4E1YW
         w+kg==
X-Gm-Message-State: AGi0PuaFO1/toUx0OUqih+OIvfv5OrhARZ5DiakOp66Xd/qJAoXY0ZJs
        yxVnyXQA6GsRAnqZMINdHTM=
X-Google-Smtp-Source: APiQypLnCLsjgcBnvkPZ5+28QUJ/N4+78+AM5Ky/QG0q+cYgPsCp9zfKFdluXLImDrxxVPdPfzzZMA==
X-Received: by 2002:ae9:ef84:: with SMTP id d126mr2435645qkg.19.1588356643541;
        Fri, 01 May 2020 11:10:43 -0700 (PDT)
Received: from ?IPv6:2601:282:803:7700:b01c:ec8e:d8ff:35b1? ([2601:282:803:7700:b01c:ec8e:d8ff:35b1])
        by smtp.googlemail.com with ESMTPSA id v2sm3261927qth.66.2020.05.01.11.10.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 May 2020 11:10:42 -0700 (PDT)
Subject: Re: Fighting BPF verifier to reach end-of-packet with XDP
To:     Jesper Dangaard Brouer <brouer@redhat.com>,
        Daniel Borkmann <borkmann@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     BPF-dev-list <bpf@vger.kernel.org>,
        =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>,
        Matteo Croce <mcroce@redhat.com>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20200501174132.4388983e@carbon>
From:   David Ahern <dsahern@gmail.com>
Message-ID: <fdcb0a10-b1f4-b65c-9bae-666c62629847@gmail.com>
Date:   Fri, 1 May 2020 12:10:41 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200501174132.4388983e@carbon>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 5/1/20 9:41 AM, Jesper Dangaard Brouer wrote:
> One use-case for tail grow patchset, is to add a kernel timestamp at
> XDP time in the extended tailroom of packet and return XDP_PASS to let
> packet travel were it needs to go, and then via tcpdump we can extract
> this timestamp. (E.g. this could improve on Ilias TSN measurements[2]).

That's an interesting trick for timestamping xdp frames.

Have you looked at having xdp frames use existing timestamping APIs?
e.g., if PTP is enabled, pull the timestamp as meta data for the frame.
