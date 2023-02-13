Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CB966952A6
	for <lists+bpf@lfdr.de>; Mon, 13 Feb 2023 22:05:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229462AbjBMVFx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 Feb 2023 16:05:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjBMVFw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 13 Feb 2023 16:05:52 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B166D1C5A6;
        Mon, 13 Feb 2023 13:05:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8DE63612B4;
        Mon, 13 Feb 2023 21:05:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DBF3C433D2;
        Mon, 13 Feb 2023 21:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676322316;
        bh=yUidYxyfTaXEBCaGPjAdgcyqWYF1axurdRo/rwGZXQk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JASPAg++4l2MNkkrYMBSyGeEHmCSi71e/k7jdWp0Im0sNAna5Tu3WtVwD74kHI+M+
         1znmwkQA6qhfJGuaP0Bs+Tqv/q3b0z0P7BRlaDXe/9XRqiETj365yD7PO68StYJq6K
         M8bd+ArNO23ZwPzXvx9UKLjjVlP5agzoD8zXzn1AzudIbAfWOjFbiwSKCtKUvDnXmT
         zLBUt2E2qGz0LqMDrck7e1EDzMTpzzja95jyehVK85fLmPoqwy2l8/RGHr9ljOeci3
         8/9WjFjLgYXMz6MN7wrJdNZdKUOawqtHIYOQEiKemN+QvzZZwxI4dsLD8uKAduqkAE
         60Fk+dvE4ra8w==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 37A5C40025; Mon, 13 Feb 2023 18:05:13 -0300 (-03)
Date:   Mon, 13 Feb 2023 18:05:13 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
        linux-kernel@vger.kernel.org, Neal Gompa <neal@gompa.dev>,
        Eric Curtin <ecurtin@redhat.com>, bpf@vger.kernel.org,
        rust-for-linux@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Yonghong Song <yhs@fb.com>,
        Martin =?utf-8?B?TGnFoWth?= <mliska@suse.cz>
Subject: Re: pahole issues with Rust DWARF was: Re: [PATCH 1/1] pahole/Rust:
 Check that we're adding DW_TAG_member sorted by byte offset
Message-ID: <Y+qmCaNHJFhd9B1v@kernel.org>
References: <20230111152050.559334-1-yakoyoku@gmail.com>
 <aaf97a61-73c9-ff90-422d-9f3a79b0acd6@iogearbox.net>
 <CANiq72m+8D8OGtkyEjmyqCynp48DCKEw4-zLZ4pm6-OmFe4p1w@mail.gmail.com>
 <bec74b32-e35f-9489-4748-cbb241b31be7@iogearbox.net>
 <CANiq72nLrUTcQ+Gx6FTBtOR7+Ad2cNAC-0dEE7mUdk7nQ8T6ag@mail.gmail.com>
 <Y+atpJV5rqo08dQJ@kernel.org>
 <Y+oofL/aJmUjcxIR@kernel.org>
 <CANiq72=Ghy2awR_+DACyiq_DAtscx3yoKb4tJ+GkpqVCcV_HEQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72=Ghy2awR_+DACyiq_DAtscx3yoKb4tJ+GkpqVCcV_HEQ@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Mon, Feb 13, 2023 at 01:45:02PM +0100, Miguel Ojeda escreveu:
> On Mon, Feb 13, 2023 at 1:09 PM Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com> wrote:
> > The namespace.o seems to be ok:
 
> I saw the other message too -- this looks great, thanks a ton.
 
> > The core one needs work:
 
> If `core.o` works, then I think it is likely other things will work :)
 
> I can try to extract the cases for those into simpler `.o` files, if
> you would find simpler test cases useful (perhaps for the test suite
> etc.).

That would be great!

I tried starting this path with this, spitted out by ChatGPT (minus the
'pub' in from of main):

⬢[acme@toolbox pahole-rust-cases]$ cat template_type.rs
// Provided by ChatGPT

use std::ops::Add;

// Define a generic struct template with a single type parameter `T`.
struct Point<T> {
    x: T,
    y: T,
}

// Implement a method for the `Point` struct that adds two points together.
// The method uses the `Add` trait to ensure that the type `T` supports addition.
impl<T: Add<Output=T>> Point<T> {
    fn add_points(self, other: Point<T>) -> Point<T> {
        Point {
            x: self.x + other.x,
            y: self.y + other.y,
        }
    }
}

