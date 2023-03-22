Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E61B6C40C3
	for <lists+bpf@lfdr.de>; Wed, 22 Mar 2023 04:04:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbjCVDEw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Mar 2023 23:04:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjCVDET (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Mar 2023 23:04:19 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B956125B7
        for <bpf@vger.kernel.org>; Tue, 21 Mar 2023 20:03:47 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id bc12so17470748plb.0
        for <bpf@vger.kernel.org>; Tue, 21 Mar 2023 20:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679454226;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nSzK+kAddtDOWun3i0mOuWQ/h7aW5t+0sg8tPr0P2po=;
        b=Vkkzqf0IxqkKpi2/xavP/3JYK5PXE9AvcXMIx9JAJ0SB3+gyQkXECqEJgiZd0ATstX
         g+p2kidaTylhzlbEsXJLXyQx8hQfIC7U5TUSBlgK4S2xZpXV0G+2LneEB4WQY+OjDdGL
         p5txxssWVmT5bYrcvjaVrw6faRgoqGer1SLRoLwufCjk78Zsn0PUJbWiz2EETp4QuG9u
         2lCAqC3B6cV5NMOFzk4SYS3GM36CXU9IgBOigrdNZa2rfgR+VkrOsWcy3F3bS/hshbXE
         CmKxmxIbuz89dZyZvhPNe9LvapvYMELpMCo29ZHrJxBWqUX10AAF68wKznR0AxMUUxea
         FX5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679454226;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nSzK+kAddtDOWun3i0mOuWQ/h7aW5t+0sg8tPr0P2po=;
        b=yTkyLI76JuBD1pjaQKWIi7QNIaWNHru0Jpd9kkzZ/W/MdOBbMi3TaM6m8SFIDlAV0f
         xEs65AevINF2K7ALHurWcWA339nApTaBWnKMNJ9o6y8mXVo2Iq6/w0GuIxReZapx26lj
         f9YHpZc7Ept5JvEqlhDhiAi7LI4jq5fK8uzcW3RTLYX+LjAZ7Vk3tJp4Z/iroLul0JXD
         8RlzVpbORHj7OHOV5fNf4YhQRoGFhyrwHaygLV9r23VDjHQBo71A+MPNWwel3MVGdKRU
         rzpaM37qm62R9cd6CkLLEiRl2eZ2qdl0YiKzEmCt/1p+FpTEVZERfXZBBHfjukhCAUBP
         Dd8w==
X-Gm-Message-State: AO0yUKUwcXM2bSjTiZaGdF8Ur1oCKsqMTrCTUZ2nHMp8bPoI2IhtXoaA
        zN3umDiUYYoZAK0iPyAWpM8=
X-Google-Smtp-Source: AK7set/oO9YfZrgSlJp+E8HlyKluFK+JYQOzt2vg+T59amrJQC8C2fBIDIKQC0P1fiTHogYUr5Cabg==
X-Received: by 2002:a17:902:f9c8:b0:1a1:b36d:7803 with SMTP id kz8-20020a170902f9c800b001a1b36d7803mr1167418plb.36.1679454225724;
        Tue, 21 Mar 2023 20:03:45 -0700 (PDT)
Received: from dhcp-172-26-102-232.dhcp.thefacebook.com ([2620:10d:c090:400::5:f4cc])
        by smtp.gmail.com with ESMTPSA id jc20-20020a17090325d400b001963a178dfcsm9420298plb.244.2023.03.21.20.03.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 20:03:45 -0700 (PDT)
Date:   Tue, 21 Mar 2023 20:03:42 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf@vger.kernel.org, Xu Kuohai <xukuohai@huaweicloud.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Fix __reg_bound_offset 64->32 var_off
 subreg propagation
Message-ID: <20230322030342.sl4n62pmep3rc6vg@dhcp-172-26-102-232.dhcp.thefacebook.com>
References: <20230321193354.10445-1-daniel@iogearbox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230321193354.10445-1-daniel@iogearbox.net>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Mar 21, 2023 at 08:33:53PM +0100, Daniel Borkmann wrote:
> Xu reports that after commit 3f50f132d840 ("bpf: Verifier, do explicit ALU32
> bounds tracking"), the following BPF program is rejected by the verifier:
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
...
> index d517d13878cf..d66e70707172 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -1823,9 +1823,9 @@ static void __reg_bound_offset(struct bpf_reg_state *reg)
>  	struct tnum var64_off = tnum_intersect(reg->var_off,
>  					       tnum_range(reg->umin_value,
>  							  reg->umax_value));
> -	struct tnum var32_off = tnum_intersect(tnum_subreg(reg->var_off),
> -						tnum_range(reg->u32_min_value,
> -							   reg->u32_max_value));
> +	struct tnum var32_off = tnum_intersect(tnum_subreg(var64_off),
> +					       tnum_range(reg->u32_min_value,
> +							  reg->u32_max_value));

Great fix and excellent analysis!
The CI is complaining though:
test_align:FAIL:pointer variable subtraction unexpected error: 1 (errno 13)
#1/12    align/pointer variable subtraction:FAIL
#1       align:FAIL
Summary: 289/1752 PASSED, 29 SKIPPED, 1 FAILED

Please roll the update for the test into the fix.

Also agree that bpf-next is a good target for the fix.
It doesn't look risky, but since it was there for so long it can go through
bpf-next just fine.
