Return-Path: <bpf+bounces-11745-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AC167BE760
	for <lists+bpf@lfdr.de>; Mon,  9 Oct 2023 19:09:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFA562816BC
	for <lists+bpf@lfdr.de>; Mon,  9 Oct 2023 17:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 799463589C;
	Mon,  9 Oct 2023 17:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="YXgYyEih";
	dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="YXgYyEih"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FAE61B264
	for <bpf@vger.kernel.org>; Mon,  9 Oct 2023 17:08:53 +0000 (UTC)
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFCC8AF
	for <bpf@vger.kernel.org>; Mon,  9 Oct 2023 10:08:50 -0700 (PDT)
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id AFE17C152565
	for <bpf@vger.kernel.org>; Mon,  9 Oct 2023 10:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1696871330; bh=/MhwGdX41O5MJTmGInwY2EMrELrfelc21lJUnZK1tXI=;
	h=Date:From:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe;
	b=YXgYyEihAhrQKyij3Q13X3lzBG5KSvwSBd6wOZDNZkP3K7YAuGO2Au4dZkW83p1q2
	 HoEIrkhlXFwUnOZ8sH2k283i4UQacjlEz9SQTde3CjhN9cDehdbfb2iFFF5afGezCs
	 zIumfA+dysFdS81xaA50T0B8xOEL8VESXrsqCO0c=
X-Mailbox-Line: From bpf-bounces@ietf.org  Mon Oct  9 10:08:50 2023
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 80A43C15106C;
	Mon,  9 Oct 2023 10:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1696871330; bh=/MhwGdX41O5MJTmGInwY2EMrELrfelc21lJUnZK1tXI=;
	h=Date:From:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe;
	b=YXgYyEihAhrQKyij3Q13X3lzBG5KSvwSBd6wOZDNZkP3K7YAuGO2Au4dZkW83p1q2
	 HoEIrkhlXFwUnOZ8sH2k283i4UQacjlEz9SQTde3CjhN9cDehdbfb2iFFF5afGezCs
	 zIumfA+dysFdS81xaA50T0B8xOEL8VESXrsqCO0c=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 17432C15106C;
 Mon,  9 Oct 2023 10:08:49 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Score: -1.41
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H4,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ipct9ZtYVnuz; Mon,  9 Oct 2023 10:08:46 -0700 (PDT)
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com
 [209.85.166.53])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id A2133C151069;
 Mon,  9 Oct 2023 10:08:46 -0700 (PDT)
Received: by mail-io1-f53.google.com with SMTP id
 ca18e2360f4ac-79f82b26abfso168495039f.1; 
 Mon, 09 Oct 2023 10:08:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696871325; x=1697476125;
 h=user-agent:content-disposition:mime-version:message-id:subject:cc
 :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EGb+785xebXAGj1rJCB3pBy7CwqpcQpO40LIbRVWbXc=;
 b=DhAdUvyxqL9WBZ1soQbYoZ5UQisUp73LrFdDk/peQoY5AWhFUK64sSXSXRLrJOndTm
 ZstKNniTa0cKVWZUM8xNIImouVWBPOpdW0hPxARahpzy6xpiJ4mD1pNFZx2J9CkZttVq
 7wo2npo2NQTY/6kleV+l7/MG6RHkxWq3ZNsC7dH4WQaHTkG+PoVaE8BM8ESDk66gcX+W
 +6+UeZbbzwty5NOF5OWM77iHCYfsQKHeqil5McVogb/L95Tm9qaYnOuNVNkzS0SDalAY
 15L9/AY5t0Pf3rq34Adr09vozqc+/glEsNUZNBtnORucC+EH9ntIsSyw76YzkFbGf01g
 N6JA==
X-Gm-Message-State: AOJu0YxawuNB66Q70WIqjZSuFY9+AC22J4aJs8pMKAMb1F8o4dOXEgF/
 0ZwLOIXyO4j39WpSS7k1uo9r3gJDlGfHvw==
X-Google-Smtp-Source: AGHT+IHiG3iQIbRu0NB899WEytwYGnM2zX0WunkkCLy4FUjqay4VAEBaeSRbsYMjZwwFcBNHzje6ug==
X-Received: by 2002:a05:6602:3351:b0:795:16b8:8601 with SMTP id
 c17-20020a056602335100b0079516b88601mr17266491ioz.0.1696871325630; 
 Mon, 09 Oct 2023 10:08:45 -0700 (PDT)
Received: from maniforge (c-24-1-27-177.hsd1.il.comcast.net. [24.1.27.177])
 by smtp.gmail.com with ESMTPSA id
 s15-20020a056602010f00b0079fd98bbe9bsm2496643iot.15.2023.10.09.10.08.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Oct 2023 10:08:45 -0700 (PDT)
Date: Mon, 9 Oct 2023 12:08:43 -0500
From: David Vernet <void@manifault.com>
To: bpf@ietf.org
Cc: bpf@vger.kernel.org, bpf-chairs@ietf.org, Erik Kline <ek.ietf@gmail.com>,
 Suresh Krishnan <suresh.krishnan@gmail.com>
Message-ID: <20231009170843.GA236066@maniforge>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/2.2.10 (2023-03-25)
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/mCB_CMpQq0uv6BoKSYARhbMeYI0>
Subject: [Bpf] IETF 118 Call for Agenda Items
X-BeenThere: bpf@ietf.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: Discussion of BPF/eBPF standardization efforts within the IETF
 <bpf.ietf.org>
List-Unsubscribe: <https://www.ietf.org/mailman/options/bpf>,
 <mailto:bpf-request@ietf.org?subject=unsubscribe>
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf/>
List-Post: <mailto:bpf@ietf.org>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
List-Subscribe: <https://www.ietf.org/mailman/listinfo/bpf>,
 <mailto:bpf-request@ietf.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: bpf-bounces@ietf.org
Sender: "Bpf" <bpf-bounces@ietf.org>
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

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

