Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C1262CA2AD
	for <lists+bpf@lfdr.de>; Tue,  1 Dec 2020 13:31:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728226AbgLAM2S (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 1 Dec 2020 07:28:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726343AbgLAM2R (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 1 Dec 2020 07:28:17 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FE21C0613CF
        for <bpf@vger.kernel.org>; Tue,  1 Dec 2020 04:27:37 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id t4so2315388wrr.12
        for <bpf@vger.kernel.org>; Tue, 01 Dec 2020 04:27:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mTIT9saW4JZE48elAbVCzCLGem+oE0gSHJTG1Irc+L8=;
        b=d6ntMLNLl1d9+VneIchH4PzLGhiXxI2qo0NKQWfgCD6PsNmCSq3GMuFVPqxCHsA8wS
         efiON3u3aoR+FWg1GjPGYT4hKV3wXygKXORxEMN4BWVD06yUzR8JMXGfi/9Zxa9334Oc
         EQEoN9dww0K8+LHSvSIew3YqbOaINFNG4FT6p5UCsrrIw9LnKOXUp+OEmElM3LYfX90D
         8BjCK5dHpG3ROdJw0VaaUWT9mRi1KgyAIf0MVXoyQVY3c2Q8oZBrj5xd5y/TZE13oQNz
         KzLkJNKxws4V1BvlCZp7gayrcm0oKBnFCRjngZ37lP9LUgS7WWDCzn/xz2eJYWhAtkh0
         w9Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mTIT9saW4JZE48elAbVCzCLGem+oE0gSHJTG1Irc+L8=;
        b=iDKbv4/57x5810Tkk/hZwKaslQi/XfBOLxl4HCs+zdzBdYKvItkRNpuK7xzd2+4Ehl
         0HR+D4flY1dE3j6jtaJ32HZwEjtj1vpKyPJPlxCsxH/K+FhDa8eLZeI/QbfctreGWh5q
         NiB8oyM7A5yeCTfiGT+VG9t5FKREYLPLeLOwi0gIum3TRcz+ejc+J/gn2rVipVehCTH3
         OvwF1A839mWq1huuXsnaOYO0Tshj3DO4JrFGDwTSUyiye919NV5sHjTx7lyUOUtIYsuC
         BTGVlAs42xbehwMK2RHrLs977itVJSiVqsujZ+R4+YR9MMK+2/PGGraKriHOirgH+Fic
         nWWA==
X-Gm-Message-State: AOAM531F2NP0lzCSg5GOrGd/dJ4sBN1um5BZ5+4QLCxV9bVU/Ere1E95
        uMFXJh+/X+2+PYpiAJ8DmsaeU9k9/9Cayw==
X-Google-Smtp-Source: ABdhPJzGQ1DkDeqZG4y0QvJTbZlxvyDUO7Iu+8yS+OD2Se1Oro2ko85UUgC9VgwUXnkvhnJB/H4r4w==
X-Received: by 2002:adf:e44d:: with SMTP id t13mr3602310wrm.144.1606825655734;
        Tue, 01 Dec 2020 04:27:35 -0800 (PST)
Received: from google.com (203.75.199.104.bc.googleusercontent.com. [104.199.75.203])
        by smtp.gmail.com with ESMTPSA id 2sm3712858wrq.87.2020.12.01.04.27.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 04:27:34 -0800 (PST)
Date:   Tue, 1 Dec 2020 12:27:31 +0000
From:   Brendan Jackman <jackmanb@google.com>
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        linux-kernel@vger.kernel.org, Jann Horn <jannh@google.com>
Subject: Re: [PATCH v2 bpf-next 08/13] bpf: Add instructions for
 atomic_[cmp]xchg
Message-ID: <20201201122731.GE2114905@google.com>
References: <20201127175738.1085417-1-jackmanb@google.com>
 <20201127175738.1085417-9-jackmanb@google.com>
 <c6d1763a-9674-9af3-51c5-c1467332c22b@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c6d1763a-9674-9af3-51c5-c1467332c22b@fb.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Nov 27, 2020 at 09:25:53PM -0800, Yonghong Song wrote:
> 
> 
> On 11/27/20 9:57 AM, Brendan Jackman wrote:
> > This adds two atomic opcodes, both of which include the BPF_FETCH
> > flag. XCHG without the BPF_FETCh flag would naturally encode
> 
> BPF_FETCH

Ack, thanks

> > atomic_set. This is not supported because it would be of limited
> > value to userspace (it doesn't imply any barriers). CMPXCHG without
> > BPF_FETCH woulud be an atomic compare-and-write. We don't have such
> > an operation in the kernel so it isn't provided to BPF either.
> > 
> > There are two significant design decisions made for the CMPXCHG
> > instruction:
> > 
> >   - To solve the issue that this operation fundamentally has 3
> >     operands, but we only have two register fields. Therefore the
> >     operand we compare against (the kernel's API calls it 'old') is
> >     hard-coded to be R0. x86 has similar design (and A64 doesn't
> >     have this problem).
> > 
> >     A potential alternative might be to encode the other operand's
> >     register number in the immediate field.
> > 
> >   - The kernel's atomic_cmpxchg returns the old value, while the C11
> >     userspace APIs return a boolean indicating the comparison
> >     result. Which should BPF do? A64 returns the old value. x86 returns
> >     the old value in the hard-coded register (and also sets a
> >     flag). That means return-old-value is easier to JIT.
> > 
> > Signed-off-by: Brendan Jackman <jackmanb@google.com>
> > ---
> >   arch/x86/net/bpf_jit_comp.c    |  8 ++++++++
> >   include/linux/filter.h         | 20 ++++++++++++++++++++
> >   include/uapi/linux/bpf.h       |  4 +++-
> >   kernel/bpf/core.c              | 20 ++++++++++++++++++++
> >   kernel/bpf/disasm.c            | 15 +++++++++++++++
> >   kernel/bpf/verifier.c          | 19 +++++++++++++++++--
> >   tools/include/linux/filter.h   | 20 ++++++++++++++++++++
> >   tools/include/uapi/linux/bpf.h |  4 +++-
> >   8 files changed, 106 insertions(+), 4 deletions(-)
> > 
> [...]
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index cd4c03b25573..c8311cc114ec 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -3601,10 +3601,13 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
> >   static int check_atomic(struct bpf_verifier_env *env, int insn_idx, struct bpf_insn *insn)
> >   {
> >   	int err;
> > +	int load_reg;
> >   	switch (insn->imm) {
> >   	case BPF_ADD:
> >   	case BPF_ADD | BPF_FETCH:
> > +	case BPF_XCHG:
> > +	case BPF_CMPXCHG:
> >   		break;
> >   	default:
> >   		verbose(env, "BPF_ATOMIC uses invalid atomic opcode %02x\n", insn->imm);
> > @@ -3626,6 +3629,13 @@ static int check_atomic(struct bpf_verifier_env *env, int insn_idx, struct bpf_i
> >   	if (err)
> >   		return err;
> > +	if (insn->imm == BPF_CMPXCHG) {
> > +		/* check src3 operand */
> 
> better comment about what src3 means here?

Ack,  adding "Check comparison of R0 with memory location"