pub fn main() {
    // Create two `Point` instances, using `i32` as the type parameter.
    let p1 = Point { x: 1, y: 2 };
    let p2 = Point { x: 3, y: 4 };

    // Add the two points together using the `add_points` method.
    let p3 = p1.add_points(p2);

    // Print the result.
    println!("Point: ({}, {})", p3.x, p3.y);
}
⬢[acme@toolbox pahole-rust-cases]$

And then handle the DW_TAG_template_type_parameter for a
DW_TAG_subroutine:

 <3><12d>: Abbrev Number: 5 (DW_TAG_structure_type)
    <12e>   DW_AT_name        : (indirect string, offset: 0x299): ArgumentV1
    <132>   DW_AT_byte_size   : 16
    <133>   DW_AT_alignment   : 8
 <4><134>: Abbrev Number: 6 (DW_TAG_member)
    <135>   DW_AT_name        : (indirect string, offset: 0xd7): value
    <139>   DW_AT_type        : <0x43a>
    <13d>   DW_AT_alignment   : 8
    <13e>   DW_AT_data_member_location: 0
 <4><13f>: Abbrev Number: 6 (DW_TAG_member)
    <140>   DW_AT_name        : (indirect string, offset: 0x10e): formatter
    <144>   DW_AT_type        : <0x447>
    <148>   DW_AT_alignment   : 8
    <149>   DW_AT_data_member_location: 8
 <4><14a>: Abbrev Number: 11 (DW_TAG_subprogram)
    <14b>   DW_AT_linkage_name: (indirect string, offset: 0x2a8): _ZN4core3fmt10ArgumentV13new17h167b8c43a2ee7614E
    <14f>   DW_AT_name        : (indirect string, offset: 0x2d9): new<i32>
    <153>   DW_AT_decl_file   : 2
    <154>   DW_AT_decl_line   : 333
    <156>   DW_AT_type        : <0x12d>
    <15a>   DW_AT_inline      : 1       (inlined)
 <5><15b>: Abbrev Number: 12 (DW_TAG_template_type_param)
    <15c>   DW_AT_type        : <0x4e3>
    <160>   DW_AT_name        : (indirect string, offset: 0x125): T
 <5><164>: Abbrev Number: 13 (DW_TAG_variable)

I'll have to stop now, but was at the point of changing ftype__fprintf()
somehow to show that template type parameter, with the patch at the end
of this message I get this:

⬢[acme@toolbox pahole]$ pahole --show_private_classes ../pahole-rust-cases/template_type.o
die__process_class: tag not supported 0x33 (variant_part)!
die__process_class: tag not supported 0x2f (template_type_parameter)!
struct Argument {
	usize                      position __attribute__((__aligned__(8))); /*     0     8 */
	struct FormatSpec          format __attribute__((__aligned__(8))); /*     8    48 */

	/* XXX last struct has 7 bytes of padding */

	/* size: 56, cachelines: 1, members: 2 */
	/* paddings: 1, sum paddings: 7 */
	/* forced alignments: 2 */
	/* last cacheline: 56 bytes */
} __attribute__((__aligned__(8)));
struct FormatSpec {
	struct Count               precision __attribute__((__aligned__(8))); /*     0    16 */

	/* XXX last struct has 16 bytes of padding */

	struct Count               width __attribute__((__aligned__(8))); /*    16    16 */

	/* XXX last struct has 16 bytes of padding */

	char                       fill __attribute__((__aligned__(4))); /*    32     4 */
	u32                        flags __attribute__((__aligned__(4))); /*    36     4 */
	enum Alignment             align __attribute__((__aligned__(1))); /*    40     1 */

	/* size: 48, cachelines: 1, members: 5 */
	/* padding: 7 */
	/* paddings: 2, sum paddings: 32 */
	/* forced alignments: 5 */
	/* last cacheline: 48 bytes */
} __attribute__((__aligned__(8)));
struct Is {

	/* XXX 8 bytes hole, try to pack */

	usize                      __0 __attribute__((__aligned__(8))); /*     8     8 */

	/* size: 16, cachelines: 1, members: 1 */
	/* sum members: 8, holes: 1, sum holes: 8 */
	/* forced alignments: 1, forced holes: 1, sum forced holes: 8 */
	/* last cacheline: 16 bytes */
} __attribute__((__aligned__(8)));
struct Param {

	/* XXX 8 bytes hole, try to pack */

