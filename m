Return-Path: <bpf+bounces-36414-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44DCE9483B0
	for <lists+bpf@lfdr.de>; Mon,  5 Aug 2024 22:45:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 680601C22155
	for <lists+bpf@lfdr.de>; Mon,  5 Aug 2024 20:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A23916BE27;
	Mon,  5 Aug 2024 20:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UaXcHito"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA5D148312
	for <bpf@vger.kernel.org>; Mon,  5 Aug 2024 20:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722890705; cv=none; b=bQFoBUkJmmsuUehhX8g9NyFP4W7DgmnRvKD7hyX6EbrQo2r61kG8XahIDLXIPoQcPdK4WRilBx+5Eye6MAolRQvAsT85phO0U/u/wOXN0pPOMU53/H22MMmyDw+qQrO8G0zsccfMAffiF80IdzHx4qS7SvfEISX/XcpSFhi5EXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722890705; c=relaxed/simple;
	bh=ZqZdVSISVWHdD2ORiCClQSHbpac+8s08kT8QY6n5pKw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jS2FDMx+NRNwuZdWHWfHo/pjDo9G8TGyoCtIs1SaYg+coEm7Lf626fMTVvcxzkz2GIkkqGf77obBDOQnRCArhleBxC1rjlKgNBmluuzbP4DCt8THedNOS3EmwojfzvYi3SLiEQAqUbry1RbXpiWHnI0GFgAFq5J14H93wT0uwJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UaXcHito; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e087c7ef68bso8139041276.3
        for <bpf@vger.kernel.org>; Mon, 05 Aug 2024 13:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722890702; x=1723495502; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZqZdVSISVWHdD2ORiCClQSHbpac+8s08kT8QY6n5pKw=;
        b=UaXcHitoc2VGxprG+f+6dhtqY3qCmyK0c1QIvVBViwZAJEkIqMLDeS7Uq7HO6xhp4+
         5j6+jnKpfDH7maxNhrG8MLdJB9MroGiUlufPJ+8oKHP4M6lbEEcPoHiyecLEw1LnG9fH
         AkSu1rfJv2rHtXpukDoDoaBOn7F4/9faVMqWse0mno8xIkti8dI2hmc+TCwbuwSBlQFS
         Wjt+wkwIFaOUPp+csUSCcNDbB2OTq8husk2aWu/70h13vkJcBjxqku69kpz2vkjUUSwo
         GgLe5l4WVn4M9MBgu8CjEC8wIbLjW8pade2eQ7UcgEcnsr1dqJo55CWUnSObng9v+90L
         mvLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722890702; x=1723495502;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZqZdVSISVWHdD2ORiCClQSHbpac+8s08kT8QY6n5pKw=;
        b=qHn3aKkNclOAbedcuPKzTeFFXHz0y17t5yI6FjVJt+Ttz2Zh1bjnxnp20SVQVqM+L0
         55/LLUgB4JI0WKZkTggfTecLf52YYkp2gI+QW241q0XIRvT0iykjJ6KQyF25+vKauCUn
         mkQkgRdqjtqf3DeLJlXu/Gvw0XUpys34UhV8k2MIGZ0WgDXzmpXQZ17B2l67mwrhpOxs
         BWS8w+Eyg77cCzmPqoPF5jrru7y2gMl2e8Irx1NIH5FYrbShlFjWA2lsl+nGWOvYqCG3
         L9e/O3oXOcrlGExpvGGFz1pX7G0FPUhczC0nXZkp5wUsKymiw92qEGdgHJNjQVFLjKMN
         pm1g==
X-Forwarded-Encrypted: i=1; AJvYcCXuX02xxLaPFNywbcB+p7aE4hehr5fcqMS/yLWy4FOWXcrMRbXeMqcxZaiSYPSEfiuTN2H0pTEOads0HKEvTaQWyPzH
X-Gm-Message-State: AOJu0Ywlej9yfcnTslvE9U4u+zmONDmSc81pJwcEus6Fu7JKR5txtlvu
	/aoswP0eF+MUs/+DMMxqUKiZ63WW4LOJ2OeVBhQWtdedpE6PGglRZt8uHCDKquzM9KGmFfw9Ko6
	bwIyorKi3XocuPtq8qZOLTFxEmIw=
X-Google-Smtp-Source: AGHT+IGvrb2Kzrl5P0rz++9rH2pn91v1P8td3me4DZXaPiKujKw2B/ig/E+GWoOUKrCPK8f8YMYZ7AAukt27FUUiIAk=
X-Received: by 2002:a05:6902:2486:b0:e0b:f45f:65df with SMTP id
 3f1490d57ef6-e0bf45f6824mr10692500276.23.1722890702201; Mon, 05 Aug 2024
 13:45:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240803001145.635887-1-amery.hung@bytedance.com>
 <20240803001145.635887-2-amery.hung@bytedance.com> <2921fc67-9129-1b5d-e720-1ca8f64e47fc@huaweicloud.com>
 <CAMB2axMwf07usb4gqocBH_9hgPsu9_VLQYMp83gV0sdazrcc-g@mail.gmail.com>
 <7b527651-a551-7d57-19d2-15dbff25db92@huaweicloud.com> <c72b14ef-47a9-4746-876a-609542755dd0@linux.dev>
