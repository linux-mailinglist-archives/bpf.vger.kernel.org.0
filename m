Return-Path: <bpf+bounces-4576-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41ECA74CEBA
	for <lists+bpf@lfdr.de>; Mon, 10 Jul 2023 09:42:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 722F61C2094F
	for <lists+bpf@lfdr.de>; Mon, 10 Jul 2023 07:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97A44BE63;
	Mon, 10 Jul 2023 07:42:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5567FA933;
	Mon, 10 Jul 2023 07:42:30 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71E1BE1;
	Mon, 10 Jul 2023 00:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=fPHyly7OUR2mlkHw64bAiHJrG25yCGMobXVh3DN1OvA=; b=kIViraSzy/7l7bN1EZ7Bzoh2rB
	FLwy+g9lvRdId8NbVNOU9m9gYsCGzmEOsH3syRhhXIYHQ0sZLrd4GFaMI4bdJPkcnAc/lDrOuC1xx
	2dcgjBXpWPq1M2ahajw1mGBnlk/tZqzBhqTAd5kyvIE0oE0QLWybKmVZ0cUaY9l0hSHUVfMsgNoBD
	Cb5rzE8OxDU123WZ9Sangu8jv1+3obaRz3jihj1uu8q+AtOAIgCuDXflqy3v0Mro1+boN+hjYrJk0
	kyOqcqEfcsZSGbdS0f59/LK7PWNqAEfbEk6WTz5K3AEstjR90hSrJU67hvU7BimeQ4b/l4aQC2L4X
	yjIEWnnw==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qIlXJ-0009J9-6O; Mon, 10 Jul 2023 09:42:21 +0200
Received: from [85.1.206.226] (helo=linux.home)
	by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1qIlXI-0004O2-NU; Mon, 10 Jul 2023 09:42:20 +0200
Subject: Re: [PATCH bpf-next v3 1/8] bpf: Add generic attach/detach/query API
 for multi-progs
To: Stanislav Fomichev <sdf@google.com>
Cc: ast@kernel.org, andrii@kernel.org, martin.lau@linux.dev,
 razor@blackwall.org, john.fastabend@gmail.com, kuba@kernel.org,
 dxu@dxuuu.xyz, joe@cilium.io, toke@kernel.org, davem@davemloft.net,
 bpf@vger.kernel.org, netdev@vger.kernel.org
References: <20230707172455.7634-1-daniel@iogearbox.net>
 <20230707172455.7634-2-daniel@iogearbox.net> <ZKiDKuoovyikz8Mm@google.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <d67ca0f4-4753-e86f-f8ca-dd515f941ea5@iogearbox.net>
