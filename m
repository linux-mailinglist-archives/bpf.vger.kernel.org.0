Return-Path: <bpf+bounces-744-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C125F7063B3
	for <lists+bpf@lfdr.de>; Wed, 17 May 2023 11:13:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 446C228156C
	for <lists+bpf@lfdr.de>; Wed, 17 May 2023 09:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B0BB10947;
	Wed, 17 May 2023 09:13:25 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7865249
	for <bpf@vger.kernel.org>; Wed, 17 May 2023 09:13:24 +0000 (UTC)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ABBAA0
	for <bpf@vger.kernel.org>; Wed, 17 May 2023 02:13:23 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-965e4be7541so82394266b.1
        for <bpf@vger.kernel.org>; Wed, 17 May 2023 02:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google; t=1684314802; x=1686906802;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=r5soTWJHvW5+wBizFEvQSRVEKRNcOFlqCOP7EePfwnA=;
        b=PWzhZ4LT5KlZRZ84pKHYBuoDiuN0tRcixoiRwCvdy3EzCVDlXB1gHwEgvWr2gtXTDq
         zRKq27MhwgS0p2PweaeCZuo+gVzKGv2nTkR0NSEz+zBSxwKbN+9EfxeW5j8L5lwdw6BO
         F+Z6v6jeTWf1VCfcaIm6OmpDTv5RueWQbekvw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684314802; x=1686906802;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r5soTWJHvW5+wBizFEvQSRVEKRNcOFlqCOP7EePfwnA=;
        b=Gpw40QF19/+HBrq7YEdF9v1ix1NV6vn/H06hGoc8DiH5JqvpF2x6vFKLOn6pV8aMtQ
         +Nnp+OScw+602tN6mfkDInWGnQxhhX69Uzx98miBCOpyY93bROJqCTmpXEqzBlvB5fQO
         ow+yVoRBMAHVFkCatpFMuD+DANFY3T08Tz8U7EF9IlsNHNHSWf9Ofad9EffpWtQYW19F
         vKQpY8jQNCwCpGYg9Fyr/2vtcVgUVN95r8cYhjQxU3hOXET5zALGZRBD414/1lwUVQuX
         XmOEiNtu4PZ9iUmy5RLxUMBcPMjLqtFURwNVdP+feRPX4qhJnmMIiRjnGXBl8UGZ/jyk
         H7vA==
X-Gm-Message-State: AC+VfDz/DYdnUH+l5gHvvRKdMuIAtEVYJqqMh7RqjxBgCPSzbeGdoowD
	gV1TFxiTd83FJ4HJZBXtv1zpww==
X-Google-Smtp-Source: ACHHUZ7/PgQ55Jqj4aXQiAuca+4GQuHkmY9OPyYJ7fEba6tcES6eKuHQB6viQ8IgIXMSMXLe8ek7yA==
X-Received: by 2002:a17:906:794e:b0:968:2bb1:f392 with SMTP id l14-20020a170906794e00b009682bb1f392mr31036760ejo.27.1684314801998;
        Wed, 17 May 2023 02:13:21 -0700 (PDT)
Received: from cloudflare.com ([82.163.205.2])
        by smtp.gmail.com with ESMTPSA id v9-20020a170906380900b0094e1344ddfdsm11910166ejc.34.2023.05.17.02.13.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 02:13:21 -0700 (PDT)
References: <20230517052244.294755-1-john.fastabend@gmail.com>
 <20230517052244.294755-4-john.fastabend@gmail.com>
User-agent: mu4e 1.6.10; emacs 28.2
From: Jakub Sitnicki <jakub@cloudflare.com>
To: John Fastabend <john.fastabend@gmail.com>
Cc: daniel@iogearbox.net, bpf@vger.kernel.org, netdev@vger.kernel.org,
 edumazet@google.com, ast@kernel.org, andrii@kernel.org, will@isovalent.com
Subject: Re: [PATCH bpf v8 03/13] bpf: sockmap, reschedule is now done
 through backlog
Date: Wed, 17 May 2023 11:12:48 +0200
In-reply-to: <20230517052244.294755-4-john.fastabend@gmail.com>
Message-ID: <87r0rf8gnj.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, May 16, 2023 at 10:22 PM -07, John Fastabend wrote:
> Now that the backlog manages the reschedule() logic correctly we can drop
> the partial fix to reschedule from recvmsg hook.
>
> Rescheduling on recvmsg hook was added to address a corner case where we
> still had data in the backlog state but had nothing to kick it and
> reschedule the backlog worker to run and finish copying data out of the
> state. This had a couple limitations, first it required user space to
> kick it introducing an unnecessary EBUSY and retry. Second it only
> handled the ingress case and egress redirects would still be hung.
>
> With the correct fix, pushing the reschedule logic down to where the
> enomem error occurs we can drop this fix.
>
> Reviewed-by: Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>

Something went wrong here.

> Fixes: bec217197b412 ("skmsg: Schedule psock work if the cached skb exists on the psock")
> Signed-off-by: John Fastabend <john.fastabend@gmail.com>
> ---

[...]

