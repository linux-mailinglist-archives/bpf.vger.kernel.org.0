Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B980B16FDFE
	for <lists+bpf@lfdr.de>; Wed, 26 Feb 2020 12:41:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728224AbgBZLli (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 26 Feb 2020 06:41:38 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38660 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726440AbgBZLlh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 26 Feb 2020 06:41:37 -0500
Received: by mail-wr1-f67.google.com with SMTP id e8so2599824wrm.5
        for <bpf@vger.kernel.org>; Wed, 26 Feb 2020 03:41:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=l84kH0yChire5nSS3J18bHwDxVZ3XKF79LqX2Bl4QM4=;
        b=rWSdu7FlWnB0rFyAV9TnO+iBV+CIfoJhxdvWoS3rbHqcexgRzEx/gvQoqw+6EwdIzB
         CcIwwftZoFpqxD0EbopTYtooJArBPSxCvmeB3sewuOrGNZ618abeYnWPQ8J4IXCXYoOt
         J5IOAIgPa+mqKPJPy5EMPYlipchKekhQXkMZEDzjt8VDOpAZ4frWea0wdOI6Br54rF9I
         QMJtdp83PP5uUyyh4Fq3oJIlnHcua72/f58TZnFm8iyBDlx4NnACgHkBebjai/BbTm0J
         AWOS1gg6XMC3wBLvmt+aD2zYmBgNWHcocotNk00isxrQzKgDvOk4cChMkKDn0VbPUYXh
         alKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=l84kH0yChire5nSS3J18bHwDxVZ3XKF79LqX2Bl4QM4=;
        b=szGp0ybesILCfPLNp/FponDDdGm+NhxveLAKtlQgzZTlAfC+cHELNA+UpjhfgCPi+p
         fP6FiG1Upyp81WXst1k9qHwpdVd2F82WvoSZW3KRgANZjqnU4D45Rmyvqn1Kd17jx/8t
         kdj9QUmnKa56C5//e08LyPULgJyNZonyB1d5BYvKKXJ/jdSwUNvB8t9gMcjJd02sTxxk
         OhDt1pNzi6lU4MiKpsL+H6CWQA6/7x2Y6Qv1a7JahXRdVkW9QDKpoQyv49aSNkVgAF4G
         GbPKH0lsKdEs/YeBpcQ/NIZpmwF1nItYDGOMUTqJoyK34V5JzUJUKj/yYGYLMb9xidhz
         jHcA==
X-Gm-Message-State: APjAAAXCCa5MnMeQMtaQq4iBtNRq5Mfsvo8QheM09ciMS6JHQw9Y05Gf
        3n0D/4eLkakudbhZtdm9RJTEX8MUzxg=
X-Google-Smtp-Source: APXvYqw4qt8UkZzzNCN9lgddHiORXUyHiHsD2S0kDv1iSUS5tc8gZFOFByIYNbvg7DtMZq3WUWTTiQ==
X-Received: by 2002:adf:fac3:: with SMTP id a3mr5177637wrs.370.1582717294040;
        Wed, 26 Feb 2020 03:41:34 -0800 (PST)
Received: from [192.168.1.10] ([194.35.116.65])
        by smtp.gmail.com with ESMTPSA id 133sm2731521wme.32.2020.02.26.03.41.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Feb 2020 03:41:33 -0800 (PST)
Subject: Re: [PATCH bpf-next] bpftool: Support struct_ops, tracing, ext prog
 types
To:     Andrey Ignatov <rdna@fb.com>, bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, kernel-team@fb.com
References: <20200225223441.689109-1-rdna@fb.com>
From:   Quentin Monnet <quentin@isovalent.com>
Message-ID: <6ca9d9bf-d7e0-d35b-0a89-b1417b9a9f2d@isovalent.com>
Date:   Wed, 26 Feb 2020 11:41:32 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200225223441.689109-1-rdna@fb.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

2020-02-25 14:34 UTC-0800 ~ Andrey Ignatov <rdna@fb.com>
> Add support for prog types that were added to kernel but not present in
> bpftool yet: struct_ops, tracing, ext prog types and corresponding
> section names.
> 
> Before:
>    # bpftool p l
>    ...
>    184: type 26  name test_subprog3  tag dda135a7dc0daf54  gpl
>            loaded_at 2020-02-25T13:28:33-0800  uid 0
>            xlated 112B  jited 103B  memlock 4096B  map_ids 136
>            btf_id 85
>    185: type 28  name new_get_skb_len  tag d2de5b87d8e5dc49  gpl
>            loaded_at 2020-02-25T13:28:33-0800  uid 0
>            xlated 72B  jited 69B  memlock 4096B  map_ids 136
>            btf_id 85
> 
> After:
>    # bpftool p l
>    ...
>    184: tracing  name test_subprog3  tag dda135a7dc0daf54  gpl
>            loaded_at 2020-02-25T13:28:33-0800  uid 0
>            xlated 112B  jited 103B  memlock 4096B  map_ids 136
>            btf_id 85
>    185: ext  name new_get_skb_len  tag d2de5b87d8e5dc49  gpl
>            loaded_at 2020-02-25T13:28:33-0800  uid 0
>            xlated 72B  jited 69B  memlock 4096B  map_ids 136
>            btf_id 85
> 
> Signed-off-by: Andrey Ignatov <rdna@fb.com>

Reviewed-by: Quentin Monnet <quentin@isovalent.com>

Thanks!
