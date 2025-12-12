Return-Path: <bpf+bounces-76502-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B672DCB79D9
	for <lists+bpf@lfdr.de>; Fri, 12 Dec 2025 03:07:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8066E300502B
	for <lists+bpf@lfdr.de>; Fri, 12 Dec 2025 02:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1677205E25;
	Fri, 12 Dec 2025 02:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="G1Dtsx8K"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F4427702E
	for <bpf@vger.kernel.org>; Fri, 12 Dec 2025 02:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765505234; cv=none; b=BB8nwx0foyvv+oboR40CrpcJS/A+nMbpOEyrw9GYKnbyNnaVp0UiOrYwebok7Vn9OBKbZVgAxO7GfQimbPlN97ldwcA+XIjxpWgO64gWiynflopw4DXPXSryAo0UMuON6gf7TeI8AzPQ5YNHRhA0fpBGBqgLU1+g35Z/TpFoXQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765505234; c=relaxed/simple;
	bh=z4QuyAw4KXi4GuUG24isFkWNtArJkw4WOvX+DQVc9EA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tdNvthFWrhwZDIzErLtpeaSlPV7YC3b/zv6UJCzPqyTMIVvzGxAUwKsjG+OCItZrnqAllUBVa/I/58YCWEiFPunxZGMBdVrOs/DMH1pP3roh+eGyM4Cty38EkX9PaWw8CDMlUBtmT3wkq3ep3wh5YOIEONnY9zdZcNvLbRwrxFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=G1Dtsx8K; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BBNCuAt2330787;
	Thu, 11 Dec 2025 18:07:09 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=cA0kyemEoUF09yOaNUIb9aGvyujiR5+Vk6JvBwlWm1M=; b=G1Dtsx8KldZ5
	Mk5sm5PYj0ugURI1fFgnGndoRif6ZZFStW1sBurAsjgLgSMN40WD1FxpvsvU8ZCn
	sPpX+8gzTwrIihIVvAmixDLppODwHxqw0MHHstumoBRovCZKQ7vkhrF+2L4ZuH2V
	vHyLahLMxqrEnRvotxH3uLjcfXKCNWrqPsQqzWuHpUz0zcl5SVDmiwl38d8+xSq/
	9/KHd9p5E6Wmx6YNt8NK76POaOwjYIxiBG+UlK0LfuT6396bQaCGcQ3JdYDOhynD
	Nh4tV+OGN2Ao87RCE9m3LQRsLd7JwPBhCOMsj0K+9ZJtq1NHy1AUg9jLSNfUecKB
	aowUKS7EQw==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4b07eds418-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 11 Dec 2025 18:07:09 -0800 (PST)
Received: from devbig003.atn7.facebook.com (2620:10d:c0a8:fe::f072) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.29; Fri, 12 Dec 2025 02:06:55 +0000
From: Chris Mason <clm@meta.com>
To: Martin Teichmann <martin.teichmann@xfel.eu>
CC: Chris Mason <clm@meta.com>, <bpf@vger.kernel.org>, <eddyz87@gmail.com>,
        <ast@kernel.org>, <andrii@kernel.org>
