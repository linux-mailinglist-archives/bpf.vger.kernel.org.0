Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8697D6F631F
	for <lists+bpf@lfdr.de>; Thu,  4 May 2023 05:07:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbjEDDHg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 May 2023 23:07:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjEDDHf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 May 2023 23:07:35 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34625C3
        for <bpf@vger.kernel.org>; Wed,  3 May 2023 20:07:34 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-63b5c48ea09so31120b3a.1
        for <bpf@vger.kernel.org>; Wed, 03 May 2023 20:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683169653; x=1685761653;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jKiqJQ9vWO/kV7N+rc8ecvGtlvP+MVlG6tY7yk4vUL4=;
        b=cD++sWt91feqWOKCbedX62PcO61PLAYy9HnGz1txcjwxFd3tjN7MuYt64UffuaNiNT
         Qf90tinLuETk+VraTIMfen6w+Ege/NkrA2kKJZ7aPhcu3Zmt2DkQibcgyxvVW8cdkpdj
         N9rBNpaiIf3/YXYIyKM9TyE/hGpytFtqhT9zvUUEReuS3meJDsGVRnAsaXuMe2tm8BGh
         7aMChecXcnQwrQ8ArqUP/5F8u5tEhZoTlsS3NUFng3T8MAyapn2MapNJbzm68CRf1y5y
         9r2hyuUZ+d7TN/MQUU1Y5v3ArhVzMqZFxMOlXStShTDiprubIXoGM5BAge/xTV0gJ80/
         5wXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683169653; x=1685761653;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jKiqJQ9vWO/kV7N+rc8ecvGtlvP+MVlG6tY7yk4vUL4=;
        b=hAMXlpY/Y22N5KZhMZ6BhTk8y/z2lI4Pk3gORhQ1726ZOrdVyMmPh7M7KQcrvssuJY
         MfRnFbfwU5o3cx3Jg9S03hPmuMiZZJFCdvh8iPTcrwePHp79OYrrV4GHpgkNU1ZzF+jV
         vW8RBHTdgxAvVz8GJSiNc5fZowSFYX0nWN3zjCwpX0eWfcOdATTiWObuffnmo41/9j9B
         wzUGFZS2POL23bKQo6rtxahP37GolvB9G0Fn8YwUXe6jczAwcXXchc5CaRs2renbGOK1
         jmYofFdnvs3jIaFe72Cb23aqh9/tSqK0kxnN2K5Qd0JF3+fi5uG1DaTDkgGRc08bGAew
         b0XA==
X-Gm-Message-State: AC+VfDy9QlLjv9ibZyTsOA/fTnU7I3j9HcgAQaNDh56BiZGcLNEyPhoj
        AVE/MfS/3N0yV96Kr8UryuE=
X-Google-Smtp-Source: ACHHUZ66Gd1QiXHlPLvB5sXb9Q7RaGRx63QIvOjvlVtieukGZFnrI6IcQHQY1zdsmul8CqOrQ6ZZxg==
X-Received: by 2002:a05:6a21:32a7:b0:f4:7cbd:c236 with SMTP id yt39-20020a056a2132a700b000f47cbdc236mr856883pzb.54.1683169653468;
        Wed, 03 May 2023 20:07:33 -0700 (PDT)
Received: from dhcp-172-26-102-232.dhcp.thefacebook.com ([2620:10d:c090:400::5:396f])
        by smtp.gmail.com with ESMTPSA id d18-20020a17090abf9200b002405d3bbe42sm2129425pjs.0.2023.05.03.20.07.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 20:07:33 -0700 (PDT)
Date:   Wed, 3 May 2023 20:07:30 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        martin.lau@kernel.org, kernel-team@meta.com
Subject: Re: [PATCH bpf-next 05/10] bpf: maintain bitmasks across all active
 frames in __mark_chain_precision
