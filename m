Return-Path: <bpf+bounces-71408-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D922BBF22FD
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 17:45:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBE2C1899DA2
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 15:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F6B945948;
	Mon, 20 Oct 2025 15:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q6bdbHiw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5521B87C9
	for <bpf@vger.kernel.org>; Mon, 20 Oct 2025 15:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760975132; cv=none; b=BQUYA0Fr9bXe0TzXRpCeQbPQVOVJFT7+ue2Z5zhwmJ5f/ERa9vgHARJSrFy8S4JPtDIT+2WORDLPGiyoQHzIsflvZ9kGGrv2S5iZT2eUWNVwHUNJu2O6e0j3bnSLiA0TfnyBUmY+yAazAQ9LJkOAOx/BwIgBg0vCJwWrjbDtYGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760975132; c=relaxed/simple;
	bh=rWlIEOfLt4QSbEFCHlWSDOc4rlXWOXGgHbTI9+CTFCQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EnxGfA2qUuOnYqSF10ev6aDlwhyH7OjDEjcEHRnZFCMo2qDDsSQMaiBHpDg+O5FgZXIcMoKpz6lXDXamRkHzWjkQkKH6W4JbVN4b94RrbdFkLBIq2aNt/9eLcg9LBJdGdZ8B3pPIdNtQKqrjUn65aa8hmdKgF+aF7Ray1VfkYqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q6bdbHiw; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b5dfff01511so123266866b.2
        for <bpf@vger.kernel.org>; Mon, 20 Oct 2025 08:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760975130; x=1761579930; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rLVd96XUXQkv2BukfYJUOUjTeSFa5/2WoKAq5E06sq8=;
        b=Q6bdbHiwrRq1zIGsJJWe2QJyedChhIdxEnYcqcecYhUr/u7zNukFYIRP/wSG8+p+Si
         vh/YBRGNZPu2iqKjLw5opnGX9IXUA6oIwVf83m+NB5Hz292YMSrSEgyUjYUweK9Q2icO
         b9Gk4/gpcJUEyn9KVR2Q5pe0QEitnb2nQdfeIghptNLusMdQEZ/mpPVSm81mTVb4jzeq
         7wNwHiargEKo++DVi49ic1NpMWbFsCXlzXJi7oI11mtG7/+00aCx6BS5md952OKX/hmI
         uSeB5niviOsCIBxyj+LJcOhpEvLjKYhTH9wlQldit4KMuIGAnp8r406ks9uZvNWqkJGn
         Lcbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760975130; x=1761579930;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rLVd96XUXQkv2BukfYJUOUjTeSFa5/2WoKAq5E06sq8=;
        b=oi8e+caDU70s+5I7CI//1cZfsAGO9iXe3nApgm4kA8+f5v6zFsj+bm2DnP8CkFJBGt
         MGz19cv03tXg4qw2HaaIluB/vSDfMbVMSUYtglDCKKbcduHOIsaBGclq2hiyEIG02++/
         3YJe/Rv+6HQ7WwA+PbyMsJkfA/Lx3cX5SzuI9jS20V9EbA7DHbW26C3rsDBuSjx2PYNv
         jL+LDgauxu7vKKp9XV0ZwUZYM+47NFULnKi2cb5cAtV9GnZ9xAPwGwuRruIFKekbOU79
         cGC9GKQK4WkF/PHJE+YSC2H+FliXXWy6mLPRc0WA3vGcd8HA0fGSxHNIIlI0yVuK9G1f
         tFeQ==
X-Forwarded-Encrypted: i=1; AJvYcCWDZk+Z3M5gdKNehnbq7bm8/NCHotbC2c0BymLgd1BlEsuqFFuDzVxxz3bqWR8Z1hed4SU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyD6nPW/cunwQ3FssN86oxpfyIimuhkvgH5kOnlqzgW+ZmujcXH
	B8HEd1Gva7NPoP8KceqnMuokvTwoNw2ky5Ru46myK+TznQdYnB2zg3il
X-Gm-Gg: ASbGnctvzS/JhiIZ9jnccaphPd7WM/fwrcS8u7gIJvZT4kn5herZml6E6vooEdl2732
	og+Xi+6xLNMtnnfjOok6mpQXngmdxeJDHI8ebq37xipbxbizPHNGY2LR1lADckW8ayEzo0y4cFc
	pdCqlrPkuHcCyiZWOWjej3KwJgaEs6/LKb6GwBdMszDhtcPuvBgaq/ThBllGi+e+A7piLhTfV26
	sT5k888EM7YZeUCFeNH7hMSYBIXnfHS+EQj/RLxX6nHLpR5Gs2NcHUHCbqqeNU2sODE1cvnNZQt
	CkfhPwcvGyEfPgxIu+jPYAYVlhYm65WaUh/x2HKEwlvsMz+qniWnYL6kjdhNzIoh7pUQ1EeFgpW
	PoEaqe45P9Fc+t3gfWyzpOCq6QJnsNDWZLVx3bBfx2svf7eQjyaQR+9cszkxUFEBbEhG0ws9i0j
	WD8TTGm8hva2exCxPX0EpO1hVxsYlvcQ==
X-Google-Smtp-Source: AGHT+IGbvK/f+EyST6/Ou/X1/Otr+t9j4IgsCu8YzzEolwEyyl33v0jG1ZAXlIIZiPmx169QmFhW2Q==
X-Received: by 2002:a17:907:9708:b0:b04:2d89:5d3a with SMTP id a640c23a62f3a-b6475505d94mr884342366b.7.1760975129544;
        Mon, 20 Oct 2025 08:45:29 -0700 (PDT)
Received: from [192.168.1.105] ([165.50.86.146])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65ebc474c6sm808850666b.78.2025.10.20.08.45.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Oct 2025 08:45:29 -0700 (PDT)
Message-ID: <d9819687-5b0d-4bfa-9aec-aef71b847383@gmail.com>
Date: Mon, 20 Oct 2025 17:45:21 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next] bpf/cpumap.c: Remove unnecessary TODO comment
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: ast@kernel.org, daniel@iogearbox.net, davem@davemloft.net,
 kuba@kernel.org, hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, haoluo@google.com,
 jolsa@kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
 david.hunter.linux@gmail.com, khalid@kernel.org,
 linux-kernel-mentees@lists.linuxfoundation.org
References: <20251019165923.199247-1-mehdi.benhadjkhelifa@gmail.com>
 <42b9b376-897e-4984-909b-218bd1e3214a@intel.com>
Content-Language: en-US
From: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
In-Reply-To: <42b9b376-897e-4984-909b-218bd1e3214a@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/20/25 4:41 PM, Alexander Lobakin wrote:
> From: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
> Date: Sun, 19 Oct 2025 17:58:55 +0100
> 
>> After discussion with bpf maintainers[1], queue_index could
>> be propagated to the remote XDP program by the xdp_md struct[2]
> 
> But it's not done automatically, so not aware users may get confused.
> 
> Instead of just removing the TODO, I believe you should leave a comment
> here that the RxQ index gets lots after the frame is redirected, so if
> someone really wants it, he/she should use <what the second link says>.
> 
Logical,I will send a v2 soon.
Thanks for the review.

Best Regards,
Mehdi Ben Hadj Khelifa>> which makes this todo a misguide for future effort.
>>
>> [1]:https://lore.kernel.org/all/87y0q23j2w.fsf@cloudflare.com/
>> [2]:https://docs.ebpf.io/linux/helper-function/bpf_xdp_adjust_meta/
>>
>> Signed-off-by: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
> Thanks,
> Olek


