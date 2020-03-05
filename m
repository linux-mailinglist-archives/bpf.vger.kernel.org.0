Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CCFA517A4FA
	for <lists+bpf@lfdr.de>; Thu,  5 Mar 2020 13:14:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725963AbgCEMOS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 5 Mar 2020 07:14:18 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50263 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725816AbgCEMOS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 5 Mar 2020 07:14:18 -0500
Received: by mail-wm1-f65.google.com with SMTP id a5so6038784wmb.0
        for <bpf@vger.kernel.org>; Thu, 05 Mar 2020 04:14:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=DtylarLseGTRSTj79YH0pOEE1qvMQn3Ic9k76fdU8z0=;
        b=c3MZrStMy9rXY4LcGnY4z7bThtnCWXwAvEzSdAtXuQb74sFKFp07aFVF8/7ZVrZMM3
         oeGGRd0VZPtEk+yT14fYnnAbe5yEaZqYTVxLhbVWr919FlVWhdQDfHSc7b3o23PQSTiG
         2y+Hd2ru1+0B95UcUfaOEE67OHsMaReKJzR5E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=DtylarLseGTRSTj79YH0pOEE1qvMQn3Ic9k76fdU8z0=;
        b=mAbozR5ko1XvB/csc5T5xMY1ZAKCRnVMr2f0sHVCXv5AUmfROEdgxvfsIfuwZ/QaTo
         otOLXoXqRXHWgrXLSaXKyZEwvf9tzasSIRkE5tbG7QFPXzEIyjcvDElgm14H7HoeB8Bg
         Q0gvZPwIh/5rR68j90Cl9W+AY979RYuOMJq3nMTtnWqHxay0OU7WLj4+eN7WoDEzWw3i
         yeoxTghUcgg5Jw03Jv3kr2rhNAfvOZfd5q4QoCBopDrvz7+7Sau7r//+8K7/y2IVXvqs
         QkgS6xmGmdzQnH15KvG/o1XI9dAxOCgwoOT6qeHovpg7bq4PMn6r7cTy0qekvGz6C7tO
         NfbA==
X-Gm-Message-State: ANhLgQ3HQN3vQL9YxEVjZzOdR83Y9fV3c2cG37sZvCd7oBeZkb+GxkF0
        UFKODSJ1wtfBgcl3DgVrIqlWbQ==
X-Google-Smtp-Source: ADFU+vvURwIYVL0oQSbipNi4dg8FfZ04v87aaIMVM8dfsGJKU87OR9g3D9Lj8aQBU1gbPm92C1Ythg==
X-Received: by 2002:a05:600c:290e:: with SMTP id i14mr8981129wmd.24.1583410456431;
        Thu, 05 Mar 2020 04:14:16 -0800 (PST)
Received: from cloudflare.com ([176.221.114.230])
        by smtp.gmail.com with ESMTPSA id p17sm41438418wre.89.2020.03.05.04.14.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2020 04:14:15 -0800 (PST)
References: <20200304101318.5225-1-lmb@cloudflare.com> <20200304101318.5225-5-lmb@cloudflare.com>
User-agent: mu4e 1.1.0; emacs 26.3
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     Lorenz Bauer <lmb@cloudflare.com>
Cc:     john.fastabend@gmail.com, Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        kernel-team@cloudflare.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next v3 04/12] bpf: tcp: guard declarations with CONFIG_NET_SOCK_MSG
In-reply-to: <20200304101318.5225-5-lmb@cloudflare.com>
Date:   Thu, 05 Mar 2020 13:14:14 +0100
Message-ID: <87d09ryp61.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Mar 04, 2020 at 11:13 AM CET, Lorenz Bauer wrote:
> tcp_bpf.c is only included in the build if CONFIG_NET_SOCK_MSG is
> selected. The declaration should therefore be guarded as such.
>
> Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
> Acked-by: John Fastabend <john.fastabend@gmail.com>
> ---

Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>

[...]
