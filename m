Return-Path: <bpf+bounces-73607-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CDEBC34DB8
	for <lists+bpf@lfdr.de>; Wed, 05 Nov 2025 10:32:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDDA1565906
	for <lists+bpf@lfdr.de>; Wed,  5 Nov 2025 09:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC53E3081AE;
	Wed,  5 Nov 2025 09:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GfeE9/kX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8637B306D5F
	for <bpf@vger.kernel.org>; Wed,  5 Nov 2025 09:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762334616; cv=none; b=OVaMDsVKzCotsoz9v4qz2V7ag+oEPq3AI2lpTyafRJMyTcAViSM2ttsBLwSVi5nkTX5BR0GvrqTUqFjm6cPATipFxnupIEGlshQWvku+A7Y83GVsHGNa9EoLkmLKOnJMKpJVFJo5NfQcDnpuEUrvHrWTtWmJIRYCk1jj9koVO58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762334616; c=relaxed/simple;
	bh=dcKB7CX25PmMaTj2V3g5P2YwGEo6FoROXoFTpwh5csY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pqEAh+AFsRBUu26Rdyim+mCK7M7QfTzFwT3iPBSoUY/524LzCm5wChRyr181Dh6OmKJUrnKrSFel0fkRnpcFs8TzowOsozRkzWC4ByuGRz448jg8g68XxMa5mwzOyUOwDDwpi/apLBxfdhXQidIUY6CCJxOqO1npTpeLrZw/vB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GfeE9/kX; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b6d2f5c0e8eso1248295966b.3
        for <bpf@vger.kernel.org>; Wed, 05 Nov 2025 01:23:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762334613; x=1762939413; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7wkhE9nY2zSrDr9FoF1jfwlabHo4LZNOFrvJVzM0P7U=;
        b=GfeE9/kXwiAk1DFcggN5/Y+6JeqMvfMFfWOZelQcI6n3NGCqJtaU1VaPXyJ1H4S32s
         RZXqoSVlhJGCWudapvuTBbeFKxh0Np29tBNBwIktyoBnUeJ2tbFufceZAsjXlc5DTJHu
         EJRyRzcJY3ef0iiBnfDXHhducGKT8JsgSByivIvV9/QVOxYi6Anz7/ojQrs0DKHu7v1S
         4QKmgJDLOSKYxSD8YfCqiU91gCBgxslSUL9wwsks47ktaaig0wYA2pbg+PsNUKzL0vx1
         BIKbh+mvRkTa/saWd5MtXWM+B72QI4uixjEuqxiC2nyddtESg5iVoGhz7bQ303YbwmuZ
         Jarg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762334613; x=1762939413;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7wkhE9nY2zSrDr9FoF1jfwlabHo4LZNOFrvJVzM0P7U=;
        b=UVpPo5oKqJtko7q2xLfnHyzzw9d4Xgoq/yKNru5GGD2EvvL4bJU3O6HqQHr4tfJ69f
         gvM1LD3dDijQ6dWzmnu8+aO8bWd2n6QZkFhRxbV2bU+4GNwpOxm3u2sWF6agnhVSLTND
         wotUatkV1734t5dHPpTmf6rnnX8Wl4huST5epxpZ07PUJfx2VukYV9upwucaFuEbZUCw
         0803D/tNuA0V+6iMAwHpLaXPLC648Z05+uxyMMIsJW80jrN0lzUWSwlf50g32/dU+xQU
         n0C/G4N57bqBTGSB0SBEbxHxYtSRn1cRMcUDw5Rg+oZ7tD7Osfm4741rZF0QWbxNNPlI
         k3Zw==
X-Gm-Message-State: AOJu0YxWUI91yRrsxbmkTH9+loev4920tkJ0MuCelsS/LJOSn4YSx/G0
	ZTUPI4xSve9K5O2eHsFeMqxpaJQHRW7VmWbR7HijIKsVldNMP+TRhD/q
X-Gm-Gg: ASbGncty6o2kBwj8hj0lyB/QfpGM7AeCfl4dZWYdXdVEYoxsHL3tsuM9Ee4e2uJykLI
	zRsE8cdzKVWAdwazdQZtD+gkNhx7Zaj7eGBDoFv30A72HcHVv566PDZBD+i0GK03cUzAj2eaogi
	nS11GINyDLoHFDT9jnOeNbVLHNZtWIzwn7QVTdApsiEjNGNCDa9zsFI8DUISqqh0Ie2NNMiZT7q
	1dGSbqzCStWSp22ja2CuMtWX7awIvIpGXS6fPBkFNyYXL6wi4/wLhAMBBXj/V+PUaiHp2o43brS
	iJGRCcBtFOpvJ81Fnk+OtQCHaNcDLT5ZXUAFBfptu0eRLps05yjTrypsfoPYETSm8voWLafWWHL
	Y34K+uvnx8bC8FJJejHxqsVYWyDPfJ80XJG7GfI3tu2s2EXDmJmbBzBEMOiAD/3R1EszkHnPT09
	ffaWJj2YeE4gWxSfaAz9OG
