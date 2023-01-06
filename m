Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4315C660581
	for <lists+bpf@lfdr.de>; Fri,  6 Jan 2023 18:18:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235007AbjAFRRl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 6 Jan 2023 12:17:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235709AbjAFRRa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 6 Jan 2023 12:17:30 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B73D303
        for <bpf@vger.kernel.org>; Fri,  6 Jan 2023 09:17:29 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id c9so1514443pfj.5
        for <bpf@vger.kernel.org>; Fri, 06 Jan 2023 09:17:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TavTUbONX2+yXfbTWhYMTZaU5crQvqDDzZMkJ5klCoI=;
        b=OQ2i+YjNeDuVeemoCKcA2XSQdxATDnzDlf0RB/QbImUC7WJyGCcbS+x3ItHv4p3bSv
         YtxcAO9wJ4U1ZRz0pWW0kdxuj3iVn5LCbwY9VXEc7SoFVY4Ze4VN/J86L/Rbi4fdQ4ia
         kZvZbvJQ7T8FOXHZOUs1OjOneoLgnPKriCppNEFspUmNHyuAXeq93f8Nha/QLLXXAnBq
         9w9xVh0G2hrl7s1FC1d0QezYm/Qge3h8cpEjHDWd+xIR8NJIjmhy5oDNQ5IuXJ2E3f+u
         ruL+MhSEBDfwy5449lBWB+myk7pp+6o1q4jlikuYrUb1HA3LP1/eqL/vSQDsyAmD669O
         mmDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TavTUbONX2+yXfbTWhYMTZaU5crQvqDDzZMkJ5klCoI=;
        b=W4oU2TrGVTc8vgrymfNwl3rZZKbnf4wSbSbeIHc9NNZndE2S7teimt+U4wn6VQBVQF
         XasCz6ZXAg7RjsU0h9zceMKZCTF5M1mNphiuRnwAVhdrC8VUkbv8cOT7minr5zi8EqnX
         2E+jBMGqfGSmivd0wNLNO9KVGpMOUdSL9eFSS1zRKTu3/Gghc/yhfJVc0dgQPQw6SHjG
         eVaatfGRTFhumrvNfvAEM4v8NjX2IHl5oZmw4hLp0/hKS7MVDppe7QKEOfF1acZ9F+Ah
         3L4g15womOpR0VCmrY4sZ62EBiL77pVkla7WObyNuOoZnrexMT4UzFJvc+/QLEnpoxrT
         3qVw==
X-Gm-Message-State: AFqh2koKE8MJmSNI+tzLyWHujBGfVAj0dDCpBv8LPvKgjr5YyRwqI5PD
        6awJXJXuKU/aVCE5bfF/llFp1EjmxLGsNkYRo9wpWQ==
X-Google-Smtp-Source: AMrXdXvZ8opWqDUM60+7TMJoKaRUq+N+CT1X9WhXI5/EMF0PYpXOXugqaMscHIisifaLKZRR3tVlDWwEC+73ayGQIAs=
X-Received: by 2002:a63:9d0a:0:b0:49f:478d:a72c with SMTP id
 i10-20020a639d0a000000b0049f478da72cmr1706861pgd.250.1673025448721; Fri, 06
 Jan 2023 09:17:28 -0800 (PST)
MIME-Version: 1.0
References: <20230104215949.529093-1-sdf@google.com> <20230104215949.529093-8-sdf@google.com>
 <bd002756-3295-b708-e304-976d42dbf121@linux.dev>
In-Reply-To: <bd002756-3295-b708-e304-976d42dbf121@linux.dev>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Fri, 6 Jan 2023 09:17:17 -0800
Message-ID: <CAKH8qBvaTUH+gSYRXpmuLBS90=pAumvZ6dPyzdFrBndpEx3+sQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 07/17] bpf: XDP metadata RX kfuncs
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

On Thu, Jan 5, 2023 at 4:48 PM Martin KaFai Lau <martin.lau@linux.dev> wrote:
>
> On 1/4/23 1:59 PM, Stanislav Fomichev wrote:
> > +void *bpf_dev_bound_resolve_kfunc(struct bpf_prog *prog, u32 func_id)
> > +{
> > +     const struct xdp_metadata_ops *ops;
> > +     void *p = NULL;
> > +
> > +     /* We don't hold bpf_devs_lock while resolving several
> > +      * kfuncs and can race with the unregister_netdevice().
> > +      * We rely on bpf_dev_bound_match() check at attach
> > +      * to render this program unusable.
> > +      */
> > +     down_read(&bpf_devs_lock);
> > +     if (!prog->aux->offload || !prog->aux->offload->netdev)
>
> nit. !prog->aux->offload->netdev check is not needed. Testing
> !prog->aux->offload should be as good.

Yeah, true, will remove, thanks!
