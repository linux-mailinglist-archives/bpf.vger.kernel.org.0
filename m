Return-Path: <bpf+bounces-13213-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD7257D63A7
	for <lists+bpf@lfdr.de>; Wed, 25 Oct 2023 09:42:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0932E1C20E32
	for <lists+bpf@lfdr.de>; Wed, 25 Oct 2023 07:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7E981643A;
	Wed, 25 Oct 2023 07:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WWvHFqUT"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7211BDC8
	for <bpf@vger.kernel.org>; Wed, 25 Oct 2023 07:42:09 +0000 (UTC)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB80A526D
	for <bpf@vger.kernel.org>; Wed, 25 Oct 2023 00:41:00 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-32d9cb5e0fcso3738852f8f.0
        for <bpf@vger.kernel.org>; Wed, 25 Oct 2023 00:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698219655; x=1698824455; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=69I3s/9Uyb5eS2uNRw6CpHXyuNuJD6rrAzv0snc5CzI=;
        b=WWvHFqUT0Vmeu4izhNGUUBvQ60nJpHoRpfsDCZIikE+laYig3xQawzglEsKqYjWSYo
         Xow1v4wD4XGBEtjGcqf8xgNJNTaaY80qJ5nA1G9mwO5lb8LR38mHjlx2TjxaM6LzMnWf
         dmRrRKyujM3Da77Xhp+/KhKlr0FVXepevPGr8AONFsgjAgzHnpZ+YSnwKf/9bLBgwmr1
         5zGhVZxyumNCvB43xu11L9LIEmdAsHDC9T8my4yQH0olJJqqHLZ6miz5zr5w9RgvvCmd
         KUYIcZcYDjIr7asTk5SsFm0LKnHfCEhPL/IL7z0q/dknbc5Hm2Fpkf46a+cuyg8paG4m
         y0lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698219655; x=1698824455;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=69I3s/9Uyb5eS2uNRw6CpHXyuNuJD6rrAzv0snc5CzI=;
        b=xBa282ESps5bojBdcjL3jPnrHlVdzSN0DzhY0GgvjIAmNBztbWAKAFkgwPXiAnycV7
         ECDKKft9WF7Zt4T6ZDt1PGgQe43lQPBoE4D3rfzBRBBTCOPpPDxdKxKWkwdwY5vTLJyn
         22DTRoMT+orqIRTnmDs/R+jaFvq2uvlN/k0o8OPDSzHt6Mc9KSuQ0kkJ3lyXoHRyIw3W
         Xnewu93sod6aDZ/OyQguHuOvqXeHn878RI0DPOjom0QYSsZcZat8LYpkySfnnAO4L7bU
         EdiW/50lKuxCcspx7pRHpUNuVz6DJyqUVyMS9iYrPfamFbBdqeB+meAy9RUxmm/Esj9Y
         LdGA==
X-Gm-Message-State: AOJu0YzKU9GNiezTak9DpCujAoHJm5wbYzIelAXe8dR9RQIJN5pXmMQF
	vZ1lVJ1jBcapUfusMsKW3RQzAXCmJTUxnG2YjJk=
X-Google-Smtp-Source: AGHT+IE/BhV7weAPzU0QQHLWkVCMXpkPFKk2kXgzuDwZPBFc9i7R1kndzUbyqRjNnABA0N5Jmfvu+w==
X-Received: by 2002:a5d:5452:0:b0:32d:ad44:cec1 with SMTP id w18-20020a5d5452000000b0032dad44cec1mr9752078wrv.3.1698219655430;
        Wed, 25 Oct 2023 00:40:55 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id u3-20020a5d5143000000b003296b488961sm11463923wrt.31.2023.10.25.00.40.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 00:40:55 -0700 (PDT)
Date: Wed, 25 Oct 2023 10:40:49 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: yan@cloudflare.com
Cc: bpf@vger.kernel.org
Subject: [bug report] lwt: Fix return values of BPF xmit ops
Message-ID: <cd258298-8d8c-453a-bf21-9859b873d379@moroto.mountain>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Yan Zhai,

The patch 29b22badb7a8: "lwt: Fix return values of BPF xmit ops" from
Aug 17, 2023 (linux-next), leads to the following Smatch static
checker warning:

	net/core/lwt_bpf.c:131 bpf_input()
	error: double free of 'skb'

net/core/lwt_bpf.c
    38  static int run_lwt_bpf(struct sk_buff *skb, struct bpf_lwt_prog *lwt,
    39                         struct dst_entry *dst, bool can_redirect)
    40  {
    41          int ret;
    42  
    43          /* Migration disable and BH disable are needed to protect per-cpu
    44           * redirect_info between BPF prog and skb_do_redirect().
    45           */
    46          migrate_disable();
    47          local_bh_disable();
    48          bpf_compute_data_pointers(skb);
    49          ret = bpf_prog_run_save_cb(lwt->prog, skb);
    50  
    51          switch (ret) {
    52          case BPF_OK:
    53          case BPF_LWT_REROUTE:
    54                  break;
    55  
    56          case BPF_REDIRECT:
    57                  if (unlikely(!can_redirect)) {
    58                          pr_warn_once("Illegal redirect return code in prog %s\n",
    59                                       lwt->name ? : "<unknown>");
    60                          ret = BPF_OK;
    61                  } else {
    62                          skb_reset_mac_header(skb);
    63                          skb_do_redirect(skb);
    64                          ret = BPF_REDIRECT;

If skb_do_redirect() returns -EINVAL it means the skb has been freed.
Originally we preserved error code but now we just return BPF_REDIRECT.

    65                  }
    66                  break;
    67  
    68          case BPF_DROP:
    69                  kfree_skb(skb);
    70                  ret = -EPERM;
    71                  break;

regards,
dan carpenter

