Return-Path: <bpf+bounces-12293-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0F127CAAB3
	for <lists+bpf@lfdr.de>; Mon, 16 Oct 2023 16:01:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A952028114C
	for <lists+bpf@lfdr.de>; Mon, 16 Oct 2023 14:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8023D28DA1;
	Mon, 16 Oct 2023 14:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gPCIVaCi"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922A9286A7
	for <bpf@vger.kernel.org>; Mon, 16 Oct 2023 14:01:29 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA343103
	for <bpf@vger.kernel.org>; Mon, 16 Oct 2023 07:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697464886;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uap3XnM9Lhyb19jxlmHwFpG/UglaDemto96MtQ/jYiA=;
	b=gPCIVaCiz9L76zMf7P2hi1hwY0TU7HaC9cNZ9yzr90HFLR8jvDXauvHhguubf7LWbWuSBP
	zakIF0UcS/R2AlUBOXFsfu4FFSy3iamKhoffgPbWt3RoKzp6fak53Yqp4SafRd03ThVBRN
	AAxi8K+6e9R4vSDwKDAFd5OujJxcpnc=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659--Yj9LtfqMVKx7V81mg1QlA-1; Mon, 16 Oct 2023 10:01:23 -0400
X-MC-Unique: -Yj9LtfqMVKx7V81mg1QlA-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4180b3a5119so52436451cf.1
        for <bpf@vger.kernel.org>; Mon, 16 Oct 2023 07:01:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697464879; x=1698069679;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uap3XnM9Lhyb19jxlmHwFpG/UglaDemto96MtQ/jYiA=;
        b=rrUOMYNjqJONG5/B4Pvwog0zsLP8b09uPRXlzMZQuAW/4zyNd/md6BMxTkdzhNkipT
         scDDjBJSyDCoEDtPxEFNe5K5uVjRL9etRdbdAAKxYFkcQPq20mNiSZ8NyDw7pLQx1yaG
         6I7WeoYj4qenR8sMorgOGhROROG+MfOFJgtAjDKqBFUEXvIG2+TYheAv9fKSO406bYvi
         pCE5FuuOlW5kGqTYqv0KRNbRy+vzdn3ToxTAcfy4NEzjWDZ8Yytkw1RmcFJXs6lIKsUr
         rDq1FR+TqFkYL8eN+wucLhz8sEpAoBZ6BNDP4qzsvdzUSKfx6k8RKPI8EcUXySWYbQU5
         vmMQ==
X-Gm-Message-State: AOJu0YyI/ILypZ5OKubYoWkrTBn+MOYZefKzN0vvde/9QeDwqbPv1EA1
	IGbZwsdpIkVUcpEXKwlTyLyc3DU8rteegwjxfDaieq+OcTzapQWc8p4frMkg/v2IG3VB3N+yd3j
	KtjxktpgE0YRe
X-Received: by 2002:ac8:7e96:0:b0:405:37fd:be80 with SMTP id w22-20020ac87e96000000b0040537fdbe80mr45482915qtj.28.1697464879402;
        Mon, 16 Oct 2023 07:01:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEb10pK3UlPBDVZPZEa2itrsXkwXP+tUxZRGEufquB0c7etO9xrmo88reJKOBREiXqFQEH5lA==
X-Received: by 2002:ac8:7e96:0:b0:405:37fd:be80 with SMTP id w22-20020ac87e96000000b0040537fdbe80mr45482872qtj.28.1697464878959;
        Mon, 16 Oct 2023 07:01:18 -0700 (PDT)
Received: from localhost ([81.56.90.2])
        by smtp.gmail.com with ESMTPSA id l18-20020ac84592000000b0041b0b869511sm3036221qtn.65.2023.10.16.07.01.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 07:01:18 -0700 (PDT)
Date: Mon, 16 Oct 2023 16:01:15 +0200
From: Davide Caratti <dcaratti@redhat.com>
To: Victor Nogueira <victor@mojatatu.com>
Cc: jhs@mojatatu.com, daniel@iogearbox.net, xiyou.wangcong@gmail.com,
	jiri@resnulli.us, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, paulb@nvidia.com,
	bpf@vger.kernel.org, mleitner@redhat.com, martin.lau@linux.dev,
	netdev@vger.kernel.org, kernel@mojatatu.com
Subject: Re: [PATCH RFC net-next v2 1/1] net: sched: Disambiguate verdict
 from return code
Message-ID: <ZS1CK76Dkyoz6nZo@dcaratti.users.ipa.redhat.com>
References: <20231014180921.833820-1-victor@mojatatu.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231014180921.833820-1-victor@mojatatu.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

hello Victor, thanks for the patch!

On Sat, Oct 14, 2023 at 03:09:21PM -0300, Victor Nogueira wrote:
> Currently there is no way to distinguish between an error and a
> classification verdict. Which has caused us a lot of pain with buggy qdiscs
> and syzkaller. This patch does 2 things - one is it disambiguates between
> an error and policy decisions. The reasons are added under the auspices of
> skb drop reason. We add the drop reason as a part of struct tcf_result.
> That way, tcf_classify can set a proper drop reason when it fails,
> and we keep the classification result as the tcf_classify's return value.
> 
> This patch also adds a variety of drop reasons which are more fine grained
> on why a packet was dropped by the TC classification action subsystem.
> 
> Co-developed-by: Daniel Borkmann <daniel@iogearbox.net>
> Signed-off-by: Victor Nogueira <victor@mojatatu.com>
> ---
> 
> v1 -> v2:
> - Make tcf_classify set drop reason instead of verdict in struct
>   tcf_result
> - Make tcf_classify return verdict (as it was doing before)
> - Only initialise struct tcf_result in tc_run
> - Add new drop reasons specific to TC
> - Merged v1 patch with Daniel's patch (https://lore.kernel.org/bpf/20231013141722.21165ef3@kernel.org/T/)
>   for completeness

Acked-by: Davide Caratti <dcaratti@redhat.com>

By the way, this might be a chance to remove the "TC mirred to Houston"
printout and replace it with a proper drop reason (see [1]). WDYT?

thanks,
-- 
davide

[1] https://lore.kernel.org/netdev/Yt2CIl7iCoahCPoU@pop-os.localdomain/


