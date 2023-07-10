Return-Path: <bpf+bounces-4624-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 562F874DD58
	for <lists+bpf@lfdr.de>; Mon, 10 Jul 2023 20:30:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCFE42812DA
	for <lists+bpf@lfdr.de>; Mon, 10 Jul 2023 18:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2790B14AAB;
	Mon, 10 Jul 2023 18:29:52 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC78C13AF9;
	Mon, 10 Jul 2023 18:29:51 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6B08180;
	Mon, 10 Jul 2023 11:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=a8+MiCiJThwksTeBz4oIft3DmVmR2gr+UYVJcopCf9Y=; b=Lc/5iBFt5aaHXrrRF317JwYkKJ
	lxYnjY93C3H4+EZX+l+jmc6SxcX2i/rQs7JukSAZiv1k7JR7TlytbCkX8EmlbEoVnAsccU1iMoc6r
	XFhqVYE7rdIBjpuT4Pa62vZAkudXN9SYkxJJ3cirXztEXODvjYhdkOOAUbKJhmuad06fFMQNa4F09
	o61u50iXzK249Zp073P9r53zPmZNGJlgNyfDZBtdGTR29TsjfPS8h1iPvNk8yN8AJQmikuCLXMOfy
	B3HxxT9NxB/PBadYP2sRnf4EveZYd5yElV8KpgNoVzgkVzFGvhSvBNkDAyT4v1+AeeDKTu9gUCFbP
	L6L8E10Q==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qIvdc-0004l9-Of; Mon, 10 Jul 2023 20:29:32 +0200
Received: from [85.1.206.226] (helo=linux.home)
	by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1qIvdc-000GfY-9Y; Mon, 10 Jul 2023 20:29:32 +0200
Subject: Re: [PATCH bpf-next v3 1/8] bpf: Add generic attach/detach/query API
 for multi-progs
To: Stanislav Fomichev <sdf@google.com>
Cc: ast@kernel.org, andrii@kernel.org, martin.lau@linux.dev,
 razor@blackwall.org, john.fastabend@gmail.com, kuba@kernel.org,
 dxu@dxuuu.xyz, joe@cilium.io, toke@kernel.org, davem@davemloft.net,
 bpf@vger.kernel.org, netdev@vger.kernel.org
References: <20230707172455.7634-1-daniel@iogearbox.net>
 <20230707172455.7634-2-daniel@iogearbox.net> <ZKiDKuoovyikz8Mm@google.com>
 <d67ca0f4-4753-e86f-f8ca-dd515f941ea5@iogearbox.net>
 <ZKxLY3onuOHepOxt@google.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <ba8221bc-f3e4-8841-850f-743cec6670fb@iogearbox.net>
