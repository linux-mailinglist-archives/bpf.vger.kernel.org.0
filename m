Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55615487BB4
	for <lists+bpf@lfdr.de>; Fri,  7 Jan 2022 19:02:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348670AbiAGSCl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 7 Jan 2022 13:02:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348668AbiAGSCl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 7 Jan 2022 13:02:41 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DAB1C061574
        for <bpf@vger.kernel.org>; Fri,  7 Jan 2022 10:02:41 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id v6so12506646wra.8
        for <bpf@vger.kernel.org>; Fri, 07 Jan 2022 10:02:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=/pTbOp8Y/z+v5/7bezto5SDe31jZoxxusR5iYShFUA4=;
        b=3PkoKFiuZihHQ2sGvrPkw3nS0qxfAL/43DrDNUtcTgNYshIwuuiS6Hc52pUGzDN09q
         m14mF4puzed849ncLWgBBKYXMZ+w2DGnj6Y+C+1xsxhmMeHe+IHZGo4uKqqrPMJA1iz4
         mLLfVQ7HqrkHyAt2qTUen0I9VGvturCpIhPUUHJm9O4dTwoxeeYa6xmLw2IU+Ka5WgG/
         V0dbDSClUqBws9f+LXSAK7uLyWbcHD3eij3N7LW4X8BsMwJoq+R9G6jYEt0EpKSqIS2a
         CHSeEyTHEhLNYKbAhARKYQ+oW1HpYod7zb5HqvseMlmLfNINJ2xj5TazRa6rJwFQnxSR
         /rZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/pTbOp8Y/z+v5/7bezto5SDe31jZoxxusR5iYShFUA4=;
        b=uOlG+dK+QCkon4qhba8o3XvlAk4kwYNkJTD/BrGHGvxDnoHT5yuWwFzQ76BuSD7g6T
         BqgZbRO8DWY4mqPLR7B5vcSDD6VRumnV+f9aJPaHop0rf6FVYLoYcnz1qGb7l3hTl7jM
         8h2x9d3BHHbRGBxDHRFB9xZDdLslaM3lQVtJMQz4cQ5t2EFIv1dLj8Cf+IMxp2vsmP3u
         0OvfJV0bpZLDrpRtkhvQzNCfJjRX4HXRkcBI4OY7IZ1nedlCX5Ioc7wyzDTUWwwTlapW
         EiNm+5VCRwMPtUtPQ++t8sKIgrkCJtbfqcs9VQQZRfMo6/6xpshQsfY/Jmm+Vqy0vCdN
         2wDA==
X-Gm-Message-State: AOAM530rD0EyukvBW3kkJxCJoRXCb6JSsh8A9QWwnvaUCixOL/wM8MuI
        YeikBLAHL3VTepQl7y4B/BSS4w==
X-Google-Smtp-Source: ABdhPJzNg/lS5tlMrOGHfOhNEkjJU3JZRrb0vKv3byxYC8QpYMARr9ll3OseabayiRorLXu7wdifCQ==
X-Received: by 2002:a5d:4533:: with SMTP id j19mr874540wra.568.1641578559698;
        Fri, 07 Jan 2022 10:02:39 -0800 (PST)
Received: from [192.168.1.8] ([149.86.69.49])
        by smtp.gmail.com with ESMTPSA id m35sm17116833wms.1.2022.01.07.10.02.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Jan 2022 10:02:39 -0800 (PST)
Message-ID: <3e97ea0d-7966-1440-b5e3-94a254772c2c@isovalent.com>
Date:   Fri, 7 Jan 2022 18:02:38 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH bpf-next 2/2] bpftool: Fix error check when calling
 hashmap__new()
Content-Language: en-GB
To:     =?UTF-8?Q?Mauricio_V=c3=a1squez?= <mauricio@kinvolk.io>,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
References: <20220107152620.192327-1-mauricio@kinvolk.io>
 <20220107152620.192327-2-mauricio@kinvolk.io>
From:   Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <20220107152620.192327-2-mauricio@kinvolk.io>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

2022-01-07 10:26 UTC-0500 ~ Mauricio Vásquez <mauricio@kinvolk.io>
> hashmap__new() encodes errors with ERR_PTR(), hence it's not valid to
> check the returned pointer against NULL and IS_ERR() has to be used
> instead.
> 
> libbpf_get_error() can't be used in this case as hashmap__new() is not
> part of the public libbpf API and it'll continue using ERR_PTR() after
> libbpf 1.0.
> 
> Fixes: 8f184732b60b ("bpftool: Switch to libbpf's hashmap for pinned paths of BPF objects")
> Fixes: 2828d0d75b73 ("bpftool: Switch to libbpf's hashmap for programs/maps in BTF listing")
> Fixes: d6699f8e0f83 ("bpftool: Switch to libbpf's hashmap for PIDs/names references")
> 
> Signed-off-by: Mauricio Vásquez <mauricio@kinvolk.io>

This looks good to me, thank you for the fix!

Reviewed-by: Quentin Monnet <quentin@isovalent.com>
