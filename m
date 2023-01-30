Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55423681B1D
	for <lists+bpf@lfdr.de>; Mon, 30 Jan 2023 21:11:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235043AbjA3UK6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 30 Jan 2023 15:10:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230444AbjA3UK6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 30 Jan 2023 15:10:58 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CE1C2FCDB
        for <bpf@vger.kernel.org>; Mon, 30 Jan 2023 12:10:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C0C9CB8168A
        for <bpf@vger.kernel.org>; Mon, 30 Jan 2023 20:10:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 079F4C433EF;
        Mon, 30 Jan 2023 20:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675109454;
        bh=bcvPaEieGOEP06+Yo9cp6YbctmkKJlmEPJKWua3NdHM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Efd8qAp9oviz9ADVX9fRI6W+4jxcjjpBe0M0zh3cIdmQP70kxean0hHc0HOlB4fHj
         X2oXtZPffNfwsqyylX8/Gvs/sDf9dkVYV03Fg5EkSNQHihEtxj4+jRzsRhSyBs43Tp
         QPYOTsib/zNkUl3kLoCuDENyw8+QvkZl+9w+y085pdreSrXIWoVTQUiXfrHrG2ZPVV
         N397zpjYdL5yVKYAt5uRkc0pFNGW00uP0HuB396QZSC5ceC5JPxPwWLsvaSvqe41bs
         Guqw09hJB6K3zJaW1XsmHZIzIA3FVi5DZV3bjErzHWYAVs95ULLlqM/BAA7ZKimiHz
         DjGmRzGmebyzg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 73D31405BE; Mon, 30 Jan 2023 17:10:51 -0300 (-03)
Date:   Mon, 30 Jan 2023 17:10:51 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Alan Maguire <alan.maguire@oracle.com>
Cc:     yhs@fb.com, ast@kernel.org, olsajiri@gmail.com, eddyz87@gmail.com,
        sinquersw@gmail.com, timo@incline.eu, daniel@iogearbox.net,
        andrii@kernel.org, songliubraving@fb.com, john.fastabend@gmail.com,
        kpsingh@chromium.org, sdf@google.com, haoluo@google.com,
        martin.lau@kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v2 dwarves 1/5] dwarves: help dwarf loader spot functions
 with optimized-out parameters
Message-ID: <Y9gkS6dcXO4HWovW@kernel.org>
References: <1675088985-20300-1-git-send-email-alan.maguire@oracle.com>
 <1675088985-20300-2-git-send-email-alan.maguire@oracle.com>
 <Y9gOGZ20aSgsYtPP@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9gOGZ20aSgsYtPP@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Mon, Jan 30, 2023 at 03:36:09PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Mon, Jan 30, 2023 at 02:29:41PM +0000, Alan Maguire escreveu:
