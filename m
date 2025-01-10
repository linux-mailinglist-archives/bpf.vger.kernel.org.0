Return-Path: <bpf+bounces-48575-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E18FA09901
	for <lists+bpf@lfdr.de>; Fri, 10 Jan 2025 19:01:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83E1B3AACDC
	for <lists+bpf@lfdr.de>; Fri, 10 Jan 2025 18:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4751D212B1D;
	Fri, 10 Jan 2025 18:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bzCgb0jq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5583F224D7;
	Fri, 10 Jan 2025 18:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736532060; cv=none; b=l0wi7EKhL4KuhXGjVZwslhSOB6b0hEwxXdScAtFZ4RXIonfperEMOiY2igKf6IcvtZre99qGy1csDl9rZ2TPWonF6Ha9hzqKQ8NkBmYjv/Dia9hybOxof7Lvb2RuRmh4RdOlgp5hXsMuw55Zm/uM7L6Z59TU2xapMBY3HTmNUMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736532060; c=relaxed/simple;
	bh=jWmGZq/yTVUzsPsRDgWRFPHu7pbFN+46aq8jeS7vP/s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VDu8WsYZzu/RQBNKC64h7hrNPxfyTV5bBG/gGd6dzy1YGiMt05IY02qtXyg77TgvxjuZZ2g7N5DLKf8BIxzW8u1QC0TjZv28JnBjDfHSfHl/FrCGdFOFNAKwmExmnioL4vGbecsO9he8OdXos4v3jAnLIb1bhYUR2D8RFS/jXCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bzCgb0jq; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e53ef7462b6so3997282276.3;
        Fri, 10 Jan 2025 10:00:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736532058; x=1737136858; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0FxFVtu1V78zPcPPY+mV2lhvGlXOTUqXWxxIhWG8ybw=;
        b=bzCgb0jqLBp8YjsfSttZuFHnCOp4AttvOVWCCwt5QUcUwfzvYaiaEzgVXtlUZBhPSU
         PsU6Uqa465ftkiw5FGxb0w/1Yvw33eOWE869nUUn6TnKTIPwlpAv9udgQ0b3HwJWSplB
         Vx1Im4w56Kc9D5Uc6DvEFR58+T0XMqZXgorjz6ywFH7OglPmo+EO8cph7KexphZaS1EV
         lEf6Zw4CYQHECvz/Od5fetgihrVb8tWmBriMeo/+EEyO1J7ahZW74I6RbvLSDwysnjAf
         MzjFNfS7CTlMy0We6lsiwxzAP1FSMRDsgeTS1JPnpwgjkwFuVBFrILlqmL5hOm0fDT12
         OjvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736532058; x=1737136858;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0FxFVtu1V78zPcPPY+mV2lhvGlXOTUqXWxxIhWG8ybw=;
        b=JAtOUA6UOcdW1IJsb354TyaKPfQSFLJHjoWiv0de5BHcYLgVwW1HB53msECtXVT5/x
         PM/ZnIjToAI68F+7p4iRzxl8Zt9BmS5ylgCQO4O95jClOSYdSZZo0tUD3s18Hv8Nz5MQ
         fd7Qbi97rgwb4lIIQDqJvjkZnUnMcrBghLYGes6UUL8UH1wmq6Pl9hghPop1xMQDvRRZ
         mVwBWJClyAwdB/LQbzQai/UTVsC7er37xlnIdw4tyDw3GBDXbCFMi678Ifms0hDVJ3a/
         FpIgFGmkt18UPZ0MHaWibhvbkseowrRaPXFd9oQM+HUyAy+VWcsc7zY9JHFtBLnkQ5S9
         RpGQ==
X-Forwarded-Encrypted: i=1; AJvYcCUDf+7twfpk/mWhbSO9cSFNocVxsB8XQ3Pa1klZddgFJo2FfR752C6AtfBvUVkHeHRGmcGofLg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzyv8UlmkWYs+MSPgPB1GyM/w91J2JTKuwhefCUiUNtvRfDulOv
	8GZGgmRkPjKqzHk2QEOWyxIITzjK+VhJHHWJRe9eiOXyYtonlaXiUS0qmPYEQjnxW913BRROuz6
	LkD+S7n43ax4oUV38IRNJ0Y3i+Wg=
X-Gm-Gg: ASbGnctzotTkk146SROABiLaOPO0+6P9wvJYPHSPWFF8CwZpRFbGx/ak6c/DJdrkuiI
	YuvqjySAHuwUTxrNCZlkw0idzjSMNYdChU5jSleZvaymsxLboQJSSNg==