Date: Mon, 10 Jul 2023 09:42:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZKiDKuoovyikz8Mm@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.8/26964/Sun Jul  9 09:27:43 2023)
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 7/7/23 11:27 PM, Stanislav Fomichev wrote:
> On 07/07, Daniel Borkmann wrote:
[...]
>> +static inline struct bpf_mprog_entry *
>> +bpf_mprog_create(const size_t size, const off_t off)
>> +{
>> +	struct bpf_mprog_bundle *bundle;
>> +	void *ptr;
>> +
>> +	BUILD_BUG_ON(size < sizeof(*bundle) + off);
>> +	BUILD_BUG_ON(sizeof(bundle->a.fp_items[0]) > sizeof(u64));
>> +	BUILD_BUG_ON(ARRAY_SIZE(bundle->a.fp_items) !=
>> +		     ARRAY_SIZE(bundle->cp_items));
>> +
>> +	ptr = kzalloc(size, GFP_KERNEL);
>> +	if (ptr) {
>> +		bundle = ptr + off;
>> +		atomic64_set(&bundle->revision, 1);
>> +		bundle->off = off;
>> +		bundle->a.parent = bundle;
>> +		bundle->b.parent = bundle;
>> +		return &bundle->a;
>> +	}
>> +	return NULL;
>> +}
>> +
>> +void bpf_mprog_free_rcu(struct rcu_head *rcu);
>> +
>> +static inline void bpf_mprog_free(struct bpf_mprog_entry *entry)
>> +{
>> +	struct bpf_mprog_bundle *bundle = entry->parent;
>> +
>> +	call_rcu(&bundle->rcu, bpf_mprog_free_rcu);
>> +}
> 
> Any reason we're doing allocation here? Why not do
> bpf_mprog_init(struct bpf_mprog_bundle *) instead that simply initializes
> the fields? Then we can move allocation/free part to the caller (tcx) along
> with rcu_head.
> Feels like it would be a bit more conventional/readable? bpf_mprog_free{,_rcu}
> will also become tcx_free{,_rcu}..
> 
> I guess current approach works, but it took me awhile to figure it out..
> (maybe it's just me)

I found this approach quite useful for tcx case since we only fetch the
bpf_mprog_entry for tcx_link_prog_attach et al, but I can take a look to
see if this looks better and if it does I'll include it.

>> +static inline void bpf_mprog_mark_ref(struct bpf_mprog_entry *entry,
>> +				      struct bpf_tuple *tuple)
>> +{
>> +	WARN_ON_ONCE(entry->parent->ref);
>> +	if (!tuple->link)
>> +		entry->parent->ref = tuple->prog;
>> +}
>> +
>> +static inline void bpf_mprog_inc(struct bpf_mprog_entry *entry)
>> +{
>> +	entry->parent->count++;
>> +}
>> +
>> +static inline void bpf_mprog_dec(struct bpf_mprog_entry *entry)
>> +{
>> +	entry->parent->count--;
>> +}
>> +
>> +static inline int bpf_mprog_max(void)
>> +{
>> +	return ARRAY_SIZE(((struct bpf_mprog_entry *)NULL)->fp_items) - 1;
>> +}
>> +
>> +static inline int bpf_mprog_total(struct bpf_mprog_entry *entry)
>> +{
>> +	int total = entry->parent->count;
>> +
>> +	WARN_ON_ONCE(total > bpf_mprog_max());
>> +	return total;
>> +}
>> +
>> +static inline bool bpf_mprog_exists(struct bpf_mprog_entry *entry,
>> +				    struct bpf_prog *prog)
>> +{
>> +	const struct bpf_mprog_fp *fp;
>> +	const struct bpf_prog *tmp;
>> +
>> +	bpf_mprog_foreach_prog(entry, fp, tmp) {
>> +		if (tmp == prog)
>> +			return true;
>> +	}
>> +	return false;
>> +}
>> +
>> +static inline bool bpf_mprog_swap_entries(const int code)
>> +{
>> +	return code == BPF_MPROG_SWAP ||
>> +	       code == BPF_MPROG_FREE;
>> +}
>> +
>> +static inline void bpf_mprog_commit(struct bpf_mprog_entry *entry)
>> +{
>> +	atomic64_inc(&entry->parent->revision);
>> +	synchronize_rcu();
> 
> Maybe add a comment on why we need to synchronize_rcu here? In general,
> I don't think I have a good grasp of that ->ref member.

Yeap, will add a comment. For the case where we delete the prog, we mark
it in bpf_mprog_detach, but we can only drop the reference once the user
swapped the bpf_mprog_entry and ensured that there are no in-flight users
hence both in bpf_mprog_commit.

[...]
>> +static int bpf_mprog_prog(struct bpf_tuple *tuple,
>> +			  u32 object, u32 flags,
>> +			  enum bpf_prog_type type)
>> +{
>> +	bool id = flags & BPF_F_ID;
>> +	struct bpf_prog *prog;
>> +
>> +	if (id)
>> +		prog = bpf_prog_by_id(object);
>> +	else
>> +		prog = bpf_prog_get(object);
>> +	if (IS_ERR(prog)) {
> 
> [..]
> 
>> +		if (!object && !id)
>> +			return 0;
> 
> What's the reason behind this?

If an fd was passed which is 0 and this was not a program fd, then we don't error
out and treat it as if no fd was passed.

>> +		return PTR_ERR(prog);
>> +	}
>> +	if (type && prog->type != type) {
>> +		bpf_prog_put(prog);
>> +		return -EINVAL;
>> +	}
>> +
>> +	tuple->link = NULL;
>> +	tuple->prog = prog;
>> +	return 0;
>> +}
[...]
>> +static int bpf_mprog_pos_before(struct bpf_mprog_entry *entry,
>> +				struct bpf_tuple *tuple)
>> +{
>> +	struct bpf_mprog_fp *fp;
>> +	struct bpf_mprog_cp *cp;
>> +	int i;
>> +
>> +	for (i = 0; i < bpf_mprog_total(entry); i++) {
>> +		bpf_mprog_read(entry, i, &fp, &cp);
>> +		if (tuple->prog == READ_ONCE(fp->prog) &&
> 
> Both attach/detach happen under rtnl, why do need READ_ONCE? I'm assuming
> even going forwrad, attach/detach from non-tcx places will happen
> under lock?
> 
> (same for bpf_mprog_pos_before/bpf_mprog_pos_after)
> 
> Feels like the only place where we need WRITE_ONCE is the replace (in-place)
> and READ_ONCE during fast-path. Why do we need the rest?

Yes, the replace case is via WRITE_ONCE, hence the READ_ONCE annotations. You
are saying that for the cases where we are under lock we should just drop the
READ_ONCE annotations? I can do that ofc, I thought the general convention was
to do the {READ,WRITE}_ONCE consistently for the purpose of documenting fp->prog
access.

>> +		    (!tuple->link || tuple->link == cp->link))
>> +			return i - 1;
>> +	}
>> +	return tuple->prog ? -ENOENT : -1;
>> +}
>> +
>> +static int bpf_mprog_pos_after(struct bpf_mprog_entry *entry,
>> +			       struct bpf_tuple *tuple)
>> +{
>> +	struct bpf_mprog_fp *fp;
>> +	struct bpf_mprog_cp *cp;
>> +	int i;
>> +
>> +	for (i = 0; i < bpf_mprog_total(entry); i++) {
>> +		bpf_mprog_read(entry, i, &fp, &cp);
>> +		if (tuple->prog == READ_ONCE(fp->prog) &&
>> +		    (!tuple->link || tuple->link == cp->link))
>> +			return i + 1;
>> +	}
>> +	return tuple->prog ? -ENOENT : bpf_mprog_total(entry);
>> +}
>> +
>> +int bpf_mprog_attach(struct bpf_mprog_entry *entry, struct bpf_prog *prog_new,
>> +		     struct bpf_link *link, struct bpf_prog *prog_old,
>> +		     u32 flags, u32 object, u64 revision)
>> +{
>> +	struct bpf_tuple rtuple, ntuple = {
>> +		.prog = prog_new,
>> +		.link = link,
>> +	}, otuple = {
>> +		.prog = prog_old,
>> +		.link = link,
>> +	};
>> +	int ret, idx = -2, tidx;
>> +
>> +	if (revision && revision != bpf_mprog_revision(entry))
>> +		return -ESTALE;
>> +	if (bpf_mprog_exists(entry, prog_new))
>> +		return -EEXIST;
>> +	ret = bpf_mprog_tuple_relative(&rtuple, object,
>> +				       flags & ~BPF_F_REPLACE,
>> +				       prog_new->type);
>> +	if (ret)
>> +		return ret;
>> +	if (flags & BPF_F_REPLACE) {
>> +		tidx = bpf_mprog_pos_exact(entry, &otuple);
>> +		if (tidx < 0) {
>> +			ret = tidx;
>> +			goto out;
>> +		}
>> +		idx = tidx;
>> +	}
> 
> [..]
> 
>> +	if (flags & BPF_F_BEFORE) {
>> +		tidx = bpf_mprog_pos_before(entry, &rtuple);
>> +		if (tidx < -1 || (idx >= -1 && tidx != idx)) {
>> +			ret = tidx < -1 ? tidx : -EDOM;
>> +			goto out;
>> +		}
>> +		idx = tidx;
>> +	}
>> +	if (flags & BPF_F_AFTER) {
>> +		tidx = bpf_mprog_pos_after(entry, &rtuple);
>> +		if (tidx < 0 || (idx >= -1 && tidx != idx)) {
>> +			ret = tidx < 0 ? tidx : -EDOM;
>> +			goto out;
>> +		}
>> +		idx = tidx;
>> +	}
> 
> There still seems to be some inter-dependency between F_BEFORE and F_AFTER?
> IOW, looks like I can pass F_BEFORE|F_AFTER|F_REPLACE. Do we need that?
> Why not exclusive cases?

I reworked this as per Andrii's suggestion/preference from v2 [0], iow, to calculate
target index and bail out if the request cannot be resolved into a common index.

   [0] https://lore.kernel.org/bpf/CAEf4BzbsUMnP7WMm3OmJznvD2b03B1qASFRNiDoVAU6XvvTZNA@mail.gmail.com/

>> +	if (idx < -1) {
>> +		if (rtuple.prog || flags) {
>> +			ret = -EINVAL;
>> +			goto out;
>> +		}
>> +		idx = bpf_mprog_total(entry);
>> +		flags = BPF_F_AFTER;
>> +	}
>> +	if (idx >= bpf_mprog_max()) {
>> +		ret = -EDOM;
>> +		goto out;
>> +	}
>> +	if (flags & BPF_F_REPLACE)
>> +		ret = bpf_mprog_replace(entry, &ntuple, idx);
>> +	else
>> +		ret = bpf_mprog_insert(entry, &ntuple, idx, flags);
>> +out:
>> +	bpf_mprog_tuple_put(&rtuple);
>> +	return ret;
>> +}
>> +

