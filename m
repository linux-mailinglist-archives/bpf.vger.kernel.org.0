Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF92833EDD9
	for <lists+bpf@lfdr.de>; Wed, 17 Mar 2021 11:00:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbhCQKAO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 17 Mar 2021 06:00:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbhCQJ7p (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 17 Mar 2021 05:59:45 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B029C06174A;
        Wed, 17 Mar 2021 02:59:45 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id l1so1449567lfk.10;
        Wed, 17 Mar 2021 02:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rZK0dXYfoMYNDjd/41SCLvGPVE+8I38D7HzSVC6cTLM=;
        b=QYVSALsh00hkRSyvxsjbDM1i8MQGFVnPhEFggreS4IYaFAXmDnZjMBD3Pkh4ZAG7WO
         H8ebsaiQO7GaasX4xTUU0LQlmDXUGy7FLKJYlOEWmcaZbACtTNMPN81geZWjEkdBhiH4
         VBU5vmK0eS9G+RAe/V/dOWZsgII7rfnYjk6xnqKR+N7907riryVuEDbLirX6vRuIVvYy
         xBcwhY2YlrCzanRs4ThXgvYBMB2PxZws+3RLwxLXlG7AT/fOLU3ppkLBoZuJcgnxDKmU
         PeaU7OtoNs5cV0G4nxIKmjr4ucvEsNqzU+N/QuFUdbxTmx6tZbBIDrk/S8wMd1Qc8AS4
         j91g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=rZK0dXYfoMYNDjd/41SCLvGPVE+8I38D7HzSVC6cTLM=;
        b=evz2wCn6MN4JCxNhdymKiYw5x8NxoWsiLOjKk7NTWpWEzKjX0ujAd2Oj3/lSs44vOZ
         SYdo0HZTEzmnF2zBND0RVkl9PRWYeJu767DgANuoavcCHOoihTMxhMa0QSyZUgngUiDo
         yYXVpywSKm+Ht3vXNyrw1yv+7Aaf4WlnxddTelFCkZkGzMe3HKRVHFPHvq70FYkQRYEm
         xDcJhiigCFCtMavafG4ynmUNXpMhUKNmGs4vdXWSiRrZpxzs72SHJI+fS3HZXAb4kMwJ
         eeIvzPIlw04JHgMq5wPmdAZVa70AM/CHAtzipuKMcgvTde+uZHSI2+qn863y4IpB7Yvq
         v50w==
X-Gm-Message-State: AOAM530oIR028Acgq48EEwhkMaAMhjqt/u5GR1ec4VRMTD3GEBJPhfz8
        91ezBA1cJuRwpLdQo5y04nMpN7dm4B8=
X-Google-Smtp-Source: ABdhPJx7Ea5AuUcM5hFjpJHkKsufHlUd0yIDy/hPh8/HLWBqwPSdY1J5ZrMRTv25O8j4D2dKzAKvfQ==
X-Received: by 2002:ac2:5382:: with SMTP id g2mr1894717lfh.60.1615975183939;
        Wed, 17 Mar 2021 02:59:43 -0700 (PDT)
Received: from [192.168.1.100] ([178.176.79.25])
        by smtp.gmail.com with ESMTPSA id m1sm3461555ljg.111.2021.03.17.02.59.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Mar 2021 02:59:43 -0700 (PDT)
Subject: Re: [PATCH] MIPS/bpf: Enable bpf_probe_read{, str}() on MIPS again
To:     Tiezhu Yang <yangtiezhu@loongson.cn>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     linux-mips@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>
References: <1615965307-6926-1-git-send-email-yangtiezhu@loongson.cn>
From:   Sergei Shtylyov <sergei.shtylyov@gmail.com>
Organization: Brain-dead Software
Message-ID: <af0fec67-d858-f555-7728-7a083127b57b@gmail.com>
Date:   Wed, 17 Mar 2021 12:59:38 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <1615965307-6926-1-git-send-email-yangtiezhu@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 17.03.2021 10:15, Tiezhu Yang wrote:

> After commit 0ebeea8ca8a4 ("bpf: Restrict bpf_probe_read{, str}() only to
> archs where they work"), bpf_probe_read{, str}() functions were not longer

    No longer.

> available on MIPS, so there exists some errors when running bpf program:

     Exist.

> root@linux:/home/loongson/bcc# python examples/tracing/task_switch.py
> bpf: Failed to load program: Invalid argument
> [...]
> 11: (85) call bpf_probe_read#4
> unknown func bpf_probe_read#4
> [...]
> Exception: Failed to load BPF program count_sched: Invalid argument
> 
> So select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE in arch/mips/Kconfig,
> otherwise the bpf old helper bpf_probe_read() will not be available.
> 
> This is similar with the commit d195b1d1d1196 ("powerpc/bpf: Enable
> bpf_probe_read{, str}() on powerpc again").
> 
> Fixes: 0ebeea8ca8a4 ("bpf: Restrict bpf_probe_read{, str}() only to archs where they work")
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
[...]

MBR, Sergei
