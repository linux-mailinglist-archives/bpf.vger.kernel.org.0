Return-Path: <bpf+bounces-54107-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A77EAA62E76
	for <lists+bpf@lfdr.de>; Sat, 15 Mar 2025 15:55:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B825D189B44D
	for <lists+bpf@lfdr.de>; Sat, 15 Mar 2025 14:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F9D01FC7CF;
	Sat, 15 Mar 2025 14:55:02 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28BC193402
	for <bpf@vger.kernel.org>; Sat, 15 Mar 2025 14:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742050502; cv=none; b=gJLJjDr2jR6JFbYQsb4yVJJLjQOjz2xKeDlY3SXwh7VPvL180P1AP1jctcGuSzncv6Uwb32uKlEtQtgNldNXa2NC0o0fH1EMGmbfb7kTj1ocVREQLcLVe/+c60EdJiOLkL+TZkRst4Q7mi8Eb6JJ3ySnKyUdSaiBcXvrA2RyOac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742050502; c=relaxed/simple;
	bh=+AGvG5wLld30k6Nedtt9mc2F8GWaFdMdEDohhaHwj1Q=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=j00QSCedJQScLUmIEJuz3YsxmZYT1PVRxbzyXX/zEWFxyLRr6Xo70prR7YtG3uHCn9DQa9dUe9yrTPDGVWZEvwxLVZaRTm4ZmmFJdgC8Ub3h1hTRgLEFMRZuwNtcXvWdjFCIDd3FbkrTp2cNiAPuwhk7EDDL2R2L5zuwYI20r+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4ZFPQb2rZcz4f3lgR
	for <bpf@vger.kernel.org>; Sat, 15 Mar 2025 22:54:31 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 59EC31A0F51
	for <bpf@vger.kernel.org>; Sat, 15 Mar 2025 22:54:55 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP3 (Coremail) with SMTP id _Ch0CgD3lsG9lNVn0cLzGQ--.62344S2;
	Sat, 15 Mar 2025 22:54:55 +0800 (CST)
Subject: Re: [PATCH bpf-next] bpf: Check map->record at the begin of
 check_and_free_fields()
To: bpf@vger.kernel.org
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>,
 Yonghong Song <yonghong.song@linux.dev>,
 Daniel Borkmann <daniel@iogearbox.net>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Jiri Olsa <jolsa@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>
References: <20250315150239.1505137-1-houtao@huaweicloud.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <141a2bdd-d912-4369-094a-0de2ce52a6e8@huaweicloud.com>
Date: Sat, 15 Mar 2025 22:54:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250315150239.1505137-1-houtao@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID:_Ch0CgD3lsG9lNVn0cLzGQ--.62344S2
X-Coremail-Antispam: 1UD129KBjvdXoWrtrW3ZF1UZr4DXF4DWrW5GFg_yoWkWFcEg3
	y0vFn5Kws7Aan7Ka4UGFn3Wryftry8tFZavw4DXrZrta45X3Wrtw10vryDZFyDJwsrJFZI
	g3sxWF9Fgr15XjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUba8YFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
	j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
	kEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xKxwCYjI0SjxkI62AI
	1cAE67vIY487MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFV
	Cjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWl
	x4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r
	1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_
	JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcS
	sGvfC2KfnxnUUI43ZEXa7IU17KsUUUUUU==
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

Please ignore this patch. Send out the old version that has not been
proofread yet. Will resend. Sorry for the inconvenience.

On 3/15/2025 11:02 PM, Hou Tao wrote:
> From: Hou Tao <houtao1@huawei.com>
>
> When there is no special field in the map value, there is no need to
> invoke bpf_obj_free_fields(). Therefore, checking the validity of
> map->record in advance.
>
> After the change, the benchmark result of per-cpu update case in
> map_perf_test increase 30%+.
>
> Signed-off-by: Hou Tao <houtao1@huawei.com>
> ---
>  kernel/bpf/hashtab.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> index 6527e9ce83cd9..2623970175dcf 100644
> --- a/kernel/bpf/hashtab.c
> +++ b/kernel/bpf/hashtab.c
> @@ -906,6 +906,9 @@ static void htab_free_dynptr_key(struct bpf_htab *htab, void *key)
>  static void check_and_free_fields(struct bpf_htab *htab,
>  				  struct htab_elem *elem)
>  {
> +	if (IS_ERR_OR_NULL(htab->map.record))
> +		return;
> +
>  	if (htab_is_percpu(htab)) {
>  		void __percpu *pptr = htab_elem_get_ptr(elem, htab->map.key_size);
>  		int cpu;


