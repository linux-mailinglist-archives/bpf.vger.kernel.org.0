Return-Path: <bpf+bounces-47424-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CC6B9F9594
	for <lists+bpf@lfdr.de>; Fri, 20 Dec 2024 16:40:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23FDD18850BE
	for <lists+bpf@lfdr.de>; Fri, 20 Dec 2024 15:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A720218E92;
	Fri, 20 Dec 2024 15:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kCkOMPYW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF912C190
	for <bpf@vger.kernel.org>; Fri, 20 Dec 2024 15:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734709234; cv=none; b=qSGCpSuujoeKUdO4n+gCSbM6QkIdmRkIFyQWbrpXiPlO8NM26RbP4jh7H14WeFlvuJmb1g8BmPF3SW2N/D+v5/BcoySENMlXiKzk0jVCoJ7gCWx/Jxu3lN8mH3ggC0xz4tWWUSGE2ATnTlsnOMFFUA9O1Zfx1jJNCUTlcoHsQQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734709234; c=relaxed/simple;
	bh=WtGzLqUjvp8B42aUHyz4RCbilJU5NZs8BbamqIDhkik=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e2DrG/r4wY1ckOJlX0lNu5HW+PAiQPhgfFweXXMRlfXprcHwH2KEcw4Jvg1mECcOfdmP65YcjrDDWiZyrO+66UTscuOyo4voeHiKliVKTYuIoLHVDNv01Rs4+KNnDuUqOnm3oeN5RRiU/OdasTCwjWDAGbTmUQRqlunueWUhNaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kCkOMPYW; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-385de9f789cso1600520f8f.2
        for <bpf@vger.kernel.org>; Fri, 20 Dec 2024 07:40:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734709230; x=1735314030; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kSdk6QAbKOm0Xa9HQTWUW7BMlVciGPLdiVkvnokPyNI=;
        b=kCkOMPYW9Sbi2WcDWPX7VhRiF64CEI9u+IGtG8f1OX5dKgnlPmKHmhaI5H5RjVY/tB
         d1jTpXh1iPcQ8xuzA+GfZYfTyrRW+xmU4A+1FnPJC8BTVOKOLv86fj6b0XgqGNQYftM9
         NonGWIzvbGuQ49/dPiXweKSegFH/hUUBfIo0ceE7EHj2yqSMRzfG0ltrFpcC0qhuWiWu
         s7o02dgF1x1Z67urzfyraw4O7/tLj4JHIq/tqgC0nImLgkr3HsK6G/pJ44zzXCMUJlv/
         E3FdM4kEzjyyfZt3Ft+/jcz173IwF1+fGjKk3dRh+pkwD18jcQIsxi3xlUcZu6CllUHX
         gKgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734709230; x=1735314030;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kSdk6QAbKOm0Xa9HQTWUW7BMlVciGPLdiVkvnokPyNI=;
        b=KmuA9uR0ZrsrdJTulQJ9bypndUklMebxW22weUi5ClQRlkSNx7SfBqTNl3vrR1dj1f
         /FLFlrry19gkeikqn+khctZFmFC1oFvirDKHOuHApeJ7Q2WAIlXrWUcw594gIKm0zh6N
         kt+MlwISKTCPBQC+cvbO5mgOT+oMLr9AGojUjPXfRcz+O6RfqBl4e7+JWUaQ4oQGXqvf
         h1wjZI9K1mwsvzkmFtnEub/Y9oorrEtc8i/uQWMBB8k6udxPxqK5E+f5IWako3Uk7D64
         sRukYJIUJXI814d0Jik/+Va1qHN/2/Vpt9S8tQ6y4zL1F3EqbzIX9WYoGrSP2Bah0s92
         Aqpg==
X-Forwarded-Encrypted: i=1; AJvYcCUlNhvFd0Mpt3UMTVsk5VE+fJMhsvIyPfJDikHRyVoEPOvBYobNxbNcZIAAhYxhLXR5NTQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEt8CFTk68WMjt5Z22bdk+gQPOvWuHA+0qj2cVY6f3jNMScZzd
	PgBAM/TcEUl0ZKhdqhaDgkhJs7NN9t5TUha4kXrXzB3kpdyF6Yc9
