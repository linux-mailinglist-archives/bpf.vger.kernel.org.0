Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BCFF556E58
	for <lists+bpf@lfdr.de>; Thu, 23 Jun 2022 00:19:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344256AbiFVWTf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Jun 2022 18:19:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236938AbiFVWTd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Jun 2022 18:19:33 -0400
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A5242C640
        for <bpf@vger.kernel.org>; Wed, 22 Jun 2022 15:19:31 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id BB245240028
        for <bpf@vger.kernel.org>; Thu, 23 Jun 2022 00:19:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1655936369; bh=NCHXX26I59zlDcpsaMkjdKsigbYX9MgTN4SUeBB5+0A=;
        h=Date:From:To:Subject:From;
        b=FO+Hn8TeoppRn+Sk3B6FTeHFoE6507oR4gwL4Srv7iJS1D41WPa9mdk8dv11XaToT
         w7bxWGrYML6CVQFMaAURyei3CRLOtOV0XCGk1TRrITjW/wkBxZQCzk1zkPrls/m9jb
         tXAhcj/oudmAJksxHpAuuQXxx/PmLRyonbnJmyvLVMLYBZnrYYtQkiJdTXPD7axST+
         plND8VYwxNBPiFnFPJUTDdNUdGZSB/VMDtG+TxcgvUUOuVeow2L5wiPoQIrnJ0wQqb
         qnCMLI5vdgQ7EyDJewlV9gIlDX0PL9vG11HOWeCDlSnulp8S7eUJbMhb1Fsu8i4UaD
         79FYBVsXj/zow==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4LSyV70nD3z6tnQ;
        Thu, 23 Jun 2022 00:19:26 +0200 (CEST)
Date:   Wed, 22 Jun 2022 22:19:21 +0000
From:   Daniel =?utf-8?Q?M=C3=BCller?= <deso@posteo.net>
To:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com
Subject: Re: [PATCH bpf-next 1/2] libbpf: Move core "types_are_compat" logic
 into relo_core.c
Message-ID: <20220622221921.q65wjyirsaqhvg4h@muellerd-fedora-MJ0AC3F3>
References: <20220622173506.860578-1-deso@posteo.net>
 <20220622173506.860578-2-deso@posteo.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220622173506.860578-2-deso@posteo.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jun 22, 2022 at 05:35:05PM +0000, Daniel Müller wrote:
> diff --git a/tools/lib/bpf/relo_core.c b/tools/lib/bpf/relo_core.c
> index 6ad3c3..e54370 100644
> --- a/tools/lib/bpf/relo_core.c
> +++ b/tools/lib/bpf/relo_core.c
> @@ -141,6 +141,84 @@ static bool core_relo_is_enumval_based(enum bpf_core_relo_kind kind)
>  	}
>  }
>  
> +int bpf_core_types_are_compat_recur(const struct btf *local_btf, __u32 local_id,
> +				    const struct btf *targ_btf, __u32 targ_id, int level)
> +{

[...]

> +
> +		/* tail recurse for return type check */
> +		skip_mods_and_typedefs(local_btf, local_type->type, &local_id);
> +		skip_mods_and_typedefs(targ_btf, targ_type->type, &targ_id);
> +		goto recur;
> +	}
> +	default:
> +		return 0;

I actually left out the pr_warn here (present in libbpf but not the kernel). I
suppose it would be best to carry it over from libbpf?

Thanks,
Daniel
