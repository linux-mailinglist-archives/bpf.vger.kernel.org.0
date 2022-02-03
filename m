Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F045A4A7EC2
	for <lists+bpf@lfdr.de>; Thu,  3 Feb 2022 05:55:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349306AbiBCEzA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Feb 2022 23:55:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbiBCEzA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Feb 2022 23:55:00 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CCA7C061714
        for <bpf@vger.kernel.org>; Wed,  2 Feb 2022 20:55:00 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id y5-20020a17090aca8500b001b8127e3d3aso1726969pjt.3
        for <bpf@vger.kernel.org>; Wed, 02 Feb 2022 20:55:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UZB/ckO3baR/5jP++YQnq5de16aSEsdbjVKm6vqGyh0=;
        b=OGO2vUJTlG3szydstqViDtepw+F4dj4/7GwX7/0SlBHy01FesgX2D1QRDD/EIU7+w5
         ahZfEgacWmbTR5b+DLiTAYWzmCEOA+QuG9wTfkwp0WFFPTgltwXg7AJiOeM90cb0ML+e
         iZfyikf76lPgvHjTuMWcAYTc2VQyeOnoGaC/YCIC4/YqmZmFc1xM0P292jM9/hGeHzMA
         djegP3Sd8jh8Xur8FwvWbHVfz3aNvfubiZHUW8s4uA9pweWbaG1U8lFWsm4X/tTwC2Uk
         bLfBZ0PTTgLjWtpwnqQynlglnNPjC3i53i+tyTo0WWyOM4iSaTmB7G2H8byu6D8NY1U9
         YovQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UZB/ckO3baR/5jP++YQnq5de16aSEsdbjVKm6vqGyh0=;
        b=RmK463vgvA2EP2ffdrbMrdP38z92VuNEUHec7nxMV3GoxefHLZWp20hrkD+VE7MKz8
         Ar+QC6BW7vX/5xyEweuG9hiTKCyRgwNkH4oCDcjLT0jTBRdpn2t3U8ESco92/dUbw8J0
         F89aYsl2uaNiWKHHjLjw2bQW6YxC+yiQ+Kv3Q1iL54SAyuM2CFkPWCa+UvAY2VnvYT3Q
         yiLXdWfhyNi9II7GBVwYYhDx+6AM39alCC2cFRZgWtqVhXDVJ5l8d5GZQiHT4dqQh8s3
         Vm/hs27w2h5SKew2Fj4fHTHweqUBdJ5lNXwWFVWKutsaNmWMyxhnYDBdE8oXLnKvY/0e
         x2VA==
X-Gm-Message-State: AOAM533/o55kG9w8zRgReqIhXmZiuOxvNv/f0Iy/HdZHsKpnio0b18TZ
        2QQCl+vIiHvrvKcZHmvVi09EKkPYWOeLxw==
X-Google-Smtp-Source: ABdhPJzMjHLZCP2HOdM4VZVpfeTnTbgP5FUZXTvKBtsis352mq8aWyYZUwdkeDdEeS8K57SzCJQVSQ==
X-Received: by 2002:a17:903:404b:: with SMTP id n11mr21228227pla.129.1643864099524;
        Wed, 02 Feb 2022 20:54:59 -0800 (PST)
Received: from localhost (61-223-193-169.dynamic-ip.hinet.net. [61.223.193.169])
        by smtp.gmail.com with ESMTPSA id p22sm25230755pfw.139.2022.02.02.20.54.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 20:54:58 -0800 (PST)
From:   Hou Tao <hotforest@gmail.com>
X-Google-Original-From: Hou Tao <houtao1@huawei.com>
To:     kafai@fb.com
Cc:     andrii@kernel.org, ard.biesheuvel@arm.com, ast@kernel.org,
        bpf@vger.kernel.org, catalin.marinas@arm.com, daniel@iogearbox.net,
        houtao1@huawei.com, linux-arm-kernel@lists.infradead.org,
        will@kernel.org, yhs@fb.com, zlim.lnx@gmail.com
Subject: Re: [PATCH bpf-next v2 2/2] bpf, arm64: calculate offset as byte-offset for bpf line info
Date:   Thu,  3 Feb 2022 12:54:51 +0800
Message-Id: <20220203045451.5217-1-houtao1@huawei.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220202184525.ydj3a7jc73o64dws@kafai-mbp.dhcp.thefacebook.com>
References: <20220202184525.ydj3a7jc73o64dws@kafai-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

> 
> On Tue, Jan 25, 2022 at 06:57:07PM +0800, Hou Tao wrote:
> > insn_to_jit_off passed to bpf_prog_fill_jited_linfo() is calculated
> > in instruction granularity instead of bytes granularity, but bpf
> > line info requires byte offset, so fixing it by calculating offset
> > as byte-offset.
> > 
> > Signed-off-by: Hou Tao <houtao1@huawei.com>
> > ---
> >  arch/arm64/net/bpf_jit_comp.c | 13 ++++++++-----
> >  1 file changed, 8 insertions(+), 5 deletions(-)
> > 
> > diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
> > index 6a83f3070985..7b94e0c5e134 100644
> > --- a/arch/arm64/net/bpf_jit_comp.c
> > +++ b/arch/arm64/net/bpf_jit_comp.c
> > @@ -152,10 +152,12 @@ static inline int bpf2a64_offset(int bpf_insn, int off,
> >  	bpf_insn++;
> >  	/*
> >  	 * Whereas arm64 branch instructions encode the offset
> > -	 * from the branch itself, so we must subtract 1 from the
> > +	 * from the branch itself, so we must subtract 4 from the
> >  	 * instruction offset.
> >  	 */
> > -	return ctx->offset[bpf_insn + off] - (ctx->offset[bpf_insn] - 1);
> > +	return (ctx->offset[bpf_insn + off] -
> > +		(ctx->offset[bpf_insn] - AARCH64_INSN_SIZE)) /
> > +		AARCH64_INSN_SIZE;
> Is it another bug fix? It does not seem to be related
> to the change described in the commit message.
>
No, because ctx->offset is byte-offset now, but bpf2a64_offset()
needs to return instruction offset instead of byte offset, so the
calculation needs update. But i should not update the comment because
it is right. Will post v3 to fix it.

> >  }
> >  
> >  static void jit_fill_hole(void *area, unsigned int size)
> > @@ -946,13 +948,14 @@ static int build_body(struct jit_ctx *ctx, bool extra_pass)
> >  		const struct bpf_insn *insn = &prog->insnsi[i];
> >  		int ret;
> >  
> > +		/* BPF line info needs byte-offset instead of insn-offset */
> >  		if (ctx->image == NULL)
> > -			ctx->offset[i] = ctx->idx;
> > +			ctx->offset[i] = ctx->idx * AARCH64_INSN_SIZE;
> >  		ret = build_insn(insn, ctx, extra_pass);
> >  		if (ret > 0) {
> >  			i++;
> >  			if (ctx->image == NULL)
> > -				ctx->offset[i] = ctx->idx;
> > +				ctx->offset[i] = ctx->idx * AARCH64_INSN_SIZE;
> >  			continue;
> >  		}
> >  		if (ret)
> > @@ -964,7 +967,7 @@ static int build_body(struct jit_ctx *ctx, bool extra_pass)
> >  	 * instruction (end of program)
> >  	 */
> >  	if (ctx->image == NULL)
> > -		ctx->offset[i] = ctx->idx;
> > +		ctx->offset[i] = ctx->idx * AARCH64_INSN_SIZE;
> Changes in this function makes sense.
> 