	usize                      __0 __attribute__((__aligned__(8))); /*     8     8 */

	/* size: 16, cachelines: 1, members: 1 */
	/* sum members: 8, holes: 1, sum holes: 8 */
	/* forced alignments: 1, forced holes: 1, sum forced holes: 8 */
	/* last cacheline: 16 bytes */
} __attribute__((__aligned__(8)));
struct Implied {

	/* size: 16, cachelines: 1, members: 0 */
	/* padding: 16 */
	/* last cacheline: 16 bytes */
} __attribute__((__aligned__(8)));
struct Count {

	/* size: 16, cachelines: 1, members: 0 */
	/* padding: 16 */
	/* last cacheline: 16 bytes */
} __attribute__((__aligned__(8)));
struct ArgumentV1 {
	struct Opaque *            value __attribute__((__aligned__(8))); /*     0     8 */
	struct Result<(), core::fmt::Error> (*formatter)(struct Opaque *, struct Formatter *) __attribute__((__aligned__(8))); /*     8     8 */

	/* size: 16, cachelines: 1, members: 2 */
	/* forced alignments: 2 */
	/* last cacheline: 16 bytes */
} __attribute__((__aligned__(8)));
struct Opaque {

	/* size: 0, cachelines: 0, members: 0 */
} __attribute__((__aligned__(1)));
struct Error {

	/* size: 0, cachelines: 0, members: 0 */
} __attribute__((__aligned__(1)));
struct Formatter {
	struct Option<usize>       width __attribute__((__aligned__(8))); /*     0    16 */

	/* XXX last struct has 16 bytes of padding */

	struct Option<usize>       precision __attribute__((__aligned__(8))); /*    16    16 */

	/* XXX last struct has 16 bytes of padding */

	struct &mut dyn core::fmt::Write buf __attribute__((__aligned__(8))); /*    32    16 */
	u32                        flags __attribute__((__aligned__(4))); /*    48     4 */
	char                       fill __attribute__((__aligned__(4))); /*    52     4 */
	enum Alignment             align __attribute__((__aligned__(1))); /*    56     1 */

	/* size: 64, cachelines: 1, members: 6 */
	/* padding: 7 */
	/* paddings: 2, sum paddings: 32 */
	/* forced alignments: 6 */
} __attribute__((__aligned__(8)));
struct Arguments {
	struct &[&str]             pieces __attribute__((__aligned__(8))); /*     0    16 */
	struct Option<&[core::fmt::rt::v1::Argument]> fmt __attribute__((__aligned__(8))); /*    16    16 */

	/* XXX last struct has 16 bytes of padding */

	struct &[core::fmt::ArgumentV1] args __attribute__((__aligned__(8))); /*    32    16 */

	/* size: 48, cachelines: 1, members: 3 */
	/* paddings: 1, sum paddings: 16 */
	/* forced alignments: 3 */
	/* last cacheline: 48 bytes */
} __attribute__((__aligned__(8)));
struct Ok {

	/* XXX 1 byte hole, try to pack */

	()                         __0 __attribute__((__aligned__(1))); /*     1     0 */

	/* size: 1, cachelines: 1, members: 1 */
	/* forced alignments: 1, forced holes: 1, sum forced holes: 1 */
	/* last cacheline: 1 bytes */
} __attribute__((__aligned__(1)));
struct Err {

	/* XXX 1 byte hole, try to pack */

	struct Error               __0 __attribute__((__aligned__(1))); /*     1     0 */

	/* size: 1, cachelines: 1, members: 1 */
	/* forced alignments: 1, forced holes: 1, sum forced holes: 1 */
	/* last cacheline: 1 bytes */
} __attribute__((__aligned__(1)));
struct Result<(), core::fmt::Error> {

	/* size: 1, cachelines: 0, members: 0 */
	/* padding: 1 */
	/* last cacheline: 1 bytes */
} __attribute__((__aligned__(1)));
struct None {

	/* size: 16, cachelines: 1, members: 0 */
	/* padding: 16 */
	/* last cacheline: 16 bytes */
} __attribute__((__aligned__(8)));
struct Some {

	/* XXX 8 bytes hole, try to pack */

	usize                      __0 __attribute__((__aligned__(8))); /*     8     8 */

	/* size: 16, cachelines: 1, members: 1 */
	/* sum members: 8, holes: 1, sum holes: 8 */
	/* forced alignments: 1, forced holes: 1, sum forced holes: 8 */
	/* last cacheline: 16 bytes */
} __attribute__((__aligned__(8)));
struct Option<usize> {

