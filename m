Return-Path: <bpf+bounces-42814-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 270779AB613
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 20:45:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76D55B21CD9
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 18:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7DAB1C9EB7;
	Tue, 22 Oct 2024 18:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HhNfyiYy"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE50E17C98
	for <bpf@vger.kernel.org>; Tue, 22 Oct 2024 18:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729622691; cv=none; b=bmpNx+yQZjmeCOPPPWwwpgmFNIWhM7dl7nlKKbLEUbS1Qiq7lIOKfl/c4psz5Ew6Gj6HN7ezq0lkKeU0hO6ZdHytTrZy99X4t1PTjzvX0/s+Cg0po4EhO3yfTvvITgEXegNPzd+7VMSEU+TKYh5C8EFA1WEhGSI4XVmxfTssY5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729622691; c=relaxed/simple;
	bh=DenbsdJjxNWLj7vQ51f4oivMJlAacm+ITX0DAbKCaHM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qhf2zNLTIQ8c+QDH1mGZBKT1ns0LauS9fCk1W5a60WznRh/OTmfcwWrKBu5ToqO6nNiYBy1YGMAsi3XU6mW5ouMD2uInBDH5Y8qb7WJkM7k1pngYvcplDcow1HmAUlROlhj4laYuv3ChRvRcj1YriRTngw5DD7H9T3nBiZ7K04Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HhNfyiYy; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-37d6a2aa748so3931877f8f.1
        for <bpf@vger.kernel.org>; Tue, 22 Oct 2024 11:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729622688; x=1730227488; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kd/jQXIUpm9vOJwW68Nw9V5n27F+Gu8tJKxVM+kwVkE=;
        b=HhNfyiYyW/F7QUA8Sh91vUFUOCHpcjBdOgg3/9heApOwICvQ8c+R4Fw0nsRQ3L17Qm
         BP+mga1/wPQopP+2f9nhmI7yAzrvNl5Qfo6L1k3ziW3vUq8BzOZxBfwLQejbDNWwqm1w
         tSevHi6cWn26wIHc831x/wkN+N6YJfDPhwPWZCriqBZA8+4t7wTX+KP0o/jDx/8amF/b
         +My7X1zTFOaGRLEZplji0jgHCpaN7iCzpNex2aW+/zGS+qeKxdyjnNrQI5fc3Gl/x5QV
         Xb7PLm5PMThmhI4x7FJVyUelGcs3S77v5BdgjL2jQxZ6NiCyqRBdLxU8i/YeDBvDbm9I
         zwDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729622688; x=1730227488;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kd/jQXIUpm9vOJwW68Nw9V5n27F+Gu8tJKxVM+kwVkE=;
        b=CJlbtE+w8CE2u0RQ87X+rHy4To4sHbG+H6PC7p7YJcScxUQNUTLTuHHVzppq81uNM6
         LZR7PTsWQAKMV33AmxK0FV/beWZIj2HNd2N8/325JFTpSaDY6x+UMpGvNHL9KXpVeu5p
         ZHNhhATWWMyXe5DTzD44vMc5EEwhS32iQkO5I5CVMLPF+P0Ht7kCyNHxC6HE6W3uFrJU
         dERSaAs+Hfdk/JLEigyjsvEBWFc4+biuSuBF5jTGIZFeDVZWHg/mKtDfd7XEIY9z+OXk
         /3W8MJpJMycYcU/GthfnTjSFzQHeBrxb4UJ+ChzDhbRFJF5UwBfwPDVNcRLwJ5NVH5Gv
         ZJuQ==
X-Gm-Message-State: AOJu0Yz46QgWBkZHcbU8ioYvQGD52Jlweh0qvVocKGx5QmhaYShZhdAk
	9Lvw+O84d63+RAbeBFuleSIXxNo6swaP0zttSGLNpzxBsnLcuU2NnSIGNNMiViikSl3RWzlMu4S
	1o55h07BLy62pqDbV6AnghjcKjQw=
X-Google-Smtp-Source: AGHT+IEDlTaBsgUxwHWEwg3KtW92RipD1P9wX13FrUVGB7dgBfE3bHU25YvfZR/tDs91QCiFcImk6L2U0oY6PZseYlM=
X-Received: by 2002:adf:ec84:0:b0:37d:461d:b1ea with SMTP id
 ffacd0b85a97d-37efb81109amr317034f8f.48.1729622687291; Tue, 22 Oct 2024
 11:44:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008091501.8302-1-houtao@huaweicloud.com> <20241008091501.8302-4-houtao@huaweicloud.com>
 <CAADnVQKmkaYJixBrJpWPDpHM9R9jq91meY9bERCVaC11CN4G_w@mail.gmail.com>
 <b2ceb4b4-e9bf-dc07-86ac-c7c3edbd4d04@huaweicloud.com> <CAADnVQL=GB7LoCQ=ceyxJDHRFudnHGsQXVMMMJa90H-70vwnpQ@mail.gmail.com>
 <5bc378ac-b9a0-66b8-e7d3-94852f05ba37@huaweicloud.com>
