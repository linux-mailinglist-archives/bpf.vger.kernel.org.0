Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9EF1EF998D
	for <lists+bpf@lfdr.de>; Tue, 12 Nov 2019 20:18:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbfKLTSA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 12 Nov 2019 14:18:00 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39761 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726977AbfKLTSA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 12 Nov 2019 14:18:00 -0500
Received: by mail-lj1-f196.google.com with SMTP id p18so19109912ljc.6
        for <bpf@vger.kernel.org>; Tue, 12 Nov 2019 11:17:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=1kWYIraaT/XfpcPhtfE2LW+E738Svg2k2/zd4/7T1y4=;
        b=cMLwHeU3DwLApFzFzxhSdMhSpcgSZylFeuyPJKUfaRi+dJiXtMNu6/lac3XlcL7mZZ
         hU1ptfM1qfav/NdUVC+rNtwl1P98Q6nEkAp8+AnuFZrUN1hHg99VMA8qoq4CiEQfqQz5
         gSP7YGeH+z+8+/tIE5zZ2r8YjLI/VFDy5E+SGMrjyNYeJmviWPZkqK187tndtvC5PBlf
         Wh3ij+QtwI4V7Nj440dz9SHR83XwcKrqyJDywRKbSwpVRZSNg1CftOmASNRxT2ksXXob
         t5l1s6o9upBm6NntEAvcUZJWhGxQWnf2JPge+1XeAZKGHcOElaPunYT/fK3cM5Nbv5HP
         qnEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=1kWYIraaT/XfpcPhtfE2LW+E738Svg2k2/zd4/7T1y4=;
        b=C6M66Ch8N4fEOFf1yzRHcqRb+bjPmmFg9f3OBaGSDTJs5MXwHnFLLzHBucNKs0komy
         2h6hEBJXpKCqNncOgC6TSDVK1B9xW6G7nlUByD6XeOwE78tnQhPUEVdpZtr/JScITCrY
         obS+/q9hxbkzx46jEgLnSbltQ2LhM+cO4sQ5TTpNqtms/UCI6/9rcDkwhRGUoQwre5iB
         AAu8aDhrV4UK4oGZq/d2rtPfamjyOxR95m1czuD/ZgrDfEkbskUaYAYtqtDbiKW8Es2D
         EkP++BnJDtB3y1X9zseFJO/Gp3ty6rAKp7dUVy8fFa7oZXsqJunT6voE+ldFBqaRIZ85
         6ASA==
X-Gm-Message-State: APjAAAVps099ExJdJnY+Q9IaY3Okuvi2WOPV9WUI18yceMnmFDiHN73D
        UZUIj/iriwyYaJYGtDcm0td5yQ==
X-Google-Smtp-Source: APXvYqzNWIsqkYNlBh8G2/Kjxp+Ko53ku3BivLZk5V2q8Xergo2UgM7e05OSC6xq2dyuFaiI3HO89g==
X-Received: by 2002:a2e:89c2:: with SMTP id c2mr21390441ljk.161.1573586278084;
        Tue, 12 Nov 2019 11:17:58 -0800 (PST)
Received: from cakuba ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id q2sm1362954lfp.26.2019.11.12.11.17.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2019 11:17:57 -0800 (PST)
Date:   Tue, 12 Nov 2019 11:17:50 -0800
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Andrii Nakryiko <andriin@fb.com>, bpf <bpf@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>,
        Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        Rik van Riel <riel@surriel.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH v2 bpf-next 1/3] bpf: add mmap() support for
 BPF_MAP_TYPE_ARRAY
Message-ID: <20191112111750.2168b131@cakuba>
In-Reply-To: <CAEf4Bzay-sCd5+5Y1+toJuEd6vNh+R7pkosYA7V7wDqTdoDxdw@mail.gmail.com>
References: <20191109080633.2855561-1-andriin@fb.com>
        <20191109080633.2855561-2-andriin@fb.com>
        <20191111103743.1c3a38a3@cakuba>
        <CAEf4Bzay-sCd5+5Y1+toJuEd6vNh+R7pkosYA7V7wDqTdoDxdw@mail.gmail.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 11 Nov 2019 18:06:42 -0800, Andrii Nakryiko wrote:
> So let's say if sizeof(struct bpf_array) is 300, then I'd have to either:
> 
> - somehow make sure that I allocate 4k (for data) + 300 (for struct
> bpf_array) in such a way that those 4k of data are 4k-aligned. Is
> there any way to do that?
> - assuming there isn't, then another way would be to allocate entire
> 4k page for struct bpf_array itself, but put it at the end of that
> page, so that 4k of data is 4k-aligned. While wasteful, the bigger
> problem is that pointer to bpf_array is not a pointer to allocated
> memory anymore, so we'd need to remember that and adjust address
> before calling vfree().
> 
> Were you suggesting #2 as a solution? Or am I missing some other way to do this?

I am suggesting #2, that's the way to do it in the kernel.

You could make the assumption that if you're allocating memory aligned
to PAGE_SIZE, the address for vfree() is:

	addr = map;
	if (map->flags & MMAPABLE)
		addr = round_down(addr, PAGE_SIZE);
	vfree(addr);

Just make a note of the fact that we depend on vmalloc()s alignment in
bpf_map_area_alloc().
