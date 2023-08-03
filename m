Return-Path: <bpf+bounces-6771-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FCBB76DCE6
	for <lists+bpf@lfdr.de>; Thu,  3 Aug 2023 02:52:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDF8028144B
	for <lists+bpf@lfdr.de>; Thu,  3 Aug 2023 00:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 882591FD1;
	Thu,  3 Aug 2023 00:51:47 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55FCD1FB5
	for <bpf@vger.kernel.org>; Thu,  3 Aug 2023 00:51:47 +0000 (UTC)
Received: from out-64.mta1.migadu.com (out-64.mta1.migadu.com [IPv6:2001:41d0:203:375::40])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE5DB2698
	for <bpf@vger.kernel.org>; Wed,  2 Aug 2023 17:51:45 -0700 (PDT)
Message-ID: <a3da80bc-644b-69d7-675c-6af2d29b7f5c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1691023903;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9L+tSqbGpu9Raf+TEK2aP8ack3vgqGiDDt6KI+8o7Os=;
	b=E8K7eI8+i9uyW4hivr+gUi/rFxffNNO3YZQzrqJauS6pP9ny7/9T73VzhsdqS2GfDayo8w
	LdBIpmtP4h+kArxefL8Pam+E2u8K+vj08US/Kr0bnzK0ONOt3ATXJBTvVHgOCoz/b4gmUe
	qLofUiXf2sq8yPrS41IzpjM1GoMyjrk=
Date: Wed, 2 Aug 2023 17:51:35 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: =?UTF-8?Q?Re=3a_=5bPATCH=5d_bpf=3a_bpf=5fstruct=5fops=3a_Remove_unn?=
 =?UTF-8?Q?ecessary_=e2=80=980=e2=80=99_values_from_err?=
Content-Language: en-US
To: Li kunyu <kunyu@nfschina.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
 kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org
References: <20230802012354.7404-1-kunyu@nfschina.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20230802012354.7404-1-kunyu@nfschina.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 8/1/23 6:23 PM, Li kunyu wrote:
> err is assigned first, so it does not need to initialize the assignment.
> 
> Signed-off-by: Li kunyu <kunyu@nfschina.com>
> ---
>   kernel/bpf/bpf_struct_ops.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
> index d3f0a4825fa6..5b591fda5d62 100644
> --- a/kernel/bpf/bpf_struct_ops.c
> +++ b/kernel/bpf/bpf_struct_ops.c
> @@ -376,7 +376,7 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
>   	const struct btf_type *t = st_ops->type;
>   	struct bpf_tramp_links *tlinks = NULL;
>   	void *udata, *kdata;
> -	int prog_fd, err = 0;
> +	int prog_fd, err;

The "tlinks" init in two lines above is also not needed. While at the same 
function, please take this chance to remove it together.

Please tag the subject with "bpf-next v2" in the next respin.

>   	void *image, *image_end;
>   	u32 i;
>   
> @@ -818,7 +818,7 @@ static int bpf_struct_ops_map_link_update(struct bpf_link *link, struct bpf_map
>   	struct bpf_struct_ops_map *st_map, *old_st_map;
>   	struct bpf_map *old_map;
>   	struct bpf_struct_ops_link *st_link;
> -	int err = 0;
> +	int err;
>   
>   	st_link = container_of(link, struct bpf_struct_ops_link, link);
>   	st_map = container_of(new_map, struct bpf_struct_ops_map, map);


