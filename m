Return-Path: <bpf+bounces-52041-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9A83A3CFBE
	for <lists+bpf@lfdr.de>; Thu, 20 Feb 2025 03:59:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9A7A3BB1A0
	for <lists+bpf@lfdr.de>; Thu, 20 Feb 2025 02:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 946681DE3CA;
	Thu, 20 Feb 2025 02:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nmte8ENK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7687F1D5AB9;
	Thu, 20 Feb 2025 02:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740020143; cv=none; b=lDgy3g3OBardId5EKbwwcNBE3JrYswl8EPD72LQOLTZ5egi55xccX+fCW54snmhIteVwnwQQjInnHxx3U5SgnbSR5Ga6eJ1MUNuQJwRMBqLhXlLeaKa7zIlKfbnfhRTmDQtz7hZZ9i2guMaHzOPO9UAfEfsxTFW0ptVquJSbsN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740020143; c=relaxed/simple;
	bh=psKC7RzdWZ1gGuQlodmLpK9wETeWrh8IUo6mPyo4wks=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=RzSq1uCe5Nxjd7cO/A7GYnSSvtcSQtQU9IR0upXiOsbAkQgLSoEH4doUfHCKzkeCRx83KntUm1Blg2ERI5j2b4QeTKYs9bV4szBX4EEenBx+tP4z9Nwawb0czBHbpMhhzHD9Rw/an9QZLd6Te6MxEesI19MsU0lX8Ga+r7vIknA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nmte8ENK; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6e67ce516efso3602336d6.3;
        Wed, 19 Feb 2025 18:55:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740020140; x=1740624940; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7qIsMgdm5+gnLcxv/iikI7veJjHDrTWCpxeKSywHH0Y=;
        b=nmte8ENKtiK9HfRemqVtKPnKff4ZNs7Uzw8h9mfmUQRa5tys3YdB9ivECaP/sU6VEp
         BEYnOmwC2oGzDrXYP0RdHX19coxuLqpj6t5XCoSC2sVLepQSFouD+b36EBwWrPsu/1ZN
         e7z3PHuuqi9tdx0a3Ztc/B2vUPwH5xv2pwUDeaTtJbLn3Hjy/eX/GEcXf4q1cS+pDAwd
         9s4aNN+ypcxSDvUhQ5GKtmS0+Qr3jsnBWdsBKipS+w2Td7Q882R5gW/401N9ZqDNLPSP
         HB/GXWqxSFrvr7+iS+Wwmcqs7IS3iER+tFu4DDZxRt6Ir5RhWylinXAxmOMG/rlM8Z7p
         lkJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740020140; x=1740624940;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7qIsMgdm5+gnLcxv/iikI7veJjHDrTWCpxeKSywHH0Y=;
        b=oHkc3EHOXozzkYTe5/irpAwy+oyYiF6JDP9G5eMLhxacsqMeEabRXHuM50V11vRsgB
         SaNkIVx3gKvAbvV2wBhyvQgcEXmEw6wWCooOFsl/+aaXqePbUh41d8jfXHfbKCs9Mrxh
         L9ZVfZr3DMNKEZYG7ha3k12lQmv3ssv+vzzXkilV08UoqpBEtvDcbxVmywTMXt7JLWep
         F92Cv/VSLo1E1qN6gx7QK+oXriR0m+vCRNzahRJm7ByV9fdmJMxF0AwSN6HsK7Up6x8q
         bXEMdUDyUD9BGkuANpQ95U276eK3cCkB3iYzaedlkglNBKOrcYVO0oUzTEfzGIrgxpfr
         HHIQ==
X-Forwarded-Encrypted: i=1; AJvYcCWbXF7N0TkuVy/VaGlfuEP0qwNhlr0npinz883RoVQh2ukOrEveZ9Mym3kOUJArqqiR16RxBbA=@vger.kernel.org
X-Gm-Message-State: AOJu0YydQmGs/61u3XWVw8NFl5jASOBoIpWEQiW1j3gBNKqxOp6oyQ1K
	emfAWXTXxc1SVAsuOt1j1XXxBIlusNwzXv8A3YVlXO89DGG0iXdy
X-Gm-Gg: ASbGncseLHQE4K7r2WpmcfnZqx1HI2s/vnW+IKwMHVp2f3CXDHTIpXxoNGM5fofhxuF
	dPKcTz677qfJS0qqN5xppthw9zETy76zPanICFoPQwlZ1yq5q7enzn/cNxIgvMT1N4jEx/NAxL1
	PhTNlzY79wmdtdQsDMPqc0KZmDaXa3wG0koTyr14YCAcA1CpEeB+OCevbGugmvuIW/1OE4/pn4u
	j1nsq397TLT+7XSdW0JZEe5AuooRnVB6PxguiP+EN8mRYukH73hoeSM+8lxMTpX0VuC/17hx456
	6xrM96xBfk0NWODWMqTjmgZw+cLeHJK6X3iDpVzu8ityYWy+wYBx24QA5hJx9UM=
