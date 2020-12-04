Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBFF72CEA8E
	for <lists+bpf@lfdr.de>; Fri,  4 Dec 2020 10:14:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729402AbgLDJNI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Dec 2020 04:13:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729016AbgLDJNI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Dec 2020 04:13:08 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A03E1C061A4F
        for <bpf@vger.kernel.org>; Fri,  4 Dec 2020 01:12:27 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id g25so4279801wmh.1
        for <bpf@vger.kernel.org>; Fri, 04 Dec 2020 01:12:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eNAFE5FFZLVMVx+wNPWHMKqe4nzg/D8xhT8Y1YuEp58=;
        b=Z8IOTdNL1PetowVVhqP9tqzPsG82zq5+21jCJZJyRqLlr61D9NDqTn+3Y3tI08Z3TI
         d7komxL2naNFa311/KXWMgrUHbZnTwEqfPEVbU/aimgNTIQ/EJTENVcxcON+8qFXoob6
         oOgk7hbn6/RVXVuCMyLDB4Rm2Nl0J2PQC1Pqum5rH4bEbrks4Uot7kEumRDO5kHIPh2M
         1bPzO3wiB8bTasNbknHNCaBmQtvcKkqVenZf129dkfmlGrzdKMS9OfEsarA6pIB2RegM
         hlckqCa3wph4qC785nzUUGLQ0bBdSYmrY2dOFFcw4t5QJ92/wDdWpYxVHefzQ5FhNxgI
         Tplw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eNAFE5FFZLVMVx+wNPWHMKqe4nzg/D8xhT8Y1YuEp58=;
        b=YV3YCdDlGDb/ARcTtwZWl5WaNHGeqmaTCUKVBqhRxEhn4AIZlN2H8ysNjKhJnlnEVD
         YNslhhMovBHJXqwmB87vCr5Cu0dgcfmk9Qho6QgZntjknJK63HdZlZZqyCPVjEHQLoi/
         RlwId7gO0GESoWJXAtIvCW0bo47B3VPEu6NDpk5na/EhAbqSJ+96J17lbM3zVvJjRYBh
         k+1k720/ZqW77PF9lp2CSP3J4f/4eTGeeeI3yiEhxoPQ4rcN+Vi+MJ1+N+Ry9FSQ6KGh
         74ASHu24kpHPFyBUwdKdZdyv46M4qp0mANT57NGiO8gWdMay+ifeJV/Lfca3OoG5O8TD
         mUAQ==
X-Gm-Message-State: AOAM530LjAAPXAuYhXhc1JDN/Q9pU8A4UmhzrEx66SyNPHbRfqTZxtWU
        JwjOr4NbyrttVi1d9sf3OkxnmQ==
X-Google-Smtp-Source: ABdhPJw0Bbl2LBmo8p+ukCndt6zY9A1gN7FUMKBdglF8M9s94u0L30lrFt53WuTBNFj2dzXVuybDGQ==
X-Received: by 2002:a7b:c04c:: with SMTP id u12mr3159612wmc.49.1607073146243;
        Fri, 04 Dec 2020 01:12:26 -0800 (PST)
Received: from google.com (203.75.199.104.bc.googleusercontent.com. [104.199.75.203])
        by smtp.gmail.com with ESMTPSA id v64sm2420265wme.25.2020.12.04.01.12.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 01:12:25 -0800 (PST)
Date:   Fri, 4 Dec 2020 09:12:21 +0000
From:   Brendan Jackman <jackmanb@google.com>
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        linux-kernel@vger.kernel.org, Jann Horn <jannh@google.com>
Subject: Re: [PATCH bpf-next v3 07/14] bpf: Add BPF_FETCH field / create
 atomic_fetch_add instruction
Message-ID: <X8n9dTz8oofFVWzM@google.com>
References: <20201203160245.1014867-1-jackmanb@google.com>
 <20201203160245.1014867-8-jackmanb@google.com>
 <45b3d69d-7356-2c28-e507-897889be564c@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45b3d69d-7356-2c28-e507-897889be564c@fb.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Dec 03, 2020 at 09:27:04PM -0800, Yonghong Song wrote:
> On 12/3/20 8:02 AM, Brendan Jackman wrote:
[...]
> > diff --git a/kernel/bpf/disasm.c b/kernel/bpf/disasm.c
> > index 37c8d6e9b4cc..3ee2246a52ef 100644
> > --- a/kernel/bpf/disasm.c
> > +++ b/kernel/bpf/disasm.c
> > @@ -160,6 +160,13 @@ void print_bpf_insn(const struct bpf_insn_cbs *cbs,
> >   				bpf_ldst_string[BPF_SIZE(insn->code) >> 3],
> >   				insn->dst_reg, insn->off,
> >   				insn->src_reg);
> > +		} else if (BPF_MODE(insn->code) == BPF_ATOMIC &&
> > +			   insn->imm == (BPF_ADD | BPF_FETCH)) {
> > +			verbose(cbs->private_data, "(%02x) r%d = atomic%s_fetch_add(*(%s *)(r%d %+d), r%d)\n",
> 
> We should not do dereference here (withough first *), right? since the input
> is actually an address. something like below?
>    r2 = atomic[64]_fetch_add((u64/u32 *)(r3 +40), r2)

Ah yep  - thanks!

[...]
> > diff --git a/tools/include/linux/filter.h b/tools/include/linux/filter.h
> > index 95ff51d97f25..ac7701678e1a 100644
> > --- a/tools/include/linux/filter.h
> > +++ b/tools/include/linux/filter.h
> > @@ -180,6 +180,16 @@
> >   		.imm   = BPF_ADD })
> >   #define BPF_STX_XADD BPF_ATOMIC_ADD /* alias */
> > +/* Atomic memory add with fetch, src_reg = atomic_fetch_add(*(dst_reg + off), src_reg); */
> 
> Maybe src_reg = atomic_fetch_add(dst_reg + off, src_reg)?

Yep - and the same for the bitwise ops in the later patch.

