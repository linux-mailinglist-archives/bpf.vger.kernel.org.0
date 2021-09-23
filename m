Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44E2F416031
	for <lists+bpf@lfdr.de>; Thu, 23 Sep 2021 15:42:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232633AbhIWNoO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Sep 2021 09:44:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232316AbhIWNoO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Sep 2021 09:44:14 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6550AC061574
        for <bpf@vger.kernel.org>; Thu, 23 Sep 2021 06:42:42 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id w29so17287759wra.8
        for <bpf@vger.kernel.org>; Thu, 23 Sep 2021 06:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RYNU9hWi3zDMwZGHajuFnmBsx+BT2s/R3kN3qcekSpA=;
        b=UvtJxvV5hUMJRwPqDAcC7asMCdGlYDjHe4gCJY0Z3LK5J67C12IfTfkr7BaPo5VYlt
         c50BzhVnF3CSoRoMUHBFpZZIyZJX/FT/lhAiA+8nB8WYn8e0x8iSMmfovaimqaBiE8P6
         6C0IwjkwUf4NlAXVCswWCOfIoaiGGmx5Af5mimp9acYrTrHgAftd4oxr07F4btbnkhkA
         tvdYpcFI2h0X3alEQSK7Z9/2NpdJNqgRuHI0mm9Zz4CM9Dv/LkDfyxDvVN956xt/8sDP
         8YQitNlA/SXwh8ywkwZb1XLYvdqYe+PMMr+f2djXCpH0SjnFfVJ+Yy+vr/lVdHTxWzZb
         hPdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RYNU9hWi3zDMwZGHajuFnmBsx+BT2s/R3kN3qcekSpA=;
        b=G2NeMV5UCvqvO6WS9yZKw5CAwWlKTZlFAGAduVlA/vQ1C68lgMI0Bdm2EpUa9qcAin
         A1wUKSh/FnuVWVLWd0lqqcL1ywEFEy/hYL1m4yPaAv+4jgbwHPfX9jztr9FKqMB4CFiI
         k5L/U3C7cNV0LOJ0+HdoPhM7LIcWc93Bt9qUvyA2dLTzXIplUC/mowQ20Atk8azZNyEX
         Zgb8zHXfG9spl3g8OdFmCOLkZVaJJ/EG9pT0q9UtsRbKL3QklLqHIwK2xIlJbfeKt6wZ
         fujlcJdpZuj9USrsD9oSKT0euPQPPFJHDVVghDDhL0TWaYPWZxxWIFyQjMPy3g/2elsg
         YAsg==
X-Gm-Message-State: AOAM5337RnOZxbTHwngr50WOsq+m03Ca8bzCJMlashtGM0hizWpw+qBk
        4mbFuHkW5xumiF6nB9cJgtI+Og==
X-Google-Smtp-Source: ABdhPJxIpMbs/49TwiYHjTwj+XToLoUASC+r9v8xnfofNIGOL695gP75+fbxyV97J0Kj+zK+9wfkMQ==
X-Received: by 2002:a1c:3584:: with SMTP id c126mr4731435wma.0.1632404560919;
        Thu, 23 Sep 2021 06:42:40 -0700 (PDT)
Received: from [192.168.1.8] ([149.86.69.207])
        by smtp.gmail.com with ESMTPSA id i1sm5576809wrb.93.2021.09.23.06.42.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Sep 2021 06:42:40 -0700 (PDT)
Subject: Re: [PATCH] samples/bpf: relicense bpf_insn.h as GPL-2.0-only OR
 BSD-2-Clause
To:     Luca Boccassi <bluca@debian.org>, bpf@vger.kernel.org
Cc:     bjorn@kernel.org, kuba@kernel.org, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, daniel@zonque.org, joe@ovn.org, jbacik@fb.com,
        Simon Horman <simon.horman@corigine.com>
References: <20210923000540.47344-1-luca.boccassi@gmail.com>
 <49c54bf3f4a95562592575062058f069654fd253.camel@debian.org>
