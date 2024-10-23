Return-Path: <bpf+bounces-42876-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A950A9AC1ED
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 10:40:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 405B8283666
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 08:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1681A15B546;
	Wed, 23 Oct 2024 08:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zSjpektF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6E315855E
	for <bpf@vger.kernel.org>; Wed, 23 Oct 2024 08:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729672844; cv=none; b=mGt2zyq2mq4DVm9d7tHct0c4CHPO02H4FWeKQg78AElY6o2TjWhbC+3V50EPY5UTFrOEJrm/+3ZfvwEOwzXLRJK1s3IjvZ+DHcNPiWRKKmvL8yFQj2zKZIHOnr5pWxCXdbml1RAr84X5XRwKUyNiNShZ22mWnfcVPiVrWDGrln0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729672844; c=relaxed/simple;
	bh=+NBZv7oArYvfP5akwMVnUHhHf/uifOLNs2ODyGtkYOY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=mwhailbDaJk7t6PDd1/gjDQUD8qg7QarV9KPXHWj7tqq8abqzlGVuH0UsWhIzLMQD/k3PRftK0m9Jgjal0PTuzCK7zz6rE4JJdNdr3kIk/LxITMMGsNozSiBmoqGCPIU+e9PlI5MzFlYACxNxX/iGK+RKTpqbdxa7dCVLgVjwWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zSjpektF; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-37ed3bd6114so3302886f8f.2
        for <bpf@vger.kernel.org>; Wed, 23 Oct 2024 01:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729672841; x=1730277641; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UwBVnyfeiaaFwe1BwX5fHUUsKIgAZFOm4eIVuwMh+lk=;
        b=zSjpektFbom8c6OqePsAY1ymRl7DL4MVvU66dMnwL7au4lZR1+kwJuu7o5idolduQh
         HHlM7PQyGAfbDPshqdDZnhZBRjNlBqXbvVsQnDWphYL57uWajFRqnfZe1c5rcviXXe27
         EfRq9pZwjdJOdaEPY0ZiF/8pyC+H/svieU4LPkAVre/aL0ZX6wTfaqJzqukEsgJESlW5
         ftU0r5YxkIg1cCP3rHTaV1Zb+r/vy3sHp/Mz8oZ5LxeNk+y1MEmBmhc5dwk0Ws211wSE
         S7ztqKdzjrPM0zTw6bBaEReBGEYuT6pdsSXDF5m5WQpRv857Vr2Cp4g452+2xPGZwejr
         SaMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729672841; x=1730277641;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UwBVnyfeiaaFwe1BwX5fHUUsKIgAZFOm4eIVuwMh+lk=;
        b=vIwwiqEUPQ+2Biy3ip1h6NxNmPXsxcOHQvvU+lxrQnIlwfTIy+9Xxigex6yNwUwyLb
         PYBNtjFCLWtWfbMybXuMIpW8zACt4S5YdDjKPWL2VvzV2LB4c7qpIVtHlkroqtYR7rPg
         E1UgYAp9cuofLns1gErC76aVYcTgmnrweBExrFYyYztIQs2Iw1woYn03JtkPHLoWnyZg
         CoCels8WgS8Z9bhjDY7sdbeEsDAq7M5/zpCOEaoxEncROR8ERu6xKzIRYU8+L4TmWDDR
         vGYEuzfXJvRMMJyf7TlLGj3VdKy/R3MQge9mr/mIQVU3k8ITMJS5QbgQWza1tivCGqr3
         Odxg==
X-Gm-Message-State: AOJu0Yyot1UJPDeIvBMz7huXUcxzDZMjSyDk2Jtq0i67Wc9LhTbE48Bx
	9R7xd2f7/3ZPTku/CC3AZ7UPRC0xyxzHVCuS3UKhfMLkFyeLn+5yiyMWtbxEXDrQkhHBj7h0KGi
	XtlE=
X-Google-Smtp-Source: AGHT+IG9zyOlYDl6aslBNmlZNofhKFfuhQeZOkzvtZncjPR5I+abQPRItI1NddONt9ss+apPtkyQFA==
X-Received: by 2002:a5d:46d0:0:b0:37d:498a:a233 with SMTP id ffacd0b85a97d-37efcf76ae3mr1008481f8f.43.1729672841265;
        Wed, 23 Oct 2024 01:40:41 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0b94048sm8369399f8f.85.2024.10.23.01.40.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 01:40:40 -0700 (PDT)
Date: Wed, 23 Oct 2024 11:40:37 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Alexei Starovoitov <ast@kernel.org>
Cc: bpf@vger.kernel.org
Subject: [bug report] samples/bpf: bpf_tail_call example for networking
Message-ID: <b2a48b45-144a-428c-9ab3-79bedbbad9d9@stanley.mountain>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Alexei Starovoitov,

Commit 530b2c8619f2 ("samples/bpf: bpf_tail_call example for
networking") from May 19, 2015 (linux-next), leads to the following
Smatch static checker warning:

	samples/bpf/sockex3_kern.c:240 bpf_func_mpls()
	warn: masked condition '(verlen & 240) == 4' is always false.

./samples/bpf/sockex3_kern.c
    227 SEC("socket")
    228 int bpf_func_mpls(struct __sk_buff *skb)
    229 {
    230         __u32 nhoff, label;
    231 
    232         nhoff = skb->cb[0];
    233 
    234         label = load_word(skb, nhoff);
    235         nhoff += sizeof(struct mpls_label);
    236         skb->cb[0] = nhoff;
    237 
    238         if (label & MPLS_LS_S_MASK) {
    239                 __u8 verlen = load_byte(skb, nhoff);
--> 240                 if ((verlen & 0xF0) == 4)
                            ^^^^^^^^^^^^^^^^^^^^
This can't be true.  Was it supposed to be 0x0F or 0x40?

    241                         parse_eth_proto(skb, ETH_P_IP);
    242                 else
    243                         parse_eth_proto(skb, ETH_P_IPV6);
    244         } else {
    245                 parse_eth_proto(skb, ETH_P_MPLS_UC);
    246         }
    247 
    248         return 0;
    249 }

regards,
dan carpenter

