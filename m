Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE932CC960
	for <lists+bpf@lfdr.de>; Sat,  5 Oct 2019 12:32:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727671AbfJEKcW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 5 Oct 2019 06:32:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41742 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727663AbfJEKcW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 5 Oct 2019 06:32:22 -0400
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com [209.85.208.199])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0FC4656F9
        for <bpf@vger.kernel.org>; Sat,  5 Oct 2019 10:32:22 +0000 (UTC)
Received: by mail-lj1-f199.google.com with SMTP id i18so2358648ljg.14
        for <bpf@vger.kernel.org>; Sat, 05 Oct 2019 03:32:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=xEOpG4bsmUSfRZlD4oRk66x9TPyoiZQEqXQbP3ed//Q=;
        b=uM2SaAicA27LnUFlcouUNx8GO8GkQPhIKF5zoH7qmn43s7hpRJpQNxNSDqt5hGbWxo
         ILRnkL3zvtOP6xVGu1m/x7FlLfHzsvL/+ptcNu7k1l7nBq3XxfdKqrloUThs5l2B9gcz
         EvUImfZsOQrXZH1ohdTBZ6ZNhoQWGKjh1JZfbj5RR3xybWWU/O/XhPP4xJgPb3jVNpEQ
         OdoRzhnNzMBBMJQd2lPJ/EfG7bRBvhisZCBvMAutIa2s2yHBmFYADBWMdM+6NF/dyXf/
         opd97XGwC4XWotyn7uEeMxGpWnBvk6OZ2U/e47Uh2VvtrE04zt/dL5DGjwyaoOnwxCtr
         K5mA==
X-Gm-Message-State: APjAAAXYVTgOjDUKj6Gqjid4473tnHv3z5yifU5JrGUChqGvqqEMbPF6
        xm/cDkW19CsSRIUUgCu7dD4zhp7FRaZ5DB4Vme4LEdxtwx6jnaUTDVT4ADVKKD5UlZ/5SQ4wyc+
        c+ioSLGjIUIvL
X-Received: by 2002:a2e:8603:: with SMTP id a3mr12269764lji.98.1570271540585;
        Sat, 05 Oct 2019 03:32:20 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwf0fExKtOtQdIInSG5yC6hGt3qpaIrZZdE3x9boKQMuMNpjHjXDiNStm8X3U55Q5ZLPaqueA==
X-Received: by 2002:a2e:8603:: with SMTP id a3mr12269752lji.98.1570271540379;
        Sat, 05 Oct 2019 03:32:20 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a00:7660:6da:443::2])
        by smtp.gmail.com with ESMTPSA id k7sm1736706lja.19.2019.10.05.03.32.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Oct 2019 03:32:19 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id D646018063D; Sat,  5 Oct 2019 12:32:18 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Jakub Kicinski <jakub.kicinski@netronome.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Marek Majkowski <marek@cloudflare.com>,
        Lorenz Bauer <lmb@cloudflare.com>,
        Alan Maguire <alan.maguire@oracle.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next v2 1/5] bpf: Support injecting chain calls into BPF programs on load
In-Reply-To: <20191004161715.2dc7cbd9@cakuba.hsd1.ca.comcast.net>
References: <157020976030.1824887.7191033447861395957.stgit@alrua-x1> <157020976144.1824887.10249946730258092768.stgit@alrua-x1> <20191004161715.2dc7cbd9@cakuba.hsd1.ca.comcast.net>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Sat, 05 Oct 2019 12:32:18 +0200
Message-ID: <877e5jo53h.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Jakub Kicinski <jakub.kicinski@netronome.com> writes:

>> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
>> index 5b9d22338606..753abfb78c13 100644
>> --- a/include/linux/bpf.h
>> +++ b/include/linux/bpf.h
>> @@ -383,6 +383,7 @@ struct bpf_prog_aux {
>>  	struct list_head ksym_lnode;
>>  	const struct bpf_prog_ops *ops;
>>  	struct bpf_map **used_maps;
>> +	struct bpf_array *chain_progs;
>>  	struct bpf_prog *prog;
>>  	struct user_struct *user;
>>  	u64 load_time; /* ns since boottime */
>> @@ -443,6 +444,7 @@ struct bpf_array {
>>  
>>  #define BPF_COMPLEXITY_LIMIT_INSNS      1000000 /* yes. 1M insns */
>>  #define MAX_TAIL_CALL_CNT 32
>> +#define BPF_NUM_CHAIN_SLOTS 8
>
> This could be user arg? Also the behaviour of mapping could be user
> controlled? Perhaps even users could pass the snippet to map the
> return code to the location, one day?

(Forgot to reply to this point).

Yeah, we could make it user-configurable. Or just dynamically increase
the size of the array if we run out. Or do something different with
linked list, as I alluded to in the other reply :)

-Toke
