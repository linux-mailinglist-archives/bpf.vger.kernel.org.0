Return-Path: <bpf+bounces-8446-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 780DE78670A
	for <lists+bpf@lfdr.de>; Thu, 24 Aug 2023 07:16:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36EFE281450
	for <lists+bpf@lfdr.de>; Thu, 24 Aug 2023 05:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D64117F6;
	Thu, 24 Aug 2023 05:16:32 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0112F24525
	for <bpf@vger.kernel.org>; Thu, 24 Aug 2023 05:16:31 +0000 (UTC)
Received: from out-46.mta1.migadu.com (out-46.mta1.migadu.com [95.215.58.46])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1324410F9
	for <bpf@vger.kernel.org>; Wed, 23 Aug 2023 22:16:29 -0700 (PDT)
Message-ID: <8c020115-399c-14de-0282-593f66e34c17@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1692854188;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J4SUUqUPbC0BQ/kOPn1om2av0paVLXBCicIpx4gzTwA=;
	b=fBOxhGyGXiXTPvnJi+P6zFLo/qf6PKJs83ktJaHMD+TlYG5QlhbZDk+g3Kz82Ed1XVuklT
	m4poeZ/gXBAiu7a1FyObsLPm/+OSE7P8+4YjGKF89V5NyKEA7B68WX4n5K9H/FG2Zd2nMh
	HYQcuT2lu49CJmhdDEsEsAqBN6r3X28=
Date: Thu, 24 Aug 2023 01:16:25 -0400
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 1/2] bpf: Remove a WARN_ON_ONCE warning related
 to local kptr
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
 Martin KaFai Lau <martin.lau@kernel.org>
References: <20230823225556.1292811-1-yonghong.song@linux.dev>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: David Marchevsky <david.marchevsky@linux.dev>
In-Reply-To: <20230823225556.1292811-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 8/23/23 6:55 PM, Yonghong Song wrote:
> Currently, in function bpf_obj_free_fields(), for local kptr,
> a warning will be issued if the struct does not contain any
> special fields. But actually the kernel seems totally okay
> with a local kptr without any special fields. Permitting
> no special fields also aligns with future percpu kptr which
> also allows no special fields.
> 
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---

Weird. Looking at the WARN_ON_ONCE now, I can't understand why I added it,
and history of the series adding it doesn't have any clues. The same series
added pointee_struct_meta ? pointee_struct_meta->record : NULL two lines below,
so it's not clear what I was trying to protect against.

Anyways, I agree that:
  * We can have a struct with a special __kptr field that points to some
    local kptr type
  * That local kptr 'pointee' type doesn't need to have any special fields, in
    which case pointee_struct_meta will rightly be NULL, a NULL record will be
    passed to __bpf_obj_drop_impl, which will handle it correctly.
    * In fact this is the same logic that bpf_obj_drop_impl does before calling
      its double-underscore cousin

LGTM

Acked-by: Dave Marchevsky <davemarchevsky@fb.com>


>  kernel/bpf/syscall.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> NOTE: I didn't put a fix tag since except the warning
> there is no correctness issue here.
> 
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 10666d17b9e3..ebeb0695305a 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -657,7 +657,6 @@ void bpf_obj_free_fields(const struct btf_record *rec, void *obj)
>  			if (!btf_is_kernel(field->kptr.btf)) {
>  				pointee_struct_meta = btf_find_struct_meta(field->kptr.btf,
>  									   field->kptr.btf_id);
> -				WARN_ON_ONCE(!pointee_struct_meta);
>  				migrate_disable();
>  				__bpf_obj_drop_impl(xchgd_field, pointee_struct_meta ?
>  								 pointee_struct_meta->record :

