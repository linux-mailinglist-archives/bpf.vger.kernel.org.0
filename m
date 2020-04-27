Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DA781BA610
	for <lists+bpf@lfdr.de>; Mon, 27 Apr 2020 16:16:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727098AbgD0OQv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Apr 2020 10:16:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727089AbgD0OQv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Apr 2020 10:16:51 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9059C0610D5
        for <bpf@vger.kernel.org>; Mon, 27 Apr 2020 07:16:50 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id x25so19748035wmc.0
        for <bpf@vger.kernel.org>; Mon, 27 Apr 2020 07:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3ZvrZIOl6DpxgRjHoCSpRnkuuUuXbmW7Utk3CE+1xbA=;
        b=gPquhElP3DirkNlNsuQRDRuhOdkKxXc8i/RGyOEzlnTqYm4FRqXLaEnz1bIzZ/ZIp/
         fP02m6qohqO99AewLv5Mym1ziN7coejpiT810OGEsVev/dudEg6umlNoktapZy3X/2dc
         EfsBzmCrrNP2guNxQXmS8A3ZRIqQGA9ZydmZWewIoBiuv9ubJSo0NMRxpibdbRTeAjjm
         Az3K7b1KLojvZ4lEQis+kHzbuIBYEf/LIDXSjOMdZqwKkH6i+rJUokRYFxzJMhJCtC0T
         IrxzVpsM20FnKyZJmPracxAgaH0GPnZ57y1pZWOyOrTPD2makslA3MFvS010on8L8bLq
         fihA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3ZvrZIOl6DpxgRjHoCSpRnkuuUuXbmW7Utk3CE+1xbA=;
        b=NKVtvQvGt+XUZ+2vZ1QuebOzatgtFt5J9/mRPGk7VU+OnBa6VBKxzCwHVbE9xmwGlY
         jr3B75iSH6vex99DOu873P99P6gCaTX0CKgA632JhUQo0xj0vBd/eHwQkcZQKbCefhKD
         CL+lNUAhDdLrFR8m2tH25YHRXydiRFUZ658uiBcuO5Q8inOFIi4ybS+Rj+s0TmiJOVnj
         1GX4m0eOiv+PCyLw7zrWieAAtWvZZSxKmzSmeEJpan6r83roBoxxbxS6O4/ELYP+J6hJ
         +/o97wwhi0n9pQ7FNMk42l44RvU8U0AEqgMnEpr0WrsW3TMMlMncDRk0Fu4a5OaLO1v3
         /uXA==
X-Gm-Message-State: AGi0Pua9uUFcZpCHntt4MASyUBoTYOBgTjXdR6QTkNwyzmTFDaBHjdnn
        XpA7zATu6peY196kuVGUbNuw5Q==
X-Google-Smtp-Source: APiQypLCrxgcx6PkNTJ9jVBZFuctDAQD0MQdBrr/HvWukDsFzzVDU3cpmeZQH5v0tMjKnOxzGtUKzQ==
X-Received: by 2002:a1c:ded4:: with SMTP id v203mr26560548wmg.106.1587997009525;
        Mon, 27 Apr 2020 07:16:49 -0700 (PDT)
Received: from [192.168.1.10] ([194.53.185.120])
        by smtp.gmail.com with ESMTPSA id i6sm23015331wrc.82.2020.04.27.07.16.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Apr 2020 07:16:48 -0700 (PDT)
Subject: Re: [PATCH bpf-next] tools: bpftool: allow unprivileged users to
 probe features
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        Richard Palethorpe <rpalethorpe@suse.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>
References: <20200423160455.28509-1-quentin@isovalent.com>
 <bbde573f-edd8-0d39-556e-98842e0328f7@iogearbox.net>
From:   Quentin Monnet <quentin@isovalent.com>
Message-ID: <b84df406-608d-f597-59ba-a27764eb1fcb@isovalent.com>
Date:   Mon, 27 Apr 2020 15:16:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <bbde573f-edd8-0d39-556e-98842e0328f7@iogearbox.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

2020-04-27 14:58 UTC+0200 ~ Daniel Borkmann <daniel@iogearbox.net>
> On 4/23/20 6:04 PM, Quentin Monnet wrote:
>> There is demand for a way to identify what BPF helper functions are
>> available to unprivileged users. To do so, allow unprivileged users to
>> run "bpftool feature probe" to list BPF-related features. This will only
>> show features accessible to those users, and may not reflect the full
>> list of features available (to administrators) on the system. For
>> non-JSON output, print an informational message stating so at the top of
>> the list.
>>
>> Note that there is no particular reason why the probes were restricted
>> to root, other than the fact I did not need them for unprivileged and
>> did not bother with the additional checks at the time probes were added.
>>
>> Cc: Richard Palethorpe <rpalethorpe@suse.com>
>> Cc: Michael Kerrisk <mtk.manpages@gmail.com>
>> Signed-off-by: Quentin Monnet <quentin@isovalent.com>
>> ---
>>   .../bpftool/Documentation/bpftool-feature.rst |  4 +++
>>   tools/bpf/bpftool/feature.c                   | 32 +++++++++++++------
>>   2 files changed, 26 insertions(+), 10 deletions(-)
>>
>> diff --git a/tools/bpf/bpftool/Documentation/bpftool-feature.rst
>> b/tools/bpf/bpftool/Documentation/bpftool-feature.rst
>> index b04156cfd7a3..313888e87249 100644
>> --- a/tools/bpf/bpftool/Documentation/bpftool-feature.rst
>> +++ b/tools/bpf/bpftool/Documentation/bpftool-feature.rst
>> @@ -49,6 +49,10 @@ DESCRIPTION
>>             Keyword **kernel** can be omitted. If no probe target is
>>             specified, probing the kernel is the default behaviour.
>>   +          Running this command as an unprivileged user will dump only
>> +          the features available to the user, which usually represent a
>> +          small subset of the parameters supported by the system.
>> +
> 
> Looks good. I wonder whether the unprivileged should be gated behind an
> explicit
> subcommand e.g. `--unprivileged`. My main worry is that if there's a
> misconfiguration
> the emitted macro/ header file will suddenly contain a lot less defines
> and it might
> go unnoticed if some optimizations in the BPF code are then compiled out
> by accident.
> Maybe it would make sense to have a feature test for libcap and then
> also allow for
> root to check on features for unpriv this way?

That's a valid concern, I'll rework the patch to add support for the
explicit option on the command line as you suggest. Thanks for the review!

Quentin
