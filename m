Return-Path: <bpf+bounces-11989-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E2337C64A2
	for <lists+bpf@lfdr.de>; Thu, 12 Oct 2023 07:33:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1C761C20DFE
	for <lists+bpf@lfdr.de>; Thu, 12 Oct 2023 05:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB55BD264;
	Thu, 12 Oct 2023 05:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ke/calM8"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E7C28EF
	for <bpf@vger.kernel.org>; Thu, 12 Oct 2023 05:33:44 +0000 (UTC)
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEABDB7
	for <bpf@vger.kernel.org>; Wed, 11 Oct 2023 22:33:43 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-690d2441b95so426703b3a.1
        for <bpf@vger.kernel.org>; Wed, 11 Oct 2023 22:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697088823; x=1697693623; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aecVAriAZkozrr/eMl5klQSCBy5x4ONrhgp2pBVvWL8=;
        b=Ke/calM8EZjtYl7+ZmTQOwsmQNa4dFnGhO25A0Fyz6sREU6pwV+OwWN8cYo0DSmi1z
         I5EcrZr0JHnixPgGC5Z+hD3b0vlz72XZmpnh2icxF6PoL+0Ng0TA6dHVQNbNVBSaB/u1
         t8bIezF7/ntQjY+Hh64qHHf4zz2n77qVQ36pjryDIbvITCR63d5OiBrr9gU5NpURqAlr
         5+C9Af1eM0xi1TrcnNQ1FgTJ7jZPHYdRlSiYLWZ4H9KKq/wASyASJ0aDeVqqKZ3c0g/W
         gOKiRG4LpFTVL+S8s66ktXyuTl6EZPqkOjEHqg0nWeXjWcRx5+/n6EfhsO1LdfKY+faK
         L5Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697088823; x=1697693623;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aecVAriAZkozrr/eMl5klQSCBy5x4ONrhgp2pBVvWL8=;
        b=IUllHitiXriR1ypdEWgr8RUj9YAA8X4Sd/DUDJAYYlkXbc4Mor12kfa76H0I0gDaeq
         UwH3QEbk4hYAqEElhdqZqaGmPBweGV6T+FWN13VKiG+rsLjH42GKa+3ZwxYdD6jB5/vR
         e931lXmi0ktN3aQOHHWwr1pB9n6E2vTj9dWejdgU/zb/Q0gxlyFmDluYmNUeAlXcSzMk
         7FY5cY90ddinM18/E30rSUrmyWAhvKXGq+AJ27roUQVeYDdCiPneRx8iajdYR2I1h/zr
         JSJpROGC+4hs6vMU8c3nm5b1bsr5eOBTcQ5yCf9lDtRxZ6er6u9a4Z9XhM0LTtXTDres
         VB+Q==
X-Gm-Message-State: AOJu0Yyea4oWbPoNLZKAyO7QDDaHzIQ8Dwpd9Trh06+AH+SgOOeoopBy
	Io2zQBPpoNmgFkiR0/2UN/s=
X-Google-Smtp-Source: AGHT+IHyosALhGhCOeMlg88iXney7ZlXVHB7eP13/PD+Q0UdaUBuIyub6DkkQTUwlZvJTqLZgdgijw==
X-Received: by 2002:a05:6a20:1584:b0:15e:6909:533c with SMTP id h4-20020a056a20158400b0015e6909533cmr26758341pzj.30.1697088822802;
        Wed, 11 Oct 2023 22:33:42 -0700 (PDT)
Received: from localhost ([2605:59c8:148:ba00:5969:89b6:5dd6:5429])
        by smtp.gmail.com with ESMTPSA id y6-20020aa78046000000b006934350c3absm10974300pfm.109.2023.10.11.22.33.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 22:33:41 -0700 (PDT)
Date: Wed, 11 Oct 2023 22:33:40 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>, 
 bpf@vger.kernel.org, 
 ast@kernel.org, 
 daniel@iogearbox.net, 
 martin.lau@kernel.org
