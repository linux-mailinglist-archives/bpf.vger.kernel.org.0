Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFE542C5E03
	for <lists+bpf@lfdr.de>; Thu, 26 Nov 2020 23:58:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391851AbgKZW6S (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 26 Nov 2020 17:58:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732801AbgKZW6R (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 26 Nov 2020 17:58:17 -0500
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5260FC0617A7
        for <bpf@vger.kernel.org>; Thu, 26 Nov 2020 14:58:17 -0800 (PST)
Received: by mail-lf1-x141.google.com with SMTP id a9so4564284lfh.2
        for <bpf@vger.kernel.org>; Thu, 26 Nov 2020 14:58:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QaDOiTzv7bYdMLTWXNj4oE28VVQBAWH2AlPKGR+E+eo=;
        b=SaadWWvtWjDmQJF+g83I57GsOtBRiaSkSsV6m7Aw0E6ectfQcDqBDC8hUH1MK8TeNr
         6VIWKhr0DinotXc0Dpiy9jeb1R6of6uACiO8yNRzwCtQgTqzGcuPnIkwz1RD1w7q7eVC
         7znuCxydQzXvCSdP/cAZv44g8TfAXjMNQbHzU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QaDOiTzv7bYdMLTWXNj4oE28VVQBAWH2AlPKGR+E+eo=;
        b=PyN3cpjEjnK/kWOaQyW0mWljcZPEowH+4Sj7qfoBJ6dkHVXm5dJdGu2lImRfoCuTwW
         89oOCX1EbEsNun/YRpJYjg4n7vrejrZPDU0l8Sdsnp75P01FV6/duL8aNwRRShGuukE9
         KdJ0AH+OiUBGKcpCohaCdAD/S2itr6HBubAs5A8z174/MIhrM1Lfha9gxd27HSIMniPX
         GNsiv0xza7LLrR7eZgjZTE6RnfSb/nC9xvi7/8T+2IuGQiQtqEBeSW5c8UZtOhhPBmWz
         UanOZDhADODWr12yFMWDxyvu41UJWtxb7Dz6lwdlBP6pF56tLA0+eG4ruQyLD+0VgA0h
         Ek5A==
X-Gm-Message-State: AOAM5335ZlKl6hSoAZMEk48Qjq6EiaMM4vB9zWpzQapD2CFOnkWLXrCm
        znqTg2iNvg/Ji4dlhCXk38DyGmp/V9TymUXgQB2KzA==
X-Google-Smtp-Source: ABdhPJzwIixXgMfP9Xlb2QJc7RM7bfwkIDUDIt/rwlFzyf7GHGqD1RyaKJhK2IYOk9lvUhuKE8yyIuMFPLZIDr2r9vc=
X-Received: by 2002:a19:f114:: with SMTP id p20mr2216142lfh.146.1606431494290;
 Thu, 26 Nov 2020 14:58:14 -0800 (PST)
MIME-Version: 1.0
References: <20201126164449.1745292-1-revest@google.com>
In-Reply-To: <20201126164449.1745292-1-revest@google.com>
From:   KP Singh <kpsingh@chromium.org>
Date:   Thu, 26 Nov 2020 23:58:03 +0100
Message-ID: <CACYkzJ6QEmUzNfWCFoffOy1YY_qBR+Qw74DT+FddQMkm+ZpSEw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/6] net: Remove the err argument from sock_from_file
To:     Florent Revest <revest@chromium.org>
Cc:     bpf <bpf@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Florent Revest <revest@google.com>,
        open list <linux-kernel@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Nov 26, 2020 at 5:45 PM Florent Revest <revest@chromium.org> wrote:
>
> Currently, the sock_from_file prototype takes an "err" pointer that is
> either not set or set to -ENOTSOCK IFF the returned socket is NULL. This
> makes the error redundant and it is ignored by a few callers.
>
> This patch simplifies the API by letting callers deduce the error based
> on whether the returned socket is NULL or not.
>
> Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
> Signed-off-by: Florent Revest <revest@google.com>

Reviewed-by: KP Singh <kpsingh@google.com>
