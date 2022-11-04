Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD0F8619156
	for <lists+bpf@lfdr.de>; Fri,  4 Nov 2022 07:48:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231546AbiKDGsJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Nov 2022 02:48:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231545AbiKDGri (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Nov 2022 02:47:38 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 136B12B1A8
        for <bpf@vger.kernel.org>; Thu,  3 Nov 2022 23:47:35 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id d24so4065098pls.4
        for <bpf@vger.kernel.org>; Thu, 03 Nov 2022 23:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6uDzKPGhGD0RM+hkfn+xaMULDVyzPMkJFdv+HQxKc4s=;
        b=ozjkai0tK+FhuL20jUGr85ch2TPrM7u2ibOhn0ADK9Zn7KvPZwMFGMygZAHypKwKmy
         Nq7kE5m7Z1w0tAq/aOgFshW0HgcoSJY/3ZnpAZF146nfrqwImyaK2jbhoxBzgjwJ5cL0
         LRt+r8SlUvoQW9rKIvMsGE/P72Gr8QCmYH8l9iph480mZwdLOqsl44F4cjwl6BJ86+/9
         qcLodib8bNhG7wzXRLCAl0AXNCvx4Qc7Vrw1gwqYCV/eJw3b9VMg0ppQrxmVBCcmVTrA
         FHUuOub9i6rj9NEQ8BB85ryRnApJolXM5gE3+0j60jSSyuyGNy6Fyhwv5WbSNzAThetG
         f/Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6uDzKPGhGD0RM+hkfn+xaMULDVyzPMkJFdv+HQxKc4s=;
        b=wGtCaxtoTVuixZwZQL8tzF75cW248yYDPws3k3oy9zAGYnhGyu3At4yI3yxG5lkrnd
         Mp7JYDwCCfSfN1h5NlhO2HC/94e/AplCqlJL50kSbt92ZaAljEJkV38FommBXZ9uJg9C
         tIhAqgpFpzftU0xbDqvUCvcDNUhY79F63xuxRWTe50nbHn1Qt87BoE/Dgif7vUF3yiVZ
         t9INx2bmm5KaAk8fGZz7bWEvTYuFVAn8atqAXbvDSAsqoIn4xHNyZpBkEZrmmdRFLYJ4
         AGWmsCT5PXa9zs4slmu+xPN+H7bLjqluXeQVRHDJg+JeBkuu4VE5OJ8Wv8mSWecEJGpZ
         wl3w==
X-Gm-Message-State: ACrzQf3BpX3BSuy9TjqWfs2lSBpCY41/Wt9U3oLXV0MEbJr9qRbaOxpY
        3ZIS69eKEzMLnMs0MifcrxQ=
X-Google-Smtp-Source: AMsMyM4Noj2bwRe+mQEYGwIxg0ELtVd3JndytAGIjYjBupt+/vLS6iaa+kDnH7XBabpbR0ifkQvDDA==
X-Received: by 2002:a17:902:f28b:b0:186:b069:63fc with SMTP id k11-20020a170902f28b00b00186b06963fcmr34504200plc.38.1667544454444;
        Thu, 03 Nov 2022 23:47:34 -0700 (PDT)
Received: from localhost ([59.152.80.69])
        by smtp.gmail.com with ESMTPSA id jj3-20020a170903048300b00186ae20e8dcsm1724904plb.271.2022.11.03.23.47.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 23:47:34 -0700 (PDT)
Date:   Fri, 4 Nov 2022 12:17:09 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>,
        Delyan Kratunov <delyank@meta.com>
Subject: Re: [PATCH bpf-next v4 07/24] bpf: Consolidate spin_lock, timer
 management into btf_record
Message-ID: <20221104064709.lwoif45vugplhloh@apollo>
References: <20221103191013.1236066-1-memxor@gmail.com>
 <20221103191013.1236066-8-memxor@gmail.com>
 <CAADnVQ+E8T3dRowYzzVfxXEcE1ntNRvF4YSgaCmGhNfO6Q0CaQ@mail.gmail.com>
 <20221104064345.nqjnolzvjv473a4e@apollo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221104064345.nqjnolzvjv473a4e@apollo>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Nov 04, 2022 at 12:13:45PM IST, Kumar Kartikeya Dwivedi wrote:
> On Fri, Nov 04, 2022 at 11:00:11AM IST, Alexei Starovoitov wrote:
> > On Thu, Nov 3, 2022 at 12:11 PM Kumar Kartikeya Dwivedi
> > <memxor@gmail.com> wrote:
> > >  static int bpf_map_alloc_off_arr(struct bpf_map *map)
> > >  {
> > > -       bool has_spin_lock = map_value_has_spin_lock(map);
> > > -       bool has_timer = map_value_has_timer(map);
> > >         bool has_fields = !IS_ERR_OR_NULL(map);
> > >         struct btf_field_offs *fo;
> > > -       u32 i;
> > > +       struct btf_record *rec;
> > > +       u32 i, *off;
> > > +       u8 *sz;
> > >
> > > -       if (!has_spin_lock && !has_timer && !has_fields) {
> > > +       if (!has_fields) {
> > >                 map->field_offs = NULL;
> > >                 return 0;
> > >         }
> > > @@ -970,32 +987,14 @@ static int bpf_map_alloc_off_arr(struct bpf_map *map)
> > >                 return -ENOMEM;
> > >         map->field_offs = fo;
> > >
> > > -       fo->cnt = 0;
> > > -       if (has_spin_lock) {
> > > -               i = fo->cnt;
> > > -
> > > -               fo->field_off[i] = map->spin_lock_off;
> > > -               fo->field_sz[i] = sizeof(struct bpf_spin_lock);
> > > -               fo->cnt++;
> > > -       }
> > > -       if (has_timer) {
> > > -               i = fo->cnt;
> > > -
> > > -               fo->field_off[i] = map->timer_off;
> > > -               fo->field_sz[i] = sizeof(struct bpf_timer);
> > > -               fo->cnt++;
> > > -       }
> > > -       if (has_fields) {
> > > -               struct btf_record *rec = map->record;
> > > -               u32 *off = &fo->field_off[fo->cnt];
> > > -               u8 *sz = &fo->field_sz[fo->cnt];
> > > -
> > > -               for (i = 0; i < rec->cnt; i++) {
> > > -                       *off++ = rec->fields[i].offset;
> > > -                       *sz++ = btf_field_type_size(rec->fields[i].type);
> > > -               }
> > > -               fo->cnt += rec->cnt;
> > > +       rec = map->record;
> > > +       off = &fo->field_off[fo->cnt];
> > > +       sz = &fo->field_sz[fo->cnt];
> >
> > Another bug that would have been obvious if you run any tests.
> > (fo->cnt contains garbage)
> >
> > I'm surprised by the amount of issues in the series.
> >
>
> It's my bad, I deleted what was fo->cnt very recently and didn't give this a run

deleted

> > > -       fo->cnt = 0;
