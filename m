Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91B876867B0
	for <lists+bpf@lfdr.de>; Wed,  1 Feb 2023 14:57:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231226AbjBAN5D (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Feb 2023 08:57:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230372AbjBAN4y (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Feb 2023 08:56:54 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30789DBD3
        for <bpf@vger.kernel.org>; Wed,  1 Feb 2023 05:55:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B92E8617B5
        for <bpf@vger.kernel.org>; Wed,  1 Feb 2023 13:55:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDDBBC433EF;
        Wed,  1 Feb 2023 13:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675259747;
        bh=wY6ulHpqGIpfu0BogvoL1mieaEOwL141OJNucUoWIGg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZR+NnzT6aznkNeVZkAquzkrJG2oMqtjKa5mXyUd1ixGhJfaBvARCMagbbDFFjTRRi
         q999oU4xSKxGA8OkqIWU5kPahRR5N0NGacQ3TAJ44JStA7ipiykneGtusNMPZ4Xe39
         5yhZhvCSvcuOjIDAJuj4UUrYrVL95ydt7bskTa0MdYQYR6EEy6/axWnXOjASTfNB44
         er2z4NYqMqDSzmRAEtiw/BFdiGbctIN79JmdieNmtu+Rnsc0hyFNPPmXUr6GAS70XH
         xKzPKT+1nvDuJksnyLsUemvYY8rlYF7K1FPEcMcmf6JsRj0Cr8WG6ueklYLuJgIVHn
         UVXXk9nx8ywbA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 5597A405BE; Wed,  1 Feb 2023 10:55:44 -0300 (-03)
Date:   Wed, 1 Feb 2023 10:55:44 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Alan Maguire <alan.maguire@oracle.com>
Cc:     yhs@fb.com, ast@kernel.org, olsajiri@gmail.com, eddyz87@gmail.com,
        sinquersw@gmail.com, timo@incline.eu, daniel@iogearbox.net,
        andrii@kernel.org, songliubraving@fb.com, john.fastabend@gmail.com,
        kpsingh@chromium.org, sdf@google.com, haoluo@google.com,
        martin.lau@kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH dwarves] dwarves: sync with libbpf-1.1
Message-ID: <Y9pvYFPlFEVXJGK1@kernel.org>
References: <1675169241-32559-1-git-send-email-alan.maguire@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1675169241-32559-1-git-send-email-alan.maguire@oracle.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Tue, Jan 31, 2023 at 12:47:21PM +0000, Alan Maguire escreveu:
> This will pull in BTF dedup improvements
> 
> 082108f libbpf: Resolve unambigous forward declarations
> de048b6 libbpf: Resolve enum fwd as full enum64 and vice versa
> f3c51fe libbpf: Btf dedup identical struct test needs check for nested structs/arrays

So, after running cmake in the build directory to update the libbpf
submodule I'm not finding the above 3 commits:

⬢[acme@toolbox bpf]$ git log --oneline -1
6597330c45d18538 (HEAD, tag: v1.1.0) sync: latest libbpf changes from kernel
⬢[acme@toolbox bpf]$ 

This matches with the "Subproject commit" below, then:

⬢[acme@toolbox bpf]$ git log --oneline | egrep "Resolve unambigous forward declarations"\|"Resolve enum fwd as full enum64 and vice versa"\|"Btf dedup identical struct test needs check for nested structs/arrays"
758331091179fe47 libbpf: Resolve unambigous forward declarations
3a387f5a8fa8b25f libbpf: Resolve enum fwd as full enum64 and vice versa
6ebbbacb5cb11840 libbpf: Btf dedup identical struct test needs check for nested structs/arrays
⬢[acme@toolbox bpf]$

So I'm updating the commits, ok?

Thanks!

- Arnaldo

 
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> ---
>  lib/bpf | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/bpf b/lib/bpf
> index 645500d..6597330 160000
> --- a/lib/bpf
> +++ b/lib/bpf
> @@ -1 +1 @@
> -Subproject commit 645500dd7d2d6b5bb76e4c0375d597d4f0c4814e
> +Subproject commit 6597330c45d185381900037f0130712cd326ae59
> -- 
> 1.8.3.1
