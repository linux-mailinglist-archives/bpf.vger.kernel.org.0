Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62555108FEF
	for <lists+bpf@lfdr.de>; Mon, 25 Nov 2019 15:30:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728065AbfKYOaF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 25 Nov 2019 09:30:05 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:36720 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727666AbfKYOaF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 25 Nov 2019 09:30:05 -0500
Received: by mail-pj1-f67.google.com with SMTP id cq11so6702146pjb.3
        for <bpf@vger.kernel.org>; Mon, 25 Nov 2019 06:30:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=msccr5HjWscnRgcVLCsdE6yYVz7Q2sue/VbW9SOWZmw=;
        b=mKJ+NwvVtI6FcgdMq5F/w8EQK/uCq/1Tv96638us4U2SeUPtgCfBoVC7GNubdUPOXi
         Uq0BCqB6jH4/hgq7ZEC1aAojo6Tjooj3VwnFdjuUO0Hx3yLUuvu7ojzZBQSdYqoT4OTc
         NxCkwhWFNZosyBGcl1O9H/DheqaaV/zH7d0n4UHvmmAuRIkQwQ1nVNOtJfkEvQg0KWHm
         HLivvhWynSvUUMlFGt8DrwrFvbGZDvyQtmf4M8WBolZyk2fGtjz49HsKUk4ogl4O8rc1
         XAphKwsU5JF77exAXET1EaMuVuw9zKnW5g2NrHywF/Jdh09bZu5NOgXtbwqkEJcDU0Rm
         DPWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=msccr5HjWscnRgcVLCsdE6yYVz7Q2sue/VbW9SOWZmw=;
        b=iOqIPEsd2cbcu7kc2fEENZ0jX+B3I7VUabOi1VRbuUgW+O9WP19IcEZ3lwTr7fyG1N
         uhrDjdeSgP/OqMskKNuIAmbQPh2azl2mcM/C5q8/zewmRhp0yrg6S/0z3t53a8j73zb+
         FbbLg8Gr04zcY+KDsVT/HVyLF593fGRSF88EpT6OldW20sk7E0epgSBYE4GAtPwPRwfW
         kOiYrSi6mPmYInNUBUlOShwGRsQ7jB8OzzubQB7MfFQHWbYtPfg/KNQHhwUeEYC0gSXc
         wtZUulbwxJnoq5lU97M87wg/JV9KPkx+qhamDoYN39CKpf0TUi2NvbNPuQ9Ciq0sj/Y+
         As3w==
X-Gm-Message-State: APjAAAWovRM/XCT6uBWpwKAsjwdOp6bzyPOGM6WE7MOhHAGO0ukKc7Ny
        yDqyBaCops6bPfLBSogG0ziuKA==
X-Google-Smtp-Source: APXvYqxDkKyiX6PQPBdq8saqXuktE9X6p6JGw5gsHRm/ywagCtmSK6UvwHwhYEuLy4/81lltcM75zg==
X-Received: by 2002:a17:90a:1ac8:: with SMTP id p66mr38436914pjp.24.1574692204117;
        Mon, 25 Nov 2019 06:30:04 -0800 (PST)
Received: from localhost ([2620:10d:c090:180::71c0])
        by smtp.gmail.com with ESMTPSA id h195sm9229020pfe.88.2019.11.25.06.30.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2019 06:30:03 -0800 (PST)
Date:   Mon, 25 Nov 2019 09:30:01 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrii Nakryiko <andriin@fb.com>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org, ast@fb.com,
        daniel@iogearbox.net, andrii.nakryiko@gmail.com, kernel-team@fb.com
Subject: Re: [PATCH bpf-next] mm: implement no-MMU variant of
 vmalloc_user_node_flags
Message-ID: <20191125143001.GA602168@cmpxchg.org>
References: <20191123220835.1237773-1-andriin@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191123220835.1237773-1-andriin@fb.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Nov 23, 2019 at 02:08:35PM -0800, Andrii Nakryiko wrote:
> To fix build with !CONFIG_MMU, implement it for no-MMU configurations as well.
> 
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Fixes: fc9702273e2e ("bpf: Add mmap() support for BPF_MAP_TYPE_ARRAY")
> Reported-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: Andrii Nakryiko <andriin@fb.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
