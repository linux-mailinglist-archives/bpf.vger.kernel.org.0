Return-Path: <bpf+bounces-42739-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F0869A975B
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 05:59:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF6F9B21A25
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 03:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED0A11E529;
	Tue, 22 Oct 2024 03:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PAHSYNOc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA4F256D
	for <bpf@vger.kernel.org>; Tue, 22 Oct 2024 03:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729569562; cv=none; b=iRoeal3kC9ScbMYEs+Dv5dSKzlHhe1GllrmWiKrWFwzCxx5iaWTyfzCTsvIPvcSsSosNkN/pvAxOSQC1+f6Bs/cayU2KpQpd0h2F7uoHUlK4IxZR7VjP0EM89FUbfI5EJAbHBvbfgTYXuF3tl3mK7UaJ5GXrtHzgQViZ4pnD7nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729569562; c=relaxed/simple;
	bh=57J+zdn5bdjoIdM1/wbWETqMn6uw+2ByhCN1u2Ff3l8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HP7Zl3dQ6xUdnpl7GGusSHBUTGvtteQqSBSQ1QQGouxtIDm1SyZKu1I+FDBl4iewtHsXLAJ0ACXqkBrl/V3iGvYwkO7U8iMOjcRGrArOvba/9Cx1nnCgL99YArvVry93flAJdJ0bIh6PpNMyf4G8Iy31alhtRDkKpuck+1RfqqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PAHSYNOc; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4316e9f4a40so25267735e9.2
        for <bpf@vger.kernel.org>; Mon, 21 Oct 2024 20:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729569559; x=1730174359; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JsZUJELnxo36bc/web3Ys+G8lN/3urfx8L/UGdK97qI=;
        b=PAHSYNOcEQaptElWVsTAYKGK1jyFdghJ8s6RxtOkyBXkyK/uJKPca4BhufTv/Fc+Sv
         H3TIX6/U/zXVJ+ErtdQLfHfo9F3hbx8b6pGOwE4ZgbIaSoL/oovhNC7HKr+9y0ZpToJj
         DB1cxWNCuooAEPjQ5Y746BNsIkmgyzKcm2qgv+Q/fwbtalO/9kJLFkDAc3zgeOyZJGgt
         4fO2+hpbwkyd195MstcmlFuT5hJN5dDCYNvglxGGCOS8qUWpxHc0+CwzDa4E0ptfR5Qe
         +h7i899Cgfwn3NcWy+J6yhVsl8UCvYg/xpbqR93jF+a/VfW9hE/SVZC/v9P0VmWXghkD
         xDSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729569559; x=1730174359;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JsZUJELnxo36bc/web3Ys+G8lN/3urfx8L/UGdK97qI=;
        b=h/OuNMhJDKYucKZbvVXNDRL6O3NoWynmRUOqqIkR/LNBWzaJUvlwOPOJnJWGn4WqhU
         6CIzkrIyI0xYkaaDTCIHEdVPGni0fM9u2DEyCnpddO41cqK3C/4Xq22b1PSwQWSxVpDt
         p5MKGXnnMJCgb0t+muTQDZ3ihXcQgHpjk4EuxkMQPx1Aai0ubd7kwcTildaQMRt70LmC
         CbKo41ix4tZ3zsjL1Wlm0fNDWe3tgld/1E8ko+SSJ+WPUeuFyFXTkQyB7OtBDfBaxqDD
         +4HmD962zC146j4ozEiUR2vpGee0ldN4jOyLujrZVr8gXMLi4EqBLsS8RsjizhZaPqQS
         vULw==
X-Gm-Message-State: AOJu0YyHDIY3a+2aZsOHFWkU/BZqHmYBe7Sr3Ta5lAYkVKFmBkL2sFxv
	5Uo5C3hNjkz6wI4hSILVBjBGez1PheaVkZfDZsOPEszviRr9zMkOLY1ZaOzc7IXfm/XkckrAHza
	NQDek//iSP9yzrIkaL3ZUgB8Z8SWA6w==
