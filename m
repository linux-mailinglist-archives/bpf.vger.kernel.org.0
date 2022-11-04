Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 517B6619137
	for <lists+bpf@lfdr.de>; Fri,  4 Nov 2022 07:44:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230375AbiKDGoN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Nov 2022 02:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbiKDGoM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Nov 2022 02:44:12 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08A342187
        for <bpf@vger.kernel.org>; Thu,  3 Nov 2022 23:44:11 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id k7so4055576pll.6
        for <bpf@vger.kernel.org>; Thu, 03 Nov 2022 23:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3Xnoy8AuFbO5a3qKkuGs1l6UvdWkXMm4Yd0WtNCNOas=;
        b=j/KW0Kx1qJOtchPhMlSL55Fah38ZaRO5s42s99SKJPNu8zlUMUOn5UBdrGUmN7PSge
         cMqg/Deq94dMSjgIYw2MQhDpOuSPgdDkJDiuiWJvMWe0f3Ukl9ZdK4/PnC8zPeFW/qA8
         DGp5qoCXwUsKM7a0PWi/VcbUZtgm+7ugYjqWDkTF9lHuLMgBBoNE1O0PZAOI3yFque6q
         N3FRzDRc8jagxR4bursZL+r1883KveWZ4xhdlpTsa8s7wf7iSAdEhddaX5cR+odI+1s9
         IP41kr1uK17D6JviEhV0svuW25W3P88ZL6MyXQPxqo87pOLznfBPc9FYDkTt7EKifCmp
         5Qjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Xnoy8AuFbO5a3qKkuGs1l6UvdWkXMm4Yd0WtNCNOas=;
        b=wPZWJ+7dxPuL9wNnBB5nB/Vu5ntpOUH98qMrqNYh/jdCwHWh7WSki2wXVX+r8csp9h
         iVJvIs71VwjAKRDFqOSz6f3qKPGIj7DGjOJcmB5ogeaiLufpgpBbOvdwYbbi1Otnb0mk
         LU1gvGvR5K2CuMLumiuNkP7KcNPxddhmq41r4Aeb2x+4cqumYEEPgRBeacbjO0WERmLZ
         AU60pQ9ZDcuDmOGjClazkvMK8zcgqcpeS93gLPttgEQLYQHzXpGbI5l4lHgRQlhRLntC
         LLBpBOCb8P1HRrX4IguigxuSBszqiAQXeseu0yWqKHQf2hRmSe2w8sBeVvfb/ZopIyIV
         qlfA==
X-Gm-Message-State: ACrzQf18QM0sH9+EYQKjoOQtDmMh3SHU541eNQxzYrS2aZu0qO6WHU4g
        EnDDjtVUyeOwyXTqpKGJk3M=
X-Google-Smtp-Source: AMsMyM7Vsrh/RkxnwYiniH1Lng4LoBfoL8CIjgV/M0v45kZRS2kG9OjPkallTxws/4xmsZRK+wHRuA==
X-Received: by 2002:a17:90b:4c8a:b0:214:2ed8:6501 with SMTP id my10-20020a17090b4c8a00b002142ed86501mr12712447pjb.70.1667544250353;
        Thu, 03 Nov 2022 23:44:10 -0700 (PDT)
Received: from localhost ([59.152.80.69])
        by smtp.gmail.com with ESMTPSA id q12-20020a17090a304c00b00206023cbcc7sm1026629pjl.15.2022.11.03.23.44.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 23:44:10 -0700 (PDT)
Date:   Fri, 4 Nov 2022 12:13:45 +0530
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
Message-ID: <20221104064345.nqjnolzvjv473a4e@apollo>
References: <20221103191013.1236066-1-memxor@gmail.com>
 <20221103191013.1236066-8-memxor@gmail.com>
 <CAADnVQ+E8T3dRowYzzVfxXEcE1ntNRvF4YSgaCmGhNfO6Q0CaQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQ+E8T3dRowYzzVfxXEcE1ntNRvF4YSgaCmGhNfO6Q0CaQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Nov 04, 2022 at 11:00:11AM IST, Alexei Starovoitov wrote:
> On Thu, Nov 3, 2022 at 12:11 PM Kumar Kartikeya Dwivedi
> <memxor@gmail.com> wrote:
> >  static int bpf_map_alloc_off_arr(struct bpf_map *map)
> >  {
> > -       bool has_spin_lock = map_value_has_spin_lock(map);
> > -       bool has_timer = map_value_has_timer(map);
> >         bool has_fields = !IS_ERR_OR_NULL(map);
> >         struct btf_field_offs *fo;
> > -       u32 i;
> > +       struct btf_record *rec;
> > +       u32 i, *off;
> > +       u8 *sz;
> >
> > -       if (!has_spin_lock && !has_timer && !has_fields) {
> > +       if (!has_fields) {
> >                 map->field_offs = NULL;
> >                 return 0;
> >         }
> > @@ -970,32 +987,14 @@ static int bpf_map_alloc_off_arr(struct bpf_map *map)
> >                 return -ENOMEM;
> >         map->field_offs = fo;
> >
> > -       fo->cnt = 0;
> > -       if (has_spin_lock) {
> > -               i = fo->cnt;
> > -
> > -               fo->field_off[i] = map->spin_lock_off;
> > -               fo->field_sz[i] = sizeof(struct bpf_spin_lock);
> > -               fo->cnt++;
> > -       }
> > -       if (has_timer) {
> > -               i = fo->cnt;
> > -
> > -               fo->field_off[i] = map->timer_off;
> > -               fo->field_sz[i] = sizeof(struct bpf_timer);
> > -               fo->cnt++;
> > -       }
> > -       if (has_fields) {
> > -               struct btf_record *rec = map->record;
> > -               u32 *off = &fo->field_off[fo->cnt];
> > -               u8 *sz = &fo->field_sz[fo->cnt];
> > -
> > -               for (i = 0; i < rec->cnt; i++) {
> > -                       *off++ = rec->fields[i].offset;
> > -                       *sz++ = btf_field_type_size(rec->fields[i].type);
> > -               }
> > -               fo->cnt += rec->cnt;
> > +       rec = map->record;
> > +       off = &fo->field_off[fo->cnt];
> > +       sz = &fo->field_sz[fo->cnt];
>
> Another bug that would have been obvious if you run any tests.
> (fo->cnt contains garbage)
>
> I'm surprised by the amount of issues in the series.
>

It's my bad, I deleted what was fo->cnt very recently and didn't give this a run
again, without realizing it's only the next patch that does kmalloc -> kzalloc.
