Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 079CF6B8089
	for <lists+bpf@lfdr.de>; Mon, 13 Mar 2023 19:30:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230380AbjCMSaJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 Mar 2023 14:30:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbjCMSaB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 13 Mar 2023 14:30:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E17E7F00C
        for <bpf@vger.kernel.org>; Mon, 13 Mar 2023 11:29:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A452D61476
        for <bpf@vger.kernel.org>; Mon, 13 Mar 2023 18:28:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCA20C433EF;
        Mon, 13 Mar 2023 18:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678732131;
        bh=o8QUJPo/lTBnq3eWlmd9wLhiL4fT1f0DjDq2Y4dcgYU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H/lP9XfNeFEmMWa+Maicyn/Oon4cEC4rhL6aKxsmb5Cr0qx5Gg3gePw0GqivwgbYq
         qnAuakiYh79D5DJkNZXUiuJhUbsEIJShTXsITGzz/pULuMPmfzUP1jCOP75/YfRFp/
         Kxq2fJL64zhPdbewKnGSGsrw1Ore5wP1y53sPmheVu85KYe5IT/dLeuSEFlXFiHylm
         oYmyWVWNswa6XJ9oi16mP4tiezQ7AYWYZf1wUVhkW85+nOL7kn8lJe9F8G5A/QWLA+
         tsvQ8+w8in598CtIkBHy6kTQOATL7FrZHNyP6zT/KGyoF4X2X1fzeNpTk4wmUfGnDC
         gD71noJSvb+hg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 644014049F; Mon, 13 Mar 2023 15:28:48 -0300 (-03)
Date:   Mon, 13 Mar 2023 15:28:48 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Eduard Zingerman <eddyz87@gmail.com>
Cc:     Alan Maguire <alan.maguire@oracle.com>, ast@kernel.org,
        andrii@kernel.org, daniel@iogearbox.net, haoluo@google.com,
        jolsa@kernel.org, john.fastabend@gmail.com, kpsingh@chromium.org,
        sinquersw@gmail.com, martin.lau@kernel.org, songliubraving@fb.com,
        sdf@google.com, timo@incline.eu, yhs@fb.com, bpf@vger.kernel.org
Subject: Re: [PATCH dwarves 2/3] dwarves_fprintf: support skipping modifier
Message-ID: <ZA9rYJzz6mCuQ6gh@kernel.org>
References: <1678459850-16140-1-git-send-email-alan.maguire@oracle.com>
 <1678459850-16140-3-git-send-email-alan.maguire@oracle.com>
 <cba295426f5bd157688b3393a4f528df06d2eca5.camel@gmail.com>
 <157b8d32-4628-4b78-a587-c492946e5e10@oracle.com>
 <6dfa7235106db98698fe013cde74666f7d485669.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6dfa7235106db98698fe013cde74666f7d485669.camel@gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Mon, Mar 13, 2023 at 07:12:43PM +0200, Eduard Zingerman escreveu:
> On Mon, 2023-03-13 at 16:37 +0000, Alan Maguire wrote:
> [...]
> > sure; try adding "--skip_encoding_btf_inconsistent_proto --btf_gen_optimized".
> > I was testing with gcc 11.2.1.
> 
> pahole -F dwarf \
>        --flat_arrays \
>        --sort --jobs \
>        --suppress_aligned_attribute \
>        --suppress_force_paddings \
>        --suppress_packed \
>        --lang_exclude rust \
>        --show_private_classes \
>        --skip_encoding_btf_inconsistent_proto \
>        --btf_gen_optimized \
>        ./vmlinux
> 
> Like this, right?
> gcc 11.3, pahole master, still don't see this in function prototypes,
> maybe I have a simpler kernel config...
> 
> [...]
> 
> > > On the other hand, I see it in a few structure definitions, e.g. here
> > > is original C code (include/linux/sysrq.h:32):
> > > 
> > >     struct sysrq_key_op {
> > >     	void (* const handler)(int);
> > >     	const char * const help_msg;
> > >     	const char * const action_msg;
> > >     	const int enable_mask;
> > >     };
> > > 
> > > And here is how it is reconstructed from DWARF (same happens when
> > > reconstructed from BTF):
> > > 
> > >     struct sysrq_key_op {
> > >             const void                 (*handler)(int);      /*     0     8 */
> > >             const const char  *        help_msg;             /*     8     8 */
> > >             const const char  *        action_msg;           /*    16     8 */
> > >             const int                  enable_mask;          /*    24     4 */
> > >     
> > >             /* size: 32, cachelines: 1, members: 4 */
> > >             /* padding: 4 */
> > >             /* last cacheline: 32 bytes */
> > >     };
> > > 
> > > So it seems to be a general issue with modifiers printing.
> > > 
> > 
> > So it seems like the modifier ordering isn't preserved, even though
> > the final BTF representation looks right? Thanks!
> 
> Yes, BTF looks right, bpftool prints the structure correctly.

Yes, the problem is in pahole's fprintf.c code

⬢[acme@toolbox pahole]$ cat const-pointer-const.c
#include <stdio.h>

struct foo {
	const char * const s;
};

int main(int argc, const char *argv[])
{
	struct foo bar = { .s = argv[1], };
	return printf("%s: %s\n", argv[0], bar.s);
}
⬢[acme@toolbox pahole]$ gcc -g const-pointer-const.c -o const-pointer-const
⬢[acme@toolbox pahole]$ pahole const-pointer-const
struct foo {
	const constchar  *         s;                    /*     0     8 */

	/* size: 8, cachelines: 1, members: 1 */
	/* last cacheline: 8 bytes */
};
⬢[acme@toolbox pahole]$


Seems a long standing bug, so if you fix the whitespace issue we can
progress and not let this problem prevent the release of 1.25, agreed?

- Arnaldo
