Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3731C79119
	for <lists+bpf@lfdr.de>; Mon, 29 Jul 2019 18:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729089AbfG2QhM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 29 Jul 2019 12:37:12 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38439 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729074AbfG2QhL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 29 Jul 2019 12:37:11 -0400
Received: by mail-pl1-f193.google.com with SMTP id az7so27704041plb.5
        for <bpf@vger.kernel.org>; Mon, 29 Jul 2019 09:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=rQNwVWhr/iAWO1h6tJ7DvuuxwYrEzjOkIjTIxJSwEeM=;
        b=CzxJQ8DfEZgEgBpwt3AL5iNRX2dHKgYQ2l1Fdl9DjYxLKA9QEjfLSAuwQ8f4ble5pp
         w3UhiYarfOQ6+3GwSpTqL1Nq6uiAt3NJBW9hqig7p/QWWjE53iA9SjYWtQ0wqqcC71FU
         emdUecmyeMSXHAIs044VY7RhUmspvRPwEOfql2Nz7iE9n1X/MksTH5/z3UV5fpuFTvuV
         DbbF2jPQkVNTfA2ZOmRfatcF7vbDefGpvhk8VxyBKVu3YuXaw5tX9nhcbM+vtSE0MrKA
         SP/500QNfGzgH1dEsfScd3Ff66xKZ2KqeLsRKVG0hc2XOmON+Gag3SQOTzYHYiMks5vk
         /aMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=rQNwVWhr/iAWO1h6tJ7DvuuxwYrEzjOkIjTIxJSwEeM=;
        b=Rr050fA7KJtL8Yzx4s2ZL1Uy370JJRolMt0pNu4YY+RcavqkQcS2M6HCEG7UCKCxR2
         cy+EMjZfAeRyA6YqoN5s09XVXQz6dgjQEqjr44HzsdWrUVs6XeXTbJZCmUFV/938rL25
         QL15SD1jk0wn0N/Xx0B8mQJ2NpJqxXAvIOzf71ierdCl8uEWaNx/fPKnVndc6c87yLCj
         c7dAxvemVdU43tw1aUdNDt1FvVw6Ni3TLWOKqfmjQtmTXnscslWWXgXg9zauYltpxHOS
         GBIkhFVu1BbafBX5uM2jJvaF82vNiKQyIzLgY/ORbMyBVCNxerPpwKxFVOBAHSZXxu6/
         SXBg==
X-Gm-Message-State: APjAAAUGMtN4HPUbQ1/vs3zwJiNGNQukkrhF3ZABL2TxR1WjmTcHl3DN
        81S0abraGwkZ9nMR5a89dDfTIQ==
X-Google-Smtp-Source: APXvYqxf5IrbxRXrgplVLx4tyGUqrNJe0VLQyF/nrJYjVyVRsG6XN4wmnW0oV3rs7b+I53AKL01jrA==
X-Received: by 2002:a17:902:59c3:: with SMTP id d3mr107721634plj.22.1564418231023;
        Mon, 29 Jul 2019 09:37:11 -0700 (PDT)
Received: from cakuba.netronome.com (c-71-204-185-212.hsd1.ca.comcast.net. [71.204.185.212])
        by smtp.gmail.com with ESMTPSA id h11sm62978725pfn.120.2019.07.29.09.37.10
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 09:37:10 -0700 (PDT)
Date:   Mon, 29 Jul 2019 09:37:00 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Jesper Dangaard Brouer <brouer@redhat.com>
Cc:     xdp-newbies@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        davem@davemloft.net, john.fastabend@gmail.com
Subject: Re: [PATCH net-next] MAINTAINERS: Remove mailing-list entry for XDP
 (eXpress Data Path)
Message-ID: <20190729093341.2bdb04dd@cakuba.netronome.com>
In-Reply-To: <156440259790.6123.1563221733550893420.stgit@carbon>
References: <156440259790.6123.1563221733550893420.stgit@carbon>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 29 Jul 2019 14:16:37 +0200, Jesper Dangaard Brouer wrote:
> This removes the mailing list xdp-newbies@vger.kernel.org from the XDP
> kernel maintainers entry.
> 
> Being in the kernel MAINTAINERS file successfully caused the list to
> receive kbuild bot warnings, syzbot reports and sometimes developer
> patches. The level of details in these messages, doesn't match the
> target audience of the XDP-newbies list. This is based on a survey on
> the mailing list, where 73% voted for removal from MAINTAINERS file.
> 
> Signed-off-by: Jesper Dangaard Brouer <brouer@redhat.com>

Acked-by: Jakub Kicinski <jakub.kicinski@netronome.com>
