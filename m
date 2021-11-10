Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3FE244C03F
	for <lists+bpf@lfdr.de>; Wed, 10 Nov 2021 12:41:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231316AbhKJLoJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 10 Nov 2021 06:44:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230440AbhKJLoJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 10 Nov 2021 06:44:09 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2DCCC061764
        for <bpf@vger.kernel.org>; Wed, 10 Nov 2021 03:41:21 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id 13so4661630ljj.11
        for <bpf@vger.kernel.org>; Wed, 10 Nov 2021 03:41:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=csmTgtaZMnyvU7jhPmCPCXw06UF8KdqBzZmK1KMCI6o=;
        b=QhmY5KuYe0XdpWl7mKeMIy/WVvxYHv/BXvIrQukvJNN+zYtG7FaI9dc6ohVUtjEqyX
         XoSQB1OuxL8X/onouOs9GEENzOYrok3YqfvL/NZ/uf8imt/TO+A7OQoDt7tEIljikIgc
         6pXdy1pwSlazlj3uAQ4yk7ZrbqknDC6UK9Hsw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=csmTgtaZMnyvU7jhPmCPCXw06UF8KdqBzZmK1KMCI6o=;
        b=KyE3pwULcSk9g0I1zTyByOdXY23Wa0gOHD5W/gq6u/7y3tTHJg8oqpMftbHRShxtNx
         1eT9tqtPRl1Tyt/HQBKiEbS08ez3sbjLBjqNVetXq4jV59TkEUfCrEPFlvrOtuCLa4+M
         DtCPSfRBp3LzcrBwIP3dzrMPCvGhHCERUkwidQG19RT1TagkL4perDZjLoDvflRP8sOd
         T1XLsF4CgoX0DUniDtWH2EC/2vgD1vtIyYrQI7wgHirIMBwJroLkLza0Rxl+34o0jZ1D
         85qR2Q6vEQ36KGQgIk4BVUzQknGia2nq0gpmuokv/hJL6LwuR97OsAqmugPgZMyQes4Z
         M5yg==
X-Gm-Message-State: AOAM5317oVX5Khu6VyQ2K8We1r0Zh3zQkNJAS0Kjq/Xgq0HpCGWmWlMv
        oV17T3HJ4Ld2UW7lJQqaQ8TA6nr82tkfysX0LjqJPg==
X-Google-Smtp-Source: ABdhPJwg3ODydwUYEKknDDnRtSuPDjfEhEAzaBDjNvT4+ZA3qibPjvBsZvquxzyGi6U0EeSCcvuLWnZdwf8Dxs4QE68=
X-Received: by 2002:a2e:9c02:: with SMTP id s2mr15129322lji.121.1636544480017;
 Wed, 10 Nov 2021 03:41:20 -0800 (PST)
MIME-Version: 1.0
References: <CACAyw99hVEJFoiBH_ZGyy=+oO-jyydoz6v1DeKPKs2HVsUH28w@mail.gmail.com>
 <CAADnVQKsK_2HHfOLs4XK7h_LC4+b7tfFw9261Psy5St8P+GWFA@mail.gmail.com>
 <CACAyw9_GmNotSyG0g1OOt648y9kx5Bd72f58TtS-QQD9FaV06w@mail.gmail.com>
 <20211105194952.xve6u6lgh2oy46dy@ast-mbp.dhcp.thefacebook.com>
 <CACAyw99KGdTAz+G3aU8G3eqC926YYpgD57q-A+NFNVqqiJPY3g@mail.gmail.com> <20211110042530.6ye65mpspre7au5f@ast-mbp.dhcp.thefacebook.com>
In-Reply-To: <20211110042530.6ye65mpspre7au5f@ast-mbp.dhcp.thefacebook.com>
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Wed, 10 Nov 2021 11:41:09 +0000
Message-ID: <CACAyw9-s0ahY8m7WtMd1OK=ZF9w5gS9gktQ6S8Kak2pznXgw0w@mail.gmail.com>
Subject: Re: Verifier rejects previously accepted program
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        kernel-team <kernel-team@cloudflare.com>,
        bpf <bpf@vger.kernel.org>, regressions@lists.linux.dev,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 10 Nov 2021 at 04:25, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> but it goes into R2 from non-inner map which ruins all my theories.

The trace does contain modifications from inner maps, but they aren't
at the start of the block at 1077. Your suggested hack makes this
clear:

