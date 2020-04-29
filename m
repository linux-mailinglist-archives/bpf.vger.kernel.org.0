Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 417041BE16C
	for <lists+bpf@lfdr.de>; Wed, 29 Apr 2020 16:44:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbgD2OoU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 29 Apr 2020 10:44:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726539AbgD2OoT (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 29 Apr 2020 10:44:19 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 314CAC03C1AE
        for <bpf@vger.kernel.org>; Wed, 29 Apr 2020 07:44:19 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id k1so2875210wrx.4
        for <bpf@vger.kernel.org>; Wed, 29 Apr 2020 07:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PSecl/OYFr4uSjR1/jQb9gvWQX32Fzr2BBQLzLGOKeg=;
        b=Q5LOnqSA2m65WzbIJfsprviNZq0c7lqsgLnam3pHSOs5YiQiXhIoPipsx39dQtJHtc
         2/LxYXOGxrjzpnznB/diyQ7I0+44YmCJ4GZChcrlHbLNjSfo/AKvci+ZPaoIBnrjVsl6
         KPfYv7/Jy1R9Iq+z5/MrVgCtHcNFn9RDFl2tioqmYE1GY8tn00oNg/Oi3avqMEsXwir7
         ASvn2fNOlft2Djh5tgLfXAQCr7ySRKrFDUPmYfwSICADh74MszEaGArdpNNH0ZO3bYds
         HAkG8oGvJCLmgP8ZZyLhhGEb8YW7dt+h6OBB3I1jLmAPv6lDcZxA+Jsybfg/xi7Q3vnr
         cIHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PSecl/OYFr4uSjR1/jQb9gvWQX32Fzr2BBQLzLGOKeg=;
        b=R8nFWGbSXdCIu1CMUzS44hF4bQZLMJ1+x3y20jd7V8GH7pRlg//kMx/lHQcAqYLvuL
         nhULtfJlm2DsVVBc45/d0zZRYsGgOHNmFSA5Q5VZ6YCsxz4UovRKNlVOTkOLmZRmxdWy
         92U2mfTigt5/XAI72mxAVixlKKgw+paKhBEUbY2m8KVc4XAMjfb4nt2ghJ4eCd4qSFpP
         3SWMHmAEgarpC2EcjVAXcgGcuKM2ZbCpstMEmdIQlz80fm75bRqyJVS9ELR1BBRENuFM
         AsiyUzENW+3Tjiy9PepwlJZHhBBXqSGiJbYkVZ3jBYwPqc4Oidwm2tfzAZxtOSvlX3Im
         AToQ==
X-Gm-Message-State: AGi0Pua0tUHxL0nf0lPtmnT++b5+u11tuSWr83W1K9doclmwoYcWhZkJ
        bwIoHCEv8ANvshCk3xadI/O3EA==
X-Google-Smtp-Source: APiQypKcqxKam1VuW34OjaP0NSxuQyWQrEle96IcqnH1BeaxD6eICOUwbKovo+lFRNXrYzBwf1uZCQ==
X-Received: by 2002:a5d:61c5:: with SMTP id q5mr39987632wrv.260.1588171457859;
        Wed, 29 Apr 2020 07:44:17 -0700 (PDT)
Received: from [192.168.1.10] ([194.53.185.38])
        by smtp.gmail.com with ESMTPSA id 91sm32923228wra.37.2020.04.29.07.44.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Apr 2020 07:44:17 -0700 (PDT)
Subject: Re: [PATCH bpf-next v2 2/3] tools: bpftool: allow unprivileged users
 to probe features
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        Richard Palethorpe <rpalethorpe@suse.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>
References: <20200429130534.11823-1-quentin@isovalent.com>
 <20200429130534.11823-3-quentin@isovalent.com>
 <0f883adc-1e8c-4b76-4b4e-98d95081993a@iogearbox.net>
From:   Quentin Monnet <quentin@isovalent.com>
Message-ID: <92c5f38a-199e-ba98-996b-7572201cae45@isovalent.com>
Date:   Wed, 29 Apr 2020 15:44:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <0f883adc-1e8c-4b76-4b4e-98d95081993a@iogearbox.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

2020-04-29 16:35 UTC+0200 ~ Daniel Borkmann <daniel@iogearbox.net>
> On 4/29/20 3:05 PM, Quentin Monnet wrote:
>> There is demand for a way to identify what BPF helper functions are
>> available to unprivileged users. To do so, allow unprivileged users to
>> run "bpftool feature probe" to list BPF-related features. This will only
>> show features accessible to those users, and may not reflect the full
>> list of features available (to administrators) on the system.
>>
>> To avoid the case where bpftool is inadvertently run as non-root and
>> would list only a subset of the features supported by the system when it
>> would be expected to list all of them, running as unprivileged is gated
>> behind the "unprivileged" keyword passed to the command line. When used
>> by a privileged user, this keyword allows to drop the CAP_SYS_ADMIN and
>> to list the features available to unprivileged users. Note that this
>> addsd a dependency on libpcap for compiling bpftool.
>>
>> Note that there is no particular reason why the probes were restricted
>> to root, other than the fact I did not need them for unprivileged and
>> did not bother with the additional checks at the time probes were added.
>>
>> Signed-off-by: Quentin Monnet <quentin@isovalent.com>
>> ---
>>   .../bpftool/Documentation/bpftool-feature.rst |  10 +-
>>   tools/bpf/bpftool/Makefile                    |   2 +-
>>   tools/bpf/bpftool/bash-completion/bpftool     |   2 +-
>>   tools/bpf/bpftool/feature.c                   | 100 +++++++++++++++---
>>   4 files changed, 99 insertions(+), 15 deletions(-)
>>
>> diff --git a/tools/bpf/bpftool/Documentation/bpftool-feature.rst
>> b/tools/bpf/bpftool/Documentation/bpftool-feature.rst
>> index b04156cfd7a3..ca085944e4cf 100644
>> --- a/tools/bpf/bpftool/Documentation/bpftool-feature.rst
>> +++ b/tools/bpf/bpftool/Documentation/bpftool-feature.rst
>> @@ -19,7 +19,7 @@ SYNOPSIS
>>   FEATURE COMMANDS
>>   ================
>>   -|    **bpftool** **feature probe** [*COMPONENT*] [**full**]
>> [**macros** [**prefix** *PREFIX*]]
>> +|    **bpftool** **feature probe** [*COMPONENT*] [**full**]
>> [**unprivileged**] [**macros** [**prefix** *PREFIX*]]
>>   |    **bpftool** **feature help**
> 
> Looks good to me, thanks! There is one small thing missing which is
> updating
> do_help() to display the same as above from bpftool help, but rest lgtm.

Eh, I'm usually the one pointing that -_-. Thank you Daniel, v3 incoming.
