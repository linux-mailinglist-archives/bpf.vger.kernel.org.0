Return-Path: <bpf+bounces-79569-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B3C3DD3C24E
	for <lists+bpf@lfdr.de>; Tue, 20 Jan 2026 09:40:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7364D449B8C
	for <lists+bpf@lfdr.de>; Tue, 20 Jan 2026 08:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3D6B3C1997;
	Tue, 20 Jan 2026 08:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NgC+jtAa"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 969913C199D
	for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 08:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768896703; cv=none; b=MsX2txqLPz2M9zgNCSQiHg+4GZtVNkRifj8pN4W9MGQnO1M9HSvakQd8g0eJj34bXfMb50rFxZ/xt9HrUjb2SPgHGCAB4YEzbc1Zz/6Fy/D6XyiUdillZgS1EVZOPCH08WSdPxVyYmVLSeWoB6c/kw8bgFZH2CKJsVSZAlW6aHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768896703; c=relaxed/simple;
	bh=RLYU6yzNuzae4INs1LtHJwUl9JdIz9mbRO2Fzz7sQL4=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=W/b56vCp45XhTeZ0bEGLx+k1bIxUXFXkYsQVih0Ug0dQIEnCoWf45OoFD9ExgMFHX/HmPFGeVB2rsT62h917DKEnKIkdwPVLaV4xL9xTASprE6ZOUGAVynxFMFBLYbA33LvgylYYukL9095NM+qZcEQfVc03A8Ux36AoJk5m9iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NgC+jtAa; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-7939e7b648aso50435867b3.1
        for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 00:11:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768896700; x=1769501500; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ea7CiM1dCMU3Zku91VNM6LLapOT6229p0+lrebhuvjU=;
        b=NgC+jtAaSsa47ZyIPZe/qdUz8fet/6K4GZdXk2syzl/u+TneJnKTZ2ejfRLiREO35I
         gxmHlcpdNknx060Oa1LZl+574OGoCXE2n+Kk8+5MZq0OKwXTFJKvloYW0ycOKLmOZAUh
         QbdrWaDe7FGY/+ChiVj2XjMXGnSAI/mZqrE7HeXIkW161bFG2vNX4qRl7V0qXdySPHt4
         iOKQAual8YFt+sXdfiEhCsjYcJ6x6zp+dGqUrsVttWAd6kAVmEilazEQ3UO+Ho9QlR7p
         z3OEKP5Ysc5yDqvgqjoc2JxT2CI8SuTMRu/FLj6rhdrWUqPCtTAuSTxRifSd8e/wUW47
         yC/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768896700; x=1769501500;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ea7CiM1dCMU3Zku91VNM6LLapOT6229p0+lrebhuvjU=;
        b=nLl80bAqwI35i/pae69wHOlFSDaaBGb5DNdeMRUKZRtBh6lsJ58TmvuEuFSoh5p+gv
         1GBcP06s1RrWw5z8bxIKtp+H9NO6QhdLrkPlTyYR74UkD6Y7TKtOaRcOQfEPIooYlNz6
         G+wnMcrPJW/nBrod+ZltcxPaVI2ANKs70zXyhq7uTLFF2h/wPK/0MBKz20NjU7rws2ws
         RDWUYzfoWkylCAqDfCOBiglmnopOqlljFiruQYfp/Gz6EHlo8kFQEYj9WWzVD/bbU0rB
         Ok2a5N5Q4kcwptu0ddZ0L+zx6HIbuXl/5CYy9x5rmO8cwX6xpDaMiUIk5hdBr61FXS5w
         O4rw==
X-Forwarded-Encrypted: i=1; AJvYcCVK13w2fJJucUg68gJQTm3IDT9GcnhCsElxkEZgN4CdecjHYPPFpuES240F4DgA5lGb/eI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnQcRiSpOBoN8M0GjHv2aqLVkAaXw3LY88BA2vkKWPQe9k3nG9
	i903bBtnjXmlUOrltnEYSfqpeta4cGSrOBz96VMBjPXJhm2j0jz7nawr
X-Gm-Gg: AZuq6aLLDhF/+VqiDc5S82KGFea19PWXKe+bOScSnQK56K43ymJbOcPgPXInXKSgnRQ
	8w0Na1N0MZTV4Olbb7d0/+osePFh/TwFxitatHdTlPXcYoqxQcmsqqU+yb2pu0uQWvtUKd6hbEH
	IdGs5RHwiXX3lFe6P281tFULFaEL+JxoQsIwZ3K/UzDxl7kJ03pRKnD/5FntRfFBrVD4nn7zHE8
	afG4oLNtrMK+ANTDKxTYnoVx7jJqid0rInADqFR8d5/vlf6tTa6vCvAsJjoP9QKXlxnQhpT2K0G
	AKXPCeJPvjljjZlAmkgSok1qjSCKZj0GqJAfnEQk20n/OuQmwp+rrn3NhfI68XKSwdiLqNLcsv6
	bhdmBgdqxtAbDsCOYsbFTTcSdNFEl81+UTAxX+fI7uQipl8vXPNcvyJDJbSYVzDqwAUfRTTQK1C
	3Qq6ZGlWI49KGSMSxSnziTciIUkHfc4nEzmWJblg/SzMkTaR1g+mF6fLtq
X-Received: by 2002:a05:690c:4c02:b0:787:ab13:eedd with SMTP id 00721157ae682-793c536b4a9mr113431447b3.40.1768896699959;
        Tue, 20 Jan 2026 00:11:39 -0800 (PST)
Received: from smtpclient.apple (2607-8700-5500-8678-0000-0000-0000-0002.16clouds.com. [2607:8700:5500:8678::2])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-793c66ee062sm49742117b3.15.2026.01.20.00.11.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Jan 2026 00:11:39 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.300.41.1.7\))
Subject: Re: [PATCH bpf RESEND v2 2/2] bpf: Require ARG_PTR_TO_MEM with memory
 flag
From: Zesen Liu <ftyghome@gmail.com>
In-Reply-To: <600177c05c552f470cc5e25c7dba6990d96790e9.camel@gmail.com>
Date: Tue, 20 Jan 2026 16:11:18 +0800
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>,
 Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>,
 KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>,
 Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>,
 Matt Bobrowski <mattbobrowski@google.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>,
 Daniel Xu <dxu@dxuuu.xyz>,
 bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org,
 netdev@vger.kernel.org,
 Shuran Liu <electronlsr@gmail.com>,
 Peili Gao <gplhust955@gmail.com>,
 Haoran Ni <haoran.ni.cs@gmail.com>
Content-Transfer-Encoding: 7bit
Message-Id: <145C0ED0-4350-4CCE-99E2-EADD23AE3BB5@gmail.com>
References: <20260118-helper_proto-v2-0-ab3a1337e755@gmail.com>
 <20260118-helper_proto-v2-2-ab3a1337e755@gmail.com>
 <600177c05c552f470cc5e25c7dba6990d96790e9.camel@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>
X-Mailer: Apple Mail (2.3864.300.41.1.7)

[...]

> On Jan 20, 2026, at 04:25, Eduard Zingerman <eddyz87@gmail.com> wrote:
> 
> Note: this patch no longer applies properly because of the change in
>      the check_func_proto() signature.

Thanks for pointing this out. I will rebase to bpf-next in v3 to
address the check_func_proto() signature changes.

