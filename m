Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10B36229347
	for <lists+bpf@lfdr.de>; Wed, 22 Jul 2020 10:20:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbgGVIUb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Jul 2020 04:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbgGVIUb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Jul 2020 04:20:31 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8020C0619DE
        for <bpf@vger.kernel.org>; Wed, 22 Jul 2020 01:20:30 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id x5so522339wmi.2
        for <bpf@vger.kernel.org>; Wed, 22 Jul 2020 01:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AGO5oXC2NaEBZms9Zzvd2Ka4lOiXeYYL68h7WdCW7xI=;
        b=LJpl2hBN0SFsjG67XqGtJQn+tNX8kctXVNJojoT3N44DachISj7x/UMugDRxiISuzp
         vANMfx2UD27Wiq1sgbz4bja+0TMOWCz9yJgNW4SCHs0iljWvcRzlBSPaeqQDAI8acMsH
         xPD6ZWu/WyCOD/ozN5tdXgw1R7Bw/EFhULNaqyQAnOtfSbeOUL3ks4RAYVRV2wRaU9WV
         SLJRnT+Xmwsb2+OThTn9FUhZzLMIyg0njVzTw84s9xlPTNUxEPT2DGIe93mTAxFlmGwS
         MXP/MkYDZYrEZYyJdzVYuZbefn6KtYPGYCs56z0vGnzN0SrobbmPdTN9mAFaV2GsRM9n
         U7FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AGO5oXC2NaEBZms9Zzvd2Ka4lOiXeYYL68h7WdCW7xI=;
        b=U9JKJdKRV8rdqUdaR0T9T/UGLk++EoUnepxqppv1BuX7o5TTFuwWSdrHjvXQRvEplz
         XONhpzJRKQOqRwpZvURy0sIWVz6W+I/msXXJyaZPpIWZbxYMGGgWbpDUl9fdJTPrW8Ke
         0LSuMdB+9yZgtCpMIU/FnroizzJBbTgMLYLeN56WaYzuonvTI10SUFYmIsC7I2hswKmB
         paBvvR5utI6dLgfvA88McvKagdTqkRufQHU0/AuN/FUM0xzHPR+fQ3EXVUxW8amxtWki
         wHfh0D1vUBkB3haxvjZbBrn3l3761hv/OoTT3mrNGGLlPxW20v/bwKf6vaVmBgYphNa5
         RtqA==
X-Gm-Message-State: AOAM530Dco4VYGUQbfl8t/XcMoLmvvuGW7lQkNavsC4PX1erbWigHnnM
        3K1HF4uIKojJrCITdV1u+vvrNy38mSVV7m4r
X-Google-Smtp-Source: ABdhPJwN9ffmcHmPB/OEIHDKByAPhM6CmSNwyL87+MyHHwPRmMtflIzDC4T04pj3pv4tWym0BbTCZg==
X-Received: by 2002:a7b:c5d8:: with SMTP id n24mr912005wmk.153.1595406029191;
        Wed, 22 Jul 2020 01:20:29 -0700 (PDT)
Received: from [192.168.1.12] ([194.35.117.140])
        by smtp.gmail.com with ESMTPSA id n5sm6509733wmi.34.2020.07.22.01.20.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jul 2020 01:20:28 -0700 (PDT)
Subject: Re: [PATCH bpf-next] tools/bpftool: strip BPF .o files before
 skeleton generation
To:     Andrii Nakryiko <andriin@fb.com>, bpf@vger.kernel.org,
        netdev@vger.kernel.org, ast@fb.com, daniel@iogearbox.net
Cc:     andrii.nakryiko@gmail.com, kernel-team@fb.com
References: <20200722043804.2373298-1-andriin@fb.com>
From:   Quentin Monnet <quentin@isovalent.com>
Message-ID: <bae8109d-3f01-eafb-eff8-4df425771b2b@isovalent.com>
Date:   Wed, 22 Jul 2020 09:20:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.0
MIME-Version: 1.0
In-Reply-To: <20200722043804.2373298-1-andriin@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 22/07/2020 05:38, Andrii Nakryiko wrote:
> Strip away DWARF info from .bpf.o files, before generating BPF skeletons.
> This reduces bpftool binary size from 3.43MB to 2.58MB.
> 
> Signed-off-by: Andrii Nakryiko <andriin@fb.com>
Acked-by: Quentin Monnet <quentin@isovalent.com>
