Return-Path: <bpf+bounces-59217-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 618F6AC7492
	for <lists+bpf@lfdr.de>; Thu, 29 May 2025 01:47:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DBD316ACA0
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 23:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E4BE2356D3;
	Wed, 28 May 2025 23:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E+2jftug"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F1E1FBCAD;
	Wed, 28 May 2025 23:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748476025; cv=none; b=aYAqwOIdL+SoI5iQ4JStvq/2IgJTUJ25u1z1MKHJdOHpE26TqcIaPJF9NdgVukisciHS/tIRVCM2VjfPwtNA6pF2rzyy3hCJ+U3Me3M88p7pS2IIu1xIrLc1tg1ev4i9VbbT2xyiKDZrKurNUfj+bf/fel+oKEabHVjRTqDyHAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748476025; c=relaxed/simple;
	bh=HXvJVjfC3VHKIy7BoJyYz+B80KYy5YwcIHOBuvSf298=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d+30ygTIkn1X9sG8Oh7WfcBjoDSeH2Z4vO5nE3c7GXCrvGTgwbHf04bN/UnUb7bImWhx+MfBFK+Df34BToHFBZgPpcsVlghEm5yTQNyLqv2k5nKXaESS4L/zu+umVoKNpDDGhT01+Cqrswo40XgwbD+3j9qWHPMRGVdVH8DzUl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E+2jftug; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-234b9dfb842so3702535ad.1;
        Wed, 28 May 2025 16:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748476023; x=1749080823; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ahVgHGY0syVgqDW38oPCFVl25F/0o5MeCR1HJluHpBg=;
        b=E+2jftugAmd/kOxFHpCsO8PUWyGgpjCsuul2ItZ2jFyB5kxlRH94PIcDWC7yF9rngj
         g48WEtt6Hyl1cxSskRy6OZYPw2mSDhfInYwTgDd+4PeIsUVXgJvuhgw/gNrUCOpbtkg2
         5c8kbXD7j/Qaq0JrdHuvQLCCho25RDGoU4LNnaRz2Q3f9gQ/UxE5nkVKohE45gH5nVLA
         pzkwmy5Qip1D9vR8UZHNzwd7nH6FhttP8QLnL3lugHcTriARKD/mnavDZnwBzssfTW7N
         zHuZjLa+us9WFOI6LmoDCOzTD5taBTWHxLRV31W1/GKf68a88FlDRLAB0e63Kk3v0X+p
         UWqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748476023; x=1749080823;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ahVgHGY0syVgqDW38oPCFVl25F/0o5MeCR1HJluHpBg=;
        b=wMmJd7z+rvzNk51nGGYlQ8h9EGyum6NMe2K37mr8XgB/9O+6H/vV4Mc2p1YoSCucNq
         PzwTX8RFjb0FHPPEVfVfcpvayC11pOesedZLggkHBgzGN+rEkXFBQqR04HJkv44ZF9an
         VJqwgYB+t43FMH8s8W/l2/3ZLpfNC7cC+SG0NS+VPrcNkOdH7CaCaiFpsY1sGGffBWh7
         iyQVLEUc7RxwQTkuNDAaAoBBbySjQHvg5odQbMMeBByqV/eNjol00pDAPZKTDn5JRkqz
         V8PZfHWz5tejvuYmQT8N57C+eGL9620rqmPjUDvBme6QWynoBwKILJGGHVrKUkQ8s/MU
         vUag==
X-Forwarded-Encrypted: i=1; AJvYcCUzyLymslQaqrd27Z22caQHRjIoML2mfbU1+N93+2Q6A/JtJkVLfQYAIO2tca7IixDqOnnK/Q3ItVn+HUM=@vger.kernel.org, AJvYcCXYHFgvNg8nk0vErzpCA71VonN8X51hzLMvqhYCSLN9NRFadnEaSRwW5wHXkaoZMCQCUp06Iq1h@vger.kernel.org
X-Gm-Message-State: AOJu0Yzmkxd7OnenqNpPrQSByHG8f/ko6TZyziJTviTt0TiujbNTJyn9
	M+0jGhc/31Y5wkbCEyPSt5GkyejvWbmiWg+2pgDSunBi2GD+K2rBb0q+
X-Gm-Gg: ASbGncsuuvWhe88//4oM1f7Vq5AOYzwhqIVAXL0ARY8RGK55SOqxvVeYUQOxlJ60tQt
	Q3M+erRhAn2c3jh/5C3RQscXbee8nmvQChE7h5E2UNva6xAajwhpaaeKPiiwnqPdlvyNqwg4DsC
	kUseUTA/MGTZ0SFFfoJ/FVBYtjIruLyRyOqnow5Oe9N4PLYhibA9X4xgIPKfhHLdSn+TonORdCT
	JfAW6ToqQsaUOj1QN2IqAJQAGDWBrpYTCg6vzKPPqf1YoM+IVw5nUY+havIwWsmzB98Oet7aix+
	PCKkBNsAWgxYjTed8YrgVY3/6bRW4x4IfussDKszchtO5iQFwl59
