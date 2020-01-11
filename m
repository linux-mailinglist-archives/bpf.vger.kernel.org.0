Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38D43138377
	for <lists+bpf@lfdr.de>; Sat, 11 Jan 2020 21:07:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731119AbgAKUH4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 11 Jan 2020 15:07:56 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43192 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731028AbgAKUH4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 11 Jan 2020 15:07:56 -0500
Received: by mail-wr1-f65.google.com with SMTP id d16so4836362wre.10
        for <bpf@vger.kernel.org>; Sat, 11 Jan 2020 12:07:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+VNlPdwEIw1gLI8EYc+Oh+CzRTvoHGfPoZx4pybzXSg=;
        b=O0noVxh6LzCvy0EKWBAEYz6Y7s6KAH9TvYIkqlK1My+ZxZnPLRcFtrG+80+5diVvE7
         iPKMhWBav5t90BTwaDbcIBYUjrvfZnEbR3SIiOPdKXv+NdNglG6eaOKGhB92W6LMpg6J
         MV7z6ZDamg/O5cFqc2O/7GZF63ykA2SwDu1BzauYyVU1ARgBjCU1DTeIe4MwiSqPmI4B
         qE4jUq/wSd+Eqvc9rZ+EwPFdWXmEBffWsvO+60NTQLARuSM7nUXPIZBoG3dTC0qa9pjp
         AbdOPdqBFQuBh4+91CdFz59OTRrGsFBlq6rNXPMdQCccDn8caHGpHxajmH0wCHjEanqh
         v6EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+VNlPdwEIw1gLI8EYc+Oh+CzRTvoHGfPoZx4pybzXSg=;
        b=CD1vKNxuVVY36czbjt9RTY6aoYTttjUYnQGU+gkp8rTKhXM6u2UVyDZ3pa4qj3cqQh
         pwVbwv+11HTkY0YBdMyTdfCarXIZVAdOPHYki5Dbt6lG+CGq+nw6qsZUEpm1qPjRPvhw
         mbHjWv2T9vkGWSbwmf9dttNWcsTr3x7gpNOUSOfuIXRDUFldHOTwsIjVuInR0DMKS/1R
         SmtUOA3gOZeHlHlpvLVS2unC786MtfOD9iCLc8cMY4FyyL1g/K/DlNoCNSKPoqq6pDwP
         zvJjRvovplSZr6rpZT7ox3NM2L8lIfdjhleyFHXx9yaKYZRSy9226/c1S/qCga3bVBPV
         Wm8g==
X-Gm-Message-State: APjAAAWuBagqDZffBwS7Jq5U4jlNsr1Kot7fJMdFwX7VgkcEPw8s05Wh
        HKJXauSDa7fV1tlI8ig7KdiLHw==
X-Google-Smtp-Source: APXvYqyYHrS775LClc2nEuhBuINtxjvrZY80MRLMdlmpOZ8pppvXe1BLqjShxYxZIbzVde9VoN7xDA==
X-Received: by 2002:adf:c746:: with SMTP id b6mr9647283wrh.298.1578773274680;
        Sat, 11 Jan 2020 12:07:54 -0800 (PST)
Received: from [192.168.1.2] ([194.35.117.39])
        by smtp.gmail.com with ESMTPSA id b10sm7726368wrt.90.2020.01.11.12.07.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Jan 2020 12:07:53 -0800 (PST)
Subject: Re: [PATCH bpf] bpftool: Fix printing incorrect pointer in
 btf_dump_ptr
To:     Martin KaFai Lau <kafai@fb.com>, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        David Miller <davem@davemloft.net>, kernel-team@fb.com,
        netdev@vger.kernel.org
References: <20200110231644.3484151-1-kafai@fb.com>
From:   Quentin Monnet <quentin.monnet@netronome.com>
Message-ID: <2e5a0dfc-6b22-4a5f-d305-da920c9a44c7@netronome.com>
Date:   Sat, 11 Jan 2020 20:07:52 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200110231644.3484151-1-kafai@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

2020-01-10 15:16 UTC-0800 ~ Martin KaFai Lau <kafai@fb.com>
> For plain text output, it incorrectly prints the pointer value
> "void *data".  The "void *data" is actually pointing to memory that
> contains a bpf-map's value.  The intention is to print the content of
> the bpf-map's value instead of printing the pointer pointing to the
> bpf-map's value.
> 
> In this case, a member of the bpf-map's value is a pointer type.
> Thus, it should print the "*(void **)data".
> 
> Fixes: 22c349e8db89 ("tools: bpftool: fix format strings and arguments for jsonw_printf()")
> Cc: Quentin Monnet <quentin.monnet@netronome.com>
> Signed-off-by: Martin KaFai Lau <kafai@fb.com>

My bad, thank you for the fix!

Reviewed-by: Quentin Monnet <quentin.monnet@netronome.com>
