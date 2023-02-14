Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5E2D696F3A
	for <lists+bpf@lfdr.de>; Tue, 14 Feb 2023 22:22:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbjBNVWe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Feb 2023 16:22:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232731AbjBNVWd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Feb 2023 16:22:33 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 639892CFDA;
        Tue, 14 Feb 2023 13:22:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EBF9E618F8;
        Tue, 14 Feb 2023 21:22:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E5DFC433EF;
        Tue, 14 Feb 2023 21:22:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676409747;
        bh=bYe8rrZ1rbBD/IbQe04ZfQjsyfd6nLIbuiuyEu57Oyc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LKTtNK7AB5jEmFrBgNp2s5kn+lbORoKQxpEgXNhy9wQz12ze9kEyvNXF4dMFQLaw/
         hUn8yTp1ABzpw/wvTUxEQPbwcR0fq7hCVQ5Y4L7QIZI0xrGjYwZlScousNJQohsl1T
         bTG9Z6oewieJvNk9n3Bsf9zGH0MHnRGtLEnqj77A64Hxul3fF/KbH2H97TGl4NI7w1
         B1Lf5dI8UBI0pZ+FEXtUihYXiWIfQdwXwQzDXgMK6ViSfMSexJWqVfmxqMe7rq14wa
         3epF9r33lCaa/pUuH+QSnx/ChO6VQjtkwZX+wHs3h/F+jfKxtvSCtpWJ9Tj2OMdkxv
         S8jAtJ0PQ4IBA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 14BAC40025; Tue, 14 Feb 2023 18:22:24 -0300 (-03)
Date:   Tue, 14 Feb 2023 18:22:24 -0300
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
Subject: Re: [PATCH 1/1] pahole/Rust: Check that we're adding DW_TAG_member
 sorted by byte offset
Message-ID: <Y+v7kNNoRC2ql/a0@kernel.org>
References: <20230111152050.559334-1-yakoyoku@gmail.com>
 <aaf97a61-73c9-ff90-422d-9f3a79b0acd6@iogearbox.net>
 <CANiq72m+8D8OGtkyEjmyqCynp48DCKEw4-zLZ4pm6-OmFe4p1w@mail.gmail.com>
 <bec74b32-e35f-9489-4748-cbb241b31be7@iogearbox.net>
 <CANiq72nLrUTcQ+Gx6FTBtOR7+Ad2cNAC-0dEE7mUdk7nQ8T6ag@mail.gmail.com>
 <Y+atpJV5rqo08dQJ@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+atpJV5rqo08dQJ@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Fri, Feb 10, 2023 at 05:48:36PM -0300, Arnaldo Carvalho de Melo escreveu:
> Hi Miguel, after a long winter, I'm trying to get Rust properly
> supported on pahole, please check that this specific use case is working
> for you as well.
> 
> I'll go thru the others to see if they are easy (or at least restricted
> to Rust CUs) as this one.

I needed to add this one on top:

From 1231b6b9b4d88e0084bef4254eb1a05eb9935c99 Mon Sep 17 00:00:00 2001
From: Arnaldo Carvalho de Melo <acme@redhat.com>
Date: Tue, 14 Feb 2023 18:13:59 -0300
Subject: [PATCH 1/1] dwarf_loader: Fix sorting of Rust structs

We may have structs with fields on the same offset, don't move anything
in that case, otherwise we get into an eternal loop, doh.

Tested with the Linux kernel built with CONFIG_RUST + all the code
examples, first Rust struct where this happened was:

  (gdb) p type->namespace.name
  $2 = 0x7fffda938497 "((), char)"
  (gdb) p type->nr_members
  $3 = 2
  (gdb) p current_member->name
  $4 = 0x7fffda918f36 "__1"
  (gdb) p next_member->name
  $5 = 0x7fffda91765c "__0"
  (gdb) p current_member->byte_offset
  $6 = 0
  (gdb) p next_member->byte_offset
  $7 = 0

But this shows that --lang_exclude should be better positioned as we're
now needlessly loading all the tags for Rust DWARF to then just trow it
away at the cu__filter() in pahole :-\

Too late in the 1.25 release cycle for that, optimize it in 1.26.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 dwarf_loader.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/dwarf_loader.c b/dwarf_loader.c
index a77598dc3affca88..acdb68d5dd33f148 100644
--- a/dwarf_loader.c
+++ b/dwarf_loader.c
@@ -2857,7 +2857,7 @@ restart:
 
 		struct class_member *next_member = list_entry(current_member->tag.node.next, typeof(*current_member), tag.node);
 
-		if (current_member->byte_offset < next_member->byte_offset)
+		if (current_member->byte_offset <= next_member->byte_offset)
 			continue;
 
 		list_del(&current_member->tag.node);
-- 
2.39.1

