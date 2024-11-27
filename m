Return-Path: <bpf+bounces-45705-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E45589DA724
	for <lists+bpf@lfdr.de>; Wed, 27 Nov 2024 12:51:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28403B24E64
	for <lists+bpf@lfdr.de>; Wed, 27 Nov 2024 11:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A0BC1F9ABF;
	Wed, 27 Nov 2024 11:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KsNABuHf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F791F9ECC;
	Wed, 27 Nov 2024 11:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732708179; cv=none; b=BYrhE8HlUWm4d2HL9RFrM817uRNzzFCBRorlWpL6ppqZQ6/r7OgjVoe9keumz9u0RjCWfdCTAigJb+0Q0I05SXvcMkjhFlaUBj7PnipKQGzV/GqNLV+eNSY63HJ06Sq6iUeiGdVTRgYcsSXWE4e1nlWkBRn2CEbi6+Vr5ztQOrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732708179; c=relaxed/simple;
	bh=YO5jsAFokPQw0krpuMb81U8PTSlUrJKpD8UCXmnpAH4=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WwbrN8ff/jGJmlGat0KAwKsqnWx0tWE/RB0stqrScjiWtU+6JgjILYCIgXfgT0a1buzco7C8A3qmoLVsvkDACznRRivD1y5gQC4NMM8rQlKpQ6v4VIVF0fAAK9FbUY0ScurW/wGOIUTa1/V50Fr5Yux5YxG/L82bIXbV5Gk/t7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KsNABuHf; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-aa560a65fd6so124075266b.0;
        Wed, 27 Nov 2024 03:49:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732708176; x=1733312976; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kwQCvtPpp8+BxmW4rpq1HgxrDOIdn4yXH8MhwqPEUsY=;
        b=KsNABuHfjMuwF4YOkt4LNVXFwrhj39yTdAYq/mkpdbqkjkeWOSb/ow9qV6gfYbH5d6
         2AeWr9KKQHW/pF1mSzBTzbpvDaij9ae4DP020OV4mvmftLelugkImelIiPfyP/Yihj8J
         dOhJ8f3gK4bhgS8I4CcD/mvrHO+/Le5j24VnuOgPpnUClHv2Nhkk6oS+A3GPpswCskiq
         /EUuN/gyi7xWK/KWzcJSjVHEfvCNaYXwFbgSJx/1CUZRXiPVSd5WwBCbclQrnqqaHAss
         8gCSa1mgBnu6F1oDRagp5CSWNAhf3ApXWcmgB7Qb56T9fdMi1+o+78tCPmhRe40x+djD
         Otow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732708176; x=1733312976;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kwQCvtPpp8+BxmW4rpq1HgxrDOIdn4yXH8MhwqPEUsY=;
        b=WpkZ2yjQJGueYX7io4vJNKwLf/nc0sAyRLRX6OTY+GMJ9O6lo8pb6cVQ3xe4PrhUP+
         K3d0RluGAg2n/FL7GQMCU19pFTyq9OwT30gxA8pffnzegI3HuMDWT82umodaI3q2U0ip
         qhDqiiMzP34G+2TZ7bi3HeExSZMV521IyYPb5tnuxdm086//CPbAOlgvgjjZGdCByd97
         IyQ6HlKhpCWHSevp4QoQKEUQMn7nDL3xu+Z26IJw6YZuBEep1tq0oj0QrzpJZqVFTRWq
         2iR5JUYNzKHIGldKLoR9DYiR72Eq4BFtawGK3WH1auG3vQieg+d5n9bZVMdUmvspR6Ss
         bSUw==
X-Forwarded-Encrypted: i=1; AJvYcCU+V/RIzT2amPXLddRqqSM2GzifmC2xqxcGNAhomFJ32H729ZUIxKPGeDsLMW0gTK03XE0=@vger.kernel.org, AJvYcCVRNbuXEw7xyHhVBynsUHgrmOWTniacrrribvLj49RUx6Bh1BmhSk0KEy6i3ltAL2H0A2J78dk+vzv3SKeY@vger.kernel.org, AJvYcCWVFelDS1wBM1eLMGpxZPWIrOxdFbv5da0UxkncUq4RgRiMZV2Jg/nOyyjhwy6OPNkBNa69W8/fjpQaiIg25XhIYk1Y@vger.kernel.org
X-Gm-Message-State: AOJu0YyIDo0cJ2CLJAi3GbK3hb65irAitc7ummDeIiOM1tWGwHbxpoFM
	IQ92hAnSiocxWB8oyKD6BNJ+0difreaEU/FfSBQjr7+2q3uj8gZY
