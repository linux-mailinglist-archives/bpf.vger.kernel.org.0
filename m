Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDDB625226E
	for <lists+bpf@lfdr.de>; Tue, 25 Aug 2020 23:06:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbgHYVGL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 Aug 2020 17:06:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726391AbgHYVGK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 Aug 2020 17:06:10 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A556C061574;
        Tue, 25 Aug 2020 14:06:10 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id i10so15453981ljn.2;
        Tue, 25 Aug 2020 14:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5imsyI0b83eRRG7XSm8dcgFIEu+jMWu3oUZKB77rnAk=;
        b=ixa9FJozDSEupBwlfbfT2YKeDnuGuwPKxniHDijVcnofGH60f/oOxgRLqF4uQMIZex
         ur5IuPNQdYJo/OsDiFthjqN4CuvC/8MAPB6+KkNDeQpSvOX2QdZjKWSXsss0/6Jo208g
         c9roI/+A7cr5YMtRaHqe4QevRkhAa9NQTVPa8+t6RCB+iY74Q/sInS7ruQdiE7/XpjVz
         v/cJGXdOLtkKeqz/KLOi19mJ59kH0okjnIXPlqPgepfsif4a3SP5hS5fCU4cv/nMiMXF
         8MR4co23JzgfUyfnirEqeCMTAl7ZRu0ylqWFTrmdC883alloiP+uLnj0EbfAqzm2xRLR
         C3ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5imsyI0b83eRRG7XSm8dcgFIEu+jMWu3oUZKB77rnAk=;
        b=PKJ4S+gnnRKqM/mRebfKhkdPGXNX7mGoP2101GagbsJN+/2jwLvkWV+1LMAiJVnKY6
         GvI73LZCSYLMmwJVBM3fCqSlLSOFSF0aAUimhghpnFeDyNbX5RxZLWHIlTy67uRw3MfI
         o32VW90TPJ+aROgVi4NahL2wqmELHU+fY0g1aEG/Jm+0xSU2vO8P5DXummCA7HSkK8U2
         +7Wabzlrr+8bGSXQ1y4vzSLkFB0XE3pfI5MN/LDLtHExKSOe4bzczEKVkIsEoeZesCMI
         ahcstg6FAtrK97PHx9SgmR1IXwRnsjUFhcWnT/xb8XJ7RNXPoAkw0Z0luGSkNipD66uC
         /9Gw==
X-Gm-Message-State: AOAM5305N3K5/eQDPnvnH7eYFCN1bmtYsw9SjMZepRBPtVqaL9SFbFrf
        m+Gh83GksXusoFHcUWRBom9QUD21c97APvVeO14=
X-Google-Smtp-Source: ABdhPJzqBo3BZIqb32YXAiqn3A8kkfWg8836sSqMY+6pdpkL6vCTqGuwP9woNyZ1/BoQn9KjnpJ6CuDknJMY7tR/H4U=
X-Received: by 2002:a2e:4e09:: with SMTP id c9mr5869546ljb.283.1598389568661;
 Tue, 25 Aug 2020 14:06:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200825182919.1118197-1-kpsingh@chromium.org>
In-Reply-To: <20200825182919.1118197-1-kpsingh@chromium.org>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 25 Aug 2020 14:05:57 -0700
Message-ID: <CAADnVQJG+vMTyuNGjWTYnWX11ZqJU-EE30UC5KPJtpv1MC78cw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v10 0/7] Generalizing bpf_local_storage
To:     KP Singh <kpsingh@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Aug 25, 2020 at 11:29 AM KP Singh <kpsingh@chromium.org> wrote:
>
> From: KP Singh <kpsingh@google.com>
>
> # v9 -> v10
>
> - Added NULL check for inode_storage_ptr before calling
>   bpf_local_storage_update
> - Removed an extraneous include
> - Rebased and added Acks / Signoff.

Hmm. Though it looks good I cannot apply it, because
test_progs -t map_ptr
is broken:
2225: (18) r2 = 0xffffc900004e5004
2227: (b4) w1 = 58
2228: (63) *(u32 *)(r2 +0) = r1
 R0=map_value(id=0,off=0,ks=4,vs=4,imm=0) R1_w=inv58
R2_w=map_value(id=0,off=4,ks=4,vs=8,imm=0) R3=inv49 R4=inv63
R5=inv(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff)) R6_w=inv0
R7=invP8 R8=map_ptr(id=0,off=0,ks=4,vs=4,imm=0) R10=?
; VERIFY_TYPE(BPF_MAP_TYPE_SK_STORAGE, check_sk_storage);
2229: (18) r1 = 0xffffc900004e5000
2231: (b4) w3 = 24
2232: (63) *(u32 *)(r1 +0) = r3
 R0=map_value(id=0,off=0,ks=4,vs=4,imm=0)
R1_w=map_value(id=0,off=0,ks=4,vs=8,imm=0)
R2_w=map_value(id=0,off=4,ks=4,vs=8,imm=0) R3_w=inv24 R4=inv63
R5=inv(id=0,umax_value=4294967295,var_off=(0x0; 0xffffffff)) R6_w=inv0
R7=invP8 R8=map_pt?
2233: (18) r3 = 0xffff8881f03f7000
; VERIFY(indirect->map_type == direct->map_type);
2235: (85) call unknown#195896080
invalid func unknown#195896080
processed 4678 insns (limit 1000000) max_states_per_insn 9
total_states 240 peak_states 178 mark_read 11

libbpf: -- END LOG --
libbpf: failed to load program 'cgroup_skb/egress'
libbpf: failed to load object 'map_ptr_kern'
libbpf: failed to load BPF skeleton 'map_ptr_kern': -4007
test_map_ptr:FAIL:skel_open_load open_load failed
#43 map_ptr:FAIL

Above 'invalid func unknown#195896080' happens
when libbpf fails to do a relocation at runtime.
Please debug.
It's certainly caused by this set, but not sure why.
