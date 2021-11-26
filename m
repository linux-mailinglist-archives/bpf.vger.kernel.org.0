Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A69945F5ED
	for <lists+bpf@lfdr.de>; Fri, 26 Nov 2021 21:30:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234530AbhKZUdx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Nov 2021 15:33:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233208AbhKZUbx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 26 Nov 2021 15:31:53 -0500
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE369C061394
        for <bpf@vger.kernel.org>; Fri, 26 Nov 2021 12:25:13 -0800 (PST)
Received: by mail-ot1-x32b.google.com with SMTP id b5-20020a9d60c5000000b0055c6349ff22so15389787otk.13
        for <bpf@vger.kernel.org>; Fri, 26 Nov 2021 12:25:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=evPlulw1dOlV914cl4e2dWyI8GZKdC7Y4NdQJADGkXo=;
        b=qJQGRNIxz0jNiwv/Gk7gQgvw2vQDM9aNQnYxNwZ1cSi9mFzBkIu4KgWWIvQ+Nx2Ev2
         6lcU2jEA8WSQ5FE8K9sKjB0Xyuksvg1SiYYwrnunmfWmy84ToNHAU5P2pxLThetLmQFd
         54LYxjzMzjJL+9yIxVJx4IZbQFcRdZRLN+AnfNhM9cprvpOJdF7Zg2PVKuJO6jHpbg75
         PHHaiONHuXAYO6eHQj24uuPe3egxMjlnWSa/soobKf4uI25ZEFR+nP2/krRkamz0pbky
         zAr4rj4ct3CN3zfWKJo7M19JGEtNYQ46pW1/0uCt/OXP8n6qClm/90yeRjejCMBd9JfL
         0cMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=evPlulw1dOlV914cl4e2dWyI8GZKdC7Y4NdQJADGkXo=;
        b=QHeFSzV281sYlWE18IsYwmo5hoA03Aob6vFwhLqY+K5Lf8e7wTgWUDr2F/C3kdfHhq
         EHHJZxerDH4F9fNdQIdgz1CZtAN/x6mmZmxyo3saeXG/AjbOhq8JvWKVcFpizFGt74pb
         0cUetoCmg+0dDmQqoNlAkQUb0zgQ+vSzyaIgAF20zHdd+AC1s9+rpeLV3RgbcuiYnMXc
         prgKidpp377MbGdg8S7Z6wvjh8KvZiJKZP337br6gB7I3Hzul18EvXArd1eI0d5RppDt
         SD4blJv03RIctsYHmfXNCwGQF4fF+zEKhsdDMk2EuHKbwpuTBvLdswVhg39eN9IAvI4c
         /cOQ==
X-Gm-Message-State: AOAM531EKFd4zIMZl9eqCKi/ZkssLKahkzRgvNrOQvVvLyR1VRbMvFd+
        BJR2v0+kH0AKUdYp6goeXUQTan4J8j8=
X-Google-Smtp-Source: ABdhPJz8eWQXGAOlA0hNaoijUnlQ7rS5eMmrNpU5ohjbyhs0Oe2QOpaxVZLxe8+htdfIuTXzoSURbg==
X-Received: by 2002:a05:6830:1204:: with SMTP id r4mr30549551otp.34.1637958313139;
        Fri, 26 Nov 2021 12:25:13 -0800 (PST)
Received: from localhost ([2600:1700:65a0:ab60:4fa:e845:6c9f:cd5b])
        by smtp.gmail.com with ESMTPSA id s2sm1174213otr.69.2021.11.26.12.25.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Nov 2021 12:25:12 -0800 (PST)
Date:   Fri, 26 Nov 2021 12:25:10 -0800
From:   Cong Wang <xiyou.wangcong@gmail.com>
To:     Yahui Chen <goodluckwillcomesoon@gmail.com>
Cc:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>, zhangwei123171@jd.com
Subject: Re: can add a new bpf helper function
 bpf_map_compare_and_update_elem?
Message-ID: <YaFCplDzX3NjN3iB@unknown>
References: <CAPydje8FKWzRCR33RanGZkucavFZNb2zSGhfQdrd49Uvgc2YxQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPydje8FKWzRCR33RanGZkucavFZNb2zSGhfQdrd49Uvgc2YxQ@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Nov 25, 2021 at 04:34:48PM +0800, Yahui Chen wrote:
> Suppose we have a map, MAP_A, and the user program does the following:
> 
> 1. bpf_map_lookup_elem(MAP_A, key, value)
> 2. change the value
> 3. bpf_map_update_elem(MAP_A, key, value, FLAG)
> 
> At the same time, the kernel's BPF program may also be modifying the value.
> 
> Then we have concurrency problems.
> 

This is why we have bpf spinlock. ;)


> Therefore, can we add a helper function like compare and swap?
> 

I don't think you can atomically compare and swap values larger than
CPU word size.


Thanks.
