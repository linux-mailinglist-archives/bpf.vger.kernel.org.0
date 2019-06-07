Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D122399B9
	for <lists+bpf@lfdr.de>; Sat,  8 Jun 2019 01:32:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730409AbfFGXcB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 7 Jun 2019 19:32:01 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:32993 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730089AbfFGXcB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 7 Jun 2019 19:32:01 -0400
Received: by mail-pf1-f194.google.com with SMTP id x15so2020445pfq.0
        for <bpf@vger.kernel.org>; Fri, 07 Jun 2019 16:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=VTzWwngxPn7YyI3XNpgYPusalulagXtL7uonX4g/D38=;
        b=bOOMgC/P21zWjKT9xBiJT6w4SUTILrqWFCEkD+HiuqJZ4/AXnT6ykjTCAUiKGhS27g
         qPbHk8Nji1CYrI0iD5hMRCu+XP2nY6Q68AbBWKS+cD/jRrgzuQs8ib2OlPnBUrLguL6c
         1sTyyKsaBeik3WfK14pxVI7jzu6xzonbkvnQmnjXxfyIs1oQtGSmL5uNqUvF9EaIKSPu
         6mtCjYXzfbdEk/2fhBieW8HKJ2U/TbOwt7i+PqgyBmq5dJahD5iDnGVc1PaER9+9rsVe
         6gOT2FiFoeCywuoXzOBM8LGiLFxD4wzCDOoRWgL1ffcN31Mqh0L3g/ZEm8g47Rog+QYW
         y2Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=VTzWwngxPn7YyI3XNpgYPusalulagXtL7uonX4g/D38=;
        b=EkGlwn+L4uuqpYJ7vN7+CIGuKTEcCXyelrEfySCKKC8fleQ+1/qnEEegtpm2Dr73b5
         aDiyCo9PRSlq+uMk4IBySGtIXWJUEQxuB8NBCR5+CoVIZXNPMiOVIP85XIgeCJqsg9Y6
         HkTT/7nbK2Re0MSVbdAQBPPYlU7ulhnO042ijPKlX+TFqvFN8vCl/ySRllI599LJZ3xt
         rGGRkfoW7QzC5HCZc6poFiiCLDoaGh4cihgjn4JTed9LrNnHCmrKpF3UYWGYvL1ekcvZ
         2OJmfvQatDhPLoJv6XZ0SzPQwOeRJf6Xsy5M6tU38yq67OWEIZu6PuoQ7O+e7JZXVfWf
         66HA==
X-Gm-Message-State: APjAAAVYA8xje8sC6pqm06KaOx8r1rxlOS49TaJoMBRcEUHuMcCxX/So
        XkRfQg1/792JIUOecAfWE43ZKg==
X-Google-Smtp-Source: APXvYqxBXYWm19+1deGaXZDaw9PH6ku9LrMOLsUCcWOXLRowgB6zoMoADpT+vT7+curvzuEwQmMs0w==
X-Received: by 2002:a63:5024:: with SMTP id e36mr5430701pgb.220.1559950320726;
        Fri, 07 Jun 2019 16:32:00 -0700 (PDT)
Received: from cakuba.netronome.com (wsip-98-171-133-120.sd.sd.cox.net. [98.171.133.120])
        by smtp.gmail.com with ESMTPSA id 85sm6135458pgb.52.2019.06.07.16.31.59
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 07 Jun 2019 16:32:00 -0700 (PDT)
Date:   Fri, 7 Jun 2019 16:31:56 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Ilya Maximets <i.maximets@samsung.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, xdp-newbies@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        Jonathan Lemon <jonathan.lemon@gmail.com>
Subject: Re: [PATCH bpf v2] xdp: fix hang while unregistering device bound
 to xdp socket
Message-ID: <20190607163156.12cd3418@cakuba.netronome.com>
In-Reply-To: <20190607173143.4919-1-i.maximets@samsung.com>
References: <CGME20190607173149eucas1p1d2ebedcab469ebd66acfe7c7dcd18d7e@eucas1p1.samsung.com>
        <20190607173143.4919-1-i.maximets@samsung.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri,  7 Jun 2019 20:31:43 +0300, Ilya Maximets wrote:
> +static int xsk_notifier(struct notifier_block *this,
> +			unsigned long msg, void *ptr)
> +{
> +	struct sock *sk;
> +	struct net_device *dev = netdev_notifier_info_to_dev(ptr);
> +	struct net *net = dev_net(dev);
> +	int i, unregister_count = 0;

Please order the var declaration lines longest to shortest.
(reverse christmas tree)

> +	mutex_lock(&net->xdp.lock);
> +	sk_for_each(sk, &net->xdp.list) {
> +		struct xdp_sock *xs = xdp_sk(sk);
> +
> +		mutex_lock(&xs->mutex);
> +		switch (msg) {
> +		case NETDEV_UNREGISTER:

You should probably check the msg type earlier and not take all the
locks and iterate for other types..
