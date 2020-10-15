Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C92628F162
	for <lists+bpf@lfdr.de>; Thu, 15 Oct 2020 13:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728124AbgJOLYn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 15 Oct 2020 07:24:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727736AbgJOLYG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 15 Oct 2020 07:24:06 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4559C061755;
        Thu, 15 Oct 2020 04:24:05 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id n15so3011677wrq.2;
        Thu, 15 Oct 2020 04:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3I0P08vNaQzgXoL9rCvvnpgGw7KyV9D8ViZvp/Lcn6s=;
        b=GA8BbyLOTTUBvhKPL+heprvfYzsNBiCMAxJMYy0/AJJtI0lP01IeXgRR8yWgnVEDLc
         8ldtbGqRI9P2uAUoL03HFwi5dWLVFJnZ3Aetj62avK/6Mo5xxpfsMHQy2BrvzpkyQgaR
         uYAskzZaFS+t+kkUVZJBnOeWGt4EqF/javGOQVJ2uEApe97rh5U5Zk16xL7XRhfYKPLE
         gtlsZvRXR0yfy9w9K8KFZp2zpixzNvKFfpTMhfHa/BcFgiuoc/POCluJybykDFIyfpXd
         gzaDaIDqZS7MuqVxMLrzVTye//Cs00bcFZpKDMZ/jlpPKK2iL+Hn5ImKPj5RW+deFPMY
         1PvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3I0P08vNaQzgXoL9rCvvnpgGw7KyV9D8ViZvp/Lcn6s=;
        b=BlA7mMVWPOwbuSgWiCVcztegh0VxCm8CVl+pPOlBIvi4mL7sK/wWN6oMnf5qPTx0FK
         F+E0Hg3z42oDJiCBJBrHckoN3F7CjU/2st2EP1rX88mU+h9eiYvYU0tMynhPtkd7Lytc
         C7y1gBLWsAlhIrKVrt5vM9bD2P/sxLonnupqt86ytVixNY1bBHDAVXfAiyjsHUpdeYdv
         9h+wMHKOUoCHE/9h9f9T1Kph6Hv7lnNLguRSkAxv/ub7ftEEp0ocVNB1YfpNKyA0T50Z
         ROviLHwNeF82cuy6GZ+AbUMI2Qo1GuA/SUiufImcI3BmPYpYBmu27ipm5pms3bV9LLeU
         ncrA==
X-Gm-Message-State: AOAM530oO6nLdW7qXeeNE8yJwgUHk/CddyfxVmAAw89Ve1DB4ZGgaHxf
        nrHaP764DyhuV4F4zpBN4k4=
X-Google-Smtp-Source: ABdhPJzb6M1OrC9nHpzbrwyV+nSGdr5lyNygxRFdgLbzIwScpgFYrjGw7EHJFCs1NG0j4AIYHz91Hw==
X-Received: by 2002:a05:6000:18d:: with SMTP id p13mr3770081wrx.248.1602761044681;
        Thu, 15 Oct 2020 04:24:04 -0700 (PDT)
Received: from [192.168.1.10] (static-176-175-73-29.ftth.abo.bbox.fr. [176.175.73.29])
        by smtp.gmail.com with ESMTPSA id t83sm4373249wmf.39.2020.10.15.04.24.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Oct 2020 04:24:03 -0700 (PDT)
Cc:     mtk.manpages@gmail.com, Tycho Andersen <tycho@tycho.pizza>,
        Sargun Dhillon <sargun@sargun.me>,
        Christian Brauner <christian@brauner.io>,
        linux-man <linux-man@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>, Jann Horn <jannh@google.com>,
        Alexei Starovoitov <ast@kernel.org>, wad@chromium.org,
        bpf@vger.kernel.org, Song Liu <songliubraving@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andy Lutomirski <luto@amacapital.net>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Robert Sesek <rsesek@google.com>
Subject: Re: For review: seccomp_user_notif(2) manual page
To:     Kees Cook <keescook@chromium.org>
References: <45f07f17-18b6-d187-0914-6f341fe90857@gmail.com>
 <202009301632.9C6A850272@keescook>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <c1cc0df8-bd06-51e7-d5a0-888c1955683b@gmail.com>
Date:   Thu, 15 Oct 2020 13:24:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <202009301632.9C6A850272@keescook>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello Kees,

On 10/1/20 1:39 AM, Kees Cook wrote:
> On Wed, Sep 30, 2020 at 01:07:38PM +0200, Michael Kerrisk (man-pages) wrote:
>> [...] I did :-)
> 
> Yay! Thank you!

You're welcome :-)

>> [...]
>>    Overview
>>        In conventional usage of a seccomp filter, the decision about how
>>        to  treat  a particular system call is made by the filter itself.
>>        The user-space notification mechanism allows the handling of  the
>>        system  call  to  instead  be handed off to a user-space process.
>>        The advantages of doing this are that, by contrast with the  sec‐
>>        comp  filter,  which  is  running on a virtual machine inside the
>>        kernel, the user-space process has access to information that  is
>>        unavailable to the seccomp filter and it can perform actions that
>>        can't be performed from the seccomp filter.
> 
> I might clarify a bit with something like (though maybe the
> target/supervisor paragraph needs to be moved to the start):
> 
> 	This is used for performing syscalls on behalf of the target,
> 	rather than having the supervisor make security policy decisions
> 	about the syscall, which would be inherently race-prone. The
> 	target's syscall should either be handled by the supervisor or
> 	allowed to continue normally in the kernel (where standard security
> 	policies will be applied).

You, Christian, and Jann all pulled me up on this point. And thanks; 
I'm going to use some of your words above. See my reply to Jann, sent
at about the same time as this reply. Please take a look at the text
in my reply to Jann, and let me know what you think.

> I'll comment more later, but I've run out of time today and I didn't see
> anyone mention this detail yet in the existing threads... :)

Later never came :-). But, I hope you may have comments for the 
next draft, which I will send out soon.

Thanks,

Michael

-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
