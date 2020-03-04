Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82660179311
	for <lists+bpf@lfdr.de>; Wed,  4 Mar 2020 16:13:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387497AbgCDPNl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 4 Mar 2020 10:13:41 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38024 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726748AbgCDPNl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 4 Mar 2020 10:13:41 -0500
Received: by mail-wr1-f67.google.com with SMTP id t11so2845826wrw.5
        for <bpf@vger.kernel.org>; Wed, 04 Mar 2020 07:13:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=fsgJGQMpQ1G9tftbB0Mps00ljMhlrkE3dAL7nSnd3vo=;
        b=SUIT7ybvralMQlOhJIjHu6ly0ZrFuMBji/zcuoM0lUme2+qnQIfCnvpMGvJy4bjzqE
         jjLsZAJziFoMM3AKjRXlddNWJPUuwwfWaOPOVzfgJtf0tPyS9kXqW/KaApFrz19w6HHu
         nskZiLoYB7+X9+SdAd9lrYl3Rtsa3eW2hwYXI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=fsgJGQMpQ1G9tftbB0Mps00ljMhlrkE3dAL7nSnd3vo=;
        b=peFQotgysZkkw7OZP4RyhNvjgTvjfIsW+v4w2JKzf9XNypwbEJpazsmLvexxdJsviu
         gYs59oIk8kXW67Ug6t4IoDEkrhlXu8IM9iHTNnJWDrxfnxab9P1FR2KWykZ28FfQKKT9
         V5/enFkIST5bmeoj4brqeGPs7SLYgZFzFnnKkdnthUZN6UGz4KLUUrovbrnb9d4KzzmF
         qWKvRW4NcAQIJW2NzzyJUye9IezEqJxdYlAnKCy2E6ZGFKklfPTA0iBczGf1qjCFWE8Q
         g9MxGDATh2PWRhZzmra5147wpQ8QSZSWK6vZVS27488ZtDaYLhN5rc0cKxIE3w8TD5Xq
         Ecqw==
X-Gm-Message-State: ANhLgQ0/Vp9MdL5HwQQlJXL4FpOljf4lB1SexL6GD4Gn4Le5Y77dZ1/d
        YPpvna5DuAo0VEH52WiJ1wPZUQ==
X-Google-Smtp-Source: ADFU+vuLe5ALaEm7h3gtz45GbwJ5nu0Ea3aTrgxaP+bm5Zu/T7rBxy4ewEXTQPFiSC0nAd34IQszeA==
X-Received: by 2002:a5d:6086:: with SMTP id w6mr4494482wrt.224.1583334819160;
        Wed, 04 Mar 2020 07:13:39 -0800 (PST)
Received: from chromium.org ([2a00:79e1:abc:308:8ca0:6f80:af01:b24])
        by smtp.gmail.com with ESMTPSA id x13sm69264wmi.35.2020.03.04.07.13.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 07:13:38 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
X-Google-Original-From: KP Singh <kpsingh>
Date:   Wed, 4 Mar 2020 16:13:37 +0100
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     linux-security-module@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>
Subject: Re: [PATCH bpf-next v2 4/7] bpf: Attachment verification for
 BPF_MODIFY_RETURN
Message-ID: <20200304151337.GD9984@chromium.org>
References: <20200304015528.29661-1-kpsingh@chromium.org>
 <20200304015528.29661-5-kpsingh@chromium.org>
 <CAEf4BzZdR-PTFZT5VJ7kMw=FNhsCUpbQvdypEWSF1JNuaye6Kw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzZdR-PTFZT5VJ7kMw=FNhsCUpbQvdypEWSF1JNuaye6Kw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 03-Mär 21:12, Andrii Nakryiko wrote:
> On Tue, Mar 3, 2020 at 5:56 PM KP Singh <kpsingh@chromium.org> wrote:
> >
> > From: KP Singh <kpsingh@google.com>
> >
> > - Allow BPF_MODIFY_RETURN attachment only to functions that are:
> >
> >     * Whitelisted by for error injection i.e. by checking
> >       within_error_injection_list. Similar disucssions happened for the
> >       bpf_overrie_return helper.
> 
> 2 typos: discussions and bpf_override_return ;)

/me bows his head in shame ;) Fixed.

 -KP

> 
> >
> >     * security hooks, this is expected to be cleaned up with the LSM
> >       changes after the KRSI patches introduce the LSM_HOOK macro:
> >
> >         https://lore.kernel.org/bpf/20200220175250.10795-1-kpsingh@chromium.org/
> >
> > - The attachment is currently limited to functions that return an int.
> >   This can be extended later other types (e.g. PTR).
> >
> > Signed-off-by: KP Singh <kpsingh@google.com>
> > ---
> 
> Acked-by: Andrii Nakryiko <andriin@fb.com>
> 
> >  kernel/bpf/btf.c      | 28 ++++++++++++++++++++--------
> >  kernel/bpf/verifier.c | 31 +++++++++++++++++++++++++++++++
> >  2 files changed, 51 insertions(+), 8 deletions(-)
> >
> 
> [...]