> > Compilation generates DWARF at several stages, and often the
> > later DWARF representations more accurately represent optimizations
> > that have occurred during compilation.
> > 
> > In particular, parameter representations can be spotted by their
> > abstract origin references to the original parameter, but they
> > often have more accurate location information.  In most cases,
> > the parameter locations will match calling conventions, and be
> > registers for the first 6 parameters on x86_64, first 8 on ARM64
> > etc.  If the parameter is not a register when it should be however,
> > it is likely passed via the stack or the compiler has used a
> > constant representation instead.  The latter can often be
> > spotted by checking for a DW_AT_const_value attribute,
> > as noted by Eduard.
> > 
> > In addition, absence of a location tag (either across
> > the abstract origin reference and the original parameter,
> > or in the standalone parameter description) is evidence of
> > an optimized-out parameter.  Presence of a location tag
> > is stored in the parameter description and shared between
> > abstract tags and their original referents.
> > 
> > This change adds a field to parameters and their associated
> > ftype to note if a parameter has been optimized out.  Having
> > this information allows us to skip such functions, as their
> > presence in CUs makes BTF encoding impossible.
> > 
> > Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> > ---
> >  dwarf_loader.c | 125 +++++++++++++++++++++++++++++++++++++++++++++++++++++----
> >  dwarves.h      |   5 ++-
> >  2 files changed, 122 insertions(+), 8 deletions(-)
> > 
> > diff --git a/dwarf_loader.c b/dwarf_loader.c
> > index 5a74035..93c2307 100644
> > --- a/dwarf_loader.c
> > +++ b/dwarf_loader.c
> > @@ -992,13 +992,98 @@ static struct class_member *class_member__new(Dwarf_Die *die, struct cu *cu,
> >  	return member;
> >  }
> >  
> > -static struct parameter *parameter__new(Dwarf_Die *die, struct cu *cu, struct conf_load *conf)
> > +/* How many function parameters are passed via registers?  Used below in
> > + * determining if an argument has been optimized out or if it is simply
> > + * an argument > NR_REGISTER_PARAMS.  Setting NR_REGISTER_PARAMS to 0
> > + * allows unsupported architectures to skip tagging optimized-out
> > + * values.
> > + */
> > +#if defined(__x86_64__)
> > +#define NR_REGISTER_PARAMS      6
> > +#elif defined(__s390__)
> > +#define NR_REGISTER_PARAMS	5
> > +#elif defined(__aarch64__)
> > +#define NR_REGISTER_PARAMS      8
> > +#elif defined(__mips__)
> > +#define NR_REGISTER_PARAMS	8
> > +#elif defined(__powerpc__)
> > +#define NR_REGISTER_PARAMS	8
> > +#elif defined(__sparc__)
> > +#define NR_REGISTER_PARAMS	6
> > +#elif defined(__riscv) && __riscv_xlen == 64
> > +#define NR_REGISTER_PARAMS	8
> > +#elif defined(__arc__)
> > +#define NR_REGISTER_PARAMS	8
> > +#else
> > +#define NR_REGISTER_PARAMS      0
> > +#endif
> 
> This should be done as a function, something like:
> 
> int cu__nr_register_params(struct cu *cu)
> {
> 	GElf_Ehdr ehdr;
> 
> 	gelf_getehdr(cu->elf, &ehdr);
> 
> 	switch (ehdr.machine) {
> 	...
> 
> }
> 
> I'm coding that now, will send the diff shortly.
> 
> This is to support cross-builds.

I made this change to this patch, please check.

Thanks,

- Arnaldo

diff --git a/dwarf_loader.c b/dwarf_loader.c
index 752a3c1afc4494f2..81963e71715c8435 100644
--- a/dwarf_loader.c
+++ b/dwarf_loader.c
@@ -994,29 +994,29 @@ static struct class_member *class_member__new(Dwarf_Die *die, struct cu *cu,
 
 /* How many function parameters are passed via registers?  Used below in
  * determining if an argument has been optimized out or if it is simply
- * an argument > NR_REGISTER_PARAMS.  Setting NR_REGISTER_PARAMS to 0
- * allows unsupported architectures to skip tagging optimized-out
+ * an argument > cu__nr_register_params().  Making cu__nr_register_params()
+ * return 0 allows unsupported architectures to skip tagging optimized-out
  * values.
  */
-#if defined(__x86_64__)
-#define NR_REGISTER_PARAMS      6
-#elif defined(__s390__)
-#define NR_REGISTER_PARAMS	5
-#elif defined(__aarch64__)
-#define NR_REGISTER_PARAMS      8
-#elif defined(__mips__)
-#define NR_REGISTER_PARAMS	8
-#elif defined(__powerpc__)
-#define NR_REGISTER_PARAMS	8
-#elif defined(__sparc__)
-#define NR_REGISTER_PARAMS	6
-#elif defined(__riscv) && __riscv_xlen == 64
-#define NR_REGISTER_PARAMS	8
-#elif defined(__arc__)
-#define NR_REGISTER_PARAMS	8
-#else
-#define NR_REGISTER_PARAMS      0
-#endif
+static int arch__nr_register_params(const GElf_Ehdr *ehdr)
+{
+	switch (ehdr->e_machine) {
+	case EM_S390:	 return 5;
+	case EM_SPARC:
+	case EM_SPARCV9:
+	case EM_X86_64:	 return 6;
+	case EM_AARCH64:
+	case EM_ARC:
+	case EM_ARM:
+	case EM_MIPS:
+	case EM_PPC:
+	case EM_PPC64:
+	case EM_RISCV:	 return 8;
+	default:	 break;
+	}
+
+	return 0;
+}
 
 static struct parameter *parameter__new(Dwarf_Die *die, struct cu *cu,
 					struct conf_load *conf, int param_idx)
@@ -1031,7 +1031,7 @@ static struct parameter *parameter__new(Dwarf_Die *die, struct cu *cu,
 		tag__init(&parm->tag, cu, die);
 		parm->name = attr_string(die, DW_AT_name, conf);
 
-		if (param_idx >= NR_REGISTER_PARAMS)
+		if (param_idx >= cu->nr_register_params)
 			return parm;
 		/* Parameters which use DW_AT_abstract_origin to point at
 		 * the original parameter definition (with no name in the DIE)
@@ -2870,6 +2870,7 @@ static int cu__set_common(struct cu *cu, struct conf_load *conf,
 		return DWARF_CB_ABORT;
 
 	cu->little_endian = ehdr.e_ident[EI_DATA] == ELFDATA2LSB;
+	cu->nr_register_params = arch__nr_register_params(&ehdr);
 	return 0;
 }
 
diff --git a/dwarves.h b/dwarves.h
index fd1ca3ae9f4ab531..ddf56f0124e0ec03 100644
--- a/dwarves.h
+++ b/dwarves.h
@@ -262,6 +262,7 @@ struct cu {
 	uint8_t		 has_addr_info:1;
 	uint8_t		 uses_global_strings:1;
 	uint8_t		 little_endian:1;
+	uint8_t		 nr_register_params;
 	uint16_t	 language;
 	unsigned long	 nr_inline_expansions;
 	size_t		 size_inline_expansions;
