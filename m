Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1E7C57867C
	for <lists+bpf@lfdr.de>; Mon, 18 Jul 2022 17:36:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbiGRPgA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 18 Jul 2022 11:36:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235563AbiGRPgA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 18 Jul 2022 11:36:00 -0400
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C75410FF9
        for <bpf@vger.kernel.org>; Mon, 18 Jul 2022 08:35:59 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id B210B240027
        for <bpf@vger.kernel.org>; Mon, 18 Jul 2022 17:35:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1658158556; bh=WmvMPMFn51CH4YO00HG6KvKQc+3p88qVTfsSb2Wmy9o=;
        h=Date:From:To:Cc:Subject:From;
        b=Ef3YveJzLohzX05gkDmzgx7c60QPvFM9Nww2UwAiWrmgxiwSa1vqKoMyZsKheV0K5
         KqnkmpAqN65zp4JFWR89CmOGN0wvWoCcfVDeT/4IZi29ZhYmroa8fx09MJf+q6mRaS
         8NTyk77HdYLd+3NLR31afSq9yCPY8Mk+LT/h+WaO+Ej2jezB48nhhAEht7611/AAzB
         J2kZctYCFMyOIvfRxQJ4SeaYX4QgU/VK+G+oQEyOEEYAY6yx/KpZvhWeRhCQHTmAlE
         v3nhX9xQXG5eTHX/DGvGJ0hsUqkZ42WCFzTJEF12AhJu+pedFckKOT2kICIjQieHXy
         QSbspEvh2RaSw==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4LmmJR3nTXz9rxL;
        Mon, 18 Jul 2022 17:35:51 +0200 (CEST)
Date:   Mon, 18 Jul 2022 15:35:48 +0000
From:   Daniel =?utf-8?Q?M=C3=BCller?= <deso@posteo.net>
To:     Kuee K1r0a <liulin063@gmail.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bpf: Fix typo in comments in verifier
Message-ID: <20220718153548.qvxrgd3ubtlwtuhu@muellerd-fedora-PC2BDTX9>
References: <20220718065231.26852-1-liulin063@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220718065231.26852-1-liulin063@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jul 18, 2022 at 02:52:31PM +0800, Kuee K1r0a wrote:
> Replace 'then' with 'than'.
> 
> Fixes: f4d7e40a5b71 ("bpf: introduce function calls (verification)")
> Signed-off-by: Kuee K1r0a <liulin063@gmail.com>
> ---
>  kernel/bpf/verifier.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 0efbac0fd126..4da1a7c7657a 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -1167,7 +1167,7 @@ static int copy_verifier_state(struct bpf_verifier_state *dst_state,
>  		return -ENOMEM;
>  	dst_state->jmp_history_cnt = src->jmp_history_cnt;
>  
> -	/* if dst has more stack frames then src frame, free them */
> +	/* if dst has more stack frames than src frame, free them */

Should we use plural as well, 'src frames'?

[...]

I believe the patch prefix should indicate which branch the patch targets as
well. E.g., [PATCH bpf-next]. Looks good to me otherwise.

Acked-by: Daniel Müller <deso@posteo.net>
