Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE5C02BC714
	for <lists+bpf@lfdr.de>; Sun, 22 Nov 2020 17:35:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728339AbgKVQd1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 22 Nov 2020 11:33:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48508 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728300AbgKVQd0 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 22 Nov 2020 11:33:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606062804;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eSFXaX0DZkpNbOwM/RCeF/BEd3n14fz/kurtk7pTmoY=;
        b=StCMHC/HyCDcHG808p/9thQCbNHLB97ek1T9oforhFojh55MW9LfrBZih5vkd7qgZ43dSF
        OZ3JOWRoVWjL7zUSFlP0LDpmoWD2sc3F8Zm34Dd/PaZ0RswUInINC4teeaarn0nRRR/QOI
        +dDEJjm8SJb3l7vs6UWTL1dZHykwyjY=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-275-QATNzNfPOJSDAeTo2m5xlw-1; Sun, 22 Nov 2020 11:33:22 -0500
X-MC-Unique: QATNzNfPOJSDAeTo2m5xlw-1
Received: by mail-qv1-f71.google.com with SMTP id q6so11202798qvr.21
        for <bpf@vger.kernel.org>; Sun, 22 Nov 2020 08:33:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=eSFXaX0DZkpNbOwM/RCeF/BEd3n14fz/kurtk7pTmoY=;
        b=i8vl5ZGpH8Pw9vi4UrLy+mdl0fJFlkRN3FAuJRPY8i9Rnp+X/k8zJT9MewaR8qsp+o
         j8BG5zwXcseUcm0l7u4oIeNBGN1CZtSbSwOhXmFkKajrScZ5cON09gt9WIIjqDpqd2Md
         mSk+BqdB6Mbe3FyXx9qHe2hpShjePUd9cib0SQNgOLeqPvpA/1WipE+yFNAWfLQQMIG3
         OKdfuu6k/gXQxeQX8CaQDEXE9+vTBj+dcpmiXzqNVqta+37gngnUvXoUHH0dTUnLqcnU
         gz7gHuFw5ybof1XIxHV3RPPnhC0evI3owoA/uyHWEUZK3Tv1RD7DlDobK0Z5ET1MWm7y
         q9rw==
X-Gm-Message-State: AOAM533SJ27Nd4c93D3u6DGDhLX/v7Kut1w2vXscJfnvNEsXCvUdut4v
        0ijtetXWggRAFid+W1mLeGcJSokvrFRHTK50er/9/8tvaHoMmCJaz5i2wxQ7E3p2eTLdI4qciDe
        BSOIJz9aBiLNw
X-Received: by 2002:a37:a783:: with SMTP id q125mr25815209qke.10.1606062801574;
        Sun, 22 Nov 2020 08:33:21 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx2n++9V878KrbbQS+4X3uFT/lj12S/EG8yAhFKA6vFd9PzTR06otQkDsZPYmv5N+Hbwviu/A==
X-Received: by 2002:a37:a783:: with SMTP id q125mr25815168qke.10.1606062801138;
        Sun, 22 Nov 2020 08:33:21 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id 9sm7113466qke.6.2020.11.22.08.33.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Nov 2020 08:33:20 -0800 (PST)
Subject: Re: [RFC] MAINTAINERS tag for cleanup robot
To:     Joe Perches <joe@perches.com>, clang-built-linux@googlegroups.com
Cc:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org, tboot-devel@lists.sourceforge.net,
        kvm@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-acpi@vger.kernel.org, devel@acpica.org,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, netdev@vger.kernel.org,
        linux-media@vger.kernel.org, MPT-FusionLinux.pdl@broadcom.com,
        linux-scsi@vger.kernel.org, linux-wireless@vger.kernel.org,
        ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org,
        ecryptfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        cluster-devel@redhat.com, linux-mtd@lists.infradead.org,
        keyrings@vger.kernel.org, netfilter-devel@vger.kernel.org,
        coreteam@netfilter.org, alsa-devel@alsa-project.org,
        bpf@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-nfs@vger.kernel.org, patches@opensource.cirrus.com
References: <20201121165058.1644182-1-trix@redhat.com>
 <2105f0c05e9eae8bee8e17dcc5314474b3c0bc73.camel@perches.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <6e8c1926-4209-8f10-d0f9-72c875a85a88@redhat.com>
Date:   Sun, 22 Nov 2020 08:33:16 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <2105f0c05e9eae8bee8e17dcc5314474b3c0bc73.camel@perches.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


On 11/21/20 9:10 AM, Joe Perches wrote:
> On Sat, 2020-11-21 at 08:50 -0800, trix@redhat.com wrote:
>> A difficult part of automating commits is composing the subsystem
>> preamble in the commit log.  For the ongoing effort of a fixer producing
>> one or two fixes a release the use of 'treewide:' does not seem appropriate.
>>
>> It would be better if the normal prefix was used.  Unfortunately normal is
>> not consistent across the tree.
>>
>> So I am looking for comments for adding a new tag to the MAINTAINERS file
>>
>> 	D: Commit subsystem prefix
>>
>> ex/ for FPGA DFL DRIVERS
>>
>> 	D: fpga: dfl:
> I'm all for it.  Good luck with the effort.  It's not completely trivial.
>
> From a decade ago:
>
> https://lore.kernel.org/lkml/1289919077.28741.50.camel@Joe-Laptop/
>
> (and that thread started with extra semicolon patches too)

Reading the history, how about this.

get_mataintainer.pl outputs a single prefix, if multiple files have the same prefix it works, if they don't its an error.

Another script 'commit_one_file.sh' does the call to get_mainainter.pl to get the prefix and be called by run-clang-tools.py to get the fixer specific message.

Defer minimizing the commits by combining similar subsystems till later.

In a steady state case, this should be uncommon.


>
>> Continuing with cleaning up clang's -Wextra-semi-stmt
>> diff --git a/Makefile b/Makefile
> []
>> @@ -1567,20 +1567,21 @@ help:
>>  	 echo  ''
>>  	@echo  'Static analysers:'
>>  	@echo  '  checkstack      - Generate a list of stack hogs'
>>  	@echo  '  versioncheck    - Sanity check on version.h usage'
>>  	@echo  '  includecheck    - Check for duplicate included header files'
>>  	@echo  '  export_report   - List the usages of all exported symbols'
>>  	@echo  '  headerdep       - Detect inclusion cycles in headers'
>>  	@echo  '  coccicheck      - Check with Coccinelle'
>>  	@echo  '  clang-analyzer  - Check with clang static analyzer'
>>  	@echo  '  clang-tidy      - Check with clang-tidy'
>> +	@echo  '  clang-tidy-fix  - Check and fix with clang-tidy'
> A pity the ordering of the code below isn't the same as the above.

Taken care thanks!

Tom


