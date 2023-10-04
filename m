Return-Path: <bpf+bounces-11414-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E84B7B9897
	for <lists+bpf@lfdr.de>; Thu,  5 Oct 2023 01:14:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 4D65E1C20977
	for <lists+bpf@lfdr.de>; Wed,  4 Oct 2023 23:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 359AB29437;
	Wed,  4 Oct 2023 23:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l8gmMzBX"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB41262BF
	for <bpf@vger.kernel.org>; Wed,  4 Oct 2023 23:14:18 +0000 (UTC)
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F513C0
	for <bpf@vger.kernel.org>; Wed,  4 Oct 2023 16:14:16 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-5803b7f7716so187167a12.0
        for <bpf@vger.kernel.org>; Wed, 04 Oct 2023 16:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696461256; x=1697066056; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=36YQ6hs4CulOlWopmb6uQIDP4MwhOtjrvzs0PufNoHY=;
        b=l8gmMzBXxgUe6ZF4hhemESNX9OgYcJmcr6lzNXGWTOsjHL1C4x61kenCTkt/zo6p+T
         m/pHleuWPjW0yp+tMd5BfeYd9kP47h8hZGGFeWPCe+TCQAOGV+uMKF34K9P3B7kc6KGO
         2J9x7M88KdvyD5LmAEmI477GfyeNA8zgrBaVotQpfZcob+fn8iebGIR5XcqxZus5vc7X
         61tsnhS/22iFUQBg6ziUa3ztkPLEN8X0g5AnOB2cjkzzT/EsLU1YMmA6wkJwUBruEiNB
         yd8sidN1kcva8YrEz2uGO0l5HsTXhkf3WQKT7kjp7xSwCUbQ0ztlFx0uByo26Ihjhz0N
         3CVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696461256; x=1697066056;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=36YQ6hs4CulOlWopmb6uQIDP4MwhOtjrvzs0PufNoHY=;
        b=JdmE7jqJAHPqbv/IuP+7wRPYE7TJbip8BUaZVChN9aUPydJhb6HAB3JxBoPOONa+DL
         QtEpgyEWeHU0QU1MCMsvWLfEgDjnAsKUbLWSEQ+JZIsatyoKA6MuoZjRC36jg2/cRz2W
         JgM8qZqzo5c0e3z/rqFYhWCyrU6eFIBLLnyq0ZtIiOY7UHW0OyaltAo/1NQRmULSHlCD
         Fu8/kOSGADhjs1YnYBONbxTXV3ugJ4gN5FTOufGsYD8AMVqmSB+N6UxxVTl6VS6W9Fuc
         SrM3b1887AQ7K6Qeg5onK1h1JhbwLg96Rujw19MjGjsOG1l5UCASzrECEnm/87nWAz/G
         KREA==
X-Gm-Message-State: AOJu0YwT/aE/Bk/h+XY4gwiRHOmbMNIxu2ELrO4j0AXoqIcdH6ppvaRD
	YrrI5PHjT9oq1kb7TcMObiULGCE=
X-Google-Smtp-Source: AGHT+IF1dARzKf/fT3sJKYBf5sSbvP+H7VtzDteM/5ESZB3A9bkxXET7hdT03ABDAKEs9wLs3IVP1J0=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a63:7f5b:0:b0:585:3066:489d with SMTP id
 p27-20020a637f5b000000b005853066489dmr50443pgn.2.1696461255863; Wed, 04 Oct
 2023 16:14:15 -0700 (PDT)
Date: Wed, 4 Oct 2023 16:14:14 -0700
In-Reply-To: <202310050607.UQ0bU3ct-lkp@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231003200522.1914523-6-sdf@google.com> <202310050607.UQ0bU3ct-lkp@intel.com>
Message-ID: <ZR3xxlNEyLjfWGgx@google.com>
Subject: Re: [PATCH bpf-next v3 05/10] net: stmmac: Add Tx HWTS support to XDP ZC
From: Stanislav Fomichev <sdf@google.com>
To: kernel test robot <lkp@intel.com>
Cc: bpf@vger.kernel.org, oe-kbuild-all@lists.linux.dev, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org, 
	haoluo@google.com, jolsa@kernel.org, kuba@kernel.org, toke@kernel.org, 
	willemb@google.com, dsahern@kernel.org, magnus.karlsson@intel.com, 
	bjorn@kernel.org, maciej.fijalkowski@intel.com, hawk@kernel.org, 
	yoong.siang.song@intel.com, netdev@vger.kernel.org, xdp-hints@xdp-project.net
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 10/05, kernel test robot wrote:
> Hi Stanislav,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on bpf-next/master]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Stanislav-Fomichev/xsk-Support-tx_metadata_len/20231004-040718
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
> patch link:    https://lore.kernel.org/r/20231003200522.1914523-6-sdf%40google.com
> patch subject: [PATCH bpf-next v3 05/10] net: stmmac: Add Tx HWTS support to XDP ZC
> config: riscv-defconfig (https://download.01.org/0day-ci/archive/20231005/202310050607.UQ0bU3ct-lkp@intel.com/config)
> compiler: riscv64-linux-gcc (GCC) 13.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231005/202310050607.UQ0bU3ct-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202310050607.UQ0bU3ct-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>    drivers/net/ethernet/stmicro/stmmac/stmmac_main.c: In function 'stmmac_xdp_xmit_zc':
> >> drivers/net/ethernet/stmicro/stmmac/stmmac_main.c:2554:17: error: implicit declaration of function 'xsk_tx_metadata_to_compl'; did you mean 'xsk_tx_metadata_complete'? [-Werror=implicit-function-declaration]
>     2554 |                 xsk_tx_metadata_to_compl(meta, &tx_q->tx_skbuff_dma[entry].xsk_meta);
>          |                 ^~~~~~~~~~~~~~~~~~~~~~~~
>          |                 xsk_tx_metadata_complete
>    cc1: some warnings being treated as errors


Missing "static inline xsk_tx_metadata_to_compl" for !CONFIG_XDP_SOCKETS.
Will fix in the patch where I add xsk_tx_metadata_to_compl...