Message-ID: <20230504030730.expcb6z4w2l5buna@dhcp-172-26-102-232.dhcp.thefacebook.com>
References: <20230425234911.2113352-1-andrii@kernel.org>
 <20230425234911.2113352-6-andrii@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230425234911.2113352-6-andrii@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Apr 25, 2023 at 04:49:06PM -0700, Andrii Nakryiko wrote:
> Teach __mark_chain_precision logic to maintain register/stack masks
> across all active frames when going from child state to parent state.
> Currently this should be mostly no-op, as precision backtracking usually
> bails out when encountering subprog entry/exit.
> 
> It's not very apparent from the diff due to increased indentation, but
> the logic remains the same, except everything is done on specific `fr`
> frame index. Calls to bt_clear_reg() and bt_clear_slot() are replaced
> with frame-specific bt_clear_frame_reg() and bt_clear_frame_slot(),
> where frame index is passed explicitly, instead of using current frame
> number.
> 
> We also adjust logging to emit affected frame number. And we also add
> better logging of human-readable register and stack slot masks, similar
> to previous patch.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  kernel/bpf/verifier.c                         | 101 ++++++++++--------
>  .../testing/selftests/bpf/verifier/precise.c  |  18 ++--
>  2 files changed, 63 insertions(+), 56 deletions(-)
> 
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 8faf9170acf0..0b19b3d9af65 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -3703,7 +3703,7 @@ static int __mark_chain_precision(struct bpf_verifier_env *env, int frame, int r
>  	struct bpf_func_state *func;
>  	struct bpf_reg_state *reg;
>  	bool skip_first = true;
> -	int i, err;
> +	int i, fr, err;
>  
>  	if (!env->bpf_capable)
>  		return 0;
> @@ -3812,56 +3812,63 @@ static int __mark_chain_precision(struct bpf_verifier_env *env, int frame, int r
>  		if (!st)
>  			break;
>  
> -		func = st->frame[frame];
> -		bitmap_from_u64(mask, bt_reg_mask(bt));
> -		for_each_set_bit(i, mask, 32) {
> -			reg = &func->regs[i];
> -			if (reg->type != SCALAR_VALUE) {
> -				bt_clear_reg(bt, i);
> -				continue;
> +		for (fr = bt->frame; fr >= 0; fr--) {

I'm lost.
'frame' arg is now unused and the next patch passes -1 into it anyway?
Probably this patch alone will break something and not bi-sectable?

> +			func = st->frame[fr];
> +			bitmap_from_u64(mask, bt_frame_reg_mask(bt, fr));
..
> diff --git a/tools/testing/selftests/bpf/verifier/precise.c b/tools/testing/selftests/bpf/verifier/precise.c
> index fce831667b06..ac9be4c576d6 100644
> --- a/tools/testing/selftests/bpf/verifier/precise.c
> +++ b/tools/testing/selftests/bpf/verifier/precise.c
> @@ -44,7 +44,7 @@
>  	mark_precise: frame0: regs(0x4)=r2 stack(0x0)= before 23\
>  	mark_precise: frame0: regs(0x4)=r2 stack(0x0)= before 22\
>  	mark_precise: frame0: regs(0x4)=r2 stack(0x0)= before 20\
> -	parent didn't have regs=4 stack=0 marks:\
> +	mark_precise: frame0: parent state regs(0x4)=r2 stack(0x0)=:\
>  	mark_precise: frame0: last_idx 19 first_idx 10\
>  	mark_precise: frame0: regs(0x4)=r2 stack(0x0)= before 19\
>  	mark_precise: frame0: regs(0x200)=r9 stack(0x0)= before 18\
> @@ -55,7 +55,7 @@
>  	mark_precise: frame0: regs(0x200)=r9 stack(0x0)= before 12\
>  	mark_precise: frame0: regs(0x200)=r9 stack(0x0)= before 11\
>  	mark_precise: frame0: regs(0x200)=r9 stack(0x0)= before 10\
> -	parent already had regs=0 stack=0 marks:",
> +	mark_precise: frame0: parent state regs(0x0)= stack(0x0)=:",

The effect of the patch looks minor, so it might be correct, just super confusing.
