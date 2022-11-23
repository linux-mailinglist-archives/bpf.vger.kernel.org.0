Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 485D663692D
	for <lists+bpf@lfdr.de>; Wed, 23 Nov 2022 19:44:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239231AbiKWSnW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 23 Nov 2022 13:43:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238557AbiKWSnV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 23 Nov 2022 13:43:21 -0500
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CBA920BC0
        for <bpf@vger.kernel.org>; Wed, 23 Nov 2022 10:43:20 -0800 (PST)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-14279410bf4so20021500fac.8
        for <bpf@vger.kernel.org>; Wed, 23 Nov 2022 10:43:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=c0t74MXl6nH5L2C+5sw1H3tquYD8JkWEtFmdTJPjP08=;
        b=idwkY7GHLVQ7hCCiDDUZmTd/EmSOwEt3N8+LRgjoF2Z//xfKlM4bQzfhWuGuErqyj+
         +tBUabl8xTyvc2upUjZ4Nede/EG/5NwvW2EleDlupjRZ1ySfAKD2BQjtQI2sK9Qz/kks
         IC4XjKevOqpTMjw7Vch9Imd3lsbsOeJf45NwRbwixhvBiQJXlzbCBimbVUai7V6ZdyI/
         98S2IiO+fkHjtnRB4l165Bku0ur/RoRDAH31KvtzeNnklsDv+gkZATMoh+JFG8B5Ozz2
         k5W6tBzMLSdNZQMiXHZyR4f21gcIHOHQ4gD/3geOvSy6aHLhxyv7YJbSvo1LQh81H2X3
         t/ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c0t74MXl6nH5L2C+5sw1H3tquYD8JkWEtFmdTJPjP08=;
        b=Fybc4UTroa89GF7WXIcegiOP3CoT+eVnLXkgw4RTWIbOd6oXA2O0BZ9uyuLAvGJ/Tq
         xZAOa1wrK0Jp2ORct0CCQKwxwQPc+1s8V0NorARPWXb/1f7mau9cWxQCRNO0DbBIgAd1
         zTsru75MQRdu/KBkXi/eznPU5GV7HD1LWIy3YGm8Nu4vM+Rgx1gNQ0TicbkDX+H0M0Fj
         A7VfIsZjXvLa+yVimD3NdWIrz7gLdy7gOzrNvYFpgtWlz8o2Fp94lk/7cOhlTQs3ThSS
         ug5tEc+n/jmTj49xFBYFfEXTfJiOf08QtGTgd7hq0+B4o7kSJqvbzSjqOUPff/IEU8Bq
         oUrQ==
X-Gm-Message-State: ANoB5pm0C9o9haCZNtwomjLnz/yN97ZSjZfjgGr7VuI6gcBR8ki4piK/
        ejBwf2ujwrtNvd56iHjy0XQJBaYSxFA5lxpFp5AzsA==
X-Google-Smtp-Source: AA0mqf77/PfMjTc7v4fLoFhXlO1WYQyFM3Eqep7QyKuDK32wM4Biw21WEAObp0qsqrz/4tlg0n6/6VHW0YtDnySK6Bk=
X-Received: by 2002:a05:6870:c18a:b0:142:870e:bd06 with SMTP id
 h10-20020a056870c18a00b00142870ebd06mr13974912oad.181.1669228999660; Wed, 23
 Nov 2022 10:43:19 -0800 (PST)
MIME-Version: 1.0
References: <20221121182552.2152891-1-sdf@google.com> <20221121182552.2152891-3-sdf@google.com>
 <ac5a7f9d-1bbf-db28-e494-44ac47a48fe6@linux.dev>
In-Reply-To: <ac5a7f9d-1bbf-db28-e494-44ac47a48fe6@linux.dev>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Wed, 23 Nov 2022 10:43:08 -0800
Message-ID: <CAKH8qBu5wvrQBXTEefLMAn72M1pp50785mauiDwrv-MNfxSZcQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/8] bpf: XDP metadata RX kfuncs
To:     Martin KaFai Lau <martin.lau@linux.dev>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, haoluo@google.com, jolsa@kernel.org,
        David Ahern <dsahern@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Willem de Bruijn <willemb@google.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Anatoly Burakov <anatoly.burakov@intel.com>,
        Alexander Lobakin <alexandr.lobakin@intel.com>,
        Magnus Karlsson <magnus.karlsson@gmail.com>,
        Maryam Tahhan <mtahhan@redhat.com>, xdp-hints@xdp-project.net,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Nov 22, 2022 at 10:34 PM Martin KaFai Lau <martin.lau@linux.dev> wrote:
>
> On 11/21/22 10:25 AM, Stanislav Fomichev wrote:
> > --- a/kernel/bpf/core.c
> > +++ b/kernel/bpf/core.c
> > @@ -2576,6 +2576,7 @@ static void bpf_prog_free_deferred(struct work_struct *work)
> >       } else {
> >               bpf_jit_free(aux->prog);
> >       }
> > +     dev_put(aux->xdp_netdev);
>
> I think dev_put needs to be done during unregister_netdevice event also.
> Otherwise, a loaded bpf prog may hold the dev for a long time.  May be there is
> ideas in offload.c.

Let me try to play with a veth pair to make sure the proper cleanup triggers.
I see your point that we now seemingly have to detach/unload the
program to trigger netdev cleanup..

> [ ... ]
>
> > diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> > index 35972afb6850..ece7f9234b2d 100644
> > --- a/kernel/bpf/syscall.c
> > +++ b/kernel/bpf/syscall.c
> > @@ -2491,7 +2491,8 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr)
> >                                BPF_F_TEST_STATE_FREQ |
> >                                BPF_F_SLEEPABLE |
> >                                BPF_F_TEST_RND_HI32 |
> > -                              BPF_F_XDP_HAS_FRAGS))
> > +                              BPF_F_XDP_HAS_FRAGS |
> > +                              BPF_F_XDP_HAS_METADATA))
> >               return -EINVAL;
> >
> >       if (!IS_ENABLED(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS) &&
> > @@ -2579,6 +2580,20 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr)
> >       prog->aux->sleepable = attr->prog_flags & BPF_F_SLEEPABLE;
> >       prog->aux->xdp_has_frags = attr->prog_flags & BPF_F_XDP_HAS_FRAGS;
> >
> > +     if (attr->prog_flags & BPF_F_XDP_HAS_METADATA) {
> > +             /* Reuse prog_ifindex to bind to the device
> > +              * for XDP metadata kfuncs.
> > +              */
> > +             prog->aux->offload_requested = false;
> > +
> > +             prog->aux->xdp_netdev = dev_get_by_index(current->nsproxy->net_ns,
> > +                                                      attr->prog_ifindex);
> > +             if (!prog->aux->xdp_netdev) {
> > +                     err = -EINVAL;
> > +                     goto free_prog;
> > +             }
> > +     }
>
