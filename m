Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40C344166B4
	for <lists+bpf@lfdr.de>; Thu, 23 Sep 2021 22:30:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243178AbhIWUcW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Sep 2021 16:32:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240613AbhIWUcV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Sep 2021 16:32:21 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92EE0C061574
        for <bpf@vger.kernel.org>; Thu, 23 Sep 2021 13:30:49 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id s11so7473234pgr.11
        for <bpf@vger.kernel.org>; Thu, 23 Sep 2021 13:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jnmuj3o/VG+4mzMvqnawceJ8cbbdGFygmSU4W3i94Wo=;
        b=RMnCnd2U3CLa+XQwRcvUW2EwATkIYMwWbgRLOVDJLNp0jjrxqO4/kdRDqqN/RK6KBy
         1g8kuf+MWuW8+wh96oZuSAA0b5FpWrj7jQLxODyihImtsCWoQByEUDxHOifpH+Khu347
         2kXaXhHYuu8ctTrqc4CA3RyAQc70ZA1D6z98LCXGWUXU58hkklRXabimMdGvQ7285Z/d
         Z1vjp0QejaVcpZwR6C4un/X5+qu/BUJFgMOvGX5qo8crYFXddK66r9QBuQX7bwjVEaXi
         suGkOhas4uRvBc4xC+jwIkLCoKuFXxo5EP/PCBp+pA1DkFygSVf7PfojWMqWeF9BZCab
         Eo2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jnmuj3o/VG+4mzMvqnawceJ8cbbdGFygmSU4W3i94Wo=;
        b=4J+9eeu5EqCJWaoXnbc55lqxL4Nqs9gWuCVTxybQABUC24eYa9qb/U/Li52l/c5e3N
         qkp9hyi6BLPa5QTrurvVUKbd8PuWNFKtg6FZPTm2PYHpyFHocvOwVonitdS5VYqNMbv7
         lwx4pB3dlJepJ2asjoZ1ru3mH4whzztppzkAqnAfYVjX/BVo/0VYYPJmRtfoSDCf1snc
         +LT6zblQzyGtNffMpffSeGJeUW0G/zm2D8+Is6sf0mvCVrY0lgFf4PYmUWBp6l+2dUT/
         ebjGA5ZvHUTVUMzYEWt/p430socwRo9T5wxvE8f1cXMVeiRTwOMPW3YWVhohtdwtI5OB
         v4NQ==
X-Gm-Message-State: AOAM533Dsw9jJUw9GzlC8KokMvWZgKEZGWDGvCS4ksTLbjyItvtJWK7Y
        TAaNENOsDqNV5Zs6Ks7QBBo7d8Akg4E=
X-Google-Smtp-Source: ABdhPJxlts72hyy3GTBn9iMFjP7w6EhDPvChX9glafEB30GTbQ/AaaAIZ2ThbGJE4tVjG+gF6YYPeQ==
X-Received: by 2002:a63:9dc7:: with SMTP id i190mr516482pgd.261.1632429049104;
        Thu, 23 Sep 2021 13:30:49 -0700 (PDT)
Received: from ast-mbp ([2620:10d:c090:500::7:504a])
        by smtp.gmail.com with ESMTPSA id y3sm6355545pjg.7.2021.09.23.13.30.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 13:30:48 -0700 (PDT)
Date:   Thu, 23 Sep 2021 13:30:46 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Joanne Koong <joannekoong@fb.com>, bpf <bpf@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH v3 bpf-next 1/5] bpf: Add bloom filter map implementation
Message-ID: <20210923203046.a3fsogdl37mw56kp@ast-mbp>
References: <20210921210225.4095056-2-joannekoong@fb.com>
 <CAEf4BzZfeGGv+gBbfBJq5W8eQESgdqeNaByk-agOgMaB8BjQhA@mail.gmail.com>
 <517a137d-66aa-8aa8-a064-fad8ae0c7fa8@fb.com>
 <20210922193827.ypqlt3ube4cbbp5a@kafai-mbp.dhcp.thefacebook.com>
 <CAEf4BzYi3VXdMctKVFsDqG+_nDTSGooJ2sSkF1FuKkqDKqc82g@mail.gmail.com>
 <20210922220844.ihzoapwytaz2o7nn@kafai-mbp.dhcp.thefacebook.com>
 <CAEf4BzaQ42NTx9tcP43N-+SkXbFin9U+jSVy6HAmO8e+Cci5Dw@mail.gmail.com>
 <20210923012849.qfgammwxxcd47fgn@kafai-mbp.dhcp.thefacebook.com>
 <CAEf4BzYstaeBBOPsA+stMOmZ+oBh384E2sY7P8GOtsZFfN=g0w@mail.gmail.com>
 <20210923194233.og5pamu6g7xfnsmp@kafai-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210923194233.og5pamu6g7xfnsmp@kafai-mbp>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Sep 23, 2021 at 12:42:33PM -0700, Martin KaFai Lau wrote:
> 
> How to move it forward from here?  Is it a must to keep the
> bloomfilter-like map in pure bpf only and we should stop
> the current work?
> 
> or it is useful to have the kernel bloom filter that provides
> a get-and-go usage and a consistent experience for user in
> map-in-map which is the primary use case here.  I don't think
> this is necessarily blocking the custom bpf map effort also.

I think map based and helper based bloom filter implementations
are far from equivalent. There are pros and cons to both.
For example the helper style doesn't have a good way
of query/populate from the user space. If it's a single element
array the user space would be forced to allocate huge buffers
just to read/write single huge value_size.
With multi element array it's sort-of easier.
mmap-ing the array could help too,
but in either case the user space would need to copy-paste jhash,
which is GPL, and that might be more than just inconvenience.
We can try siphash in the bpf helper and give it a flag to choose
between hash implementations. That helps, but doesn't completely
makes them equivalent.

As far as map based bloom filter I think it can combine bitset
and bloomfilter features into one. delete_elem from user space
can be mapped into pop() to clear bits.
Some special value of nr_hashes could mean that no hashing
is applied and 4 or 8 byte key gets modulo of max_entries
and treated as a bit index. Both bpf prog and user space will
have uniform access into such bitset. With nr_hashes >= 1
it will become a bloom filter.
In that sense may be max_entries should be specified in bits
and the map is called bitset. With nr_hashes >= 1 the kernel
would accept key_size > 8 and convert it to bloom filter
peek/pop/push. In other words
nr_hash == 0 bit_idx == key for set/read/clear
nr_hashes >= 1 bit_idx[1..N] = hash(key, N) for set/read/clear.
If we could teach the verifier to inline the bit lookup
we potentially can get rid of bloomfilter loop inside the peek().
Then the map would be true bitset without bloomfilter quirks.
Even in such case it's not equivalent to bpf_hash(mem_ptr, size, flags) helper.
Thoughts?