Cc: andrii@kernel.org, 
 kernel-team@meta.com
Message-ID: <65278534a3cb0_4a01020845@john.notmuch>
In-Reply-To: <20231011223728.3188086-5-andrii@kernel.org>
References: <20231011223728.3188086-1-andrii@kernel.org>
 <20231011223728.3188086-5-andrii@kernel.org>
Subject: RE: [PATCH bpf-next 4/5] bpf: disambiguate SCALAR register state
 output in verifier logs
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Andrii Nakryiko wrote:
> Currently the way that verifier prints SCALAR_VALUE register state (and
> PTR_TO_PACKET, which can have var_off and ranges info as well) is very
> ambiguous.
> 
> In the name of brevity we are trying to eliminate "unnecessary" output
> of umin/umax, smin/smax, u32_min/u32_max, and s32_min/s32_max values, if
> possible. Current rules are that if any of those have their default
> value (which for mins is the minimal value of its respective types: 0,
> S32_MIN, or S64_MIN, while for maxs it's U32_MAX, S32_MAX, S64_MAX, or
> U64_MAX) *OR* if there is another min/max value that as matching value.
> E.g., if smin=100 and umin=100, we'll emit only umin=10, omitting smin
> altogether. This approach has a few problems, being both ambiguous and
> sort-of incorrect in some cases.
> 
> Ambiguity is due to missing value could be either default value or value
> of umin/umax or smin/smax. This is especially confusing when we mix
> signed and unsigned ranges. Quite often, umin=0 and smin=0, and so we'll
> have only `umin=0` leaving anyone reading verifier log to guess whether
> smin is actually 0 or it's actually -9223372036854775808 (S64_MIN). And
> often times it's important to know, especially when debugging tricky
> issues.

+1

> 
> "Sort-of incorrectness" comes from mixing negative and positive values.
> E.g., if umin is some large positive number, it can be equal to smin
> which is, interpreted as signed value, is actually some negative value.
> Currently, that smin will be omitted and only umin will be emitted with
> a large positive value, giving an impression that smin is also positive.
> 
> Anyway, ambiguity is the biggest issue making it impossible to have an
> exact understanding of register state, preventing any sort of automated
> testing of verifier state based on verifier log. This patch is
> attempting to rectify the situation by removing ambiguity, while
> minimizing the verboseness of register state output.
> 
> The rules are straightforward:
>   - if some of the values are missing, then it definitely has a default
>   value. I.e., `umin=0` means that umin is zero, but smin is actually
>   S64_MIN;
>   - all the various boundaries that happen to have the same value are
>   emitted in one equality separated sequence. E.g., if umin and smin are
>   both 100, we'll emit `smin=umin=100`, making this explicit;
>   - we do not mix negative and positive values together, and even if
>   they happen to have the same bit-level value, they will be emitted
>   separately with proper sign. I.e., if both umax and smax happen to be
>   0xffffffffffffffff, we'll emit them both separately as
>   `smax=-1,umax=18446744073709551615`;
>   - in the name of a bit more uniformity and consistency,
>   {u32,s32}_{min,max} are renamed to {s,u}{min,max}32, which seems to
>   improve readability.

agree.

> 
> The above means that in case of all 4 ranges being, say, [50, 100] range,
> we'd previously see hugely ambiguous:
> 
>     R1=scalar(umin=50,umax=100)
> 
> Now, we'll be more explicit:
> 
>     R1=scalar(smin=umin=smin32=umin32=50,smax=umax=smax32=umax32=100)
> 
> This is slightly more verbose, but distinct from the case when we don't
> know anything about signed boundaries and 32-bit boundaries, which under
> new rules will match the old case:
> 
>     R1=scalar(umin=50,umax=100)

Did you consider perhaps just always printing the entire set? Its overly
verbose I guess but I find it easier to track state across multiple
steps this way.

Otherwise patch LGTM.

