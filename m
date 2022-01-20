Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE8C2494E06
	for <lists+bpf@lfdr.de>; Thu, 20 Jan 2022 13:35:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242590AbiATMfN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 20 Jan 2022 07:35:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242642AbiATMfM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 20 Jan 2022 07:35:12 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D0DCC061574
        for <bpf@vger.kernel.org>; Thu, 20 Jan 2022 04:35:12 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id q9-20020a7bce89000000b00349e697f2fbso21645867wmj.0
        for <bpf@vger.kernel.org>; Thu, 20 Jan 2022 04:35:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=62BQMO+J0oGRhtD0xxxIYbQ+PXm+Uc/GBW6L/Bz4NyQ=;
        b=OCGmD3aPR7kvNqkjWsdTdyvqKbDyMstsvNBjb6MPFtjv/ZG3Xp8i+Vv1uVH4opmqMW
         PGtUPJIxSTTcob9rhhAtFdEzZ//mL5d8bys+dNF9LJ6dequvU4JzNZoDXitKb4jotKVT
         kMcH5Tn2W8ZBTo5bNYRAf20H75nxIg7FUmj5Z7/6eiiJO7EYTcrSUK+IAhvew/FoaJy6
         VmRWUzD4RV6ef9aIFqrSObHFlIx8FHYXAtCnC40w4c9b+aH5/hssy5lNFB//Cb42m5QK
         Ipp4ZUp3G2NWx7hFrQJSoDdOYvKnUQodQtuV6438TQN1yr/yXUvVDs/5ju50W4IsTO8I
         C1YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=62BQMO+J0oGRhtD0xxxIYbQ+PXm+Uc/GBW6L/Bz4NyQ=;
        b=xU4V+IdKXwsIz1ocnzKQim3ShapTCNz63b/zqLKn1s7ZVPrdmfHkpNPxKgrhrpDGqR
         MD5eLHeVqiTeCOdQv9M8NGMGReHq2U/n+zQfR9XC92GeBbGc8hpO3CkwvUSN7oNWAL6Y
         o+PSiQ6Dv7X+/vsDnFVIR84c3b6d2rMXSf+zGY3xtVfJLzNNWJWpC1+7U3Z6vCY9oxsz
         Hljx7YbxznPid1Zz5gscv0nw1wPKiC458NEvctTuCYSEk4yxScgIqeM5m9JDY5uzXw+u
         +I881k8DRzfyMyzxOES3MLbSFFagj1IjUT6Z8FyOvxw+0ZMzraw0VmifqCy5fTBohmuc
         eeog==
X-Gm-Message-State: AOAM532qt3rpSMMbDNHCLNyV+BokCd+y7fCOjPldQ9cPC64ID0+s10xb
        BZXbqeFXDh4+WgacZqOcOvSQ+TNDyxH3/A==
X-Google-Smtp-Source: ABdhPJxSdQjUJIiiq8a+VqyWLAVUaYmITFCokicbqMX9mFtUX3E0gees70xO13u3VDHm5snb/8bdlA==
X-Received: by 2002:a1c:5405:: with SMTP id i5mr8577724wmb.34.1642682110940;
        Thu, 20 Jan 2022 04:35:10 -0800 (PST)
Received: from [192.168.1.8] ([149.86.85.208])
        by smtp.gmail.com with ESMTPSA id k35sm8158047wms.23.2022.01.20.04.35.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jan 2022 04:35:10 -0800 (PST)
Message-ID: <ac3f95ed-bead-e8ea-b477-edcbd809452c@isovalent.com>
Date:   Thu, 20 Jan 2022 12:35:09 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: Bpftool mirror now available
Content-Language: en-GB
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Networking <netdev@vger.kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Dave Thaler <dthaler@microsoft.com>
References: <267a35a6-a045-c025-c2d9-78afbf6fc325@isovalent.com>
 <CAEf4Bzbu4wc9anr19yG1AtFEcnxFsBrznynkrVZajQT1x_o6cA@mail.gmail.com>
From:   Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <CAEf4Bzbu4wc9anr19yG1AtFEcnxFsBrznynkrVZajQT1x_o6cA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

2022-01-19 22:25 UTC-0800 ~ Andrii Nakryiko <andrii.nakryiko@gmail.com>
> On Wed, Jan 19, 2022 at 6:47 AM Quentin Monnet <quentin@isovalent.com> wrote:

[...]

>> 2. Because it is easier to compile and ship, this mirror should
>> hopefully simplify bpftool packaging for distributions.
> 
> Right, I hope disto packagers will be quick to adopt the new mirror
> repo for packaging bpftool. Let's figure out bpftool versioning schema
> as a next step. Given bpftool heavily relies on libbpf and isn't
> really coupled to kernel versions, it makes sense for bpftool to
> reflect libbpf version rather than kernel's. WDYT?

Personally, I don't mind finding another scheme, as long as we keep it
consistent between the reference sources in the kernel repo and the mirror.

I also agree that it would make sense to align it to libbpf, but that
would mean going backward on the numbers (current version is 5.16.0,
libbpf's is 0.7.0) and this will mess up with every script trying to
compare versions. We could maybe add a prefix to indicate that the
scheme has changed ('l_0.7.0), but similarly, it would break a good
number of tools that expect semantic versioning, I don't think this is
any better.

The other alternative I see would be to pick a different major version
number and arbitrarily declare that bpftool's version is aligned on
libbpf's, but with a difference of 6 for the version number. So we would
start at 6.7.0 and reach 7.0.0 when libbpf 1.0.0 is released. This is
not ideal, but we would keep some consistency, and we can always add the
version of libbpf used for the build to "bpftool version"'s output. How
would you feel about it? Did you have something else in mind?

Quentin
