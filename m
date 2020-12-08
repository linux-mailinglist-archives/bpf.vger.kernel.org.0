Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 106EA2D2853
	for <lists+bpf@lfdr.de>; Tue,  8 Dec 2020 11:00:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbgLHKA0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Dec 2020 05:00:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726334AbgLHKA0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Dec 2020 05:00:26 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98C88C0613D6
        for <bpf@vger.kernel.org>; Tue,  8 Dec 2020 01:59:45 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id c1so3652261wrq.6
        for <bpf@vger.kernel.org>; Tue, 08 Dec 2020 01:59:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QdGmwva9RtqTY7a7GN4dBmF3gJOdWFsFlLtWdXLRLeA=;
        b=XAuv5QEeW/kEMbA4SLlD2kgsjqPXZd+4y+wc51LFw4CWcP0Jaw8W8hAAjawk115SEL
         YxiSL7k1uZLUanxDFQtqNWDABvLkbAeJPJTGqyQ7vSXDjd7TTTJQSn28bbNJCtoI1eZr
         muvqOnohKVlZlK1iLAwUeRmW7I7Xq8FSVRfnAstDhJDVwBHW3I5DukXufOms+KY72s/1
         FcbvU+YYHE5Q2lDFWQZ7UMnCFtqqDQP16Tjx0x60U56vmHqzshWTsYY/9cnOL2zerwX4
         VrEN77a0Xvg/S1n4OiQF+1dycTK2i1LDxE14ec7Wd+8UIYm6E+ej+RUWBPL3r5SMS4ew
         xikg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QdGmwva9RtqTY7a7GN4dBmF3gJOdWFsFlLtWdXLRLeA=;
        b=ferHRSKj3/bUQw9TjMJznXV0slj9wK1YwMOkP/OdoP4zrjaxbioZm82j0uVIG8I+q3
         /Cim9xH1OaEcxtA9HZZ59giJBbPBBS708UIRVLzJJKuMSt04XtExZqY3eWqEeBr/YNkg
         9TnlIvRUvQx3+SJN3Sp3A90BMYP1zhqAtXkyh8ORI1gt46A9tbi4+lX/bqY4WGRuvHF1
         TJ63JUZraEdCcvJyK0v95EjzxWsTk7GCqs6ZAfUDQ3km4u9vs1lE9d9mwX0Q762hcTAV
         9a1iA9grWdrGZUUCqdqmrC4+uW3rw+h+zW6t6XLvBgsIW+tV8FR6RzU/h1bo6g1+KIRg
         TPJA==
X-Gm-Message-State: AOAM533iUMToDrOJTUIPTkODMGtWsPbhbQVFbMHGzk9O3usb8/pmoO1C
        SEvKwh+sTYiH6XnkxNzukwiehA==
X-Google-Smtp-Source: ABdhPJzNhC3+5htN47FqdOjCq68HPhKctDxzg2/ih+f0nt6Mx/wIUL47vy4c3z6WRSEVesrFgrFFEw==
X-Received: by 2002:adf:f6c8:: with SMTP id y8mr22962698wrp.59.1607421584172;
        Tue, 08 Dec 2020 01:59:44 -0800 (PST)
Received: from google.com (203.75.199.104.bc.googleusercontent.com. [104.199.75.203])
        by smtp.gmail.com with ESMTPSA id f7sm3816543wmc.1.2020.12.08.01.59.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 01:59:43 -0800 (PST)
Date:   Tue, 8 Dec 2020 09:59:39 +0000
From:   Brendan Jackman <jackmanb@google.com>
To:     John Fastabend <john.fastabend@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        linux-kernel@vger.kernel.org, Jann Horn <jannh@google.com>
Subject: Re: [PATCH bpf-next v4 06/11] bpf: Add BPF_FETCH field / create
 atomic_fetch_add instruction
Message-ID: <X89Oi7ndmwS+cLWx@google.com>
References: <20201207160734.2345502-1-jackmanb@google.com>
 <20201207160734.2345502-7-jackmanb@google.com>
 <5fcf0fbcc8aa8_9ab320853@john-XPS-13-9370.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5fcf0fbcc8aa8_9ab320853@john-XPS-13-9370.notmuch>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Dec 07, 2020 at 09:31:40PM -0800, John Fastabend wrote:
> Brendan Jackman wrote:
> > The BPF_FETCH field can be set in bpf_insn.imm, for BPF_ATOMIC
> > instructions, in order to have the previous value of the
> > atomically-modified memory location loaded into the src register
> > after an atomic op is carried out.
> > 
> > Suggested-by: Yonghong Song <yhs@fb.com>
> > Signed-off-by: Brendan Jackman <jackmanb@google.com>
> > ---
> 
> I like Yonghong suggestion 
> 
>  #define BPF_ATOMIC_FETCH_ADD(SIZE, DST, SRC, OFF)               \
>      BPF_ATOMIC(SIZE, DST, SRC, OFF, BPF_ADD | BPF_FETCH)
> 
> otherwise LGTM. One observation to consider below.
> 
> Acked-by: John Fastabend <john.fastabend@gmail.com>
> 
> >  arch/x86/net/bpf_jit_comp.c    |  4 ++++
> >  include/linux/filter.h         |  1 +
> >  include/uapi/linux/bpf.h       |  3 +++
> >  kernel/bpf/core.c              | 13 +++++++++++++
> >  kernel/bpf/disasm.c            |  7 +++++++
> >  kernel/bpf/verifier.c          | 33 ++++++++++++++++++++++++---------
> >  tools/include/linux/filter.h   | 11 +++++++++++
> >  tools/include/uapi/linux/bpf.h |  3 +++
> >  8 files changed, 66 insertions(+), 9 deletions(-)
> 
> [...]
> 
> > @@ -3652,8 +3656,20 @@ static int check_atomic(struct bpf_verifier_env *env, int insn_idx, struct bpf_i
> >  		return err;
> >  
> >  	/* check whether we can write into the same memory */
> > -	return check_mem_access(env, insn_idx, insn->dst_reg, insn->off,
> > -				BPF_SIZE(insn->code), BPF_WRITE, -1, true);
> > +	err = check_mem_access(env, insn_idx, insn->dst_reg, insn->off,
> > +			       BPF_SIZE(insn->code), BPF_WRITE, -1, true);
> > +	if (err)
> > +		return err;
> > +
> > +	if (!(insn->imm & BPF_FETCH))
> > +		return 0;
> > +
> > +	/* check and record load of old value into src reg  */
> > +	err = check_reg_arg(env, insn->src_reg, DST_OP);
> 
> This will mark the reg unknown. I think this is fine here. Might be nice
> to carry bounds through though if possible

Ah, I hadn't thought of this. I think if I move this check_reg_arg to be
before the first check_mem_access, and then (when BPF_FETCH) set the
val_regno arg to load_reg, then the bounds from memory would get
propagated back to the register:

if (insn->imm & BPF_FETCH) {
	if (insn->imm == BPF_CMPXCHG)
		load_reg = BPF_REG_0;
	else
		load_reg = insn->src_reg;
	err = check_reg_arg(env, load_reg, DST_OP);
	if (err)
		return err;
} else {
	load_reg = -1;
}
/* check wether we can read the memory */
err = check_mem_access(env, insn_index, insn->dst_reg, insn->off
		       BPF_SIZE(insn->code), BPF_READ,
		       load_reg, // <--
		       true);

Is that the kind of thing you had in mind?

> > +	if (err)
> > +		return err;
> > +
> > +	return 0;
> >  }
> >  
