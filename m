Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 714FA43E06F
	for <lists+bpf@lfdr.de>; Thu, 28 Oct 2021 14:02:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbhJ1MEf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 28 Oct 2021 08:04:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48139 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229578AbhJ1MEf (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 28 Oct 2021 08:04:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635422528;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=OgFJHZa14rAj0gelQuYCdVS3Z6a6zIUIxaF4Uxm+NZ8=;
        b=QllCddqi2t+hixWzt1oX0nH9Khyw9G92gUVtK5jP01AhIzG8LHIhoZDiW45yvuH6idF9ZH
        4FqT0GExd6Mx7AyXAU1Eauug8sI85geucBFyxfGOZPqXzub0ND5Hi3rCffEep6VsF37fhU
        tLYbjFyFmnTNgjMBpCbMLPWbnM1prY4=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-539-_e7jKhZoN8ibheqbkx8D6Q-1; Thu, 28 Oct 2021 08:02:06 -0400
X-MC-Unique: _e7jKhZoN8ibheqbkx8D6Q-1
Received: by mail-ed1-f70.google.com with SMTP id i9-20020a508709000000b003dd4b55a3caso5344921edb.19
        for <bpf@vger.kernel.org>; Thu, 28 Oct 2021 05:02:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:message-id:date:mime-version:user-agent:cc
         :content-language:to:subject:content-transfer-encoding;
        bh=OgFJHZa14rAj0gelQuYCdVS3Z6a6zIUIxaF4Uxm+NZ8=;
        b=vRkPvR3kiapSNwtVP1IJLU6UezsqhKBMZ8M38uhRw7/tB1ZGKcCBGq//HsNsKYp5PU
         d3tYyUXoW6QR22Is6+aGOzFEKzNKRkdsi6YhIllEMhU4gng0AGHvgAVyYLOyD/cwbTDM
         wU0AdsCiD6NlTl0PVZCgk9iUmdTjK6boXWZ4JLY2Mlab1vM1vZf6GdJwfUWPm2+mcHyw
         66AVQlT7fE78PfagB6dujXNr/dSeWiGe4HQabZPApLngsSmNY8sKQ5tmecMsPmGGhg4X
         WivhPHBWu4hLAFn7qPXzajEdnRUA2yoX08GkegO1lG2mfELXnJmRu3qJJ786HgmN7nrw
         xTfw==
X-Gm-Message-State: AOAM531mTzTCSf+9kiU/OPbsviJ3h6ILzwM7pxbGio9B+68ZYo+ea3Su
        9bA1eK/+rR4PRdLtXru7Z8ioRzk2uSg1pxvuYiq/XdnByBbbS6Rbbj0wcysDuT3n7h7muPTRJHP
        AIbTGo22yAm6Z
X-Received: by 2002:a05:6402:11d4:: with SMTP id j20mr5565084edw.267.1635422524813;
        Thu, 28 Oct 2021 05:02:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJymg1HCihMeCfA3y3WOtCGDQDsvuoMR6FnvJ1vYrlW/fFFevBSBWb11VTCX76JkmAm5Dad9KA==
X-Received: by 2002:a05:6402:11d4:: with SMTP id j20mr5565061edw.267.1635422524624;
        Thu, 28 Oct 2021 05:02:04 -0700 (PDT)
Received: from [192.168.42.238] (3-14-107-185.static.kviknet.dk. [185.107.14.3])
        by smtp.gmail.com with ESMTPSA id t22sm1508069edt.40.2021.10.28.05.02.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Oct 2021 05:02:03 -0700 (PDT)
From:   Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <829e159a-b573-345f-fabe-fe68a756b21b@redhat.com>
Date:   Thu, 28 Oct 2021 14:02:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Cc:     brouer@redhat.com, bpf <bpf@vger.kernel.org>,
        Toke Hoiland Jorgensen <toke@redhat.com>
Content-Language: en-US
To:     Andrii Nakryiko <andrii@kernel.org>
Subject: libbpf - why find_program_by_title ?
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Andrii,

The libbpf API bpf_program__title() is getting depricated (which is 
great BTW). (p.s. Instead use bpf_program__section_name()).

Why do we still have bpf_object__find_program_by_title() ?

Shouldn't we also deprecate that?
And introduce bpf_object__find_program_by_section_name().

--Jesper

