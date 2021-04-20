Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1867F365189
	for <lists+bpf@lfdr.de>; Tue, 20 Apr 2021 06:33:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbhDTEd6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 20 Apr 2021 00:33:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbhDTEd5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 20 Apr 2021 00:33:57 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0F31C06174A
        for <bpf@vger.kernel.org>; Mon, 19 Apr 2021 21:33:26 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id g38so41450660ybi.12
        for <bpf@vger.kernel.org>; Mon, 19 Apr 2021 21:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gC5sBFCezGDYCf4dzqAF3OCevXLYTjUs+EzuB2anIAo=;
        b=pGBFperJaCTcumJPERXD14GCAuX2ajLKgXTPzNwcZIdxdkifVIEMpEvCldwtNBTHud
         d3UZzsmxx5mS6LTPKMjOP7oR76lbeMl8Ii2rQDjPn7oToI3ORc51ol+rGv11CWXC0FXp
         nt936hiFm2VYjHXVYYWlhydKQ4BFdqLMyjRbS0G5JIO/r1OSgDQ+d2E9NahmZkKGpWB4
         J5dzyPcl3eolbPdGQs3S2vMgVufgBIMjFtrpcA7peR8V2SdD/xriEiuPbgE6n8+K73Ba
         BacvNchj6gewGi+1AgfoOiMM+f/wZKazI7IKznkP23FqZb2KX+nGFKmboh8X8OTSBEQT
         nt0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gC5sBFCezGDYCf4dzqAF3OCevXLYTjUs+EzuB2anIAo=;
        b=qd94uEjzia4R+MR/BAGAmYxBmWxGtJpTvYgCP1oBISsnNbcLZs3baPYvRQP56N3YDv
         jUcOsmHmRgrzBPuzG1NApGZ2oEHf5njvV3p4XKMsRs7DgDJ/RxMnrgEQtsRu+cHlt+YZ
         AompOH5M3/xmGxgJUWn7KL9DdJcQ162B9muT5l8CIrAww3VbpekbXgXyra4QTiPJllsR
         zrziQADwAtkjOm/T466MfIgmDXWZuR6orkQXUFDY+lcRAZtB+PmXtAsJ2+hYAW7Hq0ae
         sgk5tvhDUJAo5SkRjbkgHnItWZkE1UFQT37O2US0AR9mW72D+yciLee5s9+o2ySMWLJt
         ++Ng==
X-Gm-Message-State: AOAM531oYLu6697hJMW7daT+ncHwyNp0JjbD8ZhUbp7HAj8PiNyotfav
        bRQLl324DKCgiVExbx+3OU0O6GKI6a4kjt3+q84=
X-Google-Smtp-Source: ABdhPJzewL8rCb6ckiusssbdhVxJ4ySnUKc1uhOYKrmYx9y8Er+wiejWA8w/rELvu5ePSZAMAQoESUAmZ9v5PCSTyEg=
X-Received: by 2002:a25:ae8c:: with SMTP id b12mr22553699ybj.347.1618893206099;
 Mon, 19 Apr 2021 21:33:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210416154803.37157-1-chendotjs@gmail.com>
In-Reply-To: <20210416154803.37157-1-chendotjs@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 19 Apr 2021 21:33:15 -0700
Message-ID: <CAEf4BzbN0Oz8aTXb39fjXfPyJvuR7syhRSLpO7HW-X1uRcuGbw@mail.gmail.com>
Subject: Re: [PATCH bpf] samples/bpf: Fix broken tracex1 due to kprobe
 argument change
To:     Yaqi Chen <chendotjs@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Apr 16, 2021 at 8:48 AM Yaqi Chen <chendotjs@gmail.com> wrote:
>
> From commit c0bbbdc32feb ("__netif_receive_skb_core: pass skb by
> reference"), the first argument passed into __netif_receive_skb_core
> has changed to reference of a skb pointer.
>
> This commit fixes by using bpf_probe_read_kernel.
>
> Signed-off-by: Yaqi Chen <chendotjs@gmail.com>
> ---
>  samples/bpf/tracex1_kern.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/samples/bpf/tracex1_kern.c b/samples/bpf/tracex1_kern.c
> index 3f4599c9a202..ef30d2b353b0 100644
> --- a/samples/bpf/tracex1_kern.c
> +++ b/samples/bpf/tracex1_kern.c
> @@ -26,7 +26,7 @@
>  SEC("kprobe/__netif_receive_skb_core")
>  int bpf_prog1(struct pt_regs *ctx)

This is a good opportunity to use BPF_KPROBE from bpf_tracing.h
helper. It would look like:

SEC("kprobe/__netif_receive_skb_core")
int BPF_KPROBE(struct sk_buff **pskb, bool pfmemalloc, struct
packet_type **ppt_prev)
{

    /* and here you'll be able to read sk_buff pointer as */
    bpf_probe_read_kernel(&skb, sizeof(skb), pskb);

}


>  {
> -       /* attaches to kprobe netif_receive_skb,
> +       /* attaches to kprobe __netif_receive_skb_core,
>          * looks for packets on loobpack device and prints them
>          */
>         char devname[IFNAMSIZ];
> @@ -35,7 +35,7 @@ int bpf_prog1(struct pt_regs *ctx)
>         int len;
>
>         /* non-portable! works for the given kernel only */
> -       skb = (struct sk_buff *) PT_REGS_PARM1(ctx);
> +       bpf_probe_read_kernel(&skb, sizeof(skb), (void *)PT_REGS_PARM1(ctx));
>         dev = _(skb->dev);
>         len = _(skb->len);
>
> --
> 2.18.4
>
