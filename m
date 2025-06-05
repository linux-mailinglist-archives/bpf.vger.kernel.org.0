Return-Path: <bpf+bounces-59717-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B46DEACEDE5
	for <lists+bpf@lfdr.de>; Thu,  5 Jun 2025 12:40:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E3EF16D8A6
	for <lists+bpf@lfdr.de>; Thu,  5 Jun 2025 10:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D88A217664;
	Thu,  5 Jun 2025 10:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SmRj8LmP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29191204098;
	Thu,  5 Jun 2025 10:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749120025; cv=none; b=dxkKvsQqvC68yImAPZc+BvXlBdOidSbjhRuqQkEdGQ5wHdHyN73QOjQ/5jG7nA9dQ8zPF0Fbtr9f/D50YUtL3xkftqWgqGtlEG1tFGazqzzx+KtU/OcGEfuaElUBfDJEsRxZWG/RnK63xMGHWPwXlFkVMH9NFdlqOsg6ORWuDM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749120025; c=relaxed/simple;
	bh=A5o0ZFJMWl05flgP4hD43aqyN/kGHwVvulBnI8ijTXM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ni9dlV6liwzkdji7ILrcjTyRUmn0uWSXwrvmKWcXZkkCjV6vs4mxh+qnN/VgbIRkRBzBR+MUrqhJ9bTyuGuiuUOBHbMn7u5v0xwym0VI6hpOQCpBjP7f7dbUcO2qH3Ha4DEOXBPDHHdDehPz9bkoepTdeKS5mRU4pCcvCZ3A0/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SmRj8LmP; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-601f278369bso1616123a12.1;
        Thu, 05 Jun 2025 03:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749120022; x=1749724822; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PCzlyb0Ej8H9RGAKNTUdwAiSraKf8xsjIn8xtjEu6Y4=;
        b=SmRj8LmP6ouO2e1nES1/bGfJkpVL7QNFzx4meCw36qJW+dHWf5WIR04BV1qwyxZaXT
         WoKDBelLVCzQpYEEQ7DEb3GUM3y79GAXGhIlL/WV7kfIj+8a9SSznF2RiqBQMQd/EPB6
         ou4EOrBe6OOx+Z6CeDx6VSs27pPGv2MSD9tEhcnRLkqvsYYLZJ79pgQY7AGt2EAmidIZ
         lRYyHIqDNAWtg2Oum2RMEyFXtOSQkMMi39pmXexNVMeP69rLQ0CylgLBNKBwtVlEFyMm
         m/dNqgE5AWp8PknizhqdlGy4c6ZL8ImDztrfEaDwHJgedQGa85l2EsGpaFXN7KpYojPz
         /r/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749120022; x=1749724822;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PCzlyb0Ej8H9RGAKNTUdwAiSraKf8xsjIn8xtjEu6Y4=;
        b=S8nbUUlDA1syts3Qn/y1Ijm7mhTH2i0MzwNp/842oFpvaOwevD7IvZFQJxGWMqIVRL
         obLP0Bi2nKL9l3IOJjKoQjFjN9m4+g4LMrz/lCKvhxVrFKXiItaeveltn/iVFgh1Fpaq
         FlxW8xZ28C2Fak4aJRKZ44rS/6UUyMOMollKbcrS3yixqrj8fFrRQWL3N2V4k2FJJ2+m
         E7kd5J7RC9d9b9zGe10UDHWR3bFbCG3GsyCoZkpBwiLzymqt93NEXylKUhFVLwO4F2mc
         jGyQuJ00Vb0jk6kfuM7Q4ibLlpzePyW9fC1+PE2iNRw6KWTZhtL+sw5eZVZJ5o6I109u
         JnfA==
