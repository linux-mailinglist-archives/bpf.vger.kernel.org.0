Return-Path: <bpf+bounces-37814-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0487095ABAE
	for <lists+bpf@lfdr.de>; Thu, 22 Aug 2024 05:05:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B52C82844A0
	for <lists+bpf@lfdr.de>; Thu, 22 Aug 2024 03:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 542B41CD23;
	Thu, 22 Aug 2024 03:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f5Idot5x"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE4F13C68E
	for <bpf@vger.kernel.org>; Thu, 22 Aug 2024 03:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724295682; cv=none; b=Oi4AhFzWm+pXy8518n7/SqM6U3HWDZoYrfkAxVlhgnssaBiDWYTc7yOukYGvA61R7L47qFF7+XSk3lKQdJ9vLbwIFNNWlntCutHb4Dd3mBLaDMgcxu1PtOHKGFRr3k/EYNahOsRtmssxNzTjJTOS0Jpzvx+bXZHUUlyZByyWz+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724295682; c=relaxed/simple;
	bh=60IFpBxh3566WQ34Hg953/oLKuPxO9YktDRaPbXEznc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sknb+fWa/LKK3tuN9JdBurmbwZOfQ61jKKTqw0/VCmHLPbIX8Lkai2ldsO5U6o8CCOXWY1ayssAA6r0wgSIxgT6EawWi8uIVa2/fBOnyYbd13Cn3kot9TudSddMcETIRaDNa3/7y32aCL7Fx8d7J0gzqVIDtdc/juSqZDehDXGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f5Idot5x; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2020ac89cabso2915205ad.1
        for <bpf@vger.kernel.org>; Wed, 21 Aug 2024 20:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724295681; x=1724900481; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V09TcFTcbQS6So4LQbe0U+KJG8InsvwsxJ5Glov5yIM=;
        b=f5Idot5xktOKDNWLQyihkdYPEXSuLhmRd2jZgHjSQxPr/qiNMY8UxjKjT9hUOqo/sd
         uzyeyQzj6m0HCaDo34XxN/DD4VNW1w58iIDG2w31Fp9FTIEEKcFbEG01VZkEaTFpI/OB
         Woh8E+mTJC/WXOUT5K0HTXH8ztf/kJzAHgnS35auZqBd7uLae2OteEsRnyFhYgLAWddh
         4WNJUYCJmVcKminoNNyhao89g+GiF0MesntE33IYa6bW+BQsF/xjRlF2xqGPL+DfeUlx
         2TMMbiNrXGQDR+XHcD0nukXwVBhYgTdoLNcTFRxI79RYawsxIimxv6b2O2NOBMbk1YvY
         ardA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724295681; x=1724900481;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V09TcFTcbQS6So4LQbe0U+KJG8InsvwsxJ5Glov5yIM=;
        b=B76tYvXaSF+iQWLAIC7zkoBz6QT4f/VScQBwEG4DYW8erEEMhKHWuNhGVA7BWcm0he
         lDPZz5BTos5sBlvdBjbtc0rqqCnsoD5v0WptF8R5GWjgc1WxHT4DRFWAFCiSXv8kfg+w
         gd58KtP+9o+SSldbkOzLKA4K3Zy2KIzvDptK9iezRsYVccRB2xAEZj2jTJYPOrkGhwMk
         IktTrIvO9GeFSbdIcgh3LeW4ujJFT3cBH6ybYtwSKBH1dBw8qODpeFEh7rbXjM+Nfibx
         jLel5ybWDG+uEccfOpjClJq5T3NK7ry0b/CpYrozCv5I7iuIrNpBQqdcFpZyvhSMNDEi
         f+UA==
X-Gm-Message-State: AOJu0Yz0XkYp5a8dwr++jAgpPcREea72FVsRvvQ3cF/ktC3m/C0Wc/SE
	AUpEAMmjbp+6P1jtjCx3iURgBZtgBdEL4R2GeLLD/Qe4+AzlWu29
