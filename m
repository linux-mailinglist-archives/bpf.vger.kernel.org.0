Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0AE4DDCA3C
	for <lists+bpf@lfdr.de>; Fri, 18 Oct 2019 18:04:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502382AbfJRQED (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 18 Oct 2019 12:04:03 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34203 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502380AbfJRQED (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 18 Oct 2019 12:04:03 -0400
Received: by mail-pl1-f193.google.com with SMTP id k7so3072238pll.1
        for <bpf@vger.kernel.org>; Fri, 18 Oct 2019 09:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WyRm5TgT1NppVOAzvM76cGWpZdrCJEG5ZPfeSyW5GBc=;
        b=WHfqXhuZbG5VlkTSKvkK4q3O4dVt+rJPdJ4dUveg628tVSs4aoifX56fntLqRp+l0G
         4gRKf3/GNROQmF/RuHiWEayNXCQV+rgjRX97nT/JO0bvHe5LWMUW9U/wdzuSDHEst4Cf
         pNzoqV9X0e+66TUebGND6FbODUcts1mCHlu1GNETkxO2Bs46dIYaZTyaSreQdamieUGJ
         U+8nA5fFsywNlZfMjJLgNCuMkRrXd4oG9SKi544D86a+pvStLV+HCVy63HNoeSOFPdKd
         Z5yTZy5xBSZunFpS7q1/Js9cFq4JwpwrNYWgh16wKwIRXs8kv1pKa6B6NR92eGa47ykS
         d4Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WyRm5TgT1NppVOAzvM76cGWpZdrCJEG5ZPfeSyW5GBc=;
        b=IyTvmRtWlzXqbX4CLisXs3DxpVmQLiJb1HuwObcJaEN6epdxWv+6D+gpybSRvDkoIV
         naqjnMZnuzwk5CUjWO2haU9EZWcPSq/bEalHvVhO8GrKYK3HEj8HffUA3yLK4mudzbtU
         EcxOozOvnZ+1mupknuWzrA38kaEqR8ut3yHT4WyOqin/aDn8IA2f5hTRMcqOA5Oo7KWk
         V30E3F9/0skqiCmhwJzfnFrn4Bb9eOhWh6hPe73SerYUFLDzppLMyOM74Ynvrdtg6Q11
         Fs8+xlqlykFOvqxFFx/d7FvmH/Upc089hC++xW69rA8Bl7s+zvrOFRkYjJCJQMCB7BAQ
         muNw==
X-Gm-Message-State: APjAAAWKDlHjZIzWNYlktMf5fkC2u8yJaG4IpIjAvO/tLgAW1cfiNEAu
        mYeFAai4W65+KkMszYmmxlI=
X-Google-Smtp-Source: APXvYqxEhVq3h8PKzyBL4MoOwYiOSuaR/fpyXBF6ZX6ZJWTLeb033PXIxbay/f4G6M0AM406y7t6GQ==
X-Received: by 2002:a17:902:d915:: with SMTP id c21mr2955132plz.264.1571414642491;
        Fri, 18 Oct 2019 09:04:02 -0700 (PDT)
Received: from ast-mbp ([2620:10d:c090:180::a579])
        by smtp.gmail.com with ESMTPSA id 74sm7368145pfy.78.2019.10.18.09.04.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Oct 2019 09:04:01 -0700 (PDT)
Date:   Fri, 18 Oct 2019 09:03:59 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Lorenz Bauer <lmb@cloudflare.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        joe@wand.net.nz
Subject: Re: [PATCH bpf] bpf: improve htab_map_get_next_key behaviour during
 races
Message-ID: <20191018160357.rq7twrwywpuc4xax@ast-mbp>
References: <20191018134311.7284-1-lmb@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191018134311.7284-1-lmb@cloudflare.com>
User-Agent: NeoMutt/20180223
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Oct 18, 2019 at 02:43:11PM +0100, Lorenz Bauer wrote:
> To iterate a BPF map, userspace must use MAP_GET_NEXT_KEY and provide
> the last retrieved key. The code then scans the hash table bucket
> for the key and returns the key of the next item.
> 
> This presents a problem if the last retrieved key isn't present in the
> hash table anymore, e.g. due to concurrent deletion. It's not possible
> to ascertain the location of a key in a given bucket, so there isn't
> really a correct answer. The implementation currently returns the
> first key in the first bucket. This guarantees that we never skip an
> existing key. However, it means that a user space program iterating
> a heavily modified map may never reach the end of the hash table,
> forever restarting at the beginning.
> 
> Fixing this outright is rather involved. However, we can improve slightly
> by never revisiting earlier buckets. Instead of the first key in the
> first bucket we return the first key in the "current" bucket. This
> doesn't eliminate the problem, but makes it less likely to occur.
> 
> Prior to commit 8fe45924387b ("bpf: map_get_next_key to return first key on NULL")
> passing a non-existent key to MAP_GET_NEXT_KEY was the only way to
> find the first key. Hence there is a small chance that there is code that
> will be broken by this change.

It is 100% chance that it will break older bcc tools that were written
before NULL was possible argument for get_next_key.
Please see Yonghong's patches for batched map lookup.
That's the proper way to solve your problem.

