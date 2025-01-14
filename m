Return-Path: <bpf+bounces-48785-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1365BA10A08
	for <lists+bpf@lfdr.de>; Tue, 14 Jan 2025 15:57:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B87C73A5507
	for <lists+bpf@lfdr.de>; Tue, 14 Jan 2025 14:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0DDB156887;
	Tue, 14 Jan 2025 14:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NWBnFIkb"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD0F155359;
	Tue, 14 Jan 2025 14:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736866624; cv=none; b=UwEzeS+Ucoz/D04jG1ZQJGnmDf/IBjMCOGQZDG6qwv8MtlfjYrQpBb+QXgWfDps7HLajfqUtzCi0Dk8uORACkimYqZ1E8EE9nHppVwMXi3HSqtJGm3bDkV9+rsZtVwvsfNg2rKvOPojsIeTIOkU/gXtm3kLvHpDd+cdmgmzNuuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736866624; c=relaxed/simple;
	bh=oCB4eY47rtdB0J5M4dUVDjf0mAMot9+HlQNMbwxCRSA=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=juIUYwasMLfs1hq3GDk3xUsUaTE/i3eNEhJNEH0ok4aDOYgnSKXQMiTn70fULvMNjX0SRCil1UuELGxdVwQG/ZHl5kd4BXkTPmlJAV+xsRevKDYrpUj4FZonBsGC1o8eTDO7rE2LpGUmSPS0Mch/vxWdN5t7Jg1Ms+ZRy0tUzlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NWBnFIkb; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-aaee0b309adso917807066b.3;
        Tue, 14 Jan 2025 06:57:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736866621; x=1737471421; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zyGBvV0rsTJB5SAWynK2sRNVzB68mWr81iKms0ttm1s=;
        b=NWBnFIkb50VIcgDVCxR8eqtDZYZt+839WI8qqNP60OMrRe//f35i7SYuhUezMN2drQ
         D3QJHG9nuDdlIwQs09Opi1+FK5J8g1SLZgNU13JsRYVxQJShz8t57N591b2YPi0LQ1zY
         GA6/B4vFehmMtQV+oR9RsgjA71MnrBmDXiK7SZeWr2dKQU1ioVBZClFPrKRP/Xs5v749
         W4Ux9gZPKripMBuUivnLW6TkgfWcy9CWinmKDEFd7rr/MZZB9JI565j13TYcyAY7p90c
         KDPRhQJ0KcBfuDnsTzSB+8mgTDs2kkvPjSYZgjYMOk/lSKKU50l2fvltUC0Lzefp2srp
         v1Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736866621; x=1737471421;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zyGBvV0rsTJB5SAWynK2sRNVzB68mWr81iKms0ttm1s=;
        b=xIbTQ3zOsGchVjwWM+ede4P2JCaejWca5ZOSITzlk6xjQikTAZ3Z6PT/zRrc9t/4le
         tzPuxGUqW+LTjUlewXobOFuVvb3Fb2JzvMyQQTJun+iV3ckA6yb4uBTNn4E09tpueZZc
         2kQucScqY+ajNh5k/zt89p4/Cwijl/mzmmx9+eo00aX5Q50WZnxy9AaPZ7js4RM8GBIg
         hvGRoVWntOIgJMVuxsJkvt5eBPHLlCO7BBiM6DQZlWmhUJMQSVGu4Cpkz6kGPj2ZblLb
         cWILq7HoDnRvK4b8XtqLGm3eXL1CQ9tyqLACuk0aC0OqeB7lPkgV2hVRlnxhplzBtpm7
         1MJg==
