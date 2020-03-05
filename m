Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D802717A5B6
	for <lists+bpf@lfdr.de>; Thu,  5 Mar 2020 13:54:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726094AbgCEMyD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 5 Mar 2020 07:54:03 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53043 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725991AbgCEMyD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 5 Mar 2020 07:54:03 -0500
Received: by mail-wm1-f67.google.com with SMTP id p9so6189246wmc.2
        for <bpf@vger.kernel.org>; Thu, 05 Mar 2020 04:54:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=UithumxeWzYgScx9rLpMyD2GJqEdo81auVSNbfn9oiY=;
        b=f6PmxY+OolwFWG6Qlwyz2Vw3Fx3A+kmQsoP2kyPGcXtEWvliRhBV5iONwsB4PRtoHu
         HvtCtJiLV+XvTInlE90TtwWIowBizogvXcRXTobxU9eLqYTvBiNAsfyp4qIXeCRp7xR0
         LGoYy8e9/mmZW1JFe/3FVRueKfq8NbiHwb5Qg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=UithumxeWzYgScx9rLpMyD2GJqEdo81auVSNbfn9oiY=;
        b=B3jW6ObalKDPsi2uJ1unvsbn5ac5IYHzI9Z5pInGQnZlW/G1Hu+PKGZxOoXGjF6Z+n
         idEkvLsYjY87FN+NESCRdFnOcsluB2a6TaAPFjJE1XW23yq+24kHm8+kbdiAl5o6X6Pg
         loBaJn0LUR3kdl5YfatH/1qyekTKwQ8HNF4Qy3e2IHEvZ/KJsdHcGcMQ0w7LnSBpbRWN
         Ymu9D6DxoUyTO3sRpYejawqAxjZYgru+Uw46JJSScGwgMecY+sYvxBOk3vK9bWYLDjsI
         43lb89QDxczihI2vbNsa/a4n7gqA0pRfjT9LwY6acKCyiWGR648UDLlt9HCdrRUALtfA
         Tr6w==
X-Gm-Message-State: ANhLgQ3Wl5b1nSp55rvXj49IPDSfuUPLqWfgkwOrOkjb2pNIdSDvKdM6
        LYPZqNhBP1JiO1wP+ClmAHii8A==
X-Google-Smtp-Source: ADFU+vtVxwix/QuB6JjhX0awb1vybd4BvpFB+lIY68z69hOr/TCDPZBDyFJM31X5dKcZBJjdP0iwtw==
X-Received: by 2002:a1c:7c08:: with SMTP id x8mr9227427wmc.71.1583412841132;
        Thu, 05 Mar 2020 04:54:01 -0800 (PST)
Received: from cloudflare.com ([176.221.114.230])
        by smtp.gmail.com with ESMTPSA id i18sm41145017wrv.30.2020.03.05.04.54.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2020 04:54:00 -0800 (PST)
References: <20200304101318.5225-1-lmb@cloudflare.com> <20200304101318.5225-10-lmb@cloudflare.com>
User-agent: mu4e 1.1.0; emacs 26.3
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     Lorenz Bauer <lmb@cloudflare.com>
Cc:     john.fastabend@gmail.com, Shuah Khan <shuah@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        kernel-team@cloudflare.com, linux-kselftest@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v3 09/12] selftests: bpf: don't listen() on UDP sockets
In-reply-to: <20200304101318.5225-10-lmb@cloudflare.com>
Date:   Thu, 05 Mar 2020 13:53:59 +0100
Message-ID: <878skfynbs.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Mar 04, 2020 at 11:13 AM CET, Lorenz Bauer wrote:
> Most tests for TCP sockmap can be adapted to UDP sockmap if the
> listen call is skipped. Rename listen_loopback, etc. to socket_loopback
> and skip listen() for SOCK_DGRAM.
>
> Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
> ---

FWIW, Go has net.ListenUDP so I don't think it would be very confusing
to leave the helper name as is.

Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>

[...]
