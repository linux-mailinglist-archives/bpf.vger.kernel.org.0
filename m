Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFCE963B980
	for <lists+bpf@lfdr.de>; Tue, 29 Nov 2022 06:35:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235321AbiK2Ffh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 29 Nov 2022 00:35:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235244AbiK2Ffg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 29 Nov 2022 00:35:36 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 832D427CE1
        for <bpf@vger.kernel.org>; Mon, 28 Nov 2022 21:35:34 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id fy37so31087921ejc.11
        for <bpf@vger.kernel.org>; Mon, 28 Nov 2022 21:35:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mB6OsmrWqo7VQJ2Hn3m2viDJH3rUG3Muga1QgYFdY2A=;
        b=dXfgtXZjjFv3LFb0K/JYK59Vd36TSMq94DZMaT4upE9yS6VfjsPievZjI8kJUPAFCd
         L+DEyedQpvFYORaGvaFZmJhH25SXS8P70+g9Q+buemMWhFWcuQ+a7OADB+6h+J+0sDPx
         1Ar3dTsYCpoZ4kpNqXWSSPyexRAR9obAlY153GNglPjxJw3q4OI2UvROccH6Kre60VWI
         l2I4Wnxoj9oA2OYON564kOdQBrNNJCIwsdFttgJvKGmt8SOPlcrBAXlOsmcoPkBcHLhK
         AgPaCZtrfTx9zaKNXScz2ybGbzmLoIn3mTpFhDYwrEcjt0iP5yKnMtb5kio66dG47Qxy
         LKTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mB6OsmrWqo7VQJ2Hn3m2viDJH3rUG3Muga1QgYFdY2A=;
        b=0FJZQ5nvSKL3LOBtxQNQsxZlJsn7impbGZFAnrAJ+czNofS7duIaFa9SeH+lJ0cRqw
         tymlal20PMdud7c3uS6TPJQx+cRzLjScNL2EmDS5hi6Q3TbhSR0SzC77R7/tTgIqJFA/
         mJBFkNOdrTGhaSZZAAGDbuxpZh/bGFy58NNJaqYBwnNCC6cVOkCbV90Tm7PQdjnulIiy
         zREV2eaiQH0arK35iMgvwNQvhrv0yAH71k9MnVtMix0G68ZjML+nY0JWiQYgj/jchO7o
         p0nDdz9c4j3JBTDFIsYC8UIQ+DyAeiro/8SgbTMMDJWnVrajdBqPmBPJyUV3k160fOfj
         Upag==
X-Gm-Message-State: ANoB5pkKz9w+Ct+yl/aEnI/dchx/LEpMPk1zJpUA4j2NreHu+oWSI0l8
        /hCrFW9oAJtf5irTbLqYOPryPH7LmCU3lbY2Sd8=
X-Google-Smtp-Source: AA0mqf694Mxx65myGfIiM3gY6AlEElQh3pig++rI1Edwk1CbOk9Kh/UT8nEKoPMFvJqCg+KpkmejdALQkrW60Xo1t/M=
X-Received: by 2002:a17:906:180e:b0:7a2:6d38:1085 with SMTP id
 v14-20020a170906180e00b007a26d381085mr30550059eje.114.1669700132759; Mon, 28
 Nov 2022 21:35:32 -0800 (PST)
MIME-Version: 1.0
References: <1669225312-28949-1-git-send-email-alan.maguire@oracle.com> <1669225312-28949-3-git-send-email-alan.maguire@oracle.com>
In-Reply-To: <1669225312-28949-3-git-send-email-alan.maguire@oracle.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 28 Nov 2022 21:35:20 -0800
Message-ID: <CAEf4BzZtOUXxKurpmHzsZ+8FP6aahUNEmcPz=Rr=gkuQPu0yaA@mail.gmail.com>
Subject: Re: [RFC bpf-next 2/5] libbpf: provide libbpf API to encode BTF kind information
To:     Alan Maguire <alan.maguire@oracle.com>
Cc:     andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, mykolal@fb.com,
        haiyue.wang@intel.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Nov 23, 2022 at 9:42 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>
