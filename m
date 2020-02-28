Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A6561736B4
	for <lists+bpf@lfdr.de>; Fri, 28 Feb 2020 12:57:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725856AbgB1L5m (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 28 Feb 2020 06:57:42 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:37164 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbgB1L5m (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 28 Feb 2020 06:57:42 -0500
Received: by mail-oi1-f195.google.com with SMTP id q84so2602443oic.4
        for <bpf@vger.kernel.org>; Fri, 28 Feb 2020 03:57:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1O4obvVvKLAwYYBZM+AQ18LdV1elI7eXt7o1/gJyneQ=;
        b=sXAaF8iKjzcVlEHN6GDIFYKh23PMrguoxvSdGx6Lujp018XxheYcYLL7rsZM4Csk+w
         Om4Aa8PXO8quh0pWVWktNd/82+HGeq7Nk8b8m8ANvhvZ2S/8grnDlVpcw1mgS+YgTj7Q
         B8uInsbu6ihoXH6bS+ZQzWxxRCWfCgB+O7D2A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1O4obvVvKLAwYYBZM+AQ18LdV1elI7eXt7o1/gJyneQ=;
        b=Olc/YdFOr7HeyBi0tbxlgRySQERh7fy3SWAbwPfM+wYcWUmWD43vrH+OSAlXHvkWCD
         lcOmQUIYNq78KD9bi3Hq/QgnEHgIhwilLRtwOptpQX889vxqe322XUN8OINTVYLgpFuf
         K80u0WaaEKRHvqjR4NbVnMKXYA5pIYPPX4xjyutlH2YC7NJoRwUiD0rJiUDH/FSlBczE
         BtBsKoLihu6IVIkx1IcSI0TI2SlUdK1RHLmo3TyIxQ0+RBrrN/pXc+8WRsPftgsHes/2
         BuhcipggYCAwsf3rwto/YrMnGjvgfJ0aCOx832Mc6GqY9Moxi877auU3YcyABsXLj23i
         LrEA==
X-Gm-Message-State: APjAAAXRgbJUZqFuW1d71XsU6eL/NYPPEVEz+mxlT6EkXT3JlEAbAdZx
        VYN8KtIN+h90znTwnh2KP6Fcn/EOlmIcTulAHi8Reg==
X-Google-Smtp-Source: APXvYqxeftFzsjngny/QmHkgG9u1BgJecAi1sQEe5ZTVX1cMxK5TGRlqNi+LjOyAtoq5c61t9HYu79xVQLUtmbxEqEQ=
X-Received: by 2002:aca:d4c1:: with SMTP id l184mr2883630oig.172.1582891060661;
 Fri, 28 Feb 2020 03:57:40 -0800 (PST)
MIME-Version: 1.0
References: <20200228115344.17742-1-lmb@cloudflare.com>
In-Reply-To: <20200228115344.17742-1-lmb@cloudflare.com>
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Fri, 28 Feb 2020 11:57:29 +0000
Message-ID: <CACAyw9-vUxeyVq-yktXwuTKX6NoEFiX-y88U_751umVviqOSvQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 0/9] bpf: sockmap, sockhash: support storing
 UDP sockets
To:     John Fastabend <john.fastabend@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     kernel-team <kernel-team@cloudflare.com>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 28 Feb 2020 at 11:54, Lorenz Bauer <lmb@cloudflare.com> wrote:
>
> Thanks for all the reviews so far! I've fixed the identified bug and addressed
> feedback as much as possible.

This should've been a reply to
https://lore.kernel.org/bpf/20200225135636.5768-1-lmb@cloudflare.com/
"[PATCH bpf-next 0/7] bpf: sockmap, sockhash: support storing UDP sockets"

Sorry!

-- 
Lorenz Bauer  |  Systems Engineer
6th Floor, County Hall/The Riverside Building, SE1 7PB, UK

www.cloudflare.com