	/* size: 16, cachelines: 1, members: 0 */
	/* padding: 16 */
	/* last cacheline: 16 bytes */
} __attribute__((__aligned__(8)));
struct Some {
	struct &[core::fmt::rt::v1::Argument] __0 __attribute__((__aligned__(8))); /*     0    16 */

	/* size: 16, cachelines: 1, members: 1 */
	/* forced alignments: 1 */
	/* last cacheline: 16 bytes */
} __attribute__((__aligned__(8)));
struct Option<&[core::fmt::rt::v1::Argument]> {

	/* size: 16, cachelines: 1, members: 0 */
	/* padding: 16 */
	/* last cacheline: 16 bytes */
} __attribute__((__aligned__(8)));
struct &mut dyn core::fmt::Write {
	struct dyn core::fmt::Write * pointer __attribute__((__aligned__(8))); /*     0     8 */
	usize *                    vtable __attribute__((__aligned__(8))); /*     8     8 */

	/* size: 16, cachelines: 1, members: 2 */
	/* forced alignments: 2 */
	/* last cacheline: 16 bytes */
} __attribute__((__aligned__(8)));
struct dyn core::fmt::Write {

	/* size: 0, cachelines: 0, members: 0 */
} __attribute__((__aligned__(1)));
struct &[&str] {
	struct &str *              data_ptr __attribute__((__aligned__(8))); /*     0     8 */
	usize                      length __attribute__((__aligned__(8))); /*     8     8 */

	/* size: 16, cachelines: 1, members: 2 */
	/* forced alignments: 2 */
	/* last cacheline: 16 bytes */
} __attribute__((__aligned__(8)));
struct &str {
	u8 *                       data_ptr __attribute__((__aligned__(8))); /*     0     8 */
	usize                      length __attribute__((__aligned__(8))); /*     8     8 */

	/* size: 16, cachelines: 1, members: 2 */
	/* forced alignments: 2 */
	/* last cacheline: 16 bytes */
} __attribute__((__aligned__(8)));
struct &[core::fmt::rt::v1::Argument] {
	struct Argument *          data_ptr __attribute__((__aligned__(8))); /*     0     8 */
	usize                      length __attribute__((__aligned__(8))); /*     8     8 */

	/* size: 16, cachelines: 1, members: 2 */
	/* forced alignments: 2 */
	/* last cacheline: 16 bytes */
} __attribute__((__aligned__(8)));
struct &[core::fmt::ArgumentV1] {
	struct ArgumentV1 *        data_ptr __attribute__((__aligned__(8))); /*     0     8 */
	usize                      length __attribute__((__aligned__(8))); /*     8     8 */

	/* size: 16, cachelines: 1, members: 2 */
	/* forced alignments: 2 */
	/* last cacheline: 16 bytes */
} __attribute__((__aligned__(8)));
struct Point<i32> {
	i32                        x __attribute__((__aligned__(4))); /*     0     4 */
	i32                        y __attribute__((__aligned__(4))); /*     4     4 */

	/* size: 8, cachelines: 1, members: 2 */
	/* forced alignments: 2 */
	/* last cacheline: 8 bytes */
} __attribute__((__aligned__(4)));
⬢[acme@toolbox pahole]$

I'll cut version 1.25 with what is in the 'master' and 'next' now as
binutils 2.40 is out and emitting DW_TAG_unspecified_type, that isn't
supported by pahole 1.24 and also Alan's work on optimized functions,
etc.

- Arnaldo

diff --git a/dwarf_loader.c b/dwarf_loader.c
index a77598dc3affca88..b767bcaa9322c95a 100644
--- a/dwarf_loader.c
+++ b/dwarf_loader.c
@@ -1093,6 +1093,18 @@ static struct parameter *parameter__new(Dwarf_Die *die, struct cu *cu,
 	return parm;
 }
 
