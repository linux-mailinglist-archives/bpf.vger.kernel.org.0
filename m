Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1261DBCC2
	for <lists+bpf@lfdr.de>; Fri, 18 Oct 2019 07:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388594AbfJRFPR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 18 Oct 2019 01:15:17 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33026 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727606AbfJRFPR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 18 Oct 2019 01:15:17 -0400
Received: by mail-pl1-f194.google.com with SMTP id d22so2281934pls.0;
        Thu, 17 Oct 2019 22:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eKCQEHJp+Bmk1+KxL2VW8ZVDs0l76/RRTSEB8GtoKzU=;
        b=VNYmFpR+1svH3RklJ/ni4HOgMNYHl7MHEGV9c2RKjwcUsmhFCVwHCd8Lx6MtsoWVte
         Git34f+i7ciXxxGu+izTqbWE5AxM6LMpwlAhUfDPh5Ki/fqj5/ZAurq5nX/8wqfZhuFx
         GBzv2FpY+5gkaZoq5UJ8rNnF0b/TofDQ5Xp+lVHw+QBbI4lHwpdkGPzJRzkYMlkplsMf
         Y5avb3hUqFh/XcCy5y/7Od4OeVLbiQf0WVuUB99THxpC4P/ofAiEkA2ITlSHT/5P5m5f
         PI3HN+DbW9qrtCpPtPv5uvbqXLG3l3RaWsKUTdL6qDdCg2lddyuwlw/FuZ7C1SP5rVLF
         TcLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eKCQEHJp+Bmk1+KxL2VW8ZVDs0l76/RRTSEB8GtoKzU=;
        b=EensbI4iBJApQ4yw/zv+51REzkZBDCIJK58ob+gndfNt9nNldO/g2RI45wefzbksa7
         cAHdMxA/egvYhxe9knHfZOj3rPUdAvzv398GIk2jbS6vxILtGWBQPGNtirmXqq9IHdtk
         aZnvA0I2C/8duBwXWtBd32GBOWKwzn8AaPCoIyrwCSn9evWsdFiiiyEMTe2LyOXz/kAE
         w1ZZpDrfrFoCHMzW0F7P64KqqQ4KgIbDkJHiqyBBZSoWY0q50q6sRhRklLKmW2LfMV+1
         r738Lgcf3sG8ADgJKWluBIbz1o5+8QGRXF+k13xAH67jy5oWgMgwPObQvapS1SF7FlMb
         ZnVA==
X-Gm-Message-State: APjAAAVJSQtleqkG2TqaZNQXvJW6xhIXh6KytDa6DUmjtD3CVs1aENNt
        uEqL2Df2qsKcx0HG0W/wraMuKN9w
X-Google-Smtp-Source: APXvYqzBaCznyjQSXNVi7TS0i1yrqWYhhCfDRmQilWmU7AcgFxRttRhzngCZrFJD7BNJlUiiRY2BpA==
X-Received: by 2002:a17:902:a50a:: with SMTP id s10mr2720061plq.59.1571372661919;
        Thu, 17 Oct 2019 21:24:21 -0700 (PDT)
Received: from ast-mbp ([2620:10d:c090:180::cfd0])
        by smtp.gmail.com with ESMTPSA id v35sm4253093pgn.89.2019.10.17.21.24.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Oct 2019 21:24:21 -0700 (PDT)
Date:   Thu, 17 Oct 2019 21:24:19 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        bpf@vger.kernel.org, Andrii Nakryiko <andriin@fb.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [PATCH v2 31/33] tools lib bpf: Renaming pr_warning to pr_warn
Message-ID: <20191018042416.r4fffxzbxb3u4csg@ast-mbp>
References: <20191018031710.41052-1-wangkefeng.wang@huawei.com>
 <20191018031850.48498-1-wangkefeng.wang@huawei.com>
 <20191018031850.48498-31-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191018031850.48498-31-wangkefeng.wang@huawei.com>
User-Agent: NeoMutt/20180223
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Oct 18, 2019 at 11:18:48AM +0800, Kefeng Wang wrote:
> For kernel logging macro, pr_warning is completely removed and
> replaced by pr_warn, using pr_warn in tools lib bpf for symmetry
> to kernel logging macro, then we could drop pr_warning in the
> whole linux code.
> 
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Martin KaFai Lau <kafai@fb.com>
> Cc: Song Liu <songliubraving@fb.com>
> Cc: Yonghong Song <yhs@fb.com>
> Cc: bpf@vger.kernel.org
> Acked-by: Andrii Nakryiko <andriin@fb.com>
> Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>  tools/lib/bpf/btf.c             |  56 +--
>  tools/lib/bpf/btf_dump.c        |  18 +-
>  tools/lib/bpf/libbpf.c          | 679 ++++++++++++++++----------------
>  tools/lib/bpf/libbpf_internal.h |   8 +-
>  tools/lib/bpf/xsk.c             |   4 +-
>  5 files changed, 379 insertions(+), 386 deletions(-)

Nack.
I prefer this type of renaming to go via bpf tree.
It's not a kernel patch. It's touching user space library
which is under heavy development.
Doing any other way will cause a ton of conflicts.

