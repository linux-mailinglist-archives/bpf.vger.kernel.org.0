Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBFCB6CBF69
	for <lists+bpf@lfdr.de>; Tue, 28 Mar 2023 14:41:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232748AbjC1Ml1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Mar 2023 08:41:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232743AbjC1MlV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Mar 2023 08:41:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBA6EAD08;
        Tue, 28 Mar 2023 05:41:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2ABD461756;
        Tue, 28 Mar 2023 12:40:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 349F9C433EF;
        Tue, 28 Mar 2023 12:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680007257;
        bh=CQ4IVV781DkJukhgUnV5I5MiXxgHEAr0yze5wUMQGD0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jSTD76emm4A5eKALdBIaQ3QiObyvc/EMlMJt1TRimdv0s8YTuRll6/Rq9kQR3XDjw
         sqMkhpkSleRPEYmdPECEutj2gCeiENx0CmU5HMvyTzt6j3Ia7MUB3xVKmCqrYhA8A9
         1v/P1oFza2mt/o1UowBVxbRT1fC1Cqbzqn62LJ5/mXwU6/MqO897VtuLWvbYTiKa8G
         K3qAjdom1k9nS5yK3xMKWA6n/Q8bbJn7c98vqe91bCXhX8rlmEWAY1a2kMbFh5xMJP
         9QNtVNpgGxMlYzcB5dOekgE6GS7qsfU1kWQAFNvfcnt2Jfia5tRFShgeKmOrdbpYpt
         v83NWk1SnFYsA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id A0F324052D; Tue, 28 Mar 2023 09:40:54 -0300 (-03)
Date:   Tue, 28 Mar 2023 09:40:54 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Eduard Zingerman <eddyz87@gmail.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        dwarves@vger.kernel.org, bpf@vger.kernel.org, kernel-team@fb.com,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        yhs@fb.com, jose.marchesi@oracle.com, david.faust@oracle.com,
        alan.maguire@oracle.com
Subject: Re: [PATCH dwarves v2 1/5] fprintf: Correct names for types with
 btf_type_tag attribute
Message-ID: <ZCLgVrwpb3fhnnE7@kernel.org>
References: <20230314230417.1507266-1-eddyz87@gmail.com>
 <20230314230417.1507266-2-eddyz87@gmail.com>
 <ZCGCBF5iYxCtBQKh@kernel.org>
 <b89f55694845d9d8784fe02700f184ff1de83e2e.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b89f55694845d9d8784fe02700f184ff1de83e2e.camel@gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Mon, Mar 27, 2023 at 03:10:22PM +0300, Eduard Zingerman escreveu:
> On Mon, 2023-03-27 at 08:46 -0300, Arnaldo Carvalho de Melo wrote:
> > Em Wed, Mar 15, 2023 at 01:04:13AM +0200, Eduard Zingerman escreveu:
> > > The following example contains a structure field annotated with
> > > btf_type_tag attribute:
> > > 
> > >     #define __tag1 __attribute__((btf_type_tag("tag1")))
> > > 
> > >     struct st {
> > >       int __tag1 *a;
> > >     } g;
> > > 
> > > It is not printed correctly by `pahole -F dwarf` command:
> > > 
> > >     $ clang -g -c test.c -o test.o
> > >     pahole -F dwarf test.o
> > >     struct st {
> > >     	tag1 *                     a;                    /*     0     8 */
> > >     	...
> > >     };
> > > 
> > > Note the type for variable `a`: `tag1` is printed instead of `int`.
> > > This commit teaches `type__fprintf()` and `__tag_name()` logic to skip
> > > `DW_TAG_LLVM_annotation` objects that are used to encode type tags.
> > 
> > I'm applying this now to make progress on this front, but longer term we
> > should printf it too, as we want the output to match the original source
> > code as much as possible from the type information.
> 
> Understood, thank you.
> 
> Also, I want to give a heads-up about ongoing discussion in:
> https://reviews.llvm.org/D143967
> 
> The gist of the discussion is that for the code like:
> 
>   volatile __tag("foo") int;
>   
> Kernel expects BTF to be:
> 
>   __tag("foo") -> volatile -> int
>   
> And I encode it in DWARF as:
> 
>   volatile       -> int
>     __tag("foo")
>     
> But GCC guys argue that DWARF should be like this:
> 
>   volatile       -> int
>                       __tag("foo")
> 
> So, to get the BTF to a form acceptable for kernel some additional
> pahole modifications might be necessary. (I will work on a prototype
> for such modifications this week).
> 
> Maybe put this patch-set on-hold until that is resolved?

