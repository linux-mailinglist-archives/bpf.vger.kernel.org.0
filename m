Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85EAE29F5C
	for <lists+bpf@lfdr.de>; Fri, 24 May 2019 21:49:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403810AbfEXTtI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 May 2019 15:49:08 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46446 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403829AbfEXTtI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 May 2019 15:49:08 -0400
Received: by mail-wr1-f68.google.com with SMTP id r7so11075386wrr.13
        for <bpf@vger.kernel.org>; Fri, 24 May 2019 12:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=X59zojuDCJjtx6uulEb20vWKFekng51A4yUTCDk/1is=;
        b=JGCKaedhJvGA+kV10LVeD64FNzMa8jCG0FylenQXgLKDKtrOeZZ5jkXCcWY/6yFLRt
         bKQ/P5kYO5ItUYnDy1QMUcwnR6EfY3A/DgBgqMjKa/EPYZJ4SYqTHAX8f+tB5i65xZZW
         SuV8z0ensE9HKwzkIawFk5TPVaJ0VxUbDD/d5BGdh4YjbBWFF4Nm6+/eHHC5Ax9o2ufp
         9/Xr4PcQveZgxUFxk5CP7QkMJAuBIoPCCWHdDeJqA5LF/zNI8w588OACN+MNMqMpusjV
         syRP6pheeSQFiLe108hWRddmNvf6KckTQOGWDB+ifFBd9hUbwWTqN9QSSWLS/EobXATJ
         l6kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=X59zojuDCJjtx6uulEb20vWKFekng51A4yUTCDk/1is=;
        b=PgIvV/IdbWal5xxqmp9Z+OM1QCM7TdSJQt9rhWEAa5xYg765TzQtTGBGvUK61AvgZy
         xMeGbTJGZDbFep1BP6CJZmgmRQ5rALgYKqLk2n9oya1x9Eef1wZL9Ag9RYgZQwdQ5Bax
         yAESWIRMwORq2LX4b+Z+z+GvM+IQiytNuC3Tbq1bWnMj6/DddTmmPSkN8huhrMCnt70U
         t7q6EHIbWyk8vbFRfk1Q6E/7e+xcheeEPGLzZvDmr09dxS6H9H//8IgW30oBusLlYh4E
         fbT+Rn95Hv/R0LQPxdDuVpMs2JUoZdFd1j37p3Cl5ZsjbC2zpVmCsZVqBjtA3chRKunG
         4poQ==
X-Gm-Message-State: APjAAAWSWx3ljnUzMjPEoNZhiW4uGI6EmMFww9YTNq1om+QmydE0iwA5
        z48EW1jUDWuK0b4cZ9oDIgnEPA==
X-Google-Smtp-Source: APXvYqwYHH22ZHyi5fSSsRpGc0WNklmoJjC06TBSmi+4UhbHI2pm1jq0PtZJpOdl7rgj/DhbL1bxJw==
X-Received: by 2002:a05:6000:1150:: with SMTP id d16mr9178758wrx.63.1558727347202;
        Fri, 24 May 2019 12:49:07 -0700 (PDT)
Received: from [192.168.1.2] ([194.53.186.20])
        by smtp.gmail.com with ESMTPSA id t13sm6425018wra.81.2019.05.24.12.49.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 12:49:06 -0700 (PDT)
Subject: Re: [PATCH v3 bpf-next 11/12] bpftool/docs: add description of btf
 dump C option
To:     Andrii Nakryiko <andriin@fb.com>, andrii.nakryiko@gmail.com,
        ast@fb.com, daniel@iogearbox.net, netdev@vger.kernel.org,
        bpf@vger.kernel.org, kernel-team@fb.com
References: <20190524185908.3562231-1-andriin@fb.com>
 <20190524185908.3562231-12-andriin@fb.com>
From:   Quentin Monnet <quentin.monnet@netronome.com>
Message-ID: <391cff6f-d91f-2cb6-a326-a85f0ab0326e@netronome.com>
Date:   Fri, 24 May 2019 20:49:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190524185908.3562231-12-andriin@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

2019-05-24 11:59 UTC-0700 ~ Andrii Nakryiko <andriin@fb.com>
> Document optional **c** option for btf dump subcommand.
> 
> Cc: Quentin Monnet <quentin.monnet@netronome.com>
> Signed-off-by: Andrii Nakryiko <andriin@fb.com>

Reviewed-by: Quentin Monnet <quentin.monnet@netronome.com>
