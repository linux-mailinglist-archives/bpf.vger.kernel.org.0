Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 620636928A5
	for <lists+bpf@lfdr.de>; Fri, 10 Feb 2023 21:48:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233449AbjBJUso (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Feb 2023 15:48:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233044AbjBJUsm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 10 Feb 2023 15:48:42 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BCE47E8EF;
        Fri, 10 Feb 2023 12:48:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 173AE61E9F;
        Fri, 10 Feb 2023 20:48:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 210F6C433D2;
        Fri, 10 Feb 2023 20:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676062119;
        bh=+fgkUm0vl9CjZ8x/GwVY8bF0uT0e0hNkbSJWaJfo0eU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GSPSmtwGisUu3/b56ypj0AeAhwwjNqcX/mvBTM80UEQXkXTPwdQ0ESyXQyHh5RmMF
         SzR8MYbdNLAtYkLkxKqXSPZgdBHpWtPpUelhOmXT6+V9CvErAmQtAH93n3jNX5Mze6
         vVy70SgEo7zIdurlsPZIh6XlEnYPcJ2RByDnnEV0WuiQlrsoG4i64rZ14Ganm0XS8W
         /fDcxjWbBOEIOD8HSmlFAXxMBiYmMBMNWnDIFOgOdAAblTdcXSMI6eCfxoD+B+tGz1
         KPMyntcoBw6yg5L34yBbXD/BpeL2e75hO0GfPUBDFrF2zNJBtnNUSvUf9eY8LDk7GE
         0mC6ahfmeR/3Q==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 742C940025; Fri, 10 Feb 2023 17:48:36 -0300 (-03)
Date:   Fri, 10 Feb 2023 17:48:36 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
        linux-kernel@vger.kernel.org, Neal Gompa <neal@gompa.dev>,
        Eric Curtin <ecurtin@redhat.com>, bpf@vger.kernel.org,
        rust-for-linux@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Yonghong Song <yhs@fb.com>
Subject: [PATCH 1/1] pahole/Rust: Check that we're adding DW_TAG_member
 sorted by byte offset
Message-ID: <Y+atpJV5rqo08dQJ@kernel.org>
References: <20230111152050.559334-1-yakoyoku@gmail.com>
 <aaf97a61-73c9-ff90-422d-9f3a79b0acd6@iogearbox.net>
 <CANiq72m+8D8OGtkyEjmyqCynp48DCKEw4-zLZ4pm6-OmFe4p1w@mail.gmail.com>
 <bec74b32-e35f-9489-4748-cbb241b31be7@iogearbox.net>
 <CANiq72nLrUTcQ+Gx6FTBtOR7+Ad2cNAC-0dEE7mUdk7nQ8T6ag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANiq72nLrUTcQ+Gx6FTBtOR7+Ad2cNAC-0dEE7mUdk7nQ8T6ag@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Miguel, after a long winter, I'm trying to get Rust properly
supported on pahole, please check that this specific use case is working
for you as well.

I'll go thru the others to see if they are easy (or at least restricted
to Rust CUs) as this one.

Thanks,

- Arnaldo

---

Rust may reorder struct fields and pahole assumes them to be in order,
as is the case for languages like C and C++, etc. So after having the
class member bit and byte offsets sorted out, sort Rust CU types by
offset.

Using: https://github.com/Rust-for-Linux/pahole-rust-cases/blob/main/inverted.o

Before:

  $ pahole --show_private_classes ../pahole-rust-cases/inverted.o
  struct S {

  	/* XXX 4 bytes hole, try to pack */

  	bool                       a __attribute__((__aligned__(1))); /*     4     1 */

  	/* XXX 65531 bytes hole, try to pack */
  	/* Bitfield combined with previous fields */

  	u32                        b __attribute__((__aligned__(4))); /*     0     4 */

  	/* size: 8, cachelines: 1, members: 2 */
  	/* sum members: 5, holes: 2, sum holes: 65535 */
  	/* padding: 4 */
  	/* forced alignments: 2, forced holes: 2, sum forced holes: 65535 */
  	/* last cacheline: 8 bytes */

  	/* BRAIN FART ALERT! 8 bytes != 5 (member bytes) + 0 (member bits) + 65535 (byte holes) + 0 (bit holes), diff = -524288 bits */
  } __attribute__((__aligned__(4)));
  $

