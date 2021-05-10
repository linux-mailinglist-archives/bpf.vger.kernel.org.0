Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67ABD37903F
	for <lists+bpf@lfdr.de>; Mon, 10 May 2021 16:09:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233446AbhEJOJ7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 10 May 2021 10:09:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244475AbhEJOEp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 10 May 2021 10:04:45 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFFADC06138E
        for <bpf@vger.kernel.org>; Mon, 10 May 2021 06:47:07 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id t4so24687884ejo.0
        for <bpf@vger.kernel.org>; Mon, 10 May 2021 06:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y090JTi5u7L+I2zANuVu8piJZcdJ8sLCVab3Loo8HmE=;
        b=Il76HL0QGBMxpyekRa88oVy+JUeZ43TQn0NZ2TMfuRFHZHX6ILVZUphgUPet3WV+yZ
         WupKE1kDUh8uWBEuf6Y6pcvdniqtR6uAMrLClBAxb9tR5OjAzjPL60OZLK36rw6mxctB
         nkVT17PqtqHU30rfWNAGs/xGf7NXjpMqa/VzTtoBpLlwYCVlBbO1Uo9ltJbisxGIlbQq
         tyfv5cLNSYZHt9x0a1Ro1/r8P4q/EskdDqQko+YNhiuQIo7w/U2+g/NQMHVqDL5ZWIR5
         Y6KjXPMz4yQ4HNrJbc83UbhnQxGVpx+lP47VVD1dQHq9Ou737laTgsOW4Di5lMpmx/bk
         kqXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y090JTi5u7L+I2zANuVu8piJZcdJ8sLCVab3Loo8HmE=;
        b=n8jKZ+FrN2mAxT2t81qhq3hYG5lVXMAUbIL6FB4AZWM1vvrjSONMbPOc9+vqFp/F0L
         gPAu8fgl8WhbSyEn/ZqXS45/xiMnB5WOZRo2wmyR1ZQetkb1PEpFE38kAxrlsAlAtPVh
         ozswR06hUQx75bHaMKwsMTa0KuuPy7vpbw/oJEOM+gZDelCRMnU0VepKmoANNwHdklPh
         /SXYz5VD7PYzJ3I/pvqRQsIz15QV+Qix2He8Ud/ZpJ6f5FsL8KTyz6DuNz8WqvU07XKb
         aZjN41oSGTD0HUH3Wi5jkHLYS/XHhl6RSEgXwtXVZtG1GPiHg/pMnSsTgQVdHdD+cdEe
         xc+A==
X-Gm-Message-State: AOAM533ICQ05guacwRx7pXAoLvyAs5iEYZTli9RYr5r5oV7TZdMR+s41
        N/jdGCD9rpbNQ1GRJII48zwRdDUPP9vhfQ==
X-Google-Smtp-Source: ABdhPJyiqZJWeorxtOhPgwBeJwERPjCXLQouayd0mFQb7ms4Zl0XlC/ASQmTjKfxdB4kRTwywOadXA==
X-Received: by 2002:a17:906:d18a:: with SMTP id c10mr25569352ejz.271.1620654426012;
        Mon, 10 May 2021 06:47:06 -0700 (PDT)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com. [209.85.221.47])
        by smtp.gmail.com with ESMTPSA id x18sm9531861eju.45.2021.05.10.06.47.04
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 May 2021 06:47:04 -0700 (PDT)
Received: by mail-wr1-f47.google.com with SMTP id d4so16690139wru.7
        for <bpf@vger.kernel.org>; Mon, 10 May 2021 06:47:04 -0700 (PDT)
X-Received: by 2002:adf:e750:: with SMTP id c16mr31309348wrn.50.1620654423753;
 Mon, 10 May 2021 06:47:03 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20210429102143epcas2p4c8747c09a9de28f003c20389c050394a@epcas2p4.samsung.com>
 <1619690903-1138-1-git-send-email-dseok.yi@samsung.com> <8c2ea41a-3fc5-d560-16e5-bf706949d857@iogearbox.net>
 <02bf01d74211$0ff4aed0$2fde0c70$@samsung.com> <CA+FuTScC96R5o24c-sbY-CEV4EYOVFepFR85O4uGtCLwOjnzEw@mail.gmail.com>
 <02c801d7421f$65287a90$2f796fb0$@samsung.com> <CA+FuTScUJwqEpYim0hG27k39p_yEyzuW2A8RFKuBndctgKjWZw@mail.gmail.com>
 <001801d742db$68ab8060$3a028120$@samsung.com> <CAF=yD-KtJvyjHgGVwscoQpFX3e+DmQCYeO_HVGwyGAp3ote00A@mail.gmail.com>
 <436dbc62-451b-9b29-178d-9da28f47ef24@huawei.com> <CAF=yD-+d0QYj+812joeuEx1HKPzDyhMpkZP5aP=yNBzrQT5usw@mail.gmail.com>
 <007001d7431a$96281960$c2784c20$@samsung.com> <CAF=yD-L9pxAFoT+c1Xk5YS42ZaJ+YLVQVnV+fvtqn-gLxq9ENg@mail.gmail.com>
 <00c901d74543$57fa3620$07eea260$@samsung.com> <CA+FuTSepShKoXUJo7ELMMJ4La11J6CsZggJWsQ5MB2_uhAi+OQ@mail.gmail.com>
In-Reply-To: <CA+FuTSepShKoXUJo7ELMMJ4La11J6CsZggJWsQ5MB2_uhAi+OQ@mail.gmail.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Mon, 10 May 2021 09:46:25 -0400
X-Gmail-Original-Message-ID: <CA+FuTSeyuUvKC==Mo7L+u3PS0BQyea+EdLLYjhGFrP7FQZsbEQ@mail.gmail.com>
Message-ID: <CA+FuTSeyuUvKC==Mo7L+u3PS0BQyea+EdLLYjhGFrP7FQZsbEQ@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: check for data_len before upgrading mss when 6
 to 4
To:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc:     Dongseok Yi <dseok.yi@samsung.com>,
        Yunsheng Lin <linyunsheng@huawei.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, May 10, 2021 at 9:19 AM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> > > That generates TCP packets with different MSS within the same stream.
> > >
> > > My suggestion remains to just not change MSS at all. But this has to
> > > be a new flag to avoid changing established behavior.
> >
> > I don't understand why the mss size should be kept in GSO step. Will
> > there be any issue with different mss?
>
> This issue has come up before and that has been the feedback from
> TCP experts at one point.
>
> > In general, upgrading mss make sense when 6 to 4. The new flag would be
> > set by user to not change mss. What happened if user does not set the
> > flag? I still think we should fix the issue with a general approach. Or
> > can we remove the skb_increase_gso_size line?
>
> Admins that insert such BPF packets should be aware of these issues.
> And likely be using clamping. This is a known issue.
>
> We arrived that the flag approach in bpf_skb_net_shrink. Extending
> that  to bpf_skb_change_proto would be consistent.

As for more generic approach: does downgrading to non-TSO by clearing
gso_size work for this edge case?
