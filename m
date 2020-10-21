Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24DE22952E8
	for <lists+bpf@lfdr.de>; Wed, 21 Oct 2020 21:25:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504476AbgJUTZe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 21 Oct 2020 15:25:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:42300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2441904AbgJUTZe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 21 Oct 2020 15:25:34 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1737824170;
        Wed, 21 Oct 2020 19:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603308333;
        bh=XmGtBDIc8rDQrH+DPZt5CdCuiMuBmj/fWwAZdzc8B3Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TkanMKHvCJdb4SrnL21T/IdHnW9G3ajKYy2gfB+zD8NqWiCeFF7Aek91Pi0wlSDhp
         GQ2aBuGNjgLRTMOInKjjdlZZjiEFHAgkLZ+fRkKWq3VYJQ2mVomNgmswPa87llMmnk
         MIHqFw5ylmcDYLJPKoo4LL99uJ7NCivXpc9v8slU=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 5C1EA403C2; Wed, 21 Oct 2020 16:25:30 -0300 (-03)
Date:   Wed, 21 Oct 2020 16:25:30 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     dwarves@vger.kernel.org, bpf@vger.kernel.org, kernel-team@fb.com,
        ast@kernel.org
Subject: Re: [PATCH dwarves] btf_loader: handle union forward declaration
 properly
Message-ID: <20201021192530.GS2342001@kernel.org>
References: <20201009192607.699835-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201009192607.699835-1-andrii@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Fri, Oct 09, 2020 at 12:26:07PM -0700, Andrii Nakryiko escreveu:
> Differentiate between struct and union forwards. For BTF_KIND_FWD this is
> determined by kflag. So teach btf_loader to use that bit to decide whether
> forward is for union or struct.

So, before this patch 'btfdiff vmlinux' comes clean, i.e. pretty
printing from DWARF matches pretty printing from BTF, after it:

[acme@five pahole]$ btfdiff vmlinux  | wc -l
1500
[acme@five pahole]$

One of the differences:

@@ -117457,7 +117457,7 @@ struct wireless_dev {

 	/* XXX last struct has 1 byte of padding */

-	struct cfg80211_cqm_config * cqm_config;         /*   952     8 */
+	union cfg80211_cqm_config * cqm_config;          /*   952     8 */
 	/* --- cacheline 15 boundary (960 bytes) --- */
 	struct list_head           pmsr_list;            /*   960    16 */
 	spinlock_t                 pmsr_lock;            /*   976     4 */
[acme@five pahole]$

Looking at the source code:

struct wireless_dev {
...
        struct cfg80211_cqm_config *cqm_config;
...
}

Also:

 struct nfnl_ct_hook {
-	struct nf_conn *           (*get_ct)(const struct sk_buff  *, enum ip_conntrack_info *); /*     0     8 */
-	size_t                     (*build_size)(const struct nf_conn  *); /*     8     8 */
-	int                        (*build)(struct sk_buff *, struct nf_conn *, enum ip_conntrack_info, u_int16_t, u_int16_t); /*    16     8 */
-	int                        (*parse)(const struct nlattr  *, struct nf_conn *); /*    24     8 */
-	int                        (*attach_expect)(const struct nlattr  *, struct nf_conn *, u32, u32); /*    32     8 */
-	void                       (*seq_adjust)(struct sk_buff *, struct nf_conn *, enum ip_conntrack_info, s32); /*    40     8 */
+	union nf_conn *            (*get_ct)(const struct sk_buff  *, enum ip_conntrack_info *); /*     0     8 */
+	size_t                     (*build_size)(const union nf_conn  *); /*     8     8 */
+	int                        (*build)(struct sk_buff *, union nf_conn *, enum ip_conntrack_info, u_int16_t, u_int16_t); /*    16     8 */
+	int                        (*parse)(const struct nlattr  *, union nf_conn *); /*    24     8 */
+	int                        (*attach_expect)(const struct nlattr  *, union nf_conn *, u32, u32); /*    32     8 */
+	void                       (*seq_adjust)(struct sk_buff *, union nf_conn *, enum ip_conntrack_info, s32); /*    40     8 */1

Looking at the source code:

struct nfnl_ct_hook {
        struct nf_conn *(*get_ct)(const struct sk_buff *skb,
                                  enum ip_conntrack_info *ctinfo);
        size_t (*build_size)(const struct nf_conn *ct);
        int (*build)(struct sk_buff *skb, struct nf_conn *ct,
                     enum ip_conntrack_info ctinfo,
                     u_int16_t ct_attr, u_int16_t ct_info_attr);
        int (*parse)(const struct nlattr *attr, struct nf_conn *ct);
        int (*attach_expect)(const struct nlattr *attr, struct nf_conn *ct,
                             u32 portid, u32 report);
        void (*seq_adjust)(struct sk_buff *skb, struct nf_conn *ct,
                           enum ip_conntrack_info ctinfo, s32 off);
};

- Arnaldo
 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
> N.B. This patch is based on top of tmp.libbtf_encoder branch.
> 
> Also seems like non-forward declared union has a slightly different
> representation from struct (class). Not sure why it is so, but this change
> doesn't seem to break anything.
> ---
> 
>  btf_loader.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/btf_loader.c b/btf_loader.c
> index 9b5da3a4997a..0cb23967fec3 100644
> --- a/btf_loader.c
> +++ b/btf_loader.c
> @@ -134,12 +134,13 @@ static struct type *type__new(uint16_t tag, strings_t name, size_t size)
>  	return type;
>  }
>  
> -static struct class *class__new(strings_t name, size_t size)
> +static struct class *class__new(strings_t name, size_t size, bool is_union)
>  {
>  	struct class *class = tag__alloc(sizeof(*class));
> +	uint32_t tag = is_union ? DW_TAG_union_type : DW_TAG_structure_type;
>  
>  	if (class != NULL) {
> -		type__init(&class->type, DW_TAG_structure_type, name, size);
> +		type__init(&class->type, tag, name, size);
>  		INIT_LIST_HEAD(&class->vtable);
>  	}
>  
> @@ -228,7 +229,7 @@ static int create_members(struct btf_elf *btfe, const struct btf_type *tp,
>  
>  static int create_new_class(struct btf_elf *btfe, const struct btf_type *tp, uint32_t id)
>  {
> -	struct class *class = class__new(tp->name_off, tp->size);
> +	struct class *class = class__new(tp->name_off, tp->size, false);
>  	int member_size = create_members(btfe, tp, &class->type);
>  
>  	if (member_size < 0)
> @@ -313,7 +314,7 @@ static int create_new_subroutine_type(struct btf_elf *btfe, const struct btf_typ
>  
>  static int create_new_forward_decl(struct btf_elf *btfe, const struct btf_type *tp, uint32_t id)
>  {
> -	struct class *fwd = class__new(tp->name_off, 0);
> +	struct class *fwd = class__new(tp->name_off, 0, btf_kind(tp));
>  
>  	if (fwd == NULL)
>  		return -ENOMEM;
> -- 
> 2.24.1
> 

-- 

- Arnaldo