After:

  $ readelf -wi ../pahole-rust-cases/inverted.o | grep DW_TAG_compile_unit -A9
   <0><b>: Abbrev Number: 1 (DW_TAG_compile_unit)
      <c>   DW_AT_producer    : (indirect string, offset: 0x0): clang LLVM (rustc version 1.60.0 (7737e0b5c 2022-04-04))
      <10>   DW_AT_language    : 28	(Rust)
      <12>   DW_AT_name        : (indirect string, offset: 0x39): inverted.rs/@/inverted.c4dda47b-cgu.0
      <16>   DW_AT_stmt_list   : 0x0
      <1a>   DW_AT_comp_dir    : (indirect string, offset: 0x5f): /root/pahole-rust
      <1e>   DW_AT_GNU_pubnames: 1
      <1e>   DW_AT_low_pc      : 0x0
      <26>   DW_AT_high_pc     : 0x62
   <1><2a>: Abbrev Number: 2 (DW_TAG_namespace)
  $ pahole --show_private_classes ../pahole-rust-cases/inverted.o
  struct S {
  	u32                        b __attribute__((__aligned__(4))); /*     0     4 */
  	bool                       a __attribute__((__aligned__(1))); /*     4     1 */

  	/* size: 8, cachelines: 1, members: 2 */
  	/* padding: 3 */
  	/* forced alignments: 2 */
  	/* last cacheline: 8 bytes */
  } __attribute__((__aligned__(4)));
  $

  $ cp ../pahole-rust-cases/inverted.o .
  $ pahole --btf_encode inverted.o
  $ readelf -SW inverted.o  | grep -i BTF
    [26] .BTF              PROGBITS        0000000000000000 000922 00006c 00      0   0  1
  $
  $ pahole -F btf inverted.o
  struct S {
  	u32                        b;                    /*     0     4 */
  	bool                       a;                    /*     4     1 */

  	/* size: 8, cachelines: 1, members: 2 */
  	/* padding: 3 */
  	/* last cacheline: 8 bytes */
  };
  $

Reported-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Eric Curtin <ecurtin@redhat.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Cc: Neal Gompa <neal@gompa.dev>
Cc: Yonghong Song <yhs@fb.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 dwarf_loader.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/dwarf_loader.c b/dwarf_loader.c
index 253c5efaf3b55a93..a77598dc3affca88 100644
--- a/dwarf_loader.c
+++ b/dwarf_loader.c
@@ -2835,9 +2835,51 @@ static int class_member__cache_byte_size(struct tag *tag, struct cu *cu,
 	return 0;
 }
 
+static bool cu__language_reorders_offsets(const struct cu *cu)
+{
+	return cu->language == DW_LANG_Rust;
+}
+
+static int type__sort_by_offset(struct tag *tag, struct cu *cu, void *cookie __maybe_unused)
+{
+	if (!tag__is_type(tag))
+		return 0;
+
+	struct type *type = tag__type(tag);
+	struct class_member *current_member;
+
+	// There may be more than DW_TAG_members entries in the type tags, so do a simple
+	// bubble sort for now, so that the other non tags stay where they are.
+restart:
+	type__for_each_data_member(type, current_member) {
+		if (list_is_last(&current_member->tag.node, &type->namespace.tags))
+		       break;
+
+		struct class_member *next_member = list_entry(current_member->tag.node.next, typeof(*current_member), tag.node);
+
+		if (current_member->byte_offset < next_member->byte_offset)
+			continue;
+
+		list_del(&current_member->tag.node);
+		list_add(&current_member->tag.node, &next_member->tag.node);
+		goto restart;
+	}
+
+	return 0;
+}
+
+static void cu__sort_types_by_offset(struct cu *cu, struct conf_load *conf)
+{
+	cu__for_all_tags(cu, type__sort_by_offset, conf);
+}
+
 static int cu__finalize(struct cu *cu, struct conf_load *conf, void *thr_data)
 {
 	cu__for_all_tags(cu, class_member__cache_byte_size, conf);
+
+	if (cu__language_reorders_offsets(cu))
+		cu__sort_types_by_offset(cu, conf);
+
 	if (conf && conf->steal) {
 		return conf->steal(cu, conf, thr_data);
 	}
-- 
2.39.1

