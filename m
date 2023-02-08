Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 916E768F7FD
	for <lists+bpf@lfdr.de>; Wed,  8 Feb 2023 20:25:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231341AbjBHTZW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Feb 2023 14:25:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231800AbjBHTZV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 Feb 2023 14:25:21 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 955101BD1
        for <bpf@vger.kernel.org>; Wed,  8 Feb 2023 11:25:19 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id q13so3745547qtx.2
        for <bpf@vger.kernel.org>; Wed, 08 Feb 2023 11:25:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NFlrkeEXgNWehBcAx33U4rHt/JekvgpyEDTdyrAYRpU=;
        b=V22eJSdBMDmC4TCgyxOGFJrfM6rr9USfSzc03bCGt+fb1AGhUkoO4mPupY7BkmUPcW
         9PLRYSREg9TZGrUb4untXaC0WGKlnYuiybeZG6+AEES7ANGcxhPrpvJFhYFt14ySsacP
         zWZXSIDMuEuhKm492fjso5d4Crwy/54yXB4gdinpsDa9rrMoQL+vq94D3qXNLu1kbFqw
         VZx/SG/pw5nT9PyCitWVS+8RXy1V9zlSbsPMp0/njff5Qd+Cx+5MGVA/bbKr8JtgDcNH
         pjKTU/v0/+ZBzy5BZgvnetEVi41tw+lVU8tureVuK6l0DWCCnwmIZeWqP8euzinHhQcq
         kQEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NFlrkeEXgNWehBcAx33U4rHt/JekvgpyEDTdyrAYRpU=;
        b=lkZ+NmY7VUVTb/27JCS45EOI/jaxrgqAV0sbhKh5/64zIoKYWFIdfpObZCsbWcWYPU
         1d8eaiD7wZIkGnws6R/J7TA3jnYmn/yfWPioM4V5HvFevljaIkQDmWByzU2BiTRxYsW6
         /UhXkU/hiAZ+LKCuyUkxeAPY1cKe7PJ9SXLNQKd/xGoMeyMncVchuqLwuxbMpMGQbjU0
         YjyqIihYNu39xAb9bKvXdOTer/Ow5XvXtelMjt3WioMR0G89FGXVFSrtzEG6hegGkPGp
         TQqo0rQvV5kZN09JuxJABe8s/7R5TglpKixaQS0/NVkt7Y5GK56UdOgexAfOwyuitnIL
         MP1g==
X-Gm-Message-State: AO0yUKVPFBkNiuAhG7pcq/U6Y1M9utISnKZk+/o0Ac8oHnqZen9ivpMt
        geFRSr8ClI+CGfNGdLQaFz31cw==
X-Google-Smtp-Source: AK7set8XcNRm6tPbkByIqalkedbpySv8bjESt4jGk2jFPI2Hkasx9aKHrLecauBSzgUTWeuoxFut2A==
X-Received: by 2002:ac8:7d4a:0:b0:3b4:a6af:a2f2 with SMTP id h10-20020ac87d4a000000b003b4a6afa2f2mr14968503qtb.34.1675884318724;
        Wed, 08 Feb 2023 11:25:18 -0800 (PST)
Received: from localhost (2603-7000-0c01-2716-8f57-5681-ccd3-4a2e.res6.spectrum.com. [2603:7000:c01:2716:8f57:5681:ccd3:4a2e])
        by smtp.gmail.com with ESMTPSA id k6-20020ac80206000000b003b9bd163403sm7091871qtg.4.2023.02.08.11.25.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 11:25:18 -0800 (PST)
Date:   Wed, 8 Feb 2023 14:25:17 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     tj@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, mhocko@kernel.org,
        roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, akpm@linux-foundation.org,
        bpf@vger.kernel.org, cgroups@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH bpf-next 2/5] bpf: use bpf_map_kvcalloc in
 bpf_local_storage
Message-ID: <Y+P3HSLNR94wILP1@cmpxchg.org>
References: <20230205065805.19598-1-laoar.shao@gmail.com>
 <20230205065805.19598-3-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230205065805.19598-3-laoar.shao@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Feb 05, 2023 at 06:58:02AM +0000, Yafang Shao wrote:
> Introduce new helper bpf_map_kvcalloc() for this memory allocation. Then
> bpf_local_storage will be the same with other map's creation.
> 
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>

This looks good to me, but it could be helpful to explain the
user-visible part of the bug somewhat, i.e. who is being charged right
now for the allocation if it's not the map owner.
