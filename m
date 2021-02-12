Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48798319CE4
	for <lists+bpf@lfdr.de>; Fri, 12 Feb 2021 11:58:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbhBLK45 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 12 Feb 2021 05:56:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230046AbhBLK4u (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 12 Feb 2021 05:56:50 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CCB4C061756
        for <bpf@vger.kernel.org>; Fri, 12 Feb 2021 02:56:05 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id d3so12446001lfg.10
        for <bpf@vger.kernel.org>; Fri, 12 Feb 2021 02:56:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=CAkkLOKngu+Jc3JoTm4wPpx55O5hNhsMoyStJXl6bds=;
        b=oN7T9aNQmC1TCApEnIUDuMxi9z6UPMfQxolVbn4QymqzC14ZoLAFyIE5287gz3lP0c
         OMv6NjpK1knSOtxrcUn4tKEISgxIxmaPQljgsyMvXey0+ivZPuoeq4ysDCfjtb62XrF1
         7JqjsxZq+O5FaYPn/6hu6DOE00G7XAVnqCHDs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=CAkkLOKngu+Jc3JoTm4wPpx55O5hNhsMoyStJXl6bds=;
        b=PXRXjsJPMXL8Wl1t6X5oSZiKEslHqhX/aLpjqfL/n6eZwGIQO22Qb1IX0CSCfwpn9D
         B59nR9u5frlB9rTLSD0aJQqTsV2cy40i9wCkJkuLem2X00Ec4atuCoAqEEnhMYv0nC6W
         wWFpK2UUQA6xD/Ih6L4hrheKCG+YDfpGVbeb/02GPaFTLhNC4iRnruEfZuyi3lnLjUvp
         e6+76xFZFqRo58bl2K9YL4iUMJhuhvC90vUCXjx1tZDYkAq2yk4AQZqgvBTsLLOCza6j
         7vcXEuiFiCQZusXm2mzARDRp05vfTpO7qQescVhskJZJBLBSh02AqOduUq0j3J15soc/
         mpQg==
X-Gm-Message-State: AOAM532qhdQsyrsAY9mnMr99fNramwWoRr7UBk9LXd2K5KNqoNeSqEHr
        W7z8UfSwgFQLI2wDbGQq0NiLDkpMQpKQnK5NAsXIiA==
X-Google-Smtp-Source: ABdhPJx54NF/0vvohURVv6r0D2jQTrSh1ThkawLAat3i3tXEkfvhWL4xmJpm+FdFoTV8SZo6UW4Ri1xj+ViFfT6wn+Y=
X-Received: by 2002:a19:711e:: with SMTP id m30mr186282lfc.97.1613127363501;
 Fri, 12 Feb 2021 02:56:03 -0800 (PST)
MIME-Version: 1.0
References: <20210210022136.146528-1-xiyou.wangcong@gmail.com> <20210210022136.146528-4-xiyou.wangcong@gmail.com>
In-Reply-To: <20210210022136.146528-4-xiyou.wangcong@gmail.com>
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Fri, 12 Feb 2021 10:55:52 +0000
Message-ID: <CACAyw98ABpLzjjw9zMdttgRWvim=oOqAZrDaXrLQ49eYhVsbJQ@mail.gmail.com>
Subject: Re: [Patch bpf-next v2 3/5] bpf: compute data_end dynamically with
 JIT code
To:     Cong Wang <xiyou.wangcong@gmail.com>
Cc:     Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        duanxiongchun@bytedance.com, wangdongdong.6@bytedance.com,
        jiang.wang@bytedance.com, Cong Wang <cong.wang@bytedance.com>,
        Jakub Sitnicki <jakub@cloudflare.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 10 Feb 2021 at 02:22, Cong Wang <xiyou.wangcong@gmail.com> wrote:
>
> From: Cong Wang <cong.wang@bytedance.com>
>
> Currently, we compute ->data_end with a compile-time constant
> offset of skb. But as Jakub pointed out, we can actually compute
> it in eBPF JIT code at run-time, so that we can competely get
> rid of ->data_end. This is similar to skb_shinfo(skb) computation
> in bpf_convert_shinfo_access().
>
> Suggested-by: Jakub Sitnicki <jakub@cloudflare.com>
> Cc: John Fastabend <john.fastabend@gmail.com>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Lorenz Bauer <lmb@cloudflare.com>
> Signed-off-by: Cong Wang <cong.wang@bytedance.com>

...

> @@ -9520,6 +9510,29 @@ static u32 sock_ops_convert_ctx_access(enum bpf_ac=
cess_type type,
>         return insn - insn_buf;
>  }
>
> +static struct bpf_insn *bpf_convert_data_end_access(const struct bpf_ins=
n *si,
> +                                                   struct bpf_insn *insn=
)

Is it worth adding a reference to this function in skb_headlen(),
since we're basically open coding that function here?

> +{
> +       /* si->dst_reg =3D skb->data */
> +       *insn++ =3D BPF_LDX_MEM(BPF_FIELD_SIZEOF(struct sk_buff, data),
> +                             si->dst_reg, si->src_reg,
> +                             offsetof(struct sk_buff, data));
> +       /* AX =3D skb->len */
> +       *insn++ =3D BPF_LDX_MEM(BPF_FIELD_SIZEOF(struct sk_buff, len),
> +                             BPF_REG_AX, si->src_reg,
> +                             offsetof(struct sk_buff, len));
> +       /* si->dst_reg =3D skb->data + skb->len */
> +       *insn++ =3D BPF_ALU64_REG(BPF_ADD, si->dst_reg, BPF_REG_AX);
> +       /* AX =3D skb->data_len */
> +       *insn++ =3D BPF_LDX_MEM(BPF_FIELD_SIZEOF(struct sk_buff, data_len=
),
> +                             BPF_REG_AX, si->src_reg,
> +                             offsetof(struct sk_buff, data_len));
> +       /* si->dst_reg =3D skb->data + skb->len - skb->data_len */
> +       *insn++ =3D BPF_ALU64_REG(BPF_SUB, si->dst_reg, BPF_REG_AX);
> +
> +       return insn;
> +}
> +
>  static u32 sk_skb_convert_ctx_access(enum bpf_access_type type,
>                                      const struct bpf_insn *si,
>                                      struct bpf_insn *insn_buf,
> @@ -9530,12 +9543,7 @@ static u32 sk_skb_convert_ctx_access(enum bpf_acce=
ss_type type,
>
>         switch (si->off) {
>         case offsetof(struct __sk_buff, data_end):
> -               off  =3D si->off;
> -               off -=3D offsetof(struct __sk_buff, data_end);
> -               off +=3D offsetof(struct sk_buff, cb);
> -               off +=3D offsetof(struct tcp_skb_cb, bpf.data_end);
> -               *insn++ =3D BPF_LDX_MEM(BPF_SIZEOF(void *), si->dst_reg,
> -                                     si->src_reg, off);
> +               insn =3D bpf_convert_data_end_access(si, insn);

This generates a new warning:

../net/core/filter.c: In function =E2=80=98sk_skb_convert_ctx_access=E2=80=
=99:
../net/core/filter.c:9542:6: warning: unused variable =E2=80=98off=E2=80=99=
 [-Wunused-variable]
 9542 |  int off;
      |      ^~~

--
Lorenz Bauer  |  Systems Engineer
6th Floor, County Hall/The Riverside Building, SE1 7PB, UK

www.cloudflare.com
