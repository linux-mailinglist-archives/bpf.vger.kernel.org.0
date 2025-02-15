Return-Path: <bpf+bounces-51660-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C0CBA36EFC
	for <lists+bpf@lfdr.de>; Sat, 15 Feb 2025 16:06:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7BE41712C7
	for <lists+bpf@lfdr.de>; Sat, 15 Feb 2025 15:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2026F1DC9BB;
	Sat, 15 Feb 2025 15:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fOzHer6e"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329C218BC2F;
	Sat, 15 Feb 2025 15:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739632011; cv=none; b=sEt2F/0ZYI//h+zf8E+r3fMQj8jjJ7eWvNFGdX/CBbL7z/nhxVmQOIp1eeokC7cXJ4/ZTgqsw05CzFy+K+/ZpqBsHjN1tZ5ZHKSeihz+muWq63hVpBXO5hEE++aW7+rZMjZhwO5DRQsYQKjJarC3C27cGNT6VgnacM/ZW9dJ6j4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739632011; c=relaxed/simple;
	bh=bBASK6T8J+4wU9OzljUFw/S7zGuCim4vGcwZYYLV7pQ=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=iNY9LzBVYlKB1VPh0inqRgKytXQ/TG8+JCo+lTSPpAh8grW6KnrvOkoy09bk3gYo0hjcFzFuIqCr0QsvO9J/oRYHiY84A3xLr+QhoI1qLpIXYgKotcHGpoWNO5ZHXd5+LTI4yDiMdOo1C0rv+kNxIW0VBgohte+Wk5vbbTNoZGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fOzHer6e; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7c07838973eso279510685a.2;
        Sat, 15 Feb 2025 07:06:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739632009; x=1740236809; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4merkQnx2QJYD7ghPFYMVdZyoUZfLMzy+3w9UfBn9FE=;
        b=fOzHer6e0YyhnvbEiV7WQakheZiHa7XQBnTFKP3gainwCN9P5clk3xsCfVxHMJxT+M
         gTvdFsdYIl/NCjbqpiwDgHhhIKy1+Qz+H7JrwoFt7Zer5eMIPLE5VplZlMKKlOFEDRT6
         boYWewL1Yih0z9LyLrNhDFRtAqJV0Gm7l1SaJj5PfSdHPpyErXJLGKRYlp7+HOKiFIj0
         pD2lV0Hp65ByGjtmSkQA2TWRmk12El2/2RK3FAoGoWdZTiIQmR6kESbkm4a/WQZcZPC2
         /bcW9SySa0KSYloKrymTGKu99LRgls2zSBPxm/JPe46m5HTy0Khm/WMsdcXP8WdYsgSZ
         YYmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739632009; x=1740236809;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4merkQnx2QJYD7ghPFYMVdZyoUZfLMzy+3w9UfBn9FE=;
        b=cWp1TN12t0SMgvafiC3Wa0HZb8f4EQDXhAIC/XfdszMvyi5NupQaPqlngjwqONAunC
         fR/n14hNS2fB26JXAaoPppYl0HNu7/vRA1UfgswRieO7zJduGB2iObtkHl8liajvGPG8
         YsJlLTyeOHvnFs+hElhOBUv2ZwdFy5mnWFEhv1OESMHEO/TNGo8C/E13bHgPufIFBcKk
         NU+o4jxCTUQMDQWsGAJWvmjO4+Ixjuatjtrm/n7w2pZN+1CwxeyEuIzbnG6e3tFqFdYF
         r7J3WDLcyFlgZudoo8qmByvDav0DNN1zCeJgkkobjRnrUB0lNyzisHyfx5bLMkg2IIBg
         ZGKA==
X-Forwarded-Encrypted: i=1; AJvYcCWmyl9ZavnOoGKwalcDzMOPFi1WLkD0L0V8RUAzfwDpa3bmkpAuDXg3iqs04H3X+3D3OvARjTs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUUe9lzgX6lJnYYFixUsGbWvc6dFINRJ2AbhF+BPtrsQaji7M9
	L5KKSSI+8HKK7j/qxYB4wHrF7Hbd8ydPGc7t7HiM9BK43I7K9zBZ
