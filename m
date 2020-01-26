Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E0DE149D5D
	for <lists+bpf@lfdr.de>; Sun, 26 Jan 2020 23:25:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbgAZWZa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 26 Jan 2020 17:25:30 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40668 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbgAZWZa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 26 Jan 2020 17:25:30 -0500
Received: by mail-pl1-f195.google.com with SMTP id p12so2624808plr.7
        for <bpf@vger.kernel.org>; Sun, 26 Jan 2020 14:25:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=aWWKxgIAe9v5bTrGOOVTnDrjVPCvstvKxHu2k/pA2+c=;
        b=pnvFcYNVKpHQedCay7H+M2c8YtBne+Tq9sy4KfOd4WcGuPUPQelsEZEr/RcWykT1N5
         0E6I08a9owK0SrM7dCXLDp/0RKeif1m1tncOLH3okZkf1/MCo31VxMjU2bSP/8UI3V4K
         /gnARqgk/9b9mHmine1ud9W0rr53qCDYcw8nNIOc9c9WSfeZmUpQ4Jh1A58o3+ST5RVU
         kUh2dVvLIZqQZtqZZDS78R11FZ8W3gHe4+ftdXaMzISCrAVAWz8swpB+5gdQdqI4QgF0
         FfVY9y1QMEnkwO8g/S/PYM1DI5sYtdhLVpCEJ35cin06URG/1gxEEzAvIGcFT+FfAoI5
         /vfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=aWWKxgIAe9v5bTrGOOVTnDrjVPCvstvKxHu2k/pA2+c=;
        b=anYz4CKjuGfrV6aPuC2OFsg/DrL/y2BoNjY//fhVHomfHXpwOHBjvJlyF6cCGWGXke
         h4eReUPMf9nIGGES9PNV3bxHmN4Kz9Tpup4FHo82xye3c+t5ZrhAJaoMEN7IZB7cUtRw
         lHn4JMZtE44Y7ZV6DwDz92uQsqenFNXx2zlBIQ7JD+2aI4I0MAX7sVLOl54oykc/W4Di
         e6qMlGGV0gPsSRtwXFXRT28H9MRLtOelrM6FT6jVs0e+CuSrX83gBCR0vWny7j8bY7oD
         CS/NSd9vC4cfL1mhhjaHOZQAezqzMCdwiYUoX9vBm+bKwtTviFsiWAa2oUBoj1yR9jNN
         AMrw==
X-Gm-Message-State: APjAAAVdFQ06hL8e/QFqLjbt+HRwWt9ItaW9aWhiskTsQnqeAhmjkino
        wvboUAcf7L2/VxNKqYghxyE=
X-Google-Smtp-Source: APXvYqxkQlxAu69/+GQpGtwiv2x1hLvi6oWgwDe0NieDDI0FzAPHkkKIAa3MtdASA2/mFRrVFbyaiw==
X-Received: by 2002:a17:902:b68c:: with SMTP id c12mr14442057pls.160.1580077529844;
        Sun, 26 Jan 2020 14:25:29 -0800 (PST)
Received: from localhost ([184.63.162.180])
        by smtp.gmail.com with ESMTPSA id g68sm9362811pfb.123.2020.01.26.14.25.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jan 2020 14:25:29 -0800 (PST)
Date:   Sun, 26 Jan 2020 14:25:21 -0800
From:   John Fastabend <john.fastabend@gmail.com>
To:     John Fastabend <john.fastabend@gmail.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        John Fastabend <john.fastabend@gmail.com>
Cc:     bpf@vger.kernel.org, yhs@fb.com, ast@kernel.org,
        daniel@iogearbox.net
Message-ID: <5e2e11d1d2108_539e2ad6ef82a5b434@john-XPS-13-9370.notmuch>
In-Reply-To: <5e2d08f3b7e7f_144f2ac258f6a5b4d1@john-XPS-13-9370.notmuch>
References: <157984984270.18622.13529102486040865869.stgit@john-XPS-13-9370>
 <20200125111341.mu3r2c2dos5c5rpq@ast-mbp>
 <5e2d08f3b7e7f_144f2ac258f6a5b4d1@john-XPS-13-9370.notmuch>
Subject: Re: [bpf PATCH] bpf: verifier, do_refine_retval_range may clamp umin
 to 0 incorrectly
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

John Fastabend wrote:
> Alexei Starovoitov wrote:
> > On Thu, Jan 23, 2020 at 11:10:42PM -0800, John Fastabend wrote:
> > > @@ -3573,7 +3572,6 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 regno,
> > >  		 * to refine return values.
> > >  		 */
> > >  		meta->msize_smax_value = reg->smax_value;
> > > -		meta->msize_umax_value = reg->umax_value;
> > >  
> > >  		/* The register is SCALAR_VALUE; the access check
> > >  		 * happens using its boundaries.
> > > @@ -4078,9 +4076,9 @@ static void do_refine_retval_range(struct bpf_reg_state *regs, int ret_type,
> > >  		return;
> > >  
> > >  	ret_reg->smax_value = meta->msize_smax_value;
> > > -	ret_reg->umax_value = meta->msize_umax_value;
> > >  	__reg_deduce_bounds(ret_reg);
> > >  	__reg_bound_offset(ret_reg);
> > > +	__update_reg_bounds(ret_reg);
> > 
> > Thanks a lot for the analysis and the fix.
> > I think there is still a small problem.
> > The variable is called msize_smax_value which is used to remember smax,
> > but the helpers actually use umax and the rest of
> > if (arg_type_is_mem_size(arg_type)) { ..}
> > branch is validating [0,umax] range of memory.
> > bpf_get_stack() and probe_read_str*() have 'u32 size' arguments too.
> > So doing
> > meta->msize_smax_value = reg->smax_value;
> > isn't quite correct.
> 
> Agree.
> 
> > Also the name is misleading, since the verifier needs to remember
> > the size 'signed max' doesn't have the right meaning here.
> > It's just a size. It cannot be 'signed' and cannot be negative.
> > How about renaming it to just msize_max_value and do
> > meta->msize_max_value = reg->umax_value;
> 
> msize_max_value reads better and we can give it u64 type so the
> "cannot be negative" part is clear.
> 
> > while later do:
> > ret_reg->smax_value = meta->msize_max_value;
> > with a comment that return value from the helpers
> > is 'int' and not 'unsigned int' while input argument is 'u32 size'.
> 
> Sounds better I'll draft a v2.

v2 on the list now. Thanks!

@Daniel, I dropped your reviewed-by please take another look the change
should be small and functionality was the same but still its not the
same thing you reviewed ;)

@Alexei, Can you check you agree with the "v2 note:" I added at the
bottom of the commit. The gist is it doesn't really matter from
the verifiers point of view if we use umax_value or smax_value for
the msize_max_value because just below setting msize_max_value we
check tnum_is_const and value is positive. That said it reads better
now.
