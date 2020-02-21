Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5572E167BF8
	for <lists+bpf@lfdr.de>; Fri, 21 Feb 2020 12:27:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbgBUL1W (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Feb 2020 06:27:22 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42991 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbgBUL1W (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Feb 2020 06:27:22 -0500
Received: by mail-wr1-f68.google.com with SMTP id k11so1616041wrd.9
        for <bpf@vger.kernel.org>; Fri, 21 Feb 2020 03:27:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Ho6wZMX8qLHipLihEaU5SCXs4HqK1+rvVl2GBlxkV28=;
        b=Rlb6YHpDPsOHCT/5Aq+PoY+c+yfNFB3uMTnFGqhvRhPm/D5NrdKzM2J4yQZgdKqvmx
         R3mnvee3YG//8uDOK6/gczMozK6zfg7E/WaLz1cTmuQA1EjTlNw+gnZVC8kRrK4hoX8O
         zQbdVR2pLVrnL8k6j6S2Q9RAaef0UQNxFqRGWx6Emo3FwOQUhNoXB5MbNebYDQ+n6jRP
         nToI6ez0LqEUnco25hj/dxmMpLh9JlG50ygHNaC4JWxAsnVW47V1MAXRpzpNVjz+QlaG
         oPHGFpzAi02xmB2wYd9gVJwG0LXWot9zDHJ9VvSz9hwf2DEUlAage1mxQbjNvaSyjMuz
         bSOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ho6wZMX8qLHipLihEaU5SCXs4HqK1+rvVl2GBlxkV28=;
        b=fRGVBNKvrRhz3jEfJjj43hFXCzfBTQaAmKetUUwrhwhzlNO8jfNCyWBJ0gjBXBeUNk
         JNUmNzGfjU5wN68E4B3AJb/My5dqy2hZSLyBlj+rpuwNpNJdetaCuppso4QIVDUiFRm/
         0Tee9sdgwXY67W/0q9M4NZtECMaJorR/dk70t3sw+nx17TfNrPhHIuvPB3dSpdpWZPQv
         /D3UswlfLJ8lelqnwWanljDjh04LcDYlTNKlZnNGpLcb09s9BJma53oQqb1vT38dXFuw
         Om3kugZaCvraCl2W/EqkG2XcfHyubQPrGb980C+t0ivMVz02mL4umkWBMM27KS+oEjeP
         GUsQ==
X-Gm-Message-State: APjAAAX42e29gommdq2h+5jsTuNO/Qh3MNZk7SMGIV5uTm6oSumw+pKB
        MYWHy/wTMo0Xlq5jlC37s5Pwvg==
X-Google-Smtp-Source: APXvYqylZ7Vhu0XF5ow5n1qsv1lD6lrch6MbYz9kBc0cMwAxD5rPbQ8q+Hj1YgY+26WTbyqFs1usTQ==
X-Received: by 2002:a5d:474d:: with SMTP id o13mr47350622wrs.309.1582284440977;
        Fri, 21 Feb 2020 03:27:20 -0800 (PST)
Received: from [192.168.1.23] ([91.143.66.155])
        by smtp.gmail.com with ESMTPSA id v15sm3768573wrf.7.2020.02.21.03.27.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Feb 2020 03:27:20 -0800 (PST)
Subject: Re: [PATCH bpf-next v2 1/5] bpftool: Move out sections to separate
 functions
To:     Michal Rostecki <mrostecki@opensuse.org>, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
References: <20200221031702.25292-1-mrostecki@opensuse.org>
 <20200221031702.25292-2-mrostecki@opensuse.org>
From:   Quentin Monnet <quentin@isovalent.com>
Message-ID: <ba4bf99d-9047-15b6-09b1-d8e7e0d1feef@isovalent.com>
Date:   Fri, 21 Feb 2020 11:27:18 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200221031702.25292-2-mrostecki@opensuse.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

2020-02-21 04:16 UTC+0100 ~ Michal Rostecki <mrostecki@opensuse.org>
> Remove all calls of print_end_then_start_section function and for loops
> out from the do_probe function. Instead, provide separate functions for
> each section (like i.e. section_helpers) which are called in do_probe.
> This change is motivated by better readability.
> 
> Signed-off-by: Michal Rostecki <mrostecki@opensuse.org>

Thanks!

Reviewed-by: Quentin Monnet <quentin@isovalent.com>