+static struct template_type_parameter *template_type_parameter__new(Dwarf_Die *die, struct cu *cu, struct conf_load *conf)
+{
+	struct template_type_parameter *parm = tag__alloc(cu, sizeof(*parm));
+
+	if (parm != NULL) {
+		tag__init(&parm->tag, cu, die);
+		parm->name = attr_string(die, DW_AT_name, conf);
+	}
+
+	return parm;
+}
+
 static struct inline_expansion *inline_expansion__new(Dwarf_Die *die, struct cu *cu, struct conf_load *conf)
 {
 	struct inline_expansion *exp = tag__alloc(cu, sizeof(*exp));
@@ -1211,6 +1223,7 @@ static void ftype__init(struct ftype *ftype, Dwarf_Die *die, struct cu *cu)
 #endif
 	tag__init(&ftype->tag, cu, die);
 	INIT_LIST_HEAD(&ftype->parms);
+	INIT_LIST_HEAD(&ftype->template_type_parms);
 	ftype->nr_parms	    = 0;
 	ftype->unspec_parms = 0;
 }
@@ -1566,6 +1579,19 @@ static struct tag *die__create_new_parameter(Dwarf_Die *die,
 	return &parm->tag;
 }
 
+static struct tag *die__create_new_template_type_parameter(Dwarf_Die *die, struct ftype *ftype,
+							   struct cu *cu, struct conf_load *conf)
+{
+	struct template_type_parameter *parm = template_type_parameter__new(die, cu, conf);
+
+	if (parm == NULL)
+		return NULL;
+
+	ftype__add_template_type_parameter(ftype, parm);
+
+	return &parm->tag;
+}
+
 static struct tag *die__create_new_label(Dwarf_Die *die,
 					 struct lexblock *lexblock,
 					 struct cu *cu, struct conf_load *conf)
@@ -1989,6 +2015,8 @@ static int die__process_function(Dwarf_Die *die, struct ftype *ftype,
 		case DW_TAG_GNU_template_template_param:
 #endif
 		case DW_TAG_template_type_parameter:
+			tag = die__create_new_template_type_parameter(die, ftype, cu, conf);
+			break;
 		case DW_TAG_template_value_parameter:
 			/* FIXME: probably we'll have to attach this as a list of
  			 * template parameters to use at class__fprintf time... 
diff --git a/dwarves.c b/dwarves.c
index b43031c93c5cab58..6a8feccc2d45c60d 100644
--- a/dwarves.c
+++ b/dwarves.c
@@ -1391,6 +1391,12 @@ void ftype__add_parameter(struct ftype *ftype, struct parameter *parm)
 	list_add_tail(&parm->tag.node, &ftype->parms);
 }
 
+void ftype__add_template_type_parameter(struct ftype *ftype, struct template_type_parameter *parm)
+{
+	++ftype->nr_template_type_parms;
+	list_add_tail(&parm->tag.node, &ftype->template_type_parms);
+}
+
 void lexblock__add_tag(struct lexblock *block, struct tag *tag)
 {
 	list_add_tail(&tag->node, &block->tags);
diff --git a/dwarves.h b/dwarves.h
index 24a1909a60389dee..5c9952bfddaed301 100644
--- a/dwarves.h
+++ b/dwarves.h
@@ -825,13 +825,30 @@ static inline const char *parameter__name(const struct parameter *parm)
 	return parm->name;
 }
 
+struct template_type_parameter {
+	struct tag tag;
+	const char *name;
+};
+
+static inline struct template_type_parameter *tag__template_type_parameter(const struct tag *tag)
+{
+	return (struct template_type_parameter *)tag;
+}
+
+static inline const char *template_type_parameter__name(const struct template_type_parameter *parm)
+{
+	return parm->name;
+}
+
 /*
  * tag.tag can be DW_TAG_subprogram_type or DW_TAG_subroutine_type.
  */
 struct ftype {
 	struct tag	 tag;
 	struct list_head parms;
+	struct list_head template_type_parms;
 	uint16_t	 nr_parms;
+	uint16_t	 nr_template_type_parms;
 	uint8_t		 unspec_parms:1; /* just one bit is needed */
 	uint8_t		 optimized_parms:1;
 	uint8_t		 processed:1;
@@ -872,6 +889,8 @@ void ftype__delete(struct ftype *ftype);
 	list_for_each_entry_safe_reverse(pos, n, &(ftype)->parms, tag.node)
 
 void ftype__add_parameter(struct ftype *ftype, struct parameter *parm);
+void ftype__add_template_type_parameter(struct ftype *ftype, struct template_type_parameter *parm);
+
 size_t ftype__fprintf(const struct ftype *ftype, const struct cu *cu,
 		      const char *name, const int inlined,
 		      const int is_pointer, const int type_spacing, bool is_prototype,