Date: Mon, 10 Jul 2023 20:29:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZKxLY3onuOHepOxt@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.8/26965/Mon Jul 10 09:29:40 2023)
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 7/10/23 8:18 PM, Stanislav Fomichev wrote:
> On 07/10, Daniel Borkmann wrote:
>> On 7/7/23 11:27 PM, Stanislav Fomichev wrote:
[...]
>>>> +static int bpf_mprog_prog(struct bpf_tuple *tuple,
>>>> +			  u32 object, u32 flags,
>>>> +			  enum bpf_prog_type type)
>>>> +{
>>>> +	bool id = flags & BPF_F_ID;
>>>> +	struct bpf_prog *prog;
>>>> +
>>>> +	if (id)
>>>> +		prog = bpf_prog_by_id(object);
>>>> +	else
>>>> +		prog = bpf_prog_get(object);
>>>> +	if (IS_ERR(prog)) {
>>>
>>> [..]
>>>
>>>> +		if (!object && !id)
>>>> +			return 0;
>>>
>>> What's the reason behind this?
>>
>> If an fd was passed which is 0 and this was not a program fd, then we don't error
>> out and treat it as if no fd was passed.
>   
> Is this new api an opportunity to fix that fd==0? And always treat it as
> valid. Or we have some other constrains elsewhere?

Not that I'm aware of, it should work fine in the new API.

>>>> +		return PTR_ERR(prog);
>>>> +	}
>>>> +	if (type && prog->type != type) {
>>>> +		bpf_prog_put(prog);
>>>> +		return -EINVAL;
>>>> +	}
>>>> +
>>>> +	tuple->link = NULL;
>>>> +	tuple->prog = prog;
>>>> +	return 0;
>>>> +}
>> [...]
>>>> +static int bpf_mprog_pos_before(struct bpf_mprog_entry *entry,
>>>> +				struct bpf_tuple *tuple)
>>>> +{
>>>> +	struct bpf_mprog_fp *fp;
>>>> +	struct bpf_mprog_cp *cp;
>>>> +	int i;
>>>> +
>>>> +	for (i = 0; i < bpf_mprog_total(entry); i++) {
>>>> +		bpf_mprog_read(entry, i, &fp, &cp);
>>>> +		if (tuple->prog == READ_ONCE(fp->prog) &&
>>>
>>> Both attach/detach happen under rtnl, why do need READ_ONCE? I'm assuming
>>> even going forwrad, attach/detach from non-tcx places will happen
>>> under lock?
>>>
>>> (same for bpf_mprog_pos_before/bpf_mprog_pos_after)
>>>
>>> Feels like the only place where we need WRITE_ONCE is the replace (in-place)
>>> and READ_ONCE during fast-path. Why do we need the rest?
>>
>> Yes, the replace case is via WRITE_ONCE, hence the READ_ONCE annotations. You
>> are saying that for the cases where we are under lock we should just drop the
>> READ_ONCE annotations? I can do that ofc, I thought the general convention was
>> to do the {READ,WRITE}_ONCE consistently for the purpose of documenting fp->prog
>> access.
> 
> I see, then maybe let's keep them. I was a bit confused because those
> READ_ONCE are within a locked section so I wasn't sure whether I'm
> missing something or it's working as intended :-)

Okay. I added the explanation around locking in the big comment I sent in the
other thread to Alexei.

>>>> +		    (!tuple->link || tuple->link == cp->link))
>>>> +			return i - 1;
>>>> +	}
>>>> +	return tuple->prog ? -ENOENT : -1;
>>>> +}
>>>> +
>>>> +static int bpf_mprog_pos_after(struct bpf_mprog_entry *entry,
>>>> +			       struct bpf_tuple *tuple)
>>>> +{
>>>> +	struct bpf_mprog_fp *fp;
>>>> +	struct bpf_mprog_cp *cp;
>>>> +	int i;
>>>> +
>>>> +	for (i = 0; i < bpf_mprog_total(entry); i++) {
>>>> +		bpf_mprog_read(entry, i, &fp, &cp);
>>>> +		if (tuple->prog == READ_ONCE(fp->prog) &&
>>>> +		    (!tuple->link || tuple->link == cp->link))
>>>> +			return i + 1;
>>>> +	}
>>>> +	return tuple->prog ? -ENOENT : bpf_mprog_total(entry);
>>>> +}
>>>> +
>>>> +int bpf_mprog_attach(struct bpf_mprog_entry *entry, struct bpf_prog *prog_new,
>>>> +		     struct bpf_link *link, struct bpf_prog *prog_old,
>>>> +		     u32 flags, u32 object, u64 revision)
>>>> +{
>>>> +	struct bpf_tuple rtuple, ntuple = {
>>>> +		.prog = prog_new,
>>>> +		.link = link,
>>>> +	}, otuple = {
>>>> +		.prog = prog_old,
>>>> +		.link = link,
>>>> +	};
>>>> +	int ret, idx = -2, tidx;
>>>> +
>>>> +	if (revision && revision != bpf_mprog_revision(entry))
>>>> +		return -ESTALE;
>>>> +	if (bpf_mprog_exists(entry, prog_new))
>>>> +		return -EEXIST;
>>>> +	ret = bpf_mprog_tuple_relative(&rtuple, object,
>>>> +				       flags & ~BPF_F_REPLACE,
>>>> +				       prog_new->type);
>>>> +	if (ret)
>>>> +		return ret;
>>>> +	if (flags & BPF_F_REPLACE) {
>>>> +		tidx = bpf_mprog_pos_exact(entry, &otuple);
>>>> +		if (tidx < 0) {
>>>> +			ret = tidx;
>>>> +			goto out;
>>>> +		}
>>>> +		idx = tidx;
>>>> +	}
>>>
>>> [..]
>>>
>>>> +	if (flags & BPF_F_BEFORE) {
>>>> +		tidx = bpf_mprog_pos_before(entry, &rtuple);
>>>> +		if (tidx < -1 || (idx >= -1 && tidx != idx)) {
>>>> +			ret = tidx < -1 ? tidx : -EDOM;
>>>> +			goto out;
>>>> +		}
>>>> +		idx = tidx;
>>>> +	}
>>>> +	if (flags & BPF_F_AFTER) {
>>>> +		tidx = bpf_mprog_pos_after(entry, &rtuple);
>>>> +		if (tidx < 0 || (idx >= -1 && tidx != idx)) {
>>>> +			ret = tidx < 0 ? tidx : -EDOM;
>>>> +			goto out;
>>>> +		}
>>>> +		idx = tidx;
>>>> +	}
>>>
>>> There still seems to be some inter-dependency between F_BEFORE and F_AFTER?
>>> IOW, looks like I can pass F_BEFORE|F_AFTER|F_REPLACE. Do we need that?
>>> Why not exclusive cases?
>>
>> I reworked this as per Andrii's suggestion/preference from v2 [0], iow, to calculate
>> target index and bail out if the request cannot be resolved into a common index.
>>
>>    [0] https://lore.kernel.org/bpf/CAEf4BzbsUMnP7WMm3OmJznvD2b03B1qASFRNiDoVAU6XvvTZNA@mail.gmail.com/
> 
> SG! Let's maybe put a summary in the header of what the expectation is when
> combining them?

Yes, will add a comment sounds good.

Thanks,
Daniel

