Return-Path: <bpf+bounces-4622-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1140774DD32
	for <lists+bpf@lfdr.de>; Mon, 10 Jul 2023 20:18:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91D112812E9
	for <lists+bpf@lfdr.de>; Mon, 10 Jul 2023 18:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B25ED14A94;
	Mon, 10 Jul 2023 18:18:15 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760A713AF9
	for <bpf@vger.kernel.org>; Mon, 10 Jul 2023 18:18:15 +0000 (UTC)
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BDEF12A
	for <bpf@vger.kernel.org>; Mon, 10 Jul 2023 11:18:13 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-1b895a9f4ccso56951645ad.2
        for <bpf@vger.kernel.org>; Mon, 10 Jul 2023 11:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689013093; x=1691605093;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5QBna+hsKQKTdkEqXjxIaAjxWbgshju3hDBnbo/UWxc=;
        b=7gXu7i7fYCW9dNCZfuQEaLLGo0pm0U5vPzqIuNZr3VBEadY+NPHJWSQ64k42/pDQL4
         O5eeKeAV7lVXn/p8v0lvN+fzJ55Pcamsoypz9R6i2V9IEef/OpATkCwYfH4AZv3oTCSA
         p9czjMpCz1pdPHSBX7nZ79VdKuwjRG3JIUinDiCU+tAvU69EGPlcLKJilwr2kzGiZ0JI
         fYeA+lrEHAYPONNaHjoIuu1TvBDUHaW8pcjS0vrRa85aZJkNLgAICruM6YfXtShrAkax
         RTMjvAhkhPWP73N9cEUeAb5oOudSZ94OhGcSAYU/16eWUKutfkGfFL/rxUJLUWOVfBU1
         qpQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689013093; x=1691605093;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5QBna+hsKQKTdkEqXjxIaAjxWbgshju3hDBnbo/UWxc=;
        b=LQhbiDaOcyQahOqrC5VFpBvygjRcwzgeX6mQe8YiOY6eVuKKjUOrs8uTe8muh3D2Xr
         zJliqWUzZV/QDyBMQQniTzkr2DqeShghO4Ak4UcF24e1D9/f7TIVuKSHgfGIufwDFRtr
         tNatOKvM+BZcIs0HsPbyTzk0e9CB4o20KsVfQ3kjgBSa+jPmZud/wWkN+UJIXtMwxs6K
         GE4N2oDEHO4u/YD696qrpqE9W9ItLL9s9UtrPtWB9dpN8xaY1cThHGQ07px1ACrIifQf
         JJfmVlq0pUVHAAjVRR4Chr6ItpFxoINo7Bbb8O57PhYnTMlixcfVLv6ZI5KmdcWRfvtE
         AJLA==
X-Gm-Message-State: ABy/qLZjNjr1P+OADzI1FEYILqazVgg3b0Q4xblAreB9UPSvBOXlY4Ra
	esHRt6iKzsuXOHYs1CxKaQA2574=
X-Google-Smtp-Source: APBJJlEA+Bb/OXig3n9g2cR/dOUVnCNoXJdIV5vrbMKmpj07pHGsrG+kHbze4Dt+DHNO/DeuZt1RlPo=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:903:44c:b0:1b1:e9c0:4625 with SMTP id
 iw12-20020a170903044c00b001b1e9c04625mr12101096plb.10.1689013093143; Mon, 10
 Jul 2023 11:18:13 -0700 (PDT)
Date: Mon, 10 Jul 2023 11:18:11 -0700
In-Reply-To: <d67ca0f4-4753-e86f-f8ca-dd515f941ea5@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230707172455.7634-1-daniel@iogearbox.net> <20230707172455.7634-2-daniel@iogearbox.net>
 <ZKiDKuoovyikz8Mm@google.com> <d67ca0f4-4753-e86f-f8ca-dd515f941ea5@iogearbox.net>
