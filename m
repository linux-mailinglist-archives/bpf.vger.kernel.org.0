Return-Path: <bpf+bounces-68502-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16594B5983A
	for <lists+bpf@lfdr.de>; Tue, 16 Sep 2025 15:53:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99D684E4AD2
	for <lists+bpf@lfdr.de>; Tue, 16 Sep 2025 13:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1301C31DDBC;
	Tue, 16 Sep 2025 13:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T+INquI5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E6631D731
	for <bpf@vger.kernel.org>; Tue, 16 Sep 2025 13:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758030779; cv=none; b=dwi0e1A8+Hd7XghzgD8mQQwgncJG3/eeGRWk4MzpV/zuc//36e/2JIOnNfDAhnlippv2YZ65Y0J91spzHbFwxN3YbnoAB1/rU7lw/IEd0nS7SWa7PUOpom2uIMdlPFVjp0irgjNYigdIkppPX+KO7Ktn4bV3XTyNrl4H+v4bLsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758030779; c=relaxed/simple;
	bh=noQokfXo677HbO1KhlsTtMZqS1QjS+MugjU8Nq/bfI8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a3xcRuspnOa0QO32R5tYeqmjcFZs8DWxgPFHrRTvkZLLfDC9UpEFTISWiKIOcRSDGdW/6Hylo1QNxOmtasijC6FJGCHJ9HhCfnRJ7N9wGIyOoskziqMcKeGWKE7OzFL+d5K+tqBijDhaFVjPV+2af6hZup5Dux0XpLmbcfgweSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T+INquI5; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-80e4cb9d7ceso708216485a.1
        for <bpf@vger.kernel.org>; Tue, 16 Sep 2025 06:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758030777; x=1758635577; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eKXrLdmO0cSeCLSERWY1pZi3jW8d5F1Vj2Erw5DVfII=;
        b=T+INquI52NIFQsxNO1kmBVM3ZtM7R5uCZfJI6Cpb3TrWtQSsvtapdTZVtx5y7OkZEA
         329ewXmQMvxXIR2FByNdd0TT3TzQVhNCrXQkhqlB0dAFIlXqChdBno5ofi+a8nj2ezFh
         HpU/fhoneyEkuUH3XoKgA5RSJFpsD1NPBwx8fih0HPBUJRSzxMP47WZz9fE1QBdpgQpB
         UA3CFyd8JnQoWgZEfwVUGlx2ydv1PbFmqHuUJiBxGAijBJ/jMm4fIhzSALK+0yVmkTOw
         pCDLf/m6ZCjLSgjC20F6XiTwoAZbvSV2GxC3nSXkXuxWKiq3vC3Of3+dSFF7lrMnuC/r
         whzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758030777; x=1758635577;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eKXrLdmO0cSeCLSERWY1pZi3jW8d5F1Vj2Erw5DVfII=;
        b=bw3d4cBrnM3IZ2xZ7DmFNPzMhNwBPssyZLMPshvCAhJ2/iivLIBgpHJ0PnhxdodvV4
         Lct3Gik5sJ8egtUVCxpn01AIEPYHTGqg1GoL1V1RqKCSKoVbzbH4qbrMvmfSrdnO8/X2
         BW8Aijh0yajfSqgKMK/SC9J1sKhCpDDegZFDbT2nGda6OGWGDcVUPAUHod1JSbspQJ6Y
         7q4/WhfotVEGzF+TAnmj/1wEkJn/JlyNjA0bnnGxpUhJhHXzAruMxTMY8nOEzK4/VEAa
         nZVHxbO2X39qWwdx96EnqcnfHizcJLklKtbCdTHFPh2inIdNvvY4S1CeH6uvAqaq9MCR
         lM7Q==
X-Gm-Message-State: AOJu0Yw5/+TDtk0cj+Z58NBgqumA0O/uoHZ19xnrwtLLYDqF8KuixyRG
	o3eyxJ6utFtK1FYpi2+Q7cvHjwBU7zTSweHLenxZYay83GHMcnFRgtG0
