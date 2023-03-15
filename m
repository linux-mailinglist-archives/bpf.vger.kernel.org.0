Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C9236BBF18
	for <lists+bpf@lfdr.de>; Wed, 15 Mar 2023 22:30:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbjCOVa1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Mar 2023 17:30:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbjCOVa1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 15 Mar 2023 17:30:27 -0400
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1E803A877
        for <bpf@vger.kernel.org>; Wed, 15 Mar 2023 14:30:15 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 07F2A240418
        for <bpf@vger.kernel.org>; Wed, 15 Mar 2023 22:30:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1678915814; bh=m54SJPDMKgQunReQ+qkptj382c5I/a2aEHMJ9afcPss=;
        h=Date:From:To:Cc:Subject:From;
        b=bszt0ICVH35wZ7qBTsrAA1jg9r6/1sHEX0J6mZnCF1XPbxGqIr92nDyWmzi4HuLWy
         te0xBLtaJDN4SbmTWG2i27oYHoSCeOjfoK65WzZQjZyCn/rEKQh4h3IeywRvH/grvF
         e6zWC3TtiWHJ633xzZ8/qwmY0zeW6/Vxc90qVS2SMylQy91+M3oj+aQsHibKzF7ijo
         yEl0uuSuXIT9qnT9RvMmz5eTyE1GRUs3QfJbZFDT66dFvD3b5YGv4RXv6Rpw6L3WRs
         dmB7bJ5HKe8bzJq1NazzlwdofL/HbFRGjMHKd3Yhq4Y2gmqO2ckiIHoqMrItdfiO/u
         nM7xRwvvlUeTg==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4PcNpV37z5z6tqj;
        Wed, 15 Mar 2023 22:30:10 +0100 (CET)
Date:   Wed, 15 Mar 2023 21:30:07 +0000
From:   Daniel =?utf-8?Q?M=C3=BCller?= <deso@posteo.net>
To:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com
Cc:     Linux Kernel Functional Testing <lkft@linaro.org>
Subject: Re: [PATCH bpf-next] libbpf: Ignore warnings about "inefficient
 alignment"
Message-ID: <20230315213007.67al4dko5vhjzl5p@muellerd-fedora-MJ0AC3F3>
References: <20230315171550.1551603-1-deso@posteo.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230315171550.1551603-1-deso@posteo.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

For what it's worth, I was unable to reproduce the original issue, locally and
in CI. So this is a best guess at a fix based on the suggestion provided in the
linked report.

Thanks,
Daniel

On Wed, Mar 15, 2023 at 05:15:50PM +0000, Daniel Müller wrote:
> Some consumers of libbpf compile the code base with different warnings
> enabled. In a report for perf, for example, -Wpacked was set which
> caused warnings about "inefficient alignment" to be emitted on a subset
> of supported architectures.
> With this change we silence specifically those warnings, as we
> intentionally worked with packed structs.
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> Link: https://lore.kernel.org/bpf/CA+G9fYtBnwxAWXi2+GyNByApxnf_DtP1-6+_zOKAdJKnJBexjg@mail.gmail.com/
> Fixes: 1eebcb60633f ("libbpf: Implement basic zip archive parsing support")
> Signed-off-by: Daniel Müller <deso@posteo.net>
> ---
>  tools/lib/bpf/zip.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/tools/lib/bpf/zip.c b/tools/lib/bpf/zip.c
> index f561aa..3f26d62 100644
> --- a/tools/lib/bpf/zip.c
> +++ b/tools/lib/bpf/zip.c
> @@ -16,6 +16,10 @@
>  #include "libbpf_internal.h"
>  #include "zip.h"
>  
> +#pragma GCC diagnostic push
> +#pragma GCC diagnostic ignored "-Wpacked"
> +#pragma GCC diagnostic ignored "-Wattributes"
> +
>  /* Specification of ZIP file format can be found here:
>   * https://pkware.cachefly.net/webdocs/casestudies/APPNOTE.TXT
>   * For a high level overview of the structure of a ZIP file see
> @@ -119,6 +123,8 @@ struct local_file_header {
>  	__u16 extra_field_length;
>  } __attribute__((packed));
>  
> +#pragma GCC diagnostic pop
> +
>  struct zip_archive {
>  	void *data;
>  	__u32 size;
> -- 
> 2.34.1
> 