X-Google-Smtp-Source: AGHT+IH9EfSvRyjMaJNVeguMpciEUCbVbUgb2gTsjayRV7QDqR51OeU3/f83zU2dbXeQiuI9UipWGg==
X-Received: by 2002:a17:906:c114:b0:b71:df18:9fba with SMTP id a640c23a62f3a-b72652976fcmr223141466b.15.1762334612705;
        Wed, 05 Nov 2025 01:23:32 -0800 (PST)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b723fe37cb9sm436157966b.61.2025.11.05.01.23.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 01:23:30 -0800 (PST)
Date: Wed, 5 Nov 2025 09:29:44 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
	aspsk@isovalent.com, daniel@iogearbox.net, eddyz87@gmail.com,
	qmo@kernel.org, yonghong.song@linux.dev, martin.lau@kernel.org,
	clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [PATCH v11 bpf-next 02/12] bpftool: Recognize insn_array map type
Message-ID: <aQsZCO6jzuThU7+n@mail.gmail.com>
References: <20251105090410.1250500-3-a.s.protopopov@gmail.com>
 <b1df429383fefe439fb19c0ebf0f9f665e37ffbc164c837a307fe2911a520a18@mail.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1df429383fefe439fb19c0ebf0f9f665e37ffbc164c837a307fe2911a520a18@mail.kernel.org>

On 25/11/05 09:21AM, bot+bpf-ci@kernel.org wrote:
> > diff --git a/tools/bpf/bpftool/Documentation/bpftool-map.rst b/tools/bpf/bpftool/Documentation/bpftool-map.rst
> > index 252e4c538..1af3305ea 100644
> > --- a/tools/bpf/bpftool/Documentation/bpftool-map.rst
> > +++ b/tools/bpf/bpftool/Documentation/bpftool-map.rst
> > @@ -55,7 +55,8 @@ MAP COMMANDS
> >  |     | **devmap** | **devmap_hash** | **sockmap** | **cpumap** | **xskmap** | **sockhash**
> >  |     | **cgroup_storage** | **reuseport_sockarray** | **percpu_cgroup_storage**
> >  |     | **queue** | **stack** | **sk_storage** | **struct_ops** | **ringbuf** | **inode_storage**
> > -|     | **task_storage** | **bloom_filter** | **user_ringbuf** | **cgrp_storage** | **arena** }
> > +|     | **task_storage** | **bloom_filter** | **user_ringbuf** | **cgrp_storage** | **arena**
> > +|     | **insn_array** }
> >
> >  DESCRIPTION
> >  ===========
> > diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
> > index c9de44a45..7ebf7dbcf 100644
> > --- a/tools/bpf/bpftool/map.c
> > +++ b/tools/bpf/bpftool/map.c
> > @@ -1477,7 +1477,8 @@ static int do_help(int argc, char **argv)
> >  		"                 devmap | devmap_hash | sockmap | cpumap | xskmap | sockhash |\n"
> >  		"                 cgroup_storage | reuseport_sockarray | percpu_cgroup_storage |\n"
> >  		"                 queue | stack | sk_storage | struct_ops | ringbuf | inode_storage |\n"
> > -		"                 task_storage | bloom_filter | user_ringbuf | cgrp_storage | arena }\n"
> > +		"                 task_storage | bloom_filter | user_ringbuf | cgrp_storage | arena |\n"
> > +		"                 insn_array }\n"
> >  		"       " HELP_SPEC_OPTIONS " |\n"
> >  		"                    {-f|--bpffs} | {-n|--nomount} }\n"
> >  		"",
> 
> The commit message says "Teach bpftool to recognize instruction array
> map type" but this change only updates documentation strings. Shouldn't
> libbpf's map_type_name[] array in tools/lib/bpf/libbpf.c also be
> updated? Without that, when bpftool displays an insn_array map through
> show_map_header_json() or the plain output function, it will call
> libbpf_bpf_map_type_str() which returns NULL for BPF_MAP_TYPE_INSN_ARRAY,
> causing bpftool to fall back to printing "type 39" instead of "insn_array".

It's done in an adjacent commit.

> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/19096860051


