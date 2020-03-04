Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9A4A1786CD
	for <lists+bpf@lfdr.de>; Wed,  4 Mar 2020 01:03:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727823AbgCDADc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 3 Mar 2020 19:03:32 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42590 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727604AbgCDADb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 3 Mar 2020 19:03:31 -0500
Received: by mail-pg1-f196.google.com with SMTP id h8so72285pgs.9;
        Tue, 03 Mar 2020 16:03:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Cg+Bk6p3ng/oCqeB9jAP5HpcQ6wBIVVyIyzT0MMNq0k=;
        b=Wtdw/bpDAHegTWVPqPiInwTRdc+XxDNKZV5OyxUdLlV7JnWYcKCYo5WwcOqZBwoZgR
         lCMRDanCykEaZjdNDLpO9T5CqO7BcZg7jnRfbK4HKgL0nmUTQbR2CSv9dU3LQrWdftHN
         Ok2JGkqTvgMzihWyEv4rDsCvtgunV7D2BpPu2+FdHSA61Fo2ozHR7we/hDStKntnGNU3
         yTaKQw5sIuR7Mb+sPgJue9DY26rhlMPuqGcVxhT3opQ9hKRVyjtmJ3Za+jzdRN06xyaY
         5raGwMxS83abexPR9tjLNaRRvARn3H7mJcJfNYoQCe0IT9YYvseds7bNeO9X1HksqvWl
         hFLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Cg+Bk6p3ng/oCqeB9jAP5HpcQ6wBIVVyIyzT0MMNq0k=;
        b=pkHhtqN1ljR9QQrxQUrQDLnvnDZyfQtO0gCdy1JpjHjVOdKsNhvpuMeAWpg05ImXAS
         hOHFdB2HTfn1lLI6wGkgAiciYAXpFizqhQ+Z+koarU1Wl3FpDR86/Ae6n4q/49i46JWf
         VPeDweelFt59hQmtoTF0QPC15+CKPW0hdjS7L+/RxGpjP+FhqwIvICEo0lThUQPgfqNm
         fh7Awy8vicFbfvvk/W7pyxGkYrcdBO0kL5DmaaznaB522UcBZ/d9Y6bDJg2oi09FT7FG
         lGNS9PNaqTCFYinPFTR5yKSCdYFFENMuMGZF95WA2Oh5Xx6vBETdgABeC3zzp+xVtciZ
         or2A==
X-Gm-Message-State: ANhLgQ0LINO0jpmCgd+kWaHnkPF9YRnx4AisherIovrOSXhodLW1o7XR
        ceKpHKi4y50cw6JYu4LfllA=
X-Google-Smtp-Source: ADFU+vvLke/PQpWmYNEZBsbhWp2sSTWm813w2K3TO0HseVYhvp+AY3D8KiClhK8qArj0CeTWoS6W/g==
X-Received: by 2002:a63:4103:: with SMTP id o3mr5683444pga.199.1583280210838;
        Tue, 03 Mar 2020 16:03:30 -0800 (PST)
Received: from ast-mbp ([2620:10d:c090:500::4:a0de])
        by smtp.gmail.com with ESMTPSA id z22sm4937779pgn.19.2020.03.03.16.03.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Mar 2020 16:03:29 -0800 (PST)
Date:   Tue, 3 Mar 2020 16:03:27 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     KP Singh <kpsingh@chromium.org>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Paul Turner <pjt@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>
Subject: Re: [PATCH bpf-next 4/7] bpf: Attachment verification for
 BPF_MODIFY_RETURN
Message-ID: <20200304000326.nk7jmkgxazl3umbh@ast-mbp>
References: <20200303140950.6355-1-kpsingh@chromium.org>
 <20200303140950.6355-5-kpsingh@chromium.org>
 <CAEf4BzaviDB+WGUsg1+aO5GAtkJuQ6aYSiB8VaKL0CoQRPs8Xw@mail.gmail.com>
 <20200303232151.GB17103@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200303232151.GB17103@chromium.org>
User-Agent: NeoMutt/20180223
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Mar 04, 2020 at 12:21:51AM +0100, KP Singh wrote:
> 
> > > +                       t = btf_type_skip_modifiers(btf, t->type, NULL);
> > > +                       if (!btf_type_is_int(t)) {
> > 
> > Should the size of int be verified here? E.g., if some function
> > returns u8, is that ok for BPF program to return, say, (1<<30) ?
> 
> Would this work?
> 
>        if (size != t->size) {
>                bpf_log(log,
>                        "size accessed = %d should be %d\n",
>                        size, t->size);
>                return false;
>        }

It will cause spurious failures later when llvm optimizes
if (ret & 0xff) into u8 load.
I think btf_type_is_int() is enough as-is.