1033: R0=map_value(id=0,off=0,ks=4,vs=36,uid=6900,imm=0) R1_w=invP0
R3_w=map_value(id=0,off=0,ks=4,vs=36,uid=6900,imm=0)
R6=ctx(id=0,off=0,imm=0) R7=inv(id=0) R8=pkt(id=0,off=18,r=38,imm=0)
R9=inv0 R10=fp0 fp-24=mmmmmmmm fp-32=mmmmmmmm fp-40=mmmm00m0
fp-48=mmmm0000 fp-56=00000000 fp-64=00000000 fp-72=0000mmmm
fp-80=mmmmmmmm fp-88=map_value fp-96=pkt_end fp-104=map_value
fp-112=pkt fp-120=fp fp-128=map_value
1033: (16) if w1 == 0x0 goto pc+43
1077: R0=map_value(id=0,off=0,ks=4,vs=36,uid=6900,imm=0) R1_w=invP0
R3_w=map_value(id=0,off=0,ks=4,vs=36,uid=6900,imm=0)
R6=ctx(id=0,off=0,imm=0) R7=inv(id=0) R8=pkt(id=0,off=18,r=38,imm=0)
R9=inv0 R10=fp0 fp-24=mmmmmmmm fp-32=mmmmmmmm fp-40=mmmm00m0
fp-48=mmmm0000 fp-56=00000000 fp-64=00000000 fp-72=0000mmmm
fp-80=mmmmmmmm fp-88=map_value fp-96=pkt_end fp-104=map_value
fp-112=pkt fp-120=fp fp-128=map_value
1077: (79) r2 = *(u64 *)(r10 -128)
1078: R0=map_value(id=0,off=0,ks=4,vs=36,uid=6900,imm=0) R1_w=invP0
R2_w=map_value(id=0,off=0,ks=4,vs=32,uid=0,imm=0)
R3_w=map_value(id=0,off=0,ks=4,vs=36,uid=6900,imm=0)
R6=ctx(id=0,off=0,imm=0) R7=inv(id=0) R8=pkt(id=0,off=18,r=38,imm=0)
R9=inv0 R10=fp0 fp-24=mmmmmmmm fp-32=mmmmmmmm fp-40=mmmm00m0
fp-48=mmmm0000 fp-56=00000000 fp-64=00000000 fp-72=0000mmmm
fp-80=mmmmmmmm fp-88=map_value fp-96=pkt_end fp-104=map_value
fp-112=pkt fp-120=fp fp-128=map_value

r2 is the per-CPU array. r0, r3 are from an inner map. There are
accesses to r3 a couple instructions later:

1081: R0=map_value(id=0,off=0,ks=4,vs=36,uid=6900,imm=0)
R1_w=inv(id=0) R2_w=map_value(id=0,off=0,ks=4,vs=32,uid=0,imm=0)
R3_w=map_value(id=0,off=0,ks=4,vs=36,uid=6900,imm=0)
R6=ctx(id=0,off=0,imm=0) R7=inv(id=0) R8=pkt(id=0,off=18,r=38,imm=0)
R9=inv0 R10=fp0 fp-24=mmmmmmmm fp-32=mmmmmmmm fp-40=mmmm00m0
fp-48=mmmm0000 fp-56=00000000 fp-64=00000000 fp-72=0000mmmm
fp-80=mmmmmmmm fp-88=map_value fp-96=pkt_end fp-104=map_value
fp-112=pkt fp-120=fp fp-128=map_value
1081: (71) r1 = *(u8 *)(r3 +32)
 R0=map_value(id=0,off=0,ks=4,vs=36,uid=6900,imm=0) R1_w=inv(id=0)
R2_w=map_value(id=0,off=0,ks=4,vs=32,uid=0,imm=0)
R3_w=map_value(id=0,off=0,ks=4,vs=36,uid=6900,imm=0)
R6=ctx(id=0,off=0,imm=0) R7=inv(id=0) R8=pkt(id=0,off=18,r=38,imm=0)
R9=inv0 R10=fp0 fp-24=mmmmmmmm fp-32=mmmmmmmm fp-40=mmmm00m0
fp-48=mmmm0000 fp-56=00000000 fp-64=00000000 fp-72=0000mmmm
fp-80=mmmmmmmm fp-88=map_value fp-96=pkt_end fp-104=map_value
fp-112=pkt fp-120=fp fp-128=map_value

> The verbose() part will help to confirm that R2 in the above should be uid=0.

Yes, uid=0, see above.

> After that please try only with:
> -               if (memcmp(rold, rcur, offsetof(struct bpf_reg_state, id)))
> +               if (memcmp(rold, rcur, offsetof(struct bpf_reg_state, map_uid)))
>
> It should resolve the regression, but will break timer safety check and makes
> the map_uid logic not quite right (though no existing test will show it).

This doesn't help.

