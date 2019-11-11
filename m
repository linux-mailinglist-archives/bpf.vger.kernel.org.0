Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14908F7F09
	for <lists+bpf@lfdr.de>; Mon, 11 Nov 2019 20:08:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727563AbfKKTH3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 11 Nov 2019 14:07:29 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:35213 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727290AbfKKShs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 11 Nov 2019 13:37:48 -0500
Received: by mail-pl1-f195.google.com with SMTP id s10so8147570plp.2
        for <bpf@vger.kernel.org>; Mon, 11 Nov 2019 10:37:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=XOOoBZ0re6Ve1q2YuhhAZNQkL2NgQkbUu3Jh3Rye1tk=;
        b=TxYshMCdbP5TCGKLfCSTUv0fMznilQ9G2WFtv1pXk+y365BLer6Km1l/7JlK6fOfHi
         wxiH4nxUt26GY+Y+pIhVcCs2APSYNYWw1ppktjgjuKrsPZxM9v6Do6Nkx6WIUYrtHjwM
         JdXUXs7bI/4vqB6ujDqZvRUUW/l/Ijh/l9TGHPn+hswU9lYir2GkAijBREnofHecRTY1
         f56Z3hRRN7zMxjBHcvJfhgWhyAC9fF1Zu5ui+u+UjVwYhSgp07TWYkp4rv7iL5TAGD6b
         MpaYGCO85YpTDqGHp7ddsYZdXPClkeXQckV5Ckrt1TVOyJygmGTRk8EXWDvi6yHJX2XD
         7n0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=XOOoBZ0re6Ve1q2YuhhAZNQkL2NgQkbUu3Jh3Rye1tk=;
        b=qFIBTkdmW+gAU9FKmWg+5ntuSq5jvt4bECAhyhybLjgTci246IkCS6MUbN1eS9NGCJ
         XyL+dIgGz/p7XsgThdGMWmzR1eZ2L7SyrIr22ds0SGHwObXhq+Pr4H+86O7S7+HTpm7+
         VZNUi4ZZaj98KEY1ttFl1XVVVaVU7apI440SE1pMisE1aNmg8oVj5LiAhtV0bWxGCL8L
         pROpU9XKlw6wKG9BygBIpt40tEAHrGK1iOkTlGMArQSNNdZJLWx8aP2ZoIIlGPTPtsZb
         Z1YDtGShUah8H7P2dvdIOhp0hCBeKwwmiMGZLYoM4m4BdyIdriVXWAx/hIjfCyoJXJWb
         H8cQ==
X-Gm-Message-State: APjAAAXCGKHL228jQzXpnqEOXy5OkxTMZIt/0cCCvmmoH+irdGELYIGl
        tfdE/Lr2BrtMTLq+/SoIre3nCg==
X-Google-Smtp-Source: APXvYqyMQBUyQf6Gl4KA2tQxYftn7cNhpbPzeLivgGlsCF2E02Jz5hoKgzYxZ8zY2vaet9QD3NJZrA==
X-Received: by 2002:a17:902:fe10:: with SMTP id g16mr532442plj.102.1573497467456;
        Mon, 11 Nov 2019 10:37:47 -0800 (PST)
Received: from cakuba (c-73-202-202-92.hsd1.ca.comcast.net. [73.202.202.92])
        by smtp.gmail.com with ESMTPSA id z23sm14003206pgu.16.2019.11.11.10.37.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 10:37:47 -0800 (PST)
Date:   Mon, 11 Nov 2019 10:37:43 -0800
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Andrii Nakryiko <andriin@fb.com>
Cc:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <ast@fb.com>,
        <daniel@iogearbox.net>, <andrii.nakryiko@gmail.com>,
        <kernel-team@fb.com>, Rik van Riel <riel@surriel.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH v2 bpf-next 1/3] bpf: add mmap() support for
 BPF_MAP_TYPE_ARRAY
Message-ID: <20191111103743.1c3a38a3@cakuba>
In-Reply-To: <20191109080633.2855561-2-andriin@fb.com>
References: <20191109080633.2855561-1-andriin@fb.com>
        <20191109080633.2855561-2-andriin@fb.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, 9 Nov 2019 00:06:30 -0800, Andrii Nakryiko wrote:
> With BPF_F_MMAPABLE array allocating data in separate chunk of memory,
> array_map_gen_lookup has to accomodate these changes. For non-memory-mapped
> there are no changes and no extra instructions. For BPF_F_MMAPABLE case,
> pointer to where array data is stored has to be dereferenced first.
> 
> Generated code for non-memory-mapped array:
> 
> ; p = bpf_map_lookup_elem(&data_map, &zero);
>   22: (18) r1 = map[id:19]
>   24: (07) r1 += 408			/* array->inline_data offset */
>   25: (61) r0 = *(u32 *)(r2 +0)
>   26: (35) if r0 >= 0x3 goto pc+3
>   27: (67) r0 <<= 3
>   28: (0f) r0 += r1
>   29: (05) goto pc+1
>   30: (b7) r0 = 0
> 
> Generated code for memory-mapped array:
> 
> ; p = bpf_map_lookup_elem(&data_map, &zero);
>   22: (18) r1 = map[id:27]
>   24: (07) r1 += 400			/* array->data offset */
>   25: (79) r1 = *(u64 *)(r1 +0)		/* extra dereference */
>   26: (61) r0 = *(u32 *)(r2 +0)
>   27: (35) if r0 >= 0x3 goto pc+3
>   28: (67) r0 <<= 3
>   29: (0f) r0 += r1
>   30: (05) goto pc+1
>   31: (b7) r0 = 0

Would it not be possible to overallocate the memory and align the start
of the bpf_map in case of BPF_F_MMAPABLE so that no extra dereference
is needed?
