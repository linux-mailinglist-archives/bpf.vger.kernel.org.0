Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 005B3195990
	for <lists+bpf@lfdr.de>; Fri, 27 Mar 2020 16:06:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbgC0PGo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 27 Mar 2020 11:06:44 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52164 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727606AbgC0PGo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 27 Mar 2020 11:06:44 -0400
Received: by mail-wm1-f65.google.com with SMTP id c187so11779885wme.1
        for <bpf@vger.kernel.org>; Fri, 27 Mar 2020 08:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=pr0qD0iPXCEmGNYn73fmX69Dspd/3/go52tlDvpiG+I=;
        b=hO4sdxNxvULwr69BbYBiyiZhy52w5Rt88jCkrSsCrpHZlgE+artcZrY4Hh2ptIs6D3
         DzJNdRCbZuPdmL/2YArjpOMh6REjq0xJK0LdLZk9+aTlSheU3verxJCPPZvs7uBSn3+Q
         JIGInARCeIT1eNOGQmVGWgunmy6cxgGwcDp+4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=pr0qD0iPXCEmGNYn73fmX69Dspd/3/go52tlDvpiG+I=;
        b=KBHB4jqOLRSm4lnTDIGQpFCgJsYpeKT0qL8VNVBrvNCzCfc/N2K+s6S3QovNuWnF9a
         9hQ8TJUictSk4IOK/sTwK15QSypbwWHPaAcwisupTfVN0XwwX3cZBxZWxhK8tnG5S+mZ
         cwj0yZIwP+kSVDvyLyfCPeRYr/rdDkqPJckBcAPnDhMqeo1eEQd4suIxgG7FN9Wce7F5
         J79XzTraipYb/Z72Ho/t7cx9t5XPFnBBGxfKgmbnAit4tDgpnVLa/kkxfYJrhPE9sft0
         r7rW/h6eZNJbzfUtEi5/mPdPWPV636zNqrdUtBcBLqv2OMJ/VwiBzFI09tbsaRXK5tJE
         TgEw==
X-Gm-Message-State: ANhLgQ0Ba3flSYV1V0fsm6ukFivGZtQA3cr8xbOnbbeWVtN4KeN6Eodr
        atrykJkDoYzwSYZHuz968FJPxw==
X-Google-Smtp-Source: ADFU+vttbTEMoPK04x5Y+InaWRPyOJAislXquQ5dm7z8g2RLd7ecoYpHxc6ZBWjAUh9hORUzjzQMJw==
X-Received: by 2002:a1c:8108:: with SMTP id c8mr5764675wmd.50.1585321600541;
        Fri, 27 Mar 2020 08:06:40 -0700 (PDT)
Received: from chromium.org (77-56-209-237.dclient.hispeed.ch. [77.56.209.237])
        by smtp.gmail.com with ESMTPSA id m5sm8001072wmg.13.2020.03.27.08.06.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2020 08:06:39 -0700 (PDT)
From:   KP Singh <kpsingh@chromium.org>
X-Google-Original-From: KP Singh <kpsingh>
Date:   Fri, 27 Mar 2020 16:06:37 +0100
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Brendan Jackman <jackmanb@google.com>,
        Florent Revest <revest@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH bpf-next v7 4/8] bpf: lsm: Implement attach, detach and
 execution
Message-ID: <20200327150637.GA23032@chromium.org>
References: <20200326142823.26277-1-kpsingh@chromium.org>
 <20200326142823.26277-5-kpsingh@chromium.org>
 <20200327031256.vhk2luomxgex3ui4@ast-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200327031256.vhk2luomxgex3ui4@ast-mbp>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 26-Mär 20:12, Alexei Starovoitov wrote:
> On Thu, Mar 26, 2020 at 03:28:19PM +0100, KP Singh wrote:
> >  
> >  	if (arg == nr_args) {
> > -		if (prog->expected_attach_type == BPF_TRACE_FEXIT) {
> > +		/* BPF_LSM_MAC programs only have int and void functions they
> > +		 * can be attached to. When they are attached to a void function
> > +		 * they result in the creation of an FEXIT trampoline and when
> > +		 * to a function that returns an int, a MODIFY_RETURN
> > +		 * trampoline.
> > +		 */
> > +		if (prog->expected_attach_type == BPF_TRACE_FEXIT ||
> > +		    prog->expected_attach_type == BPF_LSM_MAC) {
> >  			if (!t)
> >  				return true;
> >  			t = btf_type_by_id(btf, t->type);
> 
> Could you add a comment here that though BPF_MODIFY_RETURN-like check
> if (ret_type != 'int') return -EINVAL;
> is _not_ done here. It is still safe, since LSM hooks have only
> void and int return types.

Good idea, I reworded the comment to make this explicit and moved
the comment to inside the if condition.

> 
> > +	case BPF_LSM_MAC:
> > +		if (!prog->aux->attach_func_proto->type)
> > +			/* The function returns void, we cannot modify its
> > +			 * return value.
> > +			 */
> > +			return BPF_TRAMP_FEXIT;
> > +		else
> > +			return BPF_TRAMP_MODIFY_RETURN;
> 
> I was thinking whether it would help performance significantly enough
> if we add a flavor of BPF_TRAMP_FEXIT that doesn't have
> BPF_TRAMP_F_CALL_ORIG.

Agreed.

> That will save the cost of nop call, but I guess indirect call due
> to lsm infra is slow enough, so this extra few cycles won't be noticeable.
> So I'm fine with it as-is. When lsm hooks will get rid of indirect call
> we can optimize it further.

Also agreed, that's the next step. :)

- KP