> This can be used by BTF parsers to handle kinds they do not know about;
> this is useful when the encoding libbpf is more recent than the parsing
> BTF; the parser can then skip over the encoded types it does not know
> about.
>
> We use BTF to encode the BTF kinds that are known at the time of
> BTF encoding; the use of basic BTF kinds (structs, arrays, base types)
> to describe each kind and any associated metadata allows BTF parsing
> to handle new kinds that the parser (in libbpf or the kernel) does
> not know about.  These kinds will not be used, but since we know
> their format they can be skipped over and the rest of the BTF can
> be parsed.  This means we can encode BTF without worrying about the
> kinds a BTF parser knows about, and means we can avoid using
> --skip_new_kind solutions.  This is valuable, as if kernel BTF encodes
> everything it can, something as simple as a libbpf package update
> then unlocks that encoded information, whereas if we encode
> pessimistically and drop representations of new kinds, this is not
> possible.
>
> So, in short, by carrying a representation of all the kinds encoded,
> parsers can parse all of the encoded kinds, even if they cannot use
> them all.
>
> We use BTF itself to carry this representation because this approach
> does not require BTF parsing to understand a new BTF header format;
> BTF parsing simply sees some additional types it does not do anything
> with.  However, a BTF parser that knows about the encoding of kind
> information can use this information to guide parsing.
>
> The process works by explicitly adding btf structs for each kind.
> Each struct consists of a "struct __btf_type" followed by an array of
> metadata structs representing the following metadata (for those kinds
> that have it).  For kinds where a single metadata structure is used,
> the metadata array has one element.  For kinds where the number
> of metadata elements varies as per the info.vlen field, a zero-element
> array is encoded.
>
> For a given kind, we add a struct __BTF_KIND_<kind>.  For example,
>
> struct __BTF_KIND_INT {
>         struct __btf_type type;
> };
>
> For a type with one metadata element, the representation looks like
> this:
>
> struct __BTF_KIND_META_ARRAY {
>         __u32 type;
>         __u32 index_type;
>         __u32 nelems;
> };
>
> struct __BTF_KIND_ARRAY {
>         struct __btf_type type;
>         struct __BTF_KIND_META_ARRAY meta[1];
> };
>
> For a type with an info.vlen-determined number of following metadata
> objects, a zero-length array is used:
>
> struct __BTF_KIND_STRUCT {
>         struct __btf_type type;
>         struct __BTF_KIND_META_STRUCT meta[0];
> };
>
> In order to link kind numeric kind values to the appropriate struct,
> a typedef is added; for example:
>
> typedef struct __BTF_KIND_INT __BTF_KIND_1;
>
> When BTF parsing encounters a kind that is not known, the
> typedef __BTF_KIND_<kind number> is looked up, and we find which
> struct type id it points to.  So
>
>         1 -> typedef __BTF_KIND_1 -> struct __BTF_KIND_INT
>
> This approach is preferred, since it ensures the structs representing
> BTF kinds have names which match their associated kind rather than
> an opaque number.
>
> From there, BTF parsing can look up that struct and determine
>         - its basic size;
>         - if it has metadata; and if so
>         - how many array instances are present;
>                 - if 0, we know it is a vlen-determined number;
>                   i.e. vlen * meta_size
>                 - if > 0, simply use the overall struct size;
>
> Based upon that information, BTF parsing can proceed for such
> unknown kinds, since sufficient information was provided
> at encoding time to skip over them.
>
> Note that this assumes that the above kind-related data
> structures are represented in BTF _prior_ to any kinds that
> are new to the parser.  It also assumes the basic kinds
> required to represent kinds + metadata; base types, structs,
> arrays, etc.
>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> ---
>  tools/lib/bpf/btf.c      | 281 +++++++++++++++++++++++++++++++++++++++++++++++
>  tools/lib/bpf/btf.h      |  10 ++
>  tools/lib/bpf/libbpf.map |   1 +
>  3 files changed, 292 insertions(+)
>
> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> index 71e165b..e3cea44 100644
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c
> @@ -28,6 +28,16 @@
>
>  static struct btf_type btf_void;
>
> +/* info used to encode/decode an unrecognized kind */
> +struct btf_kind_desc {
> +       int kind;
> +       const char *struct_name;        /* __BTF_KIND_ARRAY */
> +       const char *typedef_name;       /* __BTF_KIND_2 */
> +       const char *meta_name;          /* __BTF_KIND_META_ARRAY */
> +       int nr_meta;
> +       int meta_size;
> +};
> +
>  struct btf {
>         /* raw BTF data in native endianness */
>         void *raw_data;
> @@ -5011,3 +5021,274 @@ int btf_ext_visit_str_offs(struct btf_ext *btf_ext, str_off_visit_fn visit, void
>
>         return 0;
>  }
> +
> +/* Here we use BTF to encode the BTF kinds that are known at the time of
> + * BTF encoding; the use of basic BTF kinds (structs, arrays, base types)
> + * to describe each kind and any associated metadata allows BTF parsing
> + * to handle new kinds that the parser (in libbpf or the kernel) does
> + * not know about.  These kinds will not be used, but since we know
> + * their format they can be skipped over and the rest of the BTF can
> + * be parsed.  This means we can encode BTF without worrying about the
> + * kinds a BTF parser knows about, and means we can avoid using
> + * --skip_new_kind solutions.  This is valuable, as if kernel BTF encodes
> + * everything it can, something as simple as a libbpf package update
> + * then unlocks that encodeded information, whereas if we encode
> + * pessimistically and drop representations of new kinds, this is not
> + * possible.
> + *
> + * So, in short, by carrying a representation of all the kinds encoded,
> + * parsers can parse all of the encoded kinds, even if they cannot use
> + * them all.
> + *
> + * We use BTF itself to carry this representation because this approach
> + * does not require BTF parsing to understand a new BTF header format;
> + * BTF parsing simply sees some additional types it does not do anything
> + * with.  A BTF parser that knows about the encoding of kind information
> + * however can use this information in parsing.
> + *
> + * The process works by explicitly adding btf structs for each kind.
> + * Each struct consists of a struct __btf_type followed by an array of
> + * metadata structs representing the following metadata (for those kinds
> + * that have it).  For kinds where a single metadata structure is used,
> + * the metadata array has one element.  For kinds where the number
> + * of metadata elements varies as per the info.vlen field, a zero-element
> + * array is encoded.
> + *
> + * For a given kind, we add a struct __BTF_KIND_<kind>.  For example,
> + *
> + * struct __BTF_KIND_INT {
> + *     struct __btf_type type;
> + * };
> + *
> + * For a type with one metadata element, the representation looks like
> + * this:
> + *
> + * struct __BTF_KIND_META_ARRAY {
> + *     __u32 type;
> + *     __u32 index_type;
> + *     __u32  nelems;
> + * };
> + *
> + * struct __BTF_KIND_ARRAY {
> + *     struct __btf_type type;
> + *     struct __BTF_KIND_META_ARRAY meta[1];
> + * };
> + *
> + *
> + * For a type with an info.vlen-determined number of following metadata
> + * objects, a zero-length array is used:
> + *
> + * struct __BTF_KIND_STRUCT {
> + *     struct __btf_type type;
> + *     struct __BTF_KIND_META_STRUCT meta[0];
> + * };
> + *
> + * In order to link kind numeric kind values to the appropriate struct,
> + * a typedef is added; for example:
> + *
> + * typedef struct __BTF_KIND_INT __BTF_KIND_1;
> + *
> + * When BTF parsing encounters a kind that is not known, the
> + * typedef __BTF_KIND_<kind number> is looked up, and we find which
> + * struct type id it points to.  So
> + *
> + *     1 -> typedef __BTF_KIND_1 -> struct __BTF_KIND_INT
> + *
> + * This approach is preferred, since it ensures the structs representing
> + * BTF kinds have names which match their associated kind rather than
> + * an opaque number.
> + *
> + * From there, BTF parsing can look up that struct and determine
> + *     - its basic size;
> + *     - if it has metadata; and if so
> + *     - how many array instances are present;
> + *             - if 0, we know it is a vlen-determined number;
> + *             - if > 0, simply use the overall struct size;
> + *
> + * Based upon that information, BTF parsing can proceed for such
> + * unknown kinds, since sufficient information was provided
> + * at encoding time.
> + *
> + * Note that this assumes that the above kind-related data
> + * structures are represented in BTF _prior_ to any kinds that
> + * are new to the parser.  It also assumes the basic kinds
> + * required to represent kinds + metadata; base types, structs,
> + * arrays, etc.
> + */

Goodness gracious! :)