Subject: Re: [PATCH v6 bpf-next 3/4] bpf: correct stack liveness for tail calls
Date: Thu, 11 Dec 2025 18:06:36 -0800
Message-ID: <20251212020639.3689343-1-clm@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251119160355.1160932-4-martin.teichmann@xfel.eu>
References:
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: MjmXwcCcYKM42pt-ZBAqDxjAFcREhA2J
X-Authority-Analysis: v=2.4 cv=bvxBxUai c=1 sm=1 tr=0 ts=693b78cd cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=YaqzWN9NAAAA:8 a=pGLkceISAAAA:8
 a=db01mMCuQFIZNvgDrvoA:9 a=PLZuYiSIBiB8OtF4If2o:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjEyMDAxNSBTYWx0ZWRfX9BjdsP0I6Yui
 48bGJqruvDKu9P77phs59qxXtzPt10cGv5kFtPwLtX0l+3uLyVbeWASwJZ3CYqhe/Wt0TGRUE82
 v0rFSevvpJtzkxhqztc10kbNSNtKY4hDCa7fJ32ITNukxGCRTEtbOsfEeBlunH8F4fDHoUMOHhf
 CdbFOVCPwJpWkXXWwG5lC+X/opd6qE2QsYXTxjjtZOgP4XcSZ1U5de6iJYJdpQb4WNVUwKo4sC0
 a3CRRY1kX3r7UEvjhjj8DpoBqOoOzCr6/2R6MxVbQqGsAehvV4UgJLYfLFBZeGHc32ZQ+uB9TEV
 dKcwsV5k9j/mQF4dLDGOhTqm+Twra74SJ+O+K2rgz96ylo34/nxZr+G/hb8Mezem9h7lCNSpZT+
 +pIkbdNzfmaesxvuDhEppr15YFP8uw==
X-Proofpoint-ORIG-GUID: MjmXwcCcYKM42pt-ZBAqDxjAFcREhA2J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-12_01,2025-12-11_01,2025-10-01_01

On Wed, 19 Nov 2025 17:03:54 +0100 Martin Teichmann <martin.teichmann@xfel.eu> wrote:

> From: Eduard Zingerman <eddyz87@gmail.com>
> 
> This updates bpf_insn_successors() reflecting that control flow might
> jump over the instructions between tail call and function exit, verifier
> might assume that some writes to parent stack always happen, which is
> not the case.
> 

Hi everyone,

I ran recent upstream commits through claude and it flagged this one.  Looks
like a different comment than it had made earlier:

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 9426367fc9113..0828718a8ba71 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -18156,6 +18160,25 @@ static int visit_gotox_insn(int t, struct bpf_verifier_env *env)
>  	return keep_exploring ? KEEP_EXPLORING : DONE_EXPLORING;
>  }
>
> +static int visit_tailcall_insn(struct bpf_verifier_env *env, int t)
> +{
> +	static struct bpf_subprog_info *subprog;
> +	struct bpf_iarray *jt;
> +
> +	if (env->insn_aux_data[t].jt)
> +		return 0;
> +
> +	jt = iarray_realloc(NULL, 2);
> +	if (!jt)
> +		return -ENOMEM;
> +
> +	subprog = bpf_find_containing_subprog(env, t);
> +	jt->items[0] = t + 1;
> +	jt->items[1] = subprog->exit_idx;
> +	env->insn_aux_data[t].jt = jt;
> +	return 0;
> +}
> +

[ ... ]

> @@ -18216,6 +18239,8 @@ static int visit_insn(int t, struct bpf_verifier_env *env)
>  				mark_subprog_might_sleep(env, t);
>  			if (bpf_helper_changes_pkt_data(insn->imm))
>  				mark_subprog_changes_pkt_data(env, t);
> +			if (insn->imm == BPF_FUNC_tail_call)
> +				visit_tailcall_insn(env, t);
                                ^^^^^^^^^^^^^^^^^^^^^^^

The return value of visit_tailcall_insn() is not checked here. If
iarray_realloc() fails and returns -ENOMEM, the error is silently
discarded. This is inconsistent with visit_gotox_insn() which properly
returns its value.

Under memory pressure, the jt allocation fails silently, leaving
env->insn_aux_data[t].jt as NULL. Later, bpf_insn_successors() will
not return the expected successors for the tail call, and the stack
liveness fix this patch implements would not take effect.

Should this be something like:

    if (insn->imm == BPF_FUNC_tail_call) {
        ret = visit_tailcall_insn(env, t);
        if (ret < 0)
            return ret;
    }

> +		} else if (insn->src_reg == BPF_PSEUDO_KFUNC_CALL) {

[ ... ]


