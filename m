Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 122C92C2342
	for <lists+bpf@lfdr.de>; Tue, 24 Nov 2020 11:48:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731944AbgKXKsZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 24 Nov 2020 05:48:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731324AbgKXKsX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 24 Nov 2020 05:48:23 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B23ACC0613D6
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2020 02:48:23 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id l1so21786830wrb.9
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2020 02:48:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XtAxWCg06iEi3/lQ3UN/Z3vo2NEGDxfzJqcCBtU3QfU=;
        b=PoZrnjDXZDEXYkDe1DSO0wGf8xcdAEG370furVq35SBv4EJTsRgIz3ZeTpUdlzCCs4
         6/JBIntD689FNwIMpRLGTFnKtthPTkriLHhqQc69WI7+kHmjkl6FRGyU8P7EdA6IOWSc
         abNOtDoQYXRII7oM5kTuKJ8QkFhxyxy3bzIa0Dm2dfnNcIEbHpQHLZ2T8ck1vf5FnQ1/
         VdpxYhZ+4bATA9Wv9r6xvtdmXtGuyGT2177Tj/2Sie+EWzqog19kam881XokZrn854pp
         dOvAHJbPW87QmLi3l8+sp2mszfMR35VKK9sRMGRbwO3ls0Yt/t+QgjGeJFTHCv4EOH+N
         GvSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XtAxWCg06iEi3/lQ3UN/Z3vo2NEGDxfzJqcCBtU3QfU=;
        b=Her2SZHVc+8EMfoQ+FwwxqH0Q6BEZYQwcpsC0JLBaeBWBWtJAV2tMjZ+YTycqEb+LN
         dwzU3qgZ/ANqnaKjNtpi8Ghe+NtvxrAzksuxiyVUbBui/Nt2HMrsM96iZRjoZGABpKtt
         btGaWH4QXvcHiG5CcYcw+4dqeRPUwfwkcqWcTUQJ1fDsSnLOus2E42cws2HBRTH8ka1g
         +sYTY+8PSidm0KIG/n3XccgVdoJYEv4IBC3nUbIHCO7cmqWmldcSLBFdWaTa5iUu2LYw
         AQsGY1Ts14Q2Ryj54Qvyru2QJVgtiaLqifnfnkHWZQ1HWAQbXNnLERthQnF5uRqjUL7F
         HKZw==
X-Gm-Message-State: AOAM532yE2VDj9ccPP+og3gquXN5vkrs7/sfGbNo00GLOuWIsYxJtbTw
        nIFCtRZBHPX5txZj5HLJHVlV7Q==
X-Google-Smtp-Source: ABdhPJzlsE2OB9Zg8PLD87DPf+xGPrM+L5hqkitH/QjhmonOluSfac94K/lFlXL0PdA12h2oonupTw==
X-Received: by 2002:adf:f906:: with SMTP id b6mr4627503wrr.244.1606214902257;
        Tue, 24 Nov 2020 02:48:22 -0800 (PST)
Received: from google.com (203.75.199.104.bc.googleusercontent.com. [104.199.75.203])
        by smtp.gmail.com with ESMTPSA id i11sm25578502wro.85.2020.11.24.02.48.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 02:48:21 -0800 (PST)
Date:   Tue, 24 Nov 2020 10:48:17 +0000
From:   Brendan Jackman <jackmanb@google.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>
Subject: Re: [PATCH 5/7] bpf: Add BPF_FETCH field / create atomic_fetch_add
 instruction
Message-ID: <20201124104817.GA1883487@google.com>
References: <20201123173202.1335708-1-jackmanb@google.com>
 <20201123173202.1335708-6-jackmanb@google.com>
 <20201124065257.456bpoy4r5pf67xz@ast-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201124065257.456bpoy4r5pf67xz@ast-mbp>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Nov 23, 2020 at 10:52:57PM -0800, Alexei Starovoitov wrote:
> On Mon, Nov 23, 2020 at 05:32:00PM +0000, Brendan Jackman wrote:
> > @@ -3644,8 +3649,21 @@ static int check_atomic(struct bpf_verifier_env *env, int insn_idx, struct bpf_i
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
> > +	if (err)
> > +		return err;
> > +	regs[insn->src_reg].type = SCALAR_VALUE;
> 
> check_reg_arg() will call mark_reg_unknown() which will set type to SCALAR_VALUE.
> What is the point of another assignment?

Yep, this is just an oversight - thanks, will remove.