X-Gm-Gg: ASbGncty+NXyoYLcOZj8II/YE/0lKdEZxE40ondYgi9e/3GJaBHlUClGUy+AH9a57jf
	z/bKLQFGcYYWW0Yiaq2rxHf2XyIeAuK0GvVIa65WFe6odsMpFcvinGRChpafCFHGREcfEXRexuc
	JYfii21aIKniPm0ug1ygOWgy5D1byvYVwJIPMJmJLVHDdqs+vtr6qHv3LP4kAwOqswH40lr+Q7Y
	o4SJl3QFGKzd/S3x0DEpYn5uGRu5hROPqR9Gc8vn6sbHvlMe/InDXrROD+6DgAYQVxcqv9Le+jd
	msOWBALDKqAWQR7GwxEkuuH8kIlEFQAp9EO39Hn0WrzwpoPFUZqVSk7RTKW5DuFFqfwDw8rPwtR
	Xgg5lfATwQL4ZEgdKm6OwoHXEARYC9p1pdZ5IL40YTcs/xKSHWnYeJIeCJXHc
X-Google-Smtp-Source: AGHT+IGRi37NipeT9mfdnQOJH6WATIfzhlHcS9dh3l5GiuasMXMo41tfF0sRmtMehk4/PnYd7mmu9w==
X-Received: by 2002:a05:6214:b6a:b0:77a:29ba:1b68 with SMTP id 6a1803df08f44-77a2a15a977mr122287156d6.63.1758030776758;
        Tue, 16 Sep 2025 06:52:56 -0700 (PDT)
Received: from [10.221.203.56] ([165.85.126.46])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-778d99113d1sm53465096d6.68.2025.09.16.06.52.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Sep 2025 06:52:56 -0700 (PDT)
Message-ID: <b67f9d89-72e0-4c6d-b89b-87ac5443ba2e@gmail.com>
Date: Tue, 16 Sep 2025 16:52:52 +0300
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 0/2] Fix generating skb from non-linear xdp_buff
 for mlx5
To: Amery Hung <ameryhung@gmail.com>, netdev@vger.kernel.org
Cc: bpf@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, kuba@kernel.org,
 martin.lau@kernel.org, noren@nvidia.com, dtatulea@nvidia.com,
 saeedm@nvidia.com, tariqt@nvidia.com, mbloch@nvidia.com, cpaasch@openai.com,
 kernel-team@meta.com
References: <20250915225857.3024997-1-ameryhung@gmail.com>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20250915225857.3024997-1-ameryhung@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 16/09/2025 1:58, Amery Hung wrote:
> v1 -> v2
>    - Simplify truesize calculation (Tariq)
>    - Narrow the scope of local variables (Tariq)
>    - Make truesize adjustment conditional (Tariq)
> 
> v1
>    - Separate the set from [0] (Dragos)
>    - Split legacy RQ and striding RQ fixes (Dragos)
>    - Drop conditional truesize and end frag ptr update (Dragos)
>    - Fix truesize calculation in striding RQ (Dragos)
>    - Fix the always zero headlen passed to __pskb_pull_tail() that
>      causes kernel panic (Nimrod)
> 
>    Link: https://lore.kernel.org/bpf/20250910034103.650342-1-ameryhung@gmail.com/
> 
> ---
> 
> Hi all,
> 
> This patchset, separated from [0], contains fixes to mlx5 when handling
> non-linear xdp_buff. The driver currently generates skb based on
> information obtained before the XDP program runs, such as the number of
> fragments and the size of the linear data. However, the XDP program can
> actually change them through bpf_adjust_{head,tail}(). Fix the bugs
> bygenerating skb according to xdp_buff after the XDP program runs.
> 
> [0] https://lore.kernel.org/bpf/20250905173352.3759457-1-ameryhung@gmail.com/
> 
> ---
> 
> Amery Hung (2):
>    net/mlx5e: RX, Fix generating skb from non-linear xdp_buff for legacy
>      RQ
>    net/mlx5e: RX, Fix generating skb from non-linear xdp_buff for
>      striding RQ
> 
>   .../net/ethernet/mellanox/mlx5/core/en_rx.c   | 47 +++++++++++++++----
>   1 file changed, 38 insertions(+), 9 deletions(-)
> 

Thanks for your patches.
They LGTM.

As these are touching a sensitive area, I am taking them into internal 
functional and perf testing.
I'll update with results once completed.


