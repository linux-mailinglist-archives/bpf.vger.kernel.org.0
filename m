Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81353124FA3
	for <lists+bpf@lfdr.de>; Wed, 18 Dec 2019 18:47:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbfLRRr2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 18 Dec 2019 12:47:28 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40117 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726985AbfLRRr2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 18 Dec 2019 12:47:28 -0500
Received: by mail-pl1-f195.google.com with SMTP id g6so1290596plp.7
        for <bpf@vger.kernel.org>; Wed, 18 Dec 2019 09:47:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=oIE/497lOI7LXc9jgu4fcSd10UVgyYO9WDSbuj+M5ig=;
        b=wFMRrqMsTXCYjfDjvWyZohde2LR/IevgpQJF96FF6Eb1BeaG44rQelM2V2uJH0kX31
         tmy8KVdBRh/vLeJtwdEOVP72KkmXfL/aTACuSkf4oXfLIaoNVSRU3U3lf59Rq/pdNSw4
         zI6uprq3bmbWl4WAXYL+5x8a+o5L/AVBifW3RPuuXmORdJN3xpERd7FSIxFaBh8iLi3h
         ChEOvBbl1eAH/a+FSzSH7JktEFYDGQyvKE8Go432aX4FvqUlIEGh3rIMHK4hmBy4+vtQ
         9K5HS/hVh9lXt2KvqR2Wxe8Y9/0gBx/sjzb3ulqSJC3RKY/Q5gtUD6KaqiYQfOAqRHMX
         cq3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=oIE/497lOI7LXc9jgu4fcSd10UVgyYO9WDSbuj+M5ig=;
        b=sS/52sPH+SwO+RLtYumvzNpvLc3cdCB3pTxkqHZHRT6kknr+6s+iiyEc4zC/jhh5gC
         Zjz1Li2EDjlWoY2kjB3iIJxp3P81Kyiaoq9PKEMdlwHxQiDGEqWyeTs0BOwPemeqfoHo
         8C/w8aRDenWvDZW7e5SO2qjXjuPVnbparfbRVHUp3LqFPTk3D/Lm3LbPuYf6H8ojBGgv
         QZvcTLMBaEexWWeiEqnp5diGdITLILOBrG0+cIdXrTyyNLu6yXxmrS+pDcnshts9OFKj
         X9a+C44XWN72aeDU0v5lc9hVZa/Hbhcfaydl9VWT/5TSubQVTL0Dl89W5zAA0cKmgayn
         rlYA==
X-Gm-Message-State: APjAAAWJm87ZNTyHy2py+HWDs5pkvQ8V9aWah0pU9VN0vx0tV8OdiGMA
        okmPH+6OL4WaKvvQhcwr2fDxgQ==
X-Google-Smtp-Source: APXvYqzrW1Ni4SADZX2cj4+UeYnZzyfvgqMwNH562anPy2ilqN4FNH/QwSxO2WTiRWGpevJElK4Xxw==
X-Received: by 2002:a17:90a:974a:: with SMTP id i10mr4410453pjw.0.1576691247884;
        Wed, 18 Dec 2019 09:47:27 -0800 (PST)
Received: from cakuba.netronome.com ([2601:646:8e00:e18::5])
        by smtp.gmail.com with ESMTPSA id a10sm4021874pgm.81.2019.12.18.09.47.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 09:47:27 -0800 (PST)
Date:   Wed, 18 Dec 2019 09:47:23 -0800
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>
Cc:     netdev@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>,
        bpf@vger.kernel.org, davem@davemloft.net, hawk@kernel.org,
        john.fastabend@gmail.com, magnus.karlsson@intel.com,
        jonathan.lemon@gmail.com
Subject: Re: [PATCH bpf-next 2/8] xdp: simplify cpumap cleanup
Message-ID: <20191218094723.13ab0d54@cakuba.netronome.com>
In-Reply-To: <20191218105400.2895-3-bjorn.topel@gmail.com>
References: <20191218105400.2895-1-bjorn.topel@gmail.com>
        <20191218105400.2895-3-bjorn.topel@gmail.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 18 Dec 2019 11:53:54 +0100, Bj=C3=B6rn T=C3=B6pel wrote:
> From: Bj=C3=B6rn T=C3=B6pel <bjorn.topel@intel.com>
>=20
> After the RCU flavor consolidation [1], call_rcu() and
> synchronize_rcu() waits for preempt-disable regions (NAPI) in addition
> to the read-side critical sections. As a result of this, the cleanup
> code in cpumap can be simplified
>=20
> * There is no longer a need to flush in __cpu_map_entry_free, since we
>   know that this has been done when the call_rcu() callback is
>   triggered.
>=20
> * When freeing the map, there is no need to explicitly wait for a
>   flush. It's guaranteed to be done after the synchronize_rcu() call
>   in cpu_map_free().
>=20
> [1] https://lwn.net/Articles/777036/
>=20
> Signed-off-by: Bj=C3=B6rn T=C3=B6pel <bjorn.topel@intel.com>

Probably transient but:

../kernel/bpf/cpumap.c: In function "cpu_map_free":
../kernel/bpf/cpumap.c:502:6: warning: unused variable "cpu" [-Wunused-vari=
able]
  502 |  int cpu;
      |      ^~~

I think there are also warnings in patch 4.
