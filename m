Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ED165606C5
	for <lists+bpf@lfdr.de>; Wed, 29 Jun 2022 18:56:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbiF2Q4U (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 29 Jun 2022 12:56:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbiF2Q4U (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 29 Jun 2022 12:56:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C4902250C;
        Wed, 29 Jun 2022 09:56:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2D904B81F16;
        Wed, 29 Jun 2022 16:56:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC169C34114;
        Wed, 29 Jun 2022 16:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656521776;
        bh=Se6NFgyiC4GcUPYnrSqtoRQ3Op0cRWCNFQsoCe38huo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JypqSwVlAQWeU11KSHD+K1HglvBSV7QT5NjTHhlSWtFlE7rtW9kx2ZLKCaz/3i8I0
         hpDD7fUaLfcRiG8m9UCc7jTlbYac2MUOi6gXAx2xnuFt22u7Gm+QYpcDfOjbXbPrCK
         p0ueGSgjVVMe3awHNHeaPuGB2OG0nLtHPfT8TJ5zVCF9LKtqr3mPOGihMMJHraY8m6
         gszT8tKPpuvWWLHMCFtbagtltg6ku2SKOCxjbUWRQmZnxLZl4uMZCYXmmd5sh4oBxA
         EqCD+k9ApdL8d3aRxZKru10ikDWNbW3NDUVbeKQinQ7Weisxb10yv+JzXnOlEtCekO
         oDNhgzac6l6OA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id CDCBD4096F; Wed, 29 Jun 2022 13:56:13 -0300 (-03)
Date:   Wed, 29 Jun 2022 13:56:13 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Yonghong Song <yhs@fb.com>, Jiri Olsa <olsajiri@gmail.com>
Cc:     dwarves@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com
Subject: [PATCH] btf_loader: support BTF_KIND_ENUM64 was Re: [PATCH dwarves
 v2 0/2] btf: support BTF_KIND_ENUM64
Message-ID: <YryELT6OadpiJki/@kernel.org>
References: <20220615230306.851750-1-yhs@fb.com>
 <YrrPOFzYAGHm0oht@krava>
 <Yrx+Ehpc71/6WHVT@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Yrx+Ehpc71/6WHVT@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Wed, Jun 29, 2022 at 01:30:10PM -0300, Arnaldo Carvalho de Melo escreveu:
> ⬢[acme@toolbox pahole]$ pdwtags -F btf vmlinux-v5.18-rc7+ | grep -B10 -A5 BPF_F_CTXLEN_MASK
> BTF: idx: 4173, Unknown kind 19
> BTF: idx: 4975, Unknown kind 19
> BTF: idx: 6673, Unknown kind 19
> BTF: idx: 27413, Unknown kind 19
> BTF: idx: 30626, Unknown kind 19
> BTF: idx: 30829, Unknown kind 19
> BTF: idx: 38040, Unknown kind 19
> BTF: idx: 56969, Unknown kind 19
> BTF: idx: 83004, Unknown kind 19
> ⬢[acme@toolbox pahole]$
> 
> Ok, I need to update pahole's BTF loader to support:
> 
> lib/bpf/src/btf.h:#define BTF_KIND_ENUM64		19	/* Enum for up-to 64bit values */
> 
> 
> Working on it now.

⬢[acme@toolbox pahole]$ pdwtags -F btf vmlinux-v5.18-rc7+ | grep -B5 -A5 BPF_F_CTXLEN_MASK

/* 27413 */
enum {
	BPF_F_INDEX_MASK  = 4294967295,
	BPF_F_CURRENT_CPU = 4294967295,
	BPF_F_CTXLEN_MASK = 4503595332403200,
} __attribute__((__packed__)); /* size: 8 */

/* 27414 */
enum {
	BPF_F_GET_BRANCH_RECORDS_SIZE = 1,
⬢[acme@toolbox pahole]$

Quick patch here, please Ack, if possible:

diff --git a/btf_loader.c b/btf_loader.c
index b5d444643adf30b1..e57ecce2cde26e4e 100644
--- a/btf_loader.c
+++ b/btf_loader.c
@@ -312,6 +312,49 @@ out_free:
 	return -ENOMEM;
 }
 
+static struct enumerator *enumerator__new64(const char *name, uint64_t value)
+{
+	struct enumerator *en = tag__alloc(sizeof(*en));
+
+	if (en != NULL) {
+		en->name = name;
+		en->value = value; // Value is already 64-bit, as this is used with DWARF as well
+		en->tag.tag = DW_TAG_enumerator;
+	}
+
+	return en;
+}
+
+static int create_new_enumeration64(struct cu *cu, const struct btf_type *tp, uint32_t id)
+{
+	struct btf_enum64 *ep = btf_enum64(tp);
+	uint16_t i, vlen = btf_vlen(tp);
+	struct type *enumeration = type__new(DW_TAG_enumeration_type,
+					     cu__btf_str(cu, tp->name_off),
+					     tp->size ? tp->size * 8 : (sizeof(int) * 8));
+
+	if (enumeration == NULL)
+		return -ENOMEM;
+
+	for (i = 0; i < vlen; i++) {
+		const char *name = cu__btf_str(cu, ep[i].name_off);
+		uint64_t value = ((uint64_t)ep[i].val_hi32) << 32 | ep[i].val_lo32;
+		struct enumerator *enumerator = enumerator__new64(name, value);
+
+		if (enumerator == NULL)
+			goto out_free;
+
+		enumeration__add(enumeration, enumerator);
+	}
+
+	cu__add_tag_with_id(cu, &enumeration->namespace.tag, id);
+
+	return 0;
+out_free:
+	enumeration__delete(enumeration);
+	return -ENOMEM;
+}
+
 static int create_new_subroutine_type(struct cu *cu, const struct btf_type *tp, uint32_t id)
 {
 	struct ftype *proto = tag__alloc(sizeof(*proto));
@@ -419,6 +462,9 @@ static int btf__load_types(struct btf *btf, struct cu *cu)
 		case BTF_KIND_ENUM:
 			err = create_new_enumeration(cu, type_ptr, type_index);
 			break;
+		case BTF_KIND_ENUM64:
+			err = create_new_enumeration64(cu, type_ptr, type_index);
+			break;
 		case BTF_KIND_FWD:
 			err = create_new_forward_decl(cu, type_ptr, type_index);
 			break;
