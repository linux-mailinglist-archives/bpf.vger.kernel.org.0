Return-Path: <bpf+bounces-11859-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9949C7C48DF
	for <lists+bpf@lfdr.de>; Wed, 11 Oct 2023 06:42:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0E262820EC
	for <lists+bpf@lfdr.de>; Wed, 11 Oct 2023 04:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D58453A4;
	Wed, 11 Oct 2023 04:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P9VmMByi"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A999811;
	Wed, 11 Oct 2023 04:42:32 +0000 (UTC)
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB7DEA4;
	Tue, 10 Oct 2023 21:42:30 -0700 (PDT)
Received: by mail-oo1-xc33.google.com with SMTP id 006d021491bc7-57bbb38d5d4so3606846eaf.2;
        Tue, 10 Oct 2023 21:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696999350; x=1697604150; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qylSySzOMJ1ZWYS3M7TCqlxzn+DLE4Cie4A+7m0h0NY=;
        b=P9VmMByiR1JSu162lbZycZ0fC3TBjY8JDt+ZjA/5+zSzQ7yfa+bYPoy4wyR7YtMZsX
         tChBqDmt+4soYiZCLZ5H0dKT3S/8KAq1159aMopvrscvl/NH0Nn90+7KOc3eurc0NXy9
         kfu/toB+MHh6F5OZfAx4t04VrecjXsQ9IibOvE3UvxCw1MAkRfLH/UcxnpsW8SUEibGM
         eehxON3JFs9spz1/ZnB40xPzLIuVv9gA/JZSU/lYt2HHPFSsplW2Ge0YdPkolyC6vD9x
         nYvizNSTBeMb3VkqcPrmnsI+/WknV76dIFHuOnEpvZA15oJEkegrKJ2ELZCxYQwmaizR
         0DcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696999350; x=1697604150;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qylSySzOMJ1ZWYS3M7TCqlxzn+DLE4Cie4A+7m0h0NY=;
        b=O3OMJTTqsibRyvwWGr298p+4ZEZTa+ufKTbjw4tdzu9No8DfdPhun9uyDBmjL5yJQT
         RFMrqp6g8Nmr09WIGmVikR4RgStJMuHipCTHV1OBOrBdFl7B4poLgliPgYfqUtDm89Zm
         qtwbXdQ6lDwkDMvFfQLs0I/x1L2aezxnpp1N7nSlLlX8AcuhYhQfJhH+2dJ16vnP934x
         6VJjvlfbS4IsjRJ3PYpuKVgmpmc21iPdZejIRrYYEAMZ3kpkE+cDQEb1X0ZRohRMfWnP
         ldL+ZuQR/ez/299hJtTCNiyNa1Q2VJaqR7Kiz/jZwuLLeV0XnnMmKl5+/9bWsgw9VQ2Y
         OZBg==
X-Gm-Message-State: AOJu0YwlntVGK7OFKwvujrCr6fGpK84DJM1riSBueKFsscfHdtdhaN0v
	iKNviLQzSzCZJx/Z0UO3oiA=
X-Google-Smtp-Source: AGHT+IHPvhJ8j/+pxzcKt2OPo/h4IypEE5A605zFRJazwCUFUDrTnSex41d2Ogbegncv7Kvwc1dNVg==
X-Received: by 2002:a05:6358:591c:b0:143:7d73:6e63 with SMTP id g28-20020a056358591c00b001437d736e63mr22953440rwf.2.1696999350046;
        Tue, 10 Oct 2023 21:42:30 -0700 (PDT)
Received: from localhost ([98.97.32.4])
        by smtp.gmail.com with ESMTPSA id u13-20020a62ed0d000000b006930db1e6cfsm9099915pfh.62.2023.10.10.21.42.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 21:42:29 -0700 (PDT)
Date: Tue, 10 Oct 2023 21:42:27 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, 
 bpf@vger.kernel.org, 
 "David S. Miller" <davem@davemloft.net>, 
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
 Alexei Starovoitov <ast@kernel.org>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Hao Luo <haoluo@google.com>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 Jiri Olsa <jolsa@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Jonathan Lemon <jonathan.lemon@gmail.com>, 
 KP Singh <kpsingh@kernel.org>, 
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>, 
 Magnus Karlsson <magnus.karlsson@intel.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Song Liu <song@kernel.org>, 
 Stanislav Fomichev <sdf@google.com>, 
 Thomas Gleixner <tglx@linutronix.de>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Message-ID: <652627b386bbe_2d55e208d6@john.notmuch>
In-Reply-To: <20231010065745.lJLYdf_X@linutronix.de>
References: <20230929165825.RvwBYGP1@linutronix.de>
 <20231004070926.5b4ba04c@kernel.org>
 <20231006154933.mQgxQHHt@linutronix.de>
 <20231006123139.5203444e@kernel.org>
 <20231007154351.UvncuBMF@linutronix.de>
 <20231010065745.lJLYdf_X@linutronix.de>
Subject: RE: [PATCH bpf-next -v4] net: Add a warning if NAPI cb missed
 xdp_do_flush().
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Sebastian Andrzej Siewior wrote:
> A few drivers were missing a xdp_do_flush() invocation after
> XDP_REDIRECT.
> =

> Add three helper functions each for one of the per-CPU lists. Return
> true if the per-CPU list is non-empty and flush the list.
> Add xdp_do_check_flushed() which invokes each helper functions and
> creates a warning if one of the functions had a non-empty list.
> Hide everything behind CONFIG_DEBUG_NET.
> =

> Suggested-by: Jesper Dangaard Brouer <hawk@kernel.org>
> Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> Acked-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---

LGTM.

Acked-by: John Fastabend <john.fastabend@gmail.com>=