X-Forwarded-Encrypted: i=1; AJvYcCUetmMhD/McS45WGBCawRgX9/sVGj0ltiBtKD8FyloQ2IhxvyfQ0I/+ixvmqnGK4ihAa7/oqG09r8mAEKh1@vger.kernel.org, AJvYcCWC84CHbQv6Y4UkHc3tdZES0crAUPy/AyUyvgx8jfKBJOzQiDqUTsyVLc9bqYxYI+92e8NVt9w0Hi7LCgQGYnwePa6Z@vger.kernel.org, AJvYcCWCT2+/jQWLVZd2xo+/KfAIKzgFzWStQcGB85ytZR8fJcVJklO2t8+NLVpuRMBsfAa5dL4=@vger.kernel.org, AJvYcCX++PaKIXKPejQ1FqoaHF/zQAzT+e2I0jA4QgzVnQIwWbj5MzluSxkwDprkBfVGHRbtd49jhUsYymv+@vger.kernel.org
X-Gm-Message-State: AOJu0YxxcVkOs1/C3wVU+Fwnpw8w3IDu8MGKZZsKwvlwsHCzCmYUWXSN
	gmxy8Ocw0Y+1NQJ/iKVn50U3QTX+fR33R2d4OlvS625nCTC7x0CM
X-Gm-Gg: ASbGnctWWRdqJQEnK8sq6e8RTTlZeWTdl1OfhAg/9U9Q0wdvJorEE2eupRmroEoiuZc
	UGd/WbqhD3WtssjAldw3fu+XQhTK1beoGpH9OpVrH8wkeCVTHrEUjhboHYFKxs8WCb7QaBa+PF0
	fhtw9Z0VubI6zcTeSVeQW0nQ2QWD61WYy/bPykko2ZgINbCLLsyt4JAuT8RRrlMv/BEnMoQTfgD
	nZPGdOsTZ9SuE6vHJnchv6A1Rc74ebiopDw7f4pSls=
X-Google-Smtp-Source: AGHT+IHZ9aMGG4wKkHkVdt6h/Zzook5GS/VTSZBhAWl3N1kpR50TKBEr+HMLdS+BduYidxNK4wyRWA==
X-Received: by 2002:a17:907:9413:b0:aa6:7165:504b with SMTP id a640c23a62f3a-ab2ab709c3bmr2215869866b.31.1736866620862;
        Tue, 14 Jan 2025 06:57:00 -0800 (PST)
Received: from krava ([213.175.46.84])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d99083fbd7sm6325608a12.73.2025.01.14.06.56.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 06:57:00 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 14 Jan 2025 15:56:58 +0100
To: Oleg Nesterov <oleg@redhat.com>
Cc: Eyal Birger <eyal.birger@gmail.com>, Jiri Olsa <olsajiri@gmail.com>,
	Aleksa Sarai <cyphar@cyphar.com>, mhiramat@kernel.org,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-trace-kernel@vger.kernel.org,
	BPF-dev-list <bpf@vger.kernel.org>,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>, peterz@infradead.org,
	tglx@linutronix.de, bp@alien8.de, x86@kernel.org,
	linux-api@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>, rafi@rbk.io,
	Shmulik Ladkani <shmulik.ladkani@gmail.com>
Subject: Re: Crash when attaching uretprobes to processes running in Docker
Message-ID: <Z4Z7OkrtXBauaLcm@krava>
References: <CAHsH6Gs3Eh8DFU0wq58c_LF8A4_+o6z456J7BidmcVY2AqOnHQ@mail.gmail.com>
 <20250110.152323-sassy.torch.lavish.rent-vKX3ul5B3qyi@cyphar.com>
 <Z4K7D10rjuVeRCKq@krava>
 <Z4YszJfOvFEAaKjF@krava>
 <CAHsH6Gst+UGCtiCaNq2ikaknZGghpTq2SFZX7S0A8=uDsXt=Zw@mail.gmail.com>
 <20250114143313.GA29305@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250114143313.GA29305@redhat.com>

On Tue, Jan 14, 2025 at 03:33:13PM +0100, Oleg Nesterov wrote:
> On 01/14, Eyal Birger wrote:
> >
> > FWIW If I change the seccomp policy to SCMP_ACT_KILL this still fails.
> 
> Ah... I don't know what SCMP_ACT_KILL is, but indeed, in general it is
> not safe to even try to call sys_uretprobe() if it is filtered.
> 
> Say, __secure_computing(SECCOMP_MODE_STRICT)->__secure_computing_strict()
> does do_exit(SIGKILL) :/

ugh.. could we just 'disable' uretprobe trampoline when seccomp gets enabled?
overwrite first byte with int3.. and similarly check on seccomp when installing
uretprobe and switch to int3

jirka