Ok, so I'll apply just the first two, to get btfdiff a down to those
zero sized arrays when processing clang generated DWARF for a recent
kernel, see below.

Ok?

- A rnaldo

⬢[acme@toolbox pahole]$ git log --oneline -5
b43651673676c1dc (HEAD -> master) btf_loader: A hack for BTF import of btf_type_tag attributes
e7fb771f2649fc1b fprintf: Correct names for types with btf_type_tag attribute
4d17096076b2351f (quaco/master, quaco/HEAD, github/tmp.master, github/next, acme/tmp.master, acme/next) btf_encoder: Compare functions via prototypes not parameter names
82730394195276ac fprintf: Support skipping modifier
d184aaa125ea40ff fprintf: Generalize function prototype print to support passing conf
⬢[acme@toolbox pahole]$

⬢[acme@toolbox pahole]$ btfdiff ../vmlinux-clang-pahole-1.25+rust
die__process_class: tag not supported 0x2f (template_type_parameter)!
die__process_class: tag not supported 0x33 (variant_part)!
--- /tmp/btfdiff.dwarf.EiDOTz	2023-03-28 09:38:09.283942846 -0300
+++ /tmp/btfdiff.btf.rWM9v6	2023-03-28 09:38:09.624952028 -0300
@@ -14496,7 +14496,7 @@ struct bpf_cand_cache {
 	struct {
 		const struct btf  * btf;                 /*    16     8 */
 		u32                id;                   /*    24     4 */
-	} cands[0]; /*    16     0 */
+	} cands[]; /*    16     0 */

 	/* size: 16, cachelines: 1, members: 5 */
 	/* last cacheline: 16 bytes */
@@ -18310,7 +18310,7 @@ struct btf_id_set8 {
 	struct {
 		u32                id;                   /*     8     4 */
 		u32                flags;                /*    12     4 */
-	} pairs[0]; /*     8     0 */
+	} pairs[]; /*     8     0 */

 	/* size: 8, cachelines: 1, members: 3 */
 	/* last cacheline: 8 bytes */
@@ -27765,7 +27765,7 @@ struct cpu_rmap {
 	struct {
 		u16                index;                /*    16     2 */
 		u16                dist;                 /*    18     2 */
-	} near[0]; /*    16     0 */
+	} near[]; /*    16     0 */

 	/* size: 16, cachelines: 1, members: 5 */
 	/* last cacheline: 16 bytes */
@@ -73931,7 +73931,7 @@ struct linux_efi_memreserve {
 	struct {
 		phys_addr_t        base;                 /*    16     8 */
 		phys_addr_t        size;                 /*    24     8 */
-	} entry[0]; /*    16     0 */
+	} entry[]; /*    16     0 */

 	/* size: 16, cachelines: 1, members: 4 */
 	/* last cacheline: 16 bytes */
@@ -84345,7 +84345,7 @@ struct netlink_policy_dump_state {
 	struct {
 		const struct nla_policy  * policy;       /*    16     8 */
 		unsigned int       maxtype;              /*    24     4 */
-	} policies[0]; /*    16     0 */
+	} policies[]; /*    16     0 */

 	/* size: 16, cachelines: 1, members: 4 */
 	/* sum members: 12, holes: 1, sum holes: 4 */
@@ -139178,7 +139178,7 @@ struct uv_rtc_timer_head {
 		/* XXX 4 bytes hole, try to pack */

 		u64                expires;              /*    24     8 */
-	} cpu[0]; /*    16     0 */
+	} cpu[]; /*    16     0 */

 	/* size: 16, cachelines: 1, members: 4 */
 	/* sum members: 12, holes: 1, sum holes: 4 */
⬢[acme@toolbox pahole]$
