Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 166F125279
	for <lists+bpf@lfdr.de>; Tue, 21 May 2019 16:46:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728537AbfEUOqC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 May 2019 10:46:02 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33628 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728295AbfEUOqC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 May 2019 10:46:02 -0400
Received: by mail-pl1-f193.google.com with SMTP id g21so496689plq.0
        for <bpf@vger.kernel.org>; Tue, 21 May 2019 07:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=de3y25UgGac49MbnsF0R7E+4373Q0F2/TDUFzvPVXAQ=;
        b=L8ycAEtULq2ubg26UmaLuj4uEu9FAeWattAev83ZQ2i4zEQtnAhGDcPbC5O04DlPdW
         L+kLP9LaUOoJTJQ+DeqQVXcRmzG6sH7p3qS5Suxre+uO9lkoACfmuiN6MbvSNHyT0ErO
         pI8hy0AauF6trTVMRLRfgf9UjUTwHyx1q4uVPID9NeWYiW4C0L9reFbO/szdOe6L9++B
         9R86QOmDu/h25eHiKHEovIHNA3j1dRmbaRoG9unkVNqmPv4gmlXHSwWcD/PID6+Y4EXY
         e6FiclMqCtIJ50e/qHZEbd8RRGnWm0zg46IevhewkTAs4jBjaPcwwJK0cC3jTsp8K3EN
         cLEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=de3y25UgGac49MbnsF0R7E+4373Q0F2/TDUFzvPVXAQ=;
        b=ZvojTywgn5VHGJjInW4YU/1cxcBT71tHicaZ6CG0bEacoybJOEn+QPJHoqqOWxRKCQ
         XZxuhJUzzD0h9+Wkrn8il3u3H7YOZGtRTZizwR4ksDKAioP5ujjeqJNCqxeR0SwfSCyl
         lKh5KYKEiGy4W/5Ftwx02hfZ+lgIe2VO9yUR0t/icGQ/k74a6isDl5/pe8FdDjbkAkjF
         LW1DtHaWeSDL0zRAESFwCvJln37o6GknUuNOdHf7UaWC9ax0kES8W9Ji3zeVAT7Rkj6v
         0nzi6QREvaW/Mm2sFTzFOVWbKM5PRVffFDBt5wocnW0judy/QqWrBikxhDG76ntLRqwK
         DpDA==
X-Gm-Message-State: APjAAAVeaMI4n+RsqIEbxBOYYI8GbTTw5tYdZg6D18fjGl6kBhJ/N1Gd
        HG7uDmRbd4qa1MtK+0KV8JRxMQ==
X-Google-Smtp-Source: APXvYqxL/kfPI/S/85HWsxZoJyfotngXhLZjk5iXQHZLDkK56y9TdDhMYM5qUophLBH2N2/83N6pNA==
X-Received: by 2002:a17:902:f24:: with SMTP id 33mr82347752ply.33.1558449961295;
        Tue, 21 May 2019 07:46:01 -0700 (PDT)
Received: from hermes.lan (204-195-22-127.wavecable.com. [204.195.22.127])
        by smtp.gmail.com with ESMTPSA id 7sm1948070pfo.90.2019.05.21.07.46.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 May 2019 07:46:01 -0700 (PDT)
Date:   Tue, 21 May 2019 07:45:53 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Jiri Pirko <jiri@resnulli.us>
Cc:     netdev@vger.kernel.org, davem@davemloft.net,
        xdp-newbies@vger.kernel.org, bpf@vger.kernel.org,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH v2 net 2/2] net: core: generic XDP support for stacked
 device
Message-ID: <20190521074553.12329dd5@hermes.lan>
In-Reply-To: <20190521061536.GB2210@nanopsycho.orion>
References: <20190519031046.4049-1-sthemmin@microsoft.com>
        <20190519031046.4049-3-sthemmin@microsoft.com>
        <20190520091105.GA2142@nanopsycho>
        <20190520090405.69b419e5@hermes.lan>
        <20190521061536.GB2210@nanopsycho.orion>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 21 May 2019 08:15:36 +0200
Jiri Pirko <jiri@resnulli.us> wrote:

> +	if (static_branch_unlikely(&generic_xdp_needed_key)) {
> +		int ret2;
> +
> +		preempt_disable();
> +		rcu_read_lock();
> +		ret2 = do_xdp_generic(rcu_dereference(skb->dev->xdp_prog), skb);
> +		rcu_read_unlock();
> +		preempt_enable();
> +
> +		if (ret2 != XDP_PASS)
> +			return NET_RX_DROP;
> +	}
> +

rcu_read_lock is already held by callers of __netif_receive_skb_core
