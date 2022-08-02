Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8548F58842B
	for <lists+bpf@lfdr.de>; Wed,  3 Aug 2022 00:22:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235746AbiHBWVj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 2 Aug 2022 18:21:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235109AbiHBWVe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 2 Aug 2022 18:21:34 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10F324D4D0
        for <bpf@vger.kernel.org>; Tue,  2 Aug 2022 15:21:33 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id kb8so13762730ejc.4
        for <bpf@vger.kernel.org>; Tue, 02 Aug 2022 15:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2569Gxx+GDQENqO7oEPW3Og0TXSw7Cdv7yYuINa7H9g=;
        b=ACPkihtYTpzzdKFU4JagcHyCE7yTitZ/wB32rMYrXBJubFweNVdHvmZJWdWKPSw6du
         1f5uyXZ/2Yg0MUexxDqBVkCpyU1dJivpqdnOfPu+M1c9ZCJmyXfFRtUAHegjzj1om4xY
         ZxIp/TEcEqx+QvI1YJvfXOczZBrHnB1tkX7d1iM93e0fAtjaoiqqqGgLQFEU1/a2U9c7
         5XuALbI4gWTp2lO9tOC+Pvv+0HNU68DuZGCmVMGo9/P7g/CRWVBykSclmoxjhmgo+1Uu
         S8sxnoqvKZzJ2U6+AMLdtTYEl2Za0o69gVESfQTp8lCqbWgWsUAkrgIagK1p283MUvXG
         Y+pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2569Gxx+GDQENqO7oEPW3Og0TXSw7Cdv7yYuINa7H9g=;
        b=aSfUttxy6FwpKQTbSgsLzGrD4WYLG2H0ectl7N8dwUcBsvoNxzSDaApMwbhTbDPEnn
         1tuhp+n2iESYWqKyDTI+/ORXAwH+wqutrZBb9SFOM6+fShlmP21DbRzMAftF8rAuxRsZ
         eH3bzpAs8JfyNRPeuQs6m3YMjRmZkI/qsnjN5fnBri7pYVO8ZNMAq9E2x9tGMzqysX5z
         hn8azqOB2F/aDW/xVFfZxCh/7TcuOYisMmbTuVgQocHWiWRAnlYqqPCrQlpFBbSwn1tc
         DW7yJnpgpBCEvmFt0CGXg2SguuaLM0ZYGNiIvhVQWiybRJRyy3/CqdX7CeVIGsFqtmEP
         9N+Q==
X-Gm-Message-State: ACgBeo0vnfmzyK4ubgGOPHFaA+Nx84+Nf2pxPLKheSlZ+R75MhMk0poP
        RzfThrAX77OgPeY0482tAwJO/ZmrWuXL888oK0g=
X-Google-Smtp-Source: AA6agR52F4t9onfQJNQcidW5nUWMtfCrqkE7RmJwDUMQf+0IGhm3OrMaPbfE5DkBQykGo844L9dYbiIU+qi0o3L5xok=
X-Received: by 2002:a17:907:8687:b0:730:7c7b:b9ce with SMTP id
 qa7-20020a170907868700b007307c7bb9cemr9505407ejc.656.1659478891682; Tue, 02
 Aug 2022 15:21:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220726184706.954822-1-joannelkoong@gmail.com>
 <20220726184706.954822-4-joannelkoong@gmail.com> <CAADnVQJiA+Ari7_MmBLgNSDPoCY_wmQTdE9oqCX1DGqo6nVXxw@mail.gmail.com>
In-Reply-To: <CAADnVQJiA+Ari7_MmBLgNSDPoCY_wmQTdE9oqCX1DGqo6nVXxw@mail.gmail.com>
From:   Joanne Koong <joannelkoong@gmail.com>
Date:   Tue, 2 Aug 2022 15:21:20 -0700
Message-ID: <CAJnrk1ZV4xLXG1kozt3tCyZAdPyAe-W7u6EuyR2btWEta5rQ-w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 3/3] selftests/bpf: tests for using dynptrs to
 parse skb and xdp buffers
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Aug 1, 2022 at 12:12 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Jul 26, 2022 at 11:48 AM Joanne Koong <joannelkoong@gmail.com> wrote:
> >
> >
> > -static __always_inline int handle_ipv4(struct xdp_md *xdp)
> > +static __always_inline int handle_ipv4(struct xdp_md *xdp, struct bpf_dynptr *xdp_ptr)
> >  {
> > -       void *data_end = (void *)(long)xdp->data_end;
> > -       void *data = (void *)(long)xdp->data;
> > +       struct bpf_dynptr new_xdp_ptr;
> >         struct iptnl_info *tnl;
> >         struct ethhdr *new_eth;
> >         struct ethhdr *old_eth;
> > -       struct iphdr *iph = data + sizeof(struct ethhdr);
> > +       struct iphdr *iph;
> >         __u16 *next_iph;
> >         __u16 payload_len;
> >         struct vip vip = {};
> > @@ -90,10 +90,12 @@ static __always_inline int handle_ipv4(struct xdp_md *xdp)
> >         __u32 csum = 0;
> >         int i;
> >
> > -       if (iph + 1 > data_end)
> > +       iph = bpf_dynptr_data(xdp_ptr, ethhdr_sz,
> > +                             iphdr_sz + (tcphdr_sz > udphdr_sz ? tcphdr_sz : udphdr_sz));
> > +       if (!iph)
> >                 return XDP_DROP;
>
> dynptr based xdp/skb access looks neat.
> Maybe in addition to bpf_dynptr_data() we can add helper(s)
> that return skb/xdp_md from dynptr?
> This way the code will be passing dynptr only and there will
> be no need to pass around 'struct xdp_md *xdp' (like this function).

Great idea! I'll add this to v2.

>
> Separately please keep the existing tests instead of converting them.
> Either ifdef data/data_end vs dynptr style or copy paste
> the whole test into a new .c file. Whichever is cleaner.

Will do for v2.
