Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91B8D3209D
	for <lists+bpf@lfdr.de>; Sat,  1 Jun 2019 21:42:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726195AbfFATmj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 1 Jun 2019 15:42:39 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38661 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726649AbfFATmj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 1 Jun 2019 15:42:39 -0400
Received: by mail-pf1-f196.google.com with SMTP id a186so7524001pfa.5
        for <bpf@vger.kernel.org>; Sat, 01 Jun 2019 12:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=wxk9MA26g5ON2Ao69bYkmUGIZtyekaPlopIn9qik3OQ=;
        b=CFYzWZLHLR1qUg9SCKCwuN1j2GQjTuJh3cpM/iuzlnHlTV2dSzsd5rHIOa0RvYoULi
         uSn4NeP60/Oli3IUzbyqvaMAlAoGNffOnchXe3LVZkyH0hhSS146kxHrJtzTmYceWHTD
         8r9cbqfTZxoPG9H9+yppdfX+xKMPUvfYDtsbySEBMjs2lUgpQzspyyQ+uJyP27mkWADn
         J2AD1U/O/bWUJ6COcnXF48FVEARRFQBKtewVYyH8mNRvF+uXKT06v+r9CV/eWDmav225
         ewKZAB8bDs8w3ElFVxrkgSwcnyuCR7neoTyTYfW3KX0afAdd3XrhiPxInewlpkjQ5Xy4
         FtEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=wxk9MA26g5ON2Ao69bYkmUGIZtyekaPlopIn9qik3OQ=;
        b=Eb3ognDXZjm+z+vvbKHDFEcefWqXt39Q5NztwtMOvqBQ5Z4ka/q+/lXtqJJY4iysQE
         WdQOtDZyep5Wsq4M1n64qAcgZJASIg0PptDu6VOTnG7b9ADxL5jjiUbP4uTlYatfCdCA
         J8Kc85SX0xsBjHQkMQuR8cYPfMwA0yu346L/QtPb0Y5sZewFUwOp7aTBdQQNJsPQz8od
         qjXJOBFekusJvK4L2VukpjYmkS5LgdqvhLmoYgYaFqrWeMrIdXepKVdu55tJ+eRuOvb4
         0rvB3H8H38XUexTv9s5aDw05dt6gMXceEyjziQqiWUXWyK/1y3wPgQvG1Xgx0AP+z1yF
         cZVA==
X-Gm-Message-State: APjAAAX+pRWv6AgX9NB5u2gJMzg8KdScNQHcZtSFoTOxNr9mgP3Z8YKT
        w44g5IY4IbKiXT7WaCtbNlDh0w==
X-Google-Smtp-Source: APXvYqx5jSRTbi+hj2c/yhrIeOOk+KN4zIeb4iTWApj0bUr61V5+Q+URB/bAERJRQlwFqH5TL3MUDw==
X-Received: by 2002:a17:90a:a00a:: with SMTP id q10mr18354261pjp.102.1559418157968;
        Sat, 01 Jun 2019 12:42:37 -0700 (PDT)
Received: from cakuba.netronome.com ([2601:646:8e00:e50::3])
        by smtp.gmail.com with ESMTPSA id 25sm10694651pfp.76.2019.06.01.12.42.36
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 01 Jun 2019 12:42:37 -0700 (PDT)
Date:   Sat, 1 Jun 2019 12:42:33 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Saeed Mahameed <saeedm@mellanox.com>
Cc:     "toke@redhat.com" <toke@redhat.com>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "ast@kernel.org" <ast@kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "bjorn.topel@gmail.com" <bjorn.topel@gmail.com>,
        "magnus.karlsson@intel.com" <magnus.karlsson@intel.com>,
        "bjorn.topel@intel.com" <bjorn.topel@intel.com>,
        "brouer@redhat.com" <brouer@redhat.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next v2 1/2] net: xdp: refactor XDP_QUERY_PROG{,_HW}
 to netdev
Message-ID: <20190601124233.5a130838@cakuba.netronome.com>
In-Reply-To: <b0a9c3b198bdefd145c34e52aa89d33aa502aaf5.camel@mellanox.com>
References: <20190531094215.3729-1-bjorn.topel@gmail.com>
        <20190531094215.3729-2-bjorn.topel@gmail.com>
        <b0a9c3b198bdefd145c34e52aa89d33aa502aaf5.camel@mellanox.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 31 May 2019 19:18:17 +0000, Saeed Mahameed wrote:
> On Fri, 2019-05-31 at 11:42 +0200, Bj=C3=B6rn T=C3=B6pel wrote:
> > From: Bj=C3=B6rn T=C3=B6pel <bjorn.topel@intel.com>
> >=20
> > All XDP capable drivers need to implement the XDP_QUERY_PROG{,_HW}
> > command of ndo_bpf. The query code is fairly generic. This commit
> > refactors the query code up from the drivers to the netdev level.
> >=20
> > The struct net_device has gained two new members: xdp_prog_hw and
> > xdp_flags. The former is the offloaded XDP program, if any, and the
> > latter tracks the flags that the supplied when attaching the XDP
> > program. The flags only apply to SKB_MODE or DRV_MODE, not HW_MODE.
> >=20
> > The xdp_prog member, previously only used for SKB_MODE, is shared
> > with
> > DRV_MODE. This is OK, due to the fact that SKB_MODE and DRV_MODE are
> > mutually exclusive. To differentiate between the two modes, a new
> > internal flag is introduced as well. =20
>=20
> Just thinking out loud, why can't we allow any combination of
> HW/DRV/SKB modes? they are totally different attach points in a totally
> different checkpoints in a frame life cycle.

FWIW see Message-ID: <20190201080236.446d84d4@redhat.com>

> Down the road i think we will utilize this fact and start introducing
> SKB helpers for SKB mode and driver helpers for DRV mode..

Any reason why we would want the extra complexity?  There is cls_bpf
if someone wants skb features after all..
