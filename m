Return-Path: <bpf+bounces-17778-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D936812655
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 05:18:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9B492827F5
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 04:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF727469E;
	Thu, 14 Dec 2023 04:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="daK8LOgR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3845EF4
	for <bpf@vger.kernel.org>; Wed, 13 Dec 2023 20:17:59 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-334af3b3ddfso6832368f8f.3
        for <bpf@vger.kernel.org>; Wed, 13 Dec 2023 20:17:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702527477; x=1703132277; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sDUZR3Km74y9Sl5SQmAwbWzIp7aiwhFxGgDMcOhxNxE=;
        b=daK8LOgR6ztIN3VWoYUMRxT7dQilskaOmpO60nkitWzLV3eonMlY2MUrwUadWDcTDs
         OPI1FVl0VpjNn2myYZL0LFfyLZQjr6wAiaRR8i2vpcQVg1CSkySXLiqU/HnBF5htT5xH
         67QT2DqjKe21l1Jq0XbUIk6kVGJhAKX4ebUBJwXt+H9hYy6mWHZHepiJM2ZESj5YQrtU
         V96RlEy2gjcaP2XWW5ZRuqRWwG4I5vUphisecIpDJyd+knqhEbsiXEzAJ3bsArvoI+4X
         TNtzT7znqluFZfZiVOOeZfUm0tgWvN/VtYgEIITzIIWsinsae1DENpMPzUUf+VWlRCWp
         NPyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702527477; x=1703132277;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sDUZR3Km74y9Sl5SQmAwbWzIp7aiwhFxGgDMcOhxNxE=;
        b=Eq5WnPX/VG7UhgSQqyHZK/4LXEmb9CJTZT13BgYVrYDRcSXOOBgqG9tGlKAGDkFhkt
         OEfkKzjbMhZDRoRwRqsGoXkGUKSswJSPLTSFGfWHL8GHbgWPIwiHwqSM0vp6QArRR1qt
         9vL4TgBPJQxSe/ar/PgYvXgnYPzrGBWV9wQ9F6/FMEXmMpGAY1DNX1D15szTClFE83gM
         SEy3JPlprxTFC8Hza0ZsmTHByW5l8yo5jIgeQareq3FsSjWtW6H0StZXLmuAWzduKTQZ
         WUYKFoKA6EL+5nShqtekqyq1aw40bqiSYS91GfgKmmkY5Gw1j+5iWg+UQp7UW8RRbvbW
         KxqQ==
X-Gm-Message-State: AOJu0Yzf8LfRwuj54nI6HCRXDz/0I0Zi464+CDZQ+32XMa/YwUu/bgC2
	XMHtT7KmRvDU+ASd2KKB7TsKC8n/BDO9CcDhLTYcIFasGqo=
X-Google-Smtp-Source: AGHT+IGu0nwokm0WrEBpVm2Ur5+U0KHNWpLSD9zb1TpyoGA8HSoh0zbqCa2ld6RHsv1ZL9HxR1KpzooGmwUUTkH7oK4=
X-Received: by 2002:adf:e849:0:b0:336:43b0:33fc with SMTP id
 d9-20020adfe849000000b0033643b033fcmr718861wrn.36.1702527477444; Wed, 13 Dec
 2023 20:17:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231206210959.1035724-1-yonghong.song@linux.dev>
 <d1c0232c-a41c-4cce-9bdf-3a1e8850ed05@linux.dev> <969852f3-34f8-45d9-bf2d-f6a4d5167e55@linux.dev>
 <ad71a99d-8b5f-44b4-99ee-5afb31c60bff@linux.dev> <0b3a96bd-4dfc-6d23-d473-f4351fbe84c2@huaweicloud.com>
 <0e657fc3-d932-4bd6-9d74-54eff22d3641@linux.dev>
In-Reply-To: <0e657fc3-d932-4bd6-9d74-54eff22d3641@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 13 Dec 2023 20:17:46 -0800
Message-ID: <CAADnVQJ3FiXUhZJwX_81sjZvSYYKCFB3BT6P8D59RS2Gu+0Z7g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4] bpf: Fix a race condition between btf_put()
 and map_free()
To: Yonghong Song <yonghong.song@linux.dev>
Cc: Hou Tao <houtao@huaweicloud.com>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Kernel Team <kernel-team@fb.com>, 
	Martin KaFai Lau <martin.lau@kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 8, 2023 at 9:07=E2=80=AFAM Yonghong Song <yonghong.song@linux.d=