X-Forwarded-Encrypted: i=1; AJvYcCUOoC4hu47JfEE8UDHNWyo8XrdOuPYoWwhoKEvcnHe/1yPki/jZyDpKrkeyPX2JJbRvg/HygvkVvWljlw==@vger.kernel.org, AJvYcCUiwTlTT1+YDflXQEKuI9TItP8Dx9jilWYJSECuIBheWb97Ph1L+RAH0vGbu3adiHipwiw=@vger.kernel.org, AJvYcCXQtItrtSP9gCtUkz30sEPCDWeXGQ7ByW1MrMAWADYhDzLxOyS/vDiekn1JI5VGDCDO/FNPwmgJ@vger.kernel.org
X-Gm-Message-State: AOJu0YyASNY+ELAk2lqEF6DAdxkm4VP5fJJkXTAfOkDd2BV21qjG/qQz
	INjFdRTYFp5rUVmIZEp5pKauqFHoCVt29q+EAhsQW8tWAaNZVnpN083D
X-Gm-Gg: ASbGncv+p65qWlPbttJf3hrEkDEo5a4QcJ1waw8c6wf6lPIXHEBBzQTlPgt+miW6jOp
	up7RfsYQ8brDZZTTNWN9WnxYv4xuYtG7ZlGgLh23PsGyEoTQWSzgxBk0d3xOtEqZyX5H+ki45Rz
	q06v0pXCQa4hHlfTzWhJwIX/p2FrvQDsSLL6f86Sa92mc5D82B2XhDndiKzBAhMDy+MK516Eq3Z
	chYLzARWB2jF09725/R7V/s1Vz9/u4kTC791tyZEoeMakYs6zgFSi6CA+F8GSlsg78WBAd0tEBi
	QzTpm9HxWb5nGuW5bu9A2NG+MNYnyGPdPNG8iq1Yn4D/qK6XFTHN3tMWI4CLAt/e
X-Google-Smtp-Source: AGHT+IEAAYGsPWJ5Mxfg0pCXdHfI6JfyEf1pnvTgP3ozAQ449qaU+qG0sxCkzl3Xh5PtxaMw32ugVQ==
X-Received: by 2002:a17:907:728d:b0:ad8:a115:d554 with SMTP id a640c23a62f3a-addf8fb2e01mr563944866b.56.1749120022162;
        Thu, 05 Jun 2025 03:40:22 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:325::22f? ([2620:10d:c092:600::1:d66f])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ada6ad6a76csm1227477666b.165.2025.06.05.03.40.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Jun 2025 03:40:21 -0700 (PDT)
Message-ID: <cf26c48b-45a5-4942-b035-ca5b4194dde1@gmail.com>
Date: Thu, 5 Jun 2025 11:41:40 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v4 13/18] netmem: remove __netmem_get_pp()
To: Byungchul Park <byungchul@sk.com>, willy@infradead.org,
 netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 kernel_team@skhynix.com, kuba@kernel.org, almasrymina@google.com,
 ilias.apalodimas@linaro.org, harry.yoo@oracle.com, hawk@kernel.org,
 akpm@linux-foundation.org, davem@davemloft.net, john.fastabend@gmail.com,
 andrew+netdev@lunn.ch, toke@redhat.com, tariqt@nvidia.com,
 edumazet@google.com, pabeni@redhat.com, saeedm@nvidia.com, leon@kernel.org,
 ast@kernel.org, daniel@iogearbox.net, david@redhat.com,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
 rppt@kernel.org, surenb@google.com, mhocko@suse.com, horms@kernel.org,
 linux-rdma@vger.kernel.org, bpf@vger.kernel.org, vishal.moola@gmail.com
References: <20250604025246.61616-1-byungchul@sk.com>
 <20250604025246.61616-14-byungchul@sk.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20250604025246.61616-14-byungchul@sk.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/4/25 03:52, Byungchul Park wrote:
> There are no users of __netmem_get_pp().  Remove it.
> 
> Signed-off-by: Byungchul Park <byungchul@sk.com>
> Reviewed-by: Mina Almasry <almasrymina@google.com>

Reviewed-by: Pavel Begunkov <asml.silence@gmail.com>

-- 
Pavel Begunkov


