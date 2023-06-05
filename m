Return-Path: <bpf+bounces-1811-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3E497224DD
	for <lists+bpf@lfdr.de>; Mon,  5 Jun 2023 13:46:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 628DA281059
	for <lists+bpf@lfdr.de>; Mon,  5 Jun 2023 11:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86CB317AC0;
	Mon,  5 Jun 2023 11:46:35 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB5C168CF
	for <bpf@vger.kernel.org>; Mon,  5 Jun 2023 11:46:34 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7240A1;
	Mon,  5 Jun 2023 04:46:32 -0700 (PDT)
Received: from dggpemm500006.china.huawei.com (unknown [172.30.72.55])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4QZWwV3mSDztQTr;
	Mon,  5 Jun 2023 19:44:10 +0800 (CST)
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 5 Jun 2023 19:46:29 +0800
Subject: Re: [PATCH v3 3/3] bpf: make bpf_dump_raw_ok() based on
 CONFIG_KALLSYMS
To: Maninder Singh <maninder1.s@samsung.com>, <ast@kernel.org>,
	<daniel@iogearbox.net>, <john.fastabend@gmail.com>, <andrii@kernel.org>,
	<martin.lau@linux.dev>, <song@kernel.org>, <yhs@fb.com>,
	<kpsingh@kernel.org>, <sdf@google.com>, <haoluo@google.com>,
	<jolsa@kernel.org>, <mcgrof@kernel.org>, <boqun.feng@gmail.com>,
	<vincenzopalazzodev@gmail.com>, <ojeda@kernel.org>, <jgross@suse.com>,
	<brauner@kernel.org>, <michael.christie@oracle.com>,
	<samitolvanen@google.com>, <glider@google.com>, <peterz@infradead.org>,
	<keescook@chromium.org>, <stephen.s.brennan@oracle.com>,
	<alan.maguire@oracle.com>, <pmladek@suse.com>
CC: <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>, Onkarnath
	<onkarnath.1@samsung.com>
References: <20230605040731.13828-1-maninder1.s@samsung.com>
 <CGME20230605040801epcas5p2ca850464882841a0a5748e217542a10a@epcas5p2.samsung.com>
 <20230605040731.13828-3-maninder1.s@samsung.com>
From: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <131e23cc-1693-bcc7-c9e5-1d51bd8ec930@huawei.com>
Date: Mon, 5 Jun 2023 19:46:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20230605040731.13828-3-maninder1.s@samsung.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 2023/6/5 12:07, Maninder Singh wrote:
> bpf_dump_raw_ok() depends on kallsyms_show_value() and we already
> have a false definition for the !CONFIG_KALLSYMS case. But we have
> expanded kallsyms_show_value() to work for !CONFIG_KALLSYMS case also
> in previous patch.
> 
> And so to make the code easier to follow just provide a direct
> !CONFIG_KALLSYMS definition for bpf_dump_raw_ok() as well.
> 
> As it is heavily dependent on KALLSYMS and checking based on
> kallsyms_show_value() will not work now.

This patch needs to be swapped with 2/3. To avoid unnecessary trouble
for people using "git bisect", assume that they just fall back to patch 2/3.

> 
> Co-developed-by: Onkarnath <onkarnath.1@samsung.com>
> Signed-off-by: Onkarnath <onkarnath.1@samsung.com>
> Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
> Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
>  include/linux/filter.h | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/filter.h b/include/linux/filter.h
> index bbce89937fde..1f237a3bb11a 100644
> --- a/include/linux/filter.h
> +++ b/include/linux/filter.h
> @@ -923,13 +923,21 @@ bool bpf_jit_supports_kfunc_call(void);
>  bool bpf_jit_supports_far_kfunc_call(void);
>  bool bpf_helper_changes_pkt_data(void *func);
>  
> +/*
> + * Reconstruction of call-sites is dependent on kallsyms,
> + * thus make dump the same restriction.
> + */
> +#ifdef CONFIG_KALLSYMS
>  static inline bool bpf_dump_raw_ok(const struct cred *cred)
>  {
> -	/* Reconstruction of call-sites is dependent on kallsyms,
> -	 * thus make dump the same restriction.
> -	 */
>  	return kallsyms_show_value(cred);
>  }
> +#else
> +static inline bool bpf_dump_raw_ok(const struct cred *cred)
> +{
> +	return false;
> +}
> +#endif
>  
>  struct bpf_prog *bpf_patch_insn_single(struct bpf_prog *prog, u32 off,
>  				       const struct bpf_insn *patch, u32 len);
> 

-- 
Regards,
  Zhen Lei

