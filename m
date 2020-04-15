Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 038E61AAB47
	for <lists+bpf@lfdr.de>; Wed, 15 Apr 2020 17:04:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729666AbgDOPE2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Apr 2020 11:04:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729650AbgDOPEY (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 15 Apr 2020 11:04:24 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80DDDC061A0C
        for <bpf@vger.kernel.org>; Wed, 15 Apr 2020 08:04:23 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id v2so88463plp.9
        for <bpf@vger.kernel.org>; Wed, 15 Apr 2020 08:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=w+g7W43L4S2tdEDsfdb51GCHQJ3CkZ2b+pWwC+AJy9s=;
        b=BtgyioFancJAj22nWdvrKnEXL0GcZ4br8mt82X1EpURTG2bmhWDva1BlqCJqTk+BuZ
         OfTdbrIF7p7Io8GeGcjmivWGgx0zfAyvBh7ldkkGhzPMmxXunOjn/+DN60IOLDqKCJpa
         /hd9elv+YdDYzllSfcCbgauYtiW78blhn76UIlt0BpgeD8iQl0mhhUppefCKaoZq3oC0
         bg8dups1fxeu2WcwbuhOv7sGc182mYHJ/Hoq7mlmLgigPwyNuZEtcg8oDk7i3IV/IUbz
         uwgNnXxijXRyBOXq7bwmU9yrX+W9neyh/Swoi+6V5tDChp5y3uBDktzpwB5xQjMqgUVV
         QKag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=w+g7W43L4S2tdEDsfdb51GCHQJ3CkZ2b+pWwC+AJy9s=;
        b=m7QjfhHgW/NL5Prf15bZMJ7yl6hjpM/xwvTGeUToK2IfVRr6TY7MAYfCljo4oA3VsF
         eHHeUnGoeCtrA/m7CiWsYgW0sftvZepCDCQ0lX0DWkGkZdZvhQbgjF9gD3pWRtNLI9/T
         AassdfzEahlgB5XlwlKU+NzgPfFdtyzwL+Bjs6KOYvtniRYVWHrSHENd7vRCw/7wLT5S
         Q4Z0QB9Io3b7towmyfYy7dPRnCl3sU+yP2gSrn3WFr1jmV5q1rthj9MWq7bJyrrng96F
         N9SyjVv8mloP1gYelSqHdzh7GmhS0WW87fOohz+RV4IPAqxdVpVofiqohUbNbJwebEU+
         a5rg==
X-Gm-Message-State: AGi0PuZ0Xjj8WhY4CA18w9DZMV0lq2vbpVJbjGk/8rQqHrF6Ssa/DtA+
        RoOS3SWwAXVM5U80vCUR9MCC9+IX
X-Google-Smtp-Source: APiQypKiKA0dylpxT3XdVgTGbr45iWXYAJDxDkTjwr7Cdi98/YBYDIa9/Ew71GaipSMroSadAWq4Vg==
X-Received: by 2002:a17:90a:fa87:: with SMTP id cu7mr6654090pjb.92.1586963062604;
        Wed, 15 Apr 2020 08:04:22 -0700 (PDT)
Received: from ast-mbp ([2620:10d:c090:400::5:40b6])
        by smtp.gmail.com with ESMTPSA id y14sm2792311pfg.129.2020.04.15.08.04.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2020 08:04:21 -0700 (PDT)
Date:   Wed, 15 Apr 2020 08:04:19 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Tiffany Kalin <tkalin@untangle.com>
Cc:     bpf@vger.kernel.org
Subject: Re: Bpfilter Installation
Message-ID: <20200415150419.ynaedkwnvu3ii3lg@ast-mbp>
References: <CABkdAXa0y=fvAU63Wsk1b1rF1AHNraJrsRnyXfScELvqswc+OA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABkdAXa0y=fvAU63Wsk1b1rF1AHNraJrsRnyXfScELvqswc+OA@mail.gmail.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Apr 13, 2020 at 02:22:07PM -0600, Tiffany Kalin wrote:
> Hi,
> 
> I am interested in bpfilter and I wanted to play around with it. I
> installed the latest Linux kernel (make && make modules_install &&
> make install) with BPFILTER set to yes.
> Following this video: https://www.youtube.com/watch?v=AfgwVya9Cog
> I tried to run the bpfilter.ko, but it did not work. I could not do
> modprobe nor insmod for bpfilter. Is there something I'm missing in
> order to have bpfilter.ko run? Or is there a new way to run bpfilter?
> Any guidance/help would be appreciated!

I don't think youtube is a great way to communicate on the mailing list,
since it's impossible to comment inline.
please explain in an email what your expectations for bpftiler are and
what you want to achieve.
Thanks
