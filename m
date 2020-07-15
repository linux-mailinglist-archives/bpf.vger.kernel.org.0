Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC60922138A
	for <lists+bpf@lfdr.de>; Wed, 15 Jul 2020 19:35:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726425AbgGORft (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Jul 2020 13:35:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725926AbgGORft (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 15 Jul 2020 13:35:49 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0AD6C08C5CE
        for <bpf@vger.kernel.org>; Wed, 15 Jul 2020 10:35:48 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id j18so6367218wmi.3
        for <bpf@vger.kernel.org>; Wed, 15 Jul 2020 10:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Q65viUzdrydGJbsUBZqfq3TsrTZ1vpIGmSYJcwDvo4I=;
        b=WT0ynYvujO8rhdkbtlk6GTCwf4wFQxxdoFjz4smc2tzHQx0crhb+FClHGm/gXS8pQF
         +Zekcogtx3fRG3NuSAL9SstXPfXWRrhfCfuufqJnkt5S73Ow2Dq1V9hG/XyOc+vo2/2u
         i8XL4ZFJ2EEHatMIsqh2BlCfTsF+rv7XhC1BBXh9ZG+Ty6hEWy3bdkdw0ejKAvD5s7ZV
         J36sDlSXh5TPmLtYIU9id1bzU+Mx7yymzCqiQPPiOpBEf2gOMM2INnLRKxZFZlaPv7d/
         HcxsH6zy1EtynjCDoH6qPDTE3EbOy5sZRayEDBLSdt3L5AV/hEQvzCn5J1v9oSjFLpC9
         DG/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Q65viUzdrydGJbsUBZqfq3TsrTZ1vpIGmSYJcwDvo4I=;
        b=RSfQyg1FgKEmzdNAkPnBkb2Z8Vrs0ys23cJ4HmhZXqfv8h70VJ9z1XkQNa2XwCskmd
         1WSwSqlmVX01x/v3nWabwLTWq2H76PFv3auYW1Y9Tn1FqwiJ0bPqt68ghgaUdGwbekkU
         tjBtZLBV1qeyFFvfczEq2r79gnVBKclVbWqE8sM/tSSxPbfKiCauAlx8VHQDMo/WtV2b
         G9jxnR9oDbAcQ3oKVzPEOrJIOWP5GeSlbSwjzPTKqm66zNv41CHkXwsi8BCuxsO/M7Qo
         seUaGDTn31vnvQ79H12oMe3tV7tE2EYNr+ULqP+euP2cWhXMb1diHIDG80OLzGrHM7fR
         Lp9A==
X-Gm-Message-State: AOAM5327f5lhqT15EPYlorkQIfHJkgNvOBA/amPgKh8JDjV0oOnlV/ru
        a2olNr8t7Wd2dz+4B7ryew9h/8tc0gVJ8iqt
X-Google-Smtp-Source: ABdhPJwX2QGERZOZRB/kcqI5fGr2YfV9UaZcTQLs9XThkVw5+jnwFt+apC6qOm03RkYoP90nxubgWQ==
X-Received: by 2002:a1c:e908:: with SMTP id q8mr524283wmc.59.1594834547085;
        Wed, 15 Jul 2020 10:35:47 -0700 (PDT)
Received: from [192.168.1.12] ([194.35.117.104])
        by smtp.gmail.com with ESMTPSA id d132sm4259736wmd.35.2020.07.15.10.35.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jul 2020 10:35:46 -0700 (PDT)
Subject: Re: [PATCH bpf-next] bpftool: use only nftw for file tree parsing
To:     Tony Ambardar <tony.ambardar@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org
References: <20200715051214.28099-1-Tony.Ambardar@gmail.com>
From:   Quentin Monnet <quentin@isovalent.com>
Message-ID: <58fadc96-2083-a043-9ef3-da72ad792324@isovalent.com>
Date:   Wed, 15 Jul 2020 18:35:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200715051214.28099-1-Tony.Ambardar@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

2020-07-14 22:12 UTC-0700 ~ Tony Ambardar <tony.ambardar@gmail.com>
> The bpftool sources include code to walk file trees, but use multiple
> frameworks to do so: nftw and fts. While nftw conforms to POSIX/SUSv3 and
> is widely available, fts is not conformant and less common, especially on
> non-glibc systems. The inconsistent framework usage hampers maintenance
> and portability of bpftool, in particular for embedded systems.
> 
> Standardize usage by rewriting one fts-based function to use nftw. This
> change allows building bpftool against musl for OpenWrt.
> 
> Signed-off-by: Tony Ambardar <Tony.Ambardar@gmail.com>

Thanks!

I tested your set, and bpftool does not compile on my setup. The
definitions from <ftw.h> are not picked up by gcc, common.c should have
a "#define _GNU_SOURCE" above its list of includes for this to work
(like perf.c has).

I also get a warning on this line:


> +static int do_build_table_cb(const char *fpath, const struct stat *sb,
> +			    int typeflag, struct FTW *ftwbuf)
>  {

Because passing fptath to open_obj_pinned() below discards the "const"
qualifier:

> +	fd = open_obj_pinned(fpath, true);

Fixed by having simply "char *fpath" as the first argument for
do_build_table_cb().

With those two modifications, bpftool compiles fine and listing objects
with the "-f" option works as expected.

Regards,
Quentin
