Return-Path: <bpf+bounces-79463-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D7E33D3AC36
	for <lists+bpf@lfdr.de>; Mon, 19 Jan 2026 15:37:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9B96830614CE
	for <lists+bpf@lfdr.de>; Mon, 19 Jan 2026 14:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C98B37418B;
	Mon, 19 Jan 2026 14:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="Q/ay/aYw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 210C13803C4
	for <bpf@vger.kernel.org>; Mon, 19 Jan 2026 14:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768832626; cv=none; b=YIReeKYoVwx8vUP6BEIkFDVwuzSusCKhovxkjh7lJLqrlTonKc+HrkEbZKFd+3FHMfbrOlqsdzqhV5RkJzlpX7F2gSDYcxQTq+SQU2WX20loCm39ck9POTUpXB9ZnU/xRtZxuJtbfynJh3w/BGh3lrcCoOTsGpkvaAjiHgJxMzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768832626; c=relaxed/simple;
	bh=zZ0PjRaGNoNIjizP/YoFSsRkMVKdRT7t0wNKljIe4Cw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Iiall1oP1XZwMunE65tV0MNj3syUjSaOKcg33XHR+ASYKK+Y94EtZ7ubk/TFgE1K2JvRKcFEnCLMIAza/20oPzJyWO3ihpjXekZEfS0t4wVQijSYt4rh7KwEvrvxO446odYk69pubXJVNeob3x6i+HYsR9onqALlRYWmPsacT4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=Q/ay/aYw; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-42fbc3056afso2665892f8f.2
        for <bpf@vger.kernel.org>; Mon, 19 Jan 2026 06:23:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1768832623; x=1769437423; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+sagjUhqCfmZJ0S1szqVmFs4xTlkzA3mfjQRcJnDcOk=;
        b=Q/ay/aYwXEEO/pVzzi0ZjwVOQnx7hQGWGQHzFtxKxpRWEUWnlszIbmXrh9FeQx4M8F
         f60ISipy1CDwjDtOtv9bKWEu1Kosuy9eukjCFe8TfPePb0m6B74HcXGLY4X91KLvCwne
         92laJ4KQwy6vKy8cmYrO1mxuumznFUIp90K0AEfxN4O34W0eOBrEHThqQt1kD0sSRYY7
         l/+oDPzh5LaYNtpKvM53V8UdeyXErHhr9IBsBoOhBDiigkvrkYCpsVYz1NeTPO8T3cf/
         LJhPufEuw4E1h5QOZtWVqxn0HjITfSL4aifExqChcacPNRM1XE+brpMRpCgmWYB8dHag
         kuHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768832623; x=1769437423;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+sagjUhqCfmZJ0S1szqVmFs4xTlkzA3mfjQRcJnDcOk=;
        b=mhqCMp3jFLx/WwGBBpJd+p9ZvRpnobPMs1r0IkBdXOWYGCxB/i7gA0Go2RwoDStLo7
         8aagfTDh7Ql5OjUAKGqtF5F0p7d8O/8ucfgCtg6SzZHm5VVXIuIrHpB7N9kGfuATNIIu
         4yCJd6KugMTHc+nK1F3KPu86GDV0sN0HEH0/ZU7UbZnWY3wkW4F2veiWdi9JGQ0mMmdD
         o4cJCu38D5/4IS3HkRfLiuLnerdAdzQjnjbgiXHlHNY5m4j1G937MnRtccSbFvPhazJU
         cIUkIuUvqjPBfrYOOUKSBZnr/13ZTt/khOpcOFJJD1DNZS6DsXxhz64TDgxsYc7BiGfn
         gj7w==
X-Gm-Message-State: AOJu0Yw23pcMr+G7FvSXKRa19CJW7LpYM71xwNuVWXAuu+xC7S2FgDsk
	x2Umqd0yFtaC+IolLGe5hMwXTMjHETpnrPDbGibi75adzqqa5/XH1epSv+0HewajANk=
X-Gm-Gg: AZuq6aIzAw4UqGw9BZ+uuv+YVF57OuvJGeWl/hatbevxb75rIQTylUnQydI7G8SmW/k
	DlGGjKEDu6XPBEctnrlXQGc004+ubxMN/WBmJ8bUlzcn7qiPRtd3MTWwRtuy/qcyXVlGi2bDfzJ
	ZVjhfp7DB9Zaad0VVxIuHDEs3IK7Ic1cMYieke2AWg3aYwLd3HCfkXMgm+AvU5/xbK2S0crVQaW
	cAT0y8FpfSAN5daSPEm/QMxgfQ+Un8Ui4zBjH5vXC9s3Fh0grCgf2dovMYUFM6jKXAoMBStg4P+
	UPb0uPM16qc0+j0PaEg9nxwcashGlHkImD2UpX4NI8Ml+YOGZIMp2FwY5S5WlcT+kK/xLler/Kt
	0zDvQz3Dbv11qPMEJ9MtSGoneNN7vz37h1Owxy43ZA+VBq20g+9i6YlkT5dKWtTGy0Z9DJm/qP/
	3mNczJQfMqfsCTpnmt+aA/diIrLG1xTGH3PdSaJXKSVFA3WojKRX8AhZ7lxTDYyoPoJIB57A==
X-Received: by 2002:a05:6000:288a:b0:431:84:357 with SMTP id ffacd0b85a97d-4356a0542f3mr15752591f8f.29.1768832623347;
        Mon, 19 Jan 2026 06:23:43 -0800 (PST)
Received: from [192.168.0.161] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4356999824csm23310089f8f.39.2026.01.19.06.23.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jan 2026 06:23:42 -0800 (PST)
Message-ID: <38c26cdb-3374-4d37-87a6-1647387e9f70@blackwall.org>
Date: Mon, 19 Jan 2026 16:23:41 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 15/16] selftests/net: Make NetDrvContEnv
 support queue leasing
To: Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org
Cc: bpf@vger.kernel.org, kuba@kernel.org, davem@davemloft.net,
 pabeni@redhat.com, willemb@google.com, sdf@fomichev.me,
 john.fastabend@gmail.com, martin.lau@kernel.org, jordan@jrife.io,
 maciej.fijalkowski@intel.com, magnus.karlsson@intel.com, dw@davidwei.uk,
 toke@redhat.com, yangzhenze@bytedance.com, wangdongdong.6@bytedance.com
References: <20260115082603.219152-1-daniel@iogearbox.net>
 <20260115082603.219152-16-daniel@iogearbox.net>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260115082603.219152-16-daniel@iogearbox.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15/01/2026 10:26, Daniel Borkmann wrote:
> From: David Wei <dw@davidwei.uk>
> 
> Add a new parameter `lease` to NetDrvContEnv that sets up queue leasing
> in the env.
> 
> The NETIF also has some ethtool parameters changed to support memory
> provider tests. This is needed in NetDrvContEnv rather than individual
> test cases since the cleanup to restore NETIF can't be done, until the
> netns in the env is gone.
> 
> Signed-off-by: David Wei <dw@davidwei.uk>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> ---
>   .../selftests/drivers/net/lib/py/env.py       | 47 ++++++++++++++++++-
>   1 file changed, 46 insertions(+), 1 deletion(-)
> 

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>