ev> wrote:
>
>
> On 12/8/23 12:30 AM, Hou Tao wrote:
> > Hi,
> >
> > On 12/8/2023 12:02 PM, Yonghong Song wrote:
> >> On 12/7/23 7:59 PM, Yonghong Song wrote:
> >>> On 12/7/23 5:23 PM, Martin KaFai Lau wrote:
> >>>> On 12/6/23 1:09 PM, Yonghong Song wrote:
> >>>>> When running `./test_progs -j` in my local vm with latest kernel,
> >>>>> I once hit a kasan error like below:
> >>>>>
> >>>>>
> > SNIP
> >>>>> Here, 'value_rec' is assigned in btf_check_and_fixup_fields() with
> >>>>> following code:
> >>>>>
> >>>>>     meta =3D btf_find_struct_meta(btf, btf_id);
> >>>>>     if (!meta)
> >>>>>       return -EFAULT;
> >>>>>     rec->fields[i].graph_root.value_rec =3D meta->record;
> >>>>>
> >>>>> So basically, 'value_rec' is a pointer to the record in
> >>>>> struct_metas_tab.
> >>>>> And it is possible that that particular record has been freed by
> >>>>> btf_struct_metas_free() and hence we have a kasan error here.
> >>>>>
> >>>>> Actually it is very hard to reproduce the failure with current
> >>>>> bpf/bpf-next
> >>>>> code, I only got the above error once. To increase reproducibility,
> >>>>> I added
> >>>>> a delay in bpf_map_free_deferred() to delay map->ops->map_free(),
> >>>>> which
> >>>>> significantly increased reproducibility.
> >>>>>
> >>>>>     diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> >>>>>     index 5e43ddd1b83f..aae5b5213e93 100644
> >>>>>     --- a/kernel/bpf/syscall.c
> >>>>>     +++ b/kernel/bpf/syscall.c
> >>>>>     @@ -695,6 +695,7 @@ static void bpf_map_free_deferred(struct
> >>>>> work_struct *work)
> >>>>>           struct bpf_map *map =3D container_of(work, struct bpf_map=
,
> >>>>> work);
> >>>>>           struct btf_record *rec =3D map->record;
> >>>>>
> >>>>>     +     mdelay(100);
> >>>>>           security_bpf_map_free(map);
> >>>>>           bpf_map_release_memcg(map);
> >>>>>           /* implementation dependent freeing */
> >>>>>
> >>>>> To fix the problem, we need to have a reference on btf in order to
> >>>>> safeguard accessing field->graph_root.value_rec in
> >>>>> map->ops->map_free().
> >>>>> The function btf_parse_graph_root() is the place to get a btf
> >>>>> reference.
> >>>>> The following are rough call stacks reaching bpf_parse_graph_root()=
:
> >>>>>
> >>>>>      btf_parse
> >>>>>        ...
> >>>>>          btf_parse_fields
> >>>>>            ...
> >>>>>              btf_parse_graph_root
> >>>>>
> >>>>>      map_check_btf
> >>>>>        btf_parse_fields
> >>>>>          ...
> >>>>>            btf_parse_graph_root
> >>>>>
> >>>>> Looking at the above call stack, the btf_parse_graph_root() is
> >>>>> indirectly
> >>>>> called from btf_parse() or map_check_btf().
> >>>>>
> >>>>> We cannot take a reference in btf_parse() case since at that moment=
,
> >>>>> btf is still in the middle to self-validation and initial reference
> >>>>> (refcount_set(&btf->refcnt, 1)) has not been triggered yet.
> >>>> Thanks for the details analysis and clear explanation. It helps a lo=
t.
> >>>>
> >>>> Sorry for jumping in late.
> >>>>
> >>>> I am trying to avoid making a special case for "bool has_btf_ref;"
> >>>> and "bool from_map_check". It seems to a bit too much to deal with
> >>>> the error path for btf_parse().
> > Maybe we could move the common btf used by kptr and graph_root into
> > bpf_record and let the callers of btf_parse_fields()  and
> > btf_record_free() to decide the life cycle of btf in btf_record, so
> > there will be less intrusive and less special case. The following is th=
e
>
> I didn't fully check the code but looks like we took a
> btf reference at map_check_btf() and free it at the end
> of bpf_map_free_deferred(). This is similar to my v1 patch,
> not exactly the same but similar since they all do
> btf_put() at the end of bpf_map_free_deferred().
>
> Through discussion, doing on-demand btf_get()/btf_put()
> approach, similar to kptr approach, seems more favored.
> This also has advantage to free btf at its earlist possible
> point.

Sorry. Looks like I recommended the wrong path.

The approach of btf_parse_fields(... false | true)
depending on where it's called and whether returned struct btf_record *
will be kept within a type or within a map
is pushing complexity too far.
A year from now we'll forget these subtle details.
There is an advantage to do btf_put() earli in bpf_map_put(),
but in the common case it would be delayed just after queue_work.
Which is a minor time delay.
And for free_after_mult_rcu_gp much longer,
but saving from freeing btf are minor compared to the map itself.

I think it's cleaner to go back to v1 and simply move btf_put
to bpf_map_free_deferred().
A lot less things to worry about.
Especially considering that BPF_RB_ROOT may not be the last such special
record keeping type and every new type would need to think
hard whether it's BPF_RB_ROOT-like or BPF_LIST_NODE-like.
v1 avoids this future complexity.

