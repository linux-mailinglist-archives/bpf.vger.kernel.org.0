Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F6DF8E03F
	for <lists+bpf@lfdr.de>; Thu, 15 Aug 2019 00:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728684AbfHNWBj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 14 Aug 2019 18:01:39 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:39081 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728262AbfHNWBj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 14 Aug 2019 18:01:39 -0400
Received: by mail-qk1-f193.google.com with SMTP id 125so338780qkl.6
        for <bpf@vger.kernel.org>; Wed, 14 Aug 2019 15:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=jnzlZ6m4MyBxiN6dXhfXGdbsyLhcPOPGv61CSnzfC+A=;
        b=r/fxvywngqCj51PhCj37ngMB4xdglQXrSEZWUwJQGToBavgm0YUXJH/dZZb3sRhMSa
         4XdBcej/gP8n2ywM/WYTbJQyhogVOj0HNnbJGWNegWHQHSpTynmdFvdMqwwALj4F1gp7
         0w1QKvqUMeLRhbFVXfob6wnOs2TsqdVdfUOECgdNykLDS1opGxonLPw41BqlwriC1gza
         jixtbKZoTs/K+iMJ4t8m+eQqqL7TwY6UBO3O7BbenB7+UvQRiDdDfaBAEjHgNVSR5ulZ
         l3McWlEvyI1bdjmQ0r7UEsIdcKbJCEJmBTTRjbFfmnFkZRdEcsVXpfDhfN4cXdkZYYmj
         Km8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=jnzlZ6m4MyBxiN6dXhfXGdbsyLhcPOPGv61CSnzfC+A=;
        b=ATiiPKRhcd+XmyPAL0IWjafJmt/t+5RLfYJJUYrrMrWkhjqhEUAExtz4Rw0Vvof5Lt
         Ti3yJInhvK/JTCbd/emdYc0wj6zaXPavakRbvSA9iAe0JSdsbhP3lZieUIt+SreQJEIs
         zMykjU3DgBw4RnZzPdV8X8CpoOG39OrQVM+AhocgkW3XMLWos6LbWSeLmU35BHV31JUb
         xhEkNDQNQfJcWGDkkgsErC2T+2376TPf1vAT9oMMemuQr0zuiUuz+iF4VmfJQQJLzBCp
         W0R9Jfh0r0KT+pvCGQSYJj6M+4d1Z3i8dUChcamC9rOniAslnur65QHCprEEYon7NWLN
         JSgQ==
X-Gm-Message-State: APjAAAVuQT/OQ4GhcaHSfNN+FYLjRUwlRF6/fYyFPZ2tPeS0c46LmfmY
        MJ1Gb9tXyw3BjizOJMAE1VKBBg==
X-Google-Smtp-Source: APXvYqyevbHlwujs+qIs2fF8/38hu1aCZhxdWs5ZHvmvdjmB2g6RzytsVXv5cXSc7L03g/nXtTIcqg==
X-Received: by 2002:a37:bcc:: with SMTP id 195mr1339307qkl.115.1565820098385;
        Wed, 14 Aug 2019 15:01:38 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id p201sm511922qke.6.2019.08.14.15.01.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2019 15:01:38 -0700 (PDT)
Date:   Wed, 14 Aug 2019 15:01:23 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Maxim Mikityanskiy <maximmi@mellanox.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>
Subject: Re: [PATCH bpf-next v2] net: Don't call XDP_SETUP_PROG when nothing
 is changed
Message-ID: <20190814150123.6b5124e8@cakuba.netronome.com>
In-Reply-To: <20190814143352.3759-1-maximmi@mellanox.com>
References: <5b123e9a-095f-1db4-da6e-5af6552430e1@iogearbox.net>
        <20190814143352.3759-1-maximmi@mellanox.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 14 Aug 2019 14:34:06 +0000, Maxim Mikityanskiy wrote:
> Don't uninstall an XDP program when none is installed, and don't install
> an XDP program that has the same ID as the one already installed.
> 
> dev_change_xdp_fd doesn't perform any checks in case it uninstalls an
> XDP program. It means that the driver's ndo_bpf can be called with
> XDP_SETUP_PROG asking to set it to NULL even if it's already NULL. This
> case happens if the user runs `ip link set eth0 xdp off` when there is
> no XDP program attached.
> 
> The symmetrical case is possible when the user tries to set the program
> that is already set.
> 
> The drivers typically perform some heavy operations on XDP_SETUP_PROG,
> so they all have to handle these cases internally to return early if
> they happen. This patch puts this check into the kernel code, so that
> all drivers will benefit from it.
> 
> Signed-off-by: Maxim Mikityanskiy <maximmi@mellanox.com>

Reviewed-by: Jakub Kicinski <jakub.kicinski@netronome.com>
