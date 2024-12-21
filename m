Return-Path: <bpf+bounces-47520-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D9B559F9F0C
	for <lists+bpf@lfdr.de>; Sat, 21 Dec 2024 08:23:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A447A7A1AA5
	for <lists+bpf@lfdr.de>; Sat, 21 Dec 2024 07:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91A8C1EC4D8;
	Sat, 21 Dec 2024 07:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="ADpsc7o0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B057A17A586
	for <bpf@vger.kernel.org>; Sat, 21 Dec 2024 07:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734765833; cv=none; b=YG9v8JitQ5Pfaz3B2SjfmHrHyz8QvLtXA0WeYHTYnLD8hXdHEH8jXBOhYz/iCYRHcVQBMRauimKZFR/yQ28gByGRkeW5hqi3dHnC4U1moc1YV+VgvsPaVhLg5VU4hcsi1WnbGnZySCK3OPsgl8PaZaszVWNnjZuAwd7HRwtgsqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734765833; c=relaxed/simple;
	bh=4pCD4MfpKxajW7nzJCDcQ5nkTVU5Hd2o1XK73qQHDPg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AQPBENmHbTGzVomf99umnhbeNsc4XHG2sBg/h6uRr7jvCG6Nx66HySw2Le4mR+pwG//8K+yNq80uPeqluOMcNY/IW8Zvd+Tw0FeayIuhZlfh+WgccbI9/nyKv61gJtuv8fCzR2CQZkc2VkVmeg5xqY3aKbXclflM0iTqq5EILCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=ADpsc7o0; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-385e87b25f0so2401873f8f.0
        for <bpf@vger.kernel.org>; Fri, 20 Dec 2024 23:23:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1734765827; x=1735370627; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8tA5Lm2ADWMhYDHpJNcHk3o8dJm7AHd8LMxLsgBvmio=;
        b=ADpsc7o0MZ05a33hrf/rHeWvKYn4abCLXEJ3wGz/W0CfUg+EwG7uzzmgCaGoMRW78e
         6OqJd+UKGdD0qSFAHQjuIpMhBLwlfMRzrnk2KTtMZJIdp1EDPR+O9INq1ru169nF7mRF
         yUyxV5FqfprcLCl2VeVhX9Txipr+SyOeP7LrGwpuOK1HStEIZVdX+5B3ZEuJrxDyjIho
         yanH8o8Q/jnh24WxmZDNEGNduX7xDfPZKeHecCoxVirX/aiVufry3ADwAYiTs8BbwB+x
         mTLljzFZvqNIRfGNSlAvNhvGOs+OPJPdUV1DGxqi0nmlsiwepIAWBjygZrTBl+a9wHxE
         eigw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734765827; x=1735370627;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8tA5Lm2ADWMhYDHpJNcHk3o8dJm7AHd8LMxLsgBvmio=;
        b=gfDdQpyvwUcfaiD3y6Yv/wXZaQPrtQ8AGEk5/NBr8ltTHEopuW8+dWQgjDxoWMey1k
         /4gY9NbNVHz0nL8gLeMHyy2R9fHGMzZ3++VUUrBLzHPegn2zn7iwEhVoOARuEyAkhIBG
         a9mohIs6S5yZ/9NcAm4xLtytlNcXCEFErPZWK3JVm6ROfAyB4iutMOYKitk3QTqWO3kJ
         f70k1Ns793xLk0bri/5B1ykWF2EASJMfSWmtF+dg8tNx2VwEUkeVbD8r6kiD+cE1ZwXa
         qXp1ohLOS9oIeH1c1KSp6RAbY51LwK1yt4xhVc1D0Lej1skk6lciu/yevq9YZ+nKBBWO
         XWrg==
X-Forwarded-Encrypted: i=1; AJvYcCU1i9q9EyawBovIZcLr3fLUVlJKzMwJajqw8WUAXgBgp3pDePm7hED5FPH8FiumQNZn+VI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMgi+rb5cE9NTKuBeqnVbOmVhXyuxk6201H/iT1o9CNGuu9lp+
	b5gX2siwGsMVCtomktes0e08kmvIYbklkZczAdMbZp6h7cbsVxIsnMxoqd8p+ZQ=
X-Gm-Gg: ASbGnct5nmi1iAEMMr0+9umfuE8KMTatHjuMm7r05v2woHBmUYdfAcz15YZaM720DSn
	F8FE3rKYnSOfXkJLBm2JO8OaenBPgN46MfO+JlPBfG/i/6m6y0j7Us5iR9ibrXRTQcIpARsZJDh
	6mZygbFvPLHpj6LDpCSA7huSFylAzkG05JgF8FhHyEiceAp1wnBQ6uaRTUA4yHK9/plHxj0OTds
	TeuMpv2ho1ugzPJ2gtXWZ2Bik1WhrnKtETKLxu0EYTjLcdPvvGcZ8wCQJhssUq1NFgLAXQ7m0FL
	DPahw0supyYv
X-Google-Smtp-Source: AGHT+IGwEpVfD0DO6R3bJZCFDhU5tH6LMokRLm/P7JXiyVvKonbd3vPHM6ZM+yOiPldcklwJNKXkfw==
X-Received: by 2002:a05:6000:2a5:b0:386:3d27:b4f0 with SMTP id ffacd0b85a97d-38a1a221da1mr8859964f8f.14.1734765826998;
        Fri, 20 Dec 2024 23:23:46 -0800 (PST)
Received: from [192.168.0.123] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43656af6c4esm101635095e9.4.2024.12.20.23.23.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Dec 2024 23:23:46 -0800 (PST)
Message-ID: <fae78775-2c93-4fa2-8697-bc4516dc9e8b@blackwall.org>
Date: Sat, 21 Dec 2024 09:23:45 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 2/3] netkit: Add add netkit {head,tail}room to
 rt_link.yaml
To: Daniel Borkmann <daniel@iogearbox.net>, martin.lau@linux.dev
Cc: pabeni@redhat.com, kuba@kernel.org, bpf@vger.kernel.org,
 netdev@vger.kernel.org
References: <20241220234658.490686-1-daniel@iogearbox.net>
 <20241220234658.490686-2-daniel@iogearbox.net>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20241220234658.490686-2-daniel@iogearbox.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/21/24 01:46, Daniel Borkmann wrote:
> Add netkit {head,tail}room attribute support to the rt_link.yaml spec file.
> 
> Example:
> 
>   # ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/rt_link.yaml \
>    --do getlink --json '{"ifname": "nk0"}' --output-json | jq
>   [...]
>   "linkinfo": {
>     "kind": "netkit",
>     "data": {
>       "primary": 0,
>       "policy": "forward",
>       "mode": "l3",
>       "scrub": "default",
>       "headroom": 0,
>       "tailroom": 0,
>       "peer-policy": "forward",
>       "peer-scrub": "default"
>     }
>   },
>   [...]
> 
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Nikolay Aleksandrov <razor@blackwall.org>
> ---
>  Documentation/netlink/specs/rt_link.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/netlink/specs/rt_link.yaml b/Documentation/netlink/specs/rt_link.yaml
> index 9ffa13b77dcf..dbeae6b1c548 100644
> --- a/Documentation/netlink/specs/rt_link.yaml
> +++ b/Documentation/netlink/specs/rt_link.yaml
> @@ -2166,6 +2166,12 @@ attribute-sets:
>          name: peer-scrub
>          type: u32
>          enum: netkit-scrub
> +      -
> +        name: headroom
> +        type: u16
> +      -
> +        name: tailroom
> +        type: u16
>  
>  sub-messages:
>    -

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

