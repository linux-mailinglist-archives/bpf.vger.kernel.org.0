Return-Path: <bpf+bounces-45646-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4141C9D9E23
	for <lists+bpf@lfdr.de>; Tue, 26 Nov 2024 20:56:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3B24B2349A
	for <lists+bpf@lfdr.de>; Tue, 26 Nov 2024 19:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25BBC1DF25F;
	Tue, 26 Nov 2024 19:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="TBKFh2Uq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0980228689
	for <bpf@vger.kernel.org>; Tue, 26 Nov 2024 19:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732650999; cv=none; b=m0J2O9dmqJOAvfsgxIkI86HzDTavfl1fIaik846BaTUovMVdwusBmxdlYruMTMMb9QHOnKAHkeFZ2xolTg2jtUbCxn5YLdqiRti2zhLSX76V/XpK78sLqhYZuAgK0Q48YF09itSKzGm9Ioz2rNpG5MarY3FjBy20lhTJTB0jjfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732650999; c=relaxed/simple;
	bh=Gm5B5+newMCdT5dPl2bMKMXRMaNQJu6zl9SHsVTGUdU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IZ9DnBlCMSozQAbFpKDes5PYy8l2k++i7mzIto4BkIYWkLRnUHvyPkT9HP26kzFiMf6O+v67eCRXwWjcWflg3z1GgH/l8OB01xPo1Vn+O/Xg7LHvhUK5P8XWdIZabu2t0QR/TLI+eHV2BjyfX3wugrhB675FXvYaWd7OOq1vO5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=TBKFh2Uq; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-38245e072e8so5801173f8f.0
        for <bpf@vger.kernel.org>; Tue, 26 Nov 2024 11:56:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1732650995; x=1733255795; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KDznOaXYfq6KOskwsolBzp4NXHxTYWvm0Btrb6DRprQ=;
        b=TBKFh2Uq9p6RUhQbisAHosGaX+3IOyeEMMScJqgy2OPHlMbKJMWxpiwE2Ijd9bDrP7
         IH2wcjkPBkBmI92HhsIAp6cp7rcz9brUchf1R6vqG3h7xUvZDgHZqBV9L/odDOsOZ5LM
         Pqa8ZvInsbOxIokZG0u/RAGXivDqX5VKofWdVaWDdL0E3XeVfZr8kInfAGCjhUjssHjU
         0RrwWNky1yxVKQFztSS0BlhqC2/ikwpLEmvGJQWAtyyHx8b5PEZJ8IwFrsn0UQTwEvtV
         eIIZW4owtj+JhYIAaYT7rlWSqwZqq2Z4pzpakcD2y/23BFyTnQPik8kx1x9sMXhfiTzl
         EJfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732650995; x=1733255795;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KDznOaXYfq6KOskwsolBzp4NXHxTYWvm0Btrb6DRprQ=;
        b=WBtg2kT8U5FBZDYedJkUlimC4I8yxTvt0axOKQ2aQ0HVfMoQ2h8P+W/dLWfa1/QZNt
         XaXyB25hlue4nLra9DywR/tdc83Mch18SWAyzDIQCTTWr/6hemnFKYpDH88NA8deiGjE
         O3C9duhVBx44bJe6Eg5uiXVYjFPqxR/Tn/dm8Hj7E+GFx9/IzJOc3tZj39i2C9TlGVBX
         PsNqxOoo5Mc9dm9dY6qApN9iVt18vR5EBngB3SO9S8Xj5OIFct5KIVTp+KVwEe8aslQ+
         5aJqSZ6uySj6BeqijKuSkLLq38QS1dptbrvYxDpuvTbE2uy4sbtm9RJUO6PMcGePxL/Q
         ByzA==
