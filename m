Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F3882D3B03
	for <lists+bpf@lfdr.de>; Wed,  9 Dec 2020 06:41:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727732AbgLIFky (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Dec 2020 00:40:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727645AbgLIFkx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Dec 2020 00:40:53 -0500
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ECFCC0613CF;
        Tue,  8 Dec 2020 21:40:13 -0800 (PST)
Received: by mail-ot1-x344.google.com with SMTP id a109so276156otc.1;
        Tue, 08 Dec 2020 21:40:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=z6JGKBHPAN6pNta50XqRFUPJ38/LJ/rWm+SV+OmNwnY=;
        b=MneNY57C8ATW72aGVSjho5XUG1L7xqirqc1sTdP4RN33aq8KWb9nkxKhf0FEFIvRJi
         OpJeMOhRRO2EFN6JgK1S4Oguxg7hJOLTTGm1uM43lVwjbla1/1XDqkQcjvtH18KTe7aM
         4eDScKlxkhMVDylgFgyixbFXIIbKDePXe4y2cPnDVkt92EwOAv91dafSLMMcx8gvK1va
         w3Kz6fP+azVEkGiTZgWbW23ubg0SyuwWN8SnAFGXNAFOKKh7/cgyTTwHzJtJuFux0OJV
         FtNwBQudiCreJJbu8Gct62938yETQkvqeFzpn4zpuceE2kmCJJnl8yD+nbJmirsZ01zM
         3m9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=z6JGKBHPAN6pNta50XqRFUPJ38/LJ/rWm+SV+OmNwnY=;
        b=M1LEveM1PCZ0Yfj//ur3kHeUiTpc8Uq3bccBXf7r/8yGOyXcyjVPf707Pby6pVi2uw
         5lPf4FfSAvvebrKcXnlt7uS2P1cZboVg82s+ojTzwBqYtoL9cLnHEQ0nIegv8qHQ3yK5
         7ckH0widgOF8yeKp9PSP+audqCANqPTUYB5fnFMCf+BBD8S4BBTQ3OuZ5bspohEVAihU
         +SQ2aE9UUPfUSoya1MLKD+TBV3aG9JqP/R8vthxuGXdLVNWxWU/0GkPsffZVsd3hJPuq
         /43LV+uCGHh4WLHmPv8zEJ99/G/A4WzgJj28P856me5MlPKmvTQ0sQd1NfVWkTRlU79f
         UQmQ==
X-Gm-Message-State: AOAM5338wkJbXQLHTgOc8K8ZX3f2iRhI0Gq7pA3S4bYTeTFXqAZ6qTtU
        TW8obDz5QOM+07sWmHhbh+Y=
X-Google-Smtp-Source: ABdhPJw4kCLKL2ZxUNf4vAOiVmBNAxbmCI1Uz9FvDsRVqKDNgWG2zd6jEqP7lqWFPOXE/J51mCvbpw==
X-Received: by 2002:a05:6830:22eb:: with SMTP id t11mr487039otc.114.1607492413043;
        Tue, 08 Dec 2020 21:40:13 -0800 (PST)
Received: from localhost ([184.21.204.5])
        by smtp.gmail.com with ESMTPSA id z9sm174527otj.67.2020.12.08.21.40.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 21:40:12 -0800 (PST)
Date:   Tue, 08 Dec 2020 21:40:03 -0800
From:   John Fastabend <john.fastabend@gmail.com>
To:     Brendan Jackman <jackmanb@google.com>,
        John Fastabend <john.fastabend@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        linux-kernel@vger.kernel.org, Jann Horn <jannh@google.com>
Message-ID: <5fd06333d11ff_50ce2082d@john-XPS-13-9370.notmuch>
In-Reply-To: <X89G2kItO2o60+A6@google.com>
References: <20201207160734.2345502-1-jackmanb@google.com>
 <20201207160734.2345502-5-jackmanb@google.com>
 <5fcea525c4971_5a96208bd@john-XPS-13-9370.notmuch>
 <X89G2kItO2o60+A6@google.com>
Subject: Re: [PATCH bpf-next v4 04/11] bpf: Rename BPF_XADD and prepare to
 encode other atomics in .imm
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Brendan Jackman wrote:
> Hi John, thanks a lot for the reviews!
> 
> On Mon, Dec 07, 2020 at 01:56:53PM -0800, John Fastabend wrote:
> > Brendan Jackman wrote:
> > > A subsequent patch will add additional atomic operations. These new
> > > operations will use the same opcode field as the existing XADD, with
> > > the immediate discriminating different operations.
> > > 
> > > In preparation, rename the instruction mode BPF_ATOMIC and start
> > > calling the zero immediate BPF_ADD.
> > > 
> > > This is possible (doesn't break existing valid BPF progs) because the
> > > immediate field is currently reserved MBZ and BPF_ADD is zero.
> > > 
> > > All uses are removed from the tree but the BPF_XADD definition is
> > > kept around to avoid breaking builds for people including kernel
> > > headers.
> > > 
> > > Signed-off-by: Brendan Jackman <jackmanb@google.com>
> > > ---

[...]

> > > +	case BPF_STX | BPF_ATOMIC | BPF_W:
> > > +	case BPF_STX | BPF_ATOMIC | BPF_DW:
> > > +		if (insn->imm != BPF_ADD) {
> > > +			pr_err("bpf-jit: not supported: atomic operation %02x ***\n",
> > > +			       insn->imm);
> > > +			return -EINVAL;
> > > +		}
> > 
> > Can we standardize the error across jits and the error return code? It seems
> > odd that we use pr_err, pr_info_once, pr_err_ratelimited and then return
> > ENOTSUPP, EFAULT or EINVAL.
> 
> That would be a noble cause but I don't think it makes sense in this
> patchset: they are already inconsistent, so here I've gone for intra-JIT
> consistency over inter-JIT consistency.
> 
> I think it would be more annoying, for example, if the s390 JIT returned
> -EOPNOTSUPP for a bad atomic but -1 for other unsupported ops, than it
> is already that the s390 JIT returns -1 where the MIPS returns -EINVAL.

ok works for me thanks for the explanation.