X-Google-Smtp-Source: AGHT+IFgHbt0/yOBvPhY1IYgPgLildgISKduutLIQQjJC8OOs3EC4UKUyJTAues7+jKTVolgBMN+6w==
X-Received: by 2002:a17:902:db07:b0:202:4042:8520 with SMTP id d9443c01a7336-2036819c18emr55406645ad.37.1724295680560;
        Wed, 21 Aug 2024 20:01:20 -0700 (PDT)
Received: from [10.22.68.77] ([122.11.166.8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20385fcf6b3sm2802485ad.302.2024.08.21.20.01.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Aug 2024 20:01:19 -0700 (PDT)
Message-ID: <8730a5f8-cb17-4c31-b62d-5faf529d7d89@gmail.com>
Date: Thu, 22 Aug 2024 11:01:15 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 1/2] bpf: Fix updating attached freplace prog
 to prog_array map
Content-Language: en-US
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Leon Hwang <leon.hwang@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
 Martin KaFai Lau <martin.lau@kernel.org>, Eddy Z <eddyz87@gmail.com>,
 Yonghong Song <yonghong.song@linux.dev>, Tengda Wu
 <wutengda@huaweicloud.com>, kernel-patches-bot@fb.com
References: <20240728114612.48486-1-leon.hwang@linux.dev>
 <20240728114612.48486-2-leon.hwang@linux.dev>
 <CAADnVQK-f=dCsN4E2goj6YjDkTD4PhZK=VTZygaUsK9JPD=Wag@mail.gmail.com>
From: Leon Hwang <hffilwlqm@gmail.com>
In-Reply-To: <CAADnVQK-f=dCsN4E2goj6YjDkTD4PhZK=VTZygaUsK9JPD=Wag@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 13/8/24 06:34, Alexei Starovoitov wrote:
> On Sun, Jul 28, 2024 at 4:47 AM Leon Hwang <leon.hwang@linux.dev> wrote:
>>
>> Fixes: f7866c358733 ("bpf: Fix null pointer dereference in resolve_prog_type() for BPF_PROG_TYPE_EXT")
>> Cc: Toke Høiland-Jørgensen <toke@redhat.com>
>> Cc: Martin KaFai Lau <martin.lau@kernel.org>
>> Acked-by: Yonghong Song <yonghong.song@linux.dev>
>> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
>> ---
>>  include/linux/bpf_verifier.h | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
>> index 5cea15c81b8a8..bfd093ac333f2 100644
>> --- a/include/linux/bpf_verifier.h
>> +++ b/include/linux/bpf_verifier.h
>> @@ -874,8 +874,8 @@ static inline u32 type_flag(u32 type)
>>  /* only use after check_attach_btf_id() */
>>  static inline enum bpf_prog_type resolve_prog_type(const struct bpf_prog *prog)
>>  {
>> -       return (prog->type == BPF_PROG_TYPE_EXT && prog->aux->dst_prog) ?
>> -               prog->aux->dst_prog->type : prog->type;
>> +       return (prog->type == BPF_PROG_TYPE_EXT && prog->aux->saved_dst_prog_type) ?
>> +               prog->aux->saved_dst_prog_type : prog->type;
> 
> Sorry for the delay.
> The fix lgtm.
> 
> I reworded the commit log, since it's too verbose and applied to bpf tree.
> I will apply selftest to bpf-next when the fix makes it all the way there.
> Otherwise there will be non-trivial conflicts.
> 

Hi Alexei,

Could you apply the selftest patch to bpf-next?

I'm waiting for it for my new patches that fix the panic that I
mentioned at
https://lore.kernel.org/bpf/172a5daf-8a3b-44d1-8719-301a6e8d196a@gmail.com/.
Because the new patches should add tailcall selftests based on the
latest ones.

Thanks,
Leon