X-Google-Smtp-Source: AGHT+IGb0oVtLFxfTVNkGEYvNAOhNxmeHvVh3eQFioRnpv5ZABaotkNw72x+Sj5c/pKlIAPGw3vBTg==
X-Received: by 2002:a17:902:f786:b0:234:a734:4ab1 with SMTP id d9443c01a7336-234a7344c4cmr105474015ad.3.1748476023327;
        Wed, 28 May 2025 16:47:03 -0700 (PDT)
Received: from gmail.com ([98.97.34.246])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23506bc8607sm1465935ad.42.2025.05.28.16.47.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 May 2025 16:47:02 -0700 (PDT)
Date: Wed, 28 May 2025 16:46:50 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: bpf@vger.kernel.org, Jakub Sitnicki <jakub@cloudflare.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v1] bpf, sockmap: Fix psock incorrectly pointing
 to sk
Message-ID: <20250528234650.n5orke2yq55qnoen@gmail.com>
References: <20250523162220.52291-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250523162220.52291-1-jiayuan.chen@linux.dev>

On 2025-05-24 00:22:19, Jiayuan Chen wrote:
> We observed an issue from the latest selftest: sockmap_redir where
> sk_psock(psock->sk) != psock in the backlog. The root cause is the special
> behavior in sockmap_redir - it frequently performs map_update() and
> map_delete() on the same socket. During map_update(), we create a new
> psock and during map_delete(), we eventually free the psock via rcu_work
> in sk_psock_drop(). However, pending workqueues might still exist and not
> be processed yet. If users immediately perform another map_update(), a new
> psock will be allocated for the same sk, resulting in two psocks pointing
> to the same sk.
> 
> When the pending workqueue is later triggered, it uses the old psock to
> access sk for I/O operations, which is incorrect.
> 
> Timing Diagram:
> 
> cpu0                        cpu1
> 
> map_update(sk):
>     sk->psock = psock1
>     psock1->sk = sk
> map_delete(sk):
>    rcu_work_free(psock1)
> 
> map_update(sk):
>     sk->psock = psock2
>     psock2->sk = sk
>                             workqueue:
>                                 wakeup with psock1, but the sk of psock1
>                                 doesn't belong to psock1
> rcu_handler:
>     clean psock1
>     free(psock1)
> 
> Previously, we used reference counting to address the concurrency issue
> between backlog and sock_map_close(). This logic remains necessary as it
> prevents the sk from being freed while processing the backlog. But this
> patch prevents pending backlogs from using a psock after it has been
> freed.

Nit, its not that psock would be freed because we do have the
cancel_delayed_work_sync() before the kfree(psock). But this
is not a good state with two psocks referenceing the same sk.

> 
> Note: We cannot call cancel_delayed_work_sync() in map_delete() since this
> might be invoked in BPF context by BPF helper, and the function may sleep.
> 
> Fixes: 604326b41a6f ("bpf, sockmap: convert to generic sk_msg interface")
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> 
> ---
> Thanks to Michal Luczaj for providing the sockmap_redir test case, which
> indeed covers almost all sockmap forwarding paths.
> ---
>  include/linux/skmsg.h | 1 +
>  net/core/skmsg.c      | 5 ++++-
>  2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/skmsg.h b/include/linux/skmsg.h
> index 0b9095a281b8..b17221eef2f4 100644
> --- a/include/linux/skmsg.h
> +++ b/include/linux/skmsg.h
> @@ -67,6 +67,7 @@ struct sk_psock_progs {
>  enum sk_psock_state_bits {
>  	SK_PSOCK_TX_ENABLED,
>  	SK_PSOCK_RX_STRP_ENABLED,
> +	SK_PSOCK_DROPPED,
>  };
>  
>  struct sk_psock_link {
> diff --git a/net/core/skmsg.c b/net/core/skmsg.c
> index 34c51eb1a14f..bd58a693ce9a 100644
> --- a/net/core/skmsg.c
> +++ b/net/core/skmsg.c
> @@ -656,6 +656,9 @@ static void sk_psock_backlog(struct work_struct *work)
>  	bool ingress;
>  	int ret;
>  
> +	if (sk_psock_test_state(psock, SK_PSOCK_DROPPED))
> +		return;


Could we use the SK_PSOCK_TX_ENABLED bit here? Its already used to
ensure we wont requeue work after the psock has started being
removed. Seems like we don't need two flags? wdyt?

> +
>  	/* Increment the psock refcnt to synchronize with close(fd) path in
>  	 * sock_map_close(), ensuring we wait for backlog thread completion
>  	 * before sk_socket freed. If refcnt increment fails, it indicates
> @@ -867,7 +870,7 @@ void sk_psock_drop(struct sock *sk, struct sk_psock *psock)
>  	write_unlock_bh(&sk->sk_callback_lock);
>  
>  	sk_psock_stop(psock);

Can we add this to sk_psock_stop where we have the TX_ENABLED bit
cleared.

> -
> +	sk_psock_set_state(psock, SK_PSOCK_DROPPED);
>  	INIT_RCU_WORK(&psock->rwork, sk_psock_destroy);
>  	queue_rcu_work(system_wq, &psock->rwork);
>  }
> -- 
> 2.47.1
> 

