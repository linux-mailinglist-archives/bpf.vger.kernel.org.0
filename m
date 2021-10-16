Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DE124301B4
	for <lists+bpf@lfdr.de>; Sat, 16 Oct 2021 11:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239987AbhJPJ7y (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 16 Oct 2021 05:59:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235573AbhJPJ7x (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 16 Oct 2021 05:59:53 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45BC5C061570
        for <bpf@vger.kernel.org>; Sat, 16 Oct 2021 02:57:46 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id s136so7688356pgs.4
        for <bpf@vger.kernel.org>; Sat, 16 Oct 2021 02:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mpOAixr3OFRGdoe91PDD9LeUpr0a8cKcJu5K7EQ3uGQ=;
        b=JAvSW+z0zH5mW19NfQLdGpTtMx5uvMBh9Ncmv/xzv5oOCvPSej7vQKnZt4lSgtil7R
         G4wr9u8bZM1XJQLsyrW27XwR1p9sFH6DmnkkMcaqitZ8PaoQI+xJQhTGjjLNfeapOh5J
         UyE6tYLKKDA5ltSQLzk1S7TjDczRs7/D2RzVDVagMVqoiwBwhDzyd2kOG0BEKYLz56nz
         hp7OhOEsh5BxnQVic4x+m6neopD8gFddkwR8SUVRXTOvvkf9xocJ98HXuBh28oFxf0Fu
         ouxlZEsFRdcbd+eHlavLtOpRdOUt0U3NZQewa87YPVE3Sy559rVXpZJc4gaCXwWhzCQJ
         Z7Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mpOAixr3OFRGdoe91PDD9LeUpr0a8cKcJu5K7EQ3uGQ=;
        b=TuZCovEu/37ptIMnG7PIGgoKX/QCJZwJkr9zZq8ghFAcqzsRGd0H/r9wnHU4hcFOph
         DNqsp1b5dj5Uit8iupKpYyh0fQ7itJWl+OtWFvGixMfqL1/Dmsnlo2YdQxMTVrJfLZSe
         JnvJwb67X8O2kKp9vZ4IhJHbIZvoaqTlJJHus0zFHQYdDeXwHRMiDKQT/5blQQJ27Df4
         X2p0TWHIj+ookBYSkOivDSJcPFq03kogpXDjneEHAC7AEWlSOQbjOrQTl3HYVi0fzabz
         NqnnKenSa31su/O1+aK+uNJyfHuWNQBjWVvsLdv3M1EuW2lIitP2fO7FxqieY+THiOeI
         Qlsw==
X-Gm-Message-State: AOAM532KIyAgGv8bYifNhF0dQi5bc0hpcam6LoCIpgFwt6CxNARC2bts
        rGAI1hTMUY6S0LBm1RUhyPs=
X-Google-Smtp-Source: ABdhPJxZBw7bzWVuP8lbk3O7qtXM6z6NYPYBwR54lBu50c84pcrzNoQJ/f1AOOsy/z/o07afNbNWGQ==
X-Received: by 2002:a05:6a00:24d6:b0:44c:df15:f52e with SMTP id d22-20020a056a0024d600b0044cdf15f52emr16907872pfv.36.1634378265831;
        Sat, 16 Oct 2021 02:57:45 -0700 (PDT)
Received: from [192.168.255.10] ([203.205.141.115])
        by smtp.gmail.com with ESMTPSA id o72sm7209316pjo.50.2021.10.16.02.57.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Oct 2021 02:57:45 -0700 (PDT)
Subject: Re: BUG: Ksnoop tool failed to pass the BPF verifier with recent
 kernel changes
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, alan.maguire@oracle.com,
        Yonghong Song <yhs@fb.com>
References: <800ce502-8f63-8712-7ed4-d3124a5fd6fb@gmail.com>
 <20211015193010.22frp6eat3wz54hq@kafai-mbp.dhcp.thefacebook.com>
From:   Hengqi Chen <hengqi.chen@gmail.com>
Message-ID: <da0a8a77-eb71-57c3-35b9-f1dcaeaa560d@gmail.com>
Date:   Sat, 16 Oct 2021 17:57:43 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211015193010.22frp6eat3wz54hq@kafai-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2021/10/16 3:30 AM, Martin KaFai Lau wrote:
> On Thu, Oct 14, 2021 at 12:35:42AM +0800, Hengqi Chen wrote:
>> Hi, BPF community,
>>
>>
>> I would like to report a possible bug in bpf-next,
>> hope I don't make any stupid mistake. Here is the details:
>>
>> I have two VMs:
>>
>> One has the kernel built against the following commit:
>>
>> 0693b27644f04852e46f7f034e3143992b658869 (bpf-next)
>>
>> The ksnoop tool (from BCC repo) works well on this VM.
>>
>>
>> Another has the kernel built against the following commit:
>>
>> 5319255b8df9271474bc9027cabf82253934f28d (bpf-next)
>>
>> On this VM, the ksnoop tool failed with the following message:
> I see the error in both mentioned bpf-next commits above.
> I use the latest llvm and bcc from github.
> 
> Can you confirm which llvm version (or llvm git commit) you are using
> in both the good and the bad case?
> 

Indeed, this could be the problem of LLVM, not the kernel.

The following is the version info of my environment:

The good one:

	llvm-config-14 --version
	14.0.0

	clang -v     
	Ubuntu clang version 14.0.0-++20210915052613+c78ed20784ee-1~exp1~20210915153417.547
	Target: x86_64-pc-linux-gnu
	Thread model: posix
	InstalledDir: /usr/bin
	Found candidate GCC installation: /usr/bin/../lib/gcc/x86_64-linux-gnu/9
	Selected GCC installation: /usr/bin/../lib/gcc/x86_64-linux-gnu/9
	Candidate multilib: .;@m64
	Selected multilib: .;@m64

The bad one:

	llvm-config-14 --version
	14.0.0

	clang -v         
	Ubuntu clang version 14.0.0-++20211008104411+f4145c074cb8-1~exp1~20211008085218.709
	Target: x86_64-pc-linux-gnu
	Thread model: posix
	InstalledDir: /usr/bin
	Found candidate GCC installation: /usr/bin/../lib/gcc/x86_64-linux-gnu/10
	Found candidate GCC installation: /usr/bin/../lib/gcc/x86_64-linux-gnu/11
	Found candidate GCC installation: /usr/bin/../lib/gcc/x86_64-linux-gnu/9
	Selected GCC installation: /usr/bin/../lib/gcc/x86_64-linux-gnu/11
	Candidate multilib: .;@m64
	Selected multilib: .;@m64
