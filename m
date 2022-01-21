Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 077BC496460
	for <lists+bpf@lfdr.de>; Fri, 21 Jan 2022 18:47:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351824AbiAURrZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Jan 2022 12:47:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345647AbiAURrZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Jan 2022 12:47:25 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04039C06173B
        for <bpf@vger.kernel.org>; Fri, 21 Jan 2022 09:47:25 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id w12-20020a17090a528c00b001b276aa3aabso14328604pjh.0
        for <bpf@vger.kernel.org>; Fri, 21 Jan 2022 09:47:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zvFsDR+E02Ju56BK/eKwxvObB317+aZgnTdHuFq5HKQ=;
        b=S+g+LN6IGpZqs7XHdexHZ5uJ+rLmBWkKdQLbN7wu79qawJNOilbP8+V2JuoZSUApOF
         7G7wArZX1odXLf3Yb3jVIeKmI9EOY12//vAEgcsGAeFedKezD6Ax5eH8QmQaJzn8tYIe
         fcAZg7ZnsVa+oKck8YyWYXW8+rqsucSBCui3YrZ1spbPZFYJwVRRLwcAv7VyHYhUJJfD
         2bJ9inE9+M9lzcy112tKqP/5d5vEhx2PDGfBUIKQSOaW3V0pzNQyVRuRyFfFOXnvVWbN
         fKMutERzAIJC6odAIChhNwrBw0XBT273yRA4y1H9adGh7Co6GevrtzPp/2PMXq+ARg5Z
         7jPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zvFsDR+E02Ju56BK/eKwxvObB317+aZgnTdHuFq5HKQ=;
        b=AvuP5WUHWYriS0ch4gwQf5LDM7v60l4lvIT6/I/Kk03Q7mL25UrKYbPNAP8dtRbK4F
         A7FnJJgXNhcKpGTDCYY+PoMEohRYhxGO4iVSwNLuqTS0lg7fS60ogvIJ+E1SJf4BCpLc
         u/7UfkDrjtwPb3ab4bIOERRsgkaSpsGBRmrTRsJXVAk6JvtoR6Yy2kMMT1cIHYJLMh5N
         jPLpsDtsHqzudH04OSeGNrmNLjnW4NvaQDm6Yqz3herMrBXZvdpSCcIIzzyFaW2s5Tzf
         2eEftQLtPeg7TtcXVmcdPoxyjDBKZIbx3Is1Iv7onoVKahc2K657kZq9ixZZdivDpSu1
         y0+Q==
X-Gm-Message-State: AOAM531rNmH2ZZkGSQRuovGvbwIV9ExDVNWYKIs8cm4zdZhuQbHkW4Qr
        lIkoCP/oJt6ZOmfE15+8+QJF4ZK+DU1+NRKHcUo=
X-Google-Smtp-Source: ABdhPJzJwNOQwE7xR+VtwPewSwBPGzoRmphp3/r5q5ozapLEb+qGtv6sRlghOmZowdxysNzvPBrnsAxPcF/MIIAn7IA=
X-Received: by 2002:a17:902:860c:b0:149:1017:25f0 with SMTP id
 f12-20020a170902860c00b00149101725f0mr4865421plo.116.1642787244213; Fri, 21
 Jan 2022 09:47:24 -0800 (PST)
MIME-Version: 1.0
References: <CAEf4Bzaen2f2njYOAJuyWot2YvXn0YV=2zBVyFZw=_CqJdggPw@mail.gmail.com>
 <20220121174145.3433628-1-kennyyu@fb.com>
In-Reply-To: <20220121174145.3433628-1-kennyyu@fb.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Fri, 21 Jan 2022 09:47:13 -0800
Message-ID: <CAADnVQKZa_rm3sybP=Rt4Nm-zYrv4s9XvF7PGDFTOBD-TDu23g@mail.gmail.com>
Subject: Re: [PATCH v5 bpf-next 1/3] bpf: Add bpf_access_process_vm() helper
To:     Kenny Yu <kennyyu@fb.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Gabriele <phoenix1987@gmail.com>, Yonghong Song <yhs@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jan 21, 2022 at 9:42 AM Kenny Yu <kennyyu@fb.com> wrote:
>
> Thanks for the suggestions! I'll go with the all-or-nothing approach to
> be consistent with `bpf_copy_from_user` and will make the following changes:
>
> * Return value: returns 0 on success, or negative error on failure.
> * If we had a partial read, we will memset the read bytes to 0 and return
>   -EFAULT

Not read bytes, but all bytes.
copy_from_user zeros leftover for us, but access_process_vm doesn't
do this on partial read.