X-Gm-Gg: ASbGncuGO6lNeR/a/kj6hra09GJvKVMKganVGePE9AS18tYmd0ivFxjjigoKNIU+taR
	78lmb6IWzYqkaz69z/IeuDg6ek7Fn/jH9B745wiyR1Ajma6z0rIVvGrCbjlYajZ4/3yzn9pWCor
	QpN8M0+gjODFgu6PkMwRF6WQTiSKvoGzj2u7XniTVJcNN2Q8sDXVOOnhi2T7+smuRwq0LTx1Hrj
	6ZnJLvdHmmVpOW3pX0bgfElJuPhT5rFZ6JqczQ9hjl1kQEft6SflcmDJAuu3tJGxwUGwIS7U9NZ
	jxGKhyiCV8cFunFqlXFLRSpj92FctfwwV28KvaAAy5IuNSNFdvEGyt826u252SE=
X-Google-Smtp-Source: AGHT+IFrTctZdPczLYH6k6UeuJpwlMvkHyyHyoa21HN2qCfWkeVh2lubWKK2odmTCR0myTeJyuCBQw==
X-Received: by 2002:a05:620a:29ca:b0:7c0:51b5:1796 with SMTP id af79cd13be357-7c08a9c9a0emr392436785a.29.1739632008924;
        Sat, 15 Feb 2025 07:06:48 -0800 (PST)
Received: from localhost (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c07c60821asm324828785a.25.2025.02.15.07.06.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Feb 2025 07:06:48 -0800 (PST)
Date: Sat, 15 Feb 2025 10:06:48 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 dsahern@kernel.org, 
 willemdebruijn.kernel@gmail.com, 
 willemb@google.com, 
 ast@kernel.org, 
 daniel@iogearbox.net, 
 andrii@kernel.org, 
 martin.lau@linux.dev, 
 eddyz87@gmail.com, 
 song@kernel.org, 
 yonghong.song@linux.dev, 
 john.fastabend@gmail.com, 
 kpsingh@kernel.org, 
 sdf@fomichev.me, 
 haoluo@google.com, 
 jolsa@kernel.org, 
 horms@kernel.org
Cc: bpf@vger.kernel.org, 
 netdev@vger.kernel.org, 
 Jason Xing <kerneljasonxing@gmail.com>
Message-ID: <67b0ad8819948_36e344294a7@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250214010038.54131-9-kerneljasonxing@gmail.com>
References: <20250214010038.54131-1-kerneljasonxing@gmail.com>
 <20250214010038.54131-9-kerneljasonxing@gmail.com>
Subject: Re: [PATCH bpf-next v11 08/12] bpf: add BPF_SOCK_OPS_TS_HW_OPT_CB
 callback
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jason Xing wrote:
> Support hw SCM_TSTAMP_SND case for bpf timestamping.
> 
> Add a new sock_ops callback, BPF_SOCK_OPS_TS_HW_OPT_CB. This
> callback will occur at the same timestamping point as the user
> space's hardware SCM_TSTAMP_SND. The BPF program can use it to
> get the same SCM_TSTAMP_SND timestamp without modifying the
> user-space application.
> 
> To avoid increasing the code complexity, replace SKBTX_HW_TSTAMP
> with SKBTX_HW_TSTAMP_NOBPF instead of changing numerous callers
> from driver side using SKBTX_HW_TSTAMP. The new definition of
> SKBTX_HW_TSTAMP means the combination tests of socket timestamping
> and bpf timestamping. After this patch, drivers can work under the
> bpf timestamping.
> 
> Considering some drivers doesn't assign the skb with hardware
> timestamp,

This is not for a real technical limitation, like the skb perhaps
being cloned or shared?

> this patch do the assignment and then BPF program
> can acquire the hwstamp from skb directly.

If the above is not the case and it is safe to write to the skb_shinfo,
and only if respinning anyway, grammar:

s/doesn't/don't/
s/do/does/

