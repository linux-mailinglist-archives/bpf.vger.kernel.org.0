Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B34B8B2732
	for <lists+bpf@lfdr.de>; Fri, 13 Sep 2019 23:26:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387637AbfIMVZx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 13 Sep 2019 17:25:53 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:42270 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389617AbfIMVZu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 13 Sep 2019 17:25:50 -0400
Received: by mail-lj1-f194.google.com with SMTP id y23so28408644lje.9
        for <bpf@vger.kernel.org>; Fri, 13 Sep 2019 14:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SqwwqelpURFmzfGjcJ7oMuOIQ2kIqB4BOKfM3/6ZLAw=;
        b=WnMuApb47J6Z0Rih0VYsR4YDdRoc78S/yxGZJAvId+d8Yg1MDSWITJwp7ZHrb+BWJV
         HQb6CVECMx0VXHfotKY+2mVS5HDo5ua/8sNi6JTgrD7fxuehRYGKwiVO568kKzNs5ewW
         93a2BV+VKPvyw3og+4qjBC5AD/FEOB8lANOlb6ZKcnvp3ia5ouQIgDbBPdoJQ8Fd8BVd
         TrqxaefOXxrS+sFrw315ejQi9GmrxDFxb54ELx0uI1Xgv9fxrG66XXAw0WTecgnPnvr4
         yaxlvgFYy6yZHXPtXCVPkBkjSNUc06neLsA73Jr6/8rYwo63cGGSYwRIZWRfeANuO3uE
         rGAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=SqwwqelpURFmzfGjcJ7oMuOIQ2kIqB4BOKfM3/6ZLAw=;
        b=cl5JAA8pSYOj2/HF99Gr7n6DkaxljuPTq6HLhf7LgJqre+rVNlY7YPFFLefBz30qE7
         49dhEo/aQW5G/Ol/2LgozkpHFaSYVTzRwY7GN5TDEPrf2jcf9e4uvQ+/gIO3NxXuSDyM
         dgfi0X9e/loPKX0gFycbTTPPrTmvIzB4qL7/CIlJtXesbCI6uXSwUxjYA95xu2G8UpBJ
         4SGcu4VPAlpDK6rv+0FXE5BBVNC6fLsvg4snYESWqxSZVEwPzSwlWm/ylH/L8U2kvrbu
         HXZxejxKr1P6hGbl1lVP5QPiWADFoXmhs7TRHVAYxXYQlVdg4cAJIPVq7VNCFc+fboWp
         c2wg==
X-Gm-Message-State: APjAAAUATNaOaXX7tUWwTOhSqiFlUEvmZGb1u8ph/ahMlgZzsnTSK3ux
        R/ZlOhycg6L2aYs6PzpbzdNRYQ==
X-Google-Smtp-Source: APXvYqzGOytq6JjzyFTSvv67HdgbwowjWgQmmIFRHLTWAVYagXaSOG/LQY+ywezFZ1zJzyx+H/qbbA==
X-Received: by 2002:a2e:99c1:: with SMTP id l1mr25527331ljj.8.1568409948002;
        Fri, 13 Sep 2019 14:25:48 -0700 (PDT)
Received: from khorivan (168-200-94-178.pool.ukrtel.net. [178.94.200.168])
        by smtp.gmail.com with ESMTPSA id y3sm7053303lfh.97.2019.09.13.14.25.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 13 Sep 2019 14:25:47 -0700 (PDT)
Date:   Sat, 14 Sep 2019 00:25:45 +0300
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     Yonghong Song <yhs@fb.com>
Cc:     "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "jakub.kicinski@netronome.com" <jakub.kicinski@netronome.com>,
        "hawk@kernel.org" <hawk@kernel.org>,
        "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "clang-built-linux@googlegroups.com" 
        <clang-built-linux@googlegroups.com>
Subject: Re: [PATCH bpf-next 02/11] samples: bpf: makefile: fix
 cookie_uid_helper_example obj build
Message-ID: <20190913212544.GC26724@khorivan>
Mail-Followup-To: Yonghong Song <yhs@fb.com>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "jakub.kicinski@netronome.com" <jakub.kicinski@netronome.com>,
        "hawk@kernel.org" <hawk@kernel.org>,
        "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "clang-built-linux@googlegroups.com" <clang-built-linux@googlegroups.com>
References: <20190910103830.20794-1-ivan.khoronzhuk@linaro.org>
 <20190910103830.20794-3-ivan.khoronzhuk@linaro.org>
 <7f556c1c-abee-41a9-af83-1d72fc33af4b@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <7f556c1c-abee-41a9-af83-1d72fc33af4b@fb.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Sep 13, 2019 at 08:48:37PM +0000, Yonghong Song wrote:
>
>
>On 9/10/19 11:38 AM, Ivan Khoronzhuk wrote:
>> Don't list userspace "cookie_uid_helper_example" object in list for
>> bpf objects.
>>
>> per_socket_stats_example-opjs is used to list additional dependencies
>
>s/opjs/objs
>
>> for user space binary from hostprogs-y list. Kbuild system creates
>> rules for objects listed this way anyway and no need to worry about
>> this. Despite on it, the samples bpf uses logic that hostporgs-y are
>> build for userspace with includes needed for this, but "always"
>> target, if it's not in hostprog-y list, uses CLANG-bpf rule and is
>> intended to create bpf obj but not arch obj and uses only kernel
>> includes for that. So correct it, as it breaks cross-compiling at
>> least.
>
>The above description is a little tricky to understand.
>Maybe something like:
>    'always' target is for bpf programs.
>    'cookie_uid_helper_example.o' is a user space ELF file, and
>    covered by rule `per_socket_stats_example`.
>    Let us remove `always += cookie_uid_helper_example.o`,
>    which avoids breaking cross compilation due to
>    mismatched includes.

Yes, looks better, thanks.

-- 
Regards,
Ivan Khoronzhuk
