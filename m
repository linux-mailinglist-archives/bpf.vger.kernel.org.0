Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 013231BB8BC
	for <lists+bpf@lfdr.de>; Tue, 28 Apr 2020 10:23:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbgD1IXF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Apr 2020 04:23:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726515AbgD1IXE (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 28 Apr 2020 04:23:04 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94DA4C03C1A9
        for <bpf@vger.kernel.org>; Tue, 28 Apr 2020 01:23:04 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id k1so23586377wrx.4
        for <bpf@vger.kernel.org>; Tue, 28 Apr 2020 01:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hu1khv2uD3gUpoF+6bZ7gzDCNHsGPqJjGgRCdSzUGSQ=;
        b=zPv4xv7R8TY1BPJyvNFNCs/pLOdEGoK+M9H+bNOAOqG2vky06n15cIC3mHFs8MM0wR
         0UQCh8Puhdpyl9tumeZ1lwLiv+Wl9N+LeONrvLVswNrA4/eAXd/vkOfy8GPy2R2ttD0f
         WeNJdYVdwb2ibCpQpiSo5j2kPMaB++aYENMDrwlCQ7hKxpnpJLaS7xz6F81LsoFIn+W8
         VRiwOSl1vj1lczS8e9dRyPNdt/oZP2FFgPJpPVZUiNB/fWC0CLcz5qT8ZC5CsqPpGJYH
         ysBHPZIXer86gRdQzxeG1sRTgRhtssYOhK+Hqv5MZ8ngAS1phMUM+BeMGBOSpyT9vB3/
         B1kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hu1khv2uD3gUpoF+6bZ7gzDCNHsGPqJjGgRCdSzUGSQ=;
        b=kEK6QLOZlbPtwe5NtNY3z4jO4aWbkJQGHUOEHKJLhRw7HS427VktKf5XmQkAZJ09rR
         MgD8H17sgw/KiUnQswr2FxG33CW1C1kLt9gTFCuaLT6Xac+yGdXL0loVztEH7X9qrC5b
         UA5JqUIbx/sEKQypDZhv/y63uz4qbb8a8aR91SaQn43/qctcNRZArR+bQLnT4bOpGCO0
         lC06P/1XbwqNq4IVaNsc7RNc2NLVelGKgZK70qkr91oxYV79txoimC9FpCbI9tQNRGHS
         oG5pgzQg09sKR5Cn7YCir/cvX0ho84uu3yiiyp4AM4Yuc+aXeOQiM6DnWipKYNfvFcRn
         I9GQ==
X-Gm-Message-State: AGi0Pua2S28uS34N1ZIWcsbpR8pWK7izTYBUPQcljD3KwVZs2K4X9TFm
        2p+/7EFAy8oOxcAY2DKKMPc7UA==
X-Google-Smtp-Source: APiQypJni09HavB6+l0lpfsmoIDQFRD615v5R2IarzlbZhzszTO5LwsCBBS+42rBJ94RY1dF2l9Eyg==
X-Received: by 2002:a5d:428a:: with SMTP id k10mr32115727wrq.59.1588062183393;
        Tue, 28 Apr 2020 01:23:03 -0700 (PDT)
Received: from [192.168.1.10] ([194.53.185.137])
        by smtp.gmail.com with ESMTPSA id b12sm25485134wro.18.2020.04.28.01.23.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Apr 2020 01:23:02 -0700 (PDT)
Subject: Re: [PATCH v2 bpf-next 08/10] bpftool: add bpf_link show and pin
 support
To:     Andrii Nakryiko <andriin@fb.com>, bpf@vger.kernel.org,
        netdev@vger.kernel.org, ast@fb.com, daniel@iogearbox.net
Cc:     andrii.nakryiko@gmail.com, kernel-team@fb.com
References: <20200428054944.4015462-1-andriin@fb.com>
 <20200428054944.4015462-9-andriin@fb.com>
From:   Quentin Monnet <quentin@isovalent.com>
Message-ID: <81d371a0-078e-a787-27df-54c83ce79eba@isovalent.com>
Date:   Tue, 28 Apr 2020 09:23:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200428054944.4015462-9-andriin@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

2020-04-27 22:49 UTC-0700 ~ Andrii Nakryiko <andriin@fb.com>
> Add `bpftool link show` and `bpftool link pin` commands.
> 
> Example plain output for `link show` (with showing pinned paths):
> 
> [vmuser@archvm bpf]$ sudo ~/local/linux/tools/bpf/bpftool/bpftool -f link
> 1: tracing  prog 12
>         prog_type tracing  attach_type fentry
>         pinned /sys/fs/bpf/my_test_link
>         pinned /sys/fs/bpf/my_test_link2
> 2: tracing  prog 13
>         prog_type tracing  attach_type fentry
> 3: tracing  prog 14
>         prog_type tracing  attach_type fentry
> 4: tracing  prog 15
>         prog_type tracing  attach_type fentry
> 5: tracing  prog 16
>         prog_type tracing  attach_type fentry
> 6: tracing  prog 17
>         prog_type tracing  attach_type fentry
> 7: raw_tracepoint  prog 21
>         tp 'sys_enter'
> 8: cgroup  prog 25
>         cgroup_id 584  attach_type egress
> 9: cgroup  prog 25
>         cgroup_id 599  attach_type egress
> 10: cgroup  prog 25
>         cgroup_id 614  attach_type egress
> 11: cgroup  prog 25
>         cgroup_id 629  attach_type egress
> 
> Signed-off-by: Andrii Nakryiko <andriin@fb.com>
> ---

Reviewed-by: Quentin Monnet <quentin@isovalent.com>

