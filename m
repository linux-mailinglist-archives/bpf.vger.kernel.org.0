Return-Path: <bpf+bounces-11744-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 343517BE75F
	for <lists+bpf@lfdr.de>; Mon,  9 Oct 2023 19:08:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C228281983
	for <lists+bpf@lfdr.de>; Mon,  9 Oct 2023 17:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 198CC35894;
	Mon,  9 Oct 2023 17:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3108D1B264
	for <bpf@vger.kernel.org>; Mon,  9 Oct 2023 17:08:47 +0000 (UTC)
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CADB9D
	for <bpf@vger.kernel.org>; Mon,  9 Oct 2023 10:08:46 -0700 (PDT)
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-79fa2125e19so169025039f.0
        for <bpf@vger.kernel.org>; Mon, 09 Oct 2023 10:08:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696871325; x=1697476125;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EGb+785xebXAGj1rJCB3pBy7CwqpcQpO40LIbRVWbXc=;
        b=gzCOz/LWURcR0NGET+q+G2HX84q8DlptD4iRAe9NNrSqIkN+JsY248E7P1xpB6nKMA
         zyDIPECuKZYCV5yJrln0yzBQi6VqxHUAOLUXpudxW8ibxWMH57WjBmkO9aePxv57Yt/d
         aVsBhrZWDBDjU/stL46lUmZ9MC3dRtBOhSu+Awm0/bp6Y0LanxfqzaJZGqTSni+kG13/
         sBQbtoWv3iIGgwEsSPKTMfB0MnqVWUQy3tLefWW06AeW+Q0wsTzbQBBHLCWe4FD34LI3
         aP46nNm3I5reCbxkTpAkiyvxvkb1BtRMEPOsYxnucA94l3B0xFtvwfo9r83oZf7YBuZR
         OTVQ==
X-Gm-Message-State: AOJu0Yz3iHG3Y+2K/fuCbIDnRCpRcqf2Pem8K/btqDU68GXYCrWRkTa1
	0O67JBCrX5PIlPdMGzinqlU=
X-Google-Smtp-Source: AGHT+IHiG3iQIbRu0NB899WEytwYGnM2zX0WunkkCLy4FUjqay4VAEBaeSRbsYMjZwwFcBNHzje6ug==
X-Received: by 2002:a05:6602:3351:b0:795:16b8:8601 with SMTP id c17-20020a056602335100b0079516b88601mr17266491ioz.0.1696871325630;
        Mon, 09 Oct 2023 10:08:45 -0700 (PDT)
Received: from maniforge (c-24-1-27-177.hsd1.il.comcast.net. [24.1.27.177])
        by smtp.gmail.com with ESMTPSA id s15-20020a056602010f00b0079fd98bbe9bsm2496643iot.15.2023.10.09.10.08.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 10:08:45 -0700 (PDT)
Date: Mon, 9 Oct 2023 12:08:43 -0500
From: David Vernet <void@manifault.com>
To: bpf@ietf.org
Cc: bpf@vger.kernel.org, bpf-chairs@ietf.org,
	Erik Kline <ek.ietf@gmail.com>,
	Suresh Krishnan <suresh.krishnan@gmail.com>
Subject: IETF 118 Call for Agenda Items
Message-ID: <20231009170843.GA236066@maniforge>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	PDS_BRAND_SUBJ_NAKED_TO,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello, 

The BPF working group will be holding a meeting at IETF 118 in a two
hour time slot. The chairs are in the process of setting the agenda. We
would like to solicit agenda items that would be of interest to the WG
participants with a preference to the items that address the topics of
interest covered by the charter. Please send us your request(s) for
slots to bpf-chairs@ietf.org, detailing:

* Topic and presenter info
* Name of associated draft (if any)
* Requested slot duration

Thanks
Suresh and David

