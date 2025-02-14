Return-Path: <bpf+bounces-51542-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5116A359D5
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 10:11:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 686FB16D8FB
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 09:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A02B522D784;
	Fri, 14 Feb 2025 09:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cr8Sqx6H"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B68242908;
	Fri, 14 Feb 2025 09:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739524152; cv=none; b=C9AA6tds4kFuiv++xM/lKqOK/xkx7o2t9Ax69l6oqfsCXZn0G3ebpqeAt1wUmgG0n616W3HhyfwMDrtuQIbvrvmKt/7RnBbp8TyHxiRutZmuNdFfdSfFzchj75cB00dc708hSB8sqbrVkbFpkZpFJRjgwDXM9l1b2Izdl1HlzwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739524152; c=relaxed/simple;
	bh=AXrlE696ne1KgAl5fsbq5EbyQS/sRZecw/2KakjEl0A=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y5nGTao+4wojn/ETgZWLLwl5QvaB1sFgcGJ7hsIV3qMlobNrb1RAd2RXljV9X0CGckQhq+szMEAPNlhJ6X4kiatQ4WQFp6ravt2oUl+tlJAkhpm0u4d8TKlI9Dtt6/R2P4iqOwLGy0KuLRiDb0BmbRwMOMWWtE8bwO/pcTZe9ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cr8Sqx6H; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ab7f838b92eso328728766b.2;
        Fri, 14 Feb 2025 01:09:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739524148; x=1740128948; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pz6yc2Zdui7JVfDFgsQNEIsSHONr+LvrSF53Oha4fHI=;
        b=Cr8Sqx6HGq/GhF/5U5cLdBUpqBjT4yoR+8JR2tXx5Qz+57gjh5Yh2gbhG+UWZSu2wM
         x3AjW/bPBdjIVEkbaxwu47kawsPuBBvkATNTyMG8rh2JrzRSm9WrbIW2d+U2h9h8TJI9
         or5yPWXVHsTZeclRyuJHm2BN8KyMgiBS/4ReQzkyhpr3MLjkQVugI/8zQUirMFMn+/t+
         y4+Y8mvptDZSPWNh91xHuN8JaacDck0aws2SDEZQ7eiFlQ3wB287cKMCUt8k3hQxkB1N
         JWHXjtbvkY3iJK+7D6M9oCj8r+cO8lqFAVZdHDU+Kn9wxZV8VGTt93PKrrQmIderX+BQ
         JYBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739524148; x=1740128948;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pz6yc2Zdui7JVfDFgsQNEIsSHONr+LvrSF53Oha4fHI=;
        b=ma6eObUPNihWw0+lzRG1D+GxeC6qo0gUU8kGX6aea/MppUCvYlX4poTLP68r/apVCt
         dwYn6bb4ebq/npKj/JWQ208FvlID7QkYlDJHgEoGBbBukdPkcORs0H+lLpTcH9n2oj6z
         Uu/0Al/JgHvegwkOyhYWX0+30JqQFNV6JtJwfFj7PR4+/BXFNKSsv1ixUxmZBpwhjR28
         EVqR7dttNoGqhkDkf5cp0MEj1YVNrP12LZ8Qawo4306nifnGEbb7gwnQV880T7FOAEr2
         K2FM2DXWAMG4Ojylzrb/U3+yrk6RgO6VLpwRIda3ctrLVhqC+9MV/yM1TZeeLAjnC2T3
         H8tw==
X-Forwarded-Encrypted: i=1; AJvYcCVFrHzlTLc6vqgzwOlSK0/8oIOq+LQeSIBH08LFItxLt8vmkXYQSEX6mSRGPx+63SAxFW5iUeJ4x/mhI9tDsCwdcA==@vger.kernel.org, AJvYcCXdMHa/arvE82ZOmN+0lqoI48ouKc3oXe3i06bEbb4rY5Zcki49UXLDQUSpQ1ZefO+we5o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzOMi3iWREFYoPly6WUj2NpDGGUF+dOi7IoCas1hlhs8L6Bfu4
	tChHPvHA9HaYqsv9dje4vt0/XZXEv374QsRAo/xNcZnmmN/y9En8zWulQCCB
X-Gm-Gg: ASbGncvFXkW1VwKqr9KhOyS9vnujWEwfxaxXbZAKA7S5Rct4BnwS6ihUYPfF4pJj9XI
	UlvJF9KSUujJC1byGM96BJyaBLLBKD9kK724M40wrk6rFyuPH2px0MaarNcPD1X7XTBQ+/5BNSM
	zy0r1CR9BQjjqHfc1M+rn0iNaQx+y0a+ohhCpUl0aWhgn86fsKZz4S0wf72kLYxSEDX2dB+iKpi
	TfGQgTdk9zdxDTirAxzQQdXZcsUREnOqYj+DLxKvZpaDATbOX0c2jvvW/5PaaaF8Uk6RFEtYaPx
	TQ==
X-Google-Smtp-Source: AGHT+IEP/qNLFyEcoF4glqVGA4Wxob0vMO5yUCq3IUAL441SGMbQBNl3KQgUJIjpZkMgqB24iuGBrQ==
X-Received: by 2002:a17:907:6d24:b0:ab7:be81:8940 with SMTP id a640c23a62f3a-aba4eb9b519mr714148266b.10.1739524148029;
        Fri, 14 Feb 2025 01:09:08 -0800 (PST)
Received: from krava ([173.38.220.59])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aba532322f1sm303894266b.19.2025.02.14.01.09.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 01:09:07 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 14 Feb 2025 10:09:04 +0100
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
	"linux-perf-use." <linux-perf-users@vger.kernel.org>,
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Add tracepoints with null-able arguments
Message-ID: <Z68IMCpSrfDuO7iX@krava>
References: <20250210175913.2893549-1-jolsa@kernel.org>
 <CAADnVQJD1UeMZrRrrQEZ-_twryA61Au5oxacvamL+HwT+v9=oQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQJD1UeMZrRrrQEZ-_twryA61Au5oxacvamL+HwT+v9=oQ@mail.gmail.com>

On Thu, Feb 13, 2025 at 05:04:09PM -0800, Alexei Starovoitov wrote:
> On Mon, Feb 10, 2025 at 9:59 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Some of the tracepoints slipped when we did the first scan, adding them now.
> >
> > Fixes: 838a10bd2ebf ("bpf: Augment raw_tp arguments with PTR_MAYBE_NULL")
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> 
> Applied, but at this point we better switch to Ed's llvm-based tool
> to generate this automatically.

nice, I'm not aware of this tool, where can I find it?

thanks,
jirka