X-Google-Smtp-Source: AGHT+IF2F3C7l16WMw2Alhg43G6MD0kwjDA1rS4sTTLV0C5mBTbCV2vngMFC8GkuYYhTOCl3FV/MAq022dDkqTSSLcQ=
X-Received: by 2002:a05:690c:7409:b0:6ef:e39f:bbd with SMTP id
 00721157ae682-6f5312d6be0mr99896447b3.33.1736532058186; Fri, 10 Jan 2025
 10:00:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241220195619.2022866-1-amery.hung@gmail.com>
 <20241220195619.2022866-7-amery.hung@gmail.com> <5e1c5729-9bc0-4cb7-969a-a334fb544595@linux.dev>
In-Reply-To: <5e1c5729-9bc0-4cb7-969a-a334fb544595@linux.dev>
From: Amery Hung <ameryhung@gmail.com>
Date: Fri, 10 Jan 2025 10:00:47 -0800
X-Gm-Features: AbW1kvbn4166dhIjtUPc7tFdMAai_iZXXiRwJLjZo6A4gJt3TCQ19Ymxoty_Hf4
Message-ID: <CAMB2axM1qA-+4PYyYJ3AmoKHoKAWwu-8sh1UYdZBsPGURbmh4Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 06/14] bpf: net_sched: Add basic bpf qdisc kfuncs
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, alexei.starovoitov@gmail.com, martin.lau@kernel.org, 
	sinquersw@gmail.com, toke@redhat.com, jhs@mojatatu.com, jiri@resnulli.us, 
	stfomichev@gmail.com, ekarani.silvestre@ccc.ufcg.edu.br, 
	yangpeihao@sjtu.edu.cn, xiyou.wangcong@gmail.com, yepeilin.cs@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 9, 2025 at 4:24=E2=80=AFPM Martin KaFai Lau <martin.lau@linux.d=
ev> wrote:
>
> On 12/20/24 11:55 AM, Amery Hung wrote:
> > +BTF_KFUNCS_START(qdisc_kfunc_ids)
> > +BTF_ID_FLAGS(func, bpf_skb_get_hash, KF_TRUSTED_ARGS)
> > +BTF_ID_FLAGS(func, bpf_kfree_skb, KF_RELEASE)
> > +BTF_ID_FLAGS(func, bpf_qdisc_skb_drop, KF_RELEASE)
> > +BTF_ID_FLAGS(func, bpf_dynptr_from_skb, KF_TRUSTED_ARGS)
> > +BTF_KFUNCS_END(qdisc_kfunc_ids)
> > +
> > +BTF_SET_START(qdisc_common_kfunc_set)
> > +BTF_ID(func, bpf_skb_get_hash)
> > +BTF_ID(func, bpf_kfree_skb)
>
> I think bpf_dynptr_from_skb should also be here.

Good catch

>
> > +BTF_SET_END(qdisc_common_kfunc_set)
> > +
> > +BTF_SET_START(qdisc_enqueue_kfunc_set)
> > +BTF_ID(func, bpf_qdisc_skb_drop)
> > +BTF_SET_END(qdisc_enqueue_kfunc_set)
> > +
> > +static int bpf_qdisc_kfunc_filter(const struct bpf_prog *prog, u32 kfu=
nc_id)
> > +{
> > +     if (bpf_Qdisc_ops.type !=3D btf_type_by_id(prog->aux->attach_btf,
> > +                                              prog->aux->attach_btf_id=
))
> > +             return 0;
> > +
> > +     /* Skip the check when prog->attach_func_name is not yet availabl=
e
> > +      * during check_cfg().
>
> Instead of using attach_func_name, it is better to directly use the
> prog->expected_attach_type provided by the user space. It is essentially =
the
> member index of the "struct Qdisc_ops". Take a look at the prog_ops_moff(=
) in
> bpf_tcp_ca.c.

I will replace all places that use attach_func_name to refer to the
ops to prog_ops_moff.

Thank,
Amery

>
> > +      */
> > +     if (!btf_id_set8_contains(&qdisc_kfunc_ids, kfunc_id) ||
> > +         !prog->aux->attach_func_name)
> > +             return 0;
> > +
> > +     if (!strcmp(prog->aux->attach_func_name, "enqueue")) {
> > +             if (btf_id_set_contains(&qdisc_enqueue_kfunc_set, kfunc_i=
d))
> > +                    return 0;
> > +     }
> > +
> > +     return btf_id_set_contains(&qdisc_common_kfunc_set, kfunc_id) ? 0=
 : -EACCES;
> > +}

