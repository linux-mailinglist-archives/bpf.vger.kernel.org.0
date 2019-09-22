Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B89A7BA2A4
	for <lists+bpf@lfdr.de>; Sun, 22 Sep 2019 14:37:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728955AbfIVMho (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 22 Sep 2019 08:37:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56820 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726129AbfIVMhk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 22 Sep 2019 08:37:40 -0400
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 437F1C05686D
        for <bpf@vger.kernel.org>; Sun, 22 Sep 2019 12:37:39 +0000 (UTC)
Received: by mail-qk1-f197.google.com with SMTP id w7so14317882qkf.10
        for <bpf@vger.kernel.org>; Sun, 22 Sep 2019 05:37:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZIZ6PVJwNqKV66/6V0eWwKczW/IuITxJoofGCnfWMcw=;
        b=XV5vjApT3uBEnoJTaHxgNYnb+DrlI4FnCmbb68BHme5uzMie6O3dnJsJ/R4qyfCH3I
         Kfedkdl8dpZOMBjetqcOyWD5nVfqTlybyWDxvXNucdWmgiYGvTevjQd8xperq3MFmjfJ
         lq7q7Xox3s8FSwMYVTsCSZiaPRNAuBrI5iizxG2q1vpPBnRfEtgusFDnKh02KCH9vMZf
         jexbEoGyUzGigkUx3xRUliCEzbCMcnAvG03J1kGa3A6f7kxT6uz8slcz52cbbP9qcvJ/
         ytZ0O1O7o1vepS95QFZwOBVTCkstTxisxrBqKW+zVU0Ei1zreGYs8W/xEJNvO8M0347x
         1+zQ==
X-Gm-Message-State: APjAAAVVMCUxnQxmSKo5kniCam9hGGURO+cnvxgpKqESjLc8nQcEwZEw
        /+zlPlC2BgT4d0PuS0yert0H0hQZdlSqw3gDkgXg+pmfO4Fqx2IalDP3avk5kvkYOoNgEcAI6gt
        glsZikAyPi5Oj
X-Received: by 2002:a0c:b0cb:: with SMTP id p11mr20902498qvc.216.1569155858541;
        Sun, 22 Sep 2019 05:37:38 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzCmU3TskOEyZFzEQEVup/JmX+POAXnjml1Z6r35N3M5NYpi2V6FhRyoe8OlTiMpNbNUDXHPA==
X-Received: by 2002:a0c:b0cb:: with SMTP id p11mr20902486qvc.216.1569155858290;
        Sun, 22 Sep 2019 05:37:38 -0700 (PDT)
Received: from redhat.com (bzq-79-176-40-226.red.bezeqint.net. [79.176.40.226])
        by smtp.gmail.com with ESMTPSA id w18sm3976903qts.44.2019.09.22.05.37.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Sep 2019 05:37:37 -0700 (PDT)
Date:   Sun, 22 Sep 2019 08:37:30 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Matthew Cover <werekraken@gmail.com>
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        jasowang@redhat.com, edumazet@google.com, sdf@google.com,
        matthew.cover@stackpath.com, mail@timurcelik.de, pabeni@redhat.com,
        nicolas.dichtel@6wind.com, wangli39@baidu.com,
        lifei.shirley@bytedance.com, tglx@linutronix.de,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: [PATCH net-next] tuntap: Fallback to automq on
 TUNSETSTEERINGEBPF prog negative return
Message-ID: <20190922080326-mutt-send-email-mst@kernel.org>
References: <20190920185843.4096-1-matthew.cover@stackpath.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190920185843.4096-1-matthew.cover@stackpath.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Sep 20, 2019 at 11:58:43AM -0700, Matthew Cover wrote:
> Treat a negative return from a TUNSETSTEERINGEBPF bpf prog as a signal
> to fallback to tun_automq_select_queue() for tx queue selection.
> 
> Compilation of this exact patch was tested.
> 
> For functional testing 3 additional printk()s were added.
> 
> Functional testing results (on 2 txq tap device):
> 
>   [Fri Sep 20 18:33:27 2019] ========== tun no prog ==========
>   [Fri Sep 20 18:33:27 2019] tuntap: tun_ebpf_select_queue() returned '-1'
>   [Fri Sep 20 18:33:27 2019] tuntap: tun_automq_select_queue() ran
>   [Fri Sep 20 18:33:27 2019] ========== tun prog -1 ==========
>   [Fri Sep 20 18:33:27 2019] tuntap: bpf_prog_run_clear_cb() returned '-1'
>   [Fri Sep 20 18:33:27 2019] tuntap: tun_ebpf_select_queue() returned '-1'
>   [Fri Sep 20 18:33:27 2019] tuntap: tun_automq_select_queue() ran
>   [Fri Sep 20 18:33:27 2019] ========== tun prog 0 ==========
>   [Fri Sep 20 18:33:27 2019] tuntap: bpf_prog_run_clear_cb() returned '0'
>   [Fri Sep 20 18:33:27 2019] tuntap: tun_ebpf_select_queue() returned '0'
>   [Fri Sep 20 18:33:27 2019] ========== tun prog 1 ==========
>   [Fri Sep 20 18:33:27 2019] tuntap: bpf_prog_run_clear_cb() returned '1'
>   [Fri Sep 20 18:33:27 2019] tuntap: tun_ebpf_select_queue() returned '1'
>   [Fri Sep 20 18:33:27 2019] ========== tun prog 2 ==========
>   [Fri Sep 20 18:33:27 2019] tuntap: bpf_prog_run_clear_cb() returned '2'
>   [Fri Sep 20 18:33:27 2019] tuntap: tun_ebpf_select_queue() returned '0'
> 
> Signed-off-by: Matthew Cover <matthew.cover@stackpath.com>


Could you add a bit more motivation data here?
1. why is this a good idea
2. how do we know existing userspace does not rely on existing behaviour
3. why doesn't userspace need a way to figure out whether it runs on a kernel with and
   without this patch


thanks,
MST

> ---
>  drivers/net/tun.c | 20 +++++++++++---------
>  1 file changed, 11 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index aab0be4..173d159 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c
> @@ -583,35 +583,37 @@ static u16 tun_automq_select_queue(struct tun_struct *tun, struct sk_buff *skb)
>  	return txq;
>  }
>  
> -static u16 tun_ebpf_select_queue(struct tun_struct *tun, struct sk_buff *skb)
> +static int tun_ebpf_select_queue(struct tun_struct *tun, struct sk_buff *skb)
>  {
>  	struct tun_prog *prog;
>  	u32 numqueues;
> -	u16 ret = 0;
> +	int ret = -1;
>  
>  	numqueues = READ_ONCE(tun->numqueues);
>  	if (!numqueues)
>  		return 0;
>  
> +	rcu_read_lock();
>  	prog = rcu_dereference(tun->steering_prog);
>  	if (prog)
>  		ret = bpf_prog_run_clear_cb(prog->prog, skb);
> +	rcu_read_unlock();
>  
> -	return ret % numqueues;
> +	if (ret >= 0)
> +		ret %= numqueues;
> +
> +	return ret;
>  }
>  
>  static u16 tun_select_queue(struct net_device *dev, struct sk_buff *skb,
>  			    struct net_device *sb_dev)
>  {
>  	struct tun_struct *tun = netdev_priv(dev);
> -	u16 ret;
> +	int ret;
>  
> -	rcu_read_lock();
> -	if (rcu_dereference(tun->steering_prog))
> -		ret = tun_ebpf_select_queue(tun, skb);
> -	else
> +	ret = tun_ebpf_select_queue(tun, skb);
> +	if (ret < 0)
>  		ret = tun_automq_select_queue(tun, skb);
> -	rcu_read_unlock();
>  
>  	return ret;
>  }
> -- 
> 1.8.3.1
