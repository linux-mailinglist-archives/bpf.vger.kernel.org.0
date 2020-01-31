Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 881C814E743
	for <lists+bpf@lfdr.de>; Fri, 31 Jan 2020 03:46:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727749AbgAaCqZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 30 Jan 2020 21:46:25 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:42535 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727739AbgAaCqZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 30 Jan 2020 21:46:25 -0500
Received: by mail-pl1-f194.google.com with SMTP id p9so2116040plk.9
        for <bpf@vger.kernel.org>; Thu, 30 Jan 2020 18:46:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RkMbKTmR7ngGSydipVgZ15K+LCF9xOSyNDUHBXBErD4=;
        b=YMzLYhU0c3MuCjaJpaUPRrsme7mLZ0Ee1QozBgR7IJ/bfiFI69gjdsGP79CtG2Rgc8
         2wSqKecEHLN5a40nPPHug23qTACPhTYpRBeKBWKO6psTWqWmIPto3mYNnBW/OIgsp/UO
         IG157kOsS1jgVwJxJpb6wD6mjsVWjI3j3gh7aC32ZokUZPXCSm+yEvY1JAY+46gWX0Hf
         tAhX2m8BS6casHHhTsJHwUVn99jTktncJQztaxJ2hinuFo8OgUFMRtJSWvVc3isYTzvX
         G2e+GomIaWqGT4dVHJueIaFQFKJFh8tYwr17dVzWOb6a46liCUrPbPaXHN8ZW9P9g6ai
         kM4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RkMbKTmR7ngGSydipVgZ15K+LCF9xOSyNDUHBXBErD4=;
        b=WKYu0Uq+WN+OU9fsGFxrpwkMCEqXVoO98h6GgppXDbMsLI/UzIbw7Dn9u3ZDTKhEI1
         Vi+IsvqRtzAo1HfK912EMGbXoSPK4iZZgfJ8ZCL0+gKvU7TQ92/UW6Yf1qxwO1tw5mFJ
         TsI0/NDIisO6HKi/4wA4zmgnYfx2h8zEghqcqgBBuLj947CXSypk2VZnmBw5HxuPMvPs
         wrx+0hwkPBvBhdYzFG+s12e6VRKFElTzUMxmMXOoOqF8ZsFkq3vy7x0gIdnzY267wT2x
         ixRs8pNGKbVF1V9Qyh21JRCMKJjCg9X/qrkT9Qb5Pj2i2dVaM5Ei9nXOylh2P0S/rEt6
         27+A==
X-Gm-Message-State: APjAAAWbXosjyvEpyDIdQ1UZxLSW2Wj7sHTUehARtnSYSdgBqSmUgJ1M
        qHlTSWJMaHsLpNYRtL2pg+yWuDCB
X-Google-Smtp-Source: APXvYqxiqksO0fAx7vWf4k1Y5roRLG1BkRrTj46S7NHlFS6sWAUfPxYf3gRG9xMhUuth27Yn57VdFw==
X-Received: by 2002:a17:902:bb88:: with SMTP id m8mr7894089pls.63.1580438784794;
        Thu, 30 Jan 2020 18:46:24 -0800 (PST)
Received: from ast-mbp ([2620:10d:c090:200::1:ace8])
        by smtp.gmail.com with ESMTPSA id u18sm7890709pgi.44.2020.01.30.18.46.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Jan 2020 18:46:23 -0800 (PST)
Date:   Thu, 30 Jan 2020 18:46:22 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     John Fastabend <john.fastabend@gmail.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>, bpf <bpf@vger.kernel.org>,
        Yonghong Song <yhs@fb.com>, Alexei Starovoitov <ast@kernel.org>
Subject: Re: [bpf PATCH v3] bpf: verifier, do_refine_retval_range may clamp
 umin to 0 incorrectly
Message-ID: <20200131024620.2ctms6f2il6qss3q@ast-mbp>
References: <158015334199.28573.4940395881683556537.stgit@john-XPS-13-9370>
 <b26a97e0-6b02-db4b-03b3-58054bcb9b82@iogearbox.net>
 <CAADnVQ+YhgKLkVCsQeBmKWxfuT+4hiHAYte9Xnq8XpC8WedQXQ@mail.gmail.com>
 <99042fc3-0b02-73cb-56cd-fc9a4bfdf3ee@iogearbox.net>
 <5e320c9a30f64_2a332aadcd1385bc3f@john-XPS-13-9370.notmuch>
 <20200130000415.dwd7zn6wj7qlms7g@ast-mbp>
 <5e33147f55528_19152af196f745c460@john-XPS-13-9370.notmuch>
 <20200130175935.dauoijsxmbjpytjv@ast-mbp.dhcp.thefacebook.com>
 <5e336803b5773_752d2b0db487c5c06e@john-XPS-13-9370.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e336803b5773_752d2b0db487c5c06e@john-XPS-13-9370.notmuch>
User-Agent: NeoMutt/20180223
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jan 30, 2020 at 03:34:27PM -0800, John Fastabend wrote:
> 
> diff --git a/llvm/lib/Target/BPF/BPFInstrInfo.td b/llvm/lib/Target/BPF/BPFInstrInfo.td
> index 0f39294..a187103 100644
> --- a/llvm/lib/Target/BPF/BPFInstrInfo.td
> +++ b/llvm/lib/Target/BPF/BPFInstrInfo.td
> @@ -733,7 +733,7 @@ def : Pat<(i64 (sext GPR32:$src)),
>            (SRA_ri (SLL_ri (MOV_32_64 GPR32:$src), 32), 32)>;
>  
>  def : Pat<(i64 (zext GPR32:$src)),
> -          (SRL_ri (SLL_ri (MOV_32_64 GPR32:$src), 32), 32)>;
> +          (MOV_32_64 GPR32:$src)>;

That's good optimization and 32-bit zero-extend after mov32 is not x86
specific. It's mandatory on all archs.

But I won't solve this problem. There are both signed and unsigned extensions
in that program. The one that breaks is _singed_ one and it cannot be optimized
into any other instruction by llvm.
Hence the proposal to do pseudo insn for it and upgrade to uapi later.

llvm-objdump -S test_get_stack_rawtp.o
; usize = bpf_get_stack(ctx, raw_data, max_len, BPF_F_USER_STACK);
      52:	85 00 00 00 43 00 00 00	call 67 
      53:	b7 02 00 00 00 00 00 00	r2 = 0
      54:	bc 08 00 00 00 00 00 00	w8 = w0
; 	if (usize < 0)
      55:	bc 81 00 00 00 00 00 00	w1 = w8
      56:	67 01 00 00 20 00 00 00	r1 <<= 32
      57:	c7 01 00 00 20 00 00 00	r1 s>>= 32
      58:	6d 12 1a 00 00 00 00 00	if r2 s> r1 goto +26 <LBB0_6>
56 and 57 are the shifts.