Message-ID: <ZKxLY3onuOHepOxt@google.com>
Subject: Re: [PATCH bpf-next v3 1/8] bpf: Add generic attach/detach/query API
 for multi-progs
From: Stanislav Fomichev <sdf@google.com>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: ast@kernel.org, andrii@kernel.org, martin.lau@linux.dev, 
	razor@blackwall.org, john.fastabend@gmail.com, kuba@kernel.org, dxu@dxuuu.xyz, 
	joe@cilium.io, toke@kernel.org, davem@davemloft.net, bpf@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 07/10, Daniel Borkmann wrote:
> On 7/7/23 11:27 PM, Stanislav Fomichev wrote:
> > On 07/07, Daniel Borkmann wrote:
> [...]
> > > +static inline struct bpf_mprog_entry *
> > > +bpf_mprog_create(const size_t size, const off_t off)
> > > +{
> > > +	struct bpf_mprog_bundle *bundle;
> > > +	void *ptr;
> > > +
> > > +	BUILD_BUG_ON(size < sizeof(*bundle) + off);
> > > +	BUILD_BUG_ON(sizeof(bundle->a.fp_items[0]) > sizeof(u64));
> > > +	BUILD_BUG_ON(ARRAY_SIZE(bundle->a.fp_items) !=
> > > +		     ARRAY_SIZE(bundle->cp_items));
> > > +
> > > +	ptr = kzalloc(size, GFP_KERNEL);
> > > +	if (ptr) {
> > > +		bundle = ptr + off;
> > > +		atomic64_set(&bundle->revision, 1);
> > > +		bundle->off = off;
> > > +		bundle->a.parent = bundle;
> > > +		bundle->b.parent = bundle;
> > > +		return &bundle->a;
> > > +	}
> > > +	return NULL;
> > > +}
> > > +
> > > +void bpf_mprog_free_rcu(struct rcu_head *rcu);
> > > +
> > > +static inline void bpf_mprog_free(struct bpf_mprog_entry *entry)
> > > +{
> > > +	struct bpf_mprog_bundle *bundle = entry->parent;
> > > +
> > > +	call_rcu(&bundle->rcu, bpf_mprog_free_rcu);
> > > +}
> > 
> > Any reason we're doing allocation here? Why not do
> > bpf_mprog_init(struct bpf_mprog_bundle *) instead that simply initializes
> > the fields? Then we can move allocation/free part to the caller (tcx) along
> > with rcu_head.
> > Feels like it would be a bit more conventional/readable? bpf_mprog_free{,_rcu}
> > will also become tcx_free{,_rcu}..
> > 
> > I guess current approach works, but it took me awhile to figure it out..
> > (maybe it's just me)
> 
> I found this approach quite useful for tcx case since we only fetch the
> bpf_mprog_entry for tcx_link_prog_attach et al, but I can take a look to
> see if this looks better and if it does I'll include it.
> 
> > > +static inline void bpf_mprog_mark_ref(struct bpf_mprog_entry *entry,
> > > +				      struct bpf_tuple *tuple)
> > > +{
> > > +	WARN_ON_ONCE(entry->parent->ref);
> > > +	if (!tuple->link)
> > > +		entry->parent->ref = tuple->prog;
> > > +}
> > > +
> > > +static inline void bpf_mprog_inc(struct bpf_mprog_entry *entry)
> > > +{
> > > +	entry->parent->count++;
> > > +}
> > > +
> > > +static inline void bpf_mprog_dec(struct bpf_mprog_entry *entry)
> > > +{
> > > +	entry->parent->count--;
> > > +}
> > > +
> > > +static inline int bpf_mprog_max(void)
> > > +{
> > > +	return ARRAY_SIZE(((struct bpf_mprog_entry *)NULL)->fp_items) - 1;
> > > +}
> > > +
> > > +static inline int bpf_mprog_total(struct bpf_mprog_entry *entry)
> > > +{
> > > +	int total = entry->parent->count;
> > > +
> > > +	WARN_ON_ONCE(total > bpf_mprog_max());
> > > +	return total;
> > > +}
> > > +
> > > +static inline bool bpf_mprog_exists(struct bpf_mprog_entry *entry,
> > > +				    struct bpf_prog *prog)
> > > +{
> > > +	const struct bpf_mprog_fp *fp;
> > > +	const struct bpf_prog *tmp;
> > > +
> > > +	bpf_mprog_foreach_prog(entry, fp, tmp) {
> > > +		if (tmp == prog)
> > > +			return true;
> > > +	}
> > > +	return false;
> > > +}
> > > +
> > > +static inline bool bpf_mprog_swap_entries(const int code)
> > > +{
> > > +	return code == BPF_MPROG_SWAP ||
> > > +	       code == BPF_MPROG_FREE;
> > > +}
> > > +
> > > +static inline void bpf_mprog_commit(struct bpf_mprog_entry *entry)
> > > +{
> > > +	atomic64_inc(&entry->parent->revision);
> > > +	synchronize_rcu();
> > 
> > Maybe add a comment on why we need to synchronize_rcu here? In general,
> > I don't think I have a good grasp of that ->ref member.
> 
> Yeap, will add a comment. For the case where we delete the prog, we mark
> it in bpf_mprog_detach, but we can only drop the reference once the user
> swapped the bpf_mprog_entry and ensured that there are no in-flight users
> hence both in bpf_mprog_commit.
> 
> [...]
> > > +static int bpf_mprog_prog(struct bpf_tuple *tuple,
> > > +			  u32 object, u32 flags,
> > > +			  enum bpf_prog_type type)
> > > +{
> > > +	bool id = flags & BPF_F_ID;
> > > +	struct bpf_prog *prog;
> > > +
> > > +	if (id)
> > > +		prog = bpf_prog_by_id(object);
> > > +	else
> > > +		prog = bpf_prog_get(object);
> > > +	if (IS_ERR(prog)) {
> > 
> > [..]
> > 
> > > +		if (!object && !id)
> > > +			return 0;
> > 
> > What's the reason behind this?
> 
> If an fd was passed which is 0 and this was not a program fd, then we don't error
> out and treat it as if no fd was passed.
 
Is this new api an opportunity to fix that fd==0? And always treat it as
valid. Or we have some other constrains elsewhere?

> > > +		return PTR_ERR(prog);
> > > +	}
> > > +	if (type && prog->type != type) {
> > > +		bpf_prog_put(prog);
> > > +		return -EINVAL;
> > > +	}
> > > +
> > > +	tuple->link = NULL;
> > > +	tuple->prog = prog;
> > > +	return 0;
> > > +}
> [...]
> > > +static int bpf_mprog_pos_before(struct bpf_mprog_entry *entry,
> > > +				struct bpf_tuple *tuple)
> > > +{
> > > +	struct bpf_mprog_fp *fp;
> > > +	struct bpf_mprog_cp *cp;
> > > +	int i;
> > > +
> > > +	for (i = 0; i < bpf_mprog_total(entry); i++) {
> > > +		bpf_mprog_read(entry, i, &fp, &cp);
> > > +		if (tuple->prog == READ_ONCE(fp->prog) &&
> > 
> > Both attach/detach happen under rtnl, why do need READ_ONCE? I'm assuming
> > even going forwrad, attach/detach from non-tcx places will happen
> > under lock?
> > 
> > (same for bpf_mprog_pos_before/bpf_mprog_pos_after)
> > 
> > Feels like the only place where we need WRITE_ONCE is the replace (in-place)
> > and READ_ONCE during fast-path. Why do we need the rest?
> 
> Yes, the replace case is via WRITE_ONCE, hence the READ_ONCE annotations. You
> are saying that for the cases where we are under lock we should just drop the
> READ_ONCE annotations? I can do that ofc, I thought the general convention was
> to do the {READ,WRITE}_ONCE consistently for the purpose of documenting fp->prog
> access.

I see, then maybe let's keep them. I was a bit confused because those
READ_ONCE are within a locked section so I wasn't sure whether I'm
missing something or it's working as intended :-)

> > > +		    (!tuple->link || tuple->link == cp->link))
> > > +			return i - 1;
> > > +	}
> > > +	return tuple->prog ? -ENOENT : -1;
> > > +}
> > > +
> > > +static int bpf_mprog_pos_after(struct bpf_mprog_entry *entry,
> > > +			       struct bpf_tuple *tuple)
> > > +{
> > > +	struct bpf_mprog_fp *fp;
> > > +	struct bpf_mprog_cp *cp;
> > > +	int i;
> > > +
> > > +	for (i = 0; i < bpf_mprog_total(entry); i++) {
> > > +		bpf_mprog_read(entry, i, &fp, &cp);
> > > +		if (tuple->prog == READ_ONCE(fp->prog) &&
> > > +		    (!tuple->link || tuple->link == cp->link))
> > > +			return i + 1;
> > > +	}
> > > +	return tuple->prog ? -ENOENT : bpf_mprog_total(entry);
> > > +}
> > > +
> > > +int bpf_mprog_attach(struct bpf_mprog_entry *entry, struct bpf_prog *prog_new,
> > > +		     struct bpf_link *link, struct bpf_prog *prog_old,
> > > +		     u32 flags, u32 object, u64 revision)
> > > +{
> > > +	struct bpf_tuple rtuple, ntuple = {
> > > +		.prog = prog_new,
> > > +		.link = link,
> > > +	}, otuple = {
> > > +		.prog = prog_old,
> > > +		.link = link,
> > > +	};
> > > +	int ret, idx = -2, tidx;
> > > +
> > > +	if (revision && revision != bpf_mprog_revision(entry))
> > > +		return -ESTALE;
> > > +	if (bpf_mprog_exists(entry, prog_new))
> > > +		return -EEXIST;
> > > +	ret = bpf_mprog_tuple_relative(&rtuple, object,
> > > +				       flags & ~BPF_F_REPLACE,
> > > +				       prog_new->type);
> > > +	if (ret)
> > > +		return ret;
> > > +	if (flags & BPF_F_REPLACE) {
> > > +		tidx = bpf_mprog_pos_exact(entry, &otuple);
> > > +		if (tidx < 0) {
> > > +			ret = tidx;
> > > +			goto out;
> > > +		}
> > > +		idx = tidx;
> > > +	}
> > 
> > [..]
> > 
> > > +	if (flags & BPF_F_BEFORE) {
> > > +		tidx = bpf_mprog_pos_before(entry, &rtuple);
> > > +		if (tidx < -1 || (idx >= -1 && tidx != idx)) {
> > > +			ret = tidx < -1 ? tidx : -EDOM;
> > > +			goto out;
> > > +		}
> > > +		idx = tidx;
> > > +	}
> > > +	if (flags & BPF_F_AFTER) {
> > > +		tidx = bpf_mprog_pos_after(entry, &rtuple);
> > > +		if (tidx < 0 || (idx >= -1 && tidx != idx)) {
> > > +			ret = tidx < 0 ? tidx : -EDOM;
> > > +			goto out;
> > > +		}
> > > +		idx = tidx;
> > > +	}
> > 
> > There still seems to be some inter-dependency between F_BEFORE and F_AFTER?
> > IOW, looks like I can pass F_BEFORE|F_AFTER|F_REPLACE. Do we need that?
> > Why not exclusive cases?
> 
> I reworked this as per Andrii's suggestion/preference from v2 [0], iow, to calculate
> target index and bail out if the request cannot be resolved into a common index.
> 
>   [0] https://lore.kernel.org/bpf/CAEf4BzbsUMnP7WMm3OmJznvD2b03B1qASFRNiDoVAU6XvvTZNA@mail.gmail.com/

SG! Let's maybe put a summary in the header of what the expectation is when
combining them?