From:   Quentin Monnet <quentin@isovalent.com>
Message-ID: <a92cd043-30e8-c26d-ffe9-3521322ce71b@isovalent.com>
Date:   Thu, 23 Sep 2021 14:42:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <49c54bf3f4a95562592575062058f069654fd253.camel@debian.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

2021-09-23 11:41 UTC+0100 ~ Luca Boccassi <bluca@debian.org>
> On Thu, 2021-09-23 at 01:05 +0100, luca.boccassi@gmail.com wrote:
>> From: Luca Boccassi <bluca@debian.org>
>>
>> libbpf and bpftool have been dual-licensed to facilitate inclusion in
>> software that is not compatible with GPL2-only (ie: Apache2), but the
>> samples are still GPL2-only.
>>
>> Given these files are samples, they get naturally copied around. For
>> example
>> it is the case for samples/bpf/bpf_insn.h which was copied into the
>> systemd
>> tree:
>> https://github.com/systemd/systemd/blob/main/src/shared/linux/bpf_insn.h
>>
>> Dual-license this header as GPL-2.0-only OR BSD-2-Clause to follow
>> the same licensing used by libbpf and bpftool:
>>
>> 1bc38b8ff6cc ("libbpf: relicense libbpf as LGPL-2.1 OR BSD-2-Clause")
>> 907b22365115 ("tools: bpftool: dual license all files")
>>
>> Signed-off-by: Luca Boccassi <bluca@debian.org>
>> ---
>> Most of systemd is (L)GPL2-or-later, which means there is no
>> perceived
>> incompatibility with Apache2 softwares and can thus be linked with
>> OpenSSL 3.0. But given this GPL2-only header is included this is
>> currently
>> not possible.
>> Dual-licensing this header solves this problem for us as we are
>> scoping
>> moving to OpenSSL 3.0, see:
>>
>> https://lists.freedesktop.org/archives/systemd-devel/2021-September/046882.html
>>
>> The authors of this file according to git log are:
>>
>> Alexei Starovoitov <ast@kernel.org>
>> Björn Töpel <bjorn.topel@intel.com>
>> Brendan Jackman <jackmanb@google.com>
>> Chenbo Feng <fengc@google.com>
>> Daniel Borkmann <daniel@iogearbox.net>
>> Daniel Mack <daniel@zonque.org>
>> Jakub Kicinski <jakub.kicinski@netronome.com>
>> Jiong Wang <jiong.wang@netronome.com>
>> Joe Stringer <joe@ovn.org>
>> Josef Bacik <jbacik@fb.com>
>>
>> (excludes a commit adding the SPDX header)
>>
>> All authors and maintainers are CC'ed. An Acked-by from everyone in
>> the
>> above list of authors will be necessary.
>>
>> One could probably argue for relicensing all the samples/bpf/ files
>> given both
>> libbpf and bpftool are, however the authors list would be much larger
>> and thus
>> it would be much more difficult, so I'd really appreciate if this
>> header could
>> be handled first by itself, as it solves a real license
>> incompatibility issue
>> we are currently facing.
>>
>>  samples/bpf/bpf_insn.h | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/samples/bpf/bpf_insn.h b/samples/bpf/bpf_insn.h
>> index aee04534483a..29c3bb6ad1cd 100644
>> --- a/samples/bpf/bpf_insn.h
>> +++ b/samples/bpf/bpf_insn.h
>> @@ -1,4 +1,4 @@
>> -/* SPDX-License-Identifier: GPL-2.0 */
>> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
>>  /* eBPF instruction mini library */
>>  #ifndef __BPF_INSN_H
>>  #define __BPF_INSN_H
> 
> Got "address not found" for the following:
> 
> Björn Töpel <bjorn.topel@intel.com>
> Jakub Kicinski <jakub.kicinski@netronome.com>
> Jiong Wang <jiong.wang@netronome.com>
> 
> Trying again with different aliases from more recent commits for Björn
> and Jakub.
> 
> I cannot find other commits from Jiong with a different email address -
> Jakub, do you happen to know how we can reach Jiong? Perhaps it's not
> necessary as it's Netronome that owns the copyright and thus your ack
> would cover both contributions?
> 

Hi Luca, I believe Simon can handle this for Netronome, I'm adding him
in copy.

Quentin
