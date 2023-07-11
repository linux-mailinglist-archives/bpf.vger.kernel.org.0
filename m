Return-Path: <bpf+bounces-4657-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE38174E285
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 02:23:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78D4C281486
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 00:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BF0D376;
	Tue, 11 Jul 2023 00:23:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46AC6191;
	Tue, 11 Jul 2023 00:23:26 +0000 (UTC)
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAA241A8;
	Mon, 10 Jul 2023 17:23:24 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-666e6ecb52dso2798770b3a.2;
        Mon, 10 Jul 2023 17:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689035004; x=1691627004;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QJexsnAviZKaD4R6So1yQqblAXVnUemiWagepXo9BkY=;
        b=G+20GWBl6qoZiT4bB/05q04cx5SsOD/cpfs8ZXD8OR+EMY8A0OO8dgm58bbnlah13b
         N+MpPTnPq056IRIzneTrxqvnrbX0kuq5+yjEvp0RZwvOKHRFDQD8WylXZw3BfgE4BsV6
         AZPeYmx79erNvUCCivmyFqabf2lpNALPQ5uiMlVQA5z5v4bhmGPbFTGUsOyq1t6zsf7M
         RFShTeuEO/zgGvnP+5/3DMDBeE3ytrI9S73GP9dfr3H9D5rLGojee3k3Bd3OjRg8WxAk
         tFSz2e8LhGEPsXjh3CufUBdHIeQ311vJ8QLXYYjAJTqeYD9gzRMmeK+YszvS7cZAnNkx
         0mMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689035004; x=1691627004;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QJexsnAviZKaD4R6So1yQqblAXVnUemiWagepXo9BkY=;
        b=asAFCDglNexlRouqbnHtGNl53ml6b/4K9Z/TvQ32EmyelGozOGe4VntKXZpdCzVW0w
         jmQlH4Yqx34BPQGz5EwDe48vBSuh+WfpeTfmUGNYzDubvYd7cLrDgmI0gXcBzGXAQ81K
         x17gVILBdH9bSrC4bTurRpK2mzntz9XMdwIfsTcE/8Ya3UCmxsxIscHD0cYpbch2nDv0
         P1zNwJEM4vGlGWqiyH4yohLbqYnzFJGCtVyRSsdCHD9+cWvXNMKyQ9b/7rAqCcUxPXkt
         VbKJvkLPLQO7vn98XcHM6OFBtPpb8cmWmoWdFBAdR3336dGlckmItvYuxQDOLapyyZnc
         l9KA==
X-Gm-Message-State: ABy/qLbNacnuVH1Dm0hCB0z0Bhi8qAb8/5/uzDilg7AS/l6KFXXBHD0J
	Sfhz9uxqEUjls35TKExZoGM=
X-Google-Smtp-Source: APBJJlFtjQhrmd78YmfBm4R20CNBQ7EcN5C+FxkjjCwpmTvqaFkAudVmPEaMvDxWG4uOrjlVfRK6Ig==
X-Received: by 2002:a05:6a00:1593:b0:65e:ec60:b019 with SMTP id u19-20020a056a00159300b0065eec60b019mr13513481pfk.25.1689035003994;
        Mon, 10 Jul 2023 17:23:23 -0700 (PDT)
Received: from MacBook-Pro-8.local ([2620:10d:c090:400::5:9b44])
        by smtp.gmail.com with ESMTPSA id j15-20020aa7800f000000b00666e883757fsm364497pfi.123.2023.07.10.17.23.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 17:23:23 -0700 (PDT)
Date: Mon, 10 Jul 2023 17:23:20 -0700
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: ast@kernel.org, andrii@kernel.org, martin.lau@linux.dev,
	razor@blackwall.org, sdf@google.com, john.fastabend@gmail.com,
	kuba@kernel.org, dxu@dxuuu.xyz, joe@cilium.io, toke@kernel.org,
	davem@davemloft.net, bpf@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH bpf-next v4 1/8] bpf: Add generic attach/detach/query API
 for multi-progs
Message-ID: <20230711002320.bp4mlb4at45vkrqt@MacBook-Pro-8.local>
References: <20230710201218.19460-1-daniel@iogearbox.net>
 <20230710201218.19460-2-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230710201218.19460-2-daniel@iogearbox.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jul 10, 2023 at 10:12:11PM +0200, Daniel Borkmann wrote:
> + *
> + *   struct bpf_mprog_entry *entry, *peer;
> + *   int ret;
> + *
> + *   // bpf_mprog user-side lock
> + *   // fetch active @entry from attach location
> + *   [...]
> + *   ret = bpf_mprog_attach(entry, [...]);
> + *   if (ret >= 0) {
> + *       peer = bpf_mprog_peer(entry);
> + *       if (bpf_mprog_swap_entries(ret))
> + *           // swap @entry to @peer at attach location
> + *       bpf_mprog_commit(entry);
> + *       ret = 0;
> + *   } else {
> + *       // error path, bail out, propagate @ret
> + *   }
> + *   // bpf_mprog user-side unlock
> + *
> + *  Detach case:
> + *
> + *   struct bpf_mprog_entry *entry, *peer;
> + *   bool release;
> + *   int ret;
> + *
> + *   // bpf_mprog user-side lock
> + *   // fetch active @entry from attach location
> + *   [...]
> + *   ret = bpf_mprog_detach(entry, [...]);
> + *   if (ret >= 0) {
> + *       release = ret == BPF_MPROG_FREE;
> + *       peer = release ? NULL : bpf_mprog_peer(entry);
> + *       if (bpf_mprog_swap_entries(ret))
> + *           // swap @entry to @peer at attach location
> + *       bpf_mprog_commit(entry);
> + *       if (release)
> + *           // free bpf_mprog_bundle
> + *       ret = 0;
> + *   } else {
> + *       // error path, bail out, propagate @ret
> + *   }
> + *   // bpf_mprog user-side unlock

Thanks for the doc. It helped a lot.
And when it's contained like this it's easier to discuss api.
It seems bpf_mprog_swap_entries() is trying to abstract the error code
away, but BPF_MPROG_FREE leaks out and tcx_entry_needs_release()
captures it with extra miniq_active twist, which I don't understand yet.
bpf_mprog_peer() is also leaking a bit of implementation detail.
Can we abstract it further, like:

ret = bpf_mprog_detach(entry, [...], &new_entry);
if (ret >= 0) {
   if (entry != new_entry)
     // swap @entry to @new_entry at attach location
   bpf_mprog_commit(entry);
   if (!new_entry)
     // free bpf_mprog_bundle
}
and make bpf_mprog_peer internal to mprog. It will also allow removing
BPF_MPROG_FREE vs SWAP distinction. peer is hidden.
   if (entry != new_entry)
      // update
also will be easier to read inside tcx code without looking into mprog details.

