Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D51D91BECB1
	for <lists+bpf@lfdr.de>; Thu, 30 Apr 2020 01:42:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbgD2XmE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 29 Apr 2020 19:42:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726164AbgD2XmD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 29 Apr 2020 19:42:03 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B635C03C1AE;
        Wed, 29 Apr 2020 16:42:03 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id 145so1902629pfw.13;
        Wed, 29 Apr 2020 16:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=do9+MWbG28UjyHAK/kcWf4pA+OINYdqriwEnk8jdTKY=;
        b=dmwaP+IIHgrZTFicMlJo0kRd02lRso6m3dcRss+7ThqI0dTejM7ZefD+XY9faiukTk
         +KvvM/uNd/3S5ivSMMscmqUrYcDQqIO/N/0ST66hp0d0LyO8t1PvZyLk4Ov1g3Nbf82a
         Pot8aPwSqX26OJpde3f5NLWa+WTr6EuYo5Ijeb2AeQrLv0OqNkkj1FtSJSU2d4+NiWOi
         O9xX6FAFffFvw3AOFdJHzVTgFO3YKYatUtBw7a2DvLixCLjRi2Y/ITp6RKrFx2QHfXWQ
         7pi3/GUfSscN15rZKA4wxEforf9ihW39y9rXN3xUAt82heDUepP5QDPyBpcuweFpes73
         ApVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=do9+MWbG28UjyHAK/kcWf4pA+OINYdqriwEnk8jdTKY=;
        b=SmT9FnpdQEN+NG8pJ4qnin9qPl+aGcE0R5D1V3hUWEpOovYBHIG5PXIVQZfX45dN3j
         +GVTGONN1hJERGrdZLBDthdIyz1Gzw39tV2HE5h/IXm3DX/PaRgkI7JfxPS9A2FpsVNd
         XRbKtsWCzWD9feRpqcrtakliH95j5j0x4vAciCfmjIUMRSoPtJlpp641N+JWJoI3zszZ
         YJ136Ndr+EbX3z0TQgsYAhzsuAI6BZFGSD2Blx5bbMDJkcMWX9PGPn71KWMeP7G6pOJh
         oXLu2aPL2Qi2QEtViIoTDVDGxvg01h/Hprpkf2sToBUtKHMM9NpUOW3tR+KpHDvMh1Py
         RJuA==
X-Gm-Message-State: AGi0PuahwjS4PFdOw512ywVawz1X+XVessTJVUvplKhUI5BHPfeV84PT
        IKukq3bbjLjz21/d6idvyks=
X-Google-Smtp-Source: APiQypJeohdGTCVWCopJJiXo57mEM0nmQUaOMs4gr7Ys4VA1hWzgysB86xeVCMuvfCWetIYtc+luHw==
X-Received: by 2002:a63:5a50:: with SMTP id k16mr610640pgm.171.1588203722891;
        Wed, 29 Apr 2020 16:42:02 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:400::5:e95f])
        by smtp.gmail.com with ESMTPSA id t80sm2003237pfc.23.2020.04.29.16.42.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 16:42:01 -0700 (PDT)
Date:   Wed, 29 Apr 2020 16:41:59 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     x86@kernel.org, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        mingo@kernel.org, hpa@zytor.com, ast@kernel.org,
        peterz@infradead.org, rdunlap@infradead.org,
        Arnd Bergmann <arnd@arndb.de>, bpf@vger.kernel.org,
        daniel@iogearbox.net
Subject: Re: BPF vs objtool again
Message-ID: <20200429234159.gid6ht74qqmlpuz7@ast-mbp.dhcp.thefacebook.com>
References: <30c3ca29ba037afcbd860a8672eef0021addf9fe.1563413318.git.jpoimboe@redhat.com>
 <tip-3193c0836f203a91bef96d88c64cccf0be090d9c@git.kernel.org>
 <20200429215159.eah6ksnxq6g5adpx@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200429215159.eah6ksnxq6g5adpx@treble>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Apr 29, 2020 at 04:51:59PM -0500, Josh Poimboeuf wrote:
> On Thu, Jul 18, 2019 at 12:14:08PM -0700, tip-bot for Josh Poimboeuf wrote:
> > Commit-ID:  3193c0836f203a91bef96d88c64cccf0be090d9c
> > Gitweb:     https://git.kernel.org/tip/3193c0836f203a91bef96d88c64cccf0be090d9c
> > Author:     Josh Poimboeuf <jpoimboe@redhat.com>
> > AuthorDate: Wed, 17 Jul 2019 20:36:45 -0500
> > Committer:  Thomas Gleixner <tglx@linutronix.de>
> > CommitDate: Thu, 18 Jul 2019 21:01:06 +0200
> > 
> > bpf: Disable GCC -fgcse optimization for ___bpf_prog_run()
> 
> For some reason, this
> 
>   __attribute__((optimize("-fno-gcse")))
> 
> is disabling frame pointers in ___bpf_prog_run().  If you compile with
> CONFIG_FRAME_POINTER it'll show something like:
> 
>   kernel/bpf/core.o: warning: objtool: ___bpf_prog_run.cold()+0x7: call without frame pointer save/setup

you mean it started to disable frame pointers from some version of gcc?
It wasn't doing this before, since objtool wasn't complaining, right?
Sounds like gcc bug?

> Also, since GCC 9.1, the GCC docs say "The optimize attribute should be
> used for debugging purposes only. It is not suitable in production
> code."  That doesn't sound too promising.
> 
> So it seems like this commit should be reverted. But then we're back to
> objtool being broken again in the RETPOLINE=n case, which means no ORC
> coverage in this function.  (See above commit for the details)
> 
> Some ideas:
> 
> - Skip objtool checking of that func/file (at least for RETPOLINE=n) --
>   but then it won't have ORC coverage.
> 
> - Get rid of the "double goto" in ___bpf_prog_run(), which simplifies it
>   enough for objtool to understand -- but then the text explodes for
>   RETPOLINE=y.

How that will look like?
That could be the best option.

> - Add -fno-gfcse to the Makefile for kernel/bpf/core.c -- but then that
>   affects the optimization of other functions in the file.  However I
>   don't think the impact is significant.
> 
> - Move ___bpf_prog_run() to its own file with the -fno-gfcse flag.  I'm
>   thinking this could be the least bad option.  Alexei?

I think it would be easier to move some of the hot path
functions out of core.c instead.
Like *ksym*, BPF_CALL*, bpf_jit*, bpf_prog*.
I think resulting churn will be less.
imo it's more important to keep git blame history for interpreter
than for the other funcs.
Sounds like it's a fix that needs to be sent for the next RC ?
Please send a patch for bpf tree then.

Daniel, thoughts?
