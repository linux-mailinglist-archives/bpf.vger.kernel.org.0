Return-Path: <bpf+bounces-41288-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FFBA995744
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 20:56:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F13F7287BDD
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 18:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3DFF2139CB;
	Tue,  8 Oct 2024 18:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S3UHBopq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306A5212F1D;
	Tue,  8 Oct 2024 18:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728413768; cv=none; b=FDWXFFSLbz61ODp0tz5CiKfCj9nFo69lEKpxVN+o9QH8VmwoUA425MVvQpzMwoCM2IQVXBnzPu0kBjYPUVZq6plthe+B8kREDe6ad8/g/ePaPhcbnnid3K+/LTSs5hNRr3LnOosaksKzEqiUNFDnc/YHKgHe/p3wm92ROL+QpCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728413768; c=relaxed/simple;
	bh=ROSRtze3TXDKBgI9xmG3Z/wscGO8lTvk0dVjBoQ5hic=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=DG7oGU8KTZuh9GQ378RgJrQX2qE/8Thul2CntrQIOmN/8gleO3S1dY96CyYEEFhmZH1ooCymGuCG/eE+DypdLYtNI+FSgCmjLIB6J5zJHBptSPaOkfC8an96aLkMAfYRzXL3F8I7sLX/EkmxLT4fT+a5/Jjs1zOiym2704581N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S3UHBopq; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7a99e8d5df1so594866485a.2;
        Tue, 08 Oct 2024 11:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728413764; x=1729018564; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rhhl+QUphLvAYB/QCQv8/niCGqVeDz6VBnwdB331RAs=;
        b=S3UHBopq7R9PL8IHMA3a0WQ7vs4QXDBQlW05GaPvlg0NETIL80aJfIxVDTu8AOt2tM
         jjCvLu3LcSpuVcmSAaKAU9ZUh+JkAsJMjHb50cgbHWE5wz/k8rMO+ER/vgfv8MCvtJkt
         v1yU5yFPiWFzzZ2r6aYY2RymagftcAqvSdCdPY8jlsB/UEv8phHUp2HfYz58BjbIEe9K
         o/22BQ33ppDn9nXmigSsFMder3hJl+acGXvEUaF8pEbd/0GiGEZn+GyRd3mzWCjrn4i3
         2icFQbSZ4LvVT0ekPlVQSxAv/7k1r9a/f+RKrWqBnyG3d0BHh7SD+8NXbGLUvzvSi5Zj
         nm5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728413764; x=1729018564;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Rhhl+QUphLvAYB/QCQv8/niCGqVeDz6VBnwdB331RAs=;
        b=VbldErVybsdNcN4RnhTBU3TtxHOJCFeMD6QJoEyIcCiRIPq+16hIjv/BTsPuVrn+fS
         gvGk6trgY8IyLPhX2emobqIAuNHBC7axAxo+G8pzFgsn99gXzKZihrGVZAoR9zfh0E2W
         tnVYVvmP0nT9h82DZs6gHP8c8QgrXqD+FjxlxZbI+vSRnNSwlr2zfN8dRvGYJpTaTtxd
         arjiR/R0xUtojkv3ABIir5Gkx5NSSYfcJrgXgv2HcZjUL0ElQSLnUK8xS1ynfqDffKkE
         VeLVvzuAAm5PcUz0g36hjycSumqHHg3aidD5d4IptnTEsRGThcheWNMIp3dy/t62kQr5
         7tHg==
X-Forwarded-Encrypted: i=1; AJvYcCXbRp4jxuGTkf7MO5oxusLaWNhDSINiCXPVYa5m8xdQyaShqvE+QPoSEsSEYym7Xu9IrbsjBVM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwRBP+WRq2fdmGVA31XTqBqeaR+3DX21AwmMMJadVQWtUTrwdy
	9bbKPVmMB31vAILdAZBjCJv1Pi7OAiU86c7G2FKp3XoYE4syLXkv
X-Google-Smtp-Source: AGHT+IHoC5zs8MEMstPXBUo61SDfwy34w1jbD8Mm3MQDnMnx3rmlHVGCCCl2o2/3bvxd2h/z2/Y0LQ==
X-Received: by 2002:a05:620a:40cd:b0:79f:879:63ad with SMTP id af79cd13be357-7ae6f4868cemr2913975585a.46.1728413764000;
        Tue, 08 Oct 2024 11:56:04 -0700 (PDT)
Received: from localhost (86.235.150.34.bc.googleusercontent.com. [34.150.235.86])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ae75761d59sm377581185a.102.2024.10.08.11.56.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 11:56:03 -0700 (PDT)
Date: Tue, 08 Oct 2024 14:56:03 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 dsahern@kernel.org, 
 willemdebruijn.kernel@gmail.com, 
 willemb@google.com, 
 ast@kernel.org, 
 daniel@iogearbox.net, 
 andrii@kernel.org, 
 martin.lau@linux.dev, 
 eddyz87@gmail.com, 
 song@kernel.org, 
 yonghong.song@linux.dev, 
 john.fastabend@gmail.com, 
 kpsingh@kernel.org, 
 sdf@fomichev.me, 
 haoluo@google.com, 
 jolsa@kernel.org
Cc: bpf@vger.kernel.org, 
 netdev@vger.kernel.org, 
 Jason Xing <kernelxing@tencent.com>
Message-ID: <6705804318fa1_1a41992941a@willemb.c.googlers.com.notmuch>
In-Reply-To: <20241008095109.99918-7-kerneljasonxing@gmail.com>
References: <20241008095109.99918-1-kerneljasonxing@gmail.com>
 <20241008095109.99918-7-kerneljasonxing@gmail.com>
Subject: Re: [PATCH net-next 6/9] net-timestamp: add tx OPT_ID_TCP support for
 bpf case
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jason Xing wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> We can set OPT_ID|OPT_ID_TCP before we initialize the last skb
> from each sendmsg. We only set the socket once like how we use
> setsockopt() with OPT_ID|OPT_ID_TCP flags.
> 
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> ---
>  net/core/skbuff.c | 16 +++++++++++++---
>  net/ipv4/tcp.c    | 19 +++++++++++++++----
>  2 files changed, 28 insertions(+), 7 deletions(-)
> 

> @@ -491,10 +491,21 @@ static u32 bpf_tcp_tx_timestamp(struct sock *sk)
>  	if (!(flags & SOF_TIMESTAMPING_TX_RECORD_MASK))
>  		return 0;
>  
> +	/* We require users to set both OPT_ID and OPT_ID_TCP flags
> +	 * together here, or else the key might be inaccurate.
> +	 */
> +	if (flags & SOF_TIMESTAMPING_OPT_ID &&
> +	    flags & SOF_TIMESTAMPING_OPT_ID_TCP &&
> +	    !(sk->sk_tsflags & (SOF_TIMESTAMPING_OPT_ID | SOF_TIMESTAMPING_OPT_ID_TCP))) {
> +		atomic_set(&sk->sk_tskey, (tcp_sk(sk)->write_seq - copied));
> +		sk->sk_tsflags |= (SOF_TIMESTAMPING_OPT_ID | SOF_TIMESTAMPING_OPT_ID_TCP);

So user and BPF admin conflict on both sk_tsflags and sktskey?

I think BPF resetting this key, or incrementing it, may break user
expectations.

