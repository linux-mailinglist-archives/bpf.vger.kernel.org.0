Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39ACB43FEBC
	for <lists+bpf@lfdr.de>; Fri, 29 Oct 2021 16:54:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbhJ2O4b (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 29 Oct 2021 10:56:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbhJ2O4a (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 29 Oct 2021 10:56:30 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58F03C061570
        for <bpf@vger.kernel.org>; Fri, 29 Oct 2021 07:54:02 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id q187so10176111pgq.2
        for <bpf@vger.kernel.org>; Fri, 29 Oct 2021 07:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=4AuMATFjpbWTZ0I+UQqUufcg225mt5ZMICnMbvDg+1c=;
        b=UqAJD3EsmUrq0vYya3aSXA9/SSthOtLtjisA6YqGtPD/9zoz1wNJL3p/YoPQWmtcrb
         E8HuOahKfoSlTYgFdK2AFrHzvnifZq/HyiNrnXAk5IH2IibId00aVlpx1lq6XMvIUjOm
         oy+l265CPz+yyDh3To+spKQrKdzgHPzcR7FZSkbqjDmwbQflAlm21FDW5CN28xzlLRPS
         wXPEvF5fl8+BjKQUw78GupShBsOaBB+Ybfju2XPkVE/W+H6uExbSFXVcp0UWYQkCH91r
         ZdkM0/LOuURF3zAYXIf1pYjc/XGJ6q3a7KF6QMvnE0Sr6zisl3otQ0rHsJv/62lNGqlI
         zU9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4AuMATFjpbWTZ0I+UQqUufcg225mt5ZMICnMbvDg+1c=;
        b=jJt2NSqae5mk51ljyVW2aKN9glf8cKOu2YZyTTSb3MqH51She+xH27BLQliEzEnmrO
         XQzT7pxS2XXodgxCbUvPu4ndCoG8kb4ZcviqXknJfM+JWVV53kq86a/JeD6Tkcgj4aTi
         2M6LQNJZyZ11uWPKsdgZbWm4T8Yiy1ZlefH+0U7lHWnojRcajJpsrUSFqAOwf4DQVk3Q
         8RuqPvWETZhEV4utLeeZ9luEg4k23zjSoXeh/n1T8dMMybZfumK5XNmKB3syT2v49ez7
         +GA18mpat2FU5EveJoX0U4rJwN1x5TgWcWMJf4dYI8mDF1AZDbOMf0A5eii+/b+ODvSM
         XqGQ==
X-Gm-Message-State: AOAM531WQjd2l4yzfF6f5AQU5VfHRJJW8f5mn8fsy4a/Z0WjyJ+02837
        68hnDncm7nQDRWKAyAVZ1y3TCUxi6BzZGg==
X-Google-Smtp-Source: ABdhPJwwbEf6zpdpALTBZM1s3rXj/nVxxSNUS2i4eTc7FxG3JTde4ZQluzi28M0KtJV6WV/Hh/rvXA==
X-Received: by 2002:a63:7a53:: with SMTP id j19mr8433987pgn.275.1635519241744;
        Fri, 29 Oct 2021 07:54:01 -0700 (PDT)
Received: from [0.0.0.0] ([150.109.126.7])
        by smtp.gmail.com with ESMTPSA id k8sm7721459pfu.179.2021.10.29.07.54.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Oct 2021 07:54:01 -0700 (PDT)
Subject: Re: Read large payload from struct mm_struct without ring buffer
To:     Yadunandan Pillai <ytpillai@thesw4rm.com>, bpf@vger.kernel.org
References: <20211026180110.nfgozwtq7diptye7@bigdesk>
From:   Hengqi Chen <hengqi.chen@gmail.com>
Message-ID: <f8b84cfa-7571-7594-ef5f-9aa278a9b428@gmail.com>
Date:   Fri, 29 Oct 2021 22:53:59 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211026180110.nfgozwtq7diptye7@bigdesk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 10/27/21 2:01 AM, Yadunandan Pillai wrote:
> I am intercepting sched_wakeup_new and am able to read command line
> arguments for an event using active_mm within the current task_struct.
> However, the maximum size for these arguments is way beyond the stack
> size of an eBPF program. Is there a way to read such a large payload
> into userspace?
> 
> I'm trying to maintain backwards compatibility so unfortunately ringbuf
> is not an option for the time being. I've tried reading the payload
> directly into a hashmap, but unfortunately can't read past 512 bytes
> (max buffer size). Is there another way to reserve large amounts of
> memory in a separate location and get a direct reference, so I can read
> into it with something like bpf_probe_read?
> 

You can use a per-cpu array as a heap storage for that purpose.
Please refer to Andrii's blog post ([0]) and a real-world application ([1]).

  [0]: https://nakryiko.com/posts/bpf-ringbuf/#bpf-perfbuf-bpf-perf-event-output
  [1]: https://github.com/iovisor/bcc/blob/master/libbpf-tools/mountsnoop.bpf.c

Cheers,
--
Hengqi
