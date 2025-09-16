Return-Path: <bpf+bounces-68589-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AA97B7F42B
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 15:28:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2A4058247D
	for <lists+bpf@lfdr.de>; Tue, 16 Sep 2025 23:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F6A12D0626;
	Tue, 16 Sep 2025 23:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EeFFVP7j"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9961A9F86
	for <bpf@vger.kernel.org>; Tue, 16 Sep 2025 23:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758066958; cv=none; b=IvVjDKyU6NrDi6Aj8bKZybfwAlVqYOVC14TuHu4kNbkIO8s+JRFmvvyC1KPRebZWlbbZpLjDDS7jFX76C18jfB6j/Kh+m0K75H1jBLsl6L/OqTWOyBZCQbAqKN2iGV7LSnD5SPQF6GxGsEE9a3B0sEQDZsgr3FqUYSOA2K7gKJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758066958; c=relaxed/simple;
	bh=VrnFu7cHYr5pHtHCIhb1+03bh9oKKk6rshXG390eig4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=p3kXu76sAc6dOC1WBij2Gv9qpVCN2wiwikz9SvM2luH8z79WHhia2SaRf+LxGFBgTmU3VOe+S+jOjmOYB8t2yHjjSPY2lNihWLdnnl1L3zm2OzUiwN1oHr31V0ryhQOP4HqcsjPRTvha/bSwhVc2i4wmUdkiSctZFLiTAI55PS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EeFFVP7j; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b54a2ab01ffso4283912a12.2
        for <bpf@vger.kernel.org>; Tue, 16 Sep 2025 16:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758066954; x=1758671754; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=m7tq/54wpGThutSC8+fYCbdk9H8EggmYfaEniueEn3Q=;
        b=EeFFVP7jEMXrGssK4b17IaYz1xpsjSwF3BqfZ+yEAOZV0hEWkvDP2iv7B0gbWNbuAN
         GE3pKFxCvG1lmoH5dGbQ1K/SrMFLFwKkCQccywP+I9fvt83Vw0MDdaYpC9rRhfB4GYo3
         5fju+BDSLwt/11CfrExNMtKRZURAE2WF6Q16RFgiD5cA/93TaYX3Mwn1XJirrNeuY3rK
         olBr7aVJCH2YmT4jG1NWYY4BpxahzT1D2q7H5a7/7/YqMxLqeLcG1edudDPi4oH9qf7P
         noa4+F0+9wBJdQnDNI6J9gp5cpknE80q3AeHyJpzAQ59ipG6Pd2U5ytBjRaUec0aVs/4
         ZKTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758066954; x=1758671754;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m7tq/54wpGThutSC8+fYCbdk9H8EggmYfaEniueEn3Q=;
        b=jmj4sPVGiJYqwhBZt71R3MZ/oqrHfPW5Licb6Wj2LjvksXnafh0+xd0yMQpIb6NAjO
         v4eagspety/u3Oqzukm2IAn5bvagSnQ2I3Vh+u2IeJic5ADC6qU9eBJIbyfpNAae4SP6
         xZFC/s3G16T+xQoKiziXIXt0lPB9wWM6WODeDUchTODRNryoVjbB2XD/ccmf4aOVgEQ9
         hvFtqJjDRCWST3wcYmFF/sLbGCznkNmw4Occ3bla/QEshvnQphiChpzqS6kOXupUauW/
         qJfvBy9QeikGr1uYRlUaAEgkEYqHH7eNNYTUnPXK9SD/cZmIjC3fpJiOmaUrxf/TO/db
         tVjQ==
X-Forwarded-Encrypted: i=1; AJvYcCWnH3aZSAB2jjeatDnZ9aDDZ2Le2xJ/9ZJgj80y5iNkzaZtkjbaySAzeMnl87U/l75v9X8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yweb3jMa6pZZwWs/k6HMj7C9IR/HC2/OHBuIultLB+I4u+wYCEv
	Sp9k0X+5tY6ml/nBoHhzbeyk49pIzXDlPBXeSN/J0Jztwcd5NpfJK9QE
