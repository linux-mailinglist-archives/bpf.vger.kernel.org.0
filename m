Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B9D823ABCC
	for <lists+bpf@lfdr.de>; Mon,  3 Aug 2020 19:47:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726356AbgHCRqp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 3 Aug 2020 13:46:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbgHCRqo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 3 Aug 2020 13:46:44 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E005C06174A
        for <bpf@vger.kernel.org>; Mon,  3 Aug 2020 10:46:44 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id o23so12095279ejr.1
        for <bpf@vger.kernel.org>; Mon, 03 Aug 2020 10:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QCxlN42Dpf84QDKc0qNus6gWzEZ8znuGVzXWLcSubyU=;
        b=hP9FRbXXvcCm9F2+Wqs0j3rmyEJRG+8t5EVqRFjDnC5hm4FqT4WBPLUq73Sb9qc7np
         D8dMYVZTFv/0S7nXIaYjw/Ra0hqxpc4Sz4jUtEeMEZO4ZYpD2arb217osnZlA9Oslrlg
         Ofskn98SUkekGhf9ehHzgNMM1NkVoxYW3wr8Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QCxlN42Dpf84QDKc0qNus6gWzEZ8znuGVzXWLcSubyU=;
        b=O2BaaZm0+D6N+w98BinfqnHZRCiNubLZgP8R2b1thp+4Th64Pdi9l5Nx46AUu+JdMA
         7EE6pjUNBq4ENhMADuxdecZINq63W6DI+uz3sR1k+IHsKvnDvUPxk6y5PF4RiYY++QH3
         ZIKwT5iZZUs/YmMxwPvHINXvg3P1OHyutIOsABWdsdBE3WHpO1ti/4vcOG18hsNWbPnQ
         aQs2MQWdJMzQDiLnFnHHC2Mr9L9J/WBk9/RWty1BgJvQ8RAGsQ1LiAo+OsQ2V5YOjlSo
         cMhoCdsvV5mDL/z+v4/VL8CRAVvaF98VsEH9g/mnk411FHxQRYOXsP8ZC8sjhNl/FofI
         bvPQ==
X-Gm-Message-State: AOAM530NyjjazFAGM1NH0p/piLwf9zt+ZL9B0F2u2agygw3fO2YJ0Xsc
        ys7QDef+SO0cbP+lCeEoizj/iQ==
X-Google-Smtp-Source: ABdhPJyNNPVKXrY36jyeJNuzk0LxD1oXgVP7J7CQ47kNYPls3Pu5B40PEXTllT4nwQno3oYrllGgRg==
X-Received: by 2002:a17:906:454e:: with SMTP id s14mr17331927ejq.147.1596476803256;
        Mon, 03 Aug 2020 10:46:43 -0700 (PDT)
Received: from [192.168.2.66] ([81.6.44.51])
        by smtp.gmail.com with ESMTPSA id u4sm9480396edy.18.2020.08.03.10.46.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Aug 2020 10:46:42 -0700 (PDT)
Subject: Re: [PATCH bpf-next v8 0/7] Generalizing bpf_local_storage
From:   KP Singh <kpsingh@chromium.org>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>
References: <20200803164655.1924498-1-kpsingh@chromium.org>
Message-ID: <dc832ef3-37a5-fbcb-cb87-607232fe67b4@chromium.org>
Date:   Mon, 3 Aug 2020 19:46:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200803164655.1924498-1-kpsingh@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 8/3/20 6:46 PM, KP Singh wrote:
> From: KP Singh <kpsingh@google.com>
> 
> # v7 -> v8
> 
> - Fixed an issue with BTF IDs for helpers and added
>   bpf_<>_storage_delete to selftests to catch this issue.
> - Update comments about refcounts and grabbed a refcount to the open
>   file for userspace inode helpers.
> - Rebase.
> 

Apologies, I missed that bpf-next is already closed. 

I will resend this as a v9 after it opens again.

[...]
