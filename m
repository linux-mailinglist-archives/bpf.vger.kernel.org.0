Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ABA7312684A
	for <lists+bpf@lfdr.de>; Thu, 19 Dec 2019 18:39:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbfLSRjM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 19 Dec 2019 12:39:12 -0500
Received: from mta-p5.oit.umn.edu ([134.84.196.205]:56806 "EHLO
        mta-p5.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726840AbfLSRjL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 19 Dec 2019 12:39:11 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p5.oit.umn.edu (Postfix) with ESMTP id 47dzdW2Pf9z9vbXY
        for <bpf@vger.kernel.org>; Thu, 19 Dec 2019 17:39:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p5.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p5.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id wmJjmDKzrIiM for <bpf@vger.kernel.org>;
        Thu, 19 Dec 2019 11:39:11 -0600 (CST)
Received: from mail-yw1-f69.google.com (mail-yw1-f69.google.com [209.85.161.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p5.oit.umn.edu (Postfix) with ESMTPS id 47dzdW13FZz9vbXk
        for <bpf@vger.kernel.org>; Thu, 19 Dec 2019 11:39:11 -0600 (CST)
Received: by mail-yw1-f69.google.com with SMTP id o200so4481266ywd.22
        for <bpf@vger.kernel.org>; Thu, 19 Dec 2019 09:39:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=subject:to:cc:references:in-reply-to:from:message-id:date
         :user-agent:mime-version:content-language:content-transfer-encoding;
        bh=AzwXwPyqLdMgiqxoaURBqE7zGRBLFphXTk6J0tyQ+1Q=;
        b=WZFzVAbwy+PD3mfPyPnG/lqPzt5jire3SR0Dmi4ESDMbYrL0YMqDXS/gnwFGLUOpJX
         Aph8hlbuNcPcKp1ouVSPSXKSu3cYdI1TbqcG5bChV3gwEvctRuldGeFualjy82R6o9g4
         itwTPUbaq0V5y5zcTp6RzoR8KklzaE7+9TwCIgaR5odfvBOPFtgZrIk2SJKQTlaS5mFX
         HCyYhhPuNqm3lZQjg/w+e8k/ksVL+X0kVSQJlkSYxsoQ2cO9SQKhWCyr51NhBd4yXCpC
         4Z/X7zfDYL0K3qYHVxReQo67gdRjwVE64kFRNu6kDtVAvaoQWhMQqyfKOuiusJ2tiBQv
         DkMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:in-reply-to:from
         :message-id:date:user-agent:mime-version:content-language
         :content-transfer-encoding;
        bh=AzwXwPyqLdMgiqxoaURBqE7zGRBLFphXTk6J0tyQ+1Q=;
        b=gzX7vi2iYBX+Jlf08bBlc3LRb/L3QCN2C0rCxb7x1j6/6PbA/KM8xarVYqm+9U007F
         SwBVoSNj/SFSwKfzEso9VaDXzgkvvFuDJg/Kg6hhYiSRMWihgQ/Zb+yarfzIgXKOiUM1
         On0c43QM5Wv0gNgo4Tb0Q+YjbFHxAkCVcduytBbeIqzmgsj57UNZXq5airTYcVjCPqL2
         0kXcbnJWqjmEyhxT/rCi0+InDIViwZsfpm+0sDTuEik6BSDILWBbKQPpXiMtnZ23D+uI
         bcrrjHsfg1PH5p2bivemP6YuX3ty3NyfIkki9UBj+Z629fb85L0UmUud15PjO9wl3Mrv
         sPzA==
X-Gm-Message-State: APjAAAUtgP8eIWaWRzc0VjTtnxzVY+CJs9XkKTJOoR8wrmwi28C/559h
        /0u+Hd/SdQe9aaHGiVPTTyzolRFlld4witcOAJ8mdSfZV7eeH6uSWkWqdDAnjhZ93x2m0xFD5QZ
        5nH7GMfSKJcYAk5Ur
X-Received: by 2002:a81:6707:: with SMTP id b7mr7101428ywc.36.1576777150477;
        Thu, 19 Dec 2019 09:39:10 -0800 (PST)
X-Google-Smtp-Source: APXvYqzP14w1/YKStiE4g89ZmMAeIFFU+TvL1hgLMP0XOo/Xbf7zuSSnJT6rWdWDvw3RwIwm9Zx+oA==
X-Received: by 2002:a81:6707:: with SMTP id b7mr7101408ywc.36.1576777150217;
        Thu, 19 Dec 2019 09:39:10 -0800 (PST)
Received: from [128.101.106.66] (cs-u-syssec1.cs.umn.edu. [128.101.106.66])
        by smtp.gmail.com with ESMTPSA id q1sm2854283ywa.82.2019.12.19.09.39.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Dec 2019 09:39:09 -0800 (PST)
Subject: Re: [PATCH] bpf: Replace BUG_ON when fp_old is NULL
To:     Daniel Borkmann <daniel@iogearbox.net>, Yonghong Song <yhs@fb.com>
Cc:     "kjlu@umn.edu" <kjlu@umn.edu>, Alexei Starovoitov <ast@kernel.org>,
        Martin Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20191215154432.22399-1-pakki001@umn.edu>
 <98c13b9c-a73a-6203-4ea1-6b1180d87d97@fb.com>
 <566f206c-f133-6f68-c257-2c0b3ec462fa@iogearbox.net>
In-Reply-To: <566f206c-f133-6f68-c257-2c0b3ec462fa@iogearbox.net>
From:   Aditya Pakki <pakki001@umn.edu>
Message-ID: <51dcca79-f819-8ebb-308e-210a0d76b1cc@umn.edu>
Date:   Thu, 19 Dec 2019 11:39:08 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 12/16/19 5:17 AM, Daniel Borkmann wrote:
> On 12/15/19 11:08 PM, Yonghong Song wrote:
>> On 12/15/19 7:44 AM, Aditya Pakki wrote:
>>> If fp_old is NULL in bpf_prog_realloc, the program does an assertion
>>> and crashes. However, we can continue execution by returning NULL to
>>> the upper callers. The patch fixes this issue.
>>
>> Could you share how to reproduce the assertion and crash? I would
>> like to understand the problem first before making changes in the code.
>> Thanks!
> 
> Fully agree, Aditya, please elaborate if you have seen a crash!

Thanks for your responses Alexei and Daniel. We identified this issue via static analysis
and have not seen a crash. However, by looking at the callers of bpf_prog_realloc, I do 
agree that fp_old is never NULL. 

Would you recommend removing the BUG_ON assertion altogether ?
