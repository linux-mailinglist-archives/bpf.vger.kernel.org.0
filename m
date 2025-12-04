Return-Path: <bpf+bounces-76024-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DA56CA252C
	for <lists+bpf@lfdr.de>; Thu, 04 Dec 2025 05:35:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ABCA33051170
	for <lists+bpf@lfdr.de>; Thu,  4 Dec 2025 04:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 108B02D9784;
	Thu,  4 Dec 2025 04:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xMToJ4wf"
X-Original-To: bpf@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08DF27713;
	Thu,  4 Dec 2025 04:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764822930; cv=none; b=pMTlDHHuqXBfGIg4hHckugJSJIBa3ygtkXr8z+EH1pTSctCh7ilaNh0zU+Kqr8X40evL4+xDv/ECJBZjZrUAYT/e306XF07RJ49DbkYtGBMFWKHD21XFJPtviONlIp1LbKAl6xNgcatgziBIIwE/8dGfg6CIt5pv4ESijKDj2Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764822930; c=relaxed/simple;
	bh=OupvrIJBOVvGVuN/pCKmAChPRV68Ig02qCZh2bN+TWw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e56dpKBb+h08e5UEAUbmfwx0xUc5X8/qq2qo70Sjn0WMJuBaPel508GhZaKVzVb/Q4l5V1Bv2XY8BCjFKDO1Th4Cft0Wdqimms6BMrzLw+UGpFXRqx6ChlHQvnfuc4z0iDrfpAxPm6cEH8MIBczjFxPj09F/1Fx6eZZAl96n6N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xMToJ4wf; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ea43e483-b329-4601-a12c-30231c3c17c2@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1764822916;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5TPGUlx0YURtHNs0m14VqbLfJxPGWknKIV0FuqQ3vuw=;
	b=xMToJ4wfVh93MhOySC18uElRGoUBptF4j4OvASZd0y+QKT/rUUKiQC+dJfbflO3oxDvM37
	SegljheXr4ChqcBmkbyfuQWXqatg1pny1dpyEv7b5dMavL28ayNuOH8WR69IzU3NYnVqxp
	jPwWptq/6lD9C8+NImgyieoeUY19zms=
Date: Wed, 3 Dec 2025 20:35:05 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 3/4] resolve_btfids: introduce enum
 btf_id_kind
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
 Nicolas Schier <nicolas.schier@linux.dev>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Alan Maguire <alan.maguire@oracle.com>, Donglin Peng
 <dolinux.peng@gmail.com>, bpf@vger.kernel.org, dwarves@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org
References: <20251127185242.3954132-1-ihor.solodrai@linux.dev>
 <20251127185242.3954132-4-ihor.solodrai@linux.dev>
 <CAEf4Bza+L_RL_d7JFFLmzkYj2dbnT8rDgqwCat2zLOekToRm-g@mail.gmail.com>
 <3f60cb6e-a36c-44b3-b80a-3a99d013e0a3@linux.dev>
 <CAEf4BzbNApf0n=Bwdar7UXBmHNJWaAmzuF68yfU4W5OYbYk2Bg@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <CAEf4BzbNApf0n=Bwdar7UXBmHNJWaAmzuF68yfU4W5OYbYk2Bg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 12/3/25 4:42 PM, Andrii Nakryiko wrote:
> On Tue, Dec 2, 2025 at 11:08 AM Ihor Solodrai <ihor.solodrai@linux.dev> wrote:
>>
>> On 12/1/25 9:27 AM, Andrii Nakryiko wrote:
>>> On Thu, Nov 27, 2025 at 10:53 AM Ihor Solodrai <ihor.solodrai@linux.dev> wrote:
>>>>
>>>> Instead of using multiple flags, make struct btf_id tagged with an
>>>> enum value indicating its kind in the context of resolve_btfids.
>>>>
>>>> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
>>>> ---
>>>>  tools/bpf/resolve_btfids/main.c | 62 ++++++++++++++++++++++-----------
>>>>  1 file changed, 42 insertions(+), 20 deletions(-)
>>>
>>> [...]
>>>
>>>>
>>>> -static struct btf_id *add_set(struct object *obj, char *name, bool is_set8)
>>>> +static struct btf_id *add_set(struct object *obj, char *name, enum btf_id_kind kind)
>>>>  {
>>>>         /*
>>>>          * __BTF_ID__set__name
>>>>          * name =    ^
>>>>          * id   =         ^
>>>>          */
>>>> -       char *id = name + (is_set8 ? sizeof(BTF_SET8 "__") : sizeof(BTF_SET "__")) - 1;
>>>> +       int prefixlen = kind == BTF_ID_KIND_SET8 ? sizeof(BTF_SET8 "__") : sizeof(BTF_SET "__");
>>>> +       char *id = name + prefixlen - 1;
>>>>         int len = strlen(name);
>>>> +       struct btf_id *btf_id;
>>>>
>>>>         if (id >= name + len) {
>>>>                 pr_err("FAILED to parse set name: %s\n", name);
>>>>                 return NULL;
>>>>         }
>>>>
>>>> -       return btf_id__add(&obj->sets, id, true);
>>>> +       btf_id = btf_id__add(&obj->sets, id, true);
>>>> +       if (btf_id)
>>>> +               btf_id->kind = kind;
>>>> +
>>>> +       return btf_id;
>>>>  }
>>>>
>>>>  static struct btf_id *add_symbol(struct rb_root *root, char *name, size_t size)
>>>>  {
>>>> +       struct btf_id *btf_id;
>>>>         char *id;
>>>>
>>>>         id = get_id(name + size);
>>>> @@ -288,7 +301,11 @@ static struct btf_id *add_symbol(struct rb_root *root, char *name, size_t size)
>>>>                 return NULL;
>>>>         }
>>>>
>>>> -       return btf_id__add(root, id, false);
>>>> +       btf_id = btf_id__add(root, id, false);
>>>> +       if (btf_id)
>>>> +               btf_id->kind = BTF_ID_KIND_SYM;
>>>
>>> seeing this pattern repeated, wouldn't it make sense to just pass this
>>> kind to btf_id__add() and set it there?
>>
>> I like the idea, because we could get rid the "unique" flag then.
>>
>> But the btf_id__add() does not necessarily create a new struct, and so
>> if we pass the kind in, what do we do with existing objects?
>> Overwrite the kind? If not, do we check for a mismatch?
>>
> 
> no idea, don't know code well enough, but your newly added code seems
> to overwrite the kind always, no?

You're right, I am overwriting here, haven't realized that.

I think I'll go with a mismatch check inside btf_id__add() in v3, that
would indicate a bug.

> 
>>>
>>>> +
>>>> +       return btf_id;
>>>>  }
>>>>
>>>
>>> [...]
>>>
>>>> @@ -643,7 +656,7 @@ static int id_patch(struct object *obj, struct btf_id *id)
>>>>         int i;
>>>>
>>>>         /* For set, set8, id->id may be 0 */
>>>> -       if (!id->id && !id->is_set && !id->is_set8) {
>>>> +       if (!id->id && id->kind == BTF_ID_KIND_SYM) {
>>>
>>> nit: comment says the exception is specifically for SET and SET8, so I
>>> think checking for those two instead of for SYM (implying that only
>>> other possible options are set and set8) would be a bit more
>>> future-proof?
>>
>> ok
>>
>>>
>>>>                 pr_err("WARN: resolve_btfids: unresolved symbol %s\n", id->name);
>>>>                 warnings++;
>>>>         }
>>>
>>> [...]
>>


