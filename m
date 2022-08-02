Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16904588458
	for <lists+bpf@lfdr.de>; Wed,  3 Aug 2022 00:37:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233348AbiHBWg7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 2 Aug 2022 18:36:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233140AbiHBWg6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 2 Aug 2022 18:36:58 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA92C1658C
        for <bpf@vger.kernel.org>; Tue,  2 Aug 2022 15:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659479816; x=1691015816;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=XCsTPnpTKoW+duZszx3zQSg+OHhT0zbLo009U3mVwMs=;
  b=gJ5I/PIbXUWOHxTBJNFdFez3PstC8WlkuvCRdaZMjYOREY4UUTRPgh+d
   HYZfgXbhJMNp4xJ5TPjwWWt1jTrWATer9Qk39A6gjWu2aNzSGy4K39hwW
   /wvFc7GtL7YZ2tIqjZREApGdPZbkeIrc/GgQtROgUFAmSKl1uor4uws25
   IrpuHrJiPpIdn64jHFCeAK/1qzPoOgmV+Kgr6NcnRaWUEWzWDfpGpPKFK
   HGM0h8qja4XgUDgqlYXJ+V1Xt8K25AWXHrkDlBqLauC1D/iQS3yYgfqeO
   uAWgCKvKLD+yJkTHzN/RhaOwYnji0+9rNEw2b4/sC949GKbOrddgS/Lpu
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10427"; a="269303864"
X-IronPort-AV: E=Sophos;i="5.93,212,1654585200"; 
   d="scan'208";a="269303864"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2022 15:36:56 -0700
X-IronPort-AV: E=Sophos;i="5.93,212,1654585200"; 
   d="scan'208";a="599448815"
Received: from dnrajurk-mobl.amr.corp.intel.com ([10.209.121.166])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2022 15:36:56 -0700
Date:   Tue, 2 Aug 2022 15:36:55 -0700 (PDT)
From:   Mat Martineau <mathew.j.martineau@linux.intel.com>
To:     Jiri Olsa <jolsa@kernel.org>
cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        Martin KaFai Lau <kafai@fb.com>, bpf@vger.kernel.org,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, mptcp@lists.linux.dev
Subject: Re: [PATCHv2 bpf-next] mptcp: Add struct mptcp_sock definition when
 CONFIG_MPTCP is disabled
In-Reply-To: <20220802163324.1873044-1-jolsa@kernel.org>
Message-ID: <341f1b39-24e1-3c80-41e0-a4ebac91297@linux.intel.com>
References: <20220802163324.1873044-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 2 Aug 2022, Jiri Olsa wrote:

> The btf_sock_ids array needs struct mptcp_sock BTF ID for
> the bpf_skc_to_mptcp_sock helper.
>
> When CONFIG_MPTCP is disabled, the 'struct mptcp_sock' is not
> defined and resolve_btfids will complain with:
>
>  BTFIDS  vmlinux
> WARN: resolve_btfids: unresolved symbol mptcp_sock
>
> Adding empty difinition for struct mptcp_sock when CONFIG_MPTCP
> is disabled.
>
> Acked-by: Martin KaFai Lau <kafai@fb.com>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

Thanks Jiri, v2 looks good to merge in bpf-next:

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>


> ---
> include/net/mptcp.h | 4 ++++
> 1 file changed, 4 insertions(+)
>
> v2 changes:
>  - moved the new empty struct declaration next to the inline
>    bpf_mptcp_sock_from_subflow function [Mat]
>
> diff --git a/include/net/mptcp.h b/include/net/mptcp.h
> index ac9cf7271d46..412479ebf5ad 100644
> --- a/include/net/mptcp.h
> +++ b/include/net/mptcp.h
> @@ -291,4 +291,8 @@ struct mptcp_sock *bpf_mptcp_sock_from_subflow(struct sock *sk);
> static inline struct mptcp_sock *bpf_mptcp_sock_from_subflow(struct sock *sk) { return NULL; }
> #endif
>
> +#if !IS_ENABLED(CONFIG_MPTCP)
> +struct mptcp_sock { };
> +#endif
> +
> #endif /* __NET_MPTCP_H */
> -- 
> 2.37.1
>
>

--
Mat Martineau
Intel
