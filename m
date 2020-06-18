Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BD6A1FFBB3
	for <lists+bpf@lfdr.de>; Thu, 18 Jun 2020 21:22:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728173AbgFRTWL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 18 Jun 2020 15:22:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726925AbgFRTWK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 18 Jun 2020 15:22:10 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CAA0C06174E
        for <bpf@vger.kernel.org>; Thu, 18 Jun 2020 12:22:10 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id w16so7614582ejj.5
        for <bpf@vger.kernel.org>; Thu, 18 Jun 2020 12:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=65uaTcjGj6KJzSt81NABHM5UxmJ4cmO/brSilq94BNs=;
        b=eGczg7UyVwVPw6e7mTDzxFBmBRuBelkZTI7WPQHuLx9OXUZ5iTk/ZSNz7f0vhadKD6
         v6hrv2K+Jq2GE4hZhcfoqWSNtRQWjJmCY6vbLPA2UHfT7xAQHK4ZEKvB1U2Sadl4VVCQ
         Ya9q/Ww6vs3E7ZFIVTPMy+gcaoWRO+AVmLVkPfLa2lvwnGVFAKz9vJw3Hwi4RLPL2CrG
         jEkjRp2HorrFQNmDE2D8uc+eLeo2iRY0h64WzD/GMroYRYhtnldhdOje96ZIeh8r/yfw
         +Rx4wCner3KbPM2smKnuVTNMI0eo87cUTbUIivL+m+KtpUVngFLuTu00wgdYqgW0RNmN
         S/Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=65uaTcjGj6KJzSt81NABHM5UxmJ4cmO/brSilq94BNs=;
        b=YSyP6YKnVwpOFlQwn8u/RIEVBKTEE+GGz6B129LR/Foacobw7r8Y+vCC9BbV/hV192
         t9HIzAMiBlLNUprL05eLRLDJK2T/r++eyHAsOwhb3W09CURWLhuJf9ItKBBvzkr2ni7+
         5wLakYmNOhjlHWzYlw+4k3ydiInvOXYlDUPM1uODsWX8FtgNnRUvqgqaW0+6N8PgzmtG
         irTgT39h60RX7CuL6p2IG8Q71PSCIMS27Mv6loE+0LT/nmLoI/8xNlf2eTE/YRmZ/7vu
         5tAXsDZjnLVcVixO6zi0c3JajSKC63xSg4z2suReefF3xiZtsX8YNiDol1Fl/LLGL9KB
         HWHg==
X-Gm-Message-State: AOAM531Uq0fztJZB8PXcqwyrjPVTXK6PoqRu3v1emYpzZdx/raBusozx
        +HdnHjYvXpTIzm89UbKs+sGYs98ahLVFAj27QA4=
X-Google-Smtp-Source: ABdhPJzgZ0nHf6D4O13o3/R79N/cJPGWIfBiAcqS8w7tbF72lyRfKBT10DYc275ESagCwXuLv2+Qn9bwGPJZFtskixE=
X-Received: by 2002:a17:906:7751:: with SMTP id o17mr200196ejn.111.1592508128909;
 Thu, 18 Jun 2020 12:22:08 -0700 (PDT)
MIME-Version: 1.0
References: <CAHo-OoxJ6XBrBDXUxhCr0J58eOGq3FZu5+Rg6GLeeCjThrA8rg@mail.gmail.com>
 <CAADnVQKXbd986SrW2u4nxY-0nNuC7VoVM29=3LeD9potOJTdZQ@mail.gmail.com>
 <CAHo-Ooz4smKgTDTit4NAnaasUDLJLkX7iRcYouv4KY=AG5SUaA@mail.gmail.com> <CALAqxLXgnqSM16=a3O1NyqYae1n_rMyw4_hcx5APm9s-h3TBtQ@mail.gmail.com>
In-Reply-To: <CALAqxLXgnqSM16=a3O1NyqYae1n_rMyw4_hcx5APm9s-h3TBtQ@mail.gmail.com>
From:   =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <zenczykowski@gmail.com>
Date:   Thu, 18 Jun 2020 12:21:58 -0700
Message-ID: <CAHo-OoyU5OHQuqpTEo-uAQcwcLpzkXezFY6Re-Hv6jGM9aSFSA@mail.gmail.com>
Subject: Re: capable_bpf_net_admin()
To:     John Stultz <john.stultz@linaro.org>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        BPF Mailing List <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Amit Pundir <amit.pundir@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Ok so I think

> +       if (is_net_admin_prog_type(type) && !capable(CAP_NET_ADMIN))
> +               return -EPERM;

should be

> +       if (is_net_admin_prog_type(type) && !capable(CAP_NET_ADMIN) && !capable(CAP_SYS_ADMIN))
> +               return -EPERM;

and presumably similar change just below that for perfmon.
