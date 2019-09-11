Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65799B0563
	for <lists+bpf@lfdr.de>; Thu, 12 Sep 2019 00:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbfIKWLf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 11 Sep 2019 18:11:35 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38897 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728556AbfIKWLf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 11 Sep 2019 18:11:35 -0400
Received: by mail-pg1-f196.google.com with SMTP id d10so12243424pgo.5
        for <bpf@vger.kernel.org>; Wed, 11 Sep 2019 15:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Q6jLEHDrdAVkyK20fWjT39oclCB9S4iV/KFrjMBbJeE=;
        b=QVCVJyazN/1N3tJh29TNpXnPZfFboklNshuMEVATsFL73C4lZ3qdC9cIJwoWXu03no
         Yo+usfFGucs6trZ6+x8CKnsjWG1J93b4JdVgkzYxMZtJjlsmh6pRNhFufp6iwRTUeiZT
         MdmwZDKL3OJ4enBbnJjaALuEsrl8rx30ORRFnv2Jr+pCyQKgT/0b2/WOfiaT1DVa87G5
         Y2NPh7gy9tsZ00Phml674zGM20dJ/8cuZjGJDzYAsjA9Z6pGr2jo2reiYecdjUlWGfd6
         JNDirCjdVZwZUzGsqb5fF0iFPnLZXl4Rrnd4IZtgZ2f8Ofom94jQ2//HypL5e60Iw0+s
         WHAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Q6jLEHDrdAVkyK20fWjT39oclCB9S4iV/KFrjMBbJeE=;
        b=DP9mCWiwflalQ88CowdFIRo7WLX+0GPb3LxbVkgL8r3IRK7F0mjFsfrKPESgqF3k3m
         trJs3pHAhSKWXLcfS0oDPheGf6nSOcWoIdo9vIBIqwq3bUw3YftAZr3FRjyvFjboviMm
         m1yxmqDOq12M4Prev+7rnQ0HhTqOpHakWshccdFOGcWzo5c0CDyH49NmMFdZio+vagnF
         4IyVBKa87OhwemYAsFjPolTvz0pwbh+dztG1N+SkPK+3XfZOYIkdYyyZShf8i7EAUUYy
         GHJf+VpnFXseSt9BHBSn615KLmN+aqAnKlT+eLp0ZJ1CiwXu8Wuycbw587doVGhIMoKW
         hi0g==
X-Gm-Message-State: APjAAAUbFw10ZdruJQ3IRaDCrkDowAYjLd97m8gW7c9I4e4GUxV0LCWh
        /qNYwX+Z22BTFDUXn7J/GhuH5EJW+flrOA==
X-Google-Smtp-Source: APXvYqzc+AsW4ZOIn8LcwEkNbf6geCnMtHj/uM/luJQFVU08Hw7GR90DEjIbBO8Yfy27zfgzGqT8Rg==
X-Received: by 2002:a17:90a:fa3:: with SMTP id 32mr8129966pjz.35.1568239892801;
        Wed, 11 Sep 2019 15:11:32 -0700 (PDT)
Received: from [192.168.1.188] ([23.158.160.160])
        by smtp.gmail.com with ESMTPSA id q4sm24322182pfh.115.2019.09.11.15.11.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Sep 2019 15:11:31 -0700 (PDT)
Subject: Re: [Ksummit-discuss] [PATCH v2 3/3] libnvdimm, MAINTAINERS:
 Maintainer Entry Profile
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Dave Jiang <dave.jiang@intel.com>,
        ksummit-discuss@lists.linuxfoundation.org,
        linux-nvdimm@lists.01.org, Vishal Verma <vishal.l.verma@intel.com>,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org
References: <156821692280.2951081.18036584954940423225.stgit@dwillia2-desk3.amr.corp.intel.com>
 <156821693963.2951081.11214256396118531359.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20190911184332.GL20699@kadam>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <9132e214-9b57-07dc-7ee2-f6bc52e960c5@kernel.dk>
Date:   Wed, 11 Sep 2019 16:11:29 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190911184332.GL20699@kadam>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 9/11/19 12:43 PM, Dan Carpenter wrote:
> On Wed, Sep 11, 2019 at 08:48:59AM -0700, Dan Williams wrote:
>> +Coding Style Addendum
>> +---------------------
>> +libnvdimm expects multi-line statements to be double indented. I.e.
>> +
>> +        if (x...
>> +                        && ...y) {
> 
> That looks horrible and it causes a checkpatch warning.  :(  Why not
> do it the same way that everyone else does it.
> 
> 	if (blah_blah_x && <-- && has to be on the first line for checkpatch
> 	    blah_blah_y) { <-- [tab][space][space][space][space]blah
> 
> Now all the conditions are aligned visually which makes it readable.
> They aren't aligned with the indent block so it's easy to tell the
> inside from the if condition.
> 
> I kind of hate all this extra documentation because now everyone thinks
> they can invent new hoops to jump through.

FWIW, I completely agree with Dan (Carpenter) here. I absolutely
dislike having these kinds of files, and with subsystems imposing weird
restrictions on style (like the quoted example, yuck).

Additionally, it would seem saner to standardize rules around when
code is expected to hit the maintainers hands for kernel releases. Both
yours and Martins deals with that, there really shouldn't be the need
to have this specified in detail per sub-system.

-- 
Jens Axboe

