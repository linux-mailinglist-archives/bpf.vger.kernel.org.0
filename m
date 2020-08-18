Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBEB82489F0
	for <lists+bpf@lfdr.de>; Tue, 18 Aug 2020 17:33:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbgHRPdp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 18 Aug 2020 11:33:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727875AbgHRPdc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 18 Aug 2020 11:33:32 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F5C6C061343
        for <bpf@vger.kernel.org>; Tue, 18 Aug 2020 08:33:32 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id w17so15576447edt.8
        for <bpf@vger.kernel.org>; Tue, 18 Aug 2020 08:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=a6JBuZhVYWp23R6HGvWW9nRcBBE4mX5ykNxzEwYLGKc=;
        b=Ac/Dzu3FoXOA6oUvQv+5yd66VJmRWG0TPTYZXLVCZhZ4XGLWHKfhHvYLK89FQ+LGKK
         bU8jBb9tSJU/9bNKH2g389dVKDn23kZ3IeUw0+p9c6iVLightb+zUKKgg7pN6l8WM7XN
         dTrSvLt5iuvwFupu3p0EAeJnaCYoYuw/Vn51w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=a6JBuZhVYWp23R6HGvWW9nRcBBE4mX5ykNxzEwYLGKc=;
        b=J2qFE2sOJk5Isv+wwIw3xuZDK+KZUt9oByCWCc3TgWz/vKOCAKTBD+R14ZcyiwkBTD
         f4L2aDepF8RmDVUBrxatH+RPIwAxvLjDAqgIheBnuo1OEFSldBVXn6sdlgAuRjETmUoi
         wsi+MD8eVPYAkkGelrRvGxRnIEf7fe7AGpduTEgmSRkQJXkD/S7Yc6QSEvgkcIulcidR
         M8ybZxSX+ijLbisjx1MIPmY/MytyAKq4mIxuC8FkTo29A6IQPIh95xXF+Q3lQYRfHZ9X
         U6IEOhQMiIAFTt5isw1JumAFxD4WsbGokxWrPk6XurTIo4IYIcCvQ46LDB3lWzokfA2x
         9AIw==
X-Gm-Message-State: AOAM532Cv430xyT/666cz4+jS6FMNVgzH0gLU/3rvWTgVkdZWoOnwNxO
        SYR6ojjG4haTE8Od54w0OJTfPQ==
X-Google-Smtp-Source: ABdhPJwK0rMXcmZjLSnIfUTDa+I60/0YARRpPhkhaEKKvECvklhauoQ6XXcKSJeD0BL0upcmv4+7+Q==
X-Received: by 2002:a05:6402:3070:: with SMTP id bs16mr20055627edb.269.1597764810834;
        Tue, 18 Aug 2020 08:33:30 -0700 (PDT)
Received: from [192.168.2.66] ([81.6.44.51])
        by smtp.gmail.com with ESMTPSA id q2sm17169535edb.82.2020.08.18.08.33.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Aug 2020 08:33:30 -0700 (PDT)
Subject: Re: [PATCH bpf-next v8 5/7] bpf: Implement bpf_local_storage for
 inodes
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>
References: <20200803164655.1924498-1-kpsingh@chromium.org>
 <20200803164655.1924498-6-kpsingh@chromium.org>
 <20200818012758.4666zlknkr4x6cbl@kafai-mbp.dhcp.thefacebook.com>
 <60344fad-f761-0fee-a6ef-4880c45c3e52@chromium.org>
 <20200818152316.pkyko6gcpzeqp5sn@kafai-mbp.dhcp.thefacebook.com>
From:   KP Singh <kpsingh@chromium.org>
Message-ID: <9a1544ac-309b-4c16-3f6a-e34d90b275b8@chromium.org>
Date:   Tue, 18 Aug 2020 17:33:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200818152316.pkyko6gcpzeqp5sn@kafai-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 8/18/20 5:23 PM, Martin KaFai Lau wrote:
> On Tue, Aug 18, 2020 at 05:10:34PM +0200, KP Singh wrote:
>>
>>
>> On 8/18/20 3:27 AM, Martin KaFai Lau wrote:>>> On Mon, Aug 03, 2020 at 06:46:53PM +0200, KP Singh wrote:

[...]

a get_file
>> rather fcheck followed by get_file_rcu:
>>
>> #define get_file_rcu_many(x, cnt)	\
>> 	atomic_long_add_unless(&(x)->f_count, (cnt), 0)
>> #define get_file_rcu(x) get_file_rcu_many((x), 1)
>> #define file_count(x)	atomic_long_read(&(x)->f_count)
>>
>> But there is an easier way than all of this and this is to use 
>> fget_raw which also calls get_file_rcu_many 
>> and ensures a non-zero count before getting a reference.
> ic. Make sense.
> 
> There are fdget() and fdput() also which are used in bpf/syscall.c.

Yeah we could use fdget_raw but we don't really need the struct fd but just the 
struct file.

he non-raw versions masks away FMODE_PATH (O_PATH) files, we should still be able to
access blobs on the O_PATH files, thus the _raw version here.

- KP

> 