X-Gm-Gg: ASbGnctHVag4hUw74TYZN9mj6YMYseAy65c/38z92Okx+VagJlG+EKjI8xLGpqv4xzq
	KUTb8/STHpqKcPsEMY128p6kzxndr4G4mANlU7wLHLXdJWWkNxSjVP8bLWwHxW3b7xXkafJnomD
	yPCUH16UlhoZ9Syex82e2gHLNcp0PMech7hHLP7V2sjmMWWOb355u+EMYe2Mk7r6ELGohFgRjf5
	gpLIa6wOmu2z9llCYZF//s31cnmIzB9JrKZFh685SfhqxZWLM0LN3sEDenRUmB1Klbvli5nXSc/
	BTK1yhdzfUwLA2hzixKLTuQ=
X-Google-Smtp-Source: AGHT+IH8XvC8bOLMTe+DA11zRG4XwxyPNmdeciEFri4AJtzmiWMIbPqJmMXBH/1AamlxktBfzt1tcQ==
X-Received: by 2002:a17:906:30cc:b0:aa5:c1b:2204 with SMTP id a640c23a62f3a-aa57fac455emr265187766b.8.1732708175683;
        Wed, 27 Nov 2024 03:49:35 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa547ffb152sm431874666b.62.2024.11.27.03.49.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 03:49:35 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 27 Nov 2024 12:49:33 +0100
To: Marco Elver <elver@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Nikola Grcevski <nikola.grcevski@grafana.com>, bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Remove bpf_probe_write_user()
 warning message
Message-ID: <Z0cHTRsJoWgZBGNU@krava>
References: <20241127111020.1738105-1-elver@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241127111020.1738105-1-elver@google.com>

On Wed, Nov 27, 2024 at 12:10:00PM +0100, Marco Elver wrote:
> The warning message for bpf_probe_write_user() was introduced in
> 96ae52279594 ("bpf: Add bpf_probe_write_user BPF helper to be called in
> tracers"), with the following in the commit message:
> 
>     Given this feature is meant for experiments, and it has a risk of
>     crashing the system, and running programs, we print a warning on
>     when a proglet that attempts to use this helper is installed,
>     along with the pid and process name.
> 
> After 8 years since 96ae52279594, bpf_probe_write_user() has found
> successful applications beyond experiments [1, 2], with no other good
> alternatives. Despite its intended purpose for "experiments", that
> doesn't stop Hyrum's law, and there are likely many more users depending
> on this helper: "[..] it does not matter what you promise [..] all
> observable behaviors of your system will be depended on by somebody."
> 
> The ominous "helper that may corrupt user memory!" has offered no real
> benefit, and has been found to lead to confusion where the system
> administrator is loading programs with valid use cases.
> 
> As such, remove the warning message.
> 
> Link: https://lore.kernel.org/lkml/20240404190146.1898103-1-elver@google.com/ [1]
> Link: https://lore.kernel.org/r/lkml/CAAn3qOUMD81-vxLLfep0H6rRd74ho2VaekdL4HjKq+Y1t9KdXQ@mail.gmail.com/ [2]
> Link: https://lore.kernel.org/all/CAEf4Bzb4D_=zuJrg3PawMOW3KqF8JvJm9SwF81_XHR2+u5hkUg@mail.gmail.com/
> Signed-off-by: Marco Elver <elver@google.com>

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka

> ---
> v2:
> * Just delete the message entirely (suggested by Andrii Nakryiko)
> ---
>  kernel/trace/bpf_trace.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 630b763e5240..0ab56af2e298 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -362,9 +362,6 @@ static const struct bpf_func_proto *bpf_get_probe_write_proto(void)
>  	if (!capable(CAP_SYS_ADMIN))
>  		return NULL;
>  
> -	pr_warn_ratelimited("%s[%d] is installing a program with bpf_probe_write_user helper that may corrupt user memory!",
> -			    current->comm, task_pid_nr(current));
> -
>  	return &bpf_probe_write_user_proto;
>  }
>  
> -- 
> 2.47.0.338.g60cca15819-goog
> 