>
> If offsetof(map_uid) doesn't help another guess would be:
> @@ -10496,7 +10497,7 @@ static bool regsafe(struct bpf_verifier_env *env, struct bpf_reg_state *rold,
>                  * it's valid for all map elements regardless of the key
>                  * used in bpf_map_lookup()
>                  */
> -               return memcmp(rold, rcur, offsetof(struct bpf_reg_state, id)) == 0 &&
> +               return memcmp(rold, rcur, offsetof(struct bpf_reg_state, map_uid)) == 0 &&
>                        range_within(rold, rcur) &&
>                        tnum_in(rold->var_off, rcur->var_off);
> that's for PTR_TO_MAP_VALUE and that would be a different theory which makes even less sense.

This change resolves the regression. The first five occurrences of
insn 1077 in the trace, with your logging applied:

1077: R0=map_value(id=0,off=0,ks=4,vs=36,uid=13,imm=0) R1=invP0
R3=map_value(id=0,off=0,ks=4,vs=36,uid=13,imm=0)
R6=ctx(id=0,off=0,imm=0) R7=inv(id=0) R8=pkt(id=0,off=18,r=38,imm=0)
R9=inv0 R10=fp0 fp-24=00000000 fp-32=0000mmmm fp-40=mmmm00m0
fp-48=mmmm0000 fp-56=00000000 fp-64=00000000 fp-72=0000mmmm
fp-80=mmmmmmmm fp-88=map_value fp-96=pkt_end fp-104=map_value
fp-112=pkt fp-120=fp fp-128=map_value
1077: R0=map_value(id=0,off=0,ks=4,vs=36,uid=6875,imm=0) R1_w=invP0
R3_w=map_value(id=0,off=0,ks=4,vs=36,uid=6875,imm=0)
R6=ctx(id=0,off=0,imm=0) R7=inv(id=0) R8=pkt(id=0,off=18,r=38,imm=0)
R9=inv0 R10=fp0 fp-24=00000000 fp-32=0000mmmm fp-40=mmmm00m0
fp-48=mmmm0000 fp-56=00000000 fp-64=00000000 fp-72=0000mmmm
fp-80=mmmmmmmm fp-88=map_value fp-96=pkt_end fp-104=map_value
fp-112=pkt fp-120=fp fp-128=map_value
1077: R0=map_value(id=0,off=0,ks=4,vs=36,uid=6900,imm=0) R1_w=invP0
R3_w=map_value(id=0,off=0,ks=4,vs=36,uid=6900,imm=0)
R6=ctx(id=0,off=0,imm=0) R7=inv(id=0) R8=pkt(id=0,off=18,r=38,imm=0)
R9=inv0 R10=fp0 fp-24=mmmmmmmm fp-32=mmmmmmmm fp-40=mmmm00m0
fp-48=mmmm0000 fp-56=00000000 fp-64=00000000 fp-72=0000mmmm
fp-80=mmmmmmmm fp-88=map_value fp-96=pkt_end fp-104=map_value
fp-112=pkt fp-120=fp fp-128=map_value
1077: R0=map_value(id=0,off=0,ks=4,vs=36,uid=6908,imm=0) R1_w=invP0
R3_w=map_value(id=0,off=0,ks=4,vs=36,uid=6908,imm=0)
R6=ctx(id=0,off=0,imm=0) R7=inv(id=0) R8=pkt(id=0,off=18,r=38,imm=0)
R9=inv0 R10=fp0 fp-24=mmmmmmmm fp-32=mmmmmmmm fp-40=mmmm00m0
fp-48=mmmm0000 fp-56=00000000 fp-64=00000000 fp-72=0000mmmm
fp-80=mmmmmmmm fp-88=map_value fp-96=pkt_end fp-104=map_value
fp-112=pkt fp-120=fp fp-128=map_value
1077: R0=map_value(id=0,off=0,ks=16,vs=36,uid=0,imm=0) R1=invP0
R2=map_value(id=0,off=0,ks=4,vs=368,uid=0,imm=0)
R3=map_value(id=0,off=0,ks=16,vs=36,uid=0,imm=0)
R6=ctx(id=0,off=0,imm=0)
R7=map_value(id=0,off=0,ks=4,vs=368,uid=0,imm=0)
R8=pkt(id=0,off=18,r=38,imm=0) R9=inv0 R10=fp0 fp-24=mmmmmmmm
fp-32=mmmmmmmm fp-40=mmmm00m0 fp-48=mmmm0000 fp-56=00000000
fp-64=00000000 fp-72=0000mmmm fp-80=mmmmmmmm fp-88=map_value
fp-96=pkt_end fp-104=map_value fp-112=pkt fp-120=fp fp-128=map_value

uid changes on every invocation, and therefore regsafe() returns false?

-- 
Lorenz Bauer  |  Systems Engineer
6th Floor, County Hall/The Riverside Building, SE1 7PB, UK

www.cloudflare.com