X-Gm-Message-State: AOJu0YzqNwPliKprF9nKpSOIvNmKYWwM57u/OVnKzTgtholgNi72LVaw
	YgDN8k/z5kW+/S0IvWVjsdK2oBZR4ox35M2fLTp/AVDH8sogDxF68xrAKttWXAQnaElk3iJvhz4
	H+cHGCm8a1iNIJQOeuXGCdaB0loMo6Ex6ds6D5Q==
X-Gm-Gg: ASbGncsRd3hUXOOurEEAvydllrMttaVio87O3tOSCx7TFBQSYLGP6NmSfkJWs87r3/U
	Hl9aMUXf/ZsfnFQmECqWFsxZMZAL0yu4g
X-Google-Smtp-Source: AGHT+IGFNbuXyXdC5cI28zpW94/nKxeWfSaHjWo1dStq+eqjR7PlYdmtonqohHkrjoH7/6q0h5i8RpuUUYMjUaU/4LY=
X-Received: by 2002:a5d:588f:0:b0:37d:7e71:67a0 with SMTP id
 ffacd0b85a97d-385c6ccae86mr176840f8f.9.1732650995167; Tue, 26 Nov 2024
 11:56:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Z0X/9PhIhvQwsgfW@boxer>
In-Reply-To: <Z0X/9PhIhvQwsgfW@boxer>
From: Amery Hung <amery.hung@bytedance.com>
Date: Tue, 26 Nov 2024 11:56:24 -0800
Message-ID: <CAONe225n=HosL1vBOOkzaOnG9jTYpQwDH6hwyQRAu0Cb=NBymA@mail.gmail.com>
Subject: Re: [External] Storing sk_buffs as kptrs in map
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: bpf@vger.kernel.org, magnus.karlsson@intel.com, sreedevi.joshi@intel.com, 
	ast@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 26, 2024 at 9:06=E2=80=AFAM Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> Hello eBPFers,
>
> I have a use case where I would like to store sk_buff pointers as kptrs i=
n
> eBPF map. To do so, I am borrowing skb kfuncs for acquire/release/destroy
> from Amery Hung's bpf qdisc set [0], but they are registered for
> BPF_PROG_TYPE_SCHED_CLS programs.
>
> TL;DR - due to following callstack:
>
> do_check()
>   check_kfunc_call()
>     check_kfunc_args()
>       get_kfunc_ptr_arg_type()
>           btf_is_prog_ctx_type()
>               btf_is_projection_of() -- return true
>
> sk_buff argument is being interpreted as KF_ARG_PTR_TO_CTX, but what we
> have there is KF_ARG_PTR_TO_BTF_ID. Verifier is unhappy about it. Should
> this be workarounded via some typedef or adding mentioned kfuncs to
> special_kfunc_list ? If the latter, then what else needs to be handled?
>
> Commenting out sk_buff part from btf_is_projection_of() makes it work, bu=
t
> that probably is not a solution:)
>
> Another question is in case bpf qdisc set lands, could we have these
> kfuncs not being limited to BPF_PROG_TYPE_STRUCT_OPS ?
>

Hi Maciej,

bpf qdisc will use a different mechanism to acquire skb referenced
kptrs (i.e., no skb-acquiring kfunc). For skb-releasing kfunc, I don't
think it can be made available to SCHED_CLS programs directly either.
The problem is the bpf program could kfree_skb() the skb in the ctx
with this kfunc. However, the kernel is still expecting a valid skb
later in cls_bpf_classify().

Another potential problem to consider in order to enable skb kptrs in
SCHED_CLS is the cleanup. In bpf qdisc case, we are still working on
releasing skb kptrs in maps or graphs automatically when .reset is
called so that we don't hold the resources forever.

I am interested in hearing your use case of storing skb kptr in maps.
Do you mind sharing it?

Thanks,
Amery


> I would be thankful for any pointers/stions regarding this issue.
> Maciej
>
> [0]: https://lore.kernel.org/bpf/20240714175130.4051012-7-amery.hung@byte=
dance.com/

