Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0245C2DD870
	for <lists+bpf@lfdr.de>; Thu, 17 Dec 2020 19:34:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730142AbgLQSda (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Dec 2020 13:33:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728704AbgLQSda (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Dec 2020 13:33:30 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 599DAC0617A7
        for <bpf@vger.kernel.org>; Thu, 17 Dec 2020 10:32:49 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id x15so26759442ilq.1
        for <bpf@vger.kernel.org>; Thu, 17 Dec 2020 10:32:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=euqBXwlKpksM2O1B20N3zwYJHM+krRb1R0QlrPJovKs=;
        b=hloE6vQ34Nt0jvI6wpY7VyipHe1zhzyr1SdISONaS2dIFdFEvi78131QKFFDzX4pKc
         NrO6qu4ndHfPR+rXUnD3mJbBbsvfgiNoLocM+ZCbE9Ij20m3Kn2GxT755xEKCgh1fvh6
         yU9lp7+wI8RWhYTb8mQH3oHnDFFN9h94b8WQ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=euqBXwlKpksM2O1B20N3zwYJHM+krRb1R0QlrPJovKs=;
        b=llCXeaVXcdg+CjisqtKvyBzl6dA0NnPpawMAV9WM7H2ZVhRW3Ea2OKqKB6HpYlw7i6
         I8TajTexD13blrycMPWopKTjB6V3e75O2xsLlT1bctAeVyBEkm5BQzZ/SLBQekegq1qo
         VZR1ZRc5fqWC4H/cECCivN+/KCtgLQ6x603GMxLlbEZrLiz9YNtcOX9pl9mTlKBHdMNe
         LafN9OQDvKelWILs23qaJLBJYX/gaG6xLBIejkVZL5CWziuLhIr3AuX0xfyaxtnKT+nC
         zMG/ew1xct0JSM3cOXrP36HgbkiBX6YBiCwkS7CSucuqF+t5V3NP1DYJF8xKJvRMDVPL
         CyqA==
X-Gm-Message-State: AOAM531yaAwwsUZ5cyVfWdJici2WrFOyxuhuy7wbrMH489VXO525s0Xf
        +ACY10kXiSAf836FiBgyCr+fDQ==
X-Google-Smtp-Source: ABdhPJwKbvtaglTe9buBF6UPtZDTuxPohT7p6/IvZcZYmSMeL0UCG5btnwEfAEImPVuebSVaKl8DdQ==
X-Received: by 2002:a92:155b:: with SMTP id v88mr124823ilk.303.1608229968746;
        Thu, 17 Dec 2020 10:32:48 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id d18sm3662791ilo.49.2020.12.17.10.32.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Dec 2020 10:32:48 -0800 (PST)
Subject: Re: [PATCH] selftests: Skip BPF seftests by default
To:     Mark Brown <broonie@kernel.org>,
        Seth Forshee <seth.forshee@canonical.com>
Cc:     Shuah Khan <shuah@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Daniel Diaz <daniel.diaz@linaro.org>,
        Veronika Kabatova <vkabatov@redhat.com>,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Guillaume Tucker <guillaume.tucker@collabora.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20201210185233.28091-1-broonie@kernel.org>
 <X9qExiKXPVmk3BJI@ubuntu-x1> <20201217130735.GA4708@sirena.org.uk>
 <94010653-0cb3-d804-7410-a571480d6db2@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <008fb8b6-2632-e0c8-8e6a-c643d953bde5@linuxfoundation.org>
Date:   Thu, 17 Dec 2020 11:32:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <94010653-0cb3-d804-7410-a571480d6db2@linuxfoundation.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 12/17/20 8:53 AM, Shuah Khan wrote:
> On 12/17/20 6:07 AM, Mark Brown wrote:
>> On Wed, Dec 16, 2020 at 04:05:58PM -0600, Seth Forshee wrote:
>>> On Thu, Dec 10, 2020 at 06:52:33PM +0000, Mark Brown wrote:
>>
>>>> as part of the wider kselftest build by specifying SKIP_TARGETS,
>>>> including setting an empty SKIP_TARGETS to build everything.  They can
>>>> also continue to build the BPF selftests individually in cases where
>>>> they are specifically focused on BPF.
>>

Applied to linuxkselftest fixes for rc2

thanks,
-- Shuah