In-Reply-To: <c72b14ef-47a9-4746-876a-609542755dd0@linux.dev>
From: Amery Hung <ameryhung@gmail.com>
Date: Mon, 5 Aug 2024 13:44:51 -0700
Message-ID: <CAMB2axMOTr-3svaKGqHxAwoR2_uZQ7ZWJrOzSZF7o7jqndhxQQ@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 1/4] bpf: Search for kptrs in prog BTF structs
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Hou Tao <houtao@huaweicloud.com>, bpf@vger.kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, alexei.starovoitov@gmail.com, martin.lau@kernel.org, 
	sinquersw@gmail.com, davemarchevsky@fb.com, 
	Amery Hung <amery.hung@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 5, 2024 at 1:00=E2=80=AFPM Martin KaFai Lau <martin.lau@linux.d=
ev> wrote:
>
> On 8/5/24 12:32 AM, Hou Tao wrote:
> > Hi,
> >
> > On 8/5/2024 12:31 PM, Amery Hung wrote:
> >> On Sun, Aug 4, 2024 at 7:41=E2=80=AFPM Hou Tao <houtao@huaweicloud.com=
> wrote:
> >>> Hi,
> >>>
> >>> On 8/3/2024 8:11 AM, Amery Hung wrote:
> >>>> From: Dave Marchevsky <davemarchevsky@fb.com>
> >>>>
> >>>> Currently btf_parse_fields is used in two places to create struct
> >>>> btf_record's for structs: when looking at mapval type, and when look=
ing
> >>>> at any struct in program BTF. The former looks for kptr fields while=
 the
> >>>> latter does not. This patch modifies the btf_parse_fields call made =
when
> >>>> looking at prog BTF struct types to search for kptrs as well.
> >>>>
> >>> SNIP
> >>>> On a side note, when building program BTF, the refcount of program B=
TF
> >>>> is now initialized before btf_parse_struct_metas() to prevent a
> >>>> refcount_inc() on zero warning. This happens when BPF_KPTR is presen=
t
> >>>> in program BTF: btf_parse_struct_metas() -> btf_parse_fields()
> >>>> -> btf_parse_kptr() -> btf_get(). This should be okay as the program=
 BTF
> >>>> is not available yet outside btf_parse().
> >>> If btf_parse_kptr() pins the passed btf, there will be memory leak fo=
r
> >>> the btf after closing the btf fd, because the invocation of btf_put()
> >>> for kptr record in btf->struct_meta_tab depends on the invocation of
> >>> btf_free_struct_meta_tab() in btf_free(), but the invocation of
> >>> btf_free() depends the final refcnt of the btf is released, so the bt=
f
> >>> will not be freed forever. The reason why map value doesn't have such
> >>> problem is that the invocation of btf_put() for kptr record doesn't
> >>> depends on the release of map value btf and it is accomplished by
> >>> bpf_map_free_record().
> >>>
> >> Thanks for pointing this out. It makes sense to me.
> >>
> >>> Maybe we should move the common btf used by kptr and graph_root into
> >>> btf_record and let the callers of btf_parse_fields() and
> >>> btf_record_free() to decide the life cycle of btf in btf_record.
> >> Could you maybe explain if and why moving btf of btf_field_kptr and
> >> btf_field_graph_root to btf_record is necessary? I think letting
> >> callers of btf_parse_fields() and btf_record_free() decide whether or
> >> not to change refcount should be enough. Besides, I personally would
> >> like to keep individual btf in btf_field_kptr and
> >> btf_field_graph_root, so that later we can have special fields
> >> referencing different btf.
> >
> > Sorry, I didn't express the rough idea clearly enough. I didn't mean to
> > move btf of btf_field_kptr and btf_field_graph_root to btf_record,
> > because there are other btf-s which are different with the btf which
> > creates the struct_meta_tab. What I was trying to suggest is to save on=
e
> > btf in btf_record and hope it will simplify the pin and the unpin of bt=
f
> > in btf_record:
> >
> > 1) save the btf which owns the btf_record in btf_record.
> > 2) during btf_parse_kptr() or similar, if the used btf is the same as
> > the btf in btf_record, there is no need to pin the btf
>
> I assume the used btf is the one that btf_parse is working on.
>
> > 3) when freeing the btf_record, if the btf saved in btf_field is the
> > same as the btf in btf_record, there is no need to put it
>
> For btf_field_kptr.btf, is it the same as testing the btf_field_kptr.btf =
is
> btf_is_kernel() or not? How about only does btf_get/put for btf_is_kernel=
()?
>

IIUC. It will not be the same. For a map referencing prog btf, I
suppose we should still do btf_get().

I think the core idea is since a btf_record and the prog btf
containing it has the same life time, we don't need to
btf_get()/btf_put() in btf_parse_kptr()/btf_record_free() when a
btf_field_kptr.btf is referencing itself.

However, since btf_parse_kptr() called from btf_parse() and
map_check_btf() all use prog btf, we need a way to differentiate the
two. Hence Hou suggested saving the owner's btf in btf_record, and
then check if btf_record->btf is the same as the btf_field_kptr.btf in
btf_parse_kptr()/btf_record_free().


>
> >
> > For step 2) and step 3), however I think it is also doable through othe=
r
> > ways (e.g., pass the btf to btf_record_free or similar).

