Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB2F1107FBB
	for <lists+bpf@lfdr.de>; Sat, 23 Nov 2019 19:03:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbfKWSDr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 23 Nov 2019 13:03:47 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33471 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726524AbfKWSDr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 23 Nov 2019 13:03:47 -0500
Received: by mail-pg1-f194.google.com with SMTP id 6so496515pgk.0
        for <bpf@vger.kernel.org>; Sat, 23 Nov 2019 10:03:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=b4KazJIdHMahp3tpOcvML7AefY0d0jAOfEKpcKoACHQ=;
        b=F41GojoIa7pOQto6HzJFmmD6rr98QGLFbcN/2lWa35Ygu5jPT4xDgIHx1M423zBwrZ
         srrwh0Qczc+AXDXkukpcwOSC4aBcKFYWvjXNWU1kI9C2tq8qkwpho2NUz1yO5Orgajsd
         FGnWt0rXlz3WM88b+hfl6b7Hr70SLDwz5wtnGq6u/B2hjjdvQuV2hly1s0dTDOZp6gdc
         NpmCjz9GuzGL4SCf6HsZnY9Lsqn/kLDCFoJs0tdc/clEW2P0xWrwn/xBtCplBm+0hp40
         gMXFei1jWm1O5mcR2VPmKlH56RCMptO2nmu2GpKXRkuImXAAhKronF/NcfZqR5CD/KAN
         FUlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=b4KazJIdHMahp3tpOcvML7AefY0d0jAOfEKpcKoACHQ=;
        b=r+0aYZY2KOOA8RbcsfOg5R0bQciCG3IoWX7fvtyF2GNliI8w/4C/g6M6X+GetV1kS3
         E4J89aO0GXXTV/bFozEjA0pw3Fa3ZK7UGoYjKRy+F5m3pWFecoRhzvFLsI/7LMscpHCU
         uU4N//noQuyWAyL8epaygfoq4ssII6RNIwKU3IgZgwbUO5ziN1JTMFaFb95jAFUOSD/x
         aKpJNvzICsCJaiIWZd3zIqLMl2ah92ll/q/DTmSsKwlvEc/5TYuLJnlVp+m78W3J30TV
         KkI2z5Dkg1GWotalOUR7dsV0zwfM0/A8C5Wl/hxrAyhqUpDwUf+dEUrnGIFQubddUway
         Badw==
X-Gm-Message-State: APjAAAVMW2Ur+hYr9YO/xVIjc6RZMsEs6ICKMfkbZVzp1xlfucxl4b3k
        LgTJGS2xZdAznqCzgz4NRaM/YQ==
X-Google-Smtp-Source: APXvYqylczzxoUHlQtIIWwtaPhnuxFWpFB+khkQ+j9Ha3qTgp5tmxdwFACVzBp40ZJK60jhQEGltLA==
X-Received: by 2002:aa7:9787:: with SMTP id o7mr25130589pfp.120.1574532226636;
        Sat, 23 Nov 2019 10:03:46 -0800 (PST)
Received: from cakuba.netronome.com (c-73-202-202-92.hsd1.ca.comcast.net. [73.202.202.92])
        by smtp.gmail.com with ESMTPSA id i13sm2305773pfo.39.2019.11.23.10.03.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Nov 2019 10:03:46 -0800 (PST)
Date:   Sat, 23 Nov 2019 10:03:40 -0800
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Paul Moore <paul@paul-moore.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        linux-audit@redhat.com, Jiri Olsa <jolsa@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andriin@fb.com>,
        Yonghong Song <yhs@fb.com>, Martin KaFai Lau <kafai@fb.com>,
        Steve Grubb <sgrubb@redhat.com>,
        David Miller <davem@redhat.com>,
        Eric Paris <eparis@redhat.com>, Jiri Benc <jbenc@redhat.com>
Subject: Re: [PATCH] bpf: emit audit messages upon successful prog load and
 unload
Message-ID: <20191123100340.771bfd25@cakuba.netronome.com>
In-Reply-To: <20191123085719.GA1673@krava>
References: <20191120213816.8186-1-jolsa@kernel.org>
        <8c928ec4-9e43-3e2a-7005-21f40fcca061@iogearbox.net>
        <CAADnVQKu-ZgFTaSMH=Q-jMOYYvE32TF2b2hq1=dmDV8wAf18pg@mail.gmail.com>
        <CAHC9VhQbQoXacbTCNJPGNzFOv30PwLeiWu4ROQFU46=saTeTNQ@mail.gmail.com>
        <20191122002257.4hgui6pylpkmpwac@ast-mbp.dhcp.thefacebook.com>
        <CAHC9VhRihMi_d-p+ieXyuVBcGMs80SkypVxF4gLE_s45GKP0dg@mail.gmail.com>
        <20191122192353.GA2157@krava>
        <CAHC9VhRi0JtKgHyAOdAJ=_--vL1VbK7BDq1FnRQ_GwW9P4J_zA@mail.gmail.com>
        <20191123085719.GA1673@krava>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, 23 Nov 2019 09:57:19 +0100, Jiri Olsa wrote:
> Alexei already asked Dave to revert this in previous email,
> so that should happen

Reverted in net-next now.

But this is not really how this should work. You should post a proper
revert patch to netdev for review, with an explanation in the commit
message etc.
