Return-Path: <bpf+bounces-8755-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17B28789874
	for <lists+bpf@lfdr.de>; Sat, 26 Aug 2023 19:39:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4981C1C20934
	for <lists+bpf@lfdr.de>; Sat, 26 Aug 2023 17:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1085100AB;
	Sat, 26 Aug 2023 17:39:42 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB2F2C9C
	for <bpf@vger.kernel.org>; Sat, 26 Aug 2023 17:39:42 +0000 (UTC)
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 162BB10F
	for <bpf@vger.kernel.org>; Sat, 26 Aug 2023 10:39:41 -0700 (PDT)
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id DCDB7C1522BD
	for <bpf@vger.kernel.org>; Sat, 26 Aug 2023 10:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1693071580; bh=YpYp84pb3idEHAuC2rWmkQEwiuNo1KFnd00al5qzf14=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=yml4HklbBNWGtu2uD37o8+l8Ygn2sGyMo4DsxRdAsiFev/2WOJS0YLNJmgGlps7Gb
	 HVrfdXsGIFtW4ZP2DiwaMAbTXotRyMXrC4JHyKkFO4IK6w6SdaIvPNtROiqV2QRKKR
	 3kCiXHadMtw7pU7XqkIY2dEuRUt4a66CapBb/fhI=
X-Mailbox-Line: From bpf-bounces@ietf.org  Sat Aug 26 10:39:40 2023
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id A3051C15108F;
	Sat, 26 Aug 2023 10:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1693071580; bh=YpYp84pb3idEHAuC2rWmkQEwiuNo1KFnd00al5qzf14=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=yml4HklbBNWGtu2uD37o8+l8Ygn2sGyMo4DsxRdAsiFev/2WOJS0YLNJmgGlps7Gb
	 HVrfdXsGIFtW4ZP2DiwaMAbTXotRyMXrC4JHyKkFO4IK6w6SdaIvPNtROiqV2QRKKR
	 3kCiXHadMtw7pU7XqkIY2dEuRUt4a66CapBb/fhI=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 7A84FC15108B
 for <bpf@ietfa.amsl.com>; Sat, 26 Aug 2023 10:39:39 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Score: -6.41
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5RraB_6ir9xx for <bpf@ietfa.amsl.com>;
 Sat, 26 Aug 2023 10:39:34 -0700 (PDT)
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com
 [209.85.219.173])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 054FCC15108F
 for <bpf@ietf.org>; Sat, 26 Aug 2023 10:39:34 -0700 (PDT)
Received: by mail-yb1-f173.google.com with SMTP id
 3f1490d57ef6-d7830c5b20aso2382236276.0
 for <bpf@ietf.org>; Sat, 26 Aug 2023 10:39:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693071573; x=1693676373;
 h=user-agent:in-reply-to:content-disposition:mime-version:references
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zoVLQm1UJdsQtNNpzj835FQjSyWC6l8TRBCUApOxE4U=;
 b=ATj1laM2ed+dh3x/Xo4UKyLxuMSyv+Nna3Kv3brCiFgTpX5hKhFfR1IEdTJTEX++R1
 4yboD4Okq+zegCaM1E+idX4ztCD3a3C97l9bc9LOSvtEhtr5h+Lp5MXMcFb+ACGq6OiD
 zm0WYnI3L4XWzU7/fGODUlGtddej9VtfNuz1HT+mLTApPJp4OKWYJ0egtNTkRk0Sg/Jx
 64R2uVw52t3m6Cyy8ygksJVKGHWo211+MQj2UXZdGB9iIWbHKxQLE3c9nHNxHz9YC8Cr
 4tOlVNuzkXRZX4Zx1mqj2hGPrIB5zEas7AcY8rl5gFcA4JzIqR38EnTzRn51IWAL7Mli
 GNGg==
X-Gm-Message-State: AOJu0YzCo6ZGboTr+IhmfzOaTxHs4x4EMnIudqOSjs9Y1x/Xs2x7yiX1
 AxgNjjU8criBNEHEVPc7U0M=
X-Google-Smtp-Source: AGHT+IGc/IVaa4zebs+5I9V0yixhkJ56QAQol/8vCJDD5uqQDBCtkAVl/RKMqkCA6cy7MpaD+9vQIg==
X-Received: by 2002:a25:d38e:0:b0:d4a:499d:a881 with SMTP id
 e136-20020a25d38e000000b00d4a499da881mr20660791ybf.9.1693071572961; 
 Sat, 26 Aug 2023 10:39:32 -0700 (PDT)
Received: from maniforge ([24.1.27.177]) by smtp.gmail.com with ESMTPSA id
 a22-20020a25ae16000000b00d687cf69599sm917896ybj.52.2023.08.26.10.39.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Aug 2023 10:39:32 -0700 (PDT)
Date: Sat, 26 Aug 2023 12:39:30 -0500
From: David Vernet <void@manifault.com>
To: Will Hawkins <hawkinsw@obs.cr>
Cc: bpf@vger.kernel.org, bpf@ietf.org
Message-ID: <20230826173930.GB100673@maniforge>
References: <20230826053258.1860167-1-hawkinsw@obs.cr>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230826053258.1860167-1-hawkinsw@obs.cr>
User-Agent: Mutt/2.2.10 (2023-03-25)
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/V9-KOnCV7zexjwmO23Hhz10yLMc>
Subject: Re: [Bpf] [PATCH] bpf,
 docs: Correct source of offset for program-local call
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

On Sat, Aug 26, 2023 at 01:32:54AM -0400, Will Hawkins wrote:
> The offset to use when calculating the target of a program-local call is
> in the instruction's imm field, not its offset field.
> 
> Signed-off-by: Will Hawkins <hawkinsw@obs.cr>

LGTM, thanks for the fix.

Acked-by: David Vernet <void@manifault.com>

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