X-Google-Smtp-Source: AGHT+IFbj2ea7ccjlIgrGHSJkWZQPWChpOqYf+roicqqsQg2IYZfAkXoMFbKGRBNUmQMvNQ6zDcSxw==
X-Received: by 2002:a05:6214:2a46:b0:6e6:69d9:2bc0 with SMTP id 6a1803df08f44-6e697571bf6mr95076576d6.37.1740020140168;
        Wed, 19 Feb 2025 18:55:40 -0800 (PST)
Received: from localhost (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e65d7a40bdsm81660206d6.59.2025.02.19.18.55.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 18:55:39 -0800 (PST)
Date: Wed, 19 Feb 2025 21:55:39 -0500
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
 jolsa@kernel.org, 
 shuah@kernel.org, 
 ykolal@fb.com
Cc: bpf@vger.kernel.org, 
 netdev@vger.kernel.org, 
 Jason Xing <kerneljasonxing@gmail.com>
Message-ID: <67b699ab81a9_20efb029441@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250218050125.73676-11-kerneljasonxing@gmail.com>
References: <20250218050125.73676-1-kerneljasonxing@gmail.com>
 <20250218050125.73676-11-kerneljasonxing@gmail.com>
Subject: Re: [PATCH bpf-next v12 10/12] bpf: add BPF_SOCK_OPS_TS_SND_CB
 callback
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
> This patch introduces a new callback in tcp_tx_timestamp() to correlate
> tcp_sendmsg timestamp with timestamps from other tx timestamping
> callbacks (e.g., SND/SW/ACK).
> 
> Without this patch, BPF program wouldn't know which timestamps belong
> to which flow because of no socket lock protection. This new callback
> is inserted in tcp_tx_timestamp() to address this issue because
> tcp_tx_timestamp() still owns the same socket lock with
> tcp_sendmsg_locked() in the meanwhile tcp_tx_timestamp() initializes
> the timestamping related fields for the skb, especially tskey. The
> tskey is the bridge to do the correlation.
> 
> For TCP, BPF program hooks the beginning of tcp_sendmsg_locked() and
> then stores the sendmsg timestamp at the bpf_sk_storage, correlating
> this timestamp with its tskey that are later used in other sending
> timestamping callbacks.
> 
> Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
> ---
>  include/uapi/linux/bpf.h       | 5 +++++
>  net/ipv4/tcp.c                 | 4 ++++
>  tools/include/uapi/linux/bpf.h | 5 +++++
>  3 files changed, 14 insertions(+)
> 
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 9355d617767f..86fca729fbd8 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -7052,6 +7052,11 @@ enum {
>  					 * when SK_BPF_CB_TX_TIMESTAMPING
>  					 * feature is on.
>  					 */
> +	BPF_SOCK_OPS_TS_SND_CB,		/* Called when every sendmsg syscall
> +					 * is triggered. It's used to correlate
> +					 * sendmsg timestamp with corresponding
> +					 * tskey.
> +					 */
>  };
>  
>  /* List of TCP states. There is a build check in net/ipv4/tcp.c to detect
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index 12b9c4f9c151..4b9739cd3bc5 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -492,6 +492,10 @@ static void tcp_tx_timestamp(struct sock *sk, struct sockcm_cookie *sockc)
>  		if (tsflags & SOF_TIMESTAMPING_TX_RECORD_MASK)
>  			shinfo->tskey = TCP_SKB_CB(skb)->seq + skb->len - 1;
>  	}
> +
> +	if (cgroup_bpf_enabled(CGROUP_SOCK_OPS) &&
> +	    SK_BPF_CB_FLAG_TEST(sk, SK_BPF_CB_TX_TIMESTAMPING) && skb)
> +		bpf_skops_tx_timestamping(sk, skb, BPF_SOCK_OPS_TS_SND_CB);
>  }
>  
>  static bool tcp_stream_is_readable(struct sock *sk, int target)
> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
> index d3e2988b3b4c..2739ee0154a0 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -7042,6 +7042,11 @@ enum {
>  					 * when SK_BPF_CB_TX_TIMESTAMPING
>  					 * feature is on.
>  					 */
> +	BPF_SOCK_OPS_TS_SND_CB,		/* Called when every sendmsg syscall
> +					 * is triggered. It's used to correlate
> +					 * sendmsg timestamp with corresponding
> +					 * tskey.
> +					 */

Feel free to decline this late in the review process, but a bit more
bikeshedding..

Can we spell out TSTAMP instead of TS in these definitions? Within
the context of this series it is self-explanatory, but when reading
kernel code the meaning of a two letter acronym is not that clear.

And instead of SND can we use SENDMSG or something like that?
SND here confused me as the software timestamp is SCM_TSTAMP_SND.

For instance:

    BPF_SOCK_OPS_TSTAMP_SENDMSG_CB,
    BPF_SOCK_OPS_TSTAMP_SCHED_CB,
    BPF_SOCK_OPS_TSTAMP_SND_SW_CB,
    BPF_SOCK_OPS_TSTAMP_SND_HW_CB,
   (BPF_SOCK_OPS_TSTAMP_TX_COMPLETION_CB,)
    BPF_SOCK_OPS_TSTAMP_ACK_CB,

(not sure what the OPT in OPT_CB added).



