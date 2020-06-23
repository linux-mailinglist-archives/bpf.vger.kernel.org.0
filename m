Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0190204F66
	for <lists+bpf@lfdr.de>; Tue, 23 Jun 2020 12:41:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732203AbgFWKle (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Jun 2020 06:41:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732172AbgFWKld (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 23 Jun 2020 06:41:33 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDE68C061573
        for <bpf@vger.kernel.org>; Tue, 23 Jun 2020 03:41:31 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id j18so2509948wmi.3
        for <bpf@vger.kernel.org>; Tue, 23 Jun 2020 03:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QB9WCNnej0jK2NCSww+4NBIOJShwVMR7U8SyxPc3eMs=;
        b=KxjPoth9Wllz959+GIJPoDbxdJZ7WB4zU6fy+mrg5KGppKGWdh3HkWz2X8wg7n6/ES
         1l9BcPzjdk3+rcWxG3JvNX/0aTmxssmhBAPDMl5tgX9UOnRevstuLokRdEBZjh/ZLnor
         xTnVoQPgozXKrv2sUDxL9vM/QXBZ4RVrMAQB4maEs4PygUXI2qihANyvIqcqQHt+9XZQ
         VYdMZC2nAIyEwRzMdtoUb4cSnTrjgA2Nyvt/wEtAwhXlgoUVhwLHOHfr4yY+Rg3IZsve
         +ozKgWg/09b2akKaVjdQ/GSviObPY8xLmgLRoHxdUTq/ch0G6/TDbYEWuVxNYcisJh07
         V1yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QB9WCNnej0jK2NCSww+4NBIOJShwVMR7U8SyxPc3eMs=;
        b=dOj2vkgYdoIl4TvbA16nQofCtmvJoZL6KDlhC/Ze7LHeVtt+iIiu1j9MF6xku1CYrL
         uyhrz0ySr3iKg62S/fVrkNB0R6AnPQjv2dI06iYpsf6azletxMyKe4pZBskgdtebgU8b
         EOqoC/O37kfY2VnN5Ot6LaxKlKHKZ6GSxRK7LzCKVaKRP5fhjpKz8saNCMXnfucqcOob
         Iyc4gOqHpx2h+lDgGhfRJoBflXzzCCM+LuJfqgYqLZ1PNvGO0EZfoj3MJL1S6FOuX/B9
         8PdCG4YlrI1AJJj/nVqRukLpvJoQHG37uY20bXegE6ZzHddkKkOIR95yqdGHXDs5u7Vd
         49iw==
X-Gm-Message-State: AOAM530Cdu+2u/cuzNraQKFr4u9mXYlXGeUGKs92juasVw9wcupkqPM/
        kCy2VilYEyfZ3q3bV+MfQKtsqbkWSJe5pw==
X-Google-Smtp-Source: ABdhPJzFCH41vLfd0oAbd8/l67xNhNU11IrvjktAqBpj9rWTsYiqmvhz0Da9kqwdPtuBj7CQ0Md+UQ==
X-Received: by 2002:a1c:9802:: with SMTP id a2mr22408664wme.64.1592908890051;
        Tue, 23 Jun 2020 03:41:30 -0700 (PDT)
Received: from [192.168.1.12] ([194.53.184.63])
        by smtp.gmail.com with ESMTPSA id t188sm3222786wmt.27.2020.06.23.03.41.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jun 2020 03:41:27 -0700 (PDT)
Subject: Re: [PATCH bpf-next] tools, bpftool: Correctly evaluate
 $(BUILD_BPF_SKELS) in Makefile
To:     Tobias Klauser <tklauser@distanz.ch>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     Andrii Nakryiko <andriin@fb.com>, bpf@vger.kernel.org
References: <20200623103710.10370-1-tklauser@distanz.ch>
From:   Quentin Monnet <quentin@isovalent.com>
Message-ID: <83fb6d10-6b96-0a3d-0a7a-7ce26188a289@isovalent.com>
Date:   Tue, 23 Jun 2020 11:41:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200623103710.10370-1-tklauser@distanz.ch>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

2020-06-23 12:37 UTC+0200 ~ Tobias Klauser <tklauser@distanz.ch>
> Currently, if the clang-bpf-co-re feature is not available, the build
> fails with e.g.
> 
>   CC       prog.o
> prog.c:1462:10: fatal error: profiler.skel.h: No such file or directory
>  1462 | #include "profiler.skel.h"
>       |          ^~~~~~~~~~~~~~~~~
> 
> This is due to the fact that the BPFTOOL_WITHOUT_SKELETONS macro is not
> defined, despite BUILD_BPF_SKELS not being set. Fix this by correctly
> evaluating $(BUILD_BPF_SKELS) when deciding on whether to add
> -DBPFTOOL_WITHOUT_SKELETONS to CFLAGS.
> 
> Fixes: 05aca6da3b5a ("tools/bpftool: Generalize BPF skeleton support and generate vmlinux.h")
> Signed-off-by: Tobias Klauser <tklauser@distanz.ch>

Reviewed-by: Quentin Monnet <quentin@isovalent.com>

Thanks Tobias.
