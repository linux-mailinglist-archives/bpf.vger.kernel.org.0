Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36CE94FCF4B
	for <lists+bpf@lfdr.de>; Tue, 12 Apr 2022 08:12:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348642AbiDLGPK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 12 Apr 2022 02:15:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbiDLGPJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 12 Apr 2022 02:15:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0778329A2;
        Mon, 11 Apr 2022 23:12:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5E18261892;
        Tue, 12 Apr 2022 06:12:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5181C385AB;
        Tue, 12 Apr 2022 06:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649743972;
        bh=OxfmDZzF7U2WaVKVb/qxbxauejZ04m+glB0gp8MiPa8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=FbNSxhjHIjRGow1C2VfUJIujqFGq+pCQyUqAUZS+UWOyjYXI9fuL7B1f+SdTvxXew
         uaU9kTFS08pXh5MbvmqEo41JXKlanRDtgvltm1PsY1n3yLZ1Sg0QbAz7e/D8SzRSOz
         njscD9c8Sqndt8SWv9DZCnKhS+0IvehPuBiTEvfwPMh+bDwthNFt9M6PzbubL4nxHJ
         WzGwamwLoEpsy0aR2d3jLd64a1tYiONotTxWbfuELXCPqWvFqXH+hTr2cL4XWpDBPi
         S2zlDkijO6Di3cf//x1ZwH7T2DxbP50WEvpySw7dzpnp5zm6x0eRi0VlTqoYzIScbx
         gZE+Br9x4VdvA==
Received: by mail-yb1-f175.google.com with SMTP id p65so13092131ybp.9;
        Mon, 11 Apr 2022 23:12:52 -0700 (PDT)
X-Gm-Message-State: AOAM532MvM7/7VfCa0VHBMJ9JP20EfMdYbtdzCqsQI5S+XrJmYPO1EiM
        8OaT1Hmcp0oNeXJ8WQBl4ZOhpfyTo45sPA3e/Z4=
X-Google-Smtp-Source: ABdhPJwigfg/PfO31UjOBcQDlh443ssZmcCJYgjsqAg0FtXX5Bb/s/1xjYrgye/d2hGxRLE4ZtamMqYbshOtAEnnAYc=
X-Received: by 2002:a05:6902:1026:b0:63d:cb9f:6e03 with SMTP id
 x6-20020a056902102600b0063dcb9f6e03mr25539482ybt.9.1649743971903; Mon, 11 Apr
 2022 23:12:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220411233549.740157-1-song@kernel.org> <20220411233549.740157-5-song@kernel.org>
 <YlT+ErUHkFidID2S@infradead.org>
In-Reply-To: <YlT+ErUHkFidID2S@infradead.org>
From:   Song Liu <song@kernel.org>
Date:   Mon, 11 Apr 2022 23:12:41 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6532fVXH0zkGezxuSoX7AcXfN4_gsDh-6XBkpWbkxFmg@mail.gmail.com>
Message-ID: <CAPhsuW6532fVXH0zkGezxuSoX7AcXfN4_gsDh-6XBkpWbkxFmg@mail.gmail.com>
Subject: Re: [PATCH v2 bpf 3/3] bpf: use vmalloc with VM_ALLOW_HUGE_VMAP for bpf_prog_pack
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
> On Mon, Apr 11, 2022 at 04:35:49PM -0700, Song Liu wrote:
> > Use __vmalloc_node_range with VM_ALLOW_HUGE_VMAP for bpf_prog_pack so that
>
> That is only very indirectly true now.

Yeah, I realized I missed this part after sending it. Will fix.

Thanks,
Song
