Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D399149897
	for <lists+bpf@lfdr.de>; Sun, 26 Jan 2020 04:35:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729099AbgAZDfZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 25 Jan 2020 22:35:25 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40038 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728842AbgAZDfZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 25 Jan 2020 22:35:25 -0500
Received: by mail-pl1-f195.google.com with SMTP id p12so2032954plr.7
        for <bpf@vger.kernel.org>; Sat, 25 Jan 2020 19:35:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=Dc7xdy+wQRFsKSFfW/WBLouLtZAbGTcQGZ5AAVS68IE=;
        b=WFRQypbbGMEjVXDyVtQ7KtsNHk0PJFbpiYyOrS60gaGupdmwZnpOefEU7a+whiL3KR
         4bkjQLwOqBXTDJPSHeTflnDUbvTfuiw4QmZoPDnUxG/aMdXts71ADJIvi9M9Ikon0W4Z
         m/uKq1YN4YKvttGhEnL8Qa2NOXBs0rYhm/E5htUPcYkLRVLuNHO4Qiwk6wIHrNJDg/eN
         5VYwrh/RDm1c8quwXihr94dRyT9ZDV5GbcSFQJcZKX8wQhmvPtbS0Kmw4yP6iyTNWLy3
         YErw0l4n2wKWmO2BXE6uatjDcfyzlqTTsRFIFTjmvSFrrmj1pX4XlTdRWZcUoLPL9kdI
         LNVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=Dc7xdy+wQRFsKSFfW/WBLouLtZAbGTcQGZ5AAVS68IE=;
        b=S++K0jHxEagRyd0QHcGvGdepjNfcvzck636rtq6VlQrDVyWlPUx2OApg2efRiN2606
         NOQ8dNTdAw8Alv1UagL05lWUCDlRAFFf//RjKDy1oQd3JW8vY5h9qlsVoapmq0GdG+IM
         W6p9pZUOpRXc7xQUXWLWKmY5CM2MmE+wsHCS81dDbFU5Rfaue3ynC4gVhrj0UtdUTiyJ
         TnjsG9p8cJ7UT+m/MwaMHITNGxCw/3AC+GA3EsCVVIJbgMiPShg92tXnQq0MOE9Sa/7n
         Ywtzy8Imyj91q9LUIAplZdBa7AOgW+3YNrCktGn26sjloMcY7GEOixRx3LSO24iNp2CS
         X2RQ==
X-Gm-Message-State: APjAAAU11grTUSgr3VKErDAj7XDIvV6XKd2Y3ellXr5qpOrGH3nlSTF+
        AkWl/YTJCWDkjlKRMXccfBs=
X-Google-Smtp-Source: APXvYqwTM6WCMHsT0YVYkfM8n9n1OnOZFHrBKNZ1+MhTsyAf5c+vLsyLdAmETyOl6lWl4yI+2D7ZPw==
X-Received: by 2002:a17:902:b718:: with SMTP id d24mr9460005pls.80.1580009724945;
        Sat, 25 Jan 2020 19:35:24 -0800 (PST)
Received: from localhost ([184.63.162.180])
        by smtp.gmail.com with ESMTPSA id r145sm659181pfr.5.2020.01.25.19.35.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jan 2020 19:35:24 -0800 (PST)
Date:   Sat, 25 Jan 2020 19:35:15 -0800
From:   John Fastabend <john.fastabend@gmail.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        John Fastabend <john.fastabend@gmail.com>
Cc:     bpf@vger.kernel.org, yhs@fb.com, ast@kernel.org,
        daniel@iogearbox.net
Message-ID: <5e2d08f3b7e7f_144f2ac258f6a5b4d1@john-XPS-13-9370.notmuch>
In-Reply-To: <20200125111341.mu3r2c2dos5c5rpq@ast-mbp>
References: <157984984270.18622.13529102486040865869.stgit@john-XPS-13-9370>
 <20200125111341.mu3r2c2dos5c5rpq@ast-mbp>
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

Alexei Starovoitov wrote:
> On Thu, Jan 23, 2020 at 11:10:42PM -0800, John Fastabend wrote:
> > @@ -3573,7 +3572,6 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 regno,
> >  		 * to refine return values.
> >  		 */
> >  		meta->msize_smax_value = reg->smax_value;
> > -		meta->msize_umax_value = reg->umax_value;
> >  
> >  		/* The register is SCALAR_VALUE; the access check
> >  		 * happens using its boundaries.
> > @@ -4078,9 +4076,9 @@ static void do_refine_retval_range(struct bpf_reg_state *regs, int ret_type,
> >  		return;
> >  
> >  	ret_reg->smax_value = meta->msize_smax_value;
> > -	ret_reg->umax_value = meta->msize_umax_value;
> >  	__reg_deduce_bounds(ret_reg);
> >  	__reg_bound_offset(ret_reg);
> > +	__update_reg_bounds(ret_reg);
> 
> Thanks a lot for the analysis and the fix.
> I think there is still a small problem.
> The variable is called msize_smax_value which is used to remember smax,
> but the helpers actually use umax and the rest of
> if (arg_type_is_mem_size(arg_type)) { ..}
> branch is validating [0,umax] range of memory.
> bpf_get_stack() and probe_read_str*() have 'u32 size' arguments too.
> So doing
> meta->msize_smax_value = reg->smax_value;
> isn't quite correct.

Agree.

> Also the name is misleading, since the verifier needs to remember
> the size 'signed max' doesn't have the right meaning here.
> It's just a size. It cannot be 'signed' and cannot be negative.
> How about renaming it to just msize_max_value and do
> meta->msize_max_value = reg->umax_value;

msize_max_value reads better and we can give it u64 type so the
"cannot be negative" part is clear.

> while later do:
> ret_reg->smax_value = meta->msize_max_value;
> with a comment that return value from the helpers
> is 'int' and not 'unsigned int' while input argument is 'u32 size'.

Sounds better I'll draft a v2.