X-Google-Smtp-Source: AGHT+IE/9OZVYqEcxUu7aSEfvE38S3AwnuBfdkl44RSjeekoCVctVL1x7CsTn0CZwOzUfaUym3lQ02By6EFApKoI1A8=
X-Received: by 2002:a05:600c:21cb:b0:431:4fa0:2e0b with SMTP id
 5b1f17b1804b1-43161688071mr106917865e9.28.1729569558932; Mon, 21 Oct 2024
 20:59:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008091501.8302-1-houtao@huaweicloud.com> <20241008091501.8302-4-houtao@huaweicloud.com>
 <CAADnVQKmkaYJixBrJpWPDpHM9R9jq91meY9bERCVaC11CN4G_w@mail.gmail.com> <b2ceb4b4-e9bf-dc07-86ac-c7c3edbd4d04@huaweicloud.com>
In-Reply-To: <b2ceb4b4-e9bf-dc07-86ac-c7c3edbd4d04@huaweicloud.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 21 Oct 2024 20:59:07 -0700
Message-ID: <CAADnVQL=GB7LoCQ=ceyxJDHRFudnHGsQXVMMMJa90H-70vwnpQ@mail.gmail.com>
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

On Mon, Oct 21, 2024 at 7:02=E2=80=AFAM Hou Tao <houtao@huaweicloud.com> wr=
ote:
>
> Hi,
>
> On 10/12/2024 12:29 AM, Alexei Starovoitov wrote:
> > On Tue, Oct 8, 2024 at 2:02=E2=80=AFAM Hou Tao <houtao@huaweicloud.com>=
 wrote:
> >> +#define MAX_DYNPTR_CNT_IN_MAP_KEY 4
> >> +
> >>  static int map_check_btf(struct bpf_map *map, struct bpf_token *token=
,
> >>                          const struct btf *btf, u32 btf_key_id, u32 bt=
f_value_id)
> >>  {
> >> @@ -1103,6 +1113,40 @@ static int map_check_btf(struct bpf_map *map, s=
truct bpf_token *token,
> >>         if (!value_type || value_size !=3D map->value_size)
> >>                 return -EINVAL;
> >>
> >> +       if (btf_type_is_dynptr(btf, key_type))
> >> +               map->key_record =3D btf_new_bpf_dynptr_record();
> >> +       else
> >> +               map->key_record =3D btf_parse_fields(btf, key_type, BP=
F_DYNPTR, map->key_size);
> >> +       if (!IS_ERR_OR_NULL(map->key_record)) {
> >> +               if (map->key_record->cnt > MAX_DYNPTR_CNT_IN_MAP_KEY) =
{
> >> +                       ret =3D -E2BIG;
> >> +                       goto free_map_tab;
> > Took me a while to grasp that map->key_record is only for dynptr fields
> > and map->record is for the rest except dynptr fields.
> >
> > Maybe rename key_record to dynptr_fields ?
> > Or at least add a comment to struct bpf_map to explain
> > what each btf_record is for.
>
> I was trying to rename map->record to map->value_record, however, I was
> afraid that it may introduce too much churn, so I didn't do that. But I
> think it is a good idea to add comments for both btf_record. And
> considering that only bpf_dynptr is enabled for map key, renaming it to
> dynptr_fields seems reasonable as well.
> >
> > It's kinda arbitrary decision to support multiple dynptr-s per key
> > while other fields are not.
> > Maybe worth looking at generalizing it a bit so single btf_record
> > can have multiple of certain field kinds?
> > In addition to btf_record->cnt you'd need btf_record->dynptr_cnt
> > but that would be easier to extend in the future ?
>
> Map value has already supported multiple kptrs or bpf_list_node.

fwiw I believe we reached the dead end there.
The whole support for bpf_list and bpf_rb_tree may get deprecated
and removed. The expected users didn't materialize.

> And in
> the discussion [1], I thought multiple dynptr support in map key is
> necessary, so I enabled it.
>
> [1]:
> https://lore.kernel.org/bpf/CAADnVQJWaBRB=3DP-ZNkppwm=3D0tZaT3qP8PKLLJ2S5=
SSA2-S8mxg@mail.gmail.com/

Sure. That's a different reasoning and use case.
I'm proposing to use a single btf_record with different cnt-s.
The current btf_record->cnt will stay as-is indicating total number of fiel=
ds
while btf_record->dynptr_cnt will be just for these dynptrs you're introduc=
ing.
Then you won't need two top level btf_record-s.

