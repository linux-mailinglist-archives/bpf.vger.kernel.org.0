Return-Path: <bpf+bounces-7179-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 57DB37729FC
	for <lists+bpf@lfdr.de>; Mon,  7 Aug 2023 18:00:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 630F51C20C01
	for <lists+bpf@lfdr.de>; Mon,  7 Aug 2023 16:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76B6511C8D;
	Mon,  7 Aug 2023 16:00:12 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B867111B7
	for <bpf@vger.kernel.org>; Mon,  7 Aug 2023 16:00:12 +0000 (UTC)
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E544E74
	for <bpf@vger.kernel.org>; Mon,  7 Aug 2023 09:00:10 -0700 (PDT)
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 21EC7C13AE33
	for <bpf@vger.kernel.org>; Mon,  7 Aug 2023 09:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1691424010; bh=wI2+qty/qzMk196WGTmzN87PHakNIASdMMYk4kQmiLY=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=lVQTxygaBqqL8h3dr7rueJ2RdmG3xzxxEAu9U5m4l2rcOgMsKyIjcm959dzHGEZEP
	 vW4vnl7yVlvEltBJhfK0T5vKli1Ch+RpOHII6F4pWbnMGhQaqWLr60PRQd146fK2pB
	 82Z+qOAh0/uTRILR8wehmGqp3mr5kDfIT2Pu/7xQ=
X-Mailbox-Line: From bpf-bounces@ietf.org  Mon Aug  7 09:00:10 2023
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id ED2C3C13AE2C;
	Mon,  7 Aug 2023 09:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1691424010; bh=wI2+qty/qzMk196WGTmzN87PHakNIASdMMYk4kQmiLY=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=lVQTxygaBqqL8h3dr7rueJ2RdmG3xzxxEAu9U5m4l2rcOgMsKyIjcm959dzHGEZEP
	 vW4vnl7yVlvEltBJhfK0T5vKli1Ch+RpOHII6F4pWbnMGhQaqWLr60PRQd146fK2pB
	 82Z+qOAh0/uTRILR8wehmGqp3mr5kDfIT2Pu/7xQ=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 0ED0CC13AE2A
 for <bpf@ietfa.amsl.com>; Mon,  7 Aug 2023 09:00:09 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Score: -1.41
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aI6MQH2RlIwK for <bpf@ietfa.amsl.com>;
 Mon,  7 Aug 2023 09:00:07 -0700 (PDT)
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com
 [209.85.219.50])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id C7C9CC13AE28
 for <bpf@ietf.org>; Mon,  7 Aug 2023 09:00:07 -0700 (PDT)
Received: by mail-qv1-f50.google.com with SMTP id
 6a1803df08f44-63cef62a944so30399336d6.1
 for <bpf@ietf.org>; Mon, 07 Aug 2023 09:00:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691424007; x=1692028807;
 h=user-agent:in-reply-to:content-disposition:mime-version:references
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qJ22WYEke/+FRZ158MaUEXhW/xNAw3oVqqtmb4BpNvA=;
 b=XnMY1QOWpsiVJXOI/gt89+98fBTtnx3dh1h+ICD3TDFFxR00IFS3EEDkc4fhl8XMJk
 bucurRd1t/aN0ySKFjV62JNAUE6DmqrtoXhDQ6j4l3E+odKOiVPcB0/to0FGFKh1dBYz
 By7UFcah1VKRrDYNRDZ+jxPKaRs6Roijc7xDfsbfM+1y9BhRKxrmuGpHC/7+Z1NvS4Vq
 +C2Jw7rKmItgIuptAkY4pnv2DPEY8/CZnyQesNk8W4GMA9B1kYZPJ2Srtc8M0rxlmwY+
 Rtsq2dhk1FIbFLBEEWDIod6LFOxbk8fvU3oMLuykPFKo35hX/nJzE58ssC39I9osEsGc
 WF9g==
X-Gm-Message-State: AOJu0YyVOgRNmyKM2BjH7FX74oyGoa7DGDVyBpiRX/GJ8/e1/7GpgPxG
 k6Q/NspUKqaUTtkHcdWVWgg=
X-Google-Smtp-Source: AGHT+IHWgoyQ5LC4MBSkCi8h/A2dHM1byvT5+zUYwwDynrZKnoQB8VuvJnappg4TYS6DXhTPOrN9pQ==
X-Received: by 2002:a0c:fa8a:0:b0:63d:b75:c971 with SMTP id
 o10-20020a0cfa8a000000b0063d0b75c971mr10146029qvn.15.1691424006682; 
 Mon, 07 Aug 2023 09:00:06 -0700 (PDT)
Received: from maniforge ([2620:10d:c091:400::5:1777])
 by smtp.gmail.com with ESMTPSA id
 o16-20020a0cf4d0000000b0063d385c28edsm2977607qvm.41.2023.08.07.09.00.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Aug 2023 09:00:06 -0700 (PDT)
Date: Mon, 7 Aug 2023 11:00:04 -0500
From: David Vernet <void@manifault.com>
To: Will Hawkins <hawkinsw@obs.cr>
Cc: bpf@vger.kernel.org, bpf@ietf.org
Message-ID: <20230807160004.GA10339@maniforge>
References: <20230807140651.122484-1-hawkinsw@obs.cr>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230807140651.122484-1-hawkinsw@obs.cr>
User-Agent: Mutt/2.2.10 (2023-03-25)
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/uWTeeRsA3ho-N7i_rYyxncCSWbc>
Subject: Re: [Bpf] [PATCH v4 1/1] bpf,
 docs: Formalize type notation and function semantics in ISA standard
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

On Mon, Aug 07, 2023 at 10:06:48AM -0400, Will Hawkins wrote:
> Give a single place where the shorthand for types are defined and the
> semantics of helper functions are described.
> 
> Signed-off-by: Will Hawkins <hawkinsw@obs.cr>

Looks great, thanks Will!

Acked-by: David Vernet <void@manifault.com>

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