In-Reply-To: <5bc378ac-b9a0-66b8-e7d3-94852f05ba37@huaweicloud.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 22 Oct 2024 11:44:35 -0700
Message-ID: <CAADnVQ+n_aXL5y8vte7VRajqx7intQ2bb01CS+grVA6Hz1hCvQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 03/16] bpf: Parse bpf_dynptr in map key
To: Hou Tao <houtao@huaweicloud.com>
Cc: bpf <bpf@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>, 
	Yonghong Song <yonghong.song@linux.dev>, Daniel Borkmann <daniel@iogearbox.net>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Hou Tao <houtao1@huawei.com>, 
	Xu Kuohai <xukuohai@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 22, 2024 at 12:20=E2=80=AFAM Hou Tao <houtao@huaweicloud.com> w=
rote:
>
> Hi,
>
> On 10/22/2024 11:59 AM, Alexei Starovoitov wrote:
> > On Mon, Oct 21, 2024 at 7:02=E2=80=AFAM Hou Tao <houtao@huaweicloud.com=
> wrote:
> >> Hi,
> >>
> >> On 10/12/2024 12:29 AM, Alexei Starovoitov wrote:
> >>> On Tue, Oct 8, 2024 at 2:02=E2=80=AFAM Hou Tao <houtao@huaweicloud.co=
m> wrote:
> >>>> +#define MAX_DYNPTR_CNT_IN_MAP_KEY 4
> >>>> +
> >>>>  static int map_check_btf(struct bpf_map *map, struct bpf_token *tok=
en,
> >>>>                          const struct btf *btf, u32 btf_key_id, u32 =
btf_value_id)
> >>>>  {
> >>>> @@ -1103,6 +1113,40 @@ static int map_check_btf(struct bpf_map *map,=
 struct bpf_token *token,
> >>>>         if (!value_type || value_size !=3D map->value_size)
> >>>>                 return -EINVAL;
> >>>>
> >>>> +       if (btf_type_is_dynptr(btf, key_type))
> >>>> +               map->key_record =3D btf_new_bpf_dynptr_record();
> >>>> +       else
> >>>> +               map->key_record =3D btf_parse_fields(btf, key_type, =
BPF_DYNPTR, map->key_size);
> >>>> +       if (!IS_ERR_OR_NULL(map->key_record)) {
> >>>> +               if (map->key_record->cnt > MAX_DYNPTR_CNT_IN_MAP_KEY=
) {
> >>>> +                       ret =3D -E2BIG;
> >>>> +                       goto free_map_tab;
> >>> Took me a while to grasp that map->key_record is only for dynptr fiel=
ds
> >>> and map->record is for the rest except dynptr fields.
> >>>
> >>> Maybe rename key_record to dynptr_fields ?
> >>> Or at least add a comment to struct bpf_map to explain
> >>> what each btf_record is for.
> >> I was trying to rename map->record to map->value_record, however, I wa=
s
> >> afraid that it may introduce too much churn, so I didn't do that. But =
I
> >> think it is a good idea to add comments for both btf_record. And
> >> considering that only bpf_dynptr is enabled for map key, renaming it t=
o
> >> dynptr_fields seems reasonable as well.
> >>> It's kinda arbitrary decision to support multiple dynptr-s per key
> >>> while other fields are not.
> >>> Maybe worth looking at generalizing it a bit so single btf_record
> >>> can have multiple of certain field kinds?
> >>> In addition to btf_record->cnt you'd need btf_record->dynptr_cnt
> >>> but that would be easier to extend in the future ?
> >> Map value has already supported multiple kptrs or bpf_list_node.
> > fwiw I believe we reached the dead end there.
> > The whole support for bpf_list and bpf_rb_tree may get deprecated
> > and removed. The expected users didn't materialize.
>
> OK.
> >
> >> And in
> >> the discussion [1], I thought multiple dynptr support in map key is
> >> necessary, so I enabled it.
> >>
> >> [1]:
> >> https://lore.kernel.org/bpf/CAADnVQJWaBRB=3DP-ZNkppwm=3D0tZaT3qP8PKLLJ=
2S5SSA2-S8mxg@mail.gmail.com/
> > Sure. That's a different reasoning and use case.
> > I'm proposing to use a single btf_record with different cnt-s.
> > The current btf_record->cnt will stay as-is indicating total number of =
fields
> > while btf_record->dynptr_cnt will be just for these dynptrs you're intr=
oducing.
> > Then you won't need two top level btf_record-s.
>
> I misunderstood your suggestion yesterday. Now I see what you are
> suggesting. However, it seems using a separated counter for different
> kinds of btf_field will only benefit dynptr field, because other types
> doesn't need to iterate all field instead they just need to find one
> through binary search. And I don't understand why only one btf_record
> will be enough, because these two btf_records are derived from map key
> and map value respectively.

If we have two btf records (one for key and one for value)
then it's fine.
For now btf_record for key will only have multiple
dynptr-s in there as special fields and it's fine too.
But we need to document it and when the need arises to have
dynptr-s in value or kptr/timers/whatever in a key
then we shouldn't add a 3rd and 4th btf records to
separate different kinds of special fields.

