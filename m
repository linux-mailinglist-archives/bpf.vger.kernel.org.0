Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6370A58F27E
	for <lists+bpf@lfdr.de>; Wed, 10 Aug 2022 20:43:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbiHJSnm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 10 Aug 2022 14:43:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231286AbiHJSnm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 10 Aug 2022 14:43:42 -0400
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6486BDFE
        for <bpf@vger.kernel.org>; Wed, 10 Aug 2022 11:43:40 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 398BD240101
        for <bpf@vger.kernel.org>; Wed, 10 Aug 2022 20:43:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1660157018; bh=lxSdneT9xc/j7YAZDbzMLwucizn2WLOG5bbXgqLDDUQ=;
        h=Date:From:To:Cc:Subject:From;
        b=HXyDkRtBjmfRkXm1Reucv/Ul/K8OqPw5pR0Fd10H0WZ7PkDiwVfMhL0quydCxUI5Y
         dU7NgPhCCB8JwpZ3aAqxCrbrJ7na7Lk8N63MFDDTPBVAtYdUFN+qWAQlsEzl2Ntw5f
         ou1eIv9NhqJqVfwo/X4Gz+FuDkSv8lEzKMEABaSBTyyN8LQNOyHG9HXXOE6XD76OGR
         R8f+leIPI93vLO8zEJEU8pCF1zfHvn+DUrSZzWlRtP2oB0k8TjM53qT+7PLgq2TTGK
         i9jEn4XbOHKOLx51NV4Cu3NtHukR43o2VwjKN8tKWSi5GK6CDZZDZMIDIyqe4lL697
         fu2PVsLTBEzlg==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4M2zNS0yBPz9rxQ;
        Wed, 10 Aug 2022 20:43:35 +0200 (CEST)
Date:   Wed, 10 Aug 2022 18:43:31 +0000
From:   Daniel =?utf-8?Q?M=C3=BCller?= <deso@posteo.net>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com
Subject: Re: [PATCH bpf-next] libbpf: preserve errno across
 pr_warn/pr_info/pr_debug
Message-ID: <20220810184331.4hr4ohck7mzr4y5h@muellerd-fedora-PC2BDTX9>
References: <20220810183425.1998735-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220810183425.1998735-1-andrii@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Aug 10, 2022 at 11:34:25AM -0700, Andrii Nakryiko wrote:
> As suggested in [0], make sure that libbpf_print saves and restored
> errno and as such guaranteed that no matter what actual print callback
> user installs, macros like pr_warn/pr_info/pr_debug are completely
> transparent as far as errno goes.
> 
> While libbpf code is pretty careful about not clobbering important errno
> values accidentally with pr_warn(), it's a trivial change to make sure
> that pr_warn can be used anywhere without a risk of clobbering errno.
> 
> No functional changes, just future proofing.
> 
>   [0] https://github.com/libbpf/libbpf/pull/536
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  tools/lib/bpf/libbpf.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index f7364ea82ac1..917d975bd4c6 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -223,13 +223,18 @@ __printf(2, 3)
>  void libbpf_print(enum libbpf_print_level level, const char *format, ...)
>  {
>  	va_list args;
> +	int old_errno;
>  
>  	if (!__libbpf_pr)
>  		return;
>  
> +	old_errno = errno;
> +
>  	va_start(args, format);
>  	__libbpf_pr(level, format, args);
>  	va_end(args);
> +
> +	errno = old_errno;
>  }
>  
>  static void pr_perm_msg(int err)
> -- 
> 2.30.2
> 

The change looks good to me.

Acked-by: Daniel Müller <deso@posteo.net>
