Return-Path: <bpf+bounces-4610-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C18274D904
	for <lists+bpf@lfdr.de>; Mon, 10 Jul 2023 16:26:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA526281326
	for <lists+bpf@lfdr.de>; Mon, 10 Jul 2023 14:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95F6812B71;
	Mon, 10 Jul 2023 14:26:37 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5606812B60;
	Mon, 10 Jul 2023 14:26:36 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF22513D;
	Mon, 10 Jul 2023 07:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:References:Cc:To:From:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=ohEdGKPZvhvzUNxRJZaZW8aiUuaLB9xk1W3UJmBQx2E=; b=e5N9939L/5MxT23JHwFhZS5n6e
	2+3bR0rt7NrJLLy+gVLoP5IVCp+fwZWdMfonDJ1dYUbDX9F/1/L39qMSuHOUK+zzbl8osKydyPVhK
	FxSpVer4+IiEiMjBXpX+T5Fwvm3qTbk1rYCEFK5qwVqb7UakZNjNpW+BWF8mWi+HaXG2JUwYLpBUC
	hHPz17KU39B25TnKRkNTjcimwLqgO4YJNEhhxVQgMPXyaartP+LZlfBu1a96avIJ47ZqfHV0T8oaF
	UeYhCyUhv/Z64E/MOSrJ+ShNNwvU10mA1yKKzZnRls3zSHRXTQtV1yn5xq1cQBO9XIKX5XMcL5hqp
	Ee1Uz0Vw==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qIrqH-0000Mm-Qa; Mon, 10 Jul 2023 16:26:21 +0200
Received: from [85.1.206.226] (helo=linux.home)
	by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1qIrqH-000RCF-9A; Mon, 10 Jul 2023 16:26:21 +0200
Subject: Re: [PATCH bpf-next v3 1/8] bpf: Add generic attach/detach/query API
 for multi-progs
From: Daniel Borkmann <daniel@iogearbox.net>
To: Stanislav Fomichev <sdf@google.com>
Cc: ast@kernel.org, andrii@kernel.org, martin.lau@linux.dev,
 razor@blackwall.org, john.fastabend@gmail.com, kuba@kernel.org,
 dxu@dxuuu.xyz, joe@cilium.io, toke@kernel.org, davem@davemloft.net,
 bpf@vger.kernel.org, netdev@vger.kernel.org
References: <20230707172455.7634-1-daniel@iogearbox.net>
 <20230707172455.7634-2-daniel@iogearbox.net> <ZKiDKuoovyikz8Mm@google.com>
 <d67ca0f4-4753-e86f-f8ca-dd515f941ea5@iogearbox.net>
Message-ID: <c378dd03-2950-ab2f-26bb-65e2757433b7@iogearbox.net>
Date: Mon, 10 Jul 2023 16:26:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <d67ca0f4-4753-e86f-f8ca-dd515f941ea5@iogearbox.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.8/26965/Mon Jul 10 09:29:40 2023)
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 7/10/23 9:42 AM, Daniel Borkmann wrote:
> On 7/7/23 11:27 PM, Stanislav Fomichev wrote:
>> On 07/07, Daniel Borkmann wrote:
> [...]
>>> +static inline struct bpf_mprog_entry *
>>> +bpf_mprog_create(const size_t size, const off_t off)
>>> +{
>>> +    struct bpf_mprog_bundle *bundle;
>>> +    void *ptr;
>>> +
>>> +    BUILD_BUG_ON(size < sizeof(*bundle) + off);
>>> +    BUILD_BUG_ON(sizeof(bundle->a.fp_items[0]) > sizeof(u64));
>>> +    BUILD_BUG_ON(ARRAY_SIZE(bundle->a.fp_items) !=
>>> +             ARRAY_SIZE(bundle->cp_items));
>>> +
>>> +    ptr = kzalloc(size, GFP_KERNEL);
>>> +    if (ptr) {
>>> +        bundle = ptr + off;
>>> +        atomic64_set(&bundle->revision, 1);
>>> +        bundle->off = off;
>>> +        bundle->a.parent = bundle;
>>> +        bundle->b.parent = bundle;
>>> +        return &bundle->a;
>>> +    }
>>> +    return NULL;
>>> +}
>>> +
>>> +void bpf_mprog_free_rcu(struct rcu_head *rcu);
>>> +
>>> +static inline void bpf_mprog_free(struct bpf_mprog_entry *entry)
>>> +{
>>> +    struct bpf_mprog_bundle *bundle = entry->parent;
>>> +
>>> +    call_rcu(&bundle->rcu, bpf_mprog_free_rcu);
>>> +}
>>
>> Any reason we're doing allocation here? Why not do
>> bpf_mprog_init(struct bpf_mprog_bundle *) instead that simply initializes
>> the fields? Then we can move allocation/free part to the caller (tcx) along
>> with rcu_head.
>> Feels like it would be a bit more conventional/readable? bpf_mprog_free{,_rcu}
>> will also become tcx_free{,_rcu}..
>>
>> I guess current approach works, but it took me awhile to figure it out..
>> (maybe it's just me)
> 
> I found this approach quite useful for tcx case since we only fetch the
> bpf_mprog_entry for tcx_link_prog_attach et al, but I can take a look to
> see if this looks better and if it does I'll include it.

Ok, I moved this into tcx and only left bpf_mprog_bundle_init() in mprog.
Looks better indeed, thanks Stan!

