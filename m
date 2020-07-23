Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3ECD22AE6A
	for <lists+bpf@lfdr.de>; Thu, 23 Jul 2020 13:52:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728755AbgGWLwG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Jul 2020 07:52:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728666AbgGWLwF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Jul 2020 07:52:05 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 443EBC0619DC
        for <bpf@vger.kernel.org>; Thu, 23 Jul 2020 04:52:05 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id 9so4679516wmj.5
        for <bpf@vger.kernel.org>; Thu, 23 Jul 2020 04:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NZpJnIVSkJItlVzX7BU0eJ1NGmH1x+ATcfuITedLtig=;
        b=ktInN0BkhURtuR83134zOeql/UFN3ASBDoe3ryIQAD7q1ahSWK29E4Vua6VXmbds07
         5dl9Wur6XxmkBYAY8GRyqUeedQPdRgf3M1Dz9bT/Y064Dflg1U9tR2/eV47cXNYWg1v8
         Zzch04KO2wxu0zcLZbnhZsuCnyj4rDYgHdaG4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NZpJnIVSkJItlVzX7BU0eJ1NGmH1x+ATcfuITedLtig=;
        b=GKr0SyzRKR5HWHGOtKv7G8/ZRCb9we1rEOoTYYAAn1hD/3ihsO7seoejXtHRPamQqw
         q2IqrJIr9fpPscyd4SHtIj0oM7VnIJWjgUSE3x6OW38jjur8L9AvNDvsDj0zsG1cU6VY
         HBwFJ7AE/t6CtjdQZj6YwD8Nej010vYlCnI/HI8c2gam1EGRVIAXC/EhdP5qLvVw4eOC
         XgCl79btHaSRuSScglhZXEOnIX3n7Or+XFSvYYYNqGQOF8enwZheYJyebRUWWmQ6B/EW
         EDNct7xfdQLVNTlI7QxeivuqfzvfAEu1/AnYKwTAAn8QWce9HEyUCr6gHTCSoEOob0F0
         9q8A==
X-Gm-Message-State: AOAM533J1ATGZmvNCLUiM8k8UP5JVi825SXv3Zpok5Dz4319gbQa+kKf
        ZLBQO4pNBb+aUxN5wk1BEiFt4w==
X-Google-Smtp-Source: ABdhPJx5kpjbbRmNFCzRww6zSgYNNCQm73V4u/MTpsk8pd8BfUKI6aPsdfQk8ek0oBVK2gQdotXUiw==
X-Received: by 2002:a1c:e382:: with SMTP id a124mr3869340wmh.11.1595505123981;
        Thu, 23 Jul 2020 04:52:03 -0700 (PDT)
Received: from kpsingh-macbookpro2.roam.corp.google.com ([2a00:79e0:42:206:31d4:524e:af91:4e1c])
        by smtp.gmail.com with ESMTPSA id v15sm3054324wmh.24.2020.07.23.04.52.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jul 2020 04:52:03 -0700 (PDT)
Subject: Re: [PATCH bpf-next v5 5/7] bpf: Implement bpf_local_storage for
 inodes
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>
References: <20200722171409.102949-6-kpsingh@chromium.org>
 <202007230807.y1gfvekv%lkp@intel.com>
 <CAADnVQK=m18hgfuRZvykQiJPk_c+z=FR6Dpg0aRVvtJn6-Ckrw@mail.gmail.com>
From:   KP Singh <kpsingh@chromium.org>
Message-ID: <6a907298-3355-d918-340c-10ef13d4d0d3@chromium.org>
Date:   Thu, 23 Jul 2020 13:52:02 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAADnVQK=m18hgfuRZvykQiJPk_c+z=FR6Dpg0aRVvtJn6-Ckrw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 23.07.20 07:18, Alexei Starovoitov wrote:
> On Wed, Jul 22, 2020 at 5:22 PM kernel test robot <lkp@intel.com> wrote:
>>
> 
>> All warnings (new ones prefixed by >>):
>>
>>    kernel/bpf/bpf_inode_storage.c: In function 'unlink_inode_storage':
>>>> kernel/bpf/bpf_inode_storage.c:34:32: warning: variable 'smap' set but not used [-Wunused-but-set-variable]
> 
> KP,
> 
> feel free to resubmit as soon as you fix the build.
> People typically ignore the patches when buildbot complains,
> since they know that maintainers are not going to apply a set with
> known build issue.
> 

Got it. I need to get into the habit of building with W=1 
(at least for the files I change).

Sent a v6 with the fix.