X-Gm-Gg: ASbGnctG4UuuoCOn8wVLyUeEU0pjleFgrpAd0LqleBj/4S/mPjie6kFyf9NOL9nmnuT
	S6J1mST8qy6MG+xOYQWmVOikoQHP/4zY9wpP0OKgUCPoeRSAU1XMEopnLa4DL8nRqLXn4dyb6dq
	IcbPb88BKXcIZ2EE6XVrD1E8Fda5Z0/7uo/7KTyIjvmGemdmQjnYtC6tSbC46l5DLBWAJHJaydo
	ijTjnqTSCwDP+Qo999QNFWcYLLYdnVaa9PLFf1YxoJtwEZMF7eFZGjx8PQq5VGdOdSdbXAtCwBX
	BQYWEa28sRrZQXn8qkX80xSonRMO4CG7QqRFDG62iOss8S9gVv6U
X-Google-Smtp-Source: AGHT+IEXWJp7BVvhW6rlmyI83SxyEl4Becr2oG9zzxt1hUTJnaCxGrZpV2M79F84PhohPQ54S58Q8A==
X-Received: by 2002:a5d:5e09:0:b0:385:fb8d:8658 with SMTP id ffacd0b85a97d-38a223ffbf0mr3816789f8f.40.1734709230334;
        Fri, 20 Dec 2024 07:40:30 -0800 (PST)
Received: from [192.168.0.18] (cpc158789-hari22-2-0-cust468.20-2.cable.virginm.net. [86.26.115.213])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436611fc762sm48853965e9.11.2024.12.20.07.40.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Dec 2024 07:40:29 -0800 (PST)
Message-ID: <3187e279-71c6-42df-9344-23275c81d79e@gmail.com>
Date: Fri, 20 Dec 2024 15:40:28 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next] selftests/bpf: fix veristat comp mode with new
 stats
To: Mahe Tardy <mahe.tardy@gmail.com>, bpf@vger.kernel.org
Cc: andrii@kernel.org, yatsenko@meta.com, daniel@iogearbox.net,
 john.fastabend@gmail.com
References: <20241220152218.28405-1-mahe.tardy@gmail.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <20241220152218.28405-1-mahe.tardy@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20/12/2024 15:22, Mahe Tardy wrote:
> Commit 82c1f13de315 ("selftests/bpf: Add more stats into veristat")
> introduced new stats, added by default in the CSV output, that were not
> added to parse_stat_value, used in parse_stats_csv which is used in
> comparison mode. Thus it broke comparison mode altogether making it fail
> with "Unrecognized stat #7" and EINVAL.
>
> One quirk is that PROG_TYPE and ATTACH_TYPE have been transformed to
> strings using libbpf_bpf_prog_type_str and libbpf_bpf_attach_type_str
> respectively. Since we might not want to compare those string values, we
> just skip the parsing in this patch. We might want to translate it back
> to the enum value or compare the string value directly.
>
> Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>
> ---
>   tools/testing/selftests/bpf/veristat.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/bpf/veristat.c b/tools/testing/selftests/bpf/veristat.c
> index 9d17b4dfc170..476bf95cf684 100644
> --- a/tools/testing/selftests/bpf/veristat.c
> +++ b/tools/testing/selftests/bpf/veristat.c
> @@ -1672,7 +1672,10 @@ static int parse_stat_value(const char *str, enum stat_id id, struct verif_stats
>   	case TOTAL_STATES:
>   	case PEAK_STATES:
>   	case MAX_STATES_PER_INSN:
> -	case MARK_READ_MAX_LEN: {
> +	case MARK_READ_MAX_LEN:
> +	case SIZE:
> +	case JITED_SIZE:
> +	case STACK: {
>   		long val;
>   		int err, n;
>
> @@ -1685,6 +1688,9 @@ static int parse_stat_value(const char *str, enum stat_id id, struct verif_stats
>   		st->stats[id] = val;
>   		break;
>   	}
> +	case PROG_TYPE:
> +	case ATTACH_TYPE:
> +		break;
>   	default:
>   		fprintf(stderr, "Unrecognized stat #%d\n", id);
>   		return -EINVAL;
> --
> 2.34.1
>
Looks good, thanks!

Tested-by: Mykyta Yatsenko<yatsenko@meta.com>


