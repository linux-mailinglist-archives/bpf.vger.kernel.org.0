Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43EB94FCF48
	for <lists+bpf@lfdr.de>; Tue, 12 Apr 2022 08:12:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239806AbiDLGOZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 12 Apr 2022 02:14:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbiDLGOZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 12 Apr 2022 02:14:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A82CC329A2;
        Mon, 11 Apr 2022 23:12:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 52D76B81B35;
        Tue, 12 Apr 2022 06:12:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7B52C385AD;
        Tue, 12 Apr 2022 06:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649743925;
        bh=ACoZdA3Dxg/CYFEPdBg68crTUKAvPWorsgEWhy88cz8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dDadEpfrKVvTZbzYxaA4LFGN5+4puqiHrsAFMLPFQNZ+nkOVC6y8mto9LSPQmFjbL
         ceYPVbvLgWHhlXT7MK0h5O2Z1TG8UhScxZbIpJAikMmNOAagwBNFWr0lvew7Y3z+8B
         KV+cZvE+SDZKsWcZ02Nnd+eJNpf2YvHxy71aYx5LpkY1kJVX2qjzFvNYAzcIyDnzMY
         AscGJzYeWwvn7yOpOX+2vdtQ/SyTx99AclfeVsdcdNL7dZd2kNogP6bHBWruuTcue4
         u1WRhXrwpvYVRpCa+r6yNpcHINyi00/GgAnckGIV9j7NafTqEvfyJ8czN5y5YQUNfj
         LkxHqYu/YHuUw==
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-2ebf3746f87so95242227b3.6;
        Mon, 11 Apr 2022 23:12:05 -0700 (PDT)
X-Gm-Message-State: AOAM530TLf9+tiEy8IqMaeWBk0c8YPy0WPHBSfA+qs5Hd7oobQuAp0it
        +bYLiE6DeMdnGByc+X7PWzX5za3i9yFzue2ATPQ=
X-Google-Smtp-Source: ABdhPJymgKneKeTIoxNk9CSLItjT7TD9MISrfs7p4O12oaJCxDCQbim9PNfUFRMIjdY24Ju5i697pzXbWYUiJfzzYIM=
X-Received: by 2002:a81:5087:0:b0:2ef:33c1:fccd with SMTP id
 e129-20020a815087000000b002ef33c1fccdmr185706ywb.73.1649743924838; Mon, 11
 Apr 2022 23:12:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220411233549.740157-1-song@kernel.org> <20220411233549.740157-3-song@kernel.org>
 <YlT99YrkJyLVMdNH@infradead.org>
In-Reply-To: <YlT99YrkJyLVMdNH@infradead.org>
From:   Song Liu <song@kernel.org>
Date:   Mon, 11 Apr 2022 23:11:53 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7O3V-mQo=Vsy-Qq3ZCqYT-0Osa4+YhzsYiu-84mGYZYQ@mail.gmail.com>
Message-ID: <CAPhsuW7O3V-mQo=Vsy-Qq3ZCqYT-0Osa4+YhzsYiu-84mGYZYQ@mail.gmail.com>
Subject: Re: [PATCH v2 bpf 2/3] module: introduce module_alloc_huge
To:     Christoph Hellwig <hch@infradead.org>
Cc:     bpf <bpf@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>,
        open list <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        rick.p.edgecombe@intel.com, imbrenda@linux.ibm.com,
        Luis Chamberlain <mcgrof@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Apr 11, 2022 at 9:20 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Mon, Apr 11, 2022 at 04:35:47PM -0700, Song Liu wrote:
> > Introduce module_alloc_huge, which allocates huge page backed memory in
> > module memory space. The primary user of this memory is bpf_prog_pack
> > (multiple BPF programs sharing a huge page).
>
> I kow I lead you downthis road first, but I wonder if we just want to
> pass a flag to module_alloc instead.  This avoids duplicating all the
> arch overrides.

I don't think we will see many archs support bpf_prog_pack, so the __weak
version might be good enough for a long time. Adding an argument to
module_alloc seems like more trouble to me.

Thanks,
Song
