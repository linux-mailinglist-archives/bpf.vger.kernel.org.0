Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 044CE4D3C67
	for <lists+bpf@lfdr.de>; Wed,  9 Mar 2022 22:52:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236242AbiCIVxV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Mar 2022 16:53:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233863AbiCIVxU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Mar 2022 16:53:20 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3B788F4631
        for <bpf@vger.kernel.org>; Wed,  9 Mar 2022 13:52:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646862740;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Jt46+1UBm/1UiUEBiRZpbEhGZ+ENlJfo7E1vE1EyEB4=;
        b=K6h9e7pUCt9aj5A0jK2gKL/GVd7bDgyViMXcmXK8iEyAF2YMO2otl1VEz4bnmle+empkBI
        kpHxqEYBMh1fXjENJrTZymNNYwncv+hzz5E1XxuxDEctBH4jhBsY+2EYx6HlXLQmXfYypE
        UOz9vmeUZDmrRwSx16KHePpM+BbWr+E=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-604-xL5-suPWMYexG9twRL500Q-1; Wed, 09 Mar 2022 16:52:19 -0500
X-MC-Unique: xL5-suPWMYexG9twRL500Q-1
Received: by mail-ed1-f71.google.com with SMTP id bq19-20020a056402215300b0040f276105a4so1994133edb.2
        for <bpf@vger.kernel.org>; Wed, 09 Mar 2022 13:52:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=Jt46+1UBm/1UiUEBiRZpbEhGZ+ENlJfo7E1vE1EyEB4=;
        b=kPLHYXpnuD/R6Udm7LrvWEx6JCoCVIazAK5gCVezZbBifxmVDLM75YZ5JslLlWsE00
         WXafFvMyQZdStfrzjHKabRtEDRvJXlOLAw78LNyOT/UoxcWpAZYRp6j/i3ms2r40/wii
         rESkoVtClDHZT4SxEob3ldgP6DNGihERDEmULSBiK9+nMWfB/cqWzJNkFkhtkFvH8SzR
         O5Rtli/4U2XOTc2fbEd8ydnQB8GB0qL+f6mNNY+Ks2ASFQ2W7g4Rjo8BQ2kHp8ITUIUu
         Jy7EPcoAhVCa48L6mpmeSyIXJZLufX8cGjpEqVhkQU5jGwexzRNpZTBPskkne+ylie4J
         PptA==
X-Gm-Message-State: AOAM532AmSIuLKfychGNHqfzB37lQbQbsEXgWrGkD2ljzHlvcKUZHXpG
        oV2IRoWNsXtH1mpiLaqgYroVq3BWd2A+AHA+Ya+yvxivXlWXSgLaloYLaGfM3gQXOm9Jzmf9b6V
        2CqSO0smYWrLy
X-Received: by 2002:a05:6402:168e:b0:416:1714:a45c with SMTP id a14-20020a056402168e00b004161714a45cmr1431825edv.313.1646862737111;
        Wed, 09 Mar 2022 13:52:17 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxkx7BIwgJLX3HbEgIm5+oS2n8RfHGLt73XmG46iPOoMx8OhSB+V6R63JXLAqYDdf2VUefnwA==
X-Received: by 2002:a05:6402:168e:b0:416:1714:a45c with SMTP id a14-20020a056402168e00b004161714a45cmr1431731edv.313.1646862735382;
        Wed, 09 Mar 2022 13:52:15 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id z3-20020a056402274300b004169771bd91sm1226184edd.39.2022.03.09.13.52.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 13:52:14 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 13C8F192B64; Wed,  9 Mar 2022 22:52:14 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>,
        Ingo Molnar <mingo@redhat.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yonghong Song <yhs@fb.com>
Subject: Re: [PATCH net v2] xdp: xdp_mem_allocator can be NULL in
 trace_mem_connect().
In-Reply-To: <YikSav7Y1iEQv8sq@linutronix.de>
References: <YikSav7Y1iEQv8sq@linutronix.de>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 09 Mar 2022 22:52:14 +0100
Message-ID: <87v8wmvlo1.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Sebastian Andrzej Siewior <bigeasy@linutronix.de> writes:

> Since the commit mentioned below __xdp_reg_mem_model() can return a NULL
> pointer. This pointer is dereferenced in trace_mem_connect() which leads
> to segfault.
>
> The trace points (mem_connect + mem_disconnect) were put in place to
> pair connect/disconnect using the IDs. The ID is only assigned if
> __xdp_reg_mem_model() does not return NULL. That connect trace point is
> of no use if there is no ID.
>
> Skip that connect trace point if xdp_alloc is NULL.
>
> [ Toke H=C3=B8iland-J=C3=B8rgensen delivered the reasoning for skipping t=
he trace
>   point ]
>
> Fixes: 4a48ef70b93b8 ("xdp: Allow registering memory model without rxq re=
ference")
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

With Steven's fix:

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