Aesthetics of all this aside (which hurts me deeply, but let's ignore
that for a moment), this whole requirement that these
self-describing-but-also-convention-driven types which are supposed to
help with parsing types information are themselves in types
information is quite unusual. Yes, by saying "we assume they come
before a first type with unknown kind" we kind of work around this,
but even the fact that you can use btf__type_by_id() and
btf__find_by_name_kind() before BTF is fully parsed is kind of by
accident. All-in-all this screams "a kludge" at me, sorry.

I really don't like this approach, even if *technically* it would
work. But even if so, it would add quite a bunch of size to BTF just
to self-describe it.

Let's go again (and in more detail) over my alternative proposal I
briefly described in another email thread.

So, what I'm proposing is similar in spirit and solves all the same
goals you have (and actually some more, I'll point this out below).
The only downside is that we'll need to, again, teach kernel to
understand this BTF format extension to allow kernel to use it (so we
still will need an opt-in flag for pahole, unfortunately, but
hopefully just this one time). That's pretty much the only downside.
But it's more compact, simpler and more straightforward, more elegant
(IMO), and it is easy for libbpf to sanitize it for old kernels.

Ok, so it's pretty much completely described by these changes:

--- a/include/uapi/linux/btf.h
+++ b/include/uapi/linux/btf.h
@@ -8,6 +8,21 @@
 #define BTF_MAGIC      0xeB9F
 #define BTF_VERSION    1

+struct btf_kind_meta {
+       /* extra flags, initially define just one:
+        * 0x01 - required or optional (is it safe to skip if unknown)
+        */
+       __u16 flags;
+       __u8 info_sz;
+       __u8 elem_sz;
+};
+
+struct btf_metadata {
+       __u8 kind_meta_cnt;
+       __u32 :0;
+       struct btf_kind_meta[];
+};
+
 struct btf_header {
        __u16   magic;
        __u8    version;
@@ -19,6 +34,8 @@ struct btf_header {
        __u32   type_len;       /* length of type section       */
        __u32   str_off;        /* offset of string section     */
        __u32   str_len;        /* length of string section     */
+       __u32   meta_off;
+       __u32   meta_len;
 };


So, we add meta_off/meta_len fields to btf_header, which, if non-zero,
will point to a piece of metadata (4-byte aligned) that's described by
struct btf_metadata.

In btf_metadata, the first byte records the number of known BTF kinds,
we have three more bytes for extra flags or counters for
extensibility, they should be zeroed out right now.

After these 4 bytes we have kind_meta_cnt struct btf_kind_meta
entries, each 4-byte long. It's a 1-indexed array, where each entry
corresponds to sequentially numbered BTF kinds. First two bytes are
reserved for flags and stuff like that. Among those, I think the most
useful right now would be the "optional flag". If set, it would mean
that generally speaking it's safe to skip types of that kind without
losing integrity of the data. So e.g., we could have used that for
DECL_TAGS, or perhaps even for FUNCs, if we had this metadata back
then, as these kinds are, generally speaking, not referenced from
other types (not 100% for FUNCs, as we can have FUNC externs, but
those came later). Anyways, for kernel needs we can say that optional
kinds don't cause failure to validate BTF.

*But for security reasons we should make the kernel zero-out
corresponding parts of type information, just to prevent injection of
well-known data by malicious user*.

Next, to the meat of the proposal. info_sz is size in bytes of an
additional singular information (e.g., btf_array for ARRAY kind,
4-byte info for INT kind, etc) that goes after common 12-byte struct
btf_type. It can be zero, of course. elem_sz is a size in bytes of
each nested element (field info for STRUCT, arg info for FUNC_ARG,
etc). Number of elements is defined by btf_vlen(t), which works for
any kind, regardless if it's known or not. If elem_sz is zero, KIND
can't have nested elements (and thus if vlen is non-zero, that's a
corruption).

That's it. We don't allow mixing differently-sized nested elements
within a single kind, but we don't have that today and we don't have
any meaningful ways to express this. And I don't think we'd want to do
this anyways (there are way to work around that if absolutely
necessary, as well).

From libbpf's point of view, this metadata section is easy to
sanitize, as kernel allows btf_headers of bigger size than is known to
it, provided they are zeroed out. So libbpf will just zero out
meta_off/meta_len fields, and contents of the metadata section.

As for the size, it adds just 8 + 4 + 19 * 4 = 88 bytes to the overall
BTF size. It's nothing. I didn't count the total size for your
approach, but at the very least it would be 19 * 2 * sizeof(struct
btf_type) (=12) = 456, but that's super conservative.

Note also that each btf_type can always have a name (described by
btf_type->name_off), so generic BTF tools can easily output what is
the name of the skipped entity, regardless of its actual kind. Tools
can also point out how many nested elements it is supposed to have.
Both are quite nice features, IMO.

Anyways, that's what I had in mind. I think we should bite a bullet
and do it, so that future extensions can make use of this
self-describing metadata.

Thoughts?


> +
> +/* info used to encode a kind metadata field */
> +struct btf_meta_field {
> +       const char *type;
> +       const char *name;
> +       int size;
> +       int type_id;
> +};
> +
> +#define BTF_MAX_META_FIELDS             10
> +
> +#define BTF_META_FIELD(__type, __name)                                 \
> +       { .type = #__type, .name = #__name, .size = sizeof(__type) }
> +
> +#define BTF_KIND_STR(__kind)   #__kind
> +
> +struct btf_kind_encoding {
> +       struct btf_kind_desc kind;
> +       struct btf_meta_field meta[BTF_MAX_META_FIELDS];
> +};
> +
> +#define BTF_KIND(__name, __nr_meta, __meta_size, ...)                  \
> +       { .kind = {                                                     \
> +         .kind = BTF_KIND_##__name,                                    \
> +         .struct_name = BTF_KIND_PFX#__name,                           \
> +         .meta_name = BTF_KIND_META_PFX #__name,                       \
> +         .nr_meta = __nr_meta,                                         \
> +         .meta_size = __meta_size,                                     \
> +       }, .meta = { __VA_ARGS__ } }
> +
> +struct btf_kind_encoding kinds[] = {
> +       BTF_KIND(UNKN,          0,      0),
> +
> +       BTF_KIND(INT,           0,      0),
> +
> +       BTF_KIND(PTR,           0,      0),
> +
> +       BTF_KIND(ARRAY,         1,      sizeof(struct btf_array),
> +                                       BTF_META_FIELD(__u32, type),
> +                                       BTF_META_FIELD(__u32, index_type),
> +                                       BTF_META_FIELD(__u32, nelems)),
> +
> +       BTF_KIND(STRUCT,        0,      sizeof(struct btf_member),
> +                                       BTF_META_FIELD(__u32, name_off),
> +                                       BTF_META_FIELD(__u32, type),
> +                                       BTF_META_FIELD(__u32, offset)),
> +
> +       BTF_KIND(UNION,         0,      sizeof(struct btf_member),
> +                                       BTF_META_FIELD(__u32, name_off),
> +                                       BTF_META_FIELD(__u32, type),
> +                                       BTF_META_FIELD(__u32, offset)),
> +
> +       BTF_KIND(ENUM,          0,      sizeof(struct btf_enum),
> +                                       BTF_META_FIELD(__u32, name_off),
> +                                       BTF_META_FIELD(__s32, val)),
> +
> +       BTF_KIND(FWD,           0,      0),
> +
> +       BTF_KIND(TYPEDEF,       0,      0),
> +
> +       BTF_KIND(VOLATILE,      0,      0),
> +
> +       BTF_KIND(CONST,         0,      0),
> +
> +       BTF_KIND(RESTRICT,      0,      0),
> +
> +       BTF_KIND(FUNC,          0,      0),
> +
> +       BTF_KIND(FUNC_PROTO,    0,      sizeof(struct btf_param),
> +                                       BTF_META_FIELD(__u32, name_off),
> +                                       BTF_META_FIELD(__u32, type)),
> +
> +       BTF_KIND(VAR,           1,      sizeof(struct btf_var),
> +                                       BTF_META_FIELD(__u32, linkage)),
> +
> +       BTF_KIND(DATASEC,       0,      sizeof(struct btf_var_secinfo),
> +                                       BTF_META_FIELD(__u32, type),
> +                                       BTF_META_FIELD(__u32, offset),
> +                                       BTF_META_FIELD(__u32, size)),
> +
> +
> +       BTF_KIND(FLOAT,         0,      0),
> +
> +       BTF_KIND(DECL_TAG,      1,      sizeof(struct btf_decl_tag),
> +                                       BTF_META_FIELD(__s32, component_idx)),
> +
> +       BTF_KIND(TYPE_TAG,      0,      0),
> +
> +       BTF_KIND(ENUM64,        0,      sizeof(struct btf_enum64),
> +                                       BTF_META_FIELD(__u32, name_off),
> +                                       BTF_META_FIELD(__u32, val_lo32),
> +                                       BTF_META_FIELD(__u32, val_hi32)),
> +};
> +
> +/* Try to add representations of the kinds supported to BTF provided.  This will allow parsers
> + * to decode kinds they do not support and skip over them.
> + */
> +int btf__add_kinds(struct btf *btf)
> +{
> +       int btf_type_id, __u32_id, __s32_id, struct_type_id;
> +       char name[64];
> +       int i;
> +
> +       /* should have base types; if not bootstrap them. */
> +       __u32_id = btf__find_by_name(btf, "__u32");
> +       if (__u32_id < 0) {
> +               __s32 unsigned_int_id = btf__find_by_name(btf, "unsigned int");
> +
> +               if (unsigned_int_id < 0)
> +                       unsigned_int_id = btf__add_int(btf, "unsigned int", 4, 0);
> +               __u32_id = btf__add_typedef(btf, "__u32", unsigned_int_id);
> +       }
> +       __s32_id = btf__find_by_name(btf, "__s32");
> +       if (__s32_id < 0) {
> +               __s32 int_id = btf__find_by_name_kind(btf, "int", BTF_KIND_INT);
> +
> +               if (int_id < 0)
> +                       int_id = btf__add_int(btf, "int", 4, BTF_INT_SIGNED);
> +               __s32_id = btf__add_typedef(btf, "__s32", int_id);
> +       }
> +
> +       /* add "struct __btf_type" if not already present. */
> +       btf_type_id = btf__find_by_name(btf, "__btf_type");
> +       if (btf_type_id < 0) {
> +               __s32 union_id = btf__add_union(btf, NULL, sizeof(__u32));
> +
> +               btf__add_field(btf, "size", __u32_id, 0, 0);
> +               btf__add_field(btf, "type", __u32_id, 0, 0);
> +
> +               btf_type_id = btf__add_struct(btf, "__btf_type", sizeof(struct btf_type));
> +               btf__add_field(btf, "name_off", __u32_id, 0, 0);
> +               btf__add_field(btf, "info", __u32_id, sizeof(__u32) * 8, 0);
> +               btf__add_field(btf, NULL, union_id, sizeof(__u32) * 16, 0);
> +       }
> +
> +       for (i = 0; i < ARRAY_SIZE(kinds); i++) {
> +               struct btf_kind_encoding *kind = &kinds[i];
> +               int meta_id, array_id = 0;
> +
> +               if (btf__find_by_name(btf, kind->kind.struct_name) > 0)
> +                       continue;
> +
> +               if (kind->kind.meta_size != 0) {
> +                       struct btf_meta_field *field;
> +                       __u32 bit_offset = 0;
> +                       int j;
> +
> +                       meta_id = btf__add_struct(btf, kind->kind.meta_name, kind->kind.meta_size);
> +
> +                       for (j = 0; bit_offset < kind->kind.meta_size * 8; j++) {
> +                               field = &kind->meta[j];
> +
> +                               field->type_id = btf__find_by_name(btf, field->type);
> +                               if (field->type_id < 0) {
> +                                       pr_debug("cannot find type '%s' for kind '%s' field '%s'\n",
> +                                                kind->meta[j].type, kind->kind.struct_name,
> +                                                kind->meta[j].name);
> +                               } else {
> +                                       btf__add_field(btf, field->name, field->type_id, bit_offset, 0);
> +                               }
> +                               bit_offset += field->size * 8;
> +                       }
> +                       array_id = btf__add_array(btf, __u32_id, meta_id,
> +                                                 kind->kind.nr_meta);
> +
> +               }
> +               struct_type_id = btf__add_struct(btf, kind->kind.struct_name,
> +                                                sizeof(struct btf_type) +
> +                                                (kind->kind.nr_meta * kind->kind.meta_size));
> +               btf__add_field(btf, "type", btf_type_id, 0, 0);
> +               if (kind->kind.meta_size != 0)
> +                       btf__add_field(btf, "meta", array_id, sizeof(struct btf_type) * 8, 0);
> +               snprintf(name, sizeof(name), BTF_KIND_PFX "%u", i);
> +               btf__add_typedef(btf, name, struct_type_id);
> +       }
> +       return 0;
> +}
> diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
> index 8e6880d..a054082 100644
> --- a/tools/lib/bpf/btf.h
> +++ b/tools/lib/bpf/btf.h
> @@ -219,6 +219,16 @@ LIBBPF_API int btf__add_datasec_var_info(struct btf *btf, int var_type_id,
>  LIBBPF_API int btf__add_decl_tag(struct btf *btf, const char *value, int ref_type_id,
>                             int component_idx);
>
> +/**
> + * @brief **btf__add_kinds()** adds BTF representations of the kind encoding for
> + * all of the kinds known to libbpf.  This ensures that when BTF is encoded, it
> + * will include enough information for parsers to decode (and skip over) kinds
> + * that the parser does not know about yet.  This ensures that an older BTF
> + * parser can read newer BTF, and avoids the need for the BTF encoder to limit
> + * which kinds it emits to make decoding easier.
> + */
> +LIBBPF_API int btf__add_kinds(struct btf *btf);
> +
>  struct btf_dedup_opts {
>         size_t sz;
>         /* optional .BTF.ext info to dedup along the main BTF info */
> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> index 71bf569..6121ff1 100644
> --- a/tools/lib/bpf/libbpf.map
> +++ b/tools/lib/bpf/libbpf.map
> @@ -375,6 +375,7 @@ LIBBPF_1.1.0 {
>                 bpf_link_get_fd_by_id_opts;
>                 bpf_map_get_fd_by_id_opts;
>                 bpf_prog_get_fd_by_id_opts;
> +               btf__add_kinds;
>                 user_ring_buffer__discard;
>                 user_ring_buffer__free;
>                 user_ring_buffer__new;
> --
> 1.8.3.1
>
