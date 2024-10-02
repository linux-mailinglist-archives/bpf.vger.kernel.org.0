Return-Path: <bpf+bounces-40759-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6104898D621
	for <lists+bpf@lfdr.de>; Wed,  2 Oct 2024 15:36:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D5851F2110D
	for <lists+bpf@lfdr.de>; Wed,  2 Oct 2024 13:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 502301D0493;
	Wed,  2 Oct 2024 13:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ItAsTeOf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50F718DF60;
	Wed,  2 Oct 2024 13:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727876202; cv=none; b=svT64e/au2gQUTGB6lUkAItQGgMHyhef1b/9Fla9HVGEvdYIBYFpi4iVAPhF5XiZIajVU5sHO8zn2x09FPNkyxooMcRCKudlUrOezmCpRifqsukvyCYAi11PIlD6gOW4a64zONIsiD7cF1nOe9sXlxUzbOuILpFpb+XHq2FqvrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727876202; c=relaxed/simple;
	bh=q5ZkCgADhBZHl7oDwalsHIstFb7FyHGt5fNF8Px/R0E=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=kNBP5dyEX38JQw121M+unZRRGaZNA7rqRNuU0it+xlddig0FCHI0LdKVEh/cLvIfHwlt+TRMJ0Ts8ogS2bgdl6iDduTWqFJw8vgFfN+7WZiUyA4zx0GXsWqyMkYNk2pVVpHKhTVwO4uazpacBibBAL8A5ZX0piEtqG8AjMTIAUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ItAsTeOf; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2faccccbca7so31411291fa.2;
        Wed, 02 Oct 2024 06:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727876199; x=1728480999; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wMUkkI59XlnjFeOEzlmttnyMpJecab4sH6mMElSC+Oo=;
        b=ItAsTeOfwjx1WVdWQ+Q++Lp+FCmJADQsrpqp2lQvMxA4QCvA8Fl1q9RW0NZGSa1yu0
         xtZJXIJxxggqeULKESaRyAYWgX2tgEKrYh7PLAoxfyCWaIiaR4aDPjnDYVL2BVin7HXT
         GLuRdAAu47Q1XpI5Yq4VmAeWJvB4HOn5GHjFpKnS2Q5Pp4j5b92nqGJUMyrds/75WG8M
         ZUGbq1V6VnyDOaG6R0bGSFPwREdFaA6ENZzsIYzJnj8q0S7ZxV3/VLHyJQvyCg+AI1uh
         NKhizjWd5/RVlrXdzHculpka0f/I35KQvGEIFweq/+4svrZklgRF0KIvL5Lv9y8qA2nW
         N6Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727876199; x=1728480999;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wMUkkI59XlnjFeOEzlmttnyMpJecab4sH6mMElSC+Oo=;
        b=gzNZ0rMnqpdNAEOK9SfyMGLkUTvFmvRjgzHsndrBZoB+7gDis6LOGHaynUWX6pjMr4
         +qvi4wwM82hZAxgPkoDnUpctJ/nt/a+0JCo4tgWrvDxWQuO1/y5JmFqsXdgf4Y9DBUXG
         id7KbFB1VsOCZXeVbcbymlKYIFMAwWXFrsaPJAh9/fCeUe9BQT2eQOyM0mfcocZogGK4
         aLc+h+CwU6a0y0W/EJEMC1lr6n7iV90L5DaHvLB96V5si9Ikz4iUZMjIYy82ASilrmFF
         Ooha5xQmlUg9s1U5xZkjZQPKCMKAJ8fQl/QW1/fwEhM1cEy2UwHWO3cDBqGFbBqlvxiV
         W/5w==
X-Forwarded-Encrypted: i=1; AJvYcCVkNphg90ZXy+zTgD0XGCT/aVDRarmLmfwh3N7uKYz8xwnLwNhimkyCUW1JVYBBCNepIko=@vger.kernel.org, AJvYcCW5B1Y8WX+yrbjimW2xMbdZ6rFUuygW73hmXnRXsxfKxiwUmFl9GRSQOvLjRyerefFsN778HRQz@vger.kernel.org
X-Gm-Message-State: AOJu0YzpFON37UgfuLXJU/OfRUrNbbJKV6vP0KOQvz74YmiAOJ1x+spS
	ciaWiQT9NBVSlfc/tcKSg5jSXb1lAwRv/JTPpLYx4JQhTByWB3BQ
X-Google-Smtp-Source: AGHT+IHHkz5Ebi30JV7ibbxjE4ZedXGtGwgY4Rri5mgNFizv+ZYBDL8OqlSEe8L+5FmGQ4DnRoTm1g==
X-Received: by 2002:a2e:751:0:b0:2fa:dce8:7387 with SMTP id 38308e7fff4ca-2fae107f75bmr16016341fa.32.1727876198578;
        Wed, 02 Oct 2024 06:36:38 -0700 (PDT)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c882493e54sm7664465a12.80.2024.10.02.06.36.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Oct 2024 06:36:37 -0700 (PDT)
Subject: Re: [PATCH net] sfc: Don't invoke xdp_do_flush() from netpoll.
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 netdev@vger.kernel.org, linux-net-drivers@amd.com, bpf@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Martin Habets <habetsm.xilinx@gmail.com>, Paolo Abeni <pabeni@redhat.com>,
 Thomas Gleixner <tglx@linutronix.de>, Yury Vostrikov <mon@unformed.ru>
References: <20241002125837.utOcRo6Y@linutronix.de>
From: Edward Cree <ecree.xilinx@gmail.com>
Message-ID: <48bb0155-cc1a-b72c-2d04-98d28adb467b@gmail.com>
Date: Wed, 2 Oct 2024 14:36:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241002125837.utOcRo6Y@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

On 02/10/2024 13:58, Sebastian Andrzej Siewior wrote:
> Yury reported a crash in the sfc driver originated from
> netpoll_send_udp(). The netconsole sends a message and then netpoll
> invokes the driver's NAPI function with a budget of zero. It is
> dedicated to allow driver to free TX resources, that it may have used
> while sending the packet.
> 
> In the netpoll case the driver invokes xdp_do_flush() unconditionally,
> leading to crash because bpf_net_context was never assigned.
> 
> Invoke xdp_do_flush() only if budget is not zero.
> 
> Fixes: 401cb7dae8130 ("net: Reference bpf_redirect_info via task_struct on PREEMPT_RT.")
> Reported-by: Yury Vostrikov <mon@unformed.ru>
> Closes: https://lore.kernel.org/5627f6d1-5491-4462-9d75-bc0612c26a22@app.fastmail.com
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Reviewed-by: Edward Cree <ecree.xilinx@gmail.com>

