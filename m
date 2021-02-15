Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D473031B560
	for <lists+bpf@lfdr.de>; Mon, 15 Feb 2021 07:27:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbhBOG03 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 15 Feb 2021 01:26:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbhBOG02 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 15 Feb 2021 01:26:28 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE92DC061574
        for <bpf@vger.kernel.org>; Sun, 14 Feb 2021 22:25:46 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id k22so5788666ljg.3
        for <bpf@vger.kernel.org>; Sun, 14 Feb 2021 22:25:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ubique-spb-ru.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JjMmoc8f1AYp9UUzdoeBOFgxHhnSHF1enM+t7Wmicds=;
        b=qL32UQjECIo9aFn6ymRNwC6sohfBP7tyb9J27o+wjiezM/eQUDPn6YzMDHbSzZ8bvx
         E4p+qikeEQG7oxZisHPRBAcRJVas7v6RYLechAFeWj2qM2PRovVage6dli5hf71DR7/j
         ZOOe+qbd268Ext06TXh4DT9HjH1S+nKOBoW8ZKU94YwwSBoGBFNYTgxc7nzfQe4GAe29
         G5ank6TQM/6qEOjBdEG9kSWPySFC4NVMSf8oaWxiqDPQnqj05/ibIb+e53PUada/THbx
         xpPQiC3zSlJEQIUvASyNG2gPpwKt3PZqzNplyLgujKrrrH/rRnHcfZeAkFt62Fa3Lrk4
         bFqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JjMmoc8f1AYp9UUzdoeBOFgxHhnSHF1enM+t7Wmicds=;
        b=eUganCgebV6ZrnqEYpEaOmfZEAcFDcacz2V0iHZkQjl7HgE4oCxXPGIcvc6zKblOxR
         wXIHK1cQ1mHsdpdcFb+deeOw5FeU/JZZ6zUBdhqc81Bo01Kv5HAmDd3f6KyyGXDitr3/
         vqwHq6KDWHbkPtq9VsSmxxvCVdmtiv2Spw+quscgxFn1ijGPQk1wFJ59JPIE6Nb1YTXs
         +lVaL6wuTtlX8cOR+rJylyEsCANWjXSLosGU6fY/MpnZmxLpjdJ54ZsvOi7wfR2OXWdG
         XZOuI8DuH6xhFxXPtPyvnVhmZPdFc2EJ/h80RnC2NO7ZHAbVUf0H2V02VficdRc+UNKj
         P3+g==
X-Gm-Message-State: AOAM531ro+chK/vPjr2HFOF6j+iu8YTLS3cENFUfZaRAoAkf7zh4JWKx
        5Z5kCcFcaDG6pdr5KGgGOJMP1g==
X-Google-Smtp-Source: ABdhPJxvsLCKloyIy3vSOQHh9G6aWr+/AJ4pdA0YqjAfgjWAErQUUkw8ob/WbCIxVNtuNa2IvgBPQA==
X-Received: by 2002:a2e:d11:: with SMTP id 17mr9144558ljn.295.1613370345033;
        Sun, 14 Feb 2021 22:25:45 -0800 (PST)
Received: from localhost ([178.252.72.51])
        by smtp.gmail.com with ESMTPSA id 137sm3501780ljf.110.2021.02.14.22.25.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Feb 2021 22:25:44 -0800 (PST)
Date:   Mon, 15 Feb 2021 10:25:38 +0400
From:   Dmitrii Banshchikov <me@ubique.spb.ru>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@chromium.org, rdna@fb.com
Subject: Re: [PATCH v3 bpf-next 3/4] bpf: Support pointers in global func args
Message-ID: <20210215062538.gor6viyqlasefphp@amnesia>
References: <20210212205642.620788-1-me@ubique.spb.ru>
 <20210212205642.620788-4-me@ubique.spb.ru>
 <20210213020937.g6lt3pczqbjj5h2u@ast-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210213020937.g6lt3pczqbjj5h2u@ast-mbp.dhcp.thefacebook.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Feb 12, 2021 at 06:09:37PM -0800, Alexei Starovoitov wrote:
> On Sat, Feb 13, 2021 at 12:56:41AM +0400, Dmitrii Banshchikov wrote:
> > Add an ability to pass a pointer to a type with known size in arguments
> > of a global function. Such pointers may be used to overcome the limit on
> > the maximum number of arguments, avoid expensive and tricky workarounds
> > and to have multiple output arguments.
> 
> Thanks a lot for adding this feature and exhaustive tests.
> It's a massive improvement in function-by-function verification.
> Hopefully it will increase its adoption.
> I've applied the set to bpf-next.
> 
> > @@ -5349,10 +5352,6 @@ int btf_check_func_arg_match(struct bpf_verifier_env *env, int subprog,
> >  			goto out;
> >  		}
> >  		if (btf_type_is_ptr(t)) {
> > -			if (reg->type == SCALAR_VALUE) {
> > -				bpf_log(log, "R%d is not a pointer\n", i + 1);
> > -				goto out;
> > -			}
> 
> Thanks for nuking this annoying warning along the way.
> People complained that the verification log for normal static functions
> contains above inexplicable message.
> 
> >  			/* If function expects ctx type in BTF check that caller
> >  			 * is passing PTR_TO_CTX.
> >  			 */
> > @@ -5367,6 +5366,25 @@ int btf_check_func_arg_match(struct bpf_verifier_env *env, int subprog,
> >  					goto out;
> >  				continue;
> >  			}
> > +
> > +			if (!is_global)
> > +				goto out;
> > +
> > +			t = btf_type_skip_modifiers(btf, t->type, NULL);
> > +
> > +			ref_t = btf_resolve_size(btf, t, &type_size);
> > +			if (IS_ERR(ref_t)) {
> > +				bpf_log(log,
> > +				    "arg#%d reference type('%s %s') size cannot be determined: %ld\n",
> > +				    i, btf_type_str(t), btf_name_by_offset(btf, t->name_off),
> > +					PTR_ERR(ref_t));
> 
> Hopefully one annoying message won't get replaced with this annoying message :)
> I think the type size should be known most of the time. So it should be fine.
> 
> > +		if (btf_type_is_ptr(t)) {
> > +			if (btf_get_prog_ctx_type(log, btf, t, prog_type, i)) {
> > +				reg->type = PTR_TO_CTX;
> > +				continue;
> > +			}
> 
> Do you think it would make sense to nuke another message in btf_get_prog_ctx_type ?
> With this newly gained usability of global function the message
> "arg#0 type is not a struct"
> is not useful.
> It was marginally useful in the past. Because global funcs supported
> ptr_to_ctx only it wasn't seen as often.
> Now this message probably can simply be removed. wdyt?

Yes, I hit this log message while was working on the patch and it
looked confusing but forgot to adjust/remove it.
I will prepare patch.
Thank you.



-- 

Dmitrii Banshchikov