X-Gm-Gg: ASbGnctjjPDY71RIaggWLAsW87f0QIq4fnPk+b0bp7dTH7X9Nk8UK2c9MyPkwwJNIgv
	omYityGx5TM3cGMZZPKwzsi5x0uC9XUVpdK284VNpHF8U6EVFPw3uY7pXTMIvLWGHXMECuAXHK0
	4UDIRsUmvQOFTX2VZ6TU1FayIL1ssR3SDimqWs4VzCyalTm0dCUEceODXqULaKN8wXGl0ws72SE
	pyH3u8LVbLZguXVB1nLn4OvBDzW8j/oNveynxMHWHlrb/tFY2zNj5HJoVNwPS14M7D2lfXnSm2V
	NRDrZZlUSfue2nzgXIUcnFMT0+zlQRDaAswLmfpXbQLXyw/ykNcgn3rIqb3Sfx53ETr34snqOX2
	fWOVHeRipkpzIVVJusi2Ks9WG3Cxs4UaZTKpREagbAwEQaQ==
X-Google-Smtp-Source: AGHT+IGij7BCFyQo1iCp0vdzsZ/xRNfmADSKrJ8aHHmLg5FYXxyoNUchkVYNMR5g6RtvugXVHULVSg==
X-Received: by 2002:a17:90b:1a8e:b0:32e:a8b7:e9c with SMTP id 98e67ed59e1d1-32ee3f64bb1mr199452a91.29.1758066953706;
        Tue, 16 Sep 2025 16:55:53 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:2a1:9747:e67f:953a? ([2620:10d:c090:500::4:432])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7760793b730sm17414540b3a.15.2025.09.16.16.55.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 16:55:53 -0700 (PDT)
Message-ID: <3b65db27f2cd4575875a090f9cce0ca0f138daea.camel@gmail.com>
Subject: Re: [PATCH bpf-next v5 0/8] bpf: Introduce deferred task context
 execution
From: Eduard Zingerman <eddyz87@gmail.com>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org, 
	ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com, 
	kernel-team@meta.com, memxor@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Date: Tue, 16 Sep 2025 16:55:52 -0700
In-Reply-To: <20250916233651.258458-1-mykyta.yatsenko5@gmail.com>
References: <20250916233651.258458-1-mykyta.yatsenko5@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-09-17 at 00:36 +0100, Mykyta Yatsenko wrote:

[...]

> Changelog:
> ---
> v4 -> v5
> v4:
> https://lore.kernel.org/all/20250915201820.248977-1-mykyta.yatsenko5@gmai=
l.com/
>  * Fix invalid/null pointer dereference bug, reported by syzbot
>  * Nits in selftests

Note for reviewrs, this is the part that takes care of syzbot report:

   /* Check if @regno is a pointer to a specific field in a map value */
   static int check_map_field_pointer(struct bpf_verifier_env *env, u32 reg=
no,
  -                                  enum btf_field_type field_type, u32 fi=
eld_off,
  -                                  const char *struct_name)
  +                                  enum btf_field_type field_type, u32 re=
c_off)
   {
          struct bpf_reg_state *regs =3D cur_regs(env), *reg =3D &regs[regn=
o];
          bool is_const =3D tnum_is_const(reg->var_off);
          struct bpf_map *map =3D reg->map_ptr;
          u64 val =3D reg->var_off.value;
  +       const char *struct_name =3D btf_field_type_name(field_type);
  +       int field_off;

          if (!is_const) {
                  verbose(env,
  @@ -8545,6 +8546,8 @@ static int check_map_field_pointer(struct bpf_verif=
ier_env *env, u32 regno,
                  verbose(env, "map '%s' has no valid %s\n", map->name, str=
uct_name);
                  return -EINVAL;
          }
  +       /* Now it's safe to dereference map->record */
  +       field_off =3D *(int *)((void *)map->record + rec_off);
          if (field_off !=3D val + reg->off) {
                  verbose(env, "off %lld doesn't point to 'struct %s' that =
is at %d\n",
                          val + reg->off, struct_name, field_off);
  @@ -8560,12 +8563,13 @@ static int process_timer_func(struct bpf_verifier=
_env *env, int regno,
          struct bpf_map *map =3D reg->map_ptr;
          int err;

  -       err =3D check_map_field_pointer(env, regno, BPF_TIMER, map->recor=
d->timer_off, "bpf_timer");
  +       err =3D check_map_field_pointer(env, regno, BPF_TIMER,
  +                                     offsetof(struct btf_record, timer_o=
ff));
          if (err)
                  return err;

Not very nice, but I don't see an easy way around that.

[...]

